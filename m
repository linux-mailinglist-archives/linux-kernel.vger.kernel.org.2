Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD1D337D80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 20:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhCKTRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 14:17:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhCKTRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:17:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F13364E21;
        Thu, 11 Mar 2021 19:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615490243;
        bh=/fgB/prtT+9RLH2N2jUcU7RYPTvAJNdzfvwKlhf2uGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n4uo0tkIXihBJA/SKKfXmICFMT1onRMFDghteyFbkMpvQ+MLw3qWaNYlaUqfQxRu3
         b+iAXIiFmn+UDfv5KgnxM6HaJOkRRDET5e5vKu+KqtC/O5yCsu2+Wd01CBuCMcaZuK
         Mrqdn0rF4GNHAYaY0slMJiWUwZuOq+7X8a0I6iDMTZo+wkZM/gQo09H0H+VQbZ78O/
         LDrgGduWiCxlER2mWpLCf/FZLvOD/2lShq7oHXvQZSLmNP5woAWg1ZDd2Wlk0YqE3R
         MJ9fW0/oj1kDTrQyVuv0RLxaL+wh9wqpkiKpUubYkf9Rwyj4p/85aywSwtG+Mb443l
         xXG+bN91/D2Zg==
Date:   Thu, 11 Mar 2021 19:17:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 34/34] KVM: arm64: Protect the .hyp sections from the
 host
Message-ID: <20210311191716.GD31586@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-35-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-35-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:57:51PM +0000, Quentin Perret wrote:
> When KVM runs in nVHE protected mode, use the host stage 2 to unmap the
> hypervisor sections by marking them as owned by the hypervisor itself.
> The long-term goal is to ensure the EL2 code can remain robust
> regardless of the host's state, so this starts by making sure the host
> cannot e.g. write to the .hyp sections directly.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h              |  1 +
>  arch/arm64/kvm/arm.c                          | 46 +++++++++++++++++++
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  9 ++++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 33 +++++++++++++
>  5 files changed, 91 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
