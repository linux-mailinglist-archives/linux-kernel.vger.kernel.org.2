Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C93AFAAE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 03:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhFVBq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 21:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVBq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 21:46:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EACC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 18:44:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p7so33114727lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 18:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2T+4u9U452MLDrV2sYabqwjNLxExFpoXzhYGSkfV/Ws=;
        b=eRVgBkLkEobSTUu2RowLHRnirDS2+IwYWobxfQcL1BQgaljFpmhjb4Nq7LOUQ+Hj3M
         s4W6phGuKaUSejFuFkfCQ4U9v3NjqK4FOKXIomQNR81jfOE//up36OIDU7Mnx3DX4qpF
         l2cY4IJK/9UAsJPc6Nu/AETIeST4OORcrqv75/Seg1CHIvvQvQwe7iXiAz1dgNtUnBcG
         DgCCoGbUjaPkgkzK5U0tufNBgh54zK8J7B2+UnH6aXqk04V4W4S73ISaRvv9kqG8brSA
         n6TnhwiWH1Rk99hHEuAwK9kMtmxRFbKyGkRfUZqJk36daIK2zyCxk4SzQqKiRu4dDBb1
         U2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2T+4u9U452MLDrV2sYabqwjNLxExFpoXzhYGSkfV/Ws=;
        b=sP6qNG5i5+ZSJzpOuLyIx1Krm9R8fznmo1/mSnJcVWeICbI8mowb8lYcdBov9yfje/
         tDWi6/EEFewTaBPPjlZEkLxNY/BbPkbkAbEh5jc4dHbdHnJ4WI0qqsbHz4Gh8EqOJnA9
         XuOdim5gfr+TwutuP08y0N6q7tM3J5UMP1bIsC39hZRVOYcuTVPvo/46i7Cr9tMUstN8
         Mq5DH/dW4aqDO/banoKji31aN6FpstWynR8Im7fUyqM7QiXJbYw9SxHaZJEtDEaeBRUu
         QBqAp+JXgPkNlzG/T77gbawqRIB9xPoGdYg9CkYuQUrwheFV72r8XZuFOmizFs17aRt2
         tXww==
X-Gm-Message-State: AOAM531HPOFBluedQffK39qi3srA3B718U1KF3Obz+JmxP5laQj8wopv
        XLZAdu1+zk27r3j9qO9w9B+zHZWxZ1qwXm+/LXA=
X-Google-Smtp-Source: ABdhPJyQXRfM5h/ViEgeFaxz2ca/NMheg2Er/toj2fzJ2zsb2j4LEy+PdmZbxxtQc2bwjuQGToAOvFBERb0c4+GEbxw=
X-Received: by 2002:a05:6512:1583:: with SMTP id bp3mr864286lfb.500.1624326278809;
 Mon, 21 Jun 2021 18:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <1624324395-7260-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1624324395-7260-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Jun 2021 22:44:27 -0300
Message-ID: <CAOMZO5Bh6J8=E=P1btDdgkYm9bvBN1ituRHLLOtW1cFsheQBdg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] ASoC: fsl-asoc-card: change dev_err to
 dev_err_probe for defer probe
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Mon, Jun 21, 2021 at 10:31 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> Don't need to print error message for defer probe
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2:
> - use dev_err_probe instead of dev_dbg
>
>  sound/soc/fsl/fsl-asoc-card.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 121e08c2af2a..24c890d76da0 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -708,8 +708,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>         of_node_put(framemaster);
>
>         if (!fsl_asoc_card_is_ac97(priv) && !codec_dev) {
> -               dev_err(&pdev->dev, "failed to find codec device\n");
>                 ret = -EPROBE_DEFER;
> +               dev_err_probe(&pdev->dev, ret, "failed to find codec device\n");

I know I suggested dev_err_probe() before, but looking at this again, I realized
that the error message will never be printed.

Maybe the error message could just be deleted?
