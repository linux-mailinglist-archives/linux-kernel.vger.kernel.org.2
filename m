Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF553BF8A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhGHLHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhGHLHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:07:00 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA23C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 04:04:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f13so14121981lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 04:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQF+/ojCE/cB6pZjz83JMNHkZCNZNnhbv3jXkH9NjNY=;
        b=TpauRQX+bp9X4fBya3vNqkdgCP0wjviMxoDdFuQrUb8xgoFBTtaS89v09Qnuk1Kjkr
         WmATCHKKjek7ZkYZKmcC+Lbbxh6KIs/5CEzt7QwTuhzDJHNl/cIjzVs+Vj1fK8zwPuuu
         UCBYqWvS/HJEN4bARCGJDFEDkSDL41g20OpVl1xrYmrEDbMxgPtPTA2JqdCaf1uPGgiy
         bwccQB4Ruii+qRmoIl8iG/vNFQ97Dm8/yrCiAZ0ZBOBEuwlyXrVBevUltecLfEkQ0tsn
         X0Ap8B/QufCuqmTS2Au1KXAX5pRIu0Gd2/ybHBmhw7vR4tV46bv+xeF4iUrkjxduj+nZ
         G2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQF+/ojCE/cB6pZjz83JMNHkZCNZNnhbv3jXkH9NjNY=;
        b=T2PUW1WYv0dpUldG7hSFhs389qfvuuk6aZu4vRD0qxQ2MCkJZrIJbJcMJUtQvAnflp
         KMjLalA4cecsLsXbKN6ojTIbfIreItC1eyJnrcBQzJvdP2mll8qChevne2eBh96IP2mF
         dKGuMue3f3FdFMp3TUvmAkbwvtvRsC99n+0bMsjJePCJ4+/54FaqWBBF9MKFfobiEKYl
         gF+OGSICRFXlP+GHlDRuRBdCtIPZpra8ZW5jXba1I/8YeC+gg3hbqwOd9H9Hi/+lz3VR
         cKf01dtT71T0yOA8CTxI/1O9IQz6/YDTZ1Vzo13PH88gJyj9vxuryd1Xn5GkSZdi6zcD
         AfkQ==
X-Gm-Message-State: AOAM530QrPusTBMe1lTqn6F4ZpLtTTy7mQXnCgRXJwujKfnqAFQ+tdnC
        UgEA0xWNbk6koCxTWY8otuc=
X-Google-Smtp-Source: ABdhPJzo5Ag7ncSQwWbJYNMsI2u7IOc1++kX+CINdhTZ2RJYTVBDhtzmw+wP4VVp+pIQ5pvZQZc9PQ==
X-Received: by 2002:a19:5059:: with SMTP id z25mr6560628lfj.622.1625742246651;
        Thu, 08 Jul 2021 04:04:06 -0700 (PDT)
Received: from localhost.localdomain ([94.103.225.155])
        by smtp.gmail.com with ESMTPSA id v8sm208922ljg.137.2021.07.08.04.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 04:04:06 -0700 (PDT)
Date:   Thu, 8 Jul 2021 14:04:02 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     ray.huang@amd.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: ttm: fix GPF in ttm_bo_release
Message-ID: <20210708140402.4ce25702@gmail.com>
In-Reply-To: <55aa8ece-1f1d-76d0-4f2f-951d39e79484@amd.com>
References: <20210707185108.3798-1-paskripkin@gmail.com>
        <f4bb7b29-3abc-a056-fc24-4e91b5de8d74@amd.com>
        <20210708113701.4cea7989@gmail.com>
        <20210708130910.63a15c73@gmail.com>
        <55aa8ece-1f1d-76d0-4f2f-951d39e79484@amd.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jul 2021 12:56:19 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> Am 08.07.21 um 12:09 schrieb Pavel Skripkin:
> > On Thu, 8 Jul 2021 11:37:01 +0300
> > Pavel Skripkin <paskripkin@gmail.com> wrote:
> >
> >> On Thu, 8 Jul 2021 08:49:48 +0200
> >> Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> >>
> >>> Am 07.07.21 um 20:51 schrieb Pavel Skripkin:
> >>>> My local syzbot instance hit GPF in ttm_bo_release().
> >>>> Unfortunately, syzbot didn't produce a reproducer for this, but I
> >>>> found out possible scenario:
> >>>>
> >>>> drm_gem_vram_create()            <-- drm_gem_vram_object
> >>>> kzalloced (bo embedded in this object)
> >>>>     ttm_bo_init()
> >>>>       ttm_bo_init_reserved()
> >>>>         ttm_resource_alloc()
> >>>>           man->func->alloc()       <-- allocation failure
> >>>>         ttm_bo_put()
> >>>> 	ttm_bo_release()
> >>>> 	  ttm_mem_io_free()      <-- bo->resource =3D=3D NULL passed
> >>>> 				     as second argument
> >>>> 	     *GPF*
> >>>>
> >>>> So, I've added check in ttm_bo_release() to avoid passing
> >>>> NULL as second argument to ttm_mem_io_free().
> >> Hi, Christian!
> >>
> >> Thank you for quick feedback :)
> >>
> >>> There is another ocassion of this a bit down before we call
> >>> ttm_bo_move_to_lru_tail() apart from that good catch.
> >>>
> >> Did you mean, that ttm_bo_move_to_lru_tail() should have NULL check
> >> too?
>=20
> Yes, exactly that.
>=20
> >>   I checked it's realization, and, I think, NULL check is necessary
> >> there, since mem pointer is dereferenced w/o any checking
> >>
> >>> But I'm wondering if we should make the functions NULL save
> >>> instead of the external check.
> >>>
> >> I tried to find more possible scenarios of GPF in ttm_bo_release(),
> >> but I didn't find one. But, yes, moving NULL check inside
> >> ttm_mem_io_free() is more general approach and it will defend this
> >> function from GPFs in the future.
> >>
> >>
> >>
> >> With regards,
> >> Pavel Skripkin
> >>
> > I misclicked and sent this email to Christian privately :(
> >
> > Added all thread participants back, sorry.
>=20
> No problem.
>=20
> Do you want to update your patch or should I take care of this?
>=20

Yes, I will send v2 soon. Thank you!




With regards,
Pavel Skripkin
