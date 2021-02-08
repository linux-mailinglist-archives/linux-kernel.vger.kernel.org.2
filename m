Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A650313248
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhBHM1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbhBHMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:08:39 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B5CC0617AA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 04:07:38 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id d24so962150vso.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 04:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+j5o1c0su2L6YdF71vWuSQLkAAyzmVika0Z7We4Rac=;
        b=fGVWBffzUrOIaO3OE9oqhO2bDHkyUt6xA45dv+PjB3q6C2+dLEpXekxAyisHfGOK+K
         ykgs+JcdTimpWykmP6LCmsZIUB8GrEmDWzU/hg7gooX8xJWFXUZMNORu/vPtadQUMdR4
         1Om4gc4kgRhtpIllX9VLrQxhtdQKBd9LSk92ZhbA8B22mG00N9T+VjOIAKztk0/F57k1
         ESTec0UJjqRtFNbSEWwqm6dJFxzWDjgrBfnRX9IS8A1tAtfWhjWG5Ocz9ProgoozNGHR
         RN2ww2Ey2y0zLA7/edPES5Jf0PRSTh0lN0adOf5qc5lMY8M3+CFTgUVzIED9TKqP7TpX
         +qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+j5o1c0su2L6YdF71vWuSQLkAAyzmVika0Z7We4Rac=;
        b=XAEoqGnWB4Fzn6BpjFz0C/KVqwxAIRseCxO9ZzbT3JBMV43XXc36ST0N2jy84Tlkri
         yvNfyZHrb8v9/Ix0sEBXgV40Ko2dHd9hZNxBOHgPcO8Fse2lIyCXI97GnBaz98v+c4JP
         AiQSQthuzbxiNYeuBXgh5a/56R6D7jPBC90XGQOaz1sxEADQ8FbIKBmo3tkMOQY9l7js
         AGzrMAyd1Q3REuSeLROor4G87NJmHKY27CnGI2+/dM53tn+cwUei15rl4JvbXNGVxLOK
         BhgUGmghOoo8nn1j0BRAs1hFz8c50zRXpPGMBmiG7LMDmy1VfyXug9Hj9kB8sNMcAFXn
         e/Ig==
X-Gm-Message-State: AOAM530xlZR6b8znWqE/kiW5cktXhcViHNG00RnyTYNxMy1QJey98Yno
        ZNfXowOmDOJc42LLGoD9fjUzBb/vXDkc64gHNveY7A==
X-Google-Smtp-Source: ABdhPJzdeJt7cR2Lci0/u43eiwTMDXryQjeAQX7GjhkgnwIUBZrkUU985x0DMiJvS4aJ2y06E5DIneLyvogQpFyKpI4=
X-Received: by 2002:a67:c787:: with SMTP id t7mr10392016vsk.48.1612786057397;
 Mon, 08 Feb 2021 04:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20210204151847.91353-1-kernel@esmil.dk>
In-Reply-To: <20210204151847.91353-1-kernel@esmil.dk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Feb 2021 13:07:00 +0100
Message-ID: <CAPDyKFrFPWu-mb+krWBYAC=DPpWDqYDseACRRFHyscKbG7yHaA@mail.gmail.com>
Subject: Re: [PATCH 0/9] drivers: mmc: Update trivial tasklet_init() callers
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, Alex Dubov <oakad@yahoo.com>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Pierre Ossman <pierre@ossman.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 at 16:19, Emil Renner Berthing <kernel@esmil.dk> wrote:
>
> This updates callers of tasklet_init() in drivers/mmc to the new API
> in commit 12cc923f1ccc ("tasklet: Introduce new initialization API")
>
> All changes are made by coccinelle using the following semantic patch:
>
> @ match @
> type T;
> T *container;
> identifier tasklet;
> identifier callback;
> @@
>         tasklet_init(&container->tasklet, callback, (unsigned long)container);
>
> @ patch1 depends on match @
> type match.T;
> identifier match.tasklet;
> identifier match.callback;
> identifier data;
> identifier container;
> @@
> -void callback(unsigned long data)
> +void callback(struct tasklet_struct *t)
> {
>         ...
> -       T *container = \( (T *)data \| (void *)data \);
> +       T *container = from_tasklet(container, t, tasklet);
>         ...
> }
>
> @ patch2 depends on match @
> type match.T;
> identifier match.tasklet;
> identifier match.callback;
> identifier data;
> identifier container;
> @@
> -void callback(unsigned long data)
> +void callback(struct tasklet_struct *t)
> {
>         ...
> -       T *container;
> +       T *container = from_tasklet(container, t, tasklet);
>         ...
> -       container = \( (T *)data \| (void *)data \);
>         ...
> }
>
> @ depends on (patch1 || patch2) @
> match.T *container;
> identifier match.tasklet;
> identifier match.callback;
> @@
> -       tasklet_init(&container->tasklet, callback, (unsigned long)container);
> +       tasklet_setup(&container->tasklet, callback);
>
>
> Emil Renner Berthing (9):
>   mmc: atmel-mci: Use new tasklet API
>   mmc: au1xmmc: Use new tasklet API
>   mmc: dw_mmc: Use new tasklet API
>   mmc: omap: Use new tasklet API
>   mmc: s3cmci: Use new tasklet API
>   mmc: tifm_sd: Use new tasklet API
>   mmc: uniphier-sd: Use new tasklet API
>   mmc: via-sdmmc: Use new tasklet API
>   mmc: wbsd: Use new tasklet API
>
>  drivers/mmc/host/atmel-mci.c   |  6 +++---
>  drivers/mmc/host/au1xmmc.c     | 14 ++++++--------
>  drivers/mmc/host/dw_mmc.c      |  6 +++---
>  drivers/mmc/host/omap.c        |  7 +++----
>  drivers/mmc/host/s3cmci.c      |  6 +++---
>  drivers/mmc/host/tifm_sd.c     |  7 +++----
>  drivers/mmc/host/uniphier-sd.c | 14 ++++++--------
>  drivers/mmc/host/via-sdmmc.c   |  9 +++------
>  drivers/mmc/host/wbsd.c        | 35 +++++++++++++++-------------------
>  9 files changed, 45 insertions(+), 59 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
