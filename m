Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE2B38F392
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 21:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhEXTUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 15:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbhEXTUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 15:20:42 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653A3C061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 12:19:12 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so26251375otp.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=AsmfRYALyOOPiklFnGLxIxG22/ZrSMjEGdTaIKdv2bU=;
        b=Z6K9qOtHmxNbIvyG9A4ac/vZr8tgn/cWTSgKRQvY4akWmBp6biiPaGssozi+HjDJ6N
         J2iwMafMFTIkGAGFdavLMTAX576r/cJrnUVzQoc5vnJOl4iJDionu1Toua7Pyr+Ggbdt
         05WC5Vk9GH6M/SjqEXJINc5HHx2d/+YYaawdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=AsmfRYALyOOPiklFnGLxIxG22/ZrSMjEGdTaIKdv2bU=;
        b=rXF7XtIFDaPYSAINmWKiKyB+8TwfCdaHeK9ZVxAoQNPQS7lQ0xZGCk7YJRV3Yr00Fv
         vIBuOo3Nl70GorwwDM+uxdihqPQsYSPatPRl5HcYdQAH1urEYq5/8vzCe2yEvq/S4VBp
         KbV5wLoBAocO8sJdZD/U8hAPdcpdO7m6PUNI/pAUXntiq3iCKrEYDUE2oshEulyNseMP
         ByK9JAB6yp0FHc5I15bkuL6V1Z5r/ZUF255AucFHE11Ze336aMERmmygYX1GMr7zNoiR
         JV97tDQI+LYm8O+GPDFoIy2aZzTEBic2+hbkseNgiVDgZUZbAaYc1K0ZlglqS22+jT6J
         AMvA==
X-Gm-Message-State: AOAM533V88y0S9IgIPe8WFemWMR74Pf/x23pu3/QgTA3NTkwmfHK9U+r
        yqU88ec6MISmvCOElI7ziffrehl7KPFp509ySyZrzA==
X-Google-Smtp-Source: ABdhPJyZvnN47Xm+9vSAQTY/yVMkjuiMef8z4kEdnt1y+yOYDWPBCdNJk6g1rCvHRsb/g3TvNREw/LN0Y4VqyfCekTY=
X-Received: by 2002:a05:6830:3154:: with SMTP id c20mr2433314ots.233.1621883951712;
 Mon, 24 May 2021 12:19:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 May 2021 19:19:11 +0000
MIME-Version: 1.0
In-Reply-To: <1133b2c21eb8f385c16c610638a17d9c@codeaurora.org>
References: <20210507212505.1224111-1-swboyd@chromium.org> <20210507212505.1224111-4-swboyd@chromium.org>
 <1133b2c21eb8f385c16c610638a17d9c@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 24 May 2021 19:19:11 +0000
Message-ID: <CAE-0n51G2NGyE4w1ebdBd1svVPA3QvPZX6kivKA1m9o1XhE26A@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/msm/dp: Handle aux timeouts, nacks, defers
To:     khsieh@codeaurora.org
Cc:     Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        aravindh@codeaurora.org, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2021-05-24 09:33:49)
> On 2021-05-07 14:25, Stephen Boyd wrote:
> > @@ -367,36 +347,38 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux
> > *dp_aux,
> >       }
> >
> >       ret = dp_aux_cmd_fifo_tx(aux, msg);
> > -
> >       if (ret < 0) {
> >               if (aux->native) {
> >                       aux->retry_cnt++;
> >                       if (!(aux->retry_cnt % MAX_AUX_RETRIES))
> >                               dp_catalog_aux_update_cfg(aux->catalog);
> >               }
> > -             usleep_range(400, 500); /* at least 400us to next try */
> > -             goto unlock_exit;
> > -     }
>
> 1) dp_catalog_aux_update_cfg(aux->catalog) will not work without
> dp_catalog_aux_reset(aux->catalog);
> dp_catalog_aux_reset(aux->catalog) will reset hpd control block and
> potentially cause pending hpd interrupts got lost.
> Therefore I think we should not do
> dp_catalog_aux_update_cfg(aux->catalog) for now.
> reset aux controller will reset hpd control block probolem will be fixed
> at next chipset.
> after that we can add dp_catalog_aux_update_cfg(aux->catalog) followed
> by dp_catalog_aux_reset(aux->catalog) back at next chipset.

Hmm ok. So the phy calibration logic that tweaks the tuning values is
never used? Why can't the phy be tuned while it is active? I don't
understand why we would ever want to reset the aux phy when changing the
settings for a retry. Either way, this is not actually changing in this
patch so it would be another patch to remove this code.

>
> 2) according to DP specification, aux read/write failed have to wait at
> least 400us before next try can start.
> Otherwise, DP compliant test will failed

Yes. The caller of this function, drm_dp_dpcd_access(), has the delay
already

                if (ret != 0 && ret != -ETIMEDOUT) {
                        usleep_range(AUX_RETRY_INTERVAL,
                                     AUX_RETRY_INTERVAL + 100);
                }

so this delay here is redundant.
