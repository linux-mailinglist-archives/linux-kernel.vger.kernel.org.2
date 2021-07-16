Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A10C3CB1A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 06:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhGPEpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 00:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhGPEpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 00:45:00 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CAEC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 21:42:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id x19so3494115ljc.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 21:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hLXcv6ssbAU/4UsbdnrR6GhZv/lBo8eTNBMRVo5fh+I=;
        b=PFuTJezU7vVuN4oslIUcVuXZ4Jz8VZCh1Q0kNsDVLuNEvkZ8FEvACgXh1XyIY9ZG8R
         M8zcPISX3agfmKWfKnnt4z6dwwcWcbLdTqofE4GOE1WI6L+RF3EVjbEVKHiFKNscL36Z
         sYeSK8SZd1r9IT1LZB57WVcifZi8D/zy34kq3FD8Z+ksntnXWYvZIpzB9HSGm3roxRY5
         ZvgCHToZwbxzaOu+cPfzAzCgqiPSygxYvsKTX7SCHiC4RXM5EufQIRmO1oxapcT8ho1N
         wiKs7znTaWaUq8BV8OfOU1pJrpW4lfV2hD83ZQRsuREA/3K9tL0C+ANfxISgby3j18u2
         oFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hLXcv6ssbAU/4UsbdnrR6GhZv/lBo8eTNBMRVo5fh+I=;
        b=R/0JsAUOo0pW7BGsqffT+Ys9uX5prOQw0EySBVHhKkckKKBr/GTQu8SHOST6nmwBqF
         sa/tpi7r0G3tDm+KTcMdtLj5lm4bATD9TxB5nbZwGhc6HY+k+AHAegmsbeXTYlOnraWv
         JBGRfqkOd0PBMybBDBIwtF7vVSbCVBjQnod3f/lU7AzaugBmj8koPyH5wrX+6AS5xstK
         GI+hVb2ogXZFg/uXTZ+wGb86yD7EBKi88wTy8FL0H8+exULQCjL+oTlkMDVFl5UCx3tE
         r0IndqWa8XruarKPSJySSbndBfr0yZoMWs1uMmLO8TU9h0CGzUFzt1uYHIWztUHB8IFA
         HwkA==
X-Gm-Message-State: AOAM533FnWIzbLBQlFxW+Hs71NAFMVn6Lhkp0yG+7p8fDcE1bkkiAJ4C
        UCqSqKacAhNrx6G9xQfU9Vg=
X-Google-Smtp-Source: ABdhPJys/0SJcTfz8AfGHPq5cU/DcrxoskPM8/LqKibOmTeO/P58zN2oRTu0X6OSjtG0MJwnSYhRcQ==
X-Received: by 2002:a2e:b6c8:: with SMTP id m8mr7559075ljo.8.1626410524450;
        Thu, 15 Jul 2021 21:42:04 -0700 (PDT)
Received: from asus ([37.151.208.206])
        by smtp.gmail.com with ESMTPSA id y24sm550949lfe.255.2021.07.15.21.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 21:42:03 -0700 (PDT)
Date:   Fri, 16 Jul 2021 10:42:01 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: KSM: fix data type
Message-ID: <20210716044201.GA210515@asus>
References: <cover.1626371112.git.zhansayabagdaulet@gmail.com>
 <3610f5373bb12ea04e025bafbf8350f75c0dbf4b.1626371112.git.zhansayabagdaulet@gmail.com>
 <CA+CK2bCzn8BVOH2pB4=MPyyDN9KeoWRmQ=GYq25R1zDKibuEeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCzn8BVOH2pB4=MPyyDN9KeoWRmQ=GYq25R1zDKibuEeg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 02:10:33PM -0400, Pavel Tatashin wrote:
> On Thu, Jul 15, 2021 at 2:01 PM Zhansaya Bagdauletkyzy
> <zhansayabagdaulet@gmail.com> wrote:
> >
> > ksm_stable_node_chains_prune_millisecs is declared as int, but in
> > stable__node_chains_prune_millisecs_store(), it can store values up to
> > UINT_MAX. Change the variable type to unsigned int.
> >
> > Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
> > ---
> >  mm/ksm.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 057d0c245bf4..2e4bd7662e52 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -259,7 +259,7 @@ static unsigned long ksm_stable_node_chains;
> >  static unsigned long ksm_stable_node_dups;
> >
> >  /* Delay in pruning stale stable_node_dups in the stable_node_chains */
> > -static int ksm_stable_node_chains_prune_millisecs = 2000;
> > +static unsigned int ksm_stable_node_chains_prune_millisecs = 2000;
> >
> >  /* Maximum number of page slots sharing a stable node */
> >  static int ksm_max_page_sharing = 256;
> > @@ -3105,11 +3105,11 @@ stable_node_chains_prune_millisecs_store(struct kobject *kobj,
> >                                          struct kobj_attribute *attr,
> >                                          const char *buf, size_t count)
> >  {
> > -       unsigned long msecs;
> > +       unsigned int msecs;
> >         int err;
> >
> > -       err = kstrtoul(buf, 10, &msecs);
> > -       if (err || msecs > UINT_MAX)
> > +       err = kstrtouint(buf, 10, &msecs);
> > +       if (err)
> >                 return -EINVAL;
> >
> >         ksm_stable_node_chains_prune_millisecs = msecs;
> 
> LGTM, but I would merge the two patches together. They both update
> types of sysfs tunnables in the same file.

Ok, I'll send v2 as a single patch.

Thanks,
Zhansaya
