Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD94431629
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhJRKed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJRKec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:34:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E54C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:32:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b189-20020a1c1bc6000000b0030da052dd4fso8056637wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gy0sHksnt+PEnqqXO6xICRTdN60Lc9eTfBQpwKge7yw=;
        b=O4of8n6X9NBPN4KWNWUJs/0mWzTc116qBuKDx3ncFthvjhtsyL5DV2kBO0oVRG2oIh
         R23RzUj3/dJp4qwHQHvuk/y2x51na6lRlbVwxnC+9CRpBOCwDAH4UlgfsJbVmB2x5lRg
         G2j+W0EWHRCCZkLvZP6GgzrSINGeENXTpyB0hfVC98NkB9ys1AwlyGsqdfPTfp4b0JkN
         y5IHHrIP08Poykj/HOb4KUgeMZLIBJ66URZVb6eYlcauxcx9uNn0wIvWtyoNmHgmuqPj
         7OosgV3O9JTZndiBJb0m0eNQEc5ibTOxG49zYgd1cERqKbT87xl5CKEuPRsyq6VOnQv9
         fJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gy0sHksnt+PEnqqXO6xICRTdN60Lc9eTfBQpwKge7yw=;
        b=dIfIiANwNDlpkItJ/foXt8FW9aVzt6/8AJBxLF30eT+VrCCdbOCNLC4YtcLUsva6G8
         qoz+lOU2m+b2EOE+U7d0icTsu1Uzx1nKGAU99j4EqM5mca4M+/fQ+Vxmq1N9pIVwH8/a
         ailwNHd/ytY4OVsCKZIogGzaHaQvry3M/RyYn11AE8u6r7wLjBD5qYWPQ45rkgOKGTCA
         oy9wbNDW35hxtcI8bptstWh5hR50Fv/mkuHwSvU8zwtmyHOaB+rrurkrJndqRWrS4++r
         AnX6m+y8ZWP0COr5iKIbG8Be+hV2mmuUJsRw9lsYzHHRvZn6PuOmoehXGH2C8HHhljbz
         9PAg==
X-Gm-Message-State: AOAM531LIbS5QMF8iMmOlpmYfB4PrGylDqunO/0+YQrwuccGE9XMf21m
        6uSKn9d48mZeB8q3b19caevJyA==
X-Google-Smtp-Source: ABdhPJz+FBDbOuFngAsn1vKBnLFL7clNmJbT3DoPREC11e6c1F2lUuWQ/TmDO8FETn0vXuk/SALxwg==
X-Received: by 2002:a1c:1d13:: with SMTP id d19mr29804562wmd.190.1634553139612;
        Mon, 18 Oct 2021 03:32:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:ba81:6f1b:ab2e:f120])
        by smtp.gmail.com with ESMTPSA id d24sm11609621wmb.35.2021.10.18.03.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 03:32:19 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:32:13 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 16/16] KVM: arm64: pkvm: Unshare guest structs during
 teardown
Message-ID: <YW1NLb9Pn9NyEYZF@google.com>
References: <20211013155831.943476-1-qperret@google.com>
 <20211013155831.943476-17-qperret@google.com>
 <87h7dhupfa.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7dhupfa.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 Oct 2021 at 13:25:45 (+0100), Marc Zyngier wrote:
> At this stage, the old thread may have been destroyed and the memory
> recycled. What happens if, in the interval, that memory gets shared
> again in another context? My guts feeling is that either the sharing
> fails, or the unshare above breaks something else (the refcounting
> doesn't save us if the sharing is not with HYP).

Aha, yes, that's a good point. The problematic scenario would be: a vcpu
runs in the context of task A, then blocks. Then task A is destroyed,
but the vcpu isn't (possibly because e.g. userspace intends to run it in
the context of another task or something along those lines). But the
thread_info and fpsimd_state of task A remain shared with the hypervisor
until the next vcpu run, even though the memory has been freed by the
host, and is possibly reallocated to another guest in the meantime.

So yes, at this point sharing/donating this memory range with a new
guest will fail, and confuse the host massively :/

> In any case, I wonder whether we need a notification from the core
> code that a thread for which we have a HYP mapping is gone so that we
> can mop up the mapping at that point. That's similar to what we have
> for MMU notifiers and S2 PTs.
> 
> This is doable by hooking into fpsimd_release_task() and extending
> thread_struct to track the sharing with HYP.

I've been looking into this, but struggled to find a good way to avoid
all the races. Specifically, handling the case where a vcpu and the task
which last ran it get destroyed at the same time isn't that easy to
handle: you end up having to maintain pointers from the task to the vcpu
and vice versa, but I have no obvious idea to update them both in a
non-racy way (other than having a one big lock to serialize all
those changes, but that would mean serializing all task destructions so
that really doesn't scale).

Another option is to take a refcount on 'current' from
kvm_arch_vcpu_run_map_fp() before sharing thread-specific structs with
the hyp and release the refcount of the previous task after unsharing.
But that means we'll have to also drop the refcount when the vcpu
gets destroyed, as well as explicitly unshare at that point. Shouldn't
be too bad I think. Thoughts?

Thanks,
Quentin
