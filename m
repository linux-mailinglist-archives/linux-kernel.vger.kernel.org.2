Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58830AFA7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhBASml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:42:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232173AbhBASmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:42:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1757A64DDF;
        Mon,  1 Feb 2021 18:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612204905;
        bh=8fU4c65Z1m9hAEXTu2nO/7NiTyQYV8Nb3hUN/A9d9Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G93LfQThWoA3J0Ubyc13/PnHLPhueMAMe0lXcjaaX7CEGBd9sg5xj3kG3sWGzMa8j
         H6cMnZWXdJ9NLf8e3WUAh8gCfsbN5msU+B7CREiIJUdPqqh+jtCihLxeymamPOTSn2
         +RYAbHscpO9ESQIyQ3eTkortaed8fnGphCAQfsW3r5nZPzvPQ5Z8+kq0JNp8vGJT8B
         PfSGbvVr/pRUY6ZcODZVuLsZBYIOlxXO69S8WPaHO373WmeabGpXV59/R/Rm/4wQ/s
         NCpod4Jnz01Witb4Vj8OlMJaNBtDj0WMnLXZRAIl/i15QLW+Lw3QuUPk/eWrfcdmL1
         0cx62+JEpnm8Q==
Date:   Mon, 1 Feb 2021 18:41:39 +0000
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
Subject: Re: [RFC PATCH v2 08/26] KVM: arm64: Make kvm_call_hyp() a function
 call at Hyp
Message-ID: <20210201184139.GG15632@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-9-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-9-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:06PM +0000, Quentin Perret wrote:
> kvm_call_hyp() has some logic to issue a function call or a hypercall
> depending the EL at which the kernel is running. However, all the code
> compiled under __KVM_NVHE_HYPERVISOR__ is guaranteed to run only at EL2,
> and in this case a simple function call is needed.
> 
> Add ifdefery to kvm_host.h to symplify kvm_call_hyp() in .hyp.text.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
