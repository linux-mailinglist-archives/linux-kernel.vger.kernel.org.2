Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986B43B1C18
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhFWOLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 10:11:22 -0400
Received: from foss.arm.com ([217.140.110.172]:36088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230263AbhFWOLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:11:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9DADED1;
        Wed, 23 Jun 2021 07:09:03 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B3B43F718;
        Wed, 23 Jun 2021 07:09:01 -0700 (PDT)
Subject: Re: [PATCH v17 0/6] MTE support for KVM guest
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
References: <20210621111716.37157-1-steven.price@arm.com>
 <162437105102.29544.14666831489362675099.b4-ty@kernel.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <7cc69f75-a6df-0a64-873e-69e438a43bdf@arm.com>
Date:   Wed, 23 Jun 2021 15:09:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <162437105102.29544.14666831489362675099.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2021 15:21, Marc Zyngier wrote:
> On Mon, 21 Jun 2021 12:17:10 +0100, Steven Price wrote:
>> This series adds support for using the Arm Memory Tagging Extensions
>> (MTE) in a KVM guest.
>>
>> Changes since v16[1]:
>>
>>  - Dropped the first patch ("Handle race when synchronising tags") as
>>    it's not KVM specific and by restricting MAP_SHARED in KVM there is
>>    no longer a dependency.
>>
>> [...]
> 
> Applied to next, thanks!
> 
> [1/6] arm64: mte: Sync tags for pages where PTE is untagged
>       commit: 69e3b846d8a753f9f279f29531ca56b0f7563ad0
> [2/6] KVM: arm64: Introduce MTE VM feature
>       commit: ea7fc1bb1cd1b92b42b1d9273ce7e231d3dc9321
> [3/6] KVM: arm64: Save/restore MTE registers
>       commit: e1f358b5046479d2897f23b1d5b092687c6e7a67
> [4/6] KVM: arm64: Expose KVM_ARM_CAP_MTE
>       commit: 673638f434ee4a00319e254ade338c57618d6f7e
> [5/6] KVM: arm64: ioctl to fetch/store tags in a guest
>       commit: f0376edb1ddcab19a473b4bf1fbd5b6bbed3705b
> [6/6] KVM: arm64: Document MTE capability and ioctl
>       commit: 04c02c201d7e8149ae336ead69fb64e4e6f94bc9
> 
> I performed a number of changes in user_mem_abort(), so please
> have a look at the result. It is also pretty late in the merge
> cycle, so if anything looks amiss, I'll just drop it.

It all looks good to me - thanks for making those changes.

Steve
