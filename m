Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA303E8F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhHKLaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:30:15 -0400
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:11905
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237273AbhHKLaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:30:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha9gCi4H7vn+hfVEk9VqBqMaiJe3+UHHMuppbSGPVMORnl3FsbjaARuKsoVlxLrS+hSdsBVksbSjn0CB66d8qMLuJdiAki8IvLJ36vtnVUBs48zM9xkyRjmYy65S5VnJrH9STPUEyWBHobHP00VlugLmIFQwBglauyCHOGVas9qyXZQnJCJlMaziIdulW+DURPw2JggeKfzCkazDwhRozdIgCPh3IG79xkYzHlS+IUNsT8RgflpIW+kj0hpA3sE7rASr7XoUOEV9ZjzIXxx2ci8jONUZ5GAXhDwhOpTdQxZgv1zeDevUkNOxbtaqXgg3X7rfXhBFqSQpEZAknov0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylz1gvsICTAJxhLd4PmjSGvBYNm7fcfxaqevBIkWEYM=;
 b=VAwNjdCEAO1Rfp1DDZ2hGqjdm6MUUibjhsvMqgwgO9iS3xX/Wd7KVeJHuD79qq147vdlkhKMEgkyQ8RVJaz/qscgF0APhP9cyL4C76U5ZsO6RXl7mP5snEtg1wc/mfgKR+hfsf8ym6DAc1Qbo4bdxUmKCaY39p9DVXRrlQ7NKm60WEvq9+XUPImGR+Qc0d8OSzu3aSedoCV0vJ5BW9ca/qyhU7eADHNMbqAj//vck16WEHFqxV6s0VUWxERhxjcV48QISVmSA7QpGiNPDKtkWE9NqJXWff2Ypck5EhacEksx9qCvY4NxgJcd8TQTcp9PytFG4/UgjJ4VgwsIGOT6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylz1gvsICTAJxhLd4PmjSGvBYNm7fcfxaqevBIkWEYM=;
 b=M6AfgapaLPGQUaTEVEoiZc6X4Rc3V/sjlQ4hmKhIpJ7vWs80mx/XZ4BvC0JfjFMD8ESeEbYSZikZtsKEXzKD/MxAwkTJJPLxPcQ4lAHa/aZWvUo4UlaW4PvEWoaNL0frTJ2W1jHSFgDHFcTvEr5MiLoYFvlbfJ5aRgVfsgzvtS8=
Received: from DS7PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:3bb::26)
 by DM6PR02MB5819.namprd02.prod.outlook.com (2603:10b6:5:17d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 11 Aug
 2021 11:29:47 +0000
Received: from DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::91) by DS7PR03CA0081.outlook.office365.com
 (2603:10b6:5:3bb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Wed, 11 Aug 2021 11:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT025.mail.protection.outlook.com (10.13.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 11:29:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 04:29:43 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 11 Aug 2021 04:29:43 -0700
Envelope-to: git@xilinx.com,
 kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 p.zabel@pengutronix.de,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 m.tretter@pengutronix.de
Received: from [172.30.17.109] (port=41350)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mDmQY-0002Dj-OW; Wed, 11 Aug 2021 04:29:42 -0700
Subject: Re: [PATCH] reset: reset-zynqmp: Fixed the argument data type
To:     Michael Tretter <m.tretter@pengutronix.de>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>,
        "Sai Krishna Potthuri" <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
References: <925cebbe4eb73c7d0a536da204748d33c7100d8c.1624448778.git.michal.simek@xilinx.com>
 <20210811103621.GA23827@pengutronix.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d3bdc4c8-1e31-e1ac-e192-c7bff74eb4af@xilinx.com>
Date:   Wed, 11 Aug 2021 13:29:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811103621.GA23827@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ed0918f-658c-468d-c8a7-08d95cbb5305
X-MS-TrafficTypeDiagnostic: DM6PR02MB5819:
X-Microsoft-Antispam-PRVS: <DM6PR02MB581949D885390673C02E222CC6F89@DM6PR02MB5819.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzFHpTPuTSmmAGuPenc8Fftmb88c1uCUzsAZwx0Z3Aus54t7xQ1qu7lZKvcvphwdAeyrlEaFK/3ZoRcyE4C+iMEdqCvfECfapLFmmGDs8M1IB751Fe4OBeRZbJRMVQU/rs/qemB0fMyzZ3/Vwi6qT9c8SKolHechhJSa93/iO7NRZbciyDsSRrupNwtZf9OiF/+P2YSrVUjwYUmIKjDcxZh541nhToxqIRLLd967f4RAt7ADJZ3XQipwlp9F7j/oFjSTDeCsJuBBvLx3Tw6+sp4Vor4NQiX0/mLp1wrJbveFQhsnPMP3riZ/WAM0VVnYBN61oDvQT3cb63hUw7ZMbNYoL4UTRGfdYrjb3s2gNCaaKzvxIUQMdKk+4QCylT8zEiiUdWqdnrz2Pw6C5e0BeQSTyzyAJf4N9s3+vIdq5WgfLr3gJ78QmY8ys+3m32rrVp4zW4ybUKFhwT1i5r1x4PofRv+t6/H1YfI8yO+sFdRD1vlQWl/n4IRqPgNmIhVGPm3OlOjLHzvgy2uAa78ArGdSwDTP4vK83MAljB5Ng1TpzqEXOAyaeZGVUD0564z0jW3Mi++Nn5Ovt49HcjjkJ3WceYUUmZbZEFUmKPX6D+4Fe13jLK2xJ/eaCtuXFGnQC5n4SjvsPS6AufB9rdDx10FiXOXc+JUtQ3Fda/kuHT6iKFcDOlQtBNa/vdUUPqjjVYy6PMt+Ntx1aYppIKg7w27JC11g+2qRjo1tMVa3MJXYpx7fmbRte5EXgFaFkxjokPGt25quDmi9rBD+ATTxlg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39850400004)(46966006)(36840700001)(26005)(8676002)(31696002)(31686004)(426003)(186003)(70206006)(70586007)(336012)(47076005)(44832011)(110136005)(54906003)(53546011)(316002)(8936002)(2616005)(478600001)(356005)(9786002)(82740400003)(36756003)(2906002)(82310400003)(7636003)(4326008)(36860700001)(5660300002)(36906005)(83380400001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 11:29:47.0244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed0918f-658c-468d-c8a7-08d95cbb5305
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5819
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/21 12:36 PM, Michael Tretter wrote:
> On Wed, 23 Jun 2021 13:46:20 +0200, Michal Simek wrote:
>> From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
>>
>> This patch changes the data type of the variable 'val' from
>> int to u32.
>>
>> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> Addresses-Coverity: argument of type "int *" is incompatible with parameter of type "u32 *"
>> ---
>>
>>  drivers/reset/reset-zynqmp.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
>> index daa425e74c96..59dc0ff9af9e 100644
>> --- a/drivers/reset/reset-zynqmp.c
>> +++ b/drivers/reset/reset-zynqmp.c
>> @@ -53,7 +53,8 @@ static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
>>  			       unsigned long id)
>>  {
>>  	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
>> -	int val, err;
>> +	int err;
>> +	u32 val;
> 
> The function returns val as int instead of u32. While this shouldn't be a
> problem in this case, maybe there should be an additional check just to be
> sure?

As far as I can tell coverity is not reporting any issue around it.
And when I look at internal of that function in firmware this function
in case of success returns only 0 or 1 that's why I don't think we need
to do anything with it.

Thanks,
Michal
