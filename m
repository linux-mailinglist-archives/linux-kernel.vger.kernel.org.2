Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6DE30F50F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhBDOdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbhBDOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:19:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35510C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:18:46 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u14so3721942wri.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1A5jaGMH8v+8RmdU0UTE1kbhV4vjjan/ogFcu70QFBM=;
        b=kRbGsvSTuji0iv5YtpH4MYYQqNnFddgufEy4QsAH7R2fLfOK7onqaAUtIbALHOKYnc
         NAEQ9am67BI4JNDLRDj0tSJ5nfUszcCN6tSuhpwWcque/KXCX4cfDO0U8JK43+dsj+vx
         1Y2kxvNZSdfgt2n4gKlVaxpCgAK0iZg3HekpS3oJRCfDdxiInXL1wH/eS5ZTRCsd5C47
         zoHUZ9lKr0b9hqj1r4cvMY40hRG5umkYAWcWVgdL1nqFt4TxFku5KNI0DDFSqHDOJQ29
         ENRRELa3ERiq5FgRUFXRNakDuEhpvvsXdHWHvn6eCuVv5LdB57u6hIYKryT8KZJ0fgD4
         sj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1A5jaGMH8v+8RmdU0UTE1kbhV4vjjan/ogFcu70QFBM=;
        b=QihJDFwrcUzSsucIUIDPDtLpob8VrWqDEZu+76znGHuOZTNvDCMEnFRvJcuIG7US2i
         coB+EbIh18RxWBIfFa6zKCVuM6FeLf5vPnO2ChCxqUJETddbaSUveAgucMRq2v/DVssw
         C4m/zaxuL+2SjuNv2uAkwlTo9DwN+mmexWMUe6hbdzh3d8vimgFlCx/HT9hEu6hkZEXf
         RM5xc3tImgiEwvU5PHvAAz1penkQ8ebP1l+WdkpmL27xsXZLEH/4P3lWTxKscYCavUhZ
         cu/4BT+5QLzWFgDH+CT6szTI1KYbvfDpP7tqdi5wRLM/oAxg3KKv7dqB+hx+BT6JM0mc
         EAyA==
X-Gm-Message-State: AOAM5321kAIFzsGf37dq6EChl1LxXjUsSn9lwHQZrLFqjhIK9VXqvUF/
        Q5ltpBYFy9WemX+yA9amgRCD/g==
X-Google-Smtp-Source: ABdhPJwmxlEADo2pamrd4+uG+uA5gIHQiPMR8XnPrPRMCr82leKGAKYaVIlc3piIwQdzJpEdnxUfkQ==
X-Received: by 2002:adf:9148:: with SMTP id j66mr10034560wrj.28.1612448324809;
        Thu, 04 Feb 2021 06:18:44 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id 35sm9159761wrn.42.2021.02.04.06.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:18:43 -0800 (PST)
Date:   Thu, 4 Feb 2021 14:18:41 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 23/26] KVM: arm64: Refactor __populate_fault_info()
Message-ID: <YBwCQVi2JUxKUy9Y@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-24-qperret@google.com>
 <20210203155831.GG18974@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203155831.GG18974@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 Feb 2021 at 15:58:32 (+0000), Will Deacon wrote:
> On Fri, Jan 08, 2021 at 12:15:21PM +0000, Quentin Perret wrote:
> > Refactor __populate_fault_info() to introduce __get_fault_info() which
> > will be used once the host is wrapped in a stage 2.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/hyp/switch.h | 36 +++++++++++++++----------
> >  1 file changed, 22 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> > index 84473574c2e7..e9005255d639 100644
> > --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> > +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> > @@ -157,19 +157,9 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
> >  	return true;
> >  }
> >  
> > -static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
> > +static inline bool __get_fault_info(u64 esr, u64 *far, u64 *hpfar)
> 
> Could this take a pointer to a struct kvm_vcpu_fault_info instead?

The disr_el1 field will be unused in this case, but yes, that should
work.

Cheers,
Quentin
