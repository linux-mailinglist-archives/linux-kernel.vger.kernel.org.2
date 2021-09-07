Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EC940251D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbhIGI1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242634AbhIGI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:27:05 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80886C0613C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 01:25:59 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y18so11685646ioc.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 01:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsKj9cPaLgyBNOvmCyBpPD5MVH61aPQBDGk2ylDvT4I=;
        b=Cqjo+7flYZt5PVjhviejc951vnn/ZxHjZDDSZm2iE0Rym074UsRk9jSB8UzOfpCM20
         1L7LsMW2HeQwiSX1w7skzHYqzLwWa4CPoh5LlihNGeqtjjfG1GqmfL5R3o2BrSipgrlA
         OuBBIr1mdYQh9FPAF67gcxNx2Kiu+zHh65/LVhufxDIGEAhIB9JYe1+R/wotXAyJUivj
         0EMSCIzmvIGHrrspZkocKYi6byJGjOhIKyix3nw5KN8ARegcY64YWoEaTFwGuSTWs+KI
         gDgyLFcM0QY8iY+pcGyzE7Iu2oEGesDb4IGg6lFY7iJ0uL/WSxFH76C9e2HTozPJfOAU
         pvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsKj9cPaLgyBNOvmCyBpPD5MVH61aPQBDGk2ylDvT4I=;
        b=aeCqQcDSH9+KazZjluvjcjxe6hbkp1EIQsmwzlGXSaRxOjQFlIM2iOUtnSAQA7SA0L
         JI8wWu1jzWHuYW2oCMTn/wmMCRqX1p5VDXUtAJPv0phKWgZtmmEzHiPXulro8N70n/Pu
         NeeCwQ+ixpCc+yeylaMUdmjSIi4mQc3qhjIhU/nMVJ+CWKPPK5aS+KNorjZzbky2ppv+
         FyuECItprmyuJ0o2pZ4iSW5cZSTY5Y/31Jz6H5umKIiSkExCg2CPDcVBvlCWTLVSq69c
         qL6YDgcxOKV2RYqzdfBoM+BCOqF5DU9cFtbKuVvRFeat294EBhDoXWMh6b/wkeglOZE2
         Q52A==
X-Gm-Message-State: AOAM530jtAAyGLmT01BaNWkWhh/C7hgXx4MB9N7x7mkZQTmRHE74j4Wg
        A128yXljeHIa8q3E2KrpHqu5+DxEGIRms/VKvKtXuw==
X-Google-Smtp-Source: ABdhPJyJyljW5UoDalrx/KiXWJ1AmyFiYxxkN5TxwIiLyNRIfmd72o0Tug4f9p9B9LTcvpjzBQv03fcRV3wdDGSffHI=
X-Received: by 2002:a02:3846:: with SMTP id v6mr14251170jae.45.1631003158871;
 Tue, 07 Sep 2021 01:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210729183942.2839925-1-robdclark@gmail.com> <1a38a590-a64e-58ef-1bbf-0ae49c004d05@linaro.org>
 <CAF6AEGs5dzA7kfO89Uqbh3XmorXoEa=fpW+unk5_oaihHm479Q@mail.gmail.com>
 <e2cebf65-012d-f818-8202-eb511c996e28@linaro.org> <CAF6AEGs11aYnkL30kp79pMqLTg3_4otFwG2Oc890Of2ndLbELw@mail.gmail.com>
 <CALAqxLUkyXK2gqNMBbtJFfh01ZpcG46dZaM7Zq4jG3OngvFREg@mail.gmail.com>
 <CAF6AEGsACLcDuszcgmHHs04GghLPiRfei3tGo161yBXsg7Y-YA@mail.gmail.com>
 <CAMi1Hd0dniDXPNOuh05ywqHKY+cGvAsd-cnD91K1GLppfO=x0w@mail.gmail.com>
 <CAF6AEGvtw06MYST2PdhqHVpsG4Tec2DnUA-uwFRP-6xqa9yf5Q@mail.gmail.com>
 <CAMi1Hd1kp8ijH8y3U2sxs5cE3Zfat_v-C3rrGtTK01ry8Om6Lw@mail.gmail.com> <CAF6AEGugB5QinhyOxvAiG_V40=mXS20nnqxgk71xe_fmm1iZsw@mail.gmail.com>
In-Reply-To: <CAF6AEGugB5QinhyOxvAiG_V40=mXS20nnqxgk71xe_fmm1iZsw@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 7 Sep 2021 13:55:22 +0530
Message-ID: <CAMi1Hd20xd0Lrp0MuKo=HdDPKeNC_DW08iFoF5wseCH5eB=FzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Disable frequency clamping on a630
To:     Rob Clark <robdclark@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sept 2021 at 07:11, Rob Clark <robdclark@gmail.com> wrote:
>
> One thing I thought of, which would be worth ruling out, is whether
> this issue only occurs with freq changes immediately after resuming
> the GPU, vs freq changes in general.  Could you try the below patch.
> And if it "fixes" the issue, then try reducing the delay until you
> start seeing GPU hangs again.

It doesn't fix the crash and I can still reproduce it
https://pastebin.com/raw/bxK4mAhB

>
> ----------
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 40c9fef457a4..278b85207ea3 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1513,6 +1513,8 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
>   if (ret)
>   return ret;
>
> + msleep(5);
> +
>   msm_devfreq_resume(gpu);
>
>   a6xx_llc_activate(a6xx_gpu);
> ----------
>
> BR,
> -R
