Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2F5390595
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhEYPjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:39:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232078AbhEYPjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621957052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pTfXMHcES0HP1+v2jr/ALeYwe9IxOxXOMr/JTHDhoA=;
        b=U5IJDkLfSGNkdFGrYd2BC0r6oVYQkq8Mc5aLqzobne3dXknx67AQapSk0tKpARq0pG+mqn
        od/mXhQb4SFHKQ4FRGCXpyQ9RUuFsEBlcU3P9Wqea3FwqXHmpvsHeTFmHZ7PX88WuqAqAh
        8ozO5P9CVtpC5hpHRHvg2yh5dakg2ps=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-GZtm9q1EN-ar01SsNbrjew-1; Tue, 25 May 2021 11:37:30 -0400
X-MC-Unique: GZtm9q1EN-ar01SsNbrjew-1
Received: by mail-wr1-f70.google.com with SMTP id n2-20020adfb7420000b029010e47b59f31so14603266wre.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/pTfXMHcES0HP1+v2jr/ALeYwe9IxOxXOMr/JTHDhoA=;
        b=YyMof0RYwcQ3VfSr9zzc4qr7D8ICJiuxKLN55AWvqq5YXdo5yBWKEVmVgVHnL54QK9
         gVH8ihHuxdrCOZjdkNAOQ4pIvXLX8PHylD5bC0Dkej0bHPW5CQL41NB8ouWx9iWHbayk
         VvS0+p8tSw4OgQOjN02sm/bmcTy6+cAb7f2enUbuKRt/4xQ7hlqSLZKQ0b0LVRipbrKN
         7jT2+bErCcTpUJCL4XNzqyn6+g2ChWYATGNyagHmEE9Z4aRRzzNtA3r818C8pWHykVZ9
         TSw26mpxBHz5tT92DIYEuAZYYShDMcaRz9q3RnjBG8b34nuw6RMgyHZOf+Lykb/IPtTx
         nFjw==
X-Gm-Message-State: AOAM530w8ZPc8Msig9qIXIvXwx4hgKw2ykib/3REiXcCKey+fkWkUtqj
        aV2Z00mqsnRnQalzkIKDJcl7TMvVB2seKFJdBSA/+PNr/rQL3Bg8z2T9wPztQzZIed2kw/kl9p3
        kvEWNCVgTeoj6F2CgjkPtaMEc
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr23939830wmq.38.1621957049697;
        Tue, 25 May 2021 08:37:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+987Gi5+Ao8HMeMYgLg1iRQPtEoehGdM6F2GQdq0/O5MID6l689lcRPzuTI/mRpkYixi0xw==
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr23939807wmq.38.1621957049395;
        Tue, 25 May 2021 08:37:29 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id b10sm19416681wrr.27.2021.05.25.08.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 08:37:29 -0700 (PDT)
To:     "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Arm64 crash while reading memory sysfs
Message-ID: <1c81f7d0-06f8-1f4e-c639-4a9878751cb4@redhat.com>
Date:   Tue, 25 May 2021 17:37:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.05.21 17:25, Qian Cai (QUIC) wrote:
> Reverting the patchset "arm64: drop pfn_valid_within() and simplify pfn_valid()" [1] from today's linux-next fixed a crash while reading files under /sys/devices/system/memory.
> 
> [1] https://lore.kernel.org/kvmarm/20210511100550.28178-1-rppt@kernel.org/
> 
> [  247.669668][ T1443] kernel BUG at include/linux/mm.h:1383!
> [  247.675987][ T1443] Internal error: Oops - BUG: 0 [#1] SMP
> [  247.681472][ T1443] Modules linked in: loop processor efivarfs ip_tables x_tables ext4 mbcache jbd2 dm_mod igb i2c_algo_bit nvme mlx5_core i2c_core nvme_core firmware_class
> [  247.696894][ T1443] CPU: 15 PID: 1443 Comm: ranbug Not tainted 5.13.0-rc3-next-20210524+ #11
> [  247.705326][ T1443] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
> [  247.713842][ T1443] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> [  247.720536][ T1443] pc : test_pages_in_a_zone+0x23c/0x300
> [  247.725935][ T1443] lr : test_pages_in_a_zone+0x23c/0x300
> [  247.731327][ T1443] sp : ffff800023f8f670
> [  247.735327][ T1443] x29: ffff800023f8f670 x28: 000000000000a000 x27: 000000000000a000
> [  247.743156][ T1443] x26: ffffffbfffe00000 x25: ffff800011c6f738 x24: dfff800000000000
> [  247.750984][ T1443] x23: 0000000000002000 x22: ffff009f7efa29c0 x21: 0000000000000000
> [  247.758812][ T1443] x20: ffffffffffffffff x19: 0000000000008000 x18: ffff00084f9d3370
> [  247.766640][ T1443] x17: 0000000000000000 x16: 0000000000000007 x15: 0000000000000078
> [  247.774467][ T1443] x14: 0000000000000000 x13: ffff800011c6eea4 x12: ffff60136cee0574
> [  247.782295][ T1443] x11: 1fffe0136cee0573 x10: ffff60136cee0573 x9 : dfff800000000000
> [  247.790123][ T1443] x8 : ffff009b67702b9b x7 : 0000000000000001 x6 : ffff009b67702b98
> [  247.797951][ T1443] x5 : 00009fec9311fa8d x4 : ffff009b67702b98 x3 : 1fffe00109f3a529
> [  247.805778][ T1443] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000034
> [  247.813606][ T1443] Call trace:
> [  247.816738][ T1443]  test_pages_in_a_zone+0x23c/0x300
> [  247.821784][ T1443]  valid_zones_show+0x1e0/0x298
> [  247.826483][ T1443]  dev_attr_show+0x50/0xc8
> [  247.830747][ T1443]  sysfs_kf_seq_show+0x164/0x368
> [  247.835533][ T1443]  kernfs_seq_show+0x130/0x198
> [  247.840143][ T1443]  seq_read_iter+0x344/0xd50
> [  247.844581][ T1443]  kernfs_fop_read_iter+0x32c/0x4a8
> [  247.849625][ T1443]  new_sync_read+0x2bc/0x4e8
> [  247.854063][ T1443]  vfs_read+0x18c/0x340
> [  247.858066][ T1443]  ksys_read+0xf8/0x1e0
> [  247.862068][ T1443]  __arm64_sys_read+0x74/0xa8
> [  247.866591][ T1443]  invoke_syscall.constprop.0+0xdc/0x1d8
> [  247.872072][ T1443]  do_el0_svc+0xe4/0x298
> [  247.876162][ T1443]  el0_svc+0x20/0x30
> [  247.879906][ T1443]  el0_sync_handler+0xb0/0xb8
> [  247.884429][ T1443]  el0_sync+0x178/0x180
> [  247.888435][ T1443] Code: b0005ee1 912b8021 910b0021 97fc57ac (d4210000)
> [  247.895217][ T1443] ---[ end trace 4ff9f5cbe7443f54 ]---
> [  247.900522][ T1443] Kernel panic - not syncing: Oops - BUG: Fatal exception
> [  247.907501][ T1443] SMP: stopping secondary CPUs
> [  247.912122][ T1443] Kernel Offset: disabled
> [  247.916296][ T1443] CPU features: 0x00000251,20000846
> [  247.921340][ T1443] Memory Limit: none
> [  247.925100][ T1443] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---

That hole test_pages_in_a_zone() cruft has to go sooner or later. I have 
getting rid of that on my list (simply storing the single zone if any 
per memory block).

We run into an uninitialized memmap, because the poison check in 
page_zone()->page_to_nid() triggers. I assume the memmap of a memory 
hole does not get initialized properly?

-- 
Thanks,

David / dhildenb

