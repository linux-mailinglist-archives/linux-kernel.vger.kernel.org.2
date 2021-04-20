Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C690E365386
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 09:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhDTHta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 03:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhDTHt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:49:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC88B60241;
        Tue, 20 Apr 2021 07:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618904937;
        bh=gbE4BpWMvZIBRYs4d8NACMDz92xeNg1/sl8BkQJyO00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0YXYVphtGSyI6D81WgV4DmbuJQKa4Cm4YSvb08/5YDNByaDQD/e3ZIF8uiIiGzR0F
         mf+3Dgai5ZFlx7mJysyHyD9GONe2pKB3G/S46WufjQxXprqWOUL8nq3bapXdIf5uWI
         t9WqiEE7rJRfGURjzOpYdBHDPIB2hD63c43qXZ8M=
Date:   Tue, 20 Apr 2021 09:48:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guido Kiener <Guido.Kiener@rohde-schwarz.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        "dpenkler@gmail.com" <dpenkler@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        USB list <linux-usb@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: Re: [syzbot] INFO: rcu detected stall in tx
Message-ID: <YH6HZjbrRibJgFyh@kroah.com>
References: <d1e8e0608903431e8199d9804fecca36@rohde-schwarz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1e8e0608903431e8199d9804fecca36@rohde-schwarz.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 08:56:19PM +0000, Guido Kiener wrote:
> Hi all,
> 
> The error is in usbtmc_interrupt(struct urb *urb) since five years. The status code EPROTO is not handled correctly.
> It's not a showstopper, but we should fix it and check the status code according to usbtmc_read_bulk_cb() or
> usb_skeleton.c.
> @Dave: Do you have time? Otherwise I can do it.
> @Greg: Is it urgent?

No idea, but patches for known problems are always good to get completed
as soon as possible :)

thanks,

greg k-h
