Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC78341638
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 08:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhCSHAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 03:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbhCSHAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:00:35 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F6C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 00:00:34 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so2054034oot.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FPOK1V0xQBgz/LvuEDvlEdlMHvA8U+a3mNRXD1kRc/g=;
        b=T30jMH3NuD7ezkxsdYCLGtrzrz28ROF2x0krK025Nm5sFbRsJ4/TtMYqlhCExImOSU
         42kMZFncvT6EQzsAb8Hs0GzYWDZePhDFrAOfPmltTYoGfjX4WBHEYvhq1NF9JmHxSr0t
         PQP4aDH23wR/wldGJDfAcLL/TFhzGnDuRNXEvlDZs1JrLQFCysPspVfutuTKOMfB+bOu
         NcgarfGoYXV8l62Nx6IM5CP2yv933KaZqYzmjpLel/nM+mtEMVeMB0Nha1BrFPNuTSp3
         6bA+4PUorMGp2jDsIXGbV+n29KfTUgfoO2B6GAxqAPLpaFvFpIFe5yBzFHkeLPwL3KjC
         IaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FPOK1V0xQBgz/LvuEDvlEdlMHvA8U+a3mNRXD1kRc/g=;
        b=fTKLeTrEORhyt+pHlKlWfDm1KlzwfWo7q93JWDXfdcKJ4Ecvw/bTaRqj84yQCtZGvE
         +JWcdIinc3pOfmqAgkrDx0zW2N/1RB3kuT1f+OkgFZKOCvjaVzvQBLs2FJwHgTerfQwJ
         I0WKiuudMZ/A0e0MivfafOYMqpeYDK5EDtoiiSzqB9ZUCsWDKhr4Yq0Tj4ZMjFrUjA+Z
         vlkuG4x/3AFcDfyzvooqADNwue+uZiZhQsUhE8WD/axN50pyAKGoKmQjFQ8jt2sMgyjb
         YOUrJ2qT+ur7YCipnsWsAV/dIcpgI2dqsMmwqBOT1+KNnJK/F/hBUIN02I6v/Rp89tHx
         r4Gg==
X-Gm-Message-State: AOAM530kfhmkFMNE7dlAq/TcWtx7pOpuu3iv89RvbzRusoqpqY1digTD
        kixRESoPBB8M8q2PLlgq+HVGXIuZBnyx4h9WQsignOfiwrcziQ==
X-Google-Smtp-Source: ABdhPJydbrEFLJm+jNyY05vJbeJ9IoVBovtjUBW5YWX3rnGdADvRawb06vnoVwHmhvPMWac2Kv0CKCMyy3xXSPYFYiE=
X-Received: by 2002:a05:6820:3c8:: with SMTP id s8mr22284ooj.49.1616137233541;
 Fri, 19 Mar 2021 00:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210225090610.242623-1-allen.lkml@gmail.com> <20210225090610.242623-2-allen.lkml@gmail.com>
 <CAHUa44F5Ew6U80t7PPmV1J4KunXBm_izBxVrxg=x8azjBz0r9Q@mail.gmail.com> <9a6c017c-d156-f939-f907-d6dfe83c41ac@linux.microsoft.com>
In-Reply-To: <9a6c017c-d156-f939-f907-d6dfe83c41ac@linux.microsoft.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 19 Mar 2021 08:00:22 +0100
Message-ID: <CAHUa44FyGOj5=Z80km_2T-avKiJpGVD8cWjTC3ZCX8csazP3rw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] optee: fix tee out of memory failure seen during
 kexec reboot
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     Allen Pais <allen.lkml@gmail.com>, zajec5@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 2:21 PM Allen Pais <apais@linux.microsoft.com> wrote:
>
>
>
> >>
> >> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
> >> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
> >>
> >> tee_shm_release() is not invoked on dma shm buffer.
> >>
> >> Implement .shutdown() method to handle the release of the buffers
> >> correctly.
> >>
> >> More info:
> >> https://github.com/OP-TEE/optee_os/issues/3637
> >>
> >> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> >> ---
> >>   drivers/tee/optee/core.c | 20 ++++++++++++++++++++
> >>   1 file changed, 20 insertions(+)
> >
> > This looks good to me. Do you have a practical way of testing this on
> > QEMU for instance?
> >
>
> Jens,
>
>    I could not reproduce nor create a setup using QEMU, I could only
> do it on a real h/w.
>
>    I have extensively tested the fix and I don't see any issues.

I did a few test runs too, seems OK.

Thanks,
Jens
