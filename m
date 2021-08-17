Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FF53EE66D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbhHQGAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbhHQGAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:00:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A08C061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 22:59:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso3257568pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 22:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=L7y9S8as1vRrjVNxU5IKCvH3ncwWV+1w6HAlsrVK1eo=;
        b=tzBr4THklnuJy4h4p55iHV7+ylmRjPN6jgAgR5lglaNGrFRqwo8/3CIzEsNgTaEYL4
         syQBXXZrUXL2xoWce7cdpLd/Q3xPAacVbNM3n++AnpMEHy2EKKhrpn8IbMckjcJHtqkp
         G4WgPW3h4qKViuMjQtHrMNI7lt1mQgN8maoOMffqAF7+fJC937S5RCLUlcKm8w4h9c9O
         yQ+P2d3ES7Cei5FWquJNfoM2tc5rE0cqohPm52kU2SABsqP+TEYFKBA1bwOeyEl4gcHf
         cKCmyhhgGffqIh8KAWKpJylyococwAZi7ehmHBjKNId/XOMnkytNGwVKowCTvIGIVekn
         U9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=L7y9S8as1vRrjVNxU5IKCvH3ncwWV+1w6HAlsrVK1eo=;
        b=WE+ocxFUgDl9Ag1T17+D3CZR8SzoyS0kX7BTuRwKIAyI5WE9mnMEbxW0yQF6zBY5q5
         EfAYnXfiKqhLgqwZiI7DfSkqY4kTB6PqZLeJkwHg9Nr5CfjdlgBh1zRZSV8/3GuAq7UF
         FpAjYgLnWeZbO+UyNI0kFOnhgTDs33VVGD9+CpETJCmt9uWQyFUhDA97L8wowwLAoWYk
         zxD+AF99g8zUrqC2SXos7HzqG/11ldXwEzgFHbewu64pB+0Bbvt/3WZwmxcscTySmRgC
         UbMuAOtQjRkTOHeRBL2/IfYwHxjJUY+i17UpUUe8lReTAd4dZLj60cn/pcDSGI2yuwAz
         g3FQ==
X-Gm-Message-State: AOAM530DDZId7z3ltSTq8UQC8KrXHG74eAAnOyYrVf0ZkF9tQn7KJTEU
        gHBpqsNdGeKI75ObHrT4b6I=
X-Google-Smtp-Source: ABdhPJwfsnEwi9eazaGBT5HSeAOnFGR93A5ZcOxwVXSZgkXT8QfPg60kTKLjSsUx/uwZPicEMz9ROg==
X-Received: by 2002:a17:90a:de04:: with SMTP id m4mr1878185pjv.187.1629179985022;
        Mon, 16 Aug 2021 22:59:45 -0700 (PDT)
Received: from ?IPv6:2804:431:c7f0:30b2:5c9e:50:88f3:269a? ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
        by smtp.gmail.com with ESMTPSA id c15sm920491pjr.22.2021.08.16.22.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 22:59:44 -0700 (PDT)
Message-ID: <2653ee3e582ba181651e4842821e64d3323fa566.camel@gmail.com>
Subject: Re: [PATCH v5 08/11] powerpc/pseries/iommu: Update
 remove_dma_window() to accept property name
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Aug 2021 02:59:46 -0300
In-Reply-To: <8dbd08fb-375c-9f21-f8ab-bec163b157bf@linux.ibm.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
         <20210716082755.428187-9-leobras.c@gmail.com>
         <8dbd08fb-375c-9f21-f8ab-bec163b157bf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fred, thanks for the feedback!

On Tue, 2021-07-20 at 19:51 +0200, Frederic Barrat wrote:
> 
> 
> On 16/07/2021 10:27, Leonardo Bras wrote:
> > Update remove_dma_window() so it can be used to remove DDW with a
> > given
> > property name.
> > 
> > This enables the creation of new property names for DDW, so we can
> > have different usage for it, like indirect mapping.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >   arch/powerpc/platforms/pseries/iommu.c | 21 +++++++++++----------
> >   1 file changed, 11 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c
> > b/arch/powerpc/platforms/pseries/iommu.c
> > index 108c3dcca686..17c6f4706e76 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -830,31 +830,32 @@ static void remove_dma_window(struct
> > device_node *np, u32 *ddw_avail,
> >                         np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN],
> > liobn);
> >   }
> >   
> > -static void remove_ddw(struct device_node *np, bool remove_prop)
> > +static int remove_ddw(struct device_node *np, bool remove_prop,
> > const char *win_name)
> >   {
> 
> 
> Why switch to returning an int? None of the callers check it.

IIRC, in a previous version it did make sense, which is not the case
anymore. I will revert this.

Thanks!

> 
>    Fred


