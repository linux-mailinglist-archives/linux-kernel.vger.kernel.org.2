Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D0144498B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 21:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhKCUcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 16:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhKCUcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 16:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635971385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYXXoD382YlaWwsm8RhT98RSUt90ubtt9LhxFyoOKpU=;
        b=cyNW4nD3fhti6826rsf2rj3CV5+epoHGaqygHe35ygc1ENyCqYSemAtRr7Ix/VE4ZFO4L8
        8XITgizKKcddIAt2+CtI+h0bgQpziK7raIa5wpG/OM5f/gyvLU2n3ksAAtjJZ/ltJU8bvl
        /AuIFpbLBhGZdSxAk4GwqTLMtdZGcEg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-XG8mA5tiNpGrEjQibebCiA-1; Wed, 03 Nov 2021 16:29:42 -0400
X-MC-Unique: XG8mA5tiNpGrEjQibebCiA-1
Received: by mail-wm1-f70.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso1604291wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 13:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JYXXoD382YlaWwsm8RhT98RSUt90ubtt9LhxFyoOKpU=;
        b=qYAIEmFXZIMYoQL+ke83pHcQR0mnzMGqChmghmHtp0Nn/0JfZgUtiQyQAC6/eYyOTO
         X3JzfdH+/aA9TMRs4l1F5kaecPvsU9IxdxxVdY6/xiaiceqskJM3qHURO8MqdeInWxdq
         PMaexc2DyUiyFtgbk9VjhPf13BR5M8mOFBg0ElT+P6nrxzbQETnW4CG+R/No1dTVDgwA
         gTN5ZlggbTV4tW+vqs1c5Web1OI9I/ztgnlFLK+LQcK1H3wLzH3BmFQ69WLRFjUIxxR/
         sPxcdj5BYkGZNVNKh7oINTem2wYqHnB2gFfKGOtBLqiMFuhVgU0cPuomKOr0NchG3vvG
         9nkQ==
X-Gm-Message-State: AOAM530p+Emkc5Y6+jAtUEhGjqVRPi3rstvqd3h1569XJ6EruOvYVoDc
        WGGQAHSvqG0YKLQGkMR7FNucI21vYLViI53Wu3LAs3RA7DuDM7ijkKm8yegO7514CqFLqLF4Jyt
        QcyyaVa2bpzwi+63VmbAT04JW7k7DON0+CN4cDzDI
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr42336873wrw.116.1635971380582;
        Wed, 03 Nov 2021 13:29:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfxtpdZAb0gL1AyUceKUTqCM9ysy/gh/RGCREHQblh5YqhTwn/yGQ6pNsAfrWkscr3Mxm3+yr4U09BDGEkSO4=
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr42336850wrw.116.1635971380397;
 Wed, 03 Nov 2021 13:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211101082511.254155853@linuxfoundation.org> <20211101082518.624936309@linuxfoundation.org>
 <871r3x2f0y.fsf@turtle.gmx.de>
In-Reply-To: <871r3x2f0y.fsf@turtle.gmx.de>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 3 Nov 2021 21:29:29 +0100
Message-ID: <CACO55tsq6DOZnyCZrg+N3m_hseJfN_6+YhjDyxVBAGq9PFJmGA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 5.10 32/77] drm/ttm: fix memleak in ttm_transfered_destroy
To:     Sven Joachim <svenjoac@gmx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Erhard F." <erhard_f@mailbox.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Huang Rui <ray.huang@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 8:52 PM Sven Joachim <svenjoac@gmx.de> wrote:
>
> On 2021-11-01 10:17 +0100, Greg Kroah-Hartman wrote:
>
> > From: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> > commit 0db55f9a1bafbe3dac750ea669de9134922389b5 upstream.
> >
> > We need to cleanup the fences for ghost objects as well.
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Reported-by: Erhard F. <erhard_f@mailbox.org>
> > Tested-by: Erhard F. <erhard_f@mailbox.org>
> > Reviewed-by: Huang Rui <ray.huang@amd.com>
> > Bug: https://bugzilla.kernel.org/show_bug.cgi?id=3D214029
> > Bug: https://bugzilla.kernel.org/show_bug.cgi?id=3D214447
> > CC: <stable@vger.kernel.org>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20211020173211.2247=
-1-christian.koenig@amd.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/gpu/drm/ttm/ttm_bo_util.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > @@ -322,6 +322,7 @@ static void ttm_transfered_destroy(struc
> >       struct ttm_transfer_obj *fbo;
> >
> >       fbo =3D container_of(bo, struct ttm_transfer_obj, base);
> > +     dma_resv_fini(&fbo->base.base._resv);
> >       ttm_bo_put(fbo->bo);
> >       kfree(fbo);
> >  }
>
> Alas, this innocuous looking commit causes one of my systems to lock up
> as soon as run startx.  This happens with the nouveau driver, two other
> systems with radeon and intel graphics are not affected.  Also I only
> noticed it in 5.10.77.  Kernels 5.15 and 5.14.16 are not affected, and I
> do not use 5.4 anymore.
>
> I am not familiar with nouveau's ttm management and what has changed
> there between 5.10 and 5.14, but maybe one of their developers can shed
> a light on this.
>
> Cheers,
>        Sven
>

could be related to 265ec0dd1a0d18f4114f62c0d4a794bb4e729bc1

