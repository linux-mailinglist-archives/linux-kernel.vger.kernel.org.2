Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB423CEDAD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358911AbhGSTcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385398AbhGSS7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:59:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC785C0613E8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:30:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u13so32084157lfs.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDda5dbFXyknFG+xoYFL2uxWIVC+IEB+7xC2zqUFwSc=;
        b=C2kt/tLjq50F2/8YiWA2vApdMGBU1c/5g8q0V7XaPGvDRnYu01eyxREz3eqyUTFPjo
         +RkvlkvZfYICjMHAI8gTK9GAf+/flWsUK+v7GAxtmc+xq9D5SUVbZ+DUZ9CiQxzMeanC
         YwYKYS3yuZmuX9KNoLodu1DiX6u9M1TDj8A4sNlA8pqZqXdGe8vk+eCXrW99r7bbq4xn
         aezOsvO51i/RTsOu+xwDKXdMBUxnzitKNY74AjA/4ymoyUgfBT077E45qJa7F/qXUBWW
         ztnTsieI6KT6/2V/OeLJPzcwydkdGfXsTY7HAJUxHWTKjw57wll20Q46XtDXCQNoAQ7m
         jF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDda5dbFXyknFG+xoYFL2uxWIVC+IEB+7xC2zqUFwSc=;
        b=WYfdVY7kEVYAm8KG1Tydk/mnhbnr9pymePM+0MqN/8Y0Of3x+c8LznpFCfsRIZ7Ha3
         9El9ZEnkf16sYT2SH45JjMgarGJqSfwCUxUB/U+upNeSJpbgnuP8OnHUCPJj6pW6h9mj
         h/mrftB3kEOC98QN5XO2p9In+JOIMr5OiZfWUaznAXkdAnkNIWornMaKEBIRYCByW1R5
         DVScSfpd2JejXN5Zbz44RYqRgOnnCsWJ2OKmckMtwX7u+S8r0v4Yxbj7Pdaz+kAHVEC2
         lNVafIiUDLQeA4q484xZPutiAyGz9voreqaBF7OCFyg1VMFIFkM28jcEi788qUS+32wY
         kxOQ==
X-Gm-Message-State: AOAM532A91lCbiDziGYPHrynsOS2YA1SxqPHC1k/fo9iEhLjlRwsL+0q
        3E1qyoMaYowrdZfdjop69KyTk0DBrnic9ecGefN6IA==
X-Google-Smtp-Source: ABdhPJyPUYUhTA7ZwgH8jo3MfY2NUldDSUZwBUe+PjpACyXQEbBrAmTn2pGTqyellwWFMuv9G9LvWhR2OIXXWG8rOvc=
X-Received: by 2002:ac2:46d0:: with SMTP id p16mr19415538lfo.23.1626723483858;
 Mon, 19 Jul 2021 12:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210608154805.216869-1-jean-philippe@linaro.org>
 <c29ff5c8-9c94-6a6c-6142-3bed440676bf@arm.com> <YPW+Hv3r586zKxpY@myrica>
In-Reply-To: <YPW+Hv3r586zKxpY@myrica>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 19 Jul 2021 12:37:52 -0700
Message-ID: <CAOQ_QsjyP0PMGOorTss2Fpn011mHPwVqQ72x26Gs2L0bg2amsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] KVM: arm64: Pass PSCI to userspace
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexandru Elisei <Alexandru.Elisei@arm.com>,
        salil.mehta@huawei.com, lorenzo.pieralisi@arm.com,
        kvm@vger.kernel.org, corbet@lwn.net, maz@kernel.org,
        linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
        catalin.marinas@arm.com, pbonzini@redhat.com, will@kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 11:02 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
> We forward the whole PSCI function range, so it's either KVM or userspace.
> If KVM manages PSCI and the guest calls an unimplemented function, that
> returns directly to the guest without going to userspace.
>
> The concern is valid for any other range, though. If userspace enables the
> HVC cap it receives function calls that at some point KVM might need to
> handle itself. So we need some negotiation between user and KVM about the
> specific HVC ranges that userspace can and will handle.

Are we going to use KVM_CAPs for every interesting HVC range that
userspace may want to trap? I wonder if a more generic interface for
hypercall filtering would have merit to handle the aforementioned
cases, and whatever else a VMM will want to intercept down the line.

For example, x86 has the concept of 'MSR filtering', wherein userspace
can specify a set of registers that it wants to intercept. Doing
something similar for HVCs would avoid the need for a kernel change
each time a VMM wishes to intercept a new hypercall.

--
Thanks,
Oliver
