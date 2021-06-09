Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0022B3A18CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbhFIPOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232797AbhFIPOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623251569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JMREyP3JXMVmWCr80yCkQOP9jgymsdlFzzgGHyBeU4U=;
        b=PiFpJWNzcfPlb6Ztb03KskTMy0f4Mb5SsjGNgPKQPKzab7gyE9cmKMBER9xZY/PItr/X9o
        SOGs69seWhQgZrQB/Ub7eGP9CR0/CzqsGUffzGizSMPrbAk/gdYx+FA8g2FqaaylWtiV2V
        h7UeqDtOSuI1oiYAW/sARZVLNwgKaZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-JWnM8Q3CPlmlbZ446t6wvA-1; Wed, 09 Jun 2021 11:12:47 -0400
X-MC-Unique: JWnM8Q3CPlmlbZ446t6wvA-1
Received: by mail-wr1-f69.google.com with SMTP id e11-20020a056000178bb0290119c11bd29eso6043445wrg.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 08:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JMREyP3JXMVmWCr80yCkQOP9jgymsdlFzzgGHyBeU4U=;
        b=TgEk3dO33/2Kcl7I0iub2PYkuBXJ+gzQVQFdzNtvVqfwIQsskLTrByN75967MreL/g
         8psEouCrDw5nUrO0L8YL7DFYKrn2BujgCoK4bhodGxEvOGH7GnI0JhHkTy65VyWAv44f
         51scZKGQO3orEXltxsFY86ho7MxlLT50a5hv8wGLisz0PZhoONJsicgwsXvSQX08IxsU
         Ug9MtgXqmA/K7v3ed5wMwyHzpyOXimUbVVbG09k8c3WQDPZ2J27pwRxY2by3an0OSN6+
         zHsXF6ZLHDM5maf5NzSozYbhHp05rriZMD5pNM2+wA4EJpMecEXBFgK8F41Dwa4/6jZF
         k6qA==
X-Gm-Message-State: AOAM532uDULqUAyRjDTOlntTbo95OSi/asu9c5dAkle6JxDtACQZ3i4n
        mz3kS6WZt/Qr5HsaMTsjWkrJa59Kj3sls2RzW3vMWlRodUesKbK1/zIrkVkKKejRCuyJ/tVK0lb
        ec4m81DheTkBQpphu9MPM5ruLp2FjvGD9JweHPTHO
X-Received: by 2002:a05:600c:4f90:: with SMTP id n16mr10279289wmq.139.1623251566859;
        Wed, 09 Jun 2021 08:12:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzP/57SvqEpC29EXzMW7a0xJ2z47/4rc95Texc/KFmFmXC3s2mnwQ6QJRK6ZzJBeVqEs4vPqneIDdp2sjzuc/U=
X-Received: by 2002:a05:600c:4f90:: with SMTP id n16mr10279268wmq.139.1623251566705;
 Wed, 09 Jun 2021 08:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210531031029.4642-1-alyssa@rosenzweig.io>
In-Reply-To: <20210531031029.4642-1-alyssa@rosenzweig.io>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 9 Jun 2021 17:12:36 +0200
Message-ID: <CACO55tuo=pJMOc3NRbucs=+Tm7afU9kEsYqxfSDaY=NctuifTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] documentation: Update #nouveau IRC channel network
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 5:11 AM Alyssa Rosenzweig <alyssa@rosenzweig.io> wrote:
>
> Like many free software projects, Nouveau recently moved from Freenode
> to OFTC. Update the reference.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: linux-kernel@vger.kernel.org
> ---
>  Documentation/driver-api/thermal/nouveau_thermal.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/thermal/nouveau_thermal.rst b/Documentation/driver-api/thermal/nouveau_thermal.rst
> index 79ece266c..aa10db6df 100644
> --- a/Documentation/driver-api/thermal/nouveau_thermal.rst
> +++ b/Documentation/driver-api/thermal/nouveau_thermal.rst
> @@ -90,7 +90,7 @@ Bug reports
>  -----------
>
>  Thermal management on Nouveau is new and may not work on all cards. If you have
> -inquiries, please ping mupuf on IRC (#nouveau, freenode).
> +inquiries, please ping mupuf on IRC (#nouveau, OFTC).
>
>  Bug reports should be filled on Freedesktop's bug tracker. Please follow
>  https://nouveau.freedesktop.org/wiki/Bugs
> --
> 2.30.2
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

