Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390153C868E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbhGNPFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhGNPFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:05:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C916C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:02:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u1so3657578wrs.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=69w+z8JoXYSnbwOBKKpmUamhnEyqL/avmTKA+C4lMEY=;
        b=EPZ3o0qksnwmpDdR5qBMIUCBF2nDe1/LnvgVsRL0Uwn4u1966C5R0oynHkzDAMKTep
         MWRMvT9QbZRvzkJH2VgevF1v1XtiDt9PyMkkstslRN8KAOYbR7+kEj2EfRfUyeYHDSuF
         27Z0DYgyvF/y9RpbDW5K8wF1/NZF8S8cRl0j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=69w+z8JoXYSnbwOBKKpmUamhnEyqL/avmTKA+C4lMEY=;
        b=GEmldtXoA9sakpa7pJ3+tnieJx9fB3fY0h3H7lFq6399Yw91qgVPupcKgKype6YHuV
         xBkYqgMflKDXiMqWtK9HIyGQzW/7tvBe2kGiaupieZ2t7iFxpGZoUdq/3vPRljx3U/NM
         ZFlQzRQdSNGs/8NraFCIk22WRsmedUjNue13BMSdZ4V9BLNmlFr8WWVNmTMPtGEydnza
         +eEmcjqJMd8fNmUdOD6Yr0Bp3TsxfKU2418BU74Z7JEeVtr6FxPvwn5v0A+j7t6dvRJE
         1zBtIYzOVroRk0gMpzcsw7ARhJwyDpWekZ7OmXzZoGuJ1yFG2oRXWscdXRllu/MII6gh
         qBjg==
X-Gm-Message-State: AOAM532fcVxtENZHPsoMVJsAyN7+YFagNQE64UeX6ZCqT3Do5NGPGuRf
        Ah69tUOBQbqGPM1WlmEv84Pjrg==
X-Google-Smtp-Source: ABdhPJy9TYv3Dvc+7HTbNWDhitjGCLCY3N4IXMufP5bnqtdWagmFMkGNl9XOCiGVaKFbQMoPLbiAnw==
X-Received: by 2002:a05:6000:136a:: with SMTP id q10mr13713546wrz.25.1626274941640;
        Wed, 14 Jul 2021 08:02:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b187sm5753264wmd.40.2021.07.14.08.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:02:20 -0700 (PDT)
Date:   Wed, 14 Jul 2021 17:02:18 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, airlied@linux.ie,
        daniel@ffwll.ch, Alistair Popple <apopple@nvidia.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>, bskeggs@redhat.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: nouveau: failed to initialise sync
Message-ID: <YO78eo/MNcPMYAgC@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, airlied@linux.ie,
        Alistair Popple <apopple@nvidia.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>, bskeggs@redhat.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <YOC4uekpD7iA3xPi@Red>
 <1682547.0nLxAY2a9E@nvdebian>
 <dace0dea-7ca9-99cb-ad80-106824cb5e3f@amd.com>
 <20210714125652.eohw2s2pncplxovx@box.shutemov.name>
 <8fd70eb5-7306-89a3-57f9-d633243c9df5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fd70eb5-7306-89a3-57f9-d633243c9df5@amd.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 03:02:21PM +0200, Christian König wrote:
> Am 14.07.21 um 14:56 schrieb Kirill A. Shutemov:
> > On Tue, Jul 06, 2021 at 08:58:37AM +0200, Christian König wrote:
> > > Hi guys,
> > > 
> > > yes nouveau was using the same functionality for internal BOs without
> > > noticing it. This is fixes by the following commit:
> > > 
> > > commit d098775ed44021293b1962dea61efb19297b8d02
> > > Author: Christian König <christian.koenig@amd.com>
> > > Date:   Wed Jun 9 19:25:56 2021 +0200
> > > 
> > >      drm/nouveau: init the base GEM fields for internal BOs
> > > 
> > >      TTMs buffer objects are based on GEM objects for quite a while
> > >      and rely on initializing those fields before initializing the TTM BO.
> > > 
> > >      Nouveau now doesn't init the GEM object for internally allocated BOs,
> > >      so make sure that we at least initialize some necessary fields.
> > > 
> > > Could be that the patch needs to be send to stable as well.
> > The regression is present in v5.14-rc1. Any idea when it will hit
> > upstream? I don't see it being applied to drm=next.
> 
> Well that question needs to answer Dave or somebody else from the drm-misc
> maintainer team.
> 
> This fix together with some others are already in drm-misc-next-fixes
> waiting to be pushed upstream, but it looks like that hasn't happened yet.
> 
> Even Linus already pinged me where the fix for qxl got stuck.

Yeah there was some missed patches. drm-misc-fixes is now in drm-fixes,
and drm-misc-next-fixes is included in drm-misc-fixes, for which Thomas
will do a pull request on Thu so it will land in -rc2.

It should also now be in linux-next.

But yes somehow bugfixes got a bit lost during the merge window.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
