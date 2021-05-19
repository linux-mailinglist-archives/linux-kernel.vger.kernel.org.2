Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BE33886F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245184AbhESFsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348866AbhESFpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:45:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E54C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:41:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ot16so4824119pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Ao//7r1KFld4qVZ1tXpzzorSlFP6vtsPLPVYqG20G0=;
        b=DigzqK4GdOu/HgdltA+7CkfEWC3DDrxUDEut8nZl4w7mYY+abYcumxMRYwNdPazlcQ
         hZwdeOoqQCRyH/IJVIbx7u5JsEQp3koYrSAcUu4Bs7dqaOGtc85ogx64GdzwfXAiYg4y
         gHaRXNUYM7ssVx4xi/bK+U1B5bubY4WMmSDxEsoVgO4TJ0eN+sHUkahea23M1/XXuigN
         4nY3uekDRNR/xaeR049tVB1HXhOihgQFOwE4TY8QnVdMGtkYOCLTJ5OBybaqnjV7MCAq
         Qnooo2JEOMCg0CrikKZi9PPskMSLvrWWhPdRQfoQvl1Nwfz4AZSdTsiBAhHBNguFGjv+
         L1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Ao//7r1KFld4qVZ1tXpzzorSlFP6vtsPLPVYqG20G0=;
        b=pnLH9PQ4+jB465f4tMUKWCpn1kXJb95KtnmsQV4Zl6fJRMqZgYj4vwVB7Y97cYlQos
         0BHGh0jWcgwNZb7p6Fv/iGJMAJ2Xern8x33cCgP6hK1WYJLLAsM93zb76YwEjzEfAqhT
         iOCj4zXB8zP2NCjCVntUKkXYNP+XTi5l0rCvsjgiCH/c7iT2eENYydzEQ6zVF4p2PMZX
         qFyEJ9wAWtSfCCgKnkSJDF120Fx9uLIGRQzdAp98vaPVIY3Jq7NpKmpzE7HAm5LpH8JL
         GrsbAl/RMgo/S9gtgNz9888Ze114A2ilcMbwrAcOLh7/UZuElSN2iZlMzK5LUgb+F9E6
         YwyA==
X-Gm-Message-State: AOAM530Q0unYlag9YlbPjhdeSRirQSv5xImcLpEG9v8v+YT8aZekKaxY
        YNWHzqRhvzbzOhFtxbD2eNMpEhJ5liadzA1uFOmo2A==
X-Google-Smtp-Source: ABdhPJymSSPRYI+9qpROTR12WK1J8yU5xK+sJWHNGj0HyH48UspUw6MPn6/2+CPKH19SOJ8VF/J6MwGzb5tcOSmG0co=
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr5813526pjb.168.1621402917077;
 Tue, 18 May 2021 22:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-5-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-5-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 18 May 2021 22:41:40 -0700
Message-ID: <CAAeT=FzCs5GUC448TmNoUeG_mrB0VR6riop11A-3bfk2PUvrxw@mail.gmail.com>
Subject: Re: [PATCH 04/43] KVM: SVM: Fall back to KVM's hardcoded value for
 EDX at RESET/INIT
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 5:47 PM Sean Christopherson <seanjc@google.com> wrote:
>
> At vCPU RESET/INIT (mostly RESET), stuff EDX with KVM's hardcoded,
> default Family-Model-Stepping ID of 0x600 if CPUID.0x1 isn't defined.
> At RESET, the CPUID lookup is guaranteed to "miss" because KVM emulates
> RESET before exposing the vCPU to userspace, i.e. userspace can't
> possibly have done set the vCPU's CPUID model, and thus KVM will always
> write '0'.  At INIT, using 0x600 is less bad than using '0'.
>
> While initializing EDX to '0' is _extremely_ unlikely to be noticed by
> the guest, let alone break the guest, and can be overridden by
> userspace for the RESET case, using 0x600 is preferable as it will allow
> consolidating the relevant VMX and SVM RESET/INIT logic in the future.
> And, digging through old specs suggests that neither Intel nor AMD have
> ever shipped a CPU that initialized EDX to '0' at RESET.
>
> Regarding 0x600 as KVM's default Family, it is a sane default and in
> many ways the most appropriate.  Prior to the 386 implementations, DX
> was undefined at RESET.  With the 386, 486, 586/P5, and 686/P6/Athlon,
> both Intel and AMD set EDX to 3, 4, 5, and 6 respectively.  AMD switched
> to using '15' as its primary Family with the introduction of AMD64, but
> Intel has continued using '6' for the last few decades.
>
> So, '6' is a valid Family for both Intel and AMD CPUs, is compatible
> with both 32-bit and 64-bit CPUs (albeit not a perfect fit for 64-bit
> AMD), and of the common Families (3 - 6), is the best fit with respect to
> KVM's virtual CPU model.  E.g. prior to the P6, Intel CPUs did not have a
> STI window.  Modern operating systems, Linux included, rely on the STI
> window, e.g. for "safe halt", and KVM unconditionally assumes the virtual
> CPU has an STI window.  Thus enumerating a Family ID of 3, 4, or 5 would
> be provably wrong.
>
> Opportunistically remove a stale comment.
>
> Fixes: 66f7b72e1171 ("KVM: x86: Make register state after reset conform to specification")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
