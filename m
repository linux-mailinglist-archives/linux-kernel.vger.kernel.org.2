Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764003AFAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFVCSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhFVCSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:18:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6A3C061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 19:15:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i1so6364762lfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 19:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GpzA+s8lvFsctseOT+5uPm2562t7LAgE0eEfnLZ9Pnk=;
        b=tu17vS/fM+jlMjiPABq2Ut09SAl1FccrJO20rnttQ86LkZwVvGSLjgGo8vxGraZB+v
         kcutcVyqy70RxIUm+t7V9u0WCu+u4UCChFwziU/vtJb1tgoogLW9puWtsEu1V4WE1FNU
         pxDnM6H40WkKN3Njroyh9l5FIe73uWL5VgMpjgHhGrS0+rCibtx8js7T39nxX/ceZbMT
         EFhCT8yG+uOKWPMbwxwQnOo1CpZxS7ZdV9XuZH1Zr9vfwHUVFqIzaILq9wWcPw23WUHt
         iFjiwhWNw9uQ9/HsH1yNmM9Fk2mEMytMkJ3R46w2DEBKYQfk7sKd9Vrkxi8lUhJI+1um
         mQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GpzA+s8lvFsctseOT+5uPm2562t7LAgE0eEfnLZ9Pnk=;
        b=kNI9Ipl51tibIgf6wZA2omI3O9kPFfPhPOnbvRNYLXwSr6LkHS1JvG99XFjnKgtj0N
         sPnSClYGmChoRFAzGxRMWPPctM0KPrQ4r5rd/UoRjBMfzwe4IBakKhCzfF5YIs2Aqg7J
         bR6o/G4QznuUFt5WmoUXiToh1xA3T/AMSQ8rEjfEXGiQRjNmXv/q/AcNhXgxxZB5onSF
         t1MIjJWACgyqQTu00QWwfEGTxRXTArmbpMoLJ073jb0jHMo0HhJMvniQ8WIgEycCTGup
         6TGE8z9zJdlNleufzf+QYMOnlxzRnrX1u5IJ4o0NUpYpdKNBv/gBXDxEV+cGJEF8EHIL
         Y3QA==
X-Gm-Message-State: AOAM530iEtFfE2ITOae08deN6yv4doMWp8PgsN1n0iPom1JxWb8zecek
        JEzEMz33djSbrrs0Gt2/N52kjWrg3JdOqK9LU94=
X-Google-Smtp-Source: ABdhPJySHFadxRfxD2SOtm1zWGyqRaIAuj8te+5MBb7/YjkBkJfWXviGXjXRVJYQppsXBO3rNOBU78QAAUAO4vVNiMw=
X-Received: by 2002:a05:6512:3b24:: with SMTP id f36mr927384lfv.443.1624328148749;
 Mon, 21 Jun 2021 19:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <1622616132-10391-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1622616132-10391-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Jun 2021 23:15:37 -0300
Message-ID: <CAOMZO5A1+HUmUVhYv4en4Vgw93AoS62UwQx1GwC9i4XiG5QZvw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: change dev_err to dev_dbg for defer probe
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
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

On Wed, Jun 2, 2021 at 3:59 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> Don't need to print error message for defer probe
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl-asoc-card.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 4f55b316cf0f..b40ba910ae9d 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -709,7 +709,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>         of_node_put(framemaster);
>
>         if (!fsl_asoc_card_is_ac97(priv) && !codec_dev) {
> -               dev_err(&pdev->dev, "failed to find codec device\n");
> +               dev_dbg(&pdev->dev, "failed to find codec device\n");
>                 ret = -EPROBE_DEFER;

This looks good:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

My previous suggestion of using dev_err_probe() would make the message
never to be printed.

Thanks
