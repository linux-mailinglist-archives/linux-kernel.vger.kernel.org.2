Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF635ACAB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 12:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhDJKDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 06:03:32 -0400
Received: from mail-db8eur05olkn2023.outbound.protection.outlook.com ([40.92.89.23]:1537
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229632AbhDJKDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 06:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krOqFH/xLnHSsmyx1t0WyE0mtJONezqvyTeWW8sq8tQ4IhSZSIiH+9TuKdFt6EZJhe8NjPFwHGZ0Rn94nMekAlg+vu3/Fq4H42eEcm1jV9tTlIvnmf5ZxU++d649iiIcWxQzeK66SgzvSvIsehRRiAJ6gRs4T87idB/TBZdImneiONLAqlzXnvGtES4cuE8YbXUeIcijELIBoI9tifSmlnEcFiuNNVA7OE2AtOuO5yI3DvoTjrK/BPblUmsNIApIeIaQI0FDyvGBcH2ZZoGilhUedP8gUtFnTyQoifwjuEPhLlkPUor+BwJvFLQzxvzg+Pgqpm/yqUUT/PI0F8MATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDnUlChrho7yHV6JOw6lUCa3PY0pPe4BnBGolyQi8eQ=;
 b=f/dfoN//+b3/lL7+hsSOMGDQUEAy21iaCTbnQEUdMaME37MdH6Vwfdw5mtHXOv8ZcdoIZ/06GjZ9++A/JW/N4Gyh4BOII6BFBn+zT8YKbRRUoLrToksePUweghWXwIpbAU+xjm9r06vkWSnJ2PgDJ/AIbNSjWIda6cipxbPWKcT6pnenjFkgiQIOYMQ3x6iU0fPpF4kxOXv4aXAhiYhlf7CWGtztR72Ylo7kyg+mO98IyrQPVLkSfn5rcb+25vjt6LScxoUmVh3N0pi/0DZtqdHBTisFoC0rQTdOD5kGnaEIGk4RbOXvjJuzvJAQA+JVCseLM9m64t8tuSzlfI1i9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB8EUR05FT008.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc0f::49) by
 DB8EUR05HT198.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc0f::92)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Sat, 10 Apr
 2021 10:03:15 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:fc0f::41) by DB8EUR05FT008.mail.protection.outlook.com
 (2a01:111:e400:fc0f::145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sat, 10 Apr 2021 10:03:15 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:3D429122883A1A381F31F9DB8541E933EA070DAD7ABC5A1B76A0C76EED30ED83;UpperCasedChecksum:257E4EEBA0E5BA1E131C11DAD20DA03B7130794192F44CB78960041E76B131FA;SizeAsReceived:9052;Count:48
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4020.021; Sat, 10 Apr 2021
 10:03:15 +0000
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
Message-ID: <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date:   Sat, 10 Apr 2021 11:03:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-TMN:  [66HEW8I0e7s6Qu0OI8NDwvgvK/W7qqng]
X-ClientProxiedBy: LO3P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::6) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <1789d605-bbf4-9963-d97a-653ee8ba2b9f@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (90.246.218.100) by LO3P265CA0001.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bb::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend Transport; Sat, 10 Apr 2021 10:03:14 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: c4ba8055-1e59-4426-1116-08d8fc07db69
X-MS-TrafficTypeDiagnostic: DB8EUR05HT198:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sOo7KviSg5bQB7l+b/aYBOQbnCQFg+IdGewtlJIB4qw/NHM9hFFDS4hliZsfe6+grxa0CNtMfUUJBuxr8/Myudeb4OXpdPdRvlzZ8Mj3mRpwar0+l21qzs5lW75WP27ZbgDGbXNXOR3XWgEk6t/qBfDAyG9gi62JkCp415AlkxlmBg/xTj1tisiai1uLVPEBIvbA7lwRXoDDTUBd+X6jqZmHms5WPpsh9sC07SyNwqpcG6QnMhzw49RuJLeCWi6X/lFmsDuvOvzQs7+McCFuHpRygnpXDo/SMcl71AdNH9e5mc8LhleXaIKFSc7+YNWsfXCU8FenyYphoAm42+XckMe4/gQW6923fe2B4uDJCr2U6+jVfwEhx1RX7SFXGYc
X-MS-Exchange-AntiSpam-MessageData: EjtzUb0JhDqu5AXhYh9ZCV4mj1EdKApyba7cH3/rcbrQ1G8Vlo4pYgpnRbC9ehD9JZXhFs8zNgaZYgHwIAQVJO45uCSBOeTt1Zb1sE2rLJGISAas9ZH2V1PfG3NYSf1+HNoZfh+vlmOeM8Nc/KJvzA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ba8055-1e59-4426-1116-08d8fc07db69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 10:03:15.1050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT008.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR05HT198
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Results for AMD Ryzen 4700U running Ubuntu 21.04β kernel 5.11.0-13

$ sudo dmesg | grep IOMMU
[    0.490352] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters 
supported
[    0.491985] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.493732] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 
counters/bank).
[    0.793259] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>

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
/sys/kernel/iommu_groups/0/devices/0000:00:01.0
/sys/kernel/iommu_groups/2/devices/0000:00:02.2
/sys/kernel/iommu_groups/4/devices/0000:00:08.2
/sys/kernel/iommu_groups/4/devices/0000:03:00.2
/sys/kernel/iommu_groups/4/devices/0000:04:00.0
/sys/kernel/iommu_groups/4/devices/0000:03:00.4
/sys/kernel/iommu_groups/4/devices/0000:03:00.6
/sys/kernel/iommu_groups/4/devices/0000:00:08.1
/sys/kernel/iommu_groups/4/devices/0000:03:00.1
/sys/kernel/iommu_groups/4/devices/0000:03:00.3
/sys/kernel/iommu_groups/4/devices/0000:04:00.1
/sys/kernel/iommu_groups/4/devices/0000:03:00.5
/sys/kernel/iommu_groups/4/devices/0000:00:08.0
/sys/kernel/iommu_groups/4/devices/0000:03:00.0
/sys/kernel/iommu_groups/6/devices/0000:00:18.5
/sys/kernel/iommu_groups/6/devices/0000:00:18.7
/sys/kernel/iommu_groups/6/devices/0000:00:18.0
/sys/kernel/iommu_groups/6/devices/0000:00:18.2
/sys/kernel/iommu_groups/6/devices/0000:00:18.4
/sys/kernel/iommu_groups/6/devices/0000:00:18.6
/sys/kernel/iommu_groups/6/devices/0000:00:18.1
/sys/kernel/iommu_groups/6/devices/0000:00:18.3
/sys/kernel/iommu_groups/8/devices/0000:02:00.0
/sys/kernel/iommu_groups/1/devices/0000:00:02.0
/sys/kernel/iommu_groups/3/devices/0000:00:02.4
/sys/kernel/iommu_groups/5/devices/0000:00:14.0
/sys/kernel/iommu_groups/5/devices/0000:00:14.3
/sys/kernel/iommu_groups/7/devices/0000:01:00.0

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

                 12      amd_iommu_0/cmd_processed/             (33.28%)
                  6       amd_iommu_0/cmd_processed_inv/        (33.32%)
                  0       amd_iommu_0/ign_rd_wr_mmio_1ff8h/     (33.36%)
                290       amd_iommu_0/int_dte_hit/              (33.40%)
                 20       amd_iommu_0/int_dte_mis/              (33.46%)
                391       amd_iommu_0/mem_dte_hit/              (33.49%)
              3,720       amd_iommu_0/mem_dte_mis/              (33.49%)
                 44       amd_iommu_0/mem_iommu_tlb_pde_hit/    (33.46%)
                810       amd_iommu_0/mem_iommu_tlb_pde_mis/    (33.45%)
                 35       amd_iommu_0/mem_iommu_tlb_pte_hit/    (33.41%)
                746       amd_iommu_0/mem_iommu_tlb_pte_mis/    (33.37%)
                  0       amd_iommu_0/mem_pass_excl/            (33.32%)
                  0       amd_iommu_0/mem_pass_pretrans/        (33.28%)
                  0       amd_iommu_0/mem_pass_untrans/         (33.28%)
                  0       amd_iommu_0/mem_target_abort/         (33.27%)
                715       amd_iommu_0/mem_trans_total/          (33.27%)
                  0       amd_iommu_0/page_tbl_read_gst/        (33.28%)
                 36       amd_iommu_0/page_tbl_read_nst/        (33.27%)
                 36       amd_iommu_0/page_tbl_read_tot/        (33.27%)
                  0       amd_iommu_0/smi_blk/                  (33.28%)
                  0       amd_iommu_0/smi_recv/                 (33.26%)
                  0       amd_iommu_0/tlb_inv/                  (33.23%)
                  0       amd_iommu_0/vapic_int_guest/          (33.24%)
                366       amd_iommu_0/vapic_int_non_guest/      (33.27%)

The immediately obvious difference is the with the enormous count seen 
on mem_dte_mis on the older Ryzen 2400G. Will do some RTFM but anyone 
with comments and insight?

841,689,151,202,939       amd_iommu_0/mem_dte_mis/              (33.44%)

Otherwise, all seems to running smoothly (especially for a distribution 
still in β). Bravo and many thanks all!

-- 
David Coe
