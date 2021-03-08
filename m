Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58773330AF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhCHKRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:17:07 -0500
Received: from mail-dm6nam10on2041.outbound.protection.outlook.com ([40.107.93.41]:43232
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230141AbhCHKQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:16:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1RKaJsTXyFz+wQmq5EjvNVJ3GJl0sHRXPgsWmlC9eFQeIl7z7bGFc28yvKTAMnYCDOLz7v/Hn2IPSmW8s8CWOcMjLVbwolE7mTrIi+DHvEDXBDkLBTVzo5yo9NIZMCHKeM+Tp+Ejjznz9JxJXhXmmYFbQPHlD7xN6F1/cVZAMxc7CUmmApAavSA/io1RyExmzmpIgE2GvJlU6WNe6FkBXKjzyvDus8C0Q8F3wnxvhIV0WzbE2D3xGKCxlhNzLGFY3rmvfAzfy5Dcag3GlEJR4ZaUbSjo7ipXp3jHEPquflaomOBF2oSRVrCHgbuFtGDV1++csI3Oiw48rXeH7XiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXZGWwMq49jlnnIOQXMg9lGMH3DFss95vrFAUeJSbSc=;
 b=XnDhVzra1Q4qtRpirV4+XR96gM43MSrttCJ202PX572znh5/oTFjhCHl4S4yvICh7OEjglP0AjKClf/ByLvAHjxp4GfArQLPFq3AYaanVNs1u6RO6lreHtRttqFJft6uMYwCyHP8Rpmv+Yy5Fcib+ul+cYpGWXs4sYClUu2YRxZ/6h2z93AsF5ds2m5iP/NpsksftOdQzJQFc8Cct1/j9W+kT/hCT5YkSmSxwChK61KnFJMXjhy7L3ScrYMNszGt9VdGYsNgsBCBUhoQQKLtQd54JwlvFtM2tsrAk5FPlPyeXAzODz10nWxugD3zFxnDE7E0nj0MtuEKmbPWFd6s5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXZGWwMq49jlnnIOQXMg9lGMH3DFss95vrFAUeJSbSc=;
 b=pg/eOySIAG8kqSZhnQ28OEOOIosXortxKfWWhccLzsorS3ItFs8r4cUe3Uwtjs7VcI2y9Q+ll97r6XgedkSInRn0MZp5+nzoKNUmdoEF/F3BhPYP95yyGRwWy4pbWhnVaINCfeJPtdoS6rr5nCQbgCaZf4vgLC/v1h6Kg7cThIU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1461.namprd11.prod.outlook.com (2603:10b6:910:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 8 Mar
 2021 10:16:37 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3890.037; Mon, 8 Mar 2021
 10:16:37 +0000
Subject: Re: [PATCH] arm64: dts: zynqmp: Add compatible strings for si5328
To:     Michal Simek <michal.simek@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210308070843.2096992-1-quanyang.wang@windriver.com>
 <YEXhuGeMoXbfWI6I@pendragon.ideasonboard.com>
 <a577fa2d-eb6c-aada-d460-35304af7b18d@xilinx.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <12fe8fa5-1014-634a-940d-d33d5b7bbd6e@windriver.com>
Date:   Mon, 8 Mar 2021 18:15:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <a577fa2d-eb6c-aada-d460-35304af7b18d@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::23) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by SJ0PR05CA0048.namprd05.prod.outlook.com (2603:10b6:a03:33f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.23 via Frontend Transport; Mon, 8 Mar 2021 10:16:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a302f2a-8d51-4af9-33b8-08d8e21b422e
X-MS-TrafficTypeDiagnostic: CY4PR11MB1461:
X-Microsoft-Antispam-PRVS: <CY4PR11MB1461A05CA98D0DB214396BBFF0939@CY4PR11MB1461.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMhEb1A9JHjVz6K+bkKT0xYCNbh6OT5yXqfb4PC0h+Dvy8snumaBmAtNRldhQ/hyMU/w9kwbyhjolOtU630/gN9Fsnl14tkdQng9DeH8fc8OjpTRQmkTO4lXjaf2Z50VlW/8cdGzT7PYYqi30XZXMgAdUDvo03Orsva+j7HAkapVvYTRcYgfGs652kmPSsWjrQNSQb/luHzFQWkfrMgka3+I5zIuRBSbVXrfat21SpzbAdjXkHu3AXGpwKn1sIRCh+3Y5XMH1pVvFlKUcHrLFZbuN/qrGaSXQu3iuiy2V9F6v8Yrl0KobAoreIIy3CPc7i8/6ziEKO6pw3vF8U5evbJtjeAu7v8/P7FOjhH71NxYN4I4jWz2UAktFVPJJeg8qyZpVtwPawuKu5zBqbXuE13JVKRMzDpKasSz2+WVOBOAGDAs6jsOV4UtNAGBA6dntIMjL6aGPMYfblxV8TjN3kA7orHpfPMQljxBFGBxpAAf6TCltpQ/wpBHDqT3BOcwNym40Ep4eqofsJVdtKJe7Vf8cj4Ra8TBzGvVVy63GfHp7fvYWsd6nSbGuOO7w53A21W/PRQquy0PjtCnOvz9+tKRAGH1lh2TBNdlH5h7bI8TnedTvNPT5kcrTl5KfUJ8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39840400004)(8676002)(186003)(5660300002)(52116002)(36756003)(54906003)(6666004)(110136005)(478600001)(31686004)(2906002)(4326008)(86362001)(66946007)(83380400001)(66556008)(2616005)(4744005)(26005)(16576012)(6706004)(53546011)(316002)(956004)(6486002)(16526019)(31696002)(8936002)(66476007)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ckVtUHZycmc0N1pUUmJObW9Dd212MkhHaGM2VFB4d1R5c3lKcmV6ZkNHOEY3?=
 =?utf-8?B?VXZzdk1KVWo1dEFZRmlxeUxzNkxJK1BXVzJQcjJXTTQ5aDdQZ1o3Y0ZoMXNX?=
 =?utf-8?B?bllTOHh3czd1aktIbGcyRzlTcTJ3K21peTZBSk9HRnB6eXFwWkw4Q1JaajBS?=
 =?utf-8?B?YzBHSkFSU2pqTnZURnFGR0tqYzZscDZIUCszSUdPSStwaG43OHR6YjFjYisz?=
 =?utf-8?B?S3dtaVZDOWZ3Q2tNRzRPeGtIbFFESjl4YWRSdGVmOEJUWWpiN3ptS2ZVeWNj?=
 =?utf-8?B?U2JVeVNuSXI5dlJNTkFvclFxSGdqTUwyQStaQU5wVTg0SDRSeDBRQVlGWHU2?=
 =?utf-8?B?V2pFOXdtNzFUaDlKUy9SNXBNUVFYZFBDZUVsT3QyOGJhYUk4KzBWQ2JjV0Vp?=
 =?utf-8?B?VFNuT1ZWUjUzcHB0VGNsS1M3Uy9ac3FlSHBub0ZPdU1uUzF3amZTb3pScnd2?=
 =?utf-8?B?WUJVaXV4SXlzNzQ0cTlsUmpCbmpHU0RxY2pkV2xwaVdMbitnTjk1bmFtV0ZI?=
 =?utf-8?B?UWh6bmZwMVp6ZFF3NTlXOXVQTFNmMi9jQmFadVhZenpOdktpTmZEZ0dqZHhx?=
 =?utf-8?B?cDdCVk04WTUwL21BRVVEbCtLWndEMExvd0FFTXFYWDBHZnIydWxTUWxlVkNp?=
 =?utf-8?B?MGdQNS9CMXh4MVFTWUZ2ZlJuVVZBU0JER3k3RWlxTFRPL0orQnM4WFFleU45?=
 =?utf-8?B?SlZuU091dVFzWXUwSUFpUHN3QlYwWjljbGJPTG5GR0FHU3dvOWxwZFBhSGVw?=
 =?utf-8?B?TTgrVXFWNVRFRGJvcjlwVEU5Qk1KWnRwS1FNSStSZFdLenJSNGVnMUtUMERa?=
 =?utf-8?B?RXZqNUhLQmo4THNmdlpla2dGV2ZKc3ZEb0plSkFZTFZUd29QUUhpRmMvR0lw?=
 =?utf-8?B?SDBDekJNL2lnY3VJclNtK09jK2t6M1NaLzhzMWpIenN5WXg0VW1PblhGMU43?=
 =?utf-8?B?eEQ2UTJ1RXFLR25EUXNqYnd5VFhQVGErKzVWVnozL283SUhNVktNZ1YxN0I4?=
 =?utf-8?B?SEcrb1NuNU5kZVVCcHp5UlJDeHFrVUxxeDIyeEQ1QzB4Tk5raE9FQ2FMbnhz?=
 =?utf-8?B?SlUzMko5eUY1Ukp1aUpvVG43aTJTY2plUmZWbTdhR0h4N3JKZTJIV24vblE2?=
 =?utf-8?B?RHdvUXFuQjFvNDBZdG5RbmUxaWVyNWtUN0MvSDltZTFlNDlOZWZuQkQxVFp5?=
 =?utf-8?B?V3dLakpHSU40NC9TSkhiTEZWTmVhQkdTK0FLNkZabUE4U1RpTDdpZ21FalBF?=
 =?utf-8?B?d2lVVnZ1K2QzcitGL0MrTGZQY1UyU3JGTE1welN4QVBLYWdGMURvOTF5b0dY?=
 =?utf-8?B?ZVpPNGJPRjJuT0xjTlc3eStqLzczSkRDTEl4Z1ludWRBa0ZINm1JcGpMMGJ1?=
 =?utf-8?B?UVlaaXdxa0ZBd29pOTFCM3RVZk51WUdOU0Q4RTNDOVpCMy82S1NOR0hreUFF?=
 =?utf-8?B?RlFnRTBPUCtKUEZYUTFEQVIxbWJ6NHBWWGM1WVUxclZoRmxpekZxMXI2aHUr?=
 =?utf-8?B?a1NsK2FuSytNckdRWk54Uzl4dUhiclNCcTc2S0NkaXRPZW9SWXNPbERzMU9J?=
 =?utf-8?B?QVVhTERoQTlKUVYyMTBRQ2lMM0R1SnZWV29pWHpZOVRqQkhmM1RLMHdhTWIy?=
 =?utf-8?B?aVV6a2l5K2NXcE5NcGJ2MkhBemJibkloamhiMWpCRk9uSkQyZFFXd2R0QXBK?=
 =?utf-8?B?T2RSWEhkcTdnNkdvc00yS3N4OEdJSlA4ZjZOV0RkQXVmc3BGdDBJZ0g2Zmk1?=
 =?utf-8?Q?CA+hqcwUqFpX0D07tD9AnUxH8uM8Q0+AEjrJkB4?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a302f2a-8d51-4af9-33b8-08d8e21b422e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 10:16:37.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ex7c/wTuUn5jqWZnPSt+xOdAm5v1keOWjHubDtQG/tJqbRy6GK8MP1X1DaZHyGKE/DSpzQvf2EmDUQ9vWCKwmHAIoRL6TromB4ubE29JWmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1461
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 3/8/21 4:47 PM, Michal Simek wrote:
> Hi,
>
> On 3/8/21 9:35 AM, Laurent Pinchart wrote:
>> Hi Quanyang,
>>
>> Thank you for the patch.
>>
>> On Mon, Mar 08, 2021 at 03:08:43PM +0800, quanyang.wang@windriver.com wrote:
>>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>>
>>> The function of_i2c_get_board_info will call of_modalias_node to check
>>> if a device_node contains "compatible" string. So let's assign the
>>> proper string "silabs,si5328" to clock-generator@69's compatible
>>> property to eliminate the error info as below:
>> As far as I can tell, "silabs,si5328" isn't documented in
>> Documentation/devicetree/bindings/. We need DT bindings before making
>> use of the compatible string.
>>
> the second option is to remove/comment this node.

Thank you for your suggestion.

  I will send a new patch to delete these nodes and add some comments there.

Best Regards

Quanyang

>
> Thanks,
> Michal
