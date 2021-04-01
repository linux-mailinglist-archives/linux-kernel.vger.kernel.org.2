Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B79350C33
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 04:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhDACDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 22:03:03 -0400
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:35201
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232893AbhDACC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEKeFoee6k5HzoTzf+jDoRo+eFhItIdly4dZSqg6Ha3Krzfe6KWeGVAhMPpEGbdTBD+kV5hNTcOB19KIbHSoLimdrcSzmVXesNwtTi+gWzD2IphKmXbuFK9ntUYijEFamWC9serbGwdO2UyndjLu2aa8cEvjYkC3Jm2XCxlthkogRCJqOEu05eFsmGCC3uWZnIK4eMTwMBxIDrIZD5NcsebJFQ9nj4vjW5bhIegWvwXhyVO9CX1KvDpeOLC5dLmemztuwzCynttH+M5HO3mptDBncfd5VOxk9GYVNsZ+HxHh6DtiU20Bthzq2o4vUiTQoRFo2lGjclDIF7DhIsl5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAz4H5Vfz34kuX05YjEPrU89uYRw9KRaM2436nBP4w8=;
 b=afO7pxN8c6EErRtHjbkaBT5CSzMH0MulO/Oc5NIMY55NJEdkH8b6hVFIwBSjvNz3AbKbpAGU/5SUX/wr6qmCh1bYpxHDhEWa53/EreSnBaS3HazuyWUo4njdYeeWz5ray75P74enRbVkKFzk4hFVoNh/vNIf/N57UY6Nj7IOotQoiYGFKkDZrTNxU1wqb5BwBebo3OX4MgrOgkZEpxwZ9FpVCjVuV3NNGOsMu4DYGxLWaEq4w25qAWIXlwYzp1jTdUUZIiV50LsZ486kmwX7i1P6Lv8VbyBgkfs9LUPvfxNERoQamgOpDASfvmYFoOuOWI8hSBZbAmkyfbI+n17wQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAz4H5Vfz34kuX05YjEPrU89uYRw9KRaM2436nBP4w8=;
 b=UzPs0ar/Mzk1iJMbOKfofTZOxvXhrnzjUE0HRg8AiGV3PicGBbGP9q6hDmwZ3FLu9f0NVRIL+Pp5XpKpEMl8v571yPh8F3C3yT8liIkLPrm+qpiVPpGFMj/XTG/xXbLDk8pxp+mUYcyyp2XtjSe6rKuWV/l3PLk5heGdh1WkQiQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1718.namprd11.prod.outlook.com (2603:10b6:903:2c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 02:02:25 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 02:02:25 +0000
Subject: Re: [PATCH] clk: zynqmp: move zynqmp_pll_set_mode out of round_rate
 callback
To:     Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210331090018.3464094-1-quanyang.wang@windriver.com>
 <161724172079.2260335.16388981768978108196@swboyd.mtv.corp.google.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <6bbc7554-625b-ae74-2e42-a324eee633fb@windriver.com>
Date:   Thu, 1 Apr 2021 10:01:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <161724172079.2260335.16388981768978108196@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by SJ0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:2c0::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Thu, 1 Apr 2021 02:02:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b20113f7-3e66-404c-51f8-08d8f4b231f8
X-MS-TrafficTypeDiagnostic: CY4PR11MB1718:
X-Microsoft-Antispam-PRVS: <CY4PR11MB17181D14A386B28FE3378A25F07B9@CY4PR11MB1718.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JiHB1ZHlkystMFSpERAixOtsjXwAK/u5NiSz9SxUZbLSTWFMxZ+VYgkW+5Nctsx2GSaxmep7EvU6jXqZAL30Om6YOxOOYxukXysWuGey8zJ3j9PZIVMX947ue66g/MlF6QYZ6ffGp8NMHpHMq3Qoo/2Z2pICKhK7x3lMQe2FXsYQkfywnEilRm96jBKYp1/AjZi7YXYZ5HoM9veL0QQ/bJ6prrrfd5+katmWVLp9AEMcJJwaaXxaJfeHBt+nE4pWHYDuVp+bt5cJpberoUBnbzIvQ1HJyeohuqcxKQD8zkvv6U123OOgZ4B9RefY6zfvE7sVAact3iYVO9F9WDmw42PAgzxFJ9BoPUf/ZrfdZiztIjGWAFipOvY7aH1b6NDoZeDMgGwGw9kQmDYlyTOJqso1i4UT+A+/Ygp1WtVWPqAbhrCGcaSXSxrPEB3NnG0XkDA14T2B7CkCDZ+rWjfmx8Amn4VujQgzN5vZPdc1erNTBsI8PdysJwFpYNOVV8TNxublXIWLlATIaJaCrCpZx+kOPMIBq6oaa/svL/t/IOElJu9YNE16uM1Omozd8JiB5jm2pjV6quygkmVcM5Fo4P3COmh2GUhR9ooxdKYtU2B9dEvrCWjM8Ba6d2LUx47mcDvprGvQqU6bzgVbeOB8/J+ryiioiLGgcH9rtD4Pujt4Bm+9VW+O3Y2609cW58O9leC49MfzmOZ+4FXALaAYtKW2AXonsJmOej/6m5bLMTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(366004)(376002)(346002)(6706004)(66946007)(31696002)(66556008)(66476007)(2616005)(38100700001)(53546011)(478600001)(6486002)(956004)(36756003)(31686004)(52116002)(4744005)(2906002)(6666004)(16576012)(316002)(16526019)(8676002)(7416002)(186003)(110136005)(54906003)(4326008)(8936002)(86362001)(26005)(83380400001)(5660300002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZERsYzJOT0Q4ZTM3TDdGR1NPQTZGdldLR1FRK3VTUEVRZ1M4YkdEZDJEWDV0?=
 =?utf-8?B?a3U4RTB1bDVmMjV5L3EzRHNRZU9JMGVudWMvdVVmY1NodS9oUStLMWsrb0ls?=
 =?utf-8?B?dnZvNVI2eHluT2NSWlJjWUh3VElnSi8rUW9KU3RLK0JaVGdWOVZEaVRTY285?=
 =?utf-8?B?bFRRMkFQWHI3VVFCcTkzdmNSYjlHUGZjQW9kS0tmR0dTMXl1N3J5MUV0VjdB?=
 =?utf-8?B?TnJmLzA5eDJkNWNyRGNzdEdhMGI0VEFCcHpUM2hYdk1sYTZpVWROVDd2NHZh?=
 =?utf-8?B?c2pXMGVET2lNY2Z4bFFXVUJ0ZFJjcG5BaGsvV2NYeG5mQ2ZuMTU4bHMzcEV6?=
 =?utf-8?B?eERzTjRzQnhHbXdrMGMyUmJ6Q2lTOHR0RUtTWGxWdEFVQVM0TUNHSllyeHk1?=
 =?utf-8?B?YXluQkdEK3BFYksxYVB2TkU5T3NqQjA3WVJNb0J5K1cwK0VZT0dOVW16bDBG?=
 =?utf-8?B?My9zTXdQdUtPd01MMWN2UVVibWxZU0Q3UW50L1hFa2xTS0pMSVZOMGFqdEJ3?=
 =?utf-8?B?UmpmM1BWV0trblBKQ1NVcEYzWDlNVXNGV0w2SVZBRFJMWGg3cjNGRHk0N1pE?=
 =?utf-8?B?N3dnWFQrMktLSHh0QTl6K05hUEoyL0JKQWNGQkFaRUhKNUNVYmpZdU5RTDNr?=
 =?utf-8?B?UklVS3pZYllNbHBFbEdZN3dDazlvak5DdTJBdVN4VnhyckhtclhYL1luSFhr?=
 =?utf-8?B?Y0JGV3FZU3Q2QWhKOHBSeUFtSHBsWHVtbzhCVEgzb0dRc0VLNzQzRE5RZDVT?=
 =?utf-8?B?ellDcTIremVnNFJGRlJ4MlNOL1RQYXhiRnNkSCtneHpOYnNyQ0VBR3lJSWdv?=
 =?utf-8?B?b01NdW9IdjFLU0hZL29ucHpCbCt1MnptdVRHSHhKTGRZR1ZZV3hEOFpsUkNi?=
 =?utf-8?B?VC9IWnoxeVNCZkF6OW94YmxIemlMSGpValVoYmpwYWd6ZWhpQVdwdXFnVndr?=
 =?utf-8?B?UFkvOEJOeTQxaTU2bE9WWC8zU002TDZhMzlVL1ZHT2o0bHFoa1JoNk1nRVRZ?=
 =?utf-8?B?ejEwVW5YRGhCUGEzSm8xRElJaHMraTUyWnBjSU5SV1c0S011dmNzaTM3NHl3?=
 =?utf-8?B?MEdtYW1YTGdiWE9KeUhhU1RRaXVkSE9zb0NnbWgyMlFxb1VoUzlISVc4bkRK?=
 =?utf-8?B?dFFBTVRsM1dOSmplUTd3aTVPcUQvdmVKa3p0dHgyMkhhMytyRmQ0dmloeG9O?=
 =?utf-8?B?SnExRm1JQWY5N2NzR0YwOXJkdS9PVnBoaXBWNHhPNlA0RUdXUlZHaEViTDNI?=
 =?utf-8?B?RktwRU9ocUU0L3JuanlydG5mb0J6dGkxTmZ0aDNDb2VsOW1MbHo1VEFxSjVo?=
 =?utf-8?B?MStjbmdyNkdQazJNY2RTa28wZmNVZ1Y3WVhLZVoxeTVpL3A4dHg4anFlVGFm?=
 =?utf-8?B?blA5QnhEb0g2VXlPdXdha1ZZY3FYNzk2SStxZHViQ0ZSRVk3UlVmZWlPMzJI?=
 =?utf-8?B?WlU2VHhKaVRsQTRwdnE3TUhhYnY3MTZMK1NDaWsxQ1VKV2dxaWlnS1o0cjBT?=
 =?utf-8?B?WTVCWGpNTlV1cC9VSnBTNUR5S05qeW5ncnBDTUJpcVhCRnlOOEFGVTNSc0Ru?=
 =?utf-8?B?VS9yTW0wL1JPbE5rbnIyQmtNelVBWFV1dEZJMnVFQm9WWER3MFNtV0J3d2F2?=
 =?utf-8?B?ZlhhUFBkK29GaWoxMlFtellPcFlYQzdXSk9uTmVNYWdZd3gxZnkyZlNmaXg1?=
 =?utf-8?B?Vm5QNEVzTzFvdzNSRlRqbVVoeDZBK3QxdlRUMXZsdGlHV252VlUrS1BIUEYw?=
 =?utf-8?Q?cj2X/qkTKVQCOCqPPhzY4PQdKYohlOonNOaVcXO?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20113f7-3e66-404c-51f8-08d8f4b231f8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 02:02:25.5057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxaGyog6In8ccWkUIT0E+kwFFsr94Bxsy5dEaa0PIuaHbXfYpmTgfi9oeUotEIwYZeE6j5VYN/XIHzNPUcidEdmlhY3oeqBwIhxwZgMjClQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1718
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 4/1/21 9:48 AM, Stephen Boyd wrote:
> Quoting quanyang.wang@windriver.com (2021-03-31 02:00:18)
>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> The round_rate callback should only perform rate calculation and not
>> involve calling zynqmp_pll_set_mode to change the pll mode. So let's
>> move zynqmp_pll_set_mode out of round_rate and to set_rate callback.
>>
>> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>> ---
> Any Fixes tag?

Thanks for your reminder. I will add Fixes tag at the V2 version patch.

Thanks,

Quanyang

