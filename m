Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE51631DCE5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhBQQHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbhBQQHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:07:44 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE95C061756
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:07:03 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id i23so16870398ejg.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AftdaebIpCDcjcG7rOA2wIM0Y3Td1DLEqD5IAEbRfXA=;
        b=gxiLTE5YG3jxuCRIaDNoSwKLCBkeEhm1sTjPlCDekWh5yazl3P3UuueZXS97uf2yzb
         /hBKb3Cl6EhdNBvGhf0WcTy7HLPophHbdGjJvPYDqTDkJhmrGr263S/ihS7BzrlLyY7g
         EJ2Cw2vfFyeZrgaYQTFHKddw/IaIymBH/7xcUt+2BiJsMxtttV8j2vY49ewN3+bWrlri
         /P5VBRrDhfpzggqRFmiylwZn9MSEsHsVtFZtu9ZdbIQe9CbnnrpcVLoykxjBA4wDSZK8
         7DLLfbbx5ijyjGExDtL7L4WUjhO1uuaP/jW0hMOzL83Q+RNySuAqPL0BJho1MmV6K3mS
         4guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AftdaebIpCDcjcG7rOA2wIM0Y3Td1DLEqD5IAEbRfXA=;
        b=NUoGXfM5h3CXfppnVCQgCJ6Nz/tqdjhdLDbfHLeM8qoX7hkLmVfaCIo9I9v0/yiEG1
         tGakI9act75wv25qrBJNPkEUOTPP+JfR704L6uW3Lovyw57PbjTh+t+pRfMquo9epJrd
         j9BeVpomw558nLBp99wYPWlXPi4Zq3oIeBtw/dCcz0BU20nl9SB2QvE0TsLJTM+Q3TIK
         vbUK/NRWa3OFvzlvy9jiIw5xbKyGHt09DSM6l6u8cR3z1xp3Coqwot1o1MuQwxJURxFR
         n4xhHpeagyNMp8G8bWNUEcxIhI0cFbF8PY5uLnmusPS7PyO6MRQlveCYQkxeSovjfYbM
         5jWg==
X-Gm-Message-State: AOAM530UCHwikjFstUapUtBZwjD/Tu2wf5L9lqV1ypMd1UhY57lhyJ5C
        obKK6/6khEeN53vYm0CIjTObBsAea6CmHocz3M2tAw==
X-Google-Smtp-Source: ABdhPJyJ2lzMSIS9QPqVOg7eBJ+X0T2qipK5Gyk8akppKz7EJPtC+YCFsyVmKG1GpZ67Ud4zbJu7r6U9eaJLO+3TISU=
X-Received: by 2002:a17:907:9702:: with SMTP id jg2mr26681055ejc.48.1613578022322;
 Wed, 17 Feb 2021 08:07:02 -0800 (PST)
MIME-Version: 1.0
References: <1613501314-2392-1-git-send-email-jhugo@codeaurora.org>
 <CAMZdPi9S5OnWs_QFnf+xVM+jLve6cpdvi_vpC_KdEbUUaqoFYg@mail.gmail.com> <eb873085-4120-7ec4-1f18-1c768ed741bd@codeaurora.org>
In-Reply-To: <eb873085-4120-7ec4-1f18-1c768ed741bd@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 17 Feb 2021 17:14:34 +0100
Message-ID: <CAMZdPi-s5kXcPZftCv-VfRK7VpGT9_1TREO8GNTC3rwpU8RHpQ@mail.gmail.com>
Subject: Re: [PATCH] mhi_bus: core: Return EBUSY if MHI ring is full
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fan Wu <wufan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Feb 2021 at 16:06, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
>
> On 2/17/2021 8:02 AM, Loic Poulain wrote:
> > On Tue, 16 Feb 2021 at 19:50, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> >>
> >> From: Fan Wu <wufan@codeaurora.org>
> >>
> >> Currently ENOMEM is returned when MHI ring is full. This error code is
> >> very misleading. Change to EBUSY instead.
> >
> > Well, there is no space left in the ring, so it's no so misleading.
>
> ENOMEM is typically a memory allocation failure which is not what a
> client is going to think of regarding the ring, and it's not a unique
> failure code in this case.  gen_tre can also return ENOMEM, which makes
> it difficult for the client to know if there is some significant
> failure, or they might just need to wait (assuming that is something the
> client can do).

Yes, fair enough, I overlooked the other thread, -EAGAIN would indeed
make sense.

Regards,
Loic
