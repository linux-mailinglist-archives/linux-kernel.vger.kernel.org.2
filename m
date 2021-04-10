Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A175535AAF0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 06:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhDJEzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 00:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhDJEzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 00:55:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFD8C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 21:55:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w3so11770088ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 21:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4d0pH++PQprtx+vqNO/EImXYyO+3e2J6Tc3oRYuTHK8=;
        b=BFX07dcQQC7idy+oqH7E1iiDyabFawNYenVXM+2lE5XxCaEbyFMazKJOth+88p3tju
         SzPwxXxrY2LkPYOTNXxLEbBYtKl19VmsoCGFmXT86oltTsMrwc+VvpV4D5CotvB2h8fL
         eBUdSRQY839fxM8M0Y1gZ91sCyqmv69CePGWSIgGQoveZWn7UU6Vs5NmSjSLLFH3vH4N
         V/UHOIBL2/0M8vhTrswkLWS3I6vVexDEdkuZ29C3M0yBqmzPvc6Wq/difVZaeQjJJy3o
         q2W+LXLoNUy1Sh2w0ESC8+EjXQBHs7Ro0AnRC6GjC/GpNLwau7erKvMfav7KcPAoywi/
         KeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4d0pH++PQprtx+vqNO/EImXYyO+3e2J6Tc3oRYuTHK8=;
        b=JGMEa2pDYL1UQgdMXrrTKdKQqGhXb7kUdyHygRC+PlUr485qziH1hQHIAHMx5rqexL
         IbifHX1DTPPPK6LJCWfPaOtHaejUdzH9Cc2FAIhIUFYWZibWDtqcNrwXfaR2wY397HO2
         vf+0STTLW/qL5Msttk797oiMrXj9ND8EbsDII/ier+KOq2uQ1MlSMblVcy8H1lJ1iiQs
         gpeVi7GO1J5szztegy+DXHwX2i2HAByTos6dvoHuPVXc6DQoZT8xGZ4oyy4uV9Y/zvzD
         MgtcwLTaVoM8KzXihA64fSbgVElYxotH8dU/MzYJAnT4liQWcDE6Eg4jiP3s1rPhBCB7
         Vn+Q==
X-Gm-Message-State: AOAM530An6omNZSZVt2lAwdAs7pP4zpVh7xd39r4ctbZCSl03DnXuzc/
        K9FyW/Jk0ZBLtNiuwbf9rS3aQnKo7F2aQpJgzhRyvw==
X-Google-Smtp-Source: ABdhPJy97uW/eMQbp6c11KKQsQT06Pryo58CAEY7vl4VUrtBAYLoCvDlt1KzsXgSFSdQmlWio+8NSWoCrNq2lW4GkQA=
X-Received: by 2002:a17:906:4fcd:: with SMTP id i13mr18945286ejw.341.1618030498122;
 Fri, 09 Apr 2021 21:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <1618014803-17231-1-git-send-email-wangyingjie55@126.com>
In-Reply-To: <1618014803-17231-1-git-send-email-wangyingjie55@126.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 9 Apr 2021 21:54:50 -0700
Message-ID: <CAPcyv4hBN2eCGehzZES7_NNco5xupKsvv69JtxzzCoV-DzT9bQ@mail.gmail.com>
Subject: Re: [PATCH v1] libnvdimm, dax: Fix a missing check in nd_dax_probe()
To:     wangyingjie55@126.com
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 5:33 PM <wangyingjie55@126.com> wrote:
>
> From: Yingjie Wang <wangyingjie55@126.com>
>
> In nd_dax_probe(), nd_dax_alloc() may fail and return NULL.
> Check for NULL before attempting to
> use nd_dax to avoid a NULL pointer dereference.
>
> Fixes: c5ed9268643c ("libnvdimm, dax: autodetect support")
> Signed-off-by: Yingjie Wang <wangyingjie55@126.com>
> ---
>  drivers/nvdimm/dax_devs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
> index 99965077bac4..b1426ac03f01 100644
> --- a/drivers/nvdimm/dax_devs.c
> +++ b/drivers/nvdimm/dax_devs.c
> @@ -106,6 +106,8 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
>
>         nvdimm_bus_lock(&ndns->dev);

hmmm...

>         nd_dax = nd_dax_alloc(nd_region);
> +       if (!nd_dax)
> +               return -ENOMEM;

Can you spot the bug this introduces? See the hint above.

>         nd_pfn = &nd_dax->nd_pfn;
>         dax_dev = nd_pfn_devinit(nd_pfn, ndns);
>         nvdimm_bus_unlock(&ndns->dev);
> --
> 2.7.4
>
