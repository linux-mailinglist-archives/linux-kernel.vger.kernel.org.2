Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8041B40B2D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhINPTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:19:25 -0400
Received: from mail-vi1eur05on2054.outbound.protection.outlook.com ([40.107.21.54]:61953
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234273AbhINPTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppl/mDrXQizW8mIqhIcC54Kw3sb7SUDfPkSL/GEnuh8=;
 b=LVJ5GJOeeNvQk2O0ZAtS1z8TkkQ4h0zuacqggPqErNhsuRboTarFd0kagcFUXemAEF9UPLSKGNPWNkXzckg/Szgvk2DlDl7MtmNG4tmktlPZEUqThteGGxFV+GMLmb0pfxbFLnwAbbpbWiklwFjnxe6GQtTvq+JDxgyRSaZfCyo=
Received: from AM6P194CA0098.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::39)
 by DB6PR0801MB1781.eurprd08.prod.outlook.com (2603:10a6:4:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 15:17:50 +0000
Received: from VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::59) by AM6P194CA0098.outlook.office365.com
 (2603:10a6:209:8f::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 14 Sep 2021 15:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT033.mail.protection.outlook.com (10.152.18.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 15:17:49 +0000
Received: ("Tessian outbound b9598e0ead92:v103"); Tue, 14 Sep 2021 15:17:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 31f54c92c71872e2
X-CR-MTA-TID: 64aa7808
Received: from d33975e69068.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AC9F01BA-09FA-474E-8850-24FF3C4113C9.1;
        Tue, 14 Sep 2021 15:17:37 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d33975e69068.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 14 Sep 2021 15:17:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBIWOpQx0Rmye8QFtrTM/hh7TUEntaUQJJP0wLzhvCp51uJ4w4RtWgJuY0iqQdBnMdAIfPgEr/TIFUpk6kWf0qYV/TuLwOWIn/qjmqd3G9WAfx6SaNhhbNt2wu4jA6lkT2YAkertRcpHGSnIC7n4GhZBEMwueoYZ9Vkro6wTQwF3Afh4hbVMwDPHV7+lUBz4zBR4fZ3O0lHZuZLO2y6n0jMSFQ3xAaBFWnkxPnyhacmtPLZrPrFItAuF/Yz9Gr07lbCb7HXHgzkPkG1Tmb2yY4ncE3mzWBnvffofOWaNFsW5t9pAM/voRcd8IKVXN4kP3QnZof18jm9yq635rlnYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ppl/mDrXQizW8mIqhIcC54Kw3sb7SUDfPkSL/GEnuh8=;
 b=PezPd8qzoxY/bncdu/hWvOFBJac7jayQxTpIWqStVCAxmDqWMj/oeX8vibMVp5s+Ekt/3TMjYjdt8hNV2jXPjOuxVECrzbZU6WLR9nGKp55JhIKCy4jM5Ukw5BteXN2TlY9JkA2Fy0zI4LYUNMnji2MdbozxcinJZ+LyLgp+cPXTd29lrXHEZcIn7ZsgRUVW+4gPZgarx8B00ENLI2t0NVZl47zVLinRA+IKQlQwr1fO7ax2zPvLBHz2Ns79TnKsK6IxNz8GTDfcLx7Cxt7Afixoej8lCnapTgxytDJSMR7xATzXQBbYwphQOaIiecThuZinhbYAr4sMvfB7wxRUpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppl/mDrXQizW8mIqhIcC54Kw3sb7SUDfPkSL/GEnuh8=;
 b=LVJ5GJOeeNvQk2O0ZAtS1z8TkkQ4h0zuacqggPqErNhsuRboTarFd0kagcFUXemAEF9UPLSKGNPWNkXzckg/Szgvk2DlDl7MtmNG4tmktlPZEUqThteGGxFV+GMLmb0pfxbFLnwAbbpbWiklwFjnxe6GQtTvq+JDxgyRSaZfCyo=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from DB8PR08MB5433.eurprd08.prod.outlook.com (2603:10a6:10:118::13)
 by DB6PR0802MB2278.eurprd08.prod.outlook.com (2603:10a6:4:85::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Tue, 14 Sep
 2021 15:17:34 +0000
Received: from DB8PR08MB5433.eurprd08.prod.outlook.com
 ([fe80::951e:f504:6b46:28a3]) by DB8PR08MB5433.eurprd08.prod.outlook.com
 ([fe80::951e:f504:6b46:28a3%9]) with mapi id 15.20.4500.018; Tue, 14 Sep 2021
 15:17:33 +0000
Date:   Tue, 14 Sep 2021 16:17:24 +0100
From:   Joey Gouly <joey.gouly@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH] arm64: entry: Improve the performance of system calls
Message-ID: <20210914151724.GA34977@e124191.cambridge.arm.com>
References: <20210903121950.2284-1-thunder.leizhen@huawei.com>
 <20210914095436.GA26544@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914095436.GA26544@C02TD0UTHF1T.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN7PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:806:121::21) To DB8PR08MB5433.eurprd08.prod.outlook.com
 (2603:10a6:10:118::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from e124191.cambridge.arm.com (217.140.106.55) by SN7PR04CA0076.namprd04.prod.outlook.com (2603:10b6:806:121::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Tue, 14 Sep 2021 15:17:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b24935f-7034-430f-674f-08d97792d078
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2278:|DB6PR0801MB1781:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1781BE2308FA2C1F8680634294DA9@DB6PR0801MB1781.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: +jKsRqNrJy/F9xJqutLhfVz7vb/3LG1o9xATKnGn+oSODFYGjutM0d8/Hm11p2GSvKVkC9jtEAkdkU4TyeGb98BHs/iD7n3f94b3njKUS59wHleUfFOLRvB4sF+kz7u43ZopySM359NP9g9Nv71jUEamPQ0H2OBy8MbJbwb5dBu6KGfxKNVjvbGreAzw2iFXHdUw4ZrmG836fMeMiNkIhpH3bp9ADOdzLNmopRphnqNBfkaBSIGs2lKp6cu5RHIxKAk0jQM2XxAP3GWG5s/LRHbsgy2lbGSnriRwj46w4mKSxlWmbdWT7s8b83CpaAFDMtN+MLK1HdCiuHZ7xnKHmJqbpk3L7QTLLKBYa34r8Za2KyiLVmfYFeIddjGZ4+DpducpjOUj9EegUzb1nSoeYRyzf+SZdEVYPwSIt2WiA4GH9+aub9KaATwFYuthcUJy7LauW7U/nJSBm/Wfs6wJ6FeTlIWgEJ8WuL9QPiB48uRRz94FcmP6C93nB7eS1CpyersrGjgJyXIoLpeFyjiJHGeRdOOTQukpCK9YNsxryba3WO2K8Znd2zg0KmjIWWuv6S9hORqe447u24WFZFGDAZRH/Ot1+VHkUdRiLj6Mc9NZQOPBXUKgillrId3PR/pF/cgmdo9o+O2KVQoU/RcGtPdLQcyUB5Wt9KgfwXlbB5jESMRGEoncz6nenT1KomCyrhmZZtfeSX0Q5+MYFS9ViIxmsJRwqc7ysROtVwfBVkVkLcC4edjZwvhjGPY3y/1FshFBy3PoTnOxJ3mFTi2ws24x/sUxUWdXKNdIvNHU5Hq2JCF39Q8ZOGCd5Pa+2LFIE3MeYpDOT8V4WdM/sdNcew==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5433.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(508600001)(44832011)(8936002)(6636002)(2906002)(66476007)(8676002)(66556008)(186003)(26005)(66946007)(38350700002)(52116002)(7696005)(33656002)(1076003)(956004)(55016002)(966005)(4326008)(6666004)(316002)(6862004)(5660300002)(38100700002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2278
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5e045732-baf4-4efa-d933-08d97792c681
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOp0MpZzLAeSSUuY8ADyj2n2qq6j4SCCmEIXc3GxSKUlZrhuj/N1ksKZ08H33Ma4ot/r+AwJLVK3gFe7/ahUbaNpz0xNOKVGRpehhyT4O9zAIPs3pCOyB2RUH2kmF0nFOBivHWHNcwmrpHAHaNnLG1FFVWGF5eZF+W5kUoc0JEv4UbnpPafYdODX92QzkEuLHBcS3DXASE4MfWN2krFC5upWu23pzH7rpcIY08mlhTuGfDItYnUl56AdCEH++FVlPPlVwl9TzbdHtU0MPB7n37top/Ucvgxo4I/LuTI22KP8PN+XQgm4HU7U3oUF3waDFZNibJ3eHs+6fSky7J5W3b2VKur9NZ3IP9ZeC+rEEX0TjueOBaqpeLdH6OQGnIlt6q299vLITQ4VL/QzKWZd9b+akPgQQBWziWFaRKNhkVIRQoxXNlU3OZOa4Ic6X+4UmF27Fqc7iomNqNg1CldTMQCBx0g8GeqnnDdCZ6S8Pe7vsprjN0fcIN+DX7O9KgeN7FfTwgNHJ5gtrEgJDa7Fc/w4GibcQsT5iDmmTnZ15GBjkDv1+UVlYJoVyoovcqbR7ir+VsNFFgHPSoeiT+4mhLB7yBttgE7Cos/9vhjxovplhRIcMNfKhAmQLI7igJdGX+XTtG/N6iARfppJPreVCvDaKOG5SJ9WXxoK5P8R11/vsiUlCIgVdJPDYLcdo7ceymtvi9Y26nceQ+W1NYeJ2tYOGu7qJWMmH38sPNiSIEegfnZxhvOryGpZYLLcD+q2Sz7GAlV/d9Qh9BbWzT8UbE6EpMn2tf5k/GWtWo0ewKF9+LNjy3+Hu8N7f08ye2FGtkJQY3H/lEcMBiuPSljp7A==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(46966006)(36840700001)(356005)(86362001)(70206006)(33656002)(70586007)(7696005)(82740400003)(55016002)(6666004)(6862004)(36860700001)(336012)(478600001)(956004)(186003)(82310400003)(2906002)(81166007)(47076005)(1076003)(54906003)(26005)(966005)(316002)(8936002)(6636002)(4326008)(5660300002)(8676002)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 15:17:49.5048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b24935f-7034-430f-674f-08d97792d078
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1781
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 14, 2021 at 10:55:16AM +0100, Mark Rutland wrote:
> Hi,
> 
> At a high-level, I'm not too keen on special-casing things unless
> necessary.
> 
> I wonder if we could get similar results without special-casing by using
> a static const array of handlers indexed by the EC, since (with GCC
> 11.1.0 from the kernel.org crosstool page) that can result in code like:
> 
> 0000000000001010 <el0t_64_sync_handler>:
>     1010:       d503245f        bti     c
>     1014:       d503233f        paciasp
>     1018:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
>     101c:       910003fd        mov     x29, sp
>     1020:       d5385201        mrs     x1, esr_el1
>     1024:       90000002        adrp    x2, 0 <el0t_64_sync_handlers>
>     1028:       531a7c23        lsr     w3, w1, #26
>     102c:       91000042        add     x2, x2, #:lo12:<el0t_64_sync_handlers>
>     1030:       f8637842        ldr     x2, [x2, x3, lsl #3]
>     1034:       d63f0040        blr     x2
>     1038:       a8c17bfd        ldp     x29, x30, [sp], #16
>     103c:       d50323bf        autiasp
>     1040:       d65f03c0        ret
> 
> ... which might do better by virtue of reducing a chain of potential
> mispredicts down to a single potential mispredict, and dynamic branch
> prediction hopefully does a good job of predicting the common case at
> runtime. That said, the resulting tables will be pretty big...

I tested Mark's branch which implements this (found at
https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/entry/switch-table)

I also took lmbench from https://github.com/intel/lmbench.git and built
`lat_syscall` with:

    gcc lat_syscall.c lib_*.c -l m -o lat_syscall -static

These are the results I got from benchmarking on my MacBook Air M1, with
the following command:

    ./lat_syscall null &> /dev/null ; uname -a ; for i in 0 1 2 3 4 ; do ./lat_syscall null ; done

The kernel was based on arm64_defconfig that was then stripped of as much as possible. 
GCC 11.1.0 from kernel.org crosstool page.
Clang build fom git b041b613e6fff713fc9ad6dbc73024286fb2fc93.

gcc:
        master: 0.14300
  switch-table: 0.14350
        likely: 0.13962

clang:
        master: 0.14354
  switch-table: 0.14642
        likely: 0.14256


The generated code looks similar to what Leizhen has posted, so I didn't
post it again.

So it seems the table approach actually performs worse in my testing,
and Leizhen's approach is slightly better than master (d0ee23f9d78be5531c4b055ea424ed0b489dfe9b).

Thanks,
Joey
