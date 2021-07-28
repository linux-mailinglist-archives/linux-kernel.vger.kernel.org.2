Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409E03D8B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbhG1J7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:59:31 -0400
Received: from foss.arm.com ([217.140.110.172]:54368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235499AbhG1J7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:59:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDC2731B;
        Wed, 28 Jul 2021 02:59:28 -0700 (PDT)
Received: from [10.57.85.218] (unknown [10.57.85.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC1A33F73D;
        Wed, 28 Jul 2021 02:59:25 -0700 (PDT)
Subject: Re: [PATCH 1/1] arm64/cpufeature: Add option to disable mte support
To:     yee.lee@mediatek.com, linux-kernel@vger.kernel.org
Cc:     nicholas.Tang@mediatek.com, Kuan-Ying.lee@mediatek.com,
        chinwen.chang@mediatek.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        James Morse <james.morse@arm.com>,
        Fuad Tabba <tabba@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20210728094302.9949-1-yee.lee@mediatek.com>
 <20210728094302.9949-2-yee.lee@mediatek.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <88cded87-bc06-4aeb-4996-76a5faa58afe@arm.com>
Date:   Wed, 28 Jul 2021 10:59:24 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728094302.9949-2-yee.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2021 10:42, yee.lee@mediatek.com wrote:
> From: Yee Lee <yee.lee@mediatek.com>
> 
> Add a static key to exapnd the logic of system_supports_mte().
> This function controls mte enablement in both EL1 and EL0.
> 
> The static key, "arm64_mte_support" is default true and can
> be disabled via the early_param.

Please could we use the id-reg override mechanism and give it
an alias ?

See :

arch/arm64/kernel/idreg-override.c

And could add something along the lines of :

arm64.nomte


Cheers
Suzuki

