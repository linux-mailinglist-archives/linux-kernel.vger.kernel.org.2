Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9376535871C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhDHOZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhDHOZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:25:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B46C36101B;
        Thu,  8 Apr 2021 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617891926;
        bh=sn2hDfKA8eJUAzhWw+QV3wjK0yJ9Bf1IhQlXuedPuro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nF/5+Q+jTpcthesIyTGtzGT3v1THKcDRyfCg+NFfn3bY/TV3MWiTSP3NjMTcInP/7
         O9R29lPRxzFDdmOam7nHy/YALC7lc+Yw5PpOgEotESdlfue/QTLGFI0sVqvkKCOO9L
         xRdST6WrMF7BaYo6DYb1cM4blMpBuvIqtV0NZhazgmzW7bWb8UWJ7XHNFwfS7D+qmb
         VY+RlaDb//0KGS6PkxQnfy8gFbyVnD6Q0fc+XfUGSllhQI9VzoK/JNKshLsLtWqTpd
         dC24ZfGSWvpWAeezkpVz4GfKX7PhSdG8EbKWPyKxg5S3FllyeBXaIeL8jc/i0bEIgY
         2rbreDxzkGOkg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUVb0-0001AX-EM; Thu, 08 Apr 2021 16:25:22 +0200
Date:   Thu, 8 Apr 2021 16:25:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 00/13] tty.h cleanups
Message-ID: <YG8SUl+B8+76JZwV@hovoldconsulting.com>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 02:51:21PM +0200, Greg Kroah-Hartman wrote:
> Turns out there is a lot of tty-internal stuff in include/linux/tty.h
> that do not belong there.  Create a internal-to-the-tty-layer .h file
> for these types of things and move function prototypes to it instead of
> being in the system-wide header file.
> 
> Along the way clean up the use of some old tty-only debugging macros and
> use the in-kernel dev_*() calls instead.

I'm afraid that's not a good idea since not all ttys have a
corresponding class device. Notable exception include pseudo terminals
and serdev.

While dev_printk() can handle a NULL device argument without crashing,
we'll actually lose log information by removing the tty printk helpers.

Johan
