Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA615345B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhCWJsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhCWJry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:47:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E725C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:47:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id 61so20029994wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CFy34a5oRP6FBo34jkzCBDrM18ET5oxeV6C09KGor/M=;
        b=fLnTZIW+ncV0V4pak/1zB/4eGA2vCG0u8582JlaRuKJaekepck3Hi51f15dz/ZWlxz
         sQUvU6WQ+PnQl5ejeXthi6pN4WHunjYv9+RVag/vl+JjIlaFfcjUiJj2SdcFMJdSpcEN
         4fbKMtXCvaxkH5oqnf983GkVGeMgxjerVGs3H0Xnw48l0XHHV5AgEkQisTeP3US4wJ1i
         M+MOMHNzAbxPAZ1zFxg5Qx8q7oLZhxqoomj51Gs9va0UXqRKA9cDLvg/wDDQO7/9rCI2
         aYm0pJQgp8mSu9HyMPZBMGm3YhgaA2hVcvcQWQrBNUheqOFP+G6LTR1Y+m4Bp5w1e9+H
         feMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CFy34a5oRP6FBo34jkzCBDrM18ET5oxeV6C09KGor/M=;
        b=n4xb8YLZhiIdadJ7iUOL8baEoUoLpSO724BvKnU1GcFZAkqUjuEkS+3tVpNYYEin3z
         dQVQwbv2guYNTJJGgi+9JudRn4vk8HjITsm9zIvMitzQ1soE8R0aTkB8uwuORxhf0nGY
         0sxklv2rvC9WKyrfPBrI6Zh3C56QCjI9HjxIy8ep5hYmsy+S30UmvLXTXqsc/Yx2Jn6z
         cAMsgS/gut+8FQaon7kJIEnHqeP7wA9uznHzDP5gBUIWwU41Vroeo5U3GjWMquuPHio0
         gz1YZzqe67wMD8j1vkYV0uTqJt21GjEW/5hgptZHpnSyfA/meYXU+bugBIlToDeMA0sX
         OWIw==
X-Gm-Message-State: AOAM532Mk6gAko5ih7O69fk/mymcHwJTvDLvhkyGFo5q3qwLY9F5kMQd
        L6M3l4CcvjdYeHAtaaHMxPzz3Q==
X-Google-Smtp-Source: ABdhPJy48bd7zMN/7IQI/7qwsmEMtZoUKMwW7NIyR6X4/+xBeETwQsu0Z7rjmuADJ6dWg+IBGOQErA==
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr3023308wrx.35.1616492873041;
        Tue, 23 Mar 2021 02:47:53 -0700 (PDT)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id h62sm2322264wmf.37.2021.03.23.02.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:47:52 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:47:50 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     catalin.marinas@arm.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        tabba@google.com, ardb@kernel.org, mark.rutland@arm.com,
        dbrazdil@google.com
Subject: Re: [PATCH v2 3/3] KVM: arm64: Drop the CPU_FTR_REG_HYP_COPY
 infrastructure
Message-ID: <YFm5Rsz8HlKo2sss@google.com>
References: <20210322175639.801566-1-maz@kernel.org>
 <20210322175639.801566-4-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322175639.801566-4-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 Mar 2021 at 17:56:39 (+0000), Marc Zyngier wrote:
> Now that the read_ctr macro has been specialised for nVHE,
> the whole CPU_FTR_REG_HYP_COPY infrastrcture looks completely
> overengineered.
> 
> Simplify it by populating the two u64 quantities (MMFR0 and 1)
> that the hypervisor need.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
