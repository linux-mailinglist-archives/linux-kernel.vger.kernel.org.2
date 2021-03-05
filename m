Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA032E555
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhCEJxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:53:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229604AbhCEJxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:53:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61C8764FEF;
        Fri,  5 Mar 2021 09:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614937981;
        bh=lWXNhLBFQ2XgGhc6pj58AcY8/fDvYsv9r/2/f1/VKhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GwEl0ktloubUnDo1Hz61ikSwMWCk+//Z+b6G2GSH8bh9HOxZucShh0ELa+UAY3WRV
         99U+c6Q5mB6Io5RuQhbhyF6Q84KInjF0fRbjG9rTpjvfJRnED1EwcRFyn6FMYKE6uI
         c7PCGe8dspVOav7H/0SqxQQ7nPxPFWP8Xq9BEXU+QqTCaMbpeoa4K7HpgdcZPT2hMC
         /xjyv0snaEdfOi0sGaZHqnAEAi1DiQ7daK19THv6h7QStcvsuYufsEdETZZ11lS5f6
         kBr7SkGHy2HEqQWYKlwKjKzh2nRrM/L/tAXNbxXh1VSaHPlWgmwwygi0YxCcCGwE5Q
         FiCRO95LAWiQA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lI791-0001Ew-Rp; Fri, 05 Mar 2021 10:53:15 +0100
Date:   Fri, 5 Mar 2021 10:53:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+59f777bdcbdd7eea5305@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: serial: io_edgeport: fix memory leak in edge_startup
Message-ID: <YEH/i1syuN9Yq3Wu@hovoldconsulting.com>
References: <20210301230152.527093-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301230152.527093-1-paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:01:52AM +0300, Pavel Skripkin wrote:
> sysbot found memory leak in edge_startup().
> The problem was that when an error was received from the usb_submit_urb(),
> nothing was cleaned up.
> 
> Reported-by: syzbot+59f777bdcbdd7eea5305@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>

Now applied, thanks.

Johan
