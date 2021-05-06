Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114D5374DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 04:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhEFDAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 23:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEFDAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 23:00:45 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A806CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 19:59:47 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id l129so3697110qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 19:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nU1vgirtCThHvyYn1ZRBNMbOfWAmoUamSH+LcH56a8=;
        b=bV0lkOJUu5s4BbJ6rOBiItcFnuvbF+pPAhICL7Ag0S8hMCilMdMA4h1XNFzN990UGg
         DXxyd2rDycv94LpUuP9K+XIGsdJ1jE+FBVWhinoriPc6FS1PJXhNiJa+KmYAtD0QNcox
         YLOG2tCqtb7TWLtLkt8HjH2rDcpiHVLukewopVAnLSow3YvNLj2nBXP7VkfM7YxKtGOw
         mhiFBao0G/SVg/yiavea5HiyXhCvruWpuNQvaMkzX0uhfbHillZsPq/yeJ3D8BNUfmB2
         y0L8qmXCaTVRTsv6ycs+qIsaDYZKvFy8If6GsPAX7q5kidOzd2hB/HHRbPHw1h8BHqEm
         h7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nU1vgirtCThHvyYn1ZRBNMbOfWAmoUamSH+LcH56a8=;
        b=PQ60gbfx/H7ITedD0XrNCe1BKxO76RJP0h/aPa4XMQdxsoZ452yGziPBIi7mA+CMmN
         YJa3xoXY+vbuqcoTONLJt8eBE8DbtANKpAC+CjHuEBQxxijksvK/uCcgbBZrIISQqXWM
         Mtc+oyEEHQPM+KiyBwn8HqfbypiDyOYAEm3CqrgRGiRUsi0ieYiUn1ctETebsub422Ap
         n7+wvtUkNUkCLHP1NJxfKcuO23qSCzccRG8xAUpN1vDPQ+2u2bwnLhhENgvva8Uh06Ja
         tJ0NbVXaBERLYpMBKFPmrjAQkHXIaKhGDIk15lLpTKz1ECP5aBssx1DxANEHGwkPTHGf
         oNyQ==
X-Gm-Message-State: AOAM53016JyBP/iYbEcDHirpu5Lx9f0u6MjqXs06uUzn/z1cQxnbVEu6
        oBW6zGn/wpQ+I26/Wzs0jpya9hQlogfNm2L4+SU=
X-Google-Smtp-Source: ABdhPJzDff6nOz49nsVXQ8WHxc36EDEAfLfOpn0EAONrS6s8pZ5dBpXMkQjbHpcdA6HIl/tZ0mtx4etMgnd41dZYB7w=
X-Received: by 2002:a05:620a:2903:: with SMTP id m3mr1886281qkp.37.1620269986820;
 Wed, 05 May 2021 19:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210506022452.5762-1-wanjiabing@vivo.com>
In-Reply-To: <20210506022452.5762-1-wanjiabing@vivo.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 6 May 2021 10:59:35 +0800
Message-ID: <CAA+D8AOLyjnjD2gc=a20zYCfJp1EoJ9En4Q9JQXR5qbV9Mpzyg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: Remove unneeded semicolon
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 10:26 AM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> Fix the following coccicheck warning:
>
> ./sound/soc/fsl/fsl_xcvr.c:739:2-3: Unneeded semicolon
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

> ---
>  sound/soc/fsl/fsl_xcvr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
> index 6cb558165848..df7c189d97dd 100644
> --- a/sound/soc/fsl/fsl_xcvr.c
> +++ b/sound/soc/fsl/fsl_xcvr.c
> @@ -736,7 +736,7 @@ static int fsl_xcvr_load_firmware(struct fsl_xcvr *xcvr)
>                         /* clean current page, including data memory */
>                         memset_io(xcvr->ram_addr, 0, size);
>                 }
> -       };
> +       }
>
>  err_firmware:
>         release_firmware(fw);
> --
> 2.25.1
>
