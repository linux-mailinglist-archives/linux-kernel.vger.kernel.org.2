Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F72358BB6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhDHRvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232086AbhDHRvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:51:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C6B86102A;
        Thu,  8 Apr 2021 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617904268;
        bh=KuQ2NPcI8Eyge55YipbH8V/VzAUdZA9IO6cGEES+FEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=weCQZbLDItw3wP41Mo7TQsWaBwqakf19IjFJwKNN3KU3/d7FoZEcxM/htFGBrQvgI
         cj6ixTgj3MzQbl4tjbOnMpnWR0ZbLhtf/aL5WsJE3JTQ4Htu7doKnsCfUG6KNuGtX9
         OnE8CfDWUvThr8ySHk3hrvZHytFMxXQwXFTAo6s4=
Date:   Thu, 8 Apr 2021 19:51:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 13/13] tty: clean include/linux/tty.h up
Message-ID: <YG9CiV+CwGo2CFsN@kroah.com>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
 <20210408125134.3016837-14-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408125134.3016837-14-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 02:51:34PM +0200, Greg Kroah-Hartman wrote:
> There are a lot of tty-core-only functions that are listed in
> include/linux/tty.h.  Move them to drivers/tty/tty.h so that no one else
> can accidentally call them or think that they are public functions.
> 
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/n_gsm.c  |  1 +
>  drivers/tty/n_hdlc.c |  1 +
>  drivers/tty/tty.h    | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/tty.h  | 34 ----------------------------------
>  4 files changed, 39 insertions(+), 34 deletions(-)

This needs a "tty.h" inclusion into drivers/tty/tty_baudrate.c,
otherwise it's a build warning, I missed that, sorry.  Will add that to
the next revision if it's needed, or just fix it up when committing it.

thanks,

greg k-h
