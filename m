Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD2416564
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbhIWSvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242788AbhIWSvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:51:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2730BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 11:50:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u8so29123642lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 11:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+xBDmQPXKsiGLr3VFMM2p7CpCvy6Zy6mjF1IkZrEIc=;
        b=y3X4xo8LVdZMrchYSTb0hQnOCCOXfWzr6tEV4tU2YsVOLgy8fUwLfb1w8hP2yiP2GT
         ZRjEuMxdtKdzMTw1ktv61HJpmLMtARrXWmld/U1ns3nWx3mn1vPDzi6zUry/stv95Mgj
         2KYwwNIMeQ9MWVJQwIPAjHowZrMZEFPqcWRwYwBIZepnKm2qC4OeQNRnuFXWo8q3k9SG
         DT9dDeYx6ajv7y/8OrQ9HdINic5v1tcDb25oKDYb8xSu3GA5AW/eypqW3IttgTkfcAIU
         3FrnVA+hK5lUYEEMuNwQaqKPRYe3U8l1sPLxhZsuBvTh0mFTH3banaEkmb2Hox8BbWnT
         LQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+xBDmQPXKsiGLr3VFMM2p7CpCvy6Zy6mjF1IkZrEIc=;
        b=VKKf/ZzhqiR9SHTTdrt0k4hBCgo5TNeuHY6nYg7m2ZZoxn3VqqD3g9Iw698qoqcHAi
         soLe6dVZjWCiycokxwUHu2FRUn0IDI8koVSdT03c7u+lUedeE6cQNZ2LITOQIyzOkMkN
         1JIzHdci0wTVOqr6Fj/zHOnSEMgXjsLD9jUWBykuyewxeOa7ZPN4vr3qMSywFOhX19qS
         DOJTZLymf6aJhYo4+R+RiaSj7ShCzvHMsUekKvOMSZBcqpZ3benbJj/LiXIL6cBjUadQ
         WQ7wKo7OlKqjGrHBMWaq9ru0DgP/xJdgcnphD256TY4rbFB6sN+a8agJdSeSWwCJ+6gu
         YOdg==
X-Gm-Message-State: AOAM531pjPamSNoede1ZTwitw7PJbGl0ecj21ZymiE+YEgqZLDFKbPvz
        8AJq8omMiPkESIsd2gitsUgCwpfL9RQU99eAC4eqLu495YM=
X-Google-Smtp-Source: ABdhPJxmuOPc/eEBZuFHS88X/WSvOdyPLq05/U0zOuP+5xD4VGlhAcmpTse2JIvNDLEh6CKIOgsb+rXfqVJ408et2/8=
X-Received: by 2002:a05:651c:20b:: with SMTP id y11mr6770656ljn.463.1632423017540;
 Thu, 23 Sep 2021 11:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631785820.git.mchehab+huawei@kernel.org> <820bb7a1d7e0e51cbea72c9bee6bce806427d1f3.1631785820.git.mchehab+huawei@kernel.org>
In-Reply-To: <820bb7a1d7e0e51cbea72c9bee6bce806427d1f3.1631785820.git.mchehab+huawei@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Sep 2021 20:49:41 +0200
Message-ID: <CAPDyKFrZptmXAfJbf7eUyrQ0dMVSZbpdXw=CfK-LSYbEeMayig@mail.gmail.com>
Subject: Re: [PATCH v2 05/23] dt-bindings: mmc: update mmc-card.yaml reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>,
        Yang Li <abaci-bugfix@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sept 2021 at 11:55, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Changeset 922eefdafc80 ("dt-bindings: mmc: Convert MMC Card binding to a schema")
> renamed: Documentation/devicetree/bindings/mmc/mmc-card.txt
> to: Documentation/devicetree/bindings/mmc/mmc-card.yaml.
>
> Update its cross-reference accordingly.
>
> Fixes: 922eefdafc80 ("dt-bindings: mmc: Convert MMC Card binding to a schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 7a29ad542e4a..9dafcbf969d9 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1510,7 +1510,7 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
>                  * REVISIT: should be moved to sdio core and made more
>                  * general e.g. by expanding the DT bindings of child nodes
>                  * to provide a mechanism to provide this information:
> -                * Documentation/devicetree/bindings/mmc/mmc-card.txt
> +                * Documentation/devicetree/bindings/mmc/mmc-card.yaml
>                  */
>
>                 np = of_get_compatible_child(np, "ti,wl1251");
> --
> 2.31.1
>
