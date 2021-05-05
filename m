Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85941373BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 14:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhEENAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhEENAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:00:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEAAC061574;
        Wed,  5 May 2021 05:59:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y26so1913883eds.4;
        Wed, 05 May 2021 05:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q3TUXql89bkOBKVdZb/N0fDACBtYAZwgrTC4aNZ/0kc=;
        b=uV29I9tLk7ANTNzFA1wxHQJbNKWCXsHVRbRSEBzO5LsmthoqIERDma5lAafkKTeqir
         HRvCo6sKwWjdy7gWqurDdr/67LoqJ0eeHBZ931slpmjfCNWd6P0PrbKlMn6sGUUx8MJN
         c5QszoiquPtLswpAkmublRPb/jbOHJp3cuYHkTctZYmuz6PYScf7zOeeCgFXnCIkUijp
         ZJHWbTWEN2m2AMCT4yu9W4ud1xjLX5UZMZ7Xf0k9QItiBUvcyI0vH88x37QXbjAhbYkB
         ArO45VAh4ZkSl5R0eace/5p9Br8N3bvgCUVjRSh0CEigbskH5hEpAHvoD5f4Y1BDHTUV
         ++AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q3TUXql89bkOBKVdZb/N0fDACBtYAZwgrTC4aNZ/0kc=;
        b=oeVidgfzWLKg45M1PI/4Un+fINWpSURJh4wM5jQgQHXeJKdi43gzbl8hz5JgAAsBSV
         39ySjBCg80Vnim9yvskJ4/SIV3d/RDgT/poahfbaUTPIr4egsdb2q/WRweYQ+8R8ca81
         +FIErInut3V2w7ypbA7w6xosvz83hxHkxrBcE20LmMfS7EdAp8Z+PJ9l2WM6R6GgyyN/
         +iYw+IuDuwD5kQc4NzwOhxegOMIeIIaSzuAQ8yPXier2igYVl+xEhVelIzpQjq65fz88
         25vOQtP7XPQ6J2sVpVIbM4OoV4Nk04XlZIDH7O/zKA3txLnwWINJCgFkqGbdk5Ut3IAL
         1vOA==
X-Gm-Message-State: AOAM532SzPYQlILGwghAKPdGwKL9vwah77DVUP8tFsdJRXnuZEiYBndx
        GuroROrtz3hI/3Vy/dV+2jMkfWGQTrzVlHXf2j4=
X-Google-Smtp-Source: ABdhPJyx/n0JkMbp0gnpwsKd3yP6nSHrkixNPJdYcwGzCflujmMm1KivqO2G9w8ig4+I7PoAx2bOod9QJHoAI5/GHJE=
X-Received: by 2002:a05:6402:20f:: with SMTP id t15mr32166134edv.370.1620219576979;
 Wed, 05 May 2021 05:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210409125732.376589-1-luca@lucaceresoli.net>
In-Reply-To: <20210409125732.376589-1-luca@lucaceresoli.net>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 5 May 2021 07:59:25 -0500
Message-ID: <CAHCN7xLSgkJKs-8baa9O303=x1jB=7khedyBMcoHP_33Obqdbg@mail.gmail.com>
Subject: Re: [PATCH] clk: vc5: fix output disabling when enabling a FOD
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 7:57 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> On 5P49V6965, when an output is enabled we enable the corresponding
> FOD. When this happens for the first time, and specifically when writing
> register VC5_OUT_DIV_CONTROL in vc5_clk_out_prepare(), all other outputs
> are stopped for a short time and then restarted.
>
> According to Renesas support this is intended: "The reason for that is VC=
6E
> has synced up all output function".
>
> This behaviour can be disabled at least on VersaClock 6E devices, of whic=
h
> only the 5P49V6965 is currently implemented by this driver. This requires
> writing bit 7 (bypass_sync{1..4}) in register 0x20..0x50.  Those register=
s
> are named "Unused Factory Reserved Register", and the bits are documented
> as "Skip VDDO<N> verification", which does not clearly explain the relati=
on
> to FOD sync. However according to Renesas support as well as my testing
> setting this bit does prevent disabling of all clock outputs when enablin=
g
> a FOD.
>
> See "VersaClock =C2=AE 6E Family Register Descriptions and Programming Gu=
ide"
> (August 30, 2018), Table 116 "Power Up VDD check", page 58:
> https://www.renesas.com/us/en/document/mau/versaclock-6e-family-register-=
descriptions-and-programming-guide
>
Reviewed-by: Adam Ford <aford173@gmail.com>

> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/clk/clk-versaclock5.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.=
c
> index 344cd6c61188..3c737742c2a9 100644
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -69,7 +69,10 @@
>  #define VC5_FEEDBACK_FRAC_DIV(n)               (0x19 + (n))
>  #define VC5_RC_CONTROL0                                0x1e
>  #define VC5_RC_CONTROL1                                0x1f
> -/* Register 0x20 is factory reserved */
> +
> +/* These registers are named "Unused Factory Reserved Registers" */
> +#define VC5_RESERVED_X0(idx)           (0x20 + ((idx) * 0x10))
> +#define VC5_RESERVED_X0_BYPASS_SYNC    BIT(7) /* bypass_sync<idx> bit */
>
>  /* Output divider control for divider 1,2,3,4 */
>  #define VC5_OUT_DIV_CONTROL(idx)       (0x21 + ((idx) * 0x10))
> @@ -87,7 +90,6 @@
>  #define VC5_OUT_DIV_SKEW_INT(idx, n)   (0x2b + ((idx) * 0x10) + (n))
>  #define VC5_OUT_DIV_INT(idx, n)                (0x2d + ((idx) * 0x10) + =
(n))
>  #define VC5_OUT_DIV_SKEW_FRAC(idx)     (0x2f + ((idx) * 0x10))
> -/* Registers 0x30, 0x40, 0x50 are factory reserved */
>
>  /* Clock control register for clock 1,2 */
>  #define VC5_CLK_OUTPUT_CFG(idx, n)     (0x60 + ((idx) * 0x2) + (n))
> @@ -140,6 +142,8 @@
>  #define VC5_HAS_INTERNAL_XTAL  BIT(0)
>  /* chip has PFD requency doubler */
>  #define VC5_HAS_PFD_FREQ_DBL   BIT(1)
> +/* chip has bits to disable FOD sync */
> +#define VC5_HAS_BYPASS_SYNC_BIT        BIT(2)
>
>  /* Supported IDT VC5 models. */
>  enum vc5_model {
> @@ -581,6 +585,23 @@ static int vc5_clk_out_prepare(struct clk_hw *hw)
>         unsigned int src;
>         int ret;
>
> +       /*
> +        * When enabling a FOD, all currently enabled FODs are briefly
> +        * stopped in order to synchronize all of them. This causes a clo=
ck
> +        * disruption to any unrelated chips that might be already using
> +        * other clock outputs. Bypass the sync feature to avoid the issu=
e,
> +        * which is possible on the VersaClock 6E family via reserved
> +        * registers.
> +        */

Thanks for the comments here.  I with IDT/Renesas would better
document this. I might see if I can convince one of the hardware guys
at my office to test the impact of radiated emissions.

> +       if (vc5->chip_info->flags & VC5_HAS_BYPASS_SYNC_BIT) {
> +               ret =3D regmap_update_bits(vc5->regmap,
> +                                        VC5_RESERVED_X0(hwdata->num),
> +                                        VC5_RESERVED_X0_BYPASS_SYNC,
> +                                        VC5_RESERVED_X0_BYPASS_SYNC);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         /*
>          * If the input mux is disabled, enable it first and
>          * select source from matching FOD.
> @@ -1166,7 +1187,7 @@ static const struct vc5_chip_info idt_5p49v6965_inf=
o =3D {
>         .model =3D IDT_VC6_5P49V6965,
>         .clk_fod_cnt =3D 4,
>         .clk_out_cnt =3D 5,
> -       .flags =3D 0,
> +       .flags =3D VC5_HAS_BYPASS_SYNC_BIT,
>  };
>
>  static const struct i2c_device_id vc5_id[] =3D {
> --
> 2.25.1
>
