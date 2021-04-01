Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ECD352143
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhDAVDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhDAVDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:03:31 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9D3C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:03:31 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id g8so1702364qvx.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ax0IM2LjBIVWt1ct8ruLFlZgjpZSUGTOxnEHCgkHEFA=;
        b=V4FBSC5D+IX7wIxnmQdF5s+3q/t91ZYD12hB0873yrZPetSbNe7XLgvcnJ0/+IWOzb
         56CnDJpEueg8lfQrunvjOaOieDsTNIqSXt0itCPsjpHyHRq4hiGmcCzfcLFKbq4cpE4F
         F6Jv2e5LULq+CPa/mSYEbWry9WF7M8H5GkHzB5tnIIYRxIFd7nsIP/i0YKAtQkCt4uRn
         9jQtb+0nTFwGLdo9QjA/zFFo4xXIIOkwDsYrkZ1H+VZeOr766xIVG2guVeoVSXdFeHBK
         165K/4CvDnLY+QpwrwBpcnZ6OhSZNY9BcQC5MnOARhRnwikgYUWH2m8cMoIvAfEsdK3W
         Qt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ax0IM2LjBIVWt1ct8ruLFlZgjpZSUGTOxnEHCgkHEFA=;
        b=V70He+/1O827+h663XHz8s9ragPtKhcBqfmqP8bezg5LwCZlvsYle1qoGszPwLXqyd
         eTlRznHextXvghK0S/ucFMYF6HyVRe+us02ydC3SmBcblR8JiTR86/q5BfDikjCeNWJ4
         s69j04aUTASdD80i/xbNndGabwpY8SUuiy+Lz9GzIaj32TP7PkbQu9WbKr+xlgleiR9+
         b/0X5pxJfqXhsRQ5wOd4YhrcC5autBzkMY8YEkBZ40Ixk6qyq1nJ+rOkWQPHT+YQQeiu
         pKcIV138apS7oFMj5jBh8hzH2+469KwhMBdoys5/q4s9AM/ieJ+E2kH9vRZPh5I57f8d
         w6dw==
X-Gm-Message-State: AOAM5321qLwIRjuwnIradqhQzAQTICM/+NICl6K5HDth7t9nq2nGtO0y
        m8txIlGt1D5bYmmbLI7bdSkTkBUtWMb96jQEsAQhwA==
X-Google-Smtp-Source: ABdhPJxk5Usvd87vSA9PsIRzQlCGAjpyjIFHMxoAFRIgRHtf6URu93P8J2Nppmkh17qIP6kc+a9GsBL2utYWsErqZd0=
X-Received: by 2002:a05:6214:1870:: with SMTP id eh16mr10024772qvb.23.1617311010984;
 Thu, 01 Apr 2021 14:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210216200909.19039-1-jonathan@marek.ca> <CAF6AEGv53nnzqMgTfSA6t2YpHx1dDW8UqnH9Gw0w3p8bf0mTLw@mail.gmail.com>
 <775436ba-c94a-ab22-d65b-b2391047ec65@codeaurora.org> <20210217190820.GA2229@jcrouse1-lnx.qualcomm.com>
 <CAF6AEGsHws23ozeJ8G23LFQ8J=CVVrx5xvkSgBuE_uSwT4YurQ@mail.gmail.com>
 <74d1277e-295f-0996-91c3-05cfce8d3a0e@marek.ca> <e4b62857-bd4d-cca6-0d6b-b9cc960b52a2@codeaurora.org>
 <CAF6AEGsWCrkOgMVxnx53k8b_o7xy3KWv9VaNRoY44+4GfXtWdg@mail.gmail.com>
 <757b557a-b5f6-6018-caa4-34bffb1b60b7@codeaurora.org> <CAF6AEGv-A5=4z7ZO-SytmivZTfKPYxhAjmRLVsQnrT7_pYCDtQ@mail.gmail.com>
 <0f057c99-ec94-f3e3-796f-b73a609f735d@codeaurora.org> <CAF6AEGvXYmcj0YuciZATveALJEP6DdFiwmtnYevrK2SEOJNZGg@mail.gmail.com>
 <CAF6AEGs4sYOMgysg3FraKTDetqKTgMXT6RE700e-8uyE9Gs-9A@mail.gmail.com>
In-Reply-To: <CAF6AEGs4sYOMgysg3FraKTDetqKTgMXT6RE700e-8uyE9Gs-9A@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 2 Apr 2021 00:03:19 +0300
Message-ID: <CAA8EJpoL7Eox5WqnZQVvGF9M_4itA+2=U6QX=AreTk=AEfqyQg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: fix for kernels without CONFIG_NVMEM
To:     Rob Clark <robdclark@gmail.com>
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        freedreno <freedreno@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 at 23:09, Rob Clark <robdclark@gmail.com> wrote:
>
> On Mon, Feb 22, 2021 at 8:06 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Mon, Feb 22, 2021 at 7:45 AM Akhil P Oommen <akhilpo@codeaurora.org> wrote:
> > >
> > > On 2/19/2021 9:30 PM, Rob Clark wrote:
> > > > On Fri, Feb 19, 2021 at 2:44 AM Akhil P Oommen <akhilpo@codeaurora.org> wrote:
> > > >>
> > > >> On 2/18/2021 9:41 PM, Rob Clark wrote:
> > > >>> On Thu, Feb 18, 2021 at 4:28 AM Akhil P Oommen <akhilpo@codeaurora.org> wrote:
> > > >>>>
> > > >>>> On 2/18/2021 2:05 AM, Jonathan Marek wrote:
> > > >>>>> On 2/17/21 3:18 PM, Rob Clark wrote:
> > > >>>>>> On Wed, Feb 17, 2021 at 11:08 AM Jordan Crouse
> > > >>>>>> <jcrouse@codeaurora.org> wrote:
> > > >>>>>>>
> > > >>>>>>> On Wed, Feb 17, 2021 at 07:14:16PM +0530, Akhil P Oommen wrote:
> > > >>>>>>>> On 2/17/2021 8:36 AM, Rob Clark wrote:
> > > >>>>>>>>> On Tue, Feb 16, 2021 at 12:10 PM Jonathan Marek <jonathan@marek.ca>
> > > >>>>>>>>> wrote:
> > > >>>>>>>>>>
> > > >>>>>>>>>> Ignore nvmem_cell_get() EOPNOTSUPP error in the same way as a
> > > >>>>>>>>>> ENOENT error,
> > > >>>>>>>>>> to fix the case where the kernel was compiled without CONFIG_NVMEM.
> > > >>>>>>>>>>
> > > >>>>>>>>>> Fixes: fe7952c629da ("drm/msm: Add speed-bin support to a618 gpu")
> > > >>>>>>>>>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > > >>>>>>>>>> ---
> > > >>>>>>>>>>     drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++---
> > > >>>>>>>>>>     1 file changed, 3 insertions(+), 3 deletions(-)
> > > >>>>>>>>>>
> > > >>>>>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > >>>>>>>>>> b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > >>>>>>>>>> index ba8e9d3cf0fe..7fe5d97606aa 100644
> > > >>>>>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > >>>>>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > >>>>>>>>>> @@ -1356,10 +1356,10 @@ static int a6xx_set_supported_hw(struct
> > > >>>>>>>>>> device *dev, struct a6xx_gpu *a6xx_gpu,
> > > >>>>>>>>>>
> > > >>>>>>>>>>            cell = nvmem_cell_get(dev, "speed_bin");
> > > >>>>>>>>>>            /*
> > > >>>>>>>>>> -        * -ENOENT means that the platform doesn't support
> > > >>>>>>>>>> speedbin which is
> > > >>>>>>>>>> -        * fine
> > > >>>>>>>>>> +        * -ENOENT means no speed bin in device tree,
> > > >>>>>>>>>> +        * -EOPNOTSUPP means kernel was built without CONFIG_NVMEM
> > > >>>>>>>>>
> > > >>>>>>>>> very minor nit, it would be nice to at least preserve the gist of the
> > > >>>>>>>>> "which is fine" (ie. some variation of "this is an optional thing and
> > > >>>>>>>>> things won't catch fire without it" ;-))
> > > >>>>>>>>>
> > > >>>>>>>>> (which is, I believe, is true, hopefully Akhil could confirm.. if not
> > > >>>>>>>>> we should have a harder dependency on CONFIG_NVMEM..)
> > > >>>>>>>> IIRC, if the gpu opp table in the DT uses the 'opp-supported-hw'
> > > >>>>>>>> property,
> > > >>>>>>>> we will see some error during boot up if we don't call
> > > >>>>>>>> dev_pm_opp_set_supported_hw(). So calling "nvmem_cell_get(dev,
> > > >>>>>>>> "speed_bin")"
> > > >>>>>>>> is a way to test this.
> > > >>>>>>>>
> > > >>>>>>>> If there is no other harm, we can put a hard dependency on
> > > >>>>>>>> CONFIG_NVMEM.
> > > >>>>>>>
> > > >>>>>>> I'm not sure if we want to go this far given the squishiness about
> > > >>>>>>> module
> > > >>>>>>> dependencies. As far as I know we are the only driver that uses this
> > > >>>>>>> seriously
> > > >>>>>>> on QCOM SoCs and this is only needed for certain targets. I don't
> > > >>>>>>> know if we
> > > >>>>>>> want to force every target to build NVMEM and QFPROM on our behalf.
> > > >>>>>>> But maybe
> > > >>>>>>> I'm just saying that because Kconfig dependencies tend to break my
> > > >>>>>>> brain (and
> > > >>>>>>> then Arnd has to send a patch to fix it).
> > > >>>>>>>
> > > >>>>>>
> > > >>>>>> Hmm, good point.. looks like CONFIG_NVMEM itself doesn't have any
> > > >>>>>> other dependencies, so I suppose it wouldn't be the end of the world
> > > >>>>>> to select that.. but I guess we don't want to require QFPROM
> > > >>>>>>
> > > >>>>>> I guess at the end of the day, what is the failure mode if you have a
> > > >>>>>> speed-bin device, but your kernel config misses QFPROM (and possibly
> > > >>>>>> NVMEM)?  If the result is just not having the highest clk rate(s)
> > > >>>>
> > > >>>> Atleast on sc7180's gpu, using an unsupported FMAX breaks gmu. It won't
> > > >>>> be very obvious what went wrong when this happens!
> > > >>>
> > > >>> Ugg, ok..
> > > >>>
> > > >>> I suppose we could select NVMEM, but not QFPROM, and then the case
> > > >>> where QFPROM is not enabled on platforms that have the speed-bin field
> > > >>> in DT will fail gracefully and all other platforms would continue on
> > > >>> happily?
> > > >>>
> > > >>> BR,
> > > >>> -R
> > > >>
> > > >> Sounds good to me.
> > > >>
> > > >
> > > > You probably should do a quick test with NVMEM enabled but QFPROM
> > > > disabled to confirm my theory, but I *think* that should work
> > > >
> > > > BR,
> > > > -R
> > > >
> > >
> > > I tried it on an sc7180 device. The suggested combo (CONFIG_NVMEM + no
> > > CONFIG_QCOM_QFPROM) makes the gpu probe fail with error "failed to read
> > > speed-bin. Some OPPs may not be supported by hardware". This is good
> > > enough clue for the developer that he should fix the broken speedbin
> > > detection.
> > >
> >
> > Ok, great.. then sounds like selecting NVMEM is a good approach
> >
>
> btw, did anyone ever send a patch to select NVMEM?  I'm not seeing one
> but I could be overlooking something

Judging by the amount of issues surrounding speed-bin, I might have a
bold suggestion to revert these patches for now and get them once all
the issues are sorted, so that we'd have a single working commit
instead of scattered patch series breaking git bisect, having bad
side-effects on non-sc7180 platforms, etc.


-- 
With best wishes
Dmitry
