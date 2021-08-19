Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583643F1E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhHSQrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhHSQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:47:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:47:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id t42so3461384pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s+Wwu2BCumEJC46q6yenF3dRV5K2EWETsK1YrMFqy9w=;
        b=t0aDUBfiS33CSOj/Dr+MWtreWrkcojkMjnWzTzzkq4p5MzNxiHkucko6sq84OOSQkH
         gLBoJ12XAJdmSVu88EJbBii4DxYjoTZYHYxOhO1s0O2wKxsJY+zeLo0G2bMwxPC6nct8
         refAHTVNSnwImFVmWBOW3HohPjg5rimSQb5g8JWtEI2u4d/KD+owKafS8wbAOpWYk1xn
         uXH+9RqIiCOdp0Nm3EnZiw8ytP4oAxPw6JjsTaolMBes7HZAmuR8bHUaBrzsEE3IcKCg
         HJntl14gakGuNDymXeuEVyLrokNdYY4f3W/D1LhDcWJ4/iQ2FdLBvIaBGEheMYvgk8H7
         /v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s+Wwu2BCumEJC46q6yenF3dRV5K2EWETsK1YrMFqy9w=;
        b=jNFOx1AT9qgRzzwc1nbURswnB+WLLngW+Uq6+CFOTNcuGKXJ/kkYLAG/q9F6pJJgX4
         6mBL/6TLvVZ2xOdVtd46tPPQQoiO9wGYLVqJP7pBM2FWbZAE1Z0VkTS7zOaZUHvvyqB5
         +/S2ZWyQtHUY7KTideo7tCBGmm7nSaXTUm8+WIVmENJorbJtIC0SQ/xTQPbnhM+OmX5B
         1Ly2culB3i8ODeARX01WfJ7v+7W2YsUtfKvvbefMfCeM7rdR+qyguZmlFLN1VR3yn1G1
         0254wbyACnPUa6olloTxNVIcEKQhX+qsptpojf+Lxm76rCCX1huz9chtl1TqaWVoBlSz
         2c2Q==
X-Gm-Message-State: AOAM530fjwQ1n2XpUzhhj8itzpG5OqV2VVFvlxvBezJg8tCeIdhVsbl1
        RQxHUpOyPlMmtYsRHWNVq7ioECSi39A46Sh42TI73Q==
X-Google-Smtp-Source: ABdhPJzLNgcExj0UR3byNKrR7iav69hW36zMSqA+jdvLcsg8sV3gbuUGftzwHaSGCuT/7EpnToi6fJZwRKzwBXikVfQ=
X-Received: by 2002:a63:db4a:: with SMTP id x10mr1073774pgi.30.1629391627867;
 Thu, 19 Aug 2021 09:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <m3a6m9cq52.fsf@t19.piap.pl>
In-Reply-To: <m3a6m9cq52.fsf@t19.piap.pl>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 19 Aug 2021 09:46:56 -0700
Message-ID: <CAJ+vNU34_t=zF5ZuJWr2Cw_9+0EvSwYBNSEZikkUBiOsTtDUcQ@mail.gmail.com>
Subject: Re: [PATCH] Fix cosmetic error in TDA1997x driver
To:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 3:42 AM Krzysztof Ha=C5=82asa <khalasa@piap.pl> wro=
te:
>
> The colon isn't followed by anything here.
>
> Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
>
> diff --git a/drivers/media/i2c/tda1997x.c b/drivers/media/i2c/tda1997x.c
> index 91e6db847bb5..e55e4afaae8a 100644
> --- a/drivers/media/i2c/tda1997x.c
> +++ b/drivers/media/i2c/tda1997x.c
> @@ -563,7 +563,7 @@ static void tda1997x_delayed_work_enable_hpd(struct w=
ork_struct *work)
>                                                     delayed_work_enable_h=
pd);
>         struct v4l2_subdev *sd =3D &state->sd;
>
> -       v4l2_dbg(2, debug, sd, "%s:\n", __func__);
> +       v4l2_dbg(2, debug, sd, "%s\n", __func__);
>
>         /* Set HPD high */
>         tda1997x_manual_hpd(sd, HPD_HIGH_OTHER);

Acked-By: Tim Harvey <tharvey@gateworks.com>
