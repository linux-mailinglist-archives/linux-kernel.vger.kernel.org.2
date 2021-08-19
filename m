Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D81B3F1E56
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhHSQtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhHSQs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:48:58 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDD5C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:48:22 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r2so6448097pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XLrT/sf+7DDfgyGl2ekHDV7Nozk+mw2Dakh6x2ma2AI=;
        b=MdlzVKpK1YDsJjBXNs28Mn8rTdyiGdCmh5v88cNATVYDO3po74YfzP9vyBrGJrGnq9
         3TAFmoo5siAwdtvRttnLfbOUWF+tGflYhEz8G7BH+lY+5B3JSkJGSCJg1QZH8m470aaG
         ox13fw6yaM8HI0SVIRH7Ijqy5JPeMdgwdPmQK5lr2E+lVjtInktW3ttaguK17eSe9q/F
         Is/2DIQY+L2trBy9zHQCRQWMD3ByRIRBtjPcnQWtdpWa5GA7EXMhza267D7+9grX61X2
         /mceIhTi7iohzV+JoB/GUK2hzbDFHZJ4YS7/hbftVPv3HjQQS6mxeFxV27bnEsvo1uur
         nq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XLrT/sf+7DDfgyGl2ekHDV7Nozk+mw2Dakh6x2ma2AI=;
        b=dnJU1wjCUYU1fTqHLzgAq/g0z7/5gqz3uamF3vp9DalBRinyJZVreExqPAtyt26j08
         mUWwsnfPvQeCi51jYJ22LYkVWtj7vYEZmEa4zmoQ1LWpQWvsuvnP3cSbsxdfoJFfpNov
         RUGfbOkq+jGDnNtXYLfWg/BgEwzfRp1lpgoDllQ2afUIhhD/tOphIMH/FM3MCOB/eov6
         28u+ESNhqbvyrAiTgtnIorTQ8nTVrugamXqLfLh6ZNSvbwEePHrvrxqSB8xIfT+phePj
         Yr87uteuBsV81WhZVJXxNbx79i+1pokDAESusIykPyU7BQbvUKHUQ9ZM/3EMkh2TIESL
         9yjQ==
X-Gm-Message-State: AOAM531IofpgBL94yCERwzqgExy4C1p/emt8V41Cv99ctgv/etkKgq+X
        CPv977Ke4/yLbfZasJfyQ1s5w7KJKlJWyv4dApGe1Q==
X-Google-Smtp-Source: ABdhPJy+JT3fZCG1ifMZP964pkdJZZWF0NoBoahECAWIEx3T5KNUsdJxXBYcManD8NBpfVGiWOXQIioomP9ca8D/xoA=
X-Received: by 2002:a63:150e:: with SMTP id v14mr14989244pgl.126.1629391701797;
 Thu, 19 Aug 2021 09:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <m31r7lcpyz.fsf@t19.piap.pl>
In-Reply-To: <m31r7lcpyz.fsf@t19.piap.pl>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 19 Aug 2021 09:48:10 -0700
Message-ID: <CAJ+vNU35OoSs+AcV0xFmae1CPn9T+3tbs29YxmXC17WgO+vSXQ@mail.gmail.com>
Subject: Re: [PATCH] TDA1997x: fix tda1997x_query_dv_timings() return value
To:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 3:46 AM Krzysztof Ha=C5=82asa <khalasa@piap.pl> wro=
te:
>
> Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
>
> diff --git a/drivers/media/i2c/tda1997x.c b/drivers/media/i2c/tda1997x.c
> index 043cc8275d00..cbfe58e413e9 100644
> --- a/drivers/media/i2c/tda1997x.c
> +++ b/drivers/media/i2c/tda1997x.c
> @@ -1695,14 +1695,15 @@ static int tda1997x_query_dv_timings(struct v4l2_=
subdev *sd,
>                                      struct v4l2_dv_timings *timings)
>  {
>         struct tda1997x_state *state =3D to_state(sd);
> +       int ret;
>
>         v4l_dbg(1, debug, state->client, "%s\n", __func__);
>         memset(timings, 0, sizeof(struct v4l2_dv_timings));
>         mutex_lock(&state->lock);
> -       tda1997x_detect_std(state, timings);
> +       ret =3D tda1997x_detect_std(state, timings);
>         mutex_unlock(&state->lock);
>
> -       return 0;
> +       return ret;
>  }
>
>  static const struct v4l2_subdev_video_ops tda1997x_video_ops =3D {

Krzysztof,

Patch looks good to me but needs a commit log.

Best regards,

Tim
