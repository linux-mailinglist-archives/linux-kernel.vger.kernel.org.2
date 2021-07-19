Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6900C3CD5BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbhGSMvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbhGSMvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:51:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBC3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 05:53:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so10522420wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e+7w0DILOdROevsETjkyzSOUy+VWGNhHDOlUAzj7VhU=;
        b=Ph0oVZBQZWDgTvH3+Q60TivzYxq/EWsXd41TTstiMh3CZ3iKOU2e+qg7m36V23hlGu
         Rk6Js9o4z83GYzvt/FvwvBeisUojOCPTZd5QMlhAmiva/qZIzft7AUnDFYptkQkBF4gJ
         qqCXXlEwYtMjrLc6XHGv7oE+4mNCzUpTME5gxefXghyIaUzLFWfyU7kVPpA2+GpBhl+K
         1gf60PNupu9PenlLG28WQbgLGUYzGAZ3qXty5Hn7Y3F7vOVgYwdCq/oyJ+b0+ZwOcz1l
         jjvkoxnRJ/rDUkLNHUvORoQ55Tpg6NjXO1dJ5Ca3ugDYdHfbqxmgowt6ipRXVeC94vJZ
         tuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e+7w0DILOdROevsETjkyzSOUy+VWGNhHDOlUAzj7VhU=;
        b=BEnoQlqQkquE42j/X1J7JHpuBzaPYu7dn+fcqHJcfp3rT4aXGoeWE3B3yqRyp4phNg
         0gy/EpRbPo/VNsfyn4Cy1poN/cJ6hAhQKpqc/g3gU0SS/8QpcXlj328iIQpBXLQTq1ne
         1ExlajWiaj8XQBBha41FsJUgHY8FxH5dBr7oTSnHPhV266howegR/L1nuHZhU9m9JK6V
         KyD8q2YEK/Jq1lngvQFfbRPL1y7vE0MHU/JBLtinrO7ijhfN1NfDwS0gw4QvL9gvr8qr
         Be04lO/jYLvh7zCOuWQXvI18Kaa4bCyz2mrSMrmTKqFYZsTfc3f9C6pKzAL8baGMDZIi
         XTaw==
X-Gm-Message-State: AOAM5307HT/DwtBSsjF2qvtekX+rTqdWN7VnEjFPEA3TnqNkMJkCzqq+
        mgA3XOrwLB1e7TdVXtSn9wsc9w==
X-Google-Smtp-Source: ABdhPJxD0sq1Omt7X50ZoMJy9SEY47bAIcfJMuUmV8iseFr7tGbOTs9v5GyO/p3WxY358ATqNVhqWA==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr26551985wmj.144.1626701534460;
        Mon, 19 Jul 2021 06:32:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
        by smtp.gmail.com with ESMTPSA id t16sm7778118wmj.16.2021.07.19.06.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 06:32:13 -0700 (PDT)
Date:   Mon, 19 Jul 2021 14:32:10 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 03/14] KVM: arm64: Continue stage-2 map when re-creating
 mappings
Message-ID: <YPV+2jQ/Q/ie14Fn@google.com>
References: <20210719104735.3681732-1-qperret@google.com>
 <20210719104735.3681732-4-qperret@google.com>
 <87lf62jy9z.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf62jy9z.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 Jul 2021 at 13:14:48 (+0100), Marc Zyngier wrote:
> On Mon, 19 Jul 2021 11:47:24 +0100,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > The stage-2 map walkers currently return -EAGAIN when re-creating
> > identical mappings or only changing access permissions. This allows to
> > optimize mapping pages for concurrent (v)CPUs faulting on the same
> > page.
> > 
> > While this works as expected when touching one page-table leaf at a
> > time, this can lead to difficult situations when mapping larger ranges.
> > Indeed, a large map operation can fail in the middle if an existing
> > mapping is found in the range, even if it has compatible attributes,
> > hence leaving only half of the range mapped.
> 
> I'm curious of when this can happen. We normally map a single leaf at
> a time, and we don't have a way to map multiple leaves at once: we
> either use the VMA base size or try to upgrade it to a THP, but the
> result is always a single leaf entry. What changed?

Nothing _yet_ :-)

The 'share' hypercall introduced near the end of the series allows to
share multiple physically contiguous pages in one go -- this is mostly
to allow sharing data-structures that are larger than a page.

So if one of the pages happens to be already mapped by the time the
hypercall is issued, mapping the range with the right SW bits becomes
difficult as kvm_pgtable_stage2_map() will fail halfway through, which
is tricky to handle.

This patch shouldn't change anything for existing users that only map
things that are nicely aligned at block/page granularity, but should
make the life of new users easier, so that seemed like a win.

> > To avoid having to deal with such failures in the caller, don't
> > interrupt the map operation when hitting existing PTEs, but make sure to
> > still return -EAGAIN so that user_mem_abort() can mark the page dirty
> > when needed.
> 
> I don't follow you here: if you return -EAGAIN for a writable mapping,
> we don't account for the page to be dirty on the assumption that
> nothing has been mapped. But if there is a way to map more than a
> single entry and to get -EAGAIN at the same time, then we're bound to
> lose data on page eviction.
> 
> Can you shed some light on this?

Sure. For guests, hitting the -EAGAIN case means we've lost the race
with another vCPU that faulted the same page. In this case the other
vCPU either mapped the page RO, which means that our vCPU will then get
a permission fault next time we run it which will lead to the page being
marked dirty, or the other vCPU mapped the page RW in which case it
already marked the page dirty for us and we can safely re-enter the
guest without doing anything else.

So what I meant by "still return -EAGAIN so that user_mem_abort() can
mark the page dirty when needed" is "make sure to mark the page dirty
only when necessary: if winning the race and marking the page RW, or
in the permission fault path". That is, by keeping the -EAGAIN I want to
make sure we don't mark the page dirty twice. (This might fine, but this
would be new behaviour, and it was not clear that would scale well to
many vCPUs faulting the same page).

I see how this wording can be highly confusing though, I'll and re-word
for the next version.

Cheers,
Quentin
