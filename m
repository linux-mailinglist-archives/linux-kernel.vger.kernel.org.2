Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA840310F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346053AbhIGWac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhIGWaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:30:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0911C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 15:29:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z2so829402lft.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLneQ0gyxHkkDtfnQOD0UsHJuuTR6tVk0d26lWCdN+E=;
        b=ilpTH5u3Qk+WishFjyAu6KuJqTJ09gPdjP8PRQUVAZZ8eHQKhJ2bCX/cXDHRP3gikt
         WPhA5uyLi+Kn864Yw/ptwhh4k8sZACwGNGzFACwidZrUdslXW5JyOEhGYPjMP8J4If1D
         +hdwO078kHDUEod1IiW+++jnRc2Wa2yTlsMX3E+3VP5l4QHx8Zmr8/DtxOr7s/aa5m30
         l5WI75VZ8VmlvyEE2xBy/9hopqcKSgUejybHURPW+Z9+lyyXGLw1mHtQN2rk9zAjV63e
         9VWf6KKIPgW5l77HdCxYUaKpHBEZK1EHJgBsgcOYxexJi/fzkcclBB9OuO47GMqszF5+
         2zrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLneQ0gyxHkkDtfnQOD0UsHJuuTR6tVk0d26lWCdN+E=;
        b=MwqVWEgTjxJUg5QvDqihjQfLrKzv3+ztwaYCZDd+LUjNo/XYzd6OLXor/VGge95ZKj
         /qIZCATl5BQiF0Ktkj1aMxglI0tNbRccYtXd2MD/7OndP4TqhHTeLvPd9wZt1Be3skQm
         JLSCvRxOGnkGdSFKWnPcijhUsB7g71a0LPNeG/Jpp2PCQv3rWnmILGEAWSYWi+Depb5Z
         u9AGAX5BLvNm3En61PbpT6RkzbxLOkd8tvOj/DZeP2oP5jgZzphrEdJJ59/KSg9ep8qf
         qeat8BP0sAu1k7FTKvUsr2ab/1tSY+FXRSsvcA3n4LJZb5MwvtbTPoIebFUtlz7okEBn
         ozIg==
X-Gm-Message-State: AOAM532pZsy//l/oOVeB4fw95+KFEh1S9/eMBUiSIWeWHvzeehMGT4of
        mg/QgISKHinJTTXgBpDLU2f7pr1HTShqZVY9G/L3ug==
X-Google-Smtp-Source: ABdhPJy+3Fh2/TUVFm2riSjDONzsxcAbvhzevvTtD3GSMOgR57hNrnLarHgePQ+7B7Wi7nNxEH3/MU1B/tOUfL166CA=
X-Received: by 2002:a05:6512:36d9:: with SMTP id e25mr432276lfs.553.1631053761858;
 Tue, 07 Sep 2021 15:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210907123112.10232-1-justin.he@arm.com> <20210907123112.10232-3-justin.he@arm.com>
In-Reply-To: <20210907123112.10232-3-justin.he@arm.com>
From:   Oliver Upton <oupton@google.com>
Date:   Tue, 7 Sep 2021 17:29:11 -0500
Message-ID: <CAOQ_QsjOmHw+545J0T9i-nWV2bVGGEwHq5SPVvBOM-SHMXpP5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: arm64: Add memcg accounting to KVM allocations
To:     Jia He <justin.he@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Liu Shixin <liushixin2@huawei.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jia,

On Tue, Sep 7, 2021 at 7:33 AM Jia He <justin.he@arm.com> wrote:
>
> Inspired by commit 254272ce6505 ("kvm: x86: Add memcg accounting to KVM
> allocations"), it would be better to make arm64 KVM consistent with
> common kvm codes.
>
> The memory allocations of VM scope should be charged into VM process
> cgroup, hence change GFP_KERNEL to GFP_KERNEL_ACCOUNT.
>
> There remain a few cases since these allocations are global, not in VM
> scope.

I believe there are more memory allocations that could be switched to
GFP_KERNEL_ACCOUNT. For non-pKVM kernels, we probably should charge
all stage-2 paging structure allocations to the VM process. Your patch
appears to only change the allocation of the kvm_pgtable structure,
but not descendent paging structures.

--
Thanks,
Oliver
