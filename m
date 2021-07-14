Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C833C84E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbhGNM7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhGNM7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:59:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72A6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 05:56:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a12so3411490lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 05:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TKFpa78isQisSosRPybp51ffw8MhNd0Jxnvwb6YKTCA=;
        b=KZuzekgr7wXG2FmXAr0PPvzvrvmBj0J4bs8fnWfBSPBlCDZy5CLAeYNWNOZTUk8Ltq
         Jb1KNfH/CR3zZhvGeXbUcLwlVq10brFXr4Nhw1wSTdSqI4ssLs0YyguHrtIDMeALaz5L
         88G9VX3llVKYCYeihgkoE+utDxoYNp+xQXIxdBlTio9AUfoSQ7G3l5DSLxfZSd3EW7nf
         s6ZpBoBTcgOtMl3xcMLMJBv9ZDP8OuuyBA1sswrhX9cDBY6gi9mhVPLPZeohvfF7h/Eu
         cs8Ja3oMAH1qzwipsazC2yQCXJNJA8bUDdetAj28uyBZmbuRRCOTTB0lF8khjNYAY7jQ
         /oPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TKFpa78isQisSosRPybp51ffw8MhNd0Jxnvwb6YKTCA=;
        b=oW/zHsBFbbHtvP8ufkFxY0i5TwJqEbP3YL0Ih3UqNeQU+xx/2zaUhpPRPEhXKeMkUm
         +6mIDVIzQktvpyB1dam+FAEbLsCvg0Ys+8OPtGgjmGcMc9e65+ROzegz0NX0DnzL4o09
         d4Zu8dn1xc3BvhJvQZul4/35HxAzCsqHZ1oEAHhy2AjUMj/2ZTQ3O6mzYi/oXHDubryR
         LJoVUYhypi96vWtbmto+4pevrgkMrJ5OwcebGpIcPIZJVuQqwtSQdKL/w4E3CG2+9izq
         sXj2Av+y5P69JRlCHjUF1Zy4sT7BI9sPJjN6R3ZOQONUhr4JFwufk/Zw+iEwfPsz6n8L
         aPAw==
X-Gm-Message-State: AOAM530EaUNmXaCQUsaMY0Id4//j3ThDZp5NXEVbMnGBWbjpEgfUJ31J
        9Hb+lVJlu09QF+Ldma/d8UamXA==
X-Google-Smtp-Source: ABdhPJwmFLoen/c7I313U0JHoVRop6b5mSNNUIhmly01niUZMKuO/igo18Oq7W0puYGbbjNej72ByA==
X-Received: by 2002:ac2:520c:: with SMTP id a12mr8019394lfl.67.1626267414247;
        Wed, 14 Jul 2021 05:56:54 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k8sm248479ljn.18.2021.07.14.05.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 05:56:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B073A102647; Wed, 14 Jul 2021 15:56:52 +0300 (+03)
Date:   Wed, 14 Jul 2021 15:56:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     Alistair Popple <apopple@nvidia.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>, bskeggs@redhat.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: nouveau: failed to initialise sync
Message-ID: <20210714125652.eohw2s2pncplxovx@box.shutemov.name>
References: <YOC4uekpD7iA3xPi@Red>
 <1682547.0nLxAY2a9E@nvdebian>
 <dace0dea-7ca9-99cb-ad80-106824cb5e3f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dace0dea-7ca9-99cb-ad80-106824cb5e3f@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 08:58:37AM +0200, Christian König wrote:
> Hi guys,
> 
> yes nouveau was using the same functionality for internal BOs without
> noticing it. This is fixes by the following commit:
> 
> commit d098775ed44021293b1962dea61efb19297b8d02
> Author: Christian König <christian.koenig@amd.com>
> Date:   Wed Jun 9 19:25:56 2021 +0200
> 
>     drm/nouveau: init the base GEM fields for internal BOs
> 
>     TTMs buffer objects are based on GEM objects for quite a while
>     and rely on initializing those fields before initializing the TTM BO.
> 
>     Nouveau now doesn't init the GEM object for internally allocated BOs,
>     so make sure that we at least initialize some necessary fields.
> 
> Could be that the patch needs to be send to stable as well.

The regression is present in v5.14-rc1. Any idea when it will hit
upstream? I don't see it being applied to drm=next.

-- 
 Kirill A. Shutemov
