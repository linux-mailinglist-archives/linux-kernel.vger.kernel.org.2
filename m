Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F47D3D0A27
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 09:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhGUHRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbhGUHPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:15:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D315C061762
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 00:56:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n1so1097464wri.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 00:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8w6x8b/7oISblxGUWEIo1tWz0WRfvQ9VyhhiZejv2vo=;
        b=Tt1MCuMlpx25tAZ8kaDzDLvA9Bmyxtfro3AOH0567K+PGiryJKOZqPkgUoCxkx9Wfe
         wLjkrzQx9E3vsMqPu8cOL8uHhMYvhjmZaVhwMknK8+bQJe+rQbHypIC8R0YUJKUaEtuB
         jTghtKK5RgJadYVO81tbqpvrNPX6m8OPZdbgFa6bZVM/1+1tIyuy2h+HZn7PDRkKjXLq
         2sspURuBgsFMvztK08fedY+lJ9LE2+Q9U6bzHREF38s6EIETmLDxc/E1hRma5I6YOBEU
         z/rveNG3ui2qG+zKiKcurGLjP43SoHnHud/M6KE2Yse9HcxU7eM4S4p40TboRrdMcsQv
         ZIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8w6x8b/7oISblxGUWEIo1tWz0WRfvQ9VyhhiZejv2vo=;
        b=mgG+ZqFXdC70MwwyYIlLrE1o4O/04sAo74aXsqSkC0MO8yjL/sfqESj/CUwNkTiw+4
         ShWtvGcagSlXmUY1JHOnsxVusm+Ju6P/vyzdA8/K6BZkAmXbGe7yioY7B38jCE9PH5CQ
         tTqdo9Fx88kL3fX1sbLhMuoYc49gugSaJVSEmYx/cqL9zXdQ/vu8/+jMKH0kyT6pibWU
         yA8rRkESOkHiffRLDxWCLSZR7B0dvfahBJWeCtxtmLXNEUq7LOQ7TYiS4vCiBJt4nEUn
         V54jVYQWe3jS6b4KNx4lc8cykNRXhy8TooJUd6fcwYRAgqXbsZjWSG4MfGBXIuKXerdy
         ToCA==
X-Gm-Message-State: AOAM533/YctGObJs+qJCc+2qTgOblwZN2RQjn1tMeeRd4czJPhGQlrj+
        QI/R2XirfwcvGtMthxZVwPvXdg==
X-Google-Smtp-Source: ABdhPJzj097tjUzSS6tAEMTQjHX81v616+ZPhb3BSxHkaWVSqwV5SnLuiMTEp4iXQ6qWqIFyJJi6/w==
X-Received: by 2002:a5d:46d1:: with SMTP id g17mr41675852wrs.2.1626854170169;
        Wed, 21 Jul 2021 00:56:10 -0700 (PDT)
Received: from wifi-122-dhcprange-122-230.wifi.unimo.it (wifi-122-dhcprange-122-230.wifi.unimo.it. [155.185.122.230])
        by smtp.gmail.com with ESMTPSA id n18sm25133005wrt.89.2021.07.21.00.56.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jul 2021 00:56:09 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] block/bfq: the delta_from_first should be ns rather than
 us
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210721063047.92122-1-liubaozhu@uniontech.com>
Date:   Wed, 21 Jul 2021 09:56:12 +0200
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C5E7C12D-616A-40BD-8BFF-2D7C0211B8C9@linaro.org>
References: <20210721063047.92122-1-liubaozhu@uniontech.com>
To:     liubaozhu <liubaozhu@uniontech.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[RESENDING ...]

> Il giorno 21 lug 2021, alle ore 08:30, liubaozhu =
<liubaozhu@uniontech.com> ha scritto:
>=20
> In the block/bfq-iosched.c,the function bfq_update_peak_rate(),
> bfqd->delta_from_first =3D now_ns - bfqd->first_dispatch,
> according to the subtraction operation here,now_ns is ns,
> and bfqd->first_dispatch is also ns,so bfqd->delta_from_first should =
be ns.
>=20

Correct!

Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thank you,
Paolo

> Signed-off-by: liubaozhu <liubaozhu@uniontech.com>
> ---
> block/bfq-iosched.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 99c2a3cb0..7cf4fc8c3 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -632,7 +632,7 @@ struct bfq_data {
> 	u64 tot_sectors_dispatched;
> 	/* max rq size seen during current observation interval =
(sectors) */
> 	u32 last_rq_max_size;
> -	/* time elapsed from first dispatch in current observ. interval =
(us) */
> +	/* time elapsed from first dispatch in current observ. interval =
(ns) */
> 	u64 delta_from_first;
> 	/*
> 	 * Current estimate of the device peak rate, measured in
> --=20
> 2.20.1
>=20
>=20
>=20

