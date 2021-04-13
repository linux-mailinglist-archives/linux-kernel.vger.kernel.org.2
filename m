Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FF635E376
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346795AbhDMQGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237858AbhDMQGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:06:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCDB360C40;
        Tue, 13 Apr 2021 16:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618329975;
        bh=iVk4ofLtaLgfxOuElcRqpxORDJL5HmaPNe6CvxJHhhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMUaFgkd6B45Cczvm272yabgUdJA+06hW6PZ3pfrR60fNoDghNoQgFPyF8WO/NZFF
         s/+5agp31AB/wtqz4Bpyrsm7x641Xfo8noLe+qMUzthidL6mpegw6yGi+ncjWmjpjn
         OUOdVgqmFkSQMcR2HbrdqQj9Gtk7y+i9q8eqprW4=
Date:   Tue, 13 Apr 2021 18:06:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless
 led_blink_hdl()
Message-ID: <YHXBdKuEHd1LcxVG@kroah.com>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413155908.8691-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 05:59:08PM +0200, Fabio M. De Francesco wrote:
> Removed the led_blink_hdl() function (declaration, definition, and
> caller code) because it's useless. It only seems to check whether or not a
> given pointer is NULL. There are other (simpler) means for that purpose.

But you do not actually do that here.  Why not?  You just removed
something, does it still work properly with that removal?

> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Why the leading ":" in your subject line?

> ---
>  drivers/staging/rtl8723bs/core/rtw_cmd.c         | 1 -
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
>  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
>  3 files changed, 11 deletions(-)

Does this patch require some other patch to be applied first?

thanks,

greg k-h
