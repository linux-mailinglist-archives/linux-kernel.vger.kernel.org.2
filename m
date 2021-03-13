Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05473339D25
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 10:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhCMJFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 04:05:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230309AbhCMJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 04:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615626342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NchNRTSEGkiqYTAyE/uiRINWxzMLW7q/Qg9kJjYYUV8=;
        b=IEgpW2Kl5I+OAiUrgDo6cdEID5HFrhsvy5GmXmI8vA1MdEgkPsPM7d8431PqdXKbPDaCXY
        qQ9yOgX8Hcgv4NlS+cNa4bIIz3Bi0asY7d5CSEU9bwLzPEfhn/B6zBaIA0bYgyYi2W1NS5
        SiLmH5j1ot+NgVms2HMxHUAXS70MQ/0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-ZF4mYy7hM4K-syHMT_M2Uw-1; Sat, 13 Mar 2021 04:05:26 -0500
X-MC-Unique: ZF4mYy7hM4K-syHMT_M2Uw-1
Received: by mail-ed1-f70.google.com with SMTP id r19so12464788edv.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 01:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=NchNRTSEGkiqYTAyE/uiRINWxzMLW7q/Qg9kJjYYUV8=;
        b=frIp80a1uWRy5JSfQpvnJ1c+vF3+T6AIXLgD6Vp7KatAb6x6woV9NjxSuXNzAPH5fc
         kVdN7tOTBFoBaHxrzEpTqwEdMkzTNowg3ve4rVjM0lbPVIdDMEtcXmGSw9Db5ZLw87t6
         8SvJRBUBJqUyFESvSHr+QN2NnE9pjfzQTu4zS1B0r8niCdEfLxeWoLU3rMkMs/eN0GkG
         9fRYlfToV+eXrsqvQmlcdV/7P9zhXjjz5VKJ/LNAGz9mU3s7jttMrKZf1RmR95048l4B
         Op4Ox03FvBn2yMi8qWvz2eBMs61kzuCOyGuWvkUYxN731Pt65VywNQNWvFiuz4xcIQeg
         ZCcA==
X-Gm-Message-State: AOAM533axGqZ67zHzh25WveECSNe8TaSIAyCEpbQAMiRSiSP7RzYS1oT
        BVm14neJ1CESQNSnbdDmB4jpVB4SKPB7deGwMuEDNPzpzOZt3MGJH0jUCsXJGNGHAaMASLkb2uY
        cjbzy51zwAvIY1ana6VkACt0+
X-Received: by 2002:a05:6402:1d33:: with SMTP id dh19mr18681220edb.362.1615626325551;
        Sat, 13 Mar 2021 01:05:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjqpozZGLXrOMTuUlFEgJyDdDMB8J3TH5iIeMOahQvz63gH7NYmRPQkaJGZfjOHxqndDpeYg==
X-Received: by 2002:a05:6402:1d33:: with SMTP id dh19mr18681207edb.362.1615626325366;
        Sat, 13 Mar 2021 01:05:25 -0800 (PST)
Received: from [192.168.3.108] (p4ff236b2.dip0.t-ipconnect.de. [79.242.54.178])
        by smtp.gmail.com with ESMTPSA id k9sm4364576edn.68.2021.03.13.01.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Mar 2021 01:05:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail in __free_pages_core()")
Date:   Sat, 13 Mar 2021 10:05:23 +0100
Message-Id: <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
References: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        linux-kernel@vger.kernel.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
In-Reply-To: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
To:     "Liang, Liang (Leo)" <Liang.Liang@amd.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 13.03.2021 um 05:04 schrieb Liang, Liang (Leo) <Liang.Liang@amd.com>:
>=20
> =EF=BB=BF[AMD Public Use]
>=20
> Hi David,
>=20
> Which benchmark tool you prefer? Memtest86+ or else?

Hi Leo,

I think you want something that runs under Linux natively.

I=E2=80=98m planning on coding up a kernel module to walk all 4MB pages in t=
he freelists and perform a stream benchmark individually. Then we might be a=
ble to identify the problematic range - if there is a problematic range :) G=
uess I=E2=80=98ll have it running by Monday and let you know.

Cheers!

>=20
> BRs,
> Leo
> -----Original Message-----
> From: David Hildenbrand <david@redhat.com>=20
> Sent: Saturday, March 13, 2021 12:47 AM
> To: Liang, Liang (Leo) <Liang.Liang@amd.com>; Deucher, Alexander <Alexande=
r.Deucher@amd.com>; linux-kernel@vger.kernel.org; amd-gfx list <amd-gfx@list=
s.freedesktop.org>; Andrew Morton <akpm@linux-foundation.org>
> Cc: Huang, Ray <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@am=
d.com>; Mike Rapoport <rppt@linux.ibm.com>; Rafael J. Wysocki <rafael@kernel=
.org>; George Kennedy <george.kennedy@oracle.com>
> Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to t=
ail in __free_pages_core()")
>=20
>> On 12.03.21 17:19, Liang, Liang (Leo) wrote:
>> [AMD Public Use]
>>=20
>> Dmesg attached.
>>=20
>=20
>=20
> So, looks like the "real" slowdown starts once the buddy is up and running=
 (no surprise).
>=20
>=20
> [    0.044035] Memory: 6856724K/7200304K available (14345K kernel code, 96=
99K rwdata, 5276K rodata, 2628K init, 12104K bss, 343324K reserved, 0K cma-r=
eserved)
> [    0.044045] random: get_random_u64 called from __kmem_cache_create+0x33=
/0x460 with crng_init=3D1
> [    0.049025] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16,=
 Nodes=3D1
> [    0.050036] ftrace: allocating 47158 entries in 185 pages
> [    0.097487] ftrace: allocated 185 pages with 5 groups
> [    0.109210] rcu: Hierarchical RCU implementation.
>=20
> vs.
>=20
> [    0.041115] Memory: 6869396K/7200304K available (14345K kernel code, 34=
33K rwdata, 5284K rodata, 2624K init, 6088K bss, 330652K reserved, 0K cma-re=
served)
> [    0.041127] random: get_random_u64 called from __kmem_cache_create+0x31=
/0x430 with crng_init=3D1
> [    0.041309] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16,=
 Nodes=3D1
> [    0.041335] ftrace: allocating 47184 entries in 185 pages
> [    0.055719] ftrace: allocated 185 pages with 5 groups
> [    0.055863] rcu: Hierarchical RCU implementation.
>=20
>=20
> And it gets especially bad during ACPI table processing:
>=20
> [    4.158303] ACPI: Added _OSI(Module Device)
> [    4.158767] ACPI: Added _OSI(Processor Device)
> [    4.159230] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    4.159705] ACPI: Added _OSI(Processor Aggregator Device)
> [    4.160551] ACPI: Added _OSI(Linux-Dell-Video)
> [    4.161359] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    4.162264] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [   17.713421] ACPI: 13 ACPI AML tables successfully acquired and loaded
> [   18.716065] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [   20.743828] ACPI: EC: EC started
> [   20.744155] ACPI: EC: interrupt blocked
> [   20.945956] ACPI: EC: EC_CMD/EC_SC=3D0x666, EC_DATA=3D0x662
> [   20.946618] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle tra=
nsactions
> [   20.947348] ACPI: Interpreter enabled
> [   20.951278] ACPI: (supports S0 S3 S4 S5)
> [   20.951632] ACPI: Using IOAPIC for interrupt routing
>=20
> vs.
>=20
> [    0.216039] ACPI: Added _OSI(Module Device)
> [    0.216041] ACPI: Added _OSI(Processor Device)
> [    0.216043] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.216044] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.216046] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.216048] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.216049] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    0.228259] ACPI: 13 ACPI AML tables successfully acquired and loaded
> [    0.229527] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.231663] ACPI: EC: EC started
> [    0.231666] ACPI: EC: interrupt blocked
> [    0.233664] ACPI: EC: EC_CMD/EC_SC=3D0x666, EC_DATA=3D0x662
> [    0.233667] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle tra=
nsactions
> [    0.233670] ACPI: Interpreter enabled
> [    0.233685] ACPI: (supports S0 S3 S4 S5)
> [    0.233687] ACPI: Using IOAPIC for interrupt routing
>=20
> The jump from 4.1 -> 17.7 is especially bad.
>=20
> Which might in fact indicate that this could be related to using some very=
 special slow (ACPI?) memory for ordinary purposes, interfering with actual A=
CPI users?
>=20
> But again, just a wild guess, because the system is extremely slow afterwa=
rds, however, we don't have any pauses without any signs of life for that lo=
ng.
>=20
>=20
> It would be interesting to run a simple memory bandwidth benchmark on the f=
ast kernel with differing sizes up to running OOM to see if there is really s=
ome memory that is just horribly slow once allocated and used.
>=20
> --
> Thanks,
>=20
> David / dhildenb
>=20

