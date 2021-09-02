Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE5E3FEEEB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345272AbhIBNrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232466AbhIBNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630590369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PcQKXY/cQKOdShIe+YVlSE7XvlfimtQWI3kVCVJqZrE=;
        b=b1vzPZ9JXu6L4cVcxglXRIxWoBlHaNFzfNCD16uPWuJtdIGzE1muhCtqUpgQLo+uk7PxNL
        qE4v6sP3bVJgP0lZAwNCONOyQ9/dyywl1crKQfpH6jvdVQctCmUbjr0U7l38y3j6BAHsfv
        BX89nUKMUDI+DKq6nBs3w2R8QWDMKMk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-RO3ZDOHIPi6eB6d5aRBl-A-1; Thu, 02 Sep 2021 09:46:08 -0400
X-MC-Unique: RO3ZDOHIPi6eB6d5aRBl-A-1
Received: by mail-qk1-f198.google.com with SMTP id x19-20020a05620a099300b003f64d79cbbaso1672623qkx.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 06:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PcQKXY/cQKOdShIe+YVlSE7XvlfimtQWI3kVCVJqZrE=;
        b=T7fK6du47wl5te1SkkfLFYdZUP0GuhltKIwFoFyPby6Y9gP8UUy3IilvsWWOmrM+iA
         4qLhyG0S1fJa1cAO9pH6FTMeSCcNTcGv6jBZSQpHZKLi3GREM5RIK1GW/Pzo1nkIjrP9
         gEeE3gEzy4Nal+eyzj9GcYTSMiqtfoB5S4c/b/QhEl4JxXir9trwZzdmVa24oJ68vCQH
         1ktWWRv4XlNMyBzY1hZlsx118HkA4dsJvG0n/aIlEXQK3f6Ik1a7sukZU2+Yop8jBAmc
         DH7hEemXV6+dHu2iw5WVuu0Wrap481eTmTIQq6aeikrF7vzAEmp3ognQhJdYCv9l2Dgw
         96nw==
X-Gm-Message-State: AOAM533kox6i3KA/z3j3C+SzeTM0nAEej9N06jaqziL0SaIEMmZQz9fE
        YFdzKa5exMARpKRIFaGXQqrlttxKxcUrJdO0ijZROAimvt9YBXo9Id18REEYXS45FXrDyxt7E7Q
        vVIVOIUFAahz6nq7BnGevDRxP
X-Received: by 2002:a0c:d804:: with SMTP id h4mr3371882qvj.37.1630590368155;
        Thu, 02 Sep 2021 06:46:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx83mm+WcK2lvoIW0v47pEySyGsM3Sm0Io+mwVAic5avZpGftQiWmMPlQQwHQjgqGnarNFYXg==
X-Received: by 2002:a0c:d804:: with SMTP id h4mr3371853qvj.37.1630590367962;
        Thu, 02 Sep 2021 06:46:07 -0700 (PDT)
Received: from gator (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id d20sm1413091qkl.13.2021.09.02.06.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:46:07 -0700 (PDT)
Date:   Thu, 2 Sep 2021 15:46:03 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 03/12] KVM: arm64: selftests: Add support for cpu_relax
Message-ID: <20210902134603.zqdaqa4yfndi2dmc@gator>
References: <20210901211412.4171835-1-rananta@google.com>
 <20210901211412.4171835-4-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901211412.4171835-4-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:14:03PM +0000, Raghavendra Rao Ananta wrote:
> Implement the guest helper routine, cpu_relax(), to yield
> the processor to other tasks.
> 
> The function was derived from
> arch/arm64/include/asm/vdso/processor.h.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  tools/testing/selftests/kvm/include/aarch64/processor.h | 5 +++++
>  1 file changed, 5 insertions(+)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

