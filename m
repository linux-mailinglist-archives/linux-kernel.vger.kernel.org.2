Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2AF32FD44
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 21:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCFU4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 15:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhCFU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:56:37 -0500
X-Greylist: delayed 3374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 Mar 2021 12:56:36 PST
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AB3C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 12:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Message-ID:From:CC:To:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=bVEadx5XUyga2+3JVanlGM60Y2Rfk62e/HFKwSxTExU=; b=gfQKgYSVX7QTC9ZASaMI1SiRa3
        4kgzrwivEIhULbyS0HQI8krGSCqKufyGdZusjICKkkCvhrXYzsVHTZM54HdYbr+t9p2KR+slDTzUQ
        BBJ1Pp8Ug45dzAaSNin6fTek3zC/9HKxLVzmfrp3Xg2YECpjM4B4e4gX9x5H6yet5s9/q7kok8Q5/
        KgJ3dHjSjoH3jVLcOeMP0uPZdaVprvCIsJByVD9PIhCANuPH1Zcz2QKwceokkJAhapZqXvThGI19C
        1UPEsAJ2FwOeVPmDiNX/eOY3Yqmo+7Gy+ge/z1jRWx35oAJjr5wr5pg8rKfODtsoTVPXoX/HsAE2s
        o88FpdEg==;
Received: from merlin.infradead.org ([2001:8b0:10b:1234::107])
        by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
        id 1lId61-004YLg-T0
        for linux-kernel@vger.kernel.org; Sat, 06 Mar 2021 20:00:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Message-ID:From:CC:To:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=bVEadx5XUyga2+3JVanlGM60Y2Rfk62e/HFKwSxTExU=; b=ceIvwhhav+M1uUnFOKoZGnbexg
        W1nHPwkf+MxykeLakwYq+ezYl+N9JXfFPEL1bcEngpvNMKr1hj8XPLI83AlBSHGZ6ntgbmI3iJyT6
        Mh9Ti3q6QNbFJiWWb2U6DrrCCUNfa6ouq+4Td/lt/hDO4hmcbDa13yb2MW+wniYwxTq8O7SIXHl7d
        WfFqXluL8mkde4IjVXbm/GkMnqc+wnXuUIPPDNetxO0DcdzhSTiwFMAuEk2XJL8fe/XNa7yxtkwZl
        duabVyoh0prdN/vWcla8xW9FkCAKrgwz76d1AaDge8csI9X1IuNmpDfvkrxxcT213nKBGkn6AQrgK
        R7CI6xnQ==;
Received: from [104.129.198.225] (helo=[100.124.44.209])
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lId5H-000Ga2-7Q; Sat, 06 Mar 2021 19:59:32 +0000
Date:   Sat, 06 Mar 2021 11:44:33 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <87lfb5sthg.fsf@mpe.ellerman.id.au>
References: <20210302082811.8671-1-rdunlap@infradead.org> <87lfb5sthg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] powerpc: iommu: fix build when neither PCI or IBMVIO is set
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
CC:     kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
        Anton Blanchard <anton@samba.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3954705C-2B4C-436A-8902-494240662491@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 2, 2021 3:08:43 AM PST, Michael Ellerman <mpe@ellerman=2Eid=2Eau> =
wrote:
>Randy Dunlap <rdunlap@infradead=2Eorg> writes:
>> When neither CONFIG_PCI nor CONFIG_IBMVIO is enabled:
>>
>> =2E=2E/arch/powerpc/kernel/iommu=2Ec:178:30: error:
>'fail_iommu_bus_notifier' defined but not used
>[-Werror=3Dunused-variable]
>>   178 | static struct notifier_block fail_iommu_bus_notifier =3D {
>>
>> If only that struct is bounded by 2 #if defined() phrases (PCI &&
>IBMVIO):
>>
>> =2E=2E/arch/powerpc/kernel/iommu=2Ec:162:12: error: 'fail_iommu_bus_not=
ify'
>defined but not used [-Werror=3Dunused-function]
>>   162 | static int fail_iommu_bus_notify(struct notifier_block *nb,
>>
>> If that function is also guarded by 2 #if defined() phrases:
>>
>> In file included from =2E=2E/include/linux/dma-mapping=2Eh:7,
>>                  from =2E=2E/arch/powerpc/kernel/iommu=2Ec:19:
>> =2E=2E/include/linux/device=2Eh:131:26: error: 'dev_attr_fail_iommu'
>defined but not used [-Werror=3Dunused-variable]
>>   131 |  struct device_attribute dev_attr_##_name =3D __ATTR_RW(_name)
>> =2E=2E/arch/powerpc/kernel/iommu=2Ec:160:8: note: in expansion of macro
>'DEVICE_ATTR_RW'
>>   160 | static DEVICE_ATTR_RW(fail_iommu);
>>
>> and the snowball continues to grow=2E
>> Next I got this one:
>>
>> =2E=2E/arch/powerpc/kernel/iommu=2Ec: In function 'iommu_range_alloc':
>> =2E=2E/arch/powerpc/kernel/iommu=2Ec:234:6: error: implicit declaration=
 of
>function 'should_fail_iommu'; did you mean 'should_failslab'?
>[-Werror=3Dimplicit-function-declaration]
>>   234 |  if (should_fail_iommu(dev))
>>
>> and
>>
>> =2E=2E/arch/powerpc/kernel/iommu=2Ec: In function 'should_fail_iommu':
>> =2E=2E/arch/powerpc/kernel/iommu=2Ec:122:50: error: 'fail_iommu' undecl=
ared
>(first use in this function)
>>   122 |  return dev->archdata=2Efail_iommu && should_fail(&fail_iommu,
>1);
>>
>> So combine CONFIG_FAIL_IOMMU && (CONFIG_PCI || CONFIG_IBMVIO)
>> to decide on building some of this code/data=2E
>
>Couldn't we just make FAIL_IOMMU depend on PCI || IBMVIO?
>
>cheers

Yes, I thought of that about 5 seconds after hitting Send=2E But I can't d=
o it just now -- am away from computer=2E


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
