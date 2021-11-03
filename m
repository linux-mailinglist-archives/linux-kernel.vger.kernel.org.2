Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F3C444435
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 16:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhKCPGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhKCPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:06:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C193C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 08:03:36 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f3so5695179lfu.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocVzS0OUcnB5+dQiLwWdw20NbFOBOR2SRavPv7B36iU=;
        b=CrtoyVXd9K74O/kUB1tmaOsi7EIm1pbBWLAHcq5gR28HFqzBbU1IIB1hh+djAvmfsU
         cnO0gWiTTMzstsAJuNwn9wesrjKyduBjZmINZ0sKhmdJqD2duOvAUd8C+2bG/cPbfN+i
         z86EfDpMtY9ckjx8tOOeM2Jjcq/XTeyLsOR58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocVzS0OUcnB5+dQiLwWdw20NbFOBOR2SRavPv7B36iU=;
        b=OkmgGT7LG4vGCGts4wXN9HcqPK5VFCnBJx2IoUeDSpQ9ANW97bWHJt2OjzZURolafc
         esDIIIrGPsUBLmCKBQkCPVpKrA2eKRyxbjDUaFIOtPPRCQTtZ7gdkXAMHyi3we6KysyN
         DdhlzWtl4CyKc7hXL7TSxJQJ29QDMSbuIff+dVFQYkms7C+UIt/Nt3Ra9z87lNQnU14B
         KR0X8sGvOZHshP2xrZPOYGCMDjldvZInfa8DjUfXWO3B3LYs8t/BLECohACay6Gaay+h
         f7MIf+MUt/5pUJLVkLYEZdn9eIfAPGc0TNHGmP7STLUjlJLzdE/gpjo1+RKsAANk2DKT
         UQLQ==
X-Gm-Message-State: AOAM5332IvDBoznkAaHhXFtoojbXyUXCP4MjxDSqZexl4N9VhMSVL6yA
        MguEdIlOy0yW2fURendRQWGbGltDkdYCduhm
X-Google-Smtp-Source: ABdhPJzIbz6ApvHA7tyzjGCn6zlSq+p9SqBGuAtn5HSmTYNNtrRG8cahjBTHyhfIo1xj83qzgJVIdw==
X-Received: by 2002:ac2:59c6:: with SMTP id x6mr23260044lfn.502.1635951813684;
        Wed, 03 Nov 2021 08:03:33 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d20sm201204lfv.117.2021.11.03.08.03.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 08:03:32 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id y26so5714913lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 08:03:32 -0700 (PDT)
X-Received: by 2002:a05:6512:13a5:: with SMTP id p37mr39873997lfa.474.1635951811832;
 Wed, 03 Nov 2021 08:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hnj0zCXsZy0=Ukud3U_cn054GULmHmpz7Qrpg_TkLLqA@mail.gmail.com>
 <CAHk-=wijOKZNA0Ahd0fNDDa8pc6abv9wUHbxBf8giOeERHkW0g@mail.gmail.com> <60950c33-a5be-c465-cb5a-9e33b13a1ee4@linaro.org>
In-Reply-To: <60950c33-a5be-c465-cb5a-9e33b13a1ee4@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Nov 2021 08:03:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjf_FrwxU0mAR_27cmmmr3n35fMyuJ2D+g2baeroTCFOQ@mail.gmail.com>
Message-ID: <CAHk-=wjf_FrwxU0mAR_27cmmmr3n35fMyuJ2D+g2baeroTCFOQ@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal control updates for v5.16-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 12:53 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Is the platform with 19 thermal zones and default thermal policy set to
> userspace governor ?

I think it has 11 thermal zones judging by
/sys/class/thermal/thermal_zone* going from 0 to 10.

And the kernel default seems to be

   CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y

but presumably this is F34 then setting it to 'userspace' (the kernel
config comes from the F34 one too, although it's been tweaked for the
machine).

I suspect I could just turn off THERMAL_GOV_USER_SPACE and get rid of
the message, that's not the issue.

The issue is "why is the kernel spewing pointlessly the same message
over and over again?"

                      Linus
