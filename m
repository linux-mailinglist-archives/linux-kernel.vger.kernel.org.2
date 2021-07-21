Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F21C3D1239
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbhGUOms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239706AbhGUOmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:42:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4F0760E0C;
        Wed, 21 Jul 2021 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626881002;
        bh=vw/HFFq3ue6OhFPtK7AmM0dhhlH17poo8NmNf3OwAe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gmWQQW3v5zvmdC4TABkeAnsNhe9Xy5wySrMj8XF7F5XvrENYnNj7kNTViTQe9qUxP
         PwUTTYo6WAhFJ2TFh5MKKKRNF5zcDHB3mSLksdOTEp9dhVc7q5QNSjVLBU8azJYxsY
         Ql23Ok5xhdHi3hoZHlf//rFMlpZVyIstVS/4zC5PZxAWu1j0qKtbmhKDphxv0fZHeF
         RWQUqAJBFfYixZ8LmdFLHGj9rD84i15E/9WTimBZu2WEmVRnBphn7tU8V7SANXsmpG
         yKTT92NLrUExXCGOWkf+QDp0bAzc97wSfJ6XX+uDYByca7A8Gw/dyHRP/Y53nr1Ab+
         aIOZV5kwc05hg==
Date:   Wed, 21 Jul 2021 16:23:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        jean-philippe@linaro.org, Alexandru.Elisei@arm.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 1/3] arch/arm64: Introduce a capability to tell
 whether 16-bit VMID is available
Message-ID: <20210721152316.GB11003@willie-the-truck>
References: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
 <20210616155606.2806-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616155606.2806-2-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 04:56:04PM +0100, Shameer Kolothum wrote:
> From: Julien Grall <julien.grall@arm.com>
> 
> At the moment, the function kvm_get_vmid_bits() is looking up for the
> sanitized value of ID_AA64MMFR1_EL1 and extract the information
> regarding the number of VMID bits supported.
> 
> This is fine as the function is mainly used during VMID roll-over. New
> use in a follow-up patch will require the function to be called a every
> context switch so we want the function to be more efficient.
> 
> A new capability is introduced to tell whether 16-bit VMID is
> available.

I don't really buy this rationale. The VMID allocator introduced later on
caches this value in the static 'vmid_bits' variable, and that gets used
on vCPU enter via vmid_gen_match() in the kvm_arm_update_vmid() fastpath.

So I would prefer that we just expose an accessor for that than introduce
a static key and new cpufeature just for kvm_get_vttbr().

Will
