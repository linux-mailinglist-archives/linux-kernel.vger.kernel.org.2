Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE993054DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhA0HmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:42:01 -0500
Received: from mail-eopbgr750057.outbound.protection.outlook.com ([40.107.75.57]:42573
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234414AbhA0Hii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:38:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiXe6Op+dro2OzBhIVYRroMStj6zVrH6DIgGbzcp2MIlpwWW7xai7fnGF5Vf1kxzPGqNx18rtbzaP4s6ykJXGNsZe3wIzkdPsetFizJ9quX4dQOtLNcJHHJSWURLrO4Vs690zvVYFNdZED9jnCRhUH00355YfJlfJoLSBrv7Fu0vQNW2kCO5Y3+5v9AEQ6yN/TCIeVrmxBWT5w0w2e5AI8ufKH+m3KqiiDR4l0Psus0uOfM2070u0Tw4sM3rQP4czSFRNcojvDlS6a+g2DzByTSvupJOSv5lhZ3/ykfK9XNjw4lDmLsuBqJuTYR7oIwGInjAAMvtPnlg5Gv/tIRUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCxccbosQ9EoEUvWK665lHw4Z2dj5MbiRfuPjgGIsHk=;
 b=ZPcEPuR8XUq4uDk8YJV5ZgK5k0hgEG0BknM12pfA26LaxZpUGnB+5TwmqjjjamVWrukDqjgWa9kpWI83GqedXUQtxwy/RVybH7I40/65izQW/O1aLjZFoMAyqWSochuJ42AoupFtjQkJURYqmKTTJ0gGW4sqjtMUdu+d+cum+Q9h2RIITJanVf2MPXwJRaDFUKBZ3NtMoFMgmLBhJEDl2ZkpNWTFX6pUgRMrlGdcVNE5JmA5J+hBC9n8eTBLUrQMn8I66v7H/TNlnGCkD9XtzIvHCZ9qpg4bCaUrxI9o0cijo4Os7DZl4Gn3+dbw8QA2FlUxpPflYfcGv83viUwBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCxccbosQ9EoEUvWK665lHw4Z2dj5MbiRfuPjgGIsHk=;
 b=NMAs8G3G7uum7wyvYpYVdrRnnOxxDaKZwcLJNb2WZR2Zj1vd+GE8WAYWh3L3AahJXXyr/tOKOG28kXkY+bAMaKBEdlsX/aRTjl3nUKsyBAXOs2aLBv1s6n7BlMeXI4j49Y+14DijxzxJ8DONgMdOcKxv1Uehozqy+Hu6kV95H20=
Received: from SN6PR05CA0016.namprd05.prod.outlook.com (2603:10b6:805:de::29)
 by CO6PR02MB7842.namprd02.prod.outlook.com (2603:10b6:303:ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Wed, 27 Jan
 2021 07:37:51 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::cc) by SN6PR05CA0016.outlook.office365.com
 (2603:10b6:805:de::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7 via Frontend
 Transport; Wed, 27 Jan 2021 07:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 27 Jan 2021 07:37:50 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 26 Jan 2021 23:37:50 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 26 Jan 2021 23:37:50 -0800
Envelope-to: hyunk@xilinx.com,
 hyun.kwon@xilinx.com,
 linux-kernel@vger.kernel.org,
 laurent.pinchart@ideasonboard.com
Received: from [172.30.17.109] (port=43194)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l4fOg-0004MI-6o; Tue, 26 Jan 2021 23:37:50 -0800
Subject: Re: [PATCH 1/1] MAINTAINERS: remove myself from the list
To:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Hyun Kwon <hyunk@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210127011312.697159-1-hyun.kwon@xilinx.com>
 <YBDDvmLHrYpuTBkn@pendragon.ideasonboard.com>
 <20210127021855.GA706721@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <7f1de920-98d6-e3e0-5091-d0f03d4dd44f@xilinx.com>
Date:   Wed, 27 Jan 2021 08:37:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127021855.GA706721@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e0cb106-610c-4935-f40b-08d8c2967359
X-MS-TrafficTypeDiagnostic: CO6PR02MB7842:
X-Microsoft-Antispam-PRVS: <CO6PR02MB7842320940605FAE940AFC51C6BB9@CO6PR02MB7842.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFIp+eTU3WT7oecmXcUziVz+smdaW2JkAv/o6HbPTOgQJPyrgHr4QMgSCSgy0rXDBpaD+yIm8ULPEKQPtg80tTlwLwBk0cxR41BmdbCFCcJf74Up/WUqFnVb97kriVGTNG9L9k6qooGhcnc13HRW8CcSXw/O2/+D+xQh06yaG4GSj/w6FbpbBjF//lAmrRHxNOfgTmehPqMV2b0p28xBK5+iAMJB558Ip+IkSMKdaokpxoEOqvWkp3pGyxRRdxPGXqe+oZM6kuqnddSPrPWmW/szANcKeva0WfzCVNUTbYRYOfW/yd2vC4XpbF6eGptirtUdp56c3B3QoEq8GQz2XY72vp5v2C40g8Kkh4okfEM/ti+6aXZbUsmvg96bejqE30l6DwMDGfMvOIqBoAbBDEgtvOguAhf63eo74b+L2FNyk/uC59WDCJWyeqRcGoISjZ2tpArasFvPaOG0q+1zKLEcBSQymbyq57NAsXdzN0oI6hnL7MxXSyJW9LXBzj1+jYixtvQD8RN19RVIJQ6Jbw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(70586007)(53546011)(336012)(426003)(9786002)(4326008)(316002)(70206006)(2906002)(54906003)(47076005)(82310400003)(31686004)(31696002)(110136005)(5660300002)(8936002)(26005)(478600001)(186003)(36756003)(356005)(82740400003)(8676002)(44832011)(2616005)(7636003)(4744005)(36906005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 07:37:50.8279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0cb106-610c-4935-f40b-08d8c2967359
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7842
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/27/21 3:18 AM, Hyun Kwon wrote:
> Hi Laurent,
> 
> On Tue, Jan 26, 2021 at 05:37:02PM -0800, Laurent Pinchart wrote:
>> Hi Hyun,
>>
>> Thank you for the patch.
>>
>> On Tue, Jan 26, 2021 at 05:13:12PM -0800, Hyun Kwon wrote:
>>> The email will become invalid soon.
>>
>> Is there, by any chance, anyone at Xilinx would could help maintaining
>> these drivers ?
>>
> 
> Yes, there will be. I gave my recommendations, but it's still under discussion.
> I'll ensure it's decided sooner than later.

I am still around and I will make sure that someone will take a look at
it. Just let me know that you are expecting any input from Xilinx till
we have someone.

Thanks,
Michal
