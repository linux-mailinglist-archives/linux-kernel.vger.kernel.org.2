Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD32A3309B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhCHIr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:47:56 -0500
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:46113
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229497AbhCHIrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:47:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8CauPjbQIOavQTyqkgMMu4z4FKdM5WpGLz2LmXJOHZ/TQomKxnrdY68Tgj9J/JJSQRoURnX025GQQdw+PTGDdfUMh9h9hTkshdY24hwb7FAK99m7ghoa7GwwSUbisqT2syytRYiOPm8rOYgogfyWS927Zb/7z9LP5uaTwO6nWxrdaJOZaAUTQ0HE62FOnPE7WBsfBrdfclW2LyTrvET7sGNcp93RoM2wY8cEzXzUEyMtbJ+TywMTKm5dEztWgaTDBzD9zdZP77FwSIedwLGBhQCINJ0efCdrl6cYz+PRDzWKr4qtfydDcDQcdnH/XxLHvd20xcpFtvwjOZGQqGFBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI/1azM/cRm9QxhN1E41j7ZYNCfjo+sFxy4YcO5Vt3U=;
 b=XvZyk9kQzrbxUADVjMq3a7//mv5rCjQ8a9ksRGB16lPEJIkkIj1daMBzDa3zVoqyvxGB9YRDFVmoPSsSFK3J16sR/KVsK8YhDwIQPsR2xflO1+/k+zQygv8AbGHEF79ZYPo3ZJr5JNtCnZl7mmhLetpHobJSF9OCnVhyH3Ul1KFtqHc8WcmISQngpIgvSNlQam7SWU5Q9Lvr82F0iuf6Ns8ynjE3UGUx48bmEPruMC7aflRHCXneqeh5DsbEl6PzltQBS539dy7mc/GSeWstMPJ/vbnB2GVk37QeZgoJwgvKqx+Z1V41I149sxRjIIMxOYQII+hhv/gkWKVFInWj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI/1azM/cRm9QxhN1E41j7ZYNCfjo+sFxy4YcO5Vt3U=;
 b=DMExs8SM/Gd/BBNxaCbsGMsGFROCKJU2jLT+raAYG70EgWiDvFSheYYTyC5DlfjbWlpEKUDjbWy88FLxy9EKbe24s16bLxXRLulewEuSlKHctIg+YDTveTMoG6FuLZhhREE/Q+saG00Xq8P6jlbeKEKTnFiBQdTv+0jP+5Kbhew=
Received: from SA9PR13CA0190.namprd13.prod.outlook.com (2603:10b6:806:26::15)
 by SN6PR02MB4862.namprd02.prod.outlook.com (2603:10b6:805:94::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 08:47:27 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:26:cafe::c0) by SA9PR13CA0190.outlook.office365.com
 (2603:10b6:806:26::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.23 via Frontend
 Transport; Mon, 8 Mar 2021 08:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.25 via Frontend Transport; Mon, 8 Mar 2021 08:47:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 8 Mar 2021 00:47:25 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Mon, 8 Mar 2021 00:47:25 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 krzk@kernel.org,
 robh+dt@kernel.org,
 quanyang.wang@windriver.com,
 laurent.pinchart@ideasonboard.com
Received: from [172.30.17.109] (port=52264)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lJBXx-0000Rx-24; Mon, 08 Mar 2021 00:47:25 -0800
Subject: Re: [PATCH] arm64: dts: zynqmp: Add compatible strings for si5328
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <quanyang.wang@windriver.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210308070843.2096992-1-quanyang.wang@windriver.com>
 <YEXhuGeMoXbfWI6I@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a577fa2d-eb6c-aada-d460-35304af7b18d@xilinx.com>
Date:   Mon, 8 Mar 2021 09:47:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEXhuGeMoXbfWI6I@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0ef6913-1eb9-4654-5a4e-08d8e20ecd0f
X-MS-TrafficTypeDiagnostic: SN6PR02MB4862:
X-Microsoft-Antispam-PRVS: <SN6PR02MB486236FDCC6D22762CC37CE4C6939@SN6PR02MB4862.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02lvJeq4bu135iHQRXgUrS+Fgy5+keB4cH3OxoxwrHOjjagN8Hxw0WwNq3CSUeJCVfaV+Dg9NIuBsYeCjNwtC28yAC+ZsSisortoByom8oY/ne+nWgYNc12NYHCP+xTCLHM7By6fIdA1p4dthxBtzNz9wYOhCeiHiRAgWoXjtyg8jtH0mRHOCiRslDUjew5xkTVeJj5IlYV4+YusLlMCszjgZEVc5V2MDf4KuO/U52OIQJF913k6cE8ioJQxw6LYdhQKkxbucoyNu65vzIwCF0HpaEYTJg1b903SsFwMQz0jaKaUMXjO+9kTB8Fah/ZAfGmFLqu/pDskMOyJwjJ5GkHx8KO8lttRtdv6nZydN+zvcVOEsHkklsf0MVbJ+nOkEd0tKJdht7Z8RJpEoiOvIl+ukGH0jhLhlowHMDfeTwY6Vgasg/P0xpeoZIUHCcjUwAIuMDBelR7BCkKowb7onRHUhsomzkbA0rf71NSs2nhOf3cfzsDYO0/mjin3qRZ3hZcXZ+t2I0P5ZVU3IcfG3Z26JXdnbQmt0NtP2lQZ8qBxfNlETIBK5MfTu0a1wGM3sf7/73CEuq3ED90FBZhIfsqvy8Mp1sb0RsE8v8huXyP1HfDBLhAhXeyEVEQcvtAesmJL+vfGtQNBgVEVPQj8IL6FC9jRtwmT+05IeRCyVgbl4pzuGzwVh0YCPFSJCNpReIQSwEkFbA1uG8VT0FAfWg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39850400004)(46966006)(36840700001)(8936002)(82740400003)(110136005)(9786002)(31686004)(36756003)(7636003)(356005)(44832011)(4326008)(2616005)(47076005)(316002)(54906003)(36906005)(83380400001)(31696002)(478600001)(6666004)(36860700001)(70586007)(4744005)(5660300002)(70206006)(53546011)(82310400003)(336012)(2906002)(426003)(186003)(8676002)(26005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 08:47:26.9880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ef6913-1eb9-4654-5a4e-08d8e20ecd0f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4862
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/8/21 9:35 AM, Laurent Pinchart wrote:
> Hi Quanyang,
> 
> Thank you for the patch.
> 
> On Mon, Mar 08, 2021 at 03:08:43PM +0800, quanyang.wang@windriver.com wrote:
>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> The function of_i2c_get_board_info will call of_modalias_node to check
>> if a device_node contains "compatible" string. So let's assign the
>> proper string "silabs,si5328" to clock-generator@69's compatible
>> property to eliminate the error info as below:
> 
> As far as I can tell, "silabs,si5328" isn't documented in
> Documentation/devicetree/bindings/. We need DT bindings before making
> use of the compatible string.
> 

the second option is to remove/comment this node.

Thanks,
Michal
