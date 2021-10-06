Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD2C4237FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhJFGaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232979AbhJFGaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:30:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6971861186;
        Wed,  6 Oct 2021 06:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633501709;
        bh=5Ofyu8hfWQU4ytV6M6hVrHVYrZALkAzZzA9juN6Lct4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkRktobNnsLwPDF10nX4/f1LenTx7IrHu5yBWUHPP4MllLZe00ww7JU2P6v5ra8C7
         GSCmd1RwItatjzX5GtRnrh5ukNpFrjbRU0GHSyo98TkWYf+EIqYpP3naz8YK2N4vHk
         oDOiA8j1qfiIc0nvymFs5GD8WxJtMTctm2Sz92Jg=
Date:   Wed, 6 Oct 2021 08:28:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        syzbot <syzbot+7af597ce2b38596c16ea@syzkaller.appspotmail.com>
Cc:     hminas@synopsys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] usb-testing build error (2)
Message-ID: <YV1CCyGShh623mOA@kroah.com>
References: <000000000000b01f1505cda8e03c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b01f1505cda8e03c@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 11:01:31PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    dea971290a03 usb: core: config: Change sizeof(struct ...) ..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=150e8a3f300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cd8a1eadba1e4ce4
> dashboard link: https://syzkaller.appspot.com/bug?extid=7af597ce2b38596c16ea
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7af597ce2b38596c16ea@syzkaller.appspotmail.com
> 
> drivers/usb/dwc2/params.c:252:8: error: 'struct dwc2_hsotg' has no member named 'dw_otg_caps'
> drivers/usb/dwc2/params.c:253:8: error: 'struct dwc2_hsotg' has no member named 'dw_otg_caps'
> drivers/usb/dwc2/params.c:259:8: error: 'struct dwc2_hsotg' has no member named 'dw_otg_caps'
> drivers/usb/dwc2/params.c:260:8: error: 'struct dwc2_hsotg' has no member named 'dw_otg_caps'
> drivers/usb/dwc2/params.c:264:8: error: 'struct dwc2_hsotg' has no member named 'dw_otg_caps'
> drivers/usb/dwc2/params.c:265:8: error: 'struct dwc2_hsotg' has no member named 'dw_otg_caps'
> drivers/usb/dwc2/params.c:270:7: error: 'struct dwc2_hsotg' has no member named 'dw_otg_caps'
> drivers/usb/dwc2/params.c:479:53: error: 'struct dwc2_hsotg' has no member named 'dw_otg_caps'
> drivers/usb/dwc2/params.c:500:9: error: 'struct dwc2_hsotg' has no member named 'dw_otg_caps'
> drivers/usb/dwc2/params.c:509:8: error: 'struct dwc2_hsotg' has no member named 'dw_otg_caps'
> drivers/usb/dwc2/params.c:510:8: error: 'struct dwc2_hsotg' has no member named 'dw_otg_caps'

Thanks, I'll go drop the offending patches from my tree.

greg k-h
