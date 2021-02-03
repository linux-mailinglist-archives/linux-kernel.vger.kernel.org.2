Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB2030DEFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhBCP7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:59:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234714AbhBCP7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:59:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3128164F65;
        Wed,  3 Feb 2021 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612367918;
        bh=K59+ysyzksVMwJO4K3IQGFBLA+vh5P1R5hVr7mhTX0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fM7SFqDXMg/QLD8TWNvrnoM5MjHuJjnK5+czbDxVPpQB7YFw6x0QPXxQ7Rxb8F1kR
         gVZZp6gb+Jnnox8hFopqCHQGf2p2xvojEklQbWbZVDwsS9KNh9l/WhH16A5O37/pIu
         vrfBENpdvL7uvuFTjd3v3R36n1YJC2wnpv4iENRHC/FHtn1RzpqEwqn5sqfT2HDK6k
         eo5sHlz4fLAbf6h9gS1f8+RvlLyKufY9XU8svoGJrDDSiQurtaNJJWJGCtF6GWZF7E
         4cLwALUvcsouJrBAYugYyQNh67aXO1q8FVVTQP9RvvOtaaYB2ROzch5Ww7Johcnn6/
         /P9PkrZVj2/Ww==
Date:   Wed, 3 Feb 2021 15:58:32 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
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
Message-ID: <20210203155831.GG18974@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-24-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-24-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:21PM +0000, Quentin Perret wrote:
> Refactor __populate_fault_info() to introduce __get_fault_info() which
> will be used once the host is wrapped in a stage 2.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 36 +++++++++++++++----------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index 84473574c2e7..e9005255d639 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -157,19 +157,9 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
>  	return true;
>  }
>  
> -static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
> +static inline bool __get_fault_info(u64 esr, u64 *far, u64 *hpfar)

Could this take a pointer to a struct kvm_vcpu_fault_info instead?

Will
