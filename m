Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF23939D6B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhFGIGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGIGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:06:48 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930BBC061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 01:04:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so11995171wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 01:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=45tZHTOhPWrMm2QuGwxst35nsbkg8Cc+rbe4pv2DS3s=;
        b=kIsPzVm/6HfQ2rSo6tvkvnj7PQ6cJswWvGgwdkdgaH6igE7n3GHPEMG2vp4Z472uwB
         +KsYt5wzp2s9ftXX/i4EIBLcJJxmFL4qHM5xrQibJ27PSXZLrogYgU+O7HQZGR+iyAcp
         ENqqFR0FScR0zbmHj60qWp3rM2QnSbnXLNJCCWzx48KNOVPLofYBkXxm2MKyVbnpoaEi
         VJ0S4j/02+fK0RKfpkMJgSC1sOAzhVdo9mdLOvhwevYnuhSQzcP/zVsLUUlTiGrBi8mP
         Z7vBYKauVcdW7lLENQosyuNUX/zVoCIl0Ac6KBIXKDIAfV+f1nQstXLthFWW2QDqXWoB
         sxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=45tZHTOhPWrMm2QuGwxst35nsbkg8Cc+rbe4pv2DS3s=;
        b=CM6B4thNxcKuRVAYJHFh9avFAQGxT9xES3p7Av1oTOjSqN8XZXpLsjs3wanlkMzxij
         i5ulx5tjepzHR/6BZJwlBAgn4eu+w4V2KQaNFpKSYJxeHGLc52Su7eB9xUE6gl7BrNnk
         B6SBU6gJAkeCF3s7cyzfCtN9nh5Pa2dxjgL95FspWN9rKczKm/vPB4inYPdljvPYYbF5
         sxr9jO9SvZ3kyYF8p+CcOZXZLfpZIC/C4jgZasw5GPUCwwKMentaIRQ4/qzxtg16Smpg
         DbILF1fMNvF+cmkuWDT9srFD2xGy1EWLvVPDbi5zNM04jX4JfkDiOuBVTlTlMrMcUQ4R
         PyWA==
X-Gm-Message-State: AOAM532ngeUnGcrt+ZADwETj9suynrwTzFG9K6R6K049z1QMWJWEpEvU
        mXIje4kTQs4X2DvznYCnSRkcnQ==
X-Google-Smtp-Source: ABdhPJxhLwD0/g3fyDKT04YjO9SBSS50dsCkWXljDRLq8PTa8wtbKxGm26XKKJlsPURCnhuE70CeEQ==
X-Received: by 2002:a7b:c098:: with SMTP id r24mr15440340wmh.35.1623053096135;
        Mon, 07 Jun 2021 01:04:56 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id k5sm275646wmk.11.2021.06.07.01.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 01:04:55 -0700 (PDT)
Date:   Mon, 7 Jun 2021 08:04:52 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     will@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] KVM: arm64: Unify MMIO and mem host stage-2 pools
Message-ID: <YL3TJDlMNCyq7JK3@google.com>
References: <20210602094347.3730846-1-qperret@google.com>
 <20210602094347.3730846-5-qperret@google.com>
 <b4e4647166447d8fd22b360369de4acb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4e4647166447d8fd22b360369de4acb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 Jun 2021 at 11:31:20 (+0100), Marc Zyngier wrote:
> On 2021-06-02 10:43, Quentin Perret wrote:
> > We currently maintain two separate memory pools for the host stage-2,
> > one for pages used in the page-table when mapping memory regions, and
> > the other to map MMIO regions. The former is large enough to map all of
> > memory with page granularity and the latter can cover an arbitrary
> > portion of IPA space, but allows to 'recycle' pages.
> > 
> > However, this split makes accounting difficult to manage as pages at
> > intermediate levels of the page-table may be used to map both memory and
> > MMIO regions. Simplify the scheme by merging both pools into one. This
> > means we can now hit the -ENOMEM case in the memory abort path, but
> > we're still guaranteed forward-progress in the worst case by unmapping
> > MMIO regions. On the plus side this also means we can usually map a lot
> > more MMIO space at once if memory ranges happen to be mapped with block
> > mappings.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> 
> This patch fails to apply on top of -rc4. Did you use some more exotic
> base or, as I suspect, a development tree?
> 
> Please check and respin the series if necessary.

I used kvmarm/next, but clearly an out-of-date one. I'll respin -- sorry
about that.

Thanks,
Quentin
