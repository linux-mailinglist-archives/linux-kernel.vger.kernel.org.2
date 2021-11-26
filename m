Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF6345F0DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353914AbhKZPnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378176AbhKZPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:41:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134EAC061372
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 07:31:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92F60B82815
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 15:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F47CC93056;
        Fri, 26 Nov 2021 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637940682;
        bh=kFsm/Dy7rzAPTEZov79mX9SZDSaKx2dHu3ATclKLFYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bWhN6WM8oiH/j2rFYr30fsy7R58hj+FgTQfDUoN2FHSwcZbopOfUaCGhNk+R5cGXc
         VXBsmuEDeJtC0+cRAAxJXHZVVZysA8tfniq0tx1a4plBqnS4pwSpGHSV0Zhl9BtnWu
         TXiaAnaSVMTrznD/Ef0kalSkkLEO6SYfbFVZCrG8=
Date:   Fri, 26 Nov 2021 16:31:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com
Subject: Re: [PATCH v17] tty: Fix the keyboard led light display problem
Message-ID: <YaD9x9Cvdte72ohN@kroah.com>
References: <20211126112727.14939-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126112727.14939-1-changlianzhi@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 07:27:27PM +0800, lianzhi chang wrote:
> By judging the value of kb->kbdmode to determine whether it is necessary
> to forcibly set the led state of the keyboard when switching between
> different ttys. Solve the problem of the inconsistency between the
> keyboard led status and the keyboard lock status in some scenarios,
> such as the scenario where the desktop and tty switch mutually.

No, the original text was all good, it was just not readable.

Try putting some paragraph breaks in it.  You had numbered lists, so put
those so that they are readable.

Just some basic formatting to make it able to be understood.  Do not
delete the whole thing :(

greg k-h
