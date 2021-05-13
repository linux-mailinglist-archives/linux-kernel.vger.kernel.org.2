Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84BF37F4E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhEMJjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhEMJjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:39:05 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF989C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 02:37:55 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id v191so21167994pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UK11emBimp2j7VDS60FsY4XS6s+jsxh4WvF3e9ihaL0=;
        b=bTRL8PCmF1zR+sOAQgqj+65KCF99UaaO10WnRQXi2xNSucbyVk/3mRz9uG+L2YRtVv
         LHuyA7VFIQliVXsbwO8bOL/7fGYT3CLiaJm3UdVP1HvocOzEvOq0zxj8kHcl7ja9F7JO
         VX2EUG4hJvxb+FmB7C4uE6+yMhksBTi8vffUlN671xOj32qP8QfeqbSJU03p8X/xha3t
         qv0b2k3WGLlonfaXW+Vn0b0R3K/cvjWYp42KUOUGr3+tq3tOqGaDo8BIS+39l4CASwI8
         35dcPI4y1oyV5X9k5fx8dTmFJia9+vzRMoCB8AiaxiGcrblmxge4Dxktm/KhihUJFyIR
         /nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UK11emBimp2j7VDS60FsY4XS6s+jsxh4WvF3e9ihaL0=;
        b=P08D0njXGh59c0OV6x71mobljZLCH/y+4YUw3o1/gmWFt+zzXP80n1ReG0+20DZ5eE
         gDO+XGUbI2LFYZkEW8MX0f1ERhb18eFugvvHCG1hIRy+bIboZ67wllO+WYBUJqGEV0Ex
         LJGHnyXN99UF7mrpW/rUtACwmAW0HE1NtnaaOu/0HOAhWKcdLC2ib8vDjcSDtFvDvkRt
         oF3JnCLxWVrUqf0w7wba/VRqXn4G9WOjxIHX+lvpWXdK70c2tX7V+Z1DRvkcBjvUByyf
         CfbHgCV6cqBJROuwFqL5G4KMy4z/xJVc0vWwuywhaJl9ozJJrQV86qjuMrok/c30bqMo
         fs1A==
X-Gm-Message-State: AOAM532Bh1hZ+a47GU80W/hGgHD8a/1p5Z8HIwZNe6oWduqPQmdJB4ls
        IkNOSmQnPSKRY4SJ9Uz/Ab/VKNsU2pvtleoBDsVy67Z5khKaYA==
X-Google-Smtp-Source: ABdhPJz6233+qvlYevbBcOMreUeHzbiOcEVuTVvkHGYYiFVy60jPOfm7ZdHmJZFKMTy6MQsiTJK3LNJ0qGw62R6i75o=
X-Received: by 2002:a62:8389:0:b029:27d:28f4:d583 with SMTP id
 h131-20020a6283890000b029027d28f4d583mr40172120pfe.33.1620898675232; Thu, 13
 May 2021 02:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210513051920.29320-1-rdunlap@infradead.org>
In-Reply-To: <20210513051920.29320-1-rdunlap@infradead.org>
From:   Oliver Glitta <glittao@gmail.com>
Date:   Thu, 13 May 2021 11:37:44 +0200
Message-ID: <CAD=R=qomoJW5jLNPWieKSCU1W=hM2dp2p1TJ-6a_DJhYmNaWQA@mail.gmail.com>
Subject: Re: [PATCH -mm] slub: STACKDEPOT: rename save_stack_trace()
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=A1t 13. 5. 2021 o 7:19 Randy Dunlap <rdunlap@infradead.org> nap=C3=ADsa=
l(a):
>
> save_stack_trace() already exists, so change the one in
> CONFIG_STACKDEPOT to be save_stack_depot_trace().
>
> Fixes this build error:
>
> ../mm/slub.c:607:29: error: conflicting types for =E2=80=98save_stack_tra=
ce=E2=80=99
>  static depot_stack_handle_t save_stack_trace(gfp_t flags)
>                              ^~~~~~~~~~~~~~~~
> In file included from ../include/linux/page_ext.h:6:0,
>                  from ../include/linux/mm.h:25,
>                  from ../mm/slub.c:13:
> ../include/linux/stacktrace.h:86:13: note: previous declaration of =E2=80=
=98save_stack_trace=E2=80=99 was here
>  extern void save_stack_trace(struct stack_trace *trace);
>              ^~~~~~~~~~~~~~~~
>
> from this patch in mmotm:
>   Subject: mm/slub: use stackdepot to save stack trace in objects
>
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Oliver Glitta <glittao@gmail.com>

I run it with CONFIG_ARCH_STACKWALK set on, so it didn't show this error.
Thank you for your fix.

> Cc: Oliver Glitta <glittao@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> ---
>  mm/slub.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- mmotm-2021-0512-2146.orig/mm/slub.c
> +++ mmotm-2021-0512-2146/mm/slub.c
> @@ -604,7 +604,7 @@ static struct track *get_track(struct km
>  }
>
>  #ifdef CONFIG_STACKDEPOT
> -static depot_stack_handle_t save_stack_trace(gfp_t flags)
> +static depot_stack_handle_t save_stack_depot_trace(gfp_t flags)
>  {
>         unsigned long entries[TRACK_ADDRS_COUNT];
>         depot_stack_handle_t handle;
> @@ -623,7 +623,7 @@ static void set_track(struct kmem_cache
>
>         if (addr) {
>  #ifdef CONFIG_STACKDEPOT
> -               p->handle =3D save_stack_trace(GFP_KERNEL);
> +               p->handle =3D save_stack_depot_trace(GFP_KERNEL);
>  #endif
>                 p->addr =3D addr;
>                 p->cpu =3D smp_processor_id();
