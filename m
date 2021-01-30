Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77153097D7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 20:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhA3TLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 14:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhA3TLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 14:11:53 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D435EC061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 11:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=LoscN5jD19xm5adnVXv8iTMljlY3qu2cWhabLlLMNqA=; b=I04Rmy5P6yA6iNfFGzMrg8vMzV
        FUe0VokZUkBOWaKhSjbNeRGhCIiSiwC0CHZXHDSk6AKeqiSqL9D43RwHhr2S+Z33ernY+E8Z4ASsQ
        q5cuGESbYw275/Fp7U7kQg9wIo3tTief5GwWW8Gz3I8ZuqD7uvmMwVmcDppXCRbBCKMsvIrtcNYnh
        ahkNLds4OCsT9LbgchTmkR0amCi3flfm/Qv+9Qnbyr5v7eh3xkuleUuZ1DNMVRu8odt2ZeEDTFSmo
        KxzvbCwygLi6y6g2L3Jk2wKwTmy5ZXN9QUkbDuZLsWdnN92yJhHDc58wgE1FZODMPXpsOODZFOA4p
        YnSh3V2w==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l5veF-00036D-Nz; Sat, 30 Jan 2021 19:11:08 +0000
Subject: Re: bnx2x_main.c:undefined reference to `synchronize_net'
To:     Jakub Kicinski <kuba@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>
References: <202101301843.jB5QqizS-lkp@intel.com>
 <20210130103104.28a4ed6b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d087f29f-e9d1-382d-0a5e-50d9a5280a82@infradead.org>
Date:   Sat, 30 Jan 2021 11:11:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210130103104.28a4ed6b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/21 10:31 AM, Jakub Kicinski wrote:
> I don't understand how this one happens and don't have a PPC build
> setup :S So many things seem to depend on NET here that "this should
> never happen". Must be some rogue "select" pulling BNX2 without its
> dependencies?

Yes, the problem is overuse of Kconfig "select" in powerpc for the
AKEBONO platform. The Kconfig warnings are listed at the end:

>>
>> Kconfig warnings: (for reference only)
>>    WARNING: unmet direct dependencies detected for NETDEVICES
>>    Depends on NET
>>    Selected by
>>    - AKEBONO && PPC_47x
>>    WARNING: unmet direct dependencies detected for ETHERNET
>>    Depends on NETDEVICES && NET
>>    Selected by
>>    - AKEBONO && PPC_47x
>>    WARNING: unmet direct dependencies detected for HOTPLUG_CPU
>>    Depends on SMP && (PPC_PSERIES || PPC_PMAC || PPC_POWERNV || FSL_SOC_BOOKE
>>    Selected by
>>    - PM_SLEEP_SMP && SMP && (ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE && PM_SLEEP
>>    WARNING: unmet direct dependencies detected for NET_DEVLINK
>>    Depends on NET
>>    Selected by
>>    - QED && NETDEVICES && ETHERNET && NET_VENDOR_QLOGIC && PCI
>>    WARNING: unmet direct dependencies detected for GRO_CELLS
>>    Depends on NET
>>    Selected by
>>    - MACSEC && NETDEVICES && NET_CORE
>>    WARNING: unmet direct dependencies detected for FAILOVER
>>    Depends on NET
>>    Selected by
>>    - NET_FAILOVER && NETDEVICES

I'm pretty sure that Michael Ellerman (powerpc maintainer) was going to make
some defconfig file changes for AKEBONO, but I'm not so sure that that
change will prevent randconfig build errors. I'm in a wait-and-see mode on that.

Hm, looking back at his reply to my (powerpc, not net:) patch,
I owe him a reply, so I'll look into that.

https://lore.kernel.org/linuxppc-dev/875z3prcwg.fsf@mpe.ellerman.id.au/

-- 
~Randy

