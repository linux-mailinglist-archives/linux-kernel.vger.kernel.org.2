Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35234146C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhIVKmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:42:03 -0400
Received: from foss.arm.com ([217.140.110.172]:46708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235260AbhIVKl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:41:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAF1311B3;
        Wed, 22 Sep 2021 03:39:56 -0700 (PDT)
Received: from [10.57.95.67] (unknown [10.57.95.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F9063F719;
        Wed, 22 Sep 2021 03:39:55 -0700 (PDT)
Subject: Re: [RFC PATCH v4 01/39] KVM: arm64: Make lock_all_vcpus() available
 to the rest of KVM
To:     Alexandru Elisei <alexandru.elisei@arm.com>, maz@kernel.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, will@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
 <20210825161815.266051-2-alexandru.elisei@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ed657df4-7242-2c77-cfaf-b0dc1eb5c210@arm.com>
Date:   Wed, 22 Sep 2021 11:39:54 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210825161815.266051-2-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2021 17:17, Alexandru Elisei wrote:
> The VGIC code uses the lock_all_vcpus() function to make sure no VCPUs are
> run while it fiddles with the global VGIC state. Move the declaration of
> lock_all_vcpus() and the corresponding unlock function into asm/kvm_host.h
> where it can be reused by other parts of KVM/arm64 and rename the functions
> to kvm_{lock,unlock}_all_vcpus() to make them more generic.
> 
> Because the scope of the code potentially using the functions has
> increased, add a lockdep check that the kvm->lock is held by the caller.
> Holding the lock is necessary because otherwise userspace would be able to
> create new VCPUs and run them while the existing VCPUs are locked.
> 
> No functional change intended.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>


LGTM,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
