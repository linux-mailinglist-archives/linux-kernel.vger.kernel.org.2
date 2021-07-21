Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337D63D0CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhGUJ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238354AbhGUJoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:44:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 736DC60FF2;
        Wed, 21 Jul 2021 10:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626863082;
        bh=v7yZ8xV80HOEBTn2SFFA+dDJTXTW5xOIzqd96tmaslI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AtWncSmH+F9ILFW07QHj6hhuo+Si0pQUqDvhDi73d+8N6zbB2NgE17CBGKblPZ8DL
         PUCCPr1Ak0wtvPSTwmb4xhwxrr8cBM0gN0N2QmARS0IcnW0JGWULs1tgTq1sFphkR4
         MLq3mdHTbHK9KFL1/7cHiizVr0K8rIa1VLv3lENA=
Date:   Wed, 21 Jul 2021 12:24:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenguo Zhao <zhenguo6858@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: n_gsm: add some instructions and code for
 requester
Message-ID: <YPf16Kr/jUhqxGDM@kroah.com>
References: <1624850430-28015-1-git-send-email-zhenguo6858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624850430-28015-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 11:20:30AM +0800, Zhenguo Zhao wrote:
> From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
> 
> The gsm driver can configure initiator or requester by parameter
> initiator,but the config code and using are different ,the doc has
> initiator instructions only,it should be add instructions for requester.
> 

Again, make this a patch series please.

thanks,

greg k-h
