Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBAC35DB68
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhDMJi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:38:29 -0400
Received: from mail-oln040092064038.outbound.protection.outlook.com ([40.92.64.38]:7488
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229623AbhDMJiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:38:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwRrUU0F3yQRMWDKp8C22wqJwgjfDdpe9wPCrR7mDs+406REc3lfOzXeOKHEAAYfMCep6X7b2zqJCGBlFb39IEENaIGY9z+FO8vD5kEd3ahkYoB9cdB2no9N2v1Vvc4cnAOoloPghZ5JywFFjATgDZTw+nCPh34IihTrwJajM45xcd3s8uJ7wnjfJavMeWZUfVUIKob/y2dWTLgRizmFqIv5LqVv6V0H1EW3IoyAk9LdJnGwT7ruvRQWp/u4pcfZ+Cd/q7NilS+9cgfPd+hn2e2llvTxHWCSXP+E1pZJrbxzZOy3oiDJkjAdJb7BG0Fhmh+42Ga/DDcb/Sqove8fUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtA868Cy6H/+QOpEN6Gk+NoOxwBGJGkmrCIHd0qfa/o=;
 b=JbPb4SzTxDKzDW2/AVVGIGazLSIQrH+9UZ0do+mTy3/wo8usriUkSu8pNV9LgrWkE2M36tQvWCoQ1SnRYoE7nyLY/ZSI1nXGrxW0h0Y1FdMYnUq4Dz2xpbHUp4G6QqusqndgDF8b7XHM53EZGcEL8JaL4T6SoljC37yKA5A4Her+KE8I0x/ySCilCVmHVyV136bo+LbmaLST7eOUb/x3UMZ2zxQ1HuBLO8jFNdsbj95aUac54HBVIQul7bl06gG8jL1O5DmTRaEmbwZdUA31G/lH06NFcAVIitlHcy3/p2xKAZIEeXKeIp6AJiSkuJodq+en79QXgOSLerj9b+zJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
 (2a01:111:e400:7e1a::44) by
 DB5EUR01HT089.eop-EUR01.prod.protection.outlook.com (2a01:111:e400:7e1a::269)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 09:38:04 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:7e1a::53) by DB5EUR01FT013.mail.protection.outlook.com
 (2a01:111:e400:7e1a::239) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Tue, 13 Apr 2021 09:38:04 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:5BB13109A7AF8E32FD3B084969A2F35ADB25557391B64C692E7EB5FACE296EAF;UpperCasedChecksum:356E1DEA4B4AE7AE8695E728B6CBC514D2B06DC32C12A4EF1856530CB262A58C;SizeAsReceived:9051;Count:48
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 09:38:04 +0000
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, will@kernel.org, jsnitsel@redhat.com,
        pmenzel@molgen.mpg.de, Jon.Grimm@amd.com,
        Tj <ml.linux@elloe.vision>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Alex Hung <1917203@bugs.launchpad.net>
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
From:   David Coe <david.coe@live.co.uk>
Message-ID: <VI1PR09MB263861ABB6D5CB6A000CD6F8C74F9@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date:   Tue, 13 Apr 2021 10:38:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-TMN:  [nyP/018UJNi/J2HPxxZ8jv22RUs0pvps]
X-ClientProxiedBy: LO2P265CA0156.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::24) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <03d0e57c-9a90-2605-cddd-cd619439e138@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (90.246.218.100) by LO2P265CA0156.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend Transport; Tue, 13 Apr 2021 09:38:03 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: c6442614-959c-476c-b807-08d8fe5fd62a
X-MS-TrafficTypeDiagnostic: DB5EUR01HT089:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRqcERWRBgofHi1M3rjDvvEJO+KS7iDksvjjknwbtQweZj92OjcwS8IOH9fIgDoIu4XbUQ8kN49oSlgQkMe5JVQU8BqWSCh7mslBsPdZZPiQMiP+5vG8e5Uwy6G8QfKzGhaEZ4NlbJADFC2FRtNxC1xeq/Omt0mnR0nTGb3CGAOdFyP7Ph3FvMLlBcWMIbTQbPdLwBv9Hu5iE7OxxYG4TIcKmmUdqhWGv9jQNWI5N6vk4sw+ivTzO9piYAkqPqSit5GvLb5gHmCX5Y2zuMZbv4byG9YrI8V07bU4w0Yl7VavSGEpzcPI+tJhrShfNaKApuFSLXqaZMLPsAKCsVVejN1TcQDw9UFgQoS2dEFsdjUqVGioNE0Ep/JJdezyDTHEkNqv4UwXIJ03pqFbrJbqxg==
X-MS-Exchange-AntiSpam-MessageData: p4WVkVd12/9+i0TP/PjUAjlYGg/fAMZ2mlU0QfXelWER7Lnl+kJRx3qWF8w1GjQIzyrhAkKw2h4wHl1bB3eFTiltwfDWbshE3cO36m2PN2Dn1efjItqYLBocoHqXeuUjEJsyNKG5Cj8vAK9jSOdLVA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6442614-959c-476c-b807-08d8fe5fd62a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 09:38:04.4835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR01HT089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee!

Just in case (!), I've run your revert+update patch on kernel 5.11.0-13, 
Ubuntu 21.04β running on an AMD FX-8350 (pre Zen and IOMMUv2). As with 
the AMD Ryzen 2400G and 4700U, I'm finding no obvious issues.


$ sudo dmesg | grep IOMMU
[    0.948890] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    4.393773] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    4.393776] AMD-Vi: AMD IOMMUv2 functionality not available on this 
system


$ systool -m kvm_amd -v
Module = "kvm_amd"

   Attributes:
     coresize            = "114688"
     initsize            = "0"
     initstate           = "live"
     refcnt              = "0"
     srcversion          = "4371BA17A41823101F90761"
     taint               = ""
     uevent              = <store method only>

   Parameters:
     avic                = "0"
     dump_invalid_vmcb   = "N"
     nested              = "1"
     npt                 = "1"
     nrips               = "1"
     pause_filter_count_grow= "2"
     pause_filter_count_max= "65535"
     pause_filter_count_shrink= "0"
     pause_filter_count  = "3000"
     pause_filter_thresh = "128"
     sev_es              = "0"
     sev                 = "0"
     vgif                = "0"
     vls                 = "0"

   Sections:


$ compgen -G "/sys/kernel/iommu_groups/*/devices/*"
/sys/kernel/iommu_groups/9/devices/0000:00:14.2
/sys/kernel/iommu_groups/0/devices/0000:00:00.0
/sys/kernel/iommu_groups/10/devices/0000:00:14.3
/sys/kernel/iommu_groups/2/devices/0000:00:04.0
/sys/kernel/iommu_groups/12/devices/0000:00:14.5
/sys/kernel/iommu_groups/4/devices/0000:00:0d.0
/sys/kernel/iommu_groups/14/devices/0000:00:16.0
/sys/kernel/iommu_groups/14/devices/0000:00:16.2
/sys/kernel/iommu_groups/6/devices/0000:00:12.0
/sys/kernel/iommu_groups/6/devices/0000:00:12.2
/sys/kernel/iommu_groups/16/devices/0000:02:00.0
/sys/kernel/iommu_groups/8/devices/0000:00:14.0
/sys/kernel/iommu_groups/1/devices/0000:00:02.0
/sys/kernel/iommu_groups/11/devices/0000:00:14.4
/sys/kernel/iommu_groups/3/devices/0000:00:0b.0
/sys/kernel/iommu_groups/13/devices/0000:00:15.3
/sys/kernel/iommu_groups/13/devices/0000:00:15.0
/sys/kernel/iommu_groups/13/devices/0000:06:00.0
/sys/kernel/iommu_groups/13/devices/0000:00:15.2
/sys/kernel/iommu_groups/13/devices/0000:07:00.0
/sys/kernel/iommu_groups/13/devices/0000:08:00.0
/sys/kernel/iommu_groups/13/devices/0000:00:15.1
/sys/kernel/iommu_groups/13/devices/0000:09:00.0
/sys/kernel/iommu_groups/5/devices/0000:00:11.0
/sys/kernel/iommu_groups/15/devices/0000:01:00.1
/sys/kernel/iommu_groups/15/devices/0000:01:00.0
/sys/kernel/iommu_groups/7/devices/0000:00:13.0
/sys/kernel/iommu_groups/7/devices/0000:00:13.2
/sys/kernel/iommu_groups/17/devices/0000:04:00.0


$ sudo kvm-ok
INFO: /dev/kvm exists
KVM acceleration can be used


$ perf list | grep iommu
No amd_iommu events

Best regards and many thanks.

-- 
David Coe

