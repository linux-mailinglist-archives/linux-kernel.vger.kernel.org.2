Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8ED319074
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 17:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhBKQ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 11:56:01 -0500
Received: from foss.arm.com ([217.140.110.172]:53772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhBKPlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:41:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7191B113E;
        Thu, 11 Feb 2021 07:41:05 -0800 (PST)
Received: from [10.37.8.13] (unknown [10.37.8.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A2023F73D;
        Thu, 11 Feb 2021 07:41:02 -0800 (PST)
Subject: Re: [PATCH v13 0/7] arm64: ARMv8.5-A: MTE: Add async mode support
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <de24f34c-3cbd-39d6-fe7f-6ea801bc76cd@arm.com>
Date:   Thu, 11 Feb 2021 15:45:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211153353.29094-1-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 3:33 PM, Vincenzo Frascino wrote:
> The series is based on linux-next/akpm.
> 
> To simplify the testing a tree with the new patches on top has been made
> available at [1].
> 
> [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v11.async.akpm

akpm tree seems currently broken due to [1]. If you want to test my patches a
possible workaround is to remove manually the content of $KBUILD_OUTPUT and then
do the usual:

make defconfig && make menuconfig (to enable KASAN HW TAGS) && make -j<n>

[1] https://www.spinics.net/lists/netdev/msg721547.html

Thanks!

-- 
Regards,
Vincenzo
