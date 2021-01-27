Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A648305E26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhA0OX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233375AbhA0OWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:22:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD16E207B7;
        Wed, 27 Jan 2021 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611757323;
        bh=ilkgzF27O2aG4zXfw3/KubkNM0t7h6Ensqcg3lB2FE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEMXgirm7mDr1xljqooCJhzV7vrx5icUzRjwAFBheoFBvzfuFg47bjeOFzM+mBaA0
         Vf73zeQqBis9jFFRm3U0ZeLqXIwU9yY7MT2TnXYxicLXUmON8AxdNbB9dV/BI4Czk9
         L8rVaN0fNroQ0GpW8dC40AhJp9th7MG4VJgauUYI=
Date:   Wed, 27 Jan 2021 15:22:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] vt: keyboard, use new API for keyboard_tasklet
Message-ID: <YBF3CCdnXWfSRbHU@kroah.com>
References: <20210123214739.2042-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123214739.2042-1-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 10:47:39PM +0100, Emil Renner Berthing wrote:
> This converts the keyboard_tasklet to use the new API in
> commit 12cc923f1ccc ("tasklet: Introduce new initialization API")
> 
> The new API changes the argument passed to the callback function, but
> fortunately the argument isn't used so it is straight forward to use
> DECLARE_TASKLET_DISABLED() rather than DECLARE_TASKLET_DISABLED_OLD().
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  drivers/tty/vt/keyboard.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Does not apply to my tty-next branch of my tty.git tree :(

Please rebase and resend.

thanks,

greg k-h
