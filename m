Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079F236374B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 21:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhDRTRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 15:17:00 -0400
Received: from mail-oln040092072020.outbound.protection.outlook.com ([40.92.72.20]:54964
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229488AbhDRTQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 15:16:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaiGVYjMs5cUe92TPavtMQ873SbZtoiGG82f6+Ww4rRy0VHMTF7nPmbZx/rKGXit0JTCGUHWY9NNdMAwGXWiOEdMzCwSzy7sd4l3l4nKGGpI6ZAm38uMdMrW8QGxHfQ8onIR3d+COR1TbkQ9mlWfvyovoZqEpIxPyBLkK0KmyhVz6Cdgevb9bUmVet0tbGhb0UJ/ooVD6e3jgb8tSXv7xNP2V5WM1LgUvzQ3HK2j01Q45TSs1rN4VD0Ov/Wf9px0D5lbKraetDXZb64+Yjq5713oQQxO/22IhfTmjqU/IgPUl6uJHP7hMQRIXwC0Na9dlQJ2wvwMhpuyYdLNqb6mNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cfn04uCu+FCjrnkbKb5ROGOBCUHKUtOLmPJ/87Wj/A=;
 b=dL12xlIewcVcXFKqv5uu7lKPtp2xXfSIN2uBKRfXJdBOskbK0cJMo5ymh3YlctkJu2H/8l+4V3A1M0A2IYqeQsevheRG2DuBp9TVqAtAzLUt3/JSrN6Iy+Ph4OxTcU2whz3NI9QPSJgOVJxYKmvCL7NdLExXuMkKK5vhtzhuQnUeA0a9ofHIR55/lBejTATHNJeE1idJ9i8f9kBdbaNdg/19oLxdIlnyTx0qg/K7k82gF0an5Zz8gPBDmmUrOkJKmHU3q2RqnmboWmrZCyDeG6JfrUcftekWEC0YA6uBQtVaiujx1OHlLoVMsNsRKD0mfdSVHBFY/8AJ/MXK1myAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e09::51) by
 VE1EUR03HT191.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e09::377)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Sun, 18 Apr
 2021 19:16:29 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:7e09::4f) by VE1EUR03FT005.mail.protection.outlook.com
 (2a01:111:e400:7e09::172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Sun, 18 Apr 2021 19:16:29 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:A1ED976C8DD8FC7A3096F651AA6581424025CBA0B1C8B7EBEED8FA8507A47127;UpperCasedChecksum:A3E5392CD0DF0F30E56786324ECCFA638BD0BE3B27014B27E0E9E6EE11353C74;SizeAsReceived:9318;Count:48
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4042.024; Sun, 18 Apr 2021
 19:16:29 +0000
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, will@kernel.org, jsnitsel@redhat.com,
        pmenzel@molgen.mpg.de, Jon.Grimm@amd.com,
        Tj <ml.linux@elloe.vision>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Alex Hung <1917203@bugs.launchpad.net>
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
 <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
 <add9d575-191e-d7a6-e3e1-dfc7ea7f35c8@amd.com>
 <VI1PR09MB2638289727E1854B5CE7A3AAC74E9@VI1PR09MB2638.eurprd09.prod.outlook.com>
 <df6c8363-baac-5d97-5b06-4bcd3163f83d@amd.com>
From:   David Coe <david.coe@live.co.uk>
Message-ID: <VI1PR09MB263838403F08887094285F8DC74A9@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date:   Sun, 18 Apr 2021 20:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <df6c8363-baac-5d97-5b06-4bcd3163f83d@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-TMN:  [dWROUlZXdO/XMqDl5vi6BZoFfTq1kjWz]
X-ClientProxiedBy: LO2P265CA0413.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::17) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <ae6fa6a2-88ab-2e0e-c01b-e81ce4d0c826@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.181] (90.246.218.100) by LO2P265CA0413.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend Transport; Sun, 18 Apr 2021 19:16:27 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 033c58c0-b24a-42c6-77b2-08d9029e77d3
X-MS-TrafficTypeDiagnostic: VE1EUR03HT191:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrsX/T0Ur070IulO9KWDZWeXEWQBbECaho+sKkbv0E1gQBIbZkKzF2x6vrarYgJtMEu6/T5WkDgq3syrdOa20E9brW2enOnOeqMtFxligsK23eKI1Hma4JvexVie2QN1XI0AOXKX5uvsgYkygXJUzOD9EYe8WzYHiqa9XGcDfDwweiPdVZHVZffKuDaoYa+l7yI2ZtiLfr7lHcaAnZ4MqkW9uf3SFAexR4ldxZxKbFzZn+mNSPz3YSvDobhMQKyNPFiJuqoBWj/GOw4irds1pYgt6PsLwWDoFDXGLzmvAUAJA3ZMYt4co7kiLBdgVZVygL3QR9byAhILAzXCpeJglLT5gphkOD1oL8xlegn1qzWMG+xV5L5SnryyLm13Ah2IGFuol5nW+DCHd6D8Ywr9pw==
X-MS-Exchange-AntiSpam-MessageData: cQh92S/Iq2spVx8M1/6AX9jOLkGNzQ8ZUFDjoVQp3hRtFxnjM0BIR0wVjbL4uJgc7OYa4crRrL4y1iBRRWU0OUTcYFknomS1FM0YZ75Ph4loqJqCI5gurdAS/GIr1m2r/j/60FIXNNuQs6FaLw9yrw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033c58c0-b24a-42c6-77b2-08d9029e77d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2021 19:16:29.2738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT191
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee!

Results for Ryzen 2400G on Ubuntu 20.10, kernel 5.8.0-50 with patch 2/2 
alone. Events batched 3 x 8 to avoid counter-multiplexing (?) artefacts.

On 15/04/2021 10:28, Suthikulpanit, Suravee wrote:
> David,
> 
> For the Ryzen 2400G, could you please try with:
> - 1 event at a time
> - Not more than 8 events (On your system, it has 2 banks x 4 counters/bank.
> I am trying to see if this issue might be related to the counters 
> multiplexing).
> 
$ sudo dmesg | grep IOMMU
[sudo] password for info:
[    0.543768] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters 
supported
[    0.547696] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.549196] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 
counters/bank).
[    0.811538] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>


$ declare -a EventList=("amd_iommu_0/cmd_processed/, 
amd_iommu_0/cmd_processed_inv/, amd_iommu_0/ign_rd_wr_mmio_1ff8h/, 
amd_iommu_0/int_dte_hit/, amd_iommu_0/int_dte_mis/, 
amd_iommu_0/mem_dte_hit/, amd_iommu_0/mem_dte_mis/, 
amd_iommu_0/mem_iommu_tlb_pde_hit/" "amd_iommu_0/mem_iommu_tlb_pde_mis/, 
amd_iommu_0/mem_iommu_tlb_pte_hit/, amd_iommu_0/mem_iommu_tlb_pte_mis/, 
amd_iommu_0/mem_pass_excl/, amd_iommu_0/mem_pass_pretrans/, 
amd_iommu_0/mem_pass_untrans/, amd_iommu_0/mem_target_abort/, 
amd_iommu_0/mem_trans_total/" "amd_iommu_0/page_tbl_read_gst/, 
amd_iommu_0/page_tbl_read_nst/, amd_iommu_0/page_tbl_read_tot/, 
amd_iommu_0/smi_blk/, amd_iommu_0/smi_recv/, amd_iommu_0/tlb_inv/, 
amd_iommu_0/vapic_int_guest/, amd_iommu_0/vapic_int_non_guest/")


$ for event in "${EventList[@]}"; do sudo perf stat -e "$event" sleep 10 
; done

  Performance counter stats for 'system wide':

                 18       amd_iommu_0/cmd_processed/ 

                  9       amd_iommu_0/cmd_processed_inv/ 

                  0       amd_iommu_0/ign_rd_wr_mmio_1ff8h/ 

                399       amd_iommu_0/int_dte_hit/ 

                 19       amd_iommu_0/int_dte_mis/ 

              1,177       amd_iommu_0/mem_dte_hit/ 

              5,521       amd_iommu_0/mem_dte_mis/ 

                 70       amd_iommu_0/mem_iommu_tlb_pde_hit/ 


       10.001490092 seconds time elapsed


  Performance counter stats for 'system wide':

                394       amd_iommu_0/mem_iommu_tlb_pde_mis/ 

                602       amd_iommu_0/mem_iommu_tlb_pte_hit/ 

              6,612       amd_iommu_0/mem_iommu_tlb_pte_mis/ 

                  0       amd_iommu_0/mem_pass_excl/ 

                  0       amd_iommu_0/mem_pass_pretrans/ 

              6,590       amd_iommu_0/mem_pass_untrans/ 

                  0       amd_iommu_0/mem_target_abort/ 

                616       amd_iommu_0/mem_trans_total/ 


       10.001237585 seconds time elapsed


  Performance counter stats for 'system wide':

                  0       amd_iommu_0/page_tbl_read_gst/ 

                 78       amd_iommu_0/page_tbl_read_nst/ 

                 78       amd_iommu_0/page_tbl_read_tot/ 

                  0       amd_iommu_0/smi_blk/ 

                  0       amd_iommu_0/smi_recv/ 

                  0       amd_iommu_0/tlb_inv/ 

                  0       amd_iommu_0/vapic_int_guest/ 

                637       amd_iommu_0/vapic_int_non_guest/ 


       10.001186031 seconds time elapsed

Best regards,

-- 
David
