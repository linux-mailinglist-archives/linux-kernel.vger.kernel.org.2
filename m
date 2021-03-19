Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEF33421C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhCSQYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:24:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52658 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhCSQXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:23:34 -0400
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lNHuP-0004tH-2A
        for linux-kernel@vger.kernel.org; Fri, 19 Mar 2021 16:23:33 +0000
Received: by mail-lf1-f70.google.com with SMTP id b1so14766801lft.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xz8TPdVB4EDtcxBy3GtWMpWf4qC96vtgCeVPrtt93cQ=;
        b=henKctoWgHXD0SKw81Veyl1HvEBSTQntVToyyZDAdfZamaUC4zxhZ760rwKY7Z1uZu
         N1yV10eTXjdSyB7Hr2qcZkpipoK2XoBLQsf1DIe69Gh6fZpSbfMRaessRSRM+axCFwF5
         iSsaMTftH0oB7xK/+nnQCx45tLIYqdN5ezsfGeIsJIW4WwoffRpn4NYNd8YncRJmIsd1
         8r8f+KzOKz12c3TNQ7vYCiUmdpFhpX0zqNQttbWDAl+l1WXjg1/q0o+kloaiN2ldagL2
         EfsKlEjZpt745pWIpM1YNGPMBfJw7y33rNjepcYdWS6AdNekzGirEi7BBTjzjeKc7wDW
         Di1A==
X-Gm-Message-State: AOAM532e7z+OQqIZrj26bT6H4Zm39jj0zLGcoVr1HzSr6sEFGWgEcmyd
        /tuvjeh6WVSz550AaKYiQjjNK0rtbS33rM+rw3oxKqloLO1aMiMgr9l1SCZk3n+39hNmQ/sKGTi
        uKt7yunDF15X5HMugCZ5gmwmnAVRJTClNa/5r4eYGEIOYjJWfCSRKQn+IKw==
X-Received: by 2002:a2e:5753:: with SMTP id r19mr1407874ljd.126.1616171012549;
        Fri, 19 Mar 2021 09:23:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy43J4Kpgq9mCSyPqEDKkmC9OjFRPAWnnjYVr1Ua8xgvMhBlEaYmA1VYcuSnmuiK0gH4Jzq3HrwayDwGRYvLnQ=
X-Received: by 2002:a2e:5753:: with SMTP id r19mr1407861ljd.126.1616171012302;
 Fri, 19 Mar 2021 09:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <b8db79e6857c41dab4ef08bdf826ea7c47e3bafc.1615947283.git.josef@toxicpanda.com>
 <CAAd53p5Vh_+tUeEQx3xf_aLiCiKP1u5Y3VgYCUzZ82Kgtr-iYw@mail.gmail.com>
 <bebcaffc-d485-912d-0c42-c0781f9c7603@toxicpanda.com> <CAAd53p7eJk9EtMTLjB5i7RdoKA3WS1W4TRjQs08adi7iAux_jQ@mail.gmail.com>
 <78dfcd55-442d-dcc0-c37f-5576f65f91b5@toxicpanda.com> <CAAd53p6Lp8+S0yjWi=MikQJ_zywiWamUS5p19oKoqB6uYW8jzg@mail.gmail.com>
 <0cd8b39e-3feb-87b8-e172-70b07692b82a@toxicpanda.com>
In-Reply-To: <0cd8b39e-3feb-87b8-e172-70b07692b82a@toxicpanda.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Sat, 20 Mar 2021 00:23:20 +0800
Message-ID: <CAAd53p6=dGwtTVBcQuO+Rvt0nZ2Ck_OXtR=um=S2p=OjNXnH8w@mail.gmail.com>
Subject: Re: [PATCH][RESEND] Revert "PM: ACPI: reboot: Use S5 for reboot"
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 3:02 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 3/18/21 1:42 AM, Kai-Heng Feng wrote:
> > On Thu, Mar 18, 2021 at 1:25 AM Josef Bacik <josef@toxicpanda.com> wrote:
> > [snipped]
> >> "shutdown now" works fine with and without your patch.  Thanks,
> >
> > Rafael,
> > Please revert the patch while we are working on it.
> >
> > Josef,
> > Can you please test the following patch:
> >
>
> That made it work fine.  Thanks,

So there are things depend on reboot or shutdown to carry out
different behaviors.
Can you please find whether there is any code path uses SYSTEM_RESTART
or SYSTEM_POWER_OFF that leads to different behavior? Most likely
happen in a driver's .shutdown callback.

Kai-Heng

>
> Josef
