Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5979A3F4C88
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhHWOmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHWOma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:42:30 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA1FC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:41:48 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id u7so17287907ilk.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWc9vuQDtmWHvB78xgjXDwiSH/td53Rs3ykrTDLONn0=;
        b=vuP2UdeH6j0HoKCzODhy5NSYByeMfAfPzCCA6sbDFZ+5xJ0Oc0QYXg49HHv+gJOj6A
         8OH2dK++anCLl6EITsoJ2AOJWOUuNwHDi9ukq4GOhj5FRNzVFutCcVlbzQZZq1Wd1OzB
         +xgddckoMSmRQfEqjAf5AKIqp1bhXCyqYai4Yc6RL+LX0k7F/2oJajWXIH2FJPW45XeS
         TclWxAEUcvvUS1ILnxE2CsNjzs4WZLM0r56mY/nYG9cUMR7KD+RtBcJcpD8cb5bXoQFk
         b8c7dgS2r7YWOUn7IyaJpaaVaA0knAFM5ZjxSeNV8ZU+5X7lzmRsT4X0x7Wfak0OIF5F
         k0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWc9vuQDtmWHvB78xgjXDwiSH/td53Rs3ykrTDLONn0=;
        b=UVaJeR82tiYqoIt7VLobdJqZJUgHYrU2lxr3QqA/OtRj0adfCVGFm2mumwbEBrwZvK
         VkdDMcsgOU5fU0pjcltELbXsUBFW2pJFDMIXoR6WtSGHLOLhkOYXhyd94+a2YqteanRN
         8Tfgg+EBjeuWq4cBIMY/dAqzM5fXoo+cWbtBjJVmxQaUdMJiWc41rkVVSzeSEqyBNVuw
         lRPIbdWL6J3GT5Lzduc7WEHoPJ+kqYYPOwJxJlqS2C4hSxbA4zAZqDiLMovjaqDacVDL
         OALya/wrJTUOCeSNp4zsik2Ti1aBGlgbvbXgqOglR29Bnqsu4/t7a2BllDuXyhV6+rgX
         zgvQ==
X-Gm-Message-State: AOAM531IqLOQk7srwrkM/9+lc3fqSDnuiLJ1CD5LwI7DFiTZ41d45Dsf
        s2H8weKXkL4WDwedJcBVs+SUOzBD478XxqTV9+v85A==
X-Google-Smtp-Source: ABdhPJzUbp2hzrTBSEuc41f1TIINk8z2ia0qVjX/aYzgXCdBnA9yzb48O8rZYKKecnR8JhfXExXp1ltsbC6tDr2JdLw=
X-Received: by 2002:a92:c80e:: with SMTP id v14mr24284517iln.57.1629729707428;
 Mon, 23 Aug 2021 07:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <1629365324-5891-1-git-send-email-quic_taozha@quicinc.com>
In-Reply-To: <1629365324-5891-1-git-send-email-quic_taozha@quicinc.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 23 Aug 2021 08:41:36 -0600
Message-ID: <CANLsYkxw9nXb=vsWhf8=Sf6Bnm23doTaYOS7WChxOGhudt23-w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add Coresight support for RB5 board
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

On Thu, 19 Aug 2021 at 03:29, Tao Zhang <quic_taozha@quicinc.com> wrote:
>
> This series adds Coresight support for SM8250 Soc on RB5 board.
> It is composed of two elements.
> a) Add ETM PID for Kryo-5XX.
> b) Add coresight support to DTS for RB5.
>
> This series applies to coresight/next
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>
> Tao Zhang (2):
>   coresight: etm4x: Add ETM PID for Kryo-5XX
>   arm64: dts: qcom: sm8250: Add Coresight support
>
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      | 442 +++++++++++++++++-
>  .../coresight/coresight-etm4x-core.c          |   1 +
>  2 files changed, 439 insertions(+), 4 deletions(-)
>

I have added your work to my patchset queue.  On the other hand I have
a lot of patches to review these days and as such won't be able to
look at it for 4 to 5 weeks.

Thanks,
Mathieu

> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
