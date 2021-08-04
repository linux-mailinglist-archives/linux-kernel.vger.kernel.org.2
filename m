Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BFF3E04A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbhHDPrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbhHDPrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:47:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393D1C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 08:46:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h14so2754067wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J49YuwjHy2NOI3/UOq5v3ZkPSTtuAE8eHm0+63f8mt0=;
        b=KKCQHWgX85/6DkpOCs44CvbaGognlL5uAllvJp6ktA0cfVBb2a0VLnwQKQFEPMJSGt
         IjipCXmpd3p/rMnJU3NKfgXJYiI9so2/XFXEJe0cMMXp5zNxiUTtF1sDuts9Tiehmw9Y
         QvzEEfotIqIv3605wLYfTmRJgR2g55rCpxkxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=J49YuwjHy2NOI3/UOq5v3ZkPSTtuAE8eHm0+63f8mt0=;
        b=IuWs9KJJ8G43nEjtnx0d6GED7EmhhB2CkK7YmYIr04NCM2soVF67D3lwgEVxliOZi1
         rn2mqDhViB5WTsuBjsD7vZ1R8GQf4MUlIkZ1HEgSqD7gkRhnWQuVKOoBpR+7KXpLzQ2g
         tR3kyTWeUz4Jlaq3oq4spIh9wz+svArvPbMjVBQHH/3WBHY/uTOBK/lw7HjORNcBx5vO
         obkHA4ZEf1qh6AuvqLzKnnIGbKHFk1+kHQF+/WYAWolXgZ38XYo97cZpj4MB0QaqAZp8
         G3dMC2mzLKEP85za/cMQ0hMTSjpZEAE2z3jDtZLEnQxDb5/sqmgG4oWEwTGbTsn70QNo
         VZ2A==
X-Gm-Message-State: AOAM531N/nDfXIKPUtlDzXzIC5WiPLNUbfWTmdvL09F5dftBK6TMdst7
        7XGnorFts+s/adohK5wBISRHjA==
X-Google-Smtp-Source: ABdhPJzFNOQREtlSZqHizztAPtbXsy+1Xtqkjpp3JnfkEup7uznIjBJWXvQVSfLGYMfdqxnxjiISOg==
X-Received: by 2002:a5d:59ab:: with SMTP id p11mr30422wrr.238.1628092009803;
        Wed, 04 Aug 2021 08:46:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p15sm2638112wmi.29.2021.08.04.08.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:46:48 -0700 (PDT)
Date:   Wed, 4 Aug 2021 17:46:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Zhenneng Li <lizhenneng@kylinos.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/radeon: Update pitch for page flip
Message-ID: <YQq2YAi4w79JNO4H@phenom.ffwll.local>
Mail-Followup-To: Alex Deucher <alexdeucher@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Zhenneng Li <lizhenneng@kylinos.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210802074310.1526526-1-lizhenneng@kylinos.cn>
 <e6e77cfb-4e6b-c30e-ae7c-ac84b82c9a75@amd.com>
 <YQetXMaASz/F2EyS@phenom.ffwll.local>
 <CADnq5_PDtEn1y5HJBRHXw8o11LVwSRDKNtQgZtN5u0CW5ZspnQ@mail.gmail.com>
 <6a34fcc3-0aa3-85ff-21c4-86b9b5a48fd5@daenzer.net>
 <CADnq5_MJ=m2_VvzCQ7wJaFx2=OfFfLpoJtc_Ofb+a-v3eujtXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_MJ=m2_VvzCQ7wJaFx2=OfFfLpoJtc_Ofb+a-v3eujtXg@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 10:49:39AM -0400, Alex Deucher wrote:
> On Tue, Aug 3, 2021 at 4:34 AM Michel Dänzer <michel@daenzer.net> wrote:
> >
> > On 2021-08-02 4:51 p.m., Alex Deucher wrote:
> > > On Mon, Aug 2, 2021 at 4:31 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >>
> > >> On Mon, Aug 02, 2021 at 10:12:47AM +0200, Christian König wrote:
> > >>> Am 02.08.21 um 09:43 schrieb Zhenneng Li:
> > >>>> When primary bo is updated, crtc's pitch may
> > >>>> have not been updated, this will lead to show
> > >>>> disorder content when user changes display mode,
> > >>>> we update crtc's pitch in page flip to avoid
> > >>>> this bug.
> > >>>> This refers to amdgpu's pageflip.
> > >>>
> > >>> Alex is the expert to ask about that code, but I'm not sure if that is
> > >>> really correct for the old hardware.
> > >>>
> > >>> As far as I know the crtc's pitch should not change during a page flip, but
> > >>> only during a full mode set.
> > >>>
> > >>> So could you elaborate a bit more how you trigger this?
> > >>
> > >> legacy page_flip ioctl only verifies that the fb->format stays the same.
> > >> It doesn't check anything else (afair never has), this is all up to
> > >> drivers to verify.
> > >>
> > >> Personally I'd say add a check to reject this, since testing this and
> > >> making sure it really works everywhere is probably a bit much on this old
> > >> hw.
> > >
> > > If just the pitch changed, that probably wouldn't be much of a
> > > problem, but if the pitch is changing, that probably implies other
> > > stuff has changed as well and we'll just be chasing changes.  I agree
> > > it would be best to just reject anything other than updating the
> > > scanout address.
> >
> > FWIW, that means page flipping cannot be used in some cases which work fine by changing the pitch, which can result in tearing: https://gitlab.freedesktop.org/xorg/xserver/-/issues/839 (which says the i915 driver handles this as well).
> >
> 
> Ok.  In that case, @Zhenneng can you update all of the pitch in all of
> the page_flip functions in radeon rather than just the evergreen one?

atomic drivers handle this fairly ok-ish, since we have a proper
atomic_check there.

For legacy kms I just wouldn't bother, too many corners to validate. But
also if you're bored, just do it :-)
-Daniel

> 
> Thanks,
> 
> Alex
> 
> 
> >
> > --
> > Earthling Michel Dänzer               |               https://redhat.com
> > Libre software enthusiast             |             Mesa and X developer

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
