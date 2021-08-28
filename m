Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E55F3FA3F7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 08:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhH1GNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 02:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbhH1GNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 02:13:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8447060F25;
        Sat, 28 Aug 2021 06:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630131182;
        bh=IrfMcD1HRdtmOwrQbiZX6PIiNowxcKTK2W92DQYpM8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dyMY7N5U5FQpg+iWIUcYdQAJrN8c8WmPsvNsdcQoftjreJQE1UrfC5YnwwhD844I0
         QPtf+0NZINbTLhmwJUNzbx2N069NyA0dlSPD0e3gS1L/TY0yUdEZ7am3u0r3lHeUIF
         Gk49VHy/NdaJDzlxYYMkG44mDVDBLBkV3P6kgfwA=
Date:   Sat, 28 Aug 2021 08:12:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     hello@bryanbrattlof.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix docs typos and references to
 previous struct names
Message-ID: <YSnT5rXxQNE2sPvw@kroah.com>
References: <20210828000836.GA10188@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828000836.GA10188@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 12:08:36PM +1200, Paulo Miguel Almeida wrote:
> In the comments there where some grammar mistakes and references to
> struct names that have gotten renamed over time but not reflected
> in the comments.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
>  drivers/staging/pi433/pi433_if.h | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
> index d5c1521192c1..1fae62c40661 100644
> --- a/drivers/staging/pi433/pi433_if.h
> +++ b/drivers/staging/pi433/pi433_if.h
> @@ -5,16 +5,15 @@
>   * userspace interface for pi433 radio module
>   *
>   * Pi433 is a 433MHz radio module for the Raspberry Pi.
> - * It is based on the HopeRf Module RFM69CW. Therefore inside of this
> - * driver, you'll find an abstraction of the rf69 chip.
> + * It is based on the HopeRf Module RFM69CW. Therefore, inside of this
> + * driver you'll find an abstraction of the rf69 chip.
>   *
> - * If needed, this driver could be extended, to also support other
> - * devices, basing on HopeRfs rf69.
> + * If needed this driver could also be extended to support other
> + * devices based on HopeRf rf69 as well as HopeRf modules with a similar
> + * interface such as RFM69HCW, RFM12, RFM95 and so on.
>   *
> - * The driver can also be extended, to support other modules of
> - * HopeRf with a similar interace - e. g. RFM69HCW, RFM12, RFM95, ...
>   * Copyright (C) 2016 Wolf-Entwicklungen
> - *	Marcus Wolf <linux@wolf-entwicklungen.de>
> + * Marcus Wolf <linux@wolf-entwicklungen.de>

Indentation of the name should remain here, right?

thanks,

greg k-h
