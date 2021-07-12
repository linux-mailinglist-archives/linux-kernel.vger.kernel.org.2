Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294F63C605E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhGLQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhGLQZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:25:42 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F594C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 09:22:53 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id a6so18525111qka.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=91K9fVSqD7weIFhTBGPdZoWmFd1uNebYt0kdpf0Fcos=;
        b=mAtOy7kE1GoHX/dACCRPGowBhQ2PDL92s+EWROICJxR3udof3FZESHfyA3/PE2G4n/
         XSVfAVk1ljdFgMDpOs6ma4ZCqxaxBWSV1NlIFMx/zUCnY+Ql3nH2TUEenHIiY/2wa7CP
         tNtWvyjHfuvbfA3TldA2uhTQA7GtjPhPCNNI2VCwfQoy/HrfZ0eIGBNmekc/A5/8eBsB
         Ot3gIT8MBh1IQP2eEnPBtIvmZy0Mk1I5aSAqt+/R/EA1DNRzg9vwcqwwDmv7v/UbHLGm
         Cxeow6v1yOzZQ93AjWLI0iT2YL6Dt4u5eTKMiI25QVLCqxhfz1hJhX9/cOug5S/f2CZL
         7Fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=91K9fVSqD7weIFhTBGPdZoWmFd1uNebYt0kdpf0Fcos=;
        b=N+7XMcFuqoUnvsiWDE30PpbF0OFmPyC3urohyJI20mzF3FbntjHju7CVJFmZIj2Yxl
         pJc6e7NQ8GmTBsaCxxftQkA56Ukj+u0V9oFtSOgKtReFRVsHPxpmVxNipGVx+3E9uZ7C
         xPe58n8aipJ+t5C8AfKIgnnhZpAg2RrfvktUsmTztcrt1gNu8WR+6ORc33tYzfZK+UKd
         Js5EeO5zhpwg4kUpIxEq65nmdhZw0ZW7//aRAH290h/+GgP6TwYIL73pocqAPJnKnw4X
         GitkeFlxbHXkwqVi4bveIpGnHYTuw+inH3DG4NCNPCFBqpmEFcacaHDBYKyHY/NMn4Cj
         iehQ==
X-Gm-Message-State: AOAM530VDr6UWEGAiItFegSPQRSES8PDEyEgKHg6ouP+zVJtaLIDQWYN
        EZCXDpm4ZX3TktUvsl71n2+8nO6NTWZAOSzj02I=
X-Google-Smtp-Source: ABdhPJxEJ9vdrHgKV2C5yvulxCqCUUQ8ONuFDpIzr6wLyzuk6Zq5sB/ptc+kXP8Vdfcg2aDm9ppAMVXR4J18HIWNqE0=
X-Received: by 2002:a37:9e07:: with SMTP id h7mr28939942qke.481.1626106972262;
 Mon, 12 Jul 2021 09:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <161dac7a-5aad-150e-7c14-7bb195ecf30f@canonical.com>
In-Reply-To: <161dac7a-5aad-150e-7c14-7bb195ecf30f@canonical.com>
From:   Matthew Auld <matthew.william.auld@gmail.com>
Date:   Mon, 12 Jul 2021 17:22:23 +0100
Message-ID: <CAM0jSHMO052Tcr_EMKDioOedHuX-foxz7_ejRVSLZuK8j+j9tA@mail.gmail.com>
Subject: Re: drm/i915/ttm Initialize the ttm device and memory managers
To:     Colin Ian King <colin.king@canonical.com>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2021 at 16:17, Colin Ian King <colin.king@canonical.com> wro=
te:
>
> Hi,
>
> Static analysis with Coverity on linux-next has found a potential issue
> in drivers/gpu/drm/i915/selftests/intel_memory_region.c in function
> igt_mock_fill - the problematic commit is as follows:
>
> commit d148738923fdb5077089e48ec15555e6008100d0
> Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Date:   Wed Jun 2 10:38:08 2021 +0200
>
>     drm/i915/ttm Initialize the ttm device and memory managers
>
> The analysis is as follows:
>
>
>  49 static int igt_mock_fill(void *arg)
>  50 {
>  51        struct intel_memory_region *mem =3D arg;
>  52        resource_size_t total =3D resource_size(&mem->region);
>  53        resource_size_t page_size;
>  54        resource_size_t rem;
>  55        unsigned long max_pages;
>  56        unsigned long page_num;
>  57        LIST_HEAD(objects);
>  58        int err =3D 0;
>  59
>  60        page_size =3D mem->chunk_size;
>  61        rem =3D total;
>  62 retry:
>
> value_overwrite: Overwriting previous write to max_pages with value from
> div64_u64(rem, page_size).
>
>  63        max_pages =3D div64_u64(rem, page_size);
>  64
>  65        for_each_prime_number_from(page_num, 1, max_pages) {
>  66                resource_size_t size =3D page_num * page_size;
>  67                struct drm_i915_gem_object *obj;
>  68
>  69                obj =3D i915_gem_object_create_region(mem, size, 0);
>  70                if (IS_ERR(obj)) {
>  71                        err =3D PTR_ERR(obj);
>  72                        break;
>  73                }
>  74
>  75                err =3D i915_gem_object_pin_pages_unlocked(obj);
>  76                if (err) {
>  77                        i915_gem_object_put(obj);
>  78                        break;
>  79                }
>  80
>  81                list_add(&obj->st_link, &objects);
>  82                rem -=3D size;
>  83        }
>  84
>  85        if (err =3D=3D -ENOMEM)
>  86                err =3D 0;
>  87        if (err =3D=3D -ENXIO) {
>  88                if (page_num * page_size <=3D rem) {
>  89                        if (mem->is_range_manager && max_pages > 1) {
>
> Unused value (UNUSED_VALUE)
> assigned_value: Assigning value from max_pages >> 1 to max_pages here,
> but that stored value is overwritten before it can be used.

Yeah, that doesn't look good.

AFAIK this should be fixed with d53ec322dc7d ("drm/i915/ttm: switch
over to ttm_buddy_man"), which is in drm-tip, but I guess has not made
its way over to linux-next yet.

Thanks for the report.

>
>  90                                max_pages >>=3D 1;
>  91                                goto retry;
>  92                        }
>  93
>
> The right shift to max_pages on line 90 is being overwritten on line 64
> on the retry.
>
> Colin
