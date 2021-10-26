Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5653643B843
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbhJZRi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbhJZRiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:38:17 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD41C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:35:51 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id x27-20020a9d459b000000b0055303520cc4so20842774ote.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANjT17K3ayZRw6d7hdD8+s5Skaoxr1KQOeOiPXOn+/A=;
        b=CPQt/KpbL1B1CLWaw8s2/N8hYoD+t6qyE8pvv1K0DevOBforkxredd1J4DHrpEEsG8
         BHekRZyOFZ1/nw6a0C6Rjd4QBpgzrYXasZrvJvRVGB9mvVQ8bgg6jP7/0ElTU81D09dQ
         NLj7Z7pxJ8vnXvWD++CgHEtnhCDO5ZM0gfEfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANjT17K3ayZRw6d7hdD8+s5Skaoxr1KQOeOiPXOn+/A=;
        b=u9VogeuX5Oefaax7BI6pZu2iKvR6b4sObp/7T1LVqPNr+SMZ7QyU59f+tSnWjLdVzc
         93MRRo2rER/XPoGx3uCrruiMXSLdVQZbHJ2YKFJf0cjz8oSeIsrOEC5U+ihEJgq3vhu8
         hCDX6j7xrc1sv58KqFXwoixJoeEx2wi+ONmbjdKqPoNx1/+HfxlwWuGlsm1VkVNR8BZW
         DbKmg06TYBwmeufiNTqrJXF3cJxjn1WwFPd/TDcE1dkMuBGxN7S8IqHQz8jip+N+Z+cy
         +h7yFRGL7qlZAC2TIwAx2v9Nmf11Pd54f8VBcadICKdUvxKc6b5D1/04xjYoLUjueJPT
         l/hQ==
X-Gm-Message-State: AOAM5327IfQvlxsjfbfutKzptDNnRz5dlBw0oN/v8ybD9nw2l2n6g90v
        fvT/0jpkcF0/ZAeEjh+p5BoIhLbqCLUaYQ==
X-Google-Smtp-Source: ABdhPJwkZS94xlMC+FHdaUVIxNuG9ckUXT8TT8frkoN71a6COCXJbwVeA8nzn0SCsaSK6MWEogViHw==
X-Received: by 2002:a9d:6088:: with SMTP id m8mr21193904otj.214.1635269750344;
        Tue, 26 Oct 2021 10:35:50 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id p190sm656760ooa.1.2021.10.26.10.35.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 10:35:49 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so20885189otk.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:35:49 -0700 (PDT)
X-Received: by 2002:a05:6830:44a9:: with SMTP id r41mr20622101otv.230.1635269748963;
 Tue, 26 Oct 2021 10:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211026095214.26375-1-johan@kernel.org> <20211026095214.26375-3-johan@kernel.org>
In-Reply-To: <20211026095214.26375-3-johan@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Oct 2021 10:35:37 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNbMJ1EgPRvosx0AbJgsE-qOiaQjeD=vCEyDLoUQAgkiw@mail.gmail.com>
Message-ID: <CA+ASDXNbMJ1EgPRvosx0AbJgsE-qOiaQjeD=vCEyDLoUQAgkiw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mwifiex: fix division by zero in fw download path
To:     Johan Hovold <johan@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Amitkumar Karwar <akarwar@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 2:53 AM Johan Hovold <johan@kernel.org> wrote:
>
> Add the missing endpoint max-packet sanity check to probe() to avoid
> division by zero in mwifiex_write_data_sync() in case a malicious device
> has broken descriptors (or when doing descriptor fuzz testing).
>
> Note that USB core will reject URBs submitted for endpoints with zero
> wMaxPacketSize but that drivers doing packet-size calculations still
> need to handle this (cf. commit 2548288b4fb0 ("USB: Fix: Don't skip
> endpoint descriptors with maxpacket=0")).
>
> Fixes: 4daffe354366 ("mwifiex: add support for Marvell USB8797 chipset")
> Cc: stable@vger.kernel.org      # 3.5
> Cc: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Seems like you're missing a changelog and a version number, since
you've already sent previous versions of this patch.

>  drivers/net/wireless/marvell/mwifiex/usb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
> index 426e39d4ccf0..2826654907d9 100644
> --- a/drivers/net/wireless/marvell/mwifiex/usb.c
> +++ b/drivers/net/wireless/marvell/mwifiex/usb.c
> @@ -502,6 +502,9 @@ static int mwifiex_usb_probe(struct usb_interface *intf,
>                         atomic_set(&card->tx_cmd_urb_pending, 0);
>                         card->bulk_out_maxpktsize =
>                                         le16_to_cpu(epd->wMaxPacketSize);
> +                       /* Reject broken descriptors. */
> +                       if (card->bulk_out_maxpktsize == 0)
> +                               return -ENODEV;

If we're really talking about malicious devices, I'm still not 100%
sure this is sufficient -- what if the device doesn't advertise the
right endpoints? Might we get through the surrounding loop without
ever even reaching this code? Seems like the right thing to do would
be to pull the validation outside the loop.

Brian
