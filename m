Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E40345E95
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCWMyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231219AbhCWMy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:54:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B50A619B9;
        Tue, 23 Mar 2021 12:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616504066;
        bh=lKQSbBoD5VY1QPknyOuP3OHdtK0DDF5PhyZzYUxCGtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyvtQLKpngyWCBu75hqYmFlyIY7Hwdpf2MF+ofg2eaX032kHj3tZLNK05DI1c18iw
         nIFB3rkB+IcbjnjJ3tOyKexWpLQHvqkx2vOj8QTyo9z0YMlqlBy+s83r7j0rRGKkUN
         Y1gDH1iWgq5zE4tUKhFotH8YD2ZI3f5I7FQR5a3E=
Date:   Tue, 23 Mar 2021 13:54:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhankar Kuranagatti <shubhankarvk@gmail.com>
Cc:     jason.wessel@windriver.com, dianders@chromium.org, arnd@arndb.de,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        bkkarthik@pesu.pes.edu
Subject: Re: [PATCH 1/2] drivers: misc: kgdbts.c: Fix declaration warning.
Message-ID: <YFnlADClpqE9Zkom@kroah.com>
References: <20210313215808.dt7uvt2suwq4z4x3@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313215808.dt7uvt2suwq4z4x3@kewl-virtual-machine>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 03:28:08AM +0530, Shubhankar Kuranagatti wrote:
> A new line has been added after declaration. This is done to
> maintain code uniformity.
> 
> Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
> ---
>  drivers/misc/kgdbts.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
> index 945701bce553..3ee5acc1c391 100644
> --- a/drivers/misc/kgdbts.c
> +++ b/drivers/misc/kgdbts.c
> @@ -474,6 +474,7 @@ static int emul_sstep_put(char *put_str, char *arg)
>  {
>  	if (!arch_needs_sstep_emulation) {
>  		char *ptr = &put_str[11];
> +
>  		if (put_str[1] != 'T' || put_str[2] != '0')
>  			return 1;
>  		kgdb_hex2long(&ptr, &sstep_thread_id);
> @@ -502,6 +503,7 @@ static int emul_sstep_put(char *put_str, char *arg)
>  			return 1;
>  		} else {
>  			char *ptr = &put_str[11];
> +
>  			kgdb_hex2long(&ptr, &sstep_thread_id);
>  		}
>  		break;
> @@ -740,6 +742,7 @@ static int validate_simple_test(char *put_str)
>  static int run_simple_test(int is_get_char, int chr)
>  {
>  	int ret = 0;
> +
>  	if (is_get_char) {
>  		/* Send an ACK on the get if a prior put completed and set the			* send ack variable
> --
> 2.17.1

This patch is corrupted :(

Please fix up and resend the whole series properly threaded so our tools
can pick them both up at the same time.

thanks,

greg k-h
