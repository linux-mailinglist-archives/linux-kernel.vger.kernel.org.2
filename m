Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D473BF806
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 12:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhGHKMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 06:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhGHKMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:12:00 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DB7C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 03:09:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 8so2048563lfp.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 03:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFq54d9QsTmv3rpdp/cy3tzjqHVefFyvdZXGzyRj2aA=;
        b=NK8bhf24SP2Scx6x0fpPgDcU6o9ccB6rm/GRBUBFfvhzt3iMiKtxiNlsHKmgop/Ssf
         ymZPwJh97NG7AetSXxYGFsFIr/e1epnbeI9qKVjep+vxph9tE46UJ5rksZP6Qv0BObwE
         0PteEM1heK5lEjTVhcSxOHfVWKa1BWdT2mxcbMMVpzKRqiOZKW7Wfhyi8ZgqqDQrRkXr
         UEmskaw7qH6oyyImdgPZpNjWqt4ysr1nHekFb/rQAPVERL7o+7uj+6cEnOlT+8u+wL+s
         kEunaZaNRMXJydH9sVUwnt5QIuau7bnIn4WPZy+gcNXtVxBwIQ5vB7jFEb6eg5OOtY9D
         rJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFq54d9QsTmv3rpdp/cy3tzjqHVefFyvdZXGzyRj2aA=;
        b=ldtfikKa7RgIQKxE3kL5l1aIx5RU1eVjWiUy1fLiVvuUcDXGZeyQyww+yZtGNEwu9O
         YqP+2c+zaS9JFv+8bwx5tcLKx/WAbtQs6CyCkNib8kWQcHA6pmTmV++SbgAzOGelOHBp
         aR/OlM1OwjvsvMrJYSSIC838FnY0e2eLm3D1lRL3zztINyhi+nK8sz0YAhq0h3knPMXe
         MUaYmcyyGdjkOv2XJ/+KI0El/y6EcxWRgv5f3DbC3xjR8VeeL/cwo38gee6wjmOEKerp
         743Ecdy584GJhtQXHUY9sf8XNWsA67NtFWtjVpRuNPbYqXH0XNjBju0xqnfZjUiU3hOU
         Ilmw==
X-Gm-Message-State: AOAM532tmt0bY1RVVs1tOmBZ6XVHyALTCkwpGQ3E5dfqUKeGB0wKaxQm
        x2FVoO3XN3lGy/zDpDDEirc=
X-Google-Smtp-Source: ABdhPJxL1oW6mn1pIrhyg621tFB+MjLEJFrBCVWCPsMq8ZMu/jnhFoEhMI+ze7ZGg4FrZi1NtBW2ig==
X-Received: by 2002:a05:6512:2291:: with SMTP id f17mr23098736lfu.466.1625738956685;
        Thu, 08 Jul 2021 03:09:16 -0700 (PDT)
Received: from localhost.localdomain ([94.103.225.155])
        by smtp.gmail.com with ESMTPSA id a24sm148372lfg.231.2021.07.08.03.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 03:09:16 -0700 (PDT)
Date:   Thu, 8 Jul 2021 13:09:10 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        ray.huang@amd.com, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: ttm: fix GPF in ttm_bo_release
Message-ID: <20210708130910.63a15c73@gmail.com>
In-Reply-To: <20210708113701.4cea7989@gmail.com>
References: <20210707185108.3798-1-paskripkin@gmail.com>
        <f4bb7b29-3abc-a056-fc24-4e91b5de8d74@amd.com>
        <20210708113701.4cea7989@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jul 2021 11:37:01 +0300
Pavel Skripkin <paskripkin@gmail.com> wrote:

> On Thu, 8 Jul 2021 08:49:48 +0200
> Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
>=20
> > Am 07.07.21 um 20:51 schrieb Pavel Skripkin:
> > > My local syzbot instance hit GPF in ttm_bo_release().
> > > Unfortunately, syzbot didn't produce a reproducer for this, but I
> > > found out possible scenario:
> > >
> > > drm_gem_vram_create()            <-- drm_gem_vram_object kzalloced
> > > 				     (bo embedded in this object)
> > >    ttm_bo_init()
> > >      ttm_bo_init_reserved()
> > >        ttm_resource_alloc()
> > >          man->func->alloc()       <-- allocation failure
> > >        ttm_bo_put()
> > > 	ttm_bo_release()
> > > 	  ttm_mem_io_free()      <-- bo->resource =3D=3D NULL passed
> > > 				     as second argument
> > > 	     *GPF*
> > >
> > > So, I've added check in ttm_bo_release() to avoid passing
> > > NULL as second argument to ttm_mem_io_free().
>=20
> Hi, Christian!
>=20
> Thank you for quick feedback :)
>=20
> >=20
> > There is another ocassion of this a bit down before we call=20
> > ttm_bo_move_to_lru_tail() apart from that good catch.
> >=20
>=20
> Did you mean, that ttm_bo_move_to_lru_tail() should have NULL check
> too? I checked it's realization, and, I think, NULL check is necessary
> there, since mem pointer is dereferenced w/o any checking
>=20
> > But I'm wondering if we should make the functions NULL save instead
> > of the external check.
> >=20
>=20
> I tried to find more possible scenarios of GPF in ttm_bo_release(),
> but I didn't find one. But, yes, moving NULL check inside
> ttm_mem_io_free() is more general approach and it will defend this
> function from GPFs in the future.
>=20
>=20
>=20
> With regards,
> Pavel Skripkin
>=20

I misclicked and sent this email to Christian privately :(

Added all thread participants back, sorry.



With regards,
Pavel Skripkin
