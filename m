Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A3B3418E5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCSJzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229885AbhCSJzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616147735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJ5ef4kdkKqYO2ysDRmL0Xx+1wY0nM5hZWCNcGD9eXA=;
        b=IjQdcrnScqKzhzsgRN8R0wwMt+A5veC97F8u//3Jr9Tqe/lNdhlV3eC47CuWyHyOAixI8Q
        ZJafitpTBiDSugbLfO+bxNcuONNOVuxv3y/lMaytq88DWqdFWjHOoW95Zs40Dvjl8guobM
        47fNUaVmB3cBqQyRqOgEPy3WitfHyA4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-m0Jefpd8McSrjLqy5z5NtQ-1; Fri, 19 Mar 2021 05:55:32 -0400
X-MC-Unique: m0Jefpd8McSrjLqy5z5NtQ-1
Received: by mail-wr1-f69.google.com with SMTP id o11so5551503wrc.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJ5ef4kdkKqYO2ysDRmL0Xx+1wY0nM5hZWCNcGD9eXA=;
        b=RfWtrvAyYGF0GTW4wtE2lM29ghsvXiuvxQaqsohO8uDHnXNEBUT2OIUcQYJ9BRwHP/
         vS+ucvBidzWFWUudsKWn7taryGdNsouYhL/BWTBPtUDsUjRpREz3U0jj8bzm8Fw58fPZ
         secORWVm+j0OmrOmCs5xXX/t8C0ZpboQP5KR7H1DjWRmEs12VvKLjxwo7if63KdP0RCu
         wz0vvBsHPZMkrjYOiiAHvaqdFOaoVs9POkKSNiR2QSGgRkxSI+Xdl+Wq+6HKXXGwufD1
         An4wMXqVRFyvaQ0XbKw2Rf5z0VTPPBJZgS4T0en86NV70VG+6zhspzeYgv5WtQBqCVx3
         GPcg==
X-Gm-Message-State: AOAM533Z+m+UPOGYfTbQg1VWi4vJ2X/mejR9KYT6/mJujyfo3It4AaK1
        eayTi0/3zBZFBiYq6lowTk1+9EPKP5L3aV30umkzZpwe91994wo6Fi5RSA8Mok+dXNs5hRZXEBX
        qEhd+nIoEN8ZMLYgw1JIBF0rtiToJITfqrdVWleAw
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr3485710wrw.415.1616147731754;
        Fri, 19 Mar 2021 02:55:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeKPGrxBdpMmRWCOYaxf2YjC/UlnsVRPHxzh1erEAYqUTci6IHJuCkogRSQOq5aAaeWZ1tnsOMjF8dIXRf1qk=
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr3485702wrw.415.1616147731642;
 Fri, 19 Mar 2021 02:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210319082428.3294591-1-lee.jones@linaro.org> <20210319082428.3294591-10-lee.jones@linaro.org>
In-Reply-To: <20210319082428.3294591-10-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 19 Mar 2021 10:55:21 +0100
Message-ID: <CACO55ts6Hmh07fib-QBB8nVxrVcfK-s2b-5MBaemxWJMJ=oyAw@mail.gmail.com>
Subject: Re: [PATCH 09/19] drm/nouveau/nvkm/engine/gr/gf100: Demote
 non-conformant kernel-doc header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 9:25 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:992: warning: Function parameter or member 'gr' not described in 'gf100_gr_wait_idle'
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> index 397ff4fe9df89..69e6008f99196 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> @@ -982,7 +982,7 @@ gf100_gr_zbc_init(struct gf100_gr *gr)
>         }
>  }
>
> -/**
> +/*
>   * Wait until GR goes idle. GR is considered idle if it is disabled by the
>   * MC (0x200) register, or GR is not busy and a context switch is not in
>   * progress.
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

