Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4522330DC76
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhBCOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:16:44 -0500
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com ([40.107.244.54]:46049
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232144AbhBCOQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:16:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8SUF24SZOOMD2jaXRXxhM3/ge+ZjKz4qfWxERcbuwBTGVj/+H7cPSRD1qlyfH3/eEQ7D2sCdXbllV+Odi52rUu7CnCFoZJxbYi7FAP/LHn92Gtpl7I69tztJccTXksHAxLmcbez+QJ1WX6Zlv/Ktz8Cx5v0SW02Sk11VKrLp7g61Ae9AO3QMDFShe18KUK9WtCyoDS3IYAmP4qgwHsX9JPc+PxDzHQxqBvSfExqn/5l7wXb3rWv3htcq1AWHwk/RB9pIUwLY0Al0alctR7y+3V+FIyqEQbsjx6MJWzCvIxlXn5lOVSoaitPrP0WZ2g2eUKQKBE+jKtx/1COC7nWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEeN3DVIDoTCf5pQ9eTXW+9ySt/Pa0SAVmeh3DfeVVk=;
 b=nlzZvl5ml17lGzyqR8yQuTH8RKPwNz5zEeZN30SxwGNbPQp1g019C58z9Vpdqsz2+/mh6BQC6qq9xENf/336EQ8lJyOW2J7VwsYWftJGzfWb0nzI2z8GfDkvYRi3CGRgC5GWT8mhmDFvVaUSeMphY0tz8AHI2QmzbhnSLdiXp/KJ6w5qBgG6V4r9lRGEjjalwUhEnfy2U1hYCiK/XylRrgyi1YSb0shsf6xjt/H8TlfS2dFL9MBGfO01DinKMJjVtmr9CuvsK/iZU+76V1g7bVzd/go5e/xayh5bTtl0VSb/Ly4jzbwW0UQrSha21jynbCd9OiiW0RnhZc5p9h47Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEeN3DVIDoTCf5pQ9eTXW+9ySt/Pa0SAVmeh3DfeVVk=;
 b=obJochEdiIBPubbGuTaKG527KqIo8jINZaUxghy1fpSwk3JwuEAvb7RHYsDWNpSKdNWy8RW6LTaqsgVMLck3l1lfK89hUjx7ImzcVnJb6Ymh0TK782LIOneaLu7StZfjf/Kc+Vrs6++A78DW0XkQv19fx+W4RHOiqPhyQZEiydo=
Received: from SA9PR13CA0178.namprd13.prod.outlook.com (2603:10b6:806:28::33)
 by BYAPR02MB4053.namprd02.prod.outlook.com (2603:10b6:a02:f9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 14:15:46 +0000
Received: from SN1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:28:cafe::10) by SA9PR13CA0178.outlook.office365.com
 (2603:10b6:806:28::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.11 via Frontend
 Transport; Wed, 3 Feb 2021 14:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT043.mail.protection.outlook.com (10.152.72.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 3 Feb 2021 14:15:45 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 3 Feb 2021 06:15:23 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 3 Feb 2021 06:15:23 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 andre.przywara@arm.com,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 robh+dt@kernel.org
Received: from [172.30.17.109] (port=36178)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l7IwE-0001bQ-VW; Wed, 03 Feb 2021 06:15:23 -0800
Subject: Re: [PATCH] ARM: dts: zynq: Add address-cells property to interrupt
 controllers
To:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michal Simek" <monstr@monstr.eu>, git <git@xilinx.com>,
        Andre Przywara <andre.przywara@arm.com>,
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com>
 <CAL_JsqJnu1M6ut8g_36ve-OG22jFsySHbmVHOgtDRhc-s37rpQ@mail.gmail.com>
 <210b0e5a-767b-c285-62e2-23de19bd3cf1@xilinx.com>
 <CAL_Jsq+m7F+nD6VKd2L5i44hz32_-6iX3toZ0A0CBT-g7Xqu9g@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a2f10400-51e5-bb76-f5c4-3b8e2fbc2793@xilinx.com>
Date:   Wed, 3 Feb 2021 15:15:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+m7F+nD6VKd2L5i44hz32_-6iX3toZ0A0CBT-g7Xqu9g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aab851e-4308-4610-ff4a-08d8c84e32bf
X-MS-TrafficTypeDiagnostic: BYAPR02MB4053:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR02MB40534750C7718EF22E3FF8E5C6B49@BYAPR02MB4053.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEg0kYqWj2/i2Qhb2EIPKLLH42BGScWow8C7ROlgyyPCbKgVhzPXPFZqyvYWnnPYCB7lpzwZIoJ6NojVtxS70xiUEBfHhMSRyYwt6K8b05Rhy0XYjMBDCXh9ylJtXaC95YAvHx7vpCpEpmP5xNrcGz8xFMpWCSgWDfzjjlqRXxJTdzodquYRLreyhkjacktJd8dZRo+zra+B+f9YdhYQT8qgPpYMfLcYrh+W188mZExqH4D9qO/SjgH7SzoOt6sGuNiE+ZBF+X+SivzroLSXqs7wpzDQmMo9dsWwxWGU6fueJqUQMlQBp71dic6q5hen5ZRW9Z/2BdxmrGxluycsRpAdRpVNYyFgGc+HJggyDtvnneJs541plOciA0sWs4tFs/HiSKdLwfl9jNOLjwgvj+WK3AIFaKqLfQNazOIvZtK4pt3pF8nOnClaHrAluMGpOam5Z5uS6KoMTvWeGF/zSiKEehslpIR/Ggn5swiUBrl8N2yJen4qSrphFnDktdCV0cwjdI53b2NCKmJikPDQiltT6rGV+qXzCtYhOu4vkLWzdcRuPj293JOz9gRKN6lRgu3rKYgrZ5WwsqoGEiXkii8ksgGo8eO5ORC3iK1R4y0o90WI20ex5p6lpQ5DMqa/cxYUywwzXVmQdKcuid5HbCG7RgHVglDGFaangFREiFF5yfhuExoWYCC9YCqU2A6pMa9VjCxsmoR/xJ1tC3UvLg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(46966006)(336012)(36906005)(31696002)(31686004)(5660300002)(6666004)(44832011)(2616005)(2906002)(186003)(8676002)(36756003)(53546011)(54906003)(8936002)(110136005)(26005)(7636003)(47076005)(356005)(83380400001)(82740400003)(4326008)(82310400003)(70586007)(478600001)(316002)(426003)(9786002)(70206006)(36860700001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 14:15:45.6573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aab851e-4308-4610-ff4a-08d8c84e32bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT043.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/21 3:12 PM, Rob Herring wrote:
> On Wed, Feb 3, 2021 at 1:01 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>>
>>
>> On 2/1/21 6:41 PM, Rob Herring wrote:
>>> On Mon, Feb 1, 2021 at 8:27 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>>>
>>>> The commit 3eb619b2f7d8 ("scripts/dtc: Update to upstream version
>>>> v1.6.0-11-g9d7888cbf19c") updated dtc version which also contained DTC
>>>> commit
>>>> "81e0919a3e21 checks: Add interrupt provider test"
>>>> where reasons for this checking are mentioned as
>>>> "A missing #address-cells property is less critical, but creates
>>>> ambiguities when used in interrupt-map properties, so warn about this as
>>>> well now."
>>>>
>>>> Add address-cells property to gic and gpio nodes to get rid of this warning.
>>>> The similar change has been done for ZynqMP too.
>>>
>>> FYI, we're going to make this check dependent on having an
>>> interrupt-map property. So adding these isn't necessary.
>>
>> Good to know. Is there going to be report if interrupt-map doesn't
>> exist? Which can end up with reverting these changes?
> 
> You mean a warning if '#address-cells' is present and interrupt-map is
> not? No, that would cause lots of warnings.

yep. What's the timeline for this? I mean I want to get to state that
all current warnings are gone that it will be much easier to add stuff
which we have in soc tree.

Thanks,
Michal

