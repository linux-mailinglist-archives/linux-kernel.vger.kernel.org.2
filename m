Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB13C3D2697
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhGVOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 10:41:59 -0400
Received: from foss.arm.com ([217.140.110.172]:54718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232576AbhGVOly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 10:41:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCA88106F;
        Thu, 22 Jul 2021 08:22:28 -0700 (PDT)
Received: from [10.57.7.91] (unknown [10.57.7.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E3563F694;
        Thu, 22 Jul 2021 08:22:27 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] kvm/arm: Align the VMID allocation with the arm64
 ASID one
To:     Will Deacon <will@kernel.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Cc:     "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
 <20210616155606.2806-4-shameerali.kolothum.thodi@huawei.com>
 <20210721163138.GD11003@willie-the-truck>
 <f7d708704fb84380af85298a98f7a48c@huawei.com>
 <20210722095010.GA12012@willie-the-truck>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <43b32e77-52b1-8524-63a1-c99578c2dd1d@arm.com>
Date:   Thu, 22 Jul 2021 16:22:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210722095010.GA12012@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/21 10:50 AM, Will Deacon wrote:
> As an aside: I'm more and more inclined to rip out the CnP stuff given
> that it doesn't appear to being any benefits, but does have some clear
> downsides. Perhaps something for next week.

Can you please clarify what do you mean by "it doesn't appear to being any
benefits"? IIRC, Cortex-A65 implements CnP hint and I've heard that some
payloads seen improvement...

Cheers
Vladimir 
