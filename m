Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536383D1E69
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhGVGBQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jul 2021 02:01:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3958 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhGVGBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 02:01:14 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4GVj4M3zjCz827t;
        Thu, 22 Jul 2021 14:20:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 14:24:15 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Thu, 22 Jul 2021 07:24:13 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Will Deacon <will@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "Alexandru.Elisei@arm.com" <Alexandru.Elisei@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2 1/3] arch/arm64: Introduce a capability to tell whether
 16-bit VMID is available
Thread-Topic: [PATCH v2 1/3] arch/arm64: Introduce a capability to tell
 whether 16-bit VMID is available
Thread-Index: AQHXYshKGBZfllyF/kqTqR+/q/JZlqtNslSAgAEMQiA=
Date:   Thu, 22 Jul 2021 06:24:13 +0000
Message-ID: <027c314e664c4d4889917e95a2aa58c1@huawei.com>
References: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
 <20210616155606.2806-2-shameerali.kolothum.thodi@huawei.com>
 <20210721152316.GB11003@willie-the-truck>
In-Reply-To: <20210721152316.GB11003@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.80.98]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Will Deacon [mailto:will@kernel.org]
> Sent: 21 July 2021 16:23
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> linux-kernel@vger.kernel.org; maz@kernel.org; catalin.marinas@arm.com;
> james.morse@arm.com; julien.thierry.kdev@gmail.com;
> suzuki.poulose@arm.com; jean-philippe@linaro.org;
> Alexandru.Elisei@arm.com; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v2 1/3] arch/arm64: Introduce a capability to tell whether
> 16-bit VMID is available
> 
> On Wed, Jun 16, 2021 at 04:56:04PM +0100, Shameer Kolothum wrote:
> > From: Julien Grall <julien.grall@arm.com>
> >
> > At the moment, the function kvm_get_vmid_bits() is looking up for the
> > sanitized value of ID_AA64MMFR1_EL1 and extract the information
> > regarding the number of VMID bits supported.
> >
> > This is fine as the function is mainly used during VMID roll-over. New
> > use in a follow-up patch will require the function to be called a every
> > context switch so we want the function to be more efficient.
> >
> > A new capability is introduced to tell whether 16-bit VMID is
> > available.
> 
> I don't really buy this rationale. The VMID allocator introduced later on
> caches this value in the static 'vmid_bits' variable, and that gets used
> on vCPU enter via vmid_gen_match() in the kvm_arm_update_vmid() fastpath.
> 
> So I would prefer that we just expose an accessor for that than introduce
> a static key and new cpufeature just for kvm_get_vttbr().

Ok. Will change it to an accessor.

Thanks,
Shameer
