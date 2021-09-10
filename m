Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7525406DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhIJO7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 10:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhIJO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 10:59:33 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1422C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 07:58:22 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so2559083otg.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dNMcotrOi2O8X5+K4QkSumuPAinELToImwkfJpFuS7A=;
        b=PVQJY9NQRFx6QUKl4yAwHEunh7yUg6zEKP52wAwQV4xDh71oyErJjCF5BM1da5+heD
         DQ1PAj+SDVSffzMPBvzPbVW9MYkg3Rxe6VS3WvUS0fJWE2hrZMJ74GXXoH5KwII+rhbn
         wrK7OdFgQRJzZNDIOUK5n7u1YrgW3BBuLJtTMIwyWDsCHgiFqOUu9svkS/g43yhWWu9l
         B5IHqLKS+QBhUsWlIDIPkQj/Yr6ImY5muwqNwCXsOQ8smpQn1gtCQpeQ7jHNeMakagDl
         W3aHVXM3XsxlmyeL1eMqOoGxTrxlTkF1MA0lBfS6u2Mzr7tc0agLp76PL56SqLS2FUqm
         jYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dNMcotrOi2O8X5+K4QkSumuPAinELToImwkfJpFuS7A=;
        b=dGoOnYEGEdzI4RV5jnGHI3cIl5CIKBPXAWukN0/APgu9tYrD1vNaEE7ysFhHAdn0eH
         sm9Cf660XJyCegqwakJXm3dEjzSGfLB+25tbCvsNvwWu9UBllPmuLFXBUCjFAafmhT81
         WSo8byCHYpiy4ayC8r8HzVsqTX2EHq2w0ui0uIydaOGpHaKath/COEBgicNGiaZz7/dS
         0cJzbVGcPB5pmhducoirJ4jzhCdDjX7EkgkepmA3P3uyMB+a/7hnWBcY9bTvvdgTadXQ
         hAOpZp8Dy0ZBZ0Vy4rEbfwlVHF13uaJfWhwbkvJFLTx05tSLPydUq90RUhALRLdilUKd
         iLhg==
X-Gm-Message-State: AOAM530BzD0GhWU7hoFyv+lt9SYcAOpHdetKocQ6948xVZRxlYqw2cHk
        NU7wVJCQ5aPPk3TPd1TzK7yEDw==
X-Google-Smtp-Source: ABdhPJw+Y+Dd9F4rP7RyWzysVfBfqX6B77tKm8mT8C9BahT1WfySwOXUXCCrCNBmkeBcQd6Z7QwQ5A==
X-Received: by 2002:a05:6830:2b24:: with SMTP id l36mr5211050otv.25.1631285901919;
        Fri, 10 Sep 2021 07:58:21 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q22sm1203738oof.14.2021.09.10.07.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:58:21 -0700 (PDT)
Date:   Fri, 10 Sep 2021 07:59:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alex Elder <elder@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>
Subject: Re: [GIT PULL] remoteproc updates for v5.15
Message-ID: <YTtyxSHdBpFpM6ra@ripper>
References: <20210907140023.2399178-1-bjorn.andersson@linaro.org>
 <d689501f-87d3-59ef-0c04-69b1f5029cc9@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d689501f-87d3-59ef-0c04-69b1f5029cc9@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10 Sep 06:32 PDT 2021, Arnaud POULIQUEN wrote:

> Hello Bjorn,
> 

Good morning Arnaud,

> 
> On 9/7/21 4:00 PM, Bjorn Andersson wrote:
> > The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
> > 
> >   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.15
> > 
> > for you to fetch changes up to a0a77028c85ad1f6f36c3ceea21b30dc43721665:
> > 
> >   remoteproc: q6v5_pas: Add sdm660 ADSP PIL compatible (2021-08-04 12:37:32 -0500)
> > 
> > ----------------------------------------------------------------
> > remoteproc updates for v5.15
> > 
> 
> I was expecting to see a pull request for the RPMsg framework as well,
> integrating my work around the rpmsg_char driver restructuring.
> 
> These series listed at the end of my mail have been reviewed by Mathieu Poirier
> (RPMsg framework co-maintainer) before the 5.14 pull requests. Then on July 12,
> I re-based the series on v14.1-rc1 expecting to give you enough time to
> integrate them for the next 5.15 merge window.
> 

Yes, I definitely had enough time.

> Could you please tell me if it is just a miss or if you have some concerns on
> them? Because I never received feedback from you for this work.
> 

I did see that you and Mathieu had reached an agreement on the patches
and set out to apply the patches.

But as I look at the patches I realize that you're refactoring the
entire design of how rpmsg_char works and last time we spoke about the
existing users I got the feeling that you had no way to validate that
they still work after this refactoring. And in those discussions I
highlighted a few things that would break existing users.

So I felt the need to convince myself that your series does indeed not
break existing users.

Unfortunately I dropped the ball on getting back to do this.

> Or maybe I missed something in the process, I thought that Matthieu's
> "reviewed-by" was sufficient to be accepted.
> 

The change is complex, affects existing users, it introduces new ABI and
that I don't believe Mathieu has the means of testing the existing
users(?). So while I trust Mathieu's R-b, I did want to take one more
look at it.

> How could we move forward on this work, which also seems to interest some other
> companies?
> 

I'll make sure to carve out the necessary time in the coming days to go
through the patches and let's take it from there.

> Related series:
> - [PATCH v5 0/4] Restructure the rpmsg char to decorrelate the control part
>   https://lkml.org/lkml/2021/7/12/2872
> - [PATCH v4 0/4] rpmsg: char: introduce the rpmsg-raw channel???
>   https://lkml.org/lkml/2021/7/12/2908
> - [PATCH v3] rpmsg: ctrl: Introduce new RPMSG_CREATE/RELEASE_DEV_IOCTL controls
>   https://lkml.org/lkml/2021/7/12/2913
> 

You have 9 patches over 3 different series in different versions, where
things certainly depend on each other.

I believe I asked you if we could do this step-wise, I didn't mean that
we should split it in multiple steps that needs to be taken at the same
time...

> - [PATCH v2] rpmsg: Fix rpmsg_create_ept return when RPMSG config is not defined
>   https://lkml.org/lkml/2021/7/12/2877

Then you have this, which I thought was related to the others when I
browsed through the patch list, and therefor didn't merge. But now that
I look again I see that this is unrelated.

I've added the appropriate Fixes tag and picked this up now.

Regards,
Bjorn

> Thanks in advance,
> Regards,
> Arnaud
> 
> 
> > This moves the crash recovery worker to the freezable work queue to
> > avoid interaction with other drivers during suspend & resume. It fixes a
> > couple of typos in comments.
> > 
> > It adds support for handling the audio DSP on SDM660 and it fixes a race
> > between the Qualcomm wireless subsystem driver and the associated driver
> > for the RF chip.
> > 
> > ----------------------------------------------------------------
> > Alex Elder (1):
> >       remoteproc: use freezable workqueue for crash notifications
> > 
> > Bjorn Andersson (1):
> >       remoteproc: qcom: wcnss: Fix race with iris probe
> > 
> > Dong Aisheng (2):
> >       remoteproc: fix an typo in fw_elf_get_class code comments
> >       remoteproc: fix kernel doc for struct rproc_ops
> > 
> > Konrad Dybcio (2):
> >       dt-bindings: remoteproc: qcom: adsp: Add SDM660 ADSP
> >       remoteproc: q6v5_pas: Add sdm660 ADSP PIL compatible
> > 
> >  .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |   1 +
> >  drivers/remoteproc/qcom_q6v5_pas.c                 |   1 +
> >  drivers/remoteproc/qcom_wcnss.c                    |  49 +++------
> >  drivers/remoteproc/qcom_wcnss.h                    |   4 +-
> >  drivers/remoteproc/qcom_wcnss_iris.c               | 120 +++++++++++++--------
> >  drivers/remoteproc/remoteproc_core.c               |   4 +-
> >  drivers/remoteproc/remoteproc_elf_helpers.h        |   2 +-
> >  include/linux/remoteproc.h                         |   5 +-
> >  8 files changed, 96 insertions(+), 90 deletions(-)
> > 
