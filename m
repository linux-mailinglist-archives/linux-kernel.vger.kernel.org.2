Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F0C340F04
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhCRUZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRUZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:25:35 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAFDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:25:35 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a11so5130624qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=4zDsIYOprog9B5y3rsUfED+L5wmiaQe7RHCQ6tBNZZ8=;
        b=l1jZXZhJnbHk/Wwj5LUfWeHHf0DsSlc2S/WOkB+XLmMY6hdLdL+m8NaTtl9g+dHJfk
         75seqGteupipnSIxVNSsg2h50hXYGJujoE51lkYPIntTapcp66qruTYST8JXpjUBb7gB
         eh9c7CZ+QAWeFkJfvbofIxhOyhXOPXwIHtmcDOOaldFrvj/6nZcQ5l22keEMoLvtfWJn
         E+ZUr2nLZB0grnAHkstVJjaiUF/LsCcwMAiSYZB2lwYeLVib60DnEh0hGSKGIkkp+f0A
         mwxhZML61fx+/d+F1Rw8BeAcPXRE36sPfo1VoTVadvENNHVhZP2APiiAJmdMFZXz1fLD
         wmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4zDsIYOprog9B5y3rsUfED+L5wmiaQe7RHCQ6tBNZZ8=;
        b=RpegJkVCsh5bCJRUTbj3igLXYBPBP9nF5f+anfYlu/7YMQ+OwCFtb83MKBN9wdRYcv
         8IzKM2gy+8dXyep8agZxpVn3aceknojThsdXZ5bMc46NGl6XcOVoRXx79fyddPrlPyHS
         2gU/1O6ubw3a8KYiQvpIBNhlJ6VPonDfXYLd+x0QFkiFVMS/1m2uOaMCvUSgAYFuEO4i
         YDlmEtaAirxNp/eeplm5Wd+VZQOmZ+w2lIHtfzDqAuaxMjDRkKsPwBz3dnMwBHBsaop7
         2YdM1ECFjHOSwH7x5QJlaLUK3R00L7eI5MaERKYuHX25eMdjr4j4Lwb12HCVFbDQczPb
         sGhw==
X-Gm-Message-State: AOAM530o+32J2nJDs6ZzE5k5uCPrHXjwlXUImhgNkbapvglwB5KH2bMm
        WYQQxcJbBi7mg2/viNJ4basER//5LBeomnnr
X-Google-Smtp-Source: ABdhPJy60341IL5RWjf5A6iwP0gHji6vmLyFby3B/GlwxwH3tTQoRECSPYLm0elA8Vvxk0A8+4rxUg==
X-Received: by 2002:ac8:4288:: with SMTP id o8mr5398682qtl.28.1616099134481;
        Thu, 18 Mar 2021 13:25:34 -0700 (PDT)
Received: from Gentoo ([37.19.198.63])
        by smtp.gmail.com with ESMTPSA id o23sm2225968qtm.31.2021.03.18.13.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:25:33 -0700 (PDT)
Date:   Fri, 19 Mar 2021 01:55:21 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <John.Clements@amd.com>,
        "Chen, Guchun" <guchun.chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Jiansong Chen <Jiansong.Chen@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: Fix a typo
Message-ID: <YFO3MYXwWbXwTgUh@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <John.Clements@amd.com>,
        "Chen, Guchun" <guchun.chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Jiansong Chen <Jiansong.Chen@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210318113308.1345-1-unixbhaskar@gmail.com>
 <b09b524c-1f3d-6231-29b9-f0eac3e77293@infradead.org>
 <CADnq5_OsrHGxmXeuEiV06qas7jJ0pvExqdrw-PmqpKvWi=0jOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+2goaO1049LHQE3k"
Content-Disposition: inline
In-Reply-To: <CADnq5_OsrHGxmXeuEiV06qas7jJ0pvExqdrw-PmqpKvWi=0jOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+2goaO1049LHQE3k
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:12 Thu 18 Mar 2021, Alex Deucher wrote:
>On Thu, Mar 18, 2021 at 2:08 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 3/18/21 4:33 AM, Bhaskar Chowdhury wrote:
>> >
>> > s/traing/training/
>> >
>> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> > ---
>> >  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> > index c325d6f53a71..db18e4f6cf5f 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> > @@ -661,7 +661,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>> >
>> >       if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
>> >               /*
>> > -              * Long traing will encroach certain mount of bottom VRAM,
>> > +              * Long training will encroach certain mount of bottom VRAM,
>>
>>                                                        amount
>> I think.
>
>Yeah, I think it should read something like:
>
>Long training will encroach a certain amount on the bottom of VRAM;
>save the content from the bottom VRAM to system memory
>before training, and restore it after training to avoid
>VRAM corruption.
>
>Alex
>
>>
>> >                * saving the content of this bottom VRAM to system memory
>> >                * before training, and restoring it after training to avoid
>> >                * VRAM corruption.

Thanks.

>> > --
>> > 2.26.2
>> >
>>
>>
>> --
>> ~Randy
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--+2goaO1049LHQE3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBTtzEACgkQsjqdtxFL
KRWHLwf/VSZrbhSYrWqEci3El3RuohOKQEWAKRxH+FBbFypej1MzZn8MFVI0gjwm
Iw/qmk2zZcGiSrJR1BXSOFA4audev1Iy0x5I91rju+AZASDVWNk2CZHOZOIuR9GL
VC3MbDxIGZK/pcVAOOpqjXvvUZoToKQQvwcr2DzSpFnZ7rE3ULbrpopfWBfpS5rv
Giu5Arlad9IVrqZ/Kp0Hksiv8xRUL3y/+WbSDa9vsyj/hKMm2HrqJvISxFN7UDnX
sPd/5X+41RtOD2Q9PWY03gBfQshTXEkTZnNk5/bxoRecydv1XA1OXGMMTNdkKDzx
kwE39qzDORe0xeFLJv+gBIiQW73cvw==
=xiDw
-----END PGP SIGNATURE-----

--+2goaO1049LHQE3k--
