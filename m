Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6217B43E04F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 13:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhJ1L51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 07:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhJ1L5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 07:57:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D73C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Mime-Version
        :Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=y8rl0XIlF2Cpg8lJtO567Qjj0qqLoriC6dnteEPeF9s=; b=WjK2ObiNkKVftdaJyUhHA0jBWj
        AFrpKFfQvlcu72O6hVoFALLaLErdeUgVt0n9phDkP9cjCpT8KsKROoUHUCJpVlnx8mv2F8nHtFSgp
        Ys/zs6zku8gMnswZYanFDlcdP22+f2WoIrVKDS+pi4tJVsJymp0rYkGq5ZgXYfeRV+984n8AVJwX4
        onuGhNUrRFCPhLulfQ0JTHEIucYbeINXhDiRGNATgvYfrPcIX/fY/2y5Lo++h3T/cj6JzhTrRbwnS
        1wfisF5sVQB3a4VAJAK5fgNPAOuDKn84HLTgC4dRMrs4GlGgkQbyeS2w3dkWvnGHq6iaWfc+dsptH
        9FGsg2Fw==;
Received: from [54.239.6.185] (helo=freeip.amazon.com)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg3ze-00CkpU-7b; Thu, 28 Oct 2021 11:54:50 +0000
Message-ID: <dcd5178f3706fd57352f171bb20535ed052d26fe.camel@infradead.org>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=3A?= drivers/char: suspected
 null-pointer dereference problem in handle_control_message
From:   Amit Shah <amit@infradead.org>
To:     YE Chengfeng <cyeaa@connect.ust.hk>,
        "amit@kernel.org" <amit@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 28 Oct 2021 13:54:49 +0200
In-Reply-To: <TYCP286MB11885C2C4C12BFBB42F0D9CE8A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB11884B1010AF8C77F1BBDAF08A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
         <a61be974ef65d00fd22b0216fc0d85c0c226f5e9.camel@infradead.org>
         <TYCP286MB11885C2C4C12BFBB42F0D9CE8A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-26 at 11:51 +0000, YE Chengfeng wrote:
> Thanks for your reply.
> 
> Agree with you, seems that the branch at #line 1573 already handles this situation.
> 
> Another question, is it possible that port->name is null when show_port_name is invoked? I don't see any null-check there, could it be a null-dereference problem at #line 1282? Link is below.
> https://github.com/torvalds/linux/blob/master/drivers/char/virtio_console.c#L1282

Why don't you try it?

It's certainly possible that a port doesn't have a name.


