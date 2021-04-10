Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6C735ABDE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 10:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhDJIRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 04:17:51 -0400
Received: from mail-oln040092074021.outbound.protection.outlook.com ([40.92.74.21]:14980
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229494AbhDJIRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:17:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnmvuSml9GzQ5BMrDgNDosfMHldSnmo4RX1MjXyurLjcQUJxbGdlayLFsSqdXynbdFpTWEixCW10FAxS86VJ/RxRTG5iYwPaVW6Ce1103PZvqVCzEygevlycDAB0a08BCAjrlP8Q05/bumucHz/uoIII/MLsCBpzNNPuEP39iSL8kmvwVdKA+UMPr2GlHsFVPiib9j5UVbuIv9HqMyS8cUxJcnwuGFzPCIF9sXDUSno4VOphCs12RH5MY5NCpTjYxBB5jvbOjOlsDydKPKeYhR9hrJlSM3NuK8Z2wZ5G3f3l7wXrH5pGB38OrnQuK1rfjDPytLTPKWV/fmBF/2uk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OZSPYTLYUxKGz73EOVQZ+RzNGTZJKGo4iDxooyTVnI=;
 b=HYPLMQEwWevyee9TZjGo/LCDFkvfGcS/O8u/aBZEX6r80T7urPV4E4B4Kl1Vie02N3cbQ3nNZ4wonzfW8CY/FitZVNE1rKTwEl6UzE/PlQpwvz2JVi1nPr4sMEShxqmDiECng7Bxd+pIKZQA7RzicxDT1simIUGsgKYiS3QPL4lIgk3g4eKm8WwWMzE+aeqPXRVU9knVy4JIjrPcyO6X8pBdIaitXczCCS3T61RzWHV5W3aEpPoed5E6lRkPrp9pzIKfOPYocUqeFpJFCgnvhuHWJtbFJBS92pMG24TnNxD0TgM+fYpZzeHUQXKAOTVU7hfro26JvsXdxh+LwVl9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR04FT045.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::4a) by
 VI1EUR04HT214.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::340)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Sat, 10 Apr
 2021 08:17:33 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:7e0e::4c) by VI1EUR04FT045.mail.protection.outlook.com
 (2a01:111:e400:7e0e::261) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sat, 10 Apr 2021 08:17:33 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:8565501D067E3CF2B9032DD715922D3AA7E8484DDABA94569EA80264D38183F2;UpperCasedChecksum:EAE8A138F7694D25DC30288BE2E60D8958BC57E83768A30C7515A284411C0C69;SizeAsReceived:9056;Count:48
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4020.021; Sat, 10 Apr 2021
 08:17:33 +0000
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
Message-ID: <VI1PR09MB2638FACB956277A7CEAAE367C7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date:   Sat, 10 Apr 2021 09:17:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-TMN:  [rduGy+E+by0qeIukvtM32Bvy+L3Ajqir]
X-ClientProxiedBy: LO2P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::34) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <3cf21069-e4a7-3520-1b93-a198445412f9@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (90.246.218.100) by LO2P265CA0046.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:61::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend Transport; Sat, 10 Apr 2021 08:17:32 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: ef5f3d79-0567-4965-8398-08d8fbf91737
X-MS-TrafficTypeDiagnostic: VI1EUR04HT214:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMZ26jKp6O9jfyRKLtjGJFI5XNNnJjkuS6joPqr8P9nEeYuv3KPeir60pnY/l22c81UeZWOtYKPYF8S8l9JHmnWJTYp/xgxs6XiBZlIa9NJG9Sfld3i61v2hCI/3Iqu8AkdPL18ADlKzKAqxyTX8YAkBxfwGokdHFxO6SmNQuxAdzj3bzkrvieJzkLQGKa9tu5wKFN8MS6hd0dWzLXwtOIMch1i8xarCv3uk+DzhotowHbMpcrN+GwOBSBFjYNogGXsXKvE4eM+O2EyMCx+Ng97SaZE72bpvUnLWPenkasvjEgN/txrlcIyE7bN3OFl2ktBvblpaAGLv+QbVzO1CV32kfsjSBwMtXZxrD/dIKydM2xxM+bCqSrv18Ay40oaOHE/Lt5WK07OjktoYZCm9BQ==
X-MS-Exchange-AntiSpam-MessageData: L8cyyihZvfgv/iePdLcpzQASoEuYd4fV77RHmkoPCWyyy410MqBjUE0XDeb/Xr3WYpK72mJX+d5sBJtBp90278EqiZsrEZloRz6dq9bQL6SEzFypfFLlrBV8LC2z+JgwXJc2CHPe2eGnkOf5jiTsbQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5f3d79-0567-4965-8398-08d8fbf91737
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 08:17:32.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT045.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT214
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, well! This is a promising start to the weekend. Thank you both, 
Suravee and Paul.

Results for AMD Ryzen 4 2400G
   running Ubuntu 21.04β kernel 5.11.0-13 and Windows 10 2H2 under KVM

$ sudo dmesg | grep IOMMU
[    0.557725] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters 
supported
[    0.561538] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.562828] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 
counters/bank).
[    0.881108] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>

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
     vgif                = "1"
     vls                 = "1"

   Sections:

$ compgen -G "/sys/kernel/iommu_groups/*/devices/*"
/sys/kernel/iommu_groups/9/devices/0000:09:00.0
/sys/kernel/iommu_groups/0/devices/0000:00:01.0
/sys/kernel/iommu_groups/10/devices/0000:0a:00.0
/sys/kernel/iommu_groups/2/devices/0000:00:01.6
/sys/kernel/iommu_groups/12/devices/0000:0b:00.0
/sys/kernel/iommu_groups/4/devices/0000:00:08.1
/sys/kernel/iommu_groups/6/devices/0000:00:14.0
/sys/kernel/iommu_groups/6/devices/0000:00:14.3
/sys/kernel/iommu_groups/8/devices/0000:02:04.0
/sys/kernel/iommu_groups/8/devices/0000:02:01.0
/sys/kernel/iommu_groups/8/devices/0000:04:00.0
/sys/kernel/iommu_groups/8/devices/0000:01:00.1
/sys/kernel/iommu_groups/8/devices/0000:02:06.0
/sys/kernel/iommu_groups/8/devices/0000:01:00.0
/sys/kernel/iommu_groups/8/devices/0000:01:00.2
/sys/kernel/iommu_groups/8/devices/0000:08:00.0
/sys/kernel/iommu_groups/8/devices/0000:02:00.0
/sys/kernel/iommu_groups/8/devices/0000:02:07.0
/sys/kernel/iommu_groups/8/devices/0000:03:00.0
/sys/kernel/iommu_groups/1/devices/0000:00:01.2
/sys/kernel/iommu_groups/11/devices/0000:0a:00.1
/sys/kernel/iommu_groups/11/devices/0000:0a:00.3
/sys/kernel/iommu_groups/11/devices/0000:0a:00.2
/sys/kernel/iommu_groups/11/devices/0000:0a:00.4
/sys/kernel/iommu_groups/11/devices/0000:0a:00.6
/sys/kernel/iommu_groups/3/devices/0000:00:08.0
/sys/kernel/iommu_groups/5/devices/0000:00:08.2
/sys/kernel/iommu_groups/7/devices/0000:00:18.5
/sys/kernel/iommu_groups/7/devices/0000:00:18.7
/sys/kernel/iommu_groups/7/devices/0000:00:18.0
/sys/kernel/iommu_groups/7/devices/0000:00:18.2
/sys/kernel/iommu_groups/7/devices/0000:00:18.4
/sys/kernel/iommu_groups/7/devices/0000:00:18.6
/sys/kernel/iommu_groups/7/devices/0000:00:18.1
/sys/kernel/iommu_groups/7/devices/0000:00:18.3

$ sudo kvm-ok
INFO: /dev/kvm exists
KVM acceleration can be used

$ sudo perf stat -e 'amd_iommu_0/cmd_processed/, 
amd_iommu_0/cmd_processed_inv/, amd_iommu_0/ign_rd_wr_mmio_1ff8h/, 
amd_iommu_0/int_dte_hit/, amd_iommu_0/int_dte_mis/, 
amd_iommu_0/mem_dte_hit/, amd_iommu_0/mem_dte_mis/, 
amd_iommu_0/mem_iommu_tlb_pde_hit/, amd_iommu_0/mem_iommu_tlb_pde_mis/, 
amd_iommu_0/mem_iommu_tlb_pte_hit/, amd_iommu_0/mem_iommu_tlb_pte_mis/, 
amd_iommu_0/mem_pass_excl/, amd_iommu_0/mem_pass_pretrans/, 
amd_iommu_0/mem_pass_untrans/, amd_iommu_0/mem_target_abort/, 
amd_iommu_0/mem_trans_total/, amd_iommu_0/page_tbl_read_gst/, 
amd_iommu_0/page_tbl_read_nst/, amd_iommu_0/page_tbl_read_tot/, 
amd_iommu_0/smi_blk/, amd_iommu_0/smi_recv/, amd_iommu_0/tlb_inv/, 
amd_iommu_0/vapic_int_guest/, amd_iommu_0/vapic_int_non_guest/' sleep 10

Performance counter stats for 'system wide':

                   0       amd_iommu_0/cmd_processed/            (33.32%)
                   2       amd_iommu_0/cmd_processed_inv/        (33.35%)
                   0       amd_iommu_0/ign_rd_wr_mmio_1ff8h/     (33.39%)
                 340       amd_iommu_0/int_dte_hit/              (33.43%)
                  23       amd_iommu_0/int_dte_mis/              (33.44%)
                 556       amd_iommu_0/mem_dte_hit/              (33.44%)
841,689,151,202,939       amd_iommu_0/mem_dte_mis/              (33.44%)
                  74       amd_iommu_0/mem_iommu_tlb_pde_hit/    (33.44%)
                 502       amd_iommu_0/mem_iommu_tlb_pde_mis/    (33.41%)
               1,195       amd_iommu_0/mem_iommu_tlb_pte_hit/    (33.36%)
               8,017       amd_iommu_0/mem_iommu_tlb_pte_mis/    (33.33%)
                   0       amd_iommu_0/mem_pass_excl/            (33.29%)
                   0       amd_iommu_0/mem_pass_pretrans/        (33.28%)
              16,504       amd_iommu_0/mem_pass_untrans/         (33.28%)
                   0       amd_iommu_0/mem_target_abort/         (33.28%)
               2,842       amd_iommu_0/mem_trans_total/          (33.28%)
                   0       amd_iommu_0/page_tbl_read_gst/        (33.28%)
                 111       amd_iommu_0/page_tbl_read_nst/        (33.29%)
                 111       amd_iommu_0/page_tbl_read_tot/        (33.28%)
                   0       amd_iommu_0/smi_blk/                  (33.28%)
                   0       amd_iommu_0/smi_recv/                 (33.29%)
                   0       amd_iommu_0/tlb_inv/                  (33.28%)
                   0       amd_iommu_0/vapic_int_guest/          (33.28%)
                 345       amd_iommu_0/vapic_int_non_guest/      (33.29%)

        10.000799128 seconds time elapsed

Results for Ryzen 7 4700U to follow.

-- 
David Coe
