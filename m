Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA033A98F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhFPLT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:19:29 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:34510 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229546AbhFPLT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:19:27 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GBBPku031781;
        Wed, 16 Jun 2021 04:17:11 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-0064b401.pphosted.com with ESMTP id 39728b0gtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 04:17:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYP6/wr9kMgXmtr8AU+vNyuOjAkkwc34CKL4M+DArqNc6BblvXGLESXTHVF3i3RtXdyq0iuPx5kWJ7i8ds7Jegn64ms870bwuDFyVedEu35O7tVxFR5PG/slsnd1oEGcIy9pCpcbUo/Kdp5dtnDN3lsTuC0sN7lZof2AC7XCM5AlAgOEH3zlCShSi9VQXn8vrtB9TL1FfnftwoU4kU71cOCizmjymkiugIVzV3bOI5UsU/7WmcZ/Z+PFmef4343Fj2hHIh66l0tNIwJob1Jwqn6Ow/GAfNY6kfssfYD/fG/dKIL8I/jA0TDfbWfIEIIsZknB0+YqzJij7RiOYK3s8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48FB+4WB3l2NCxT7WgV1TUlrwvbP4e1wq/RG3WHaCws=;
 b=awLY7sv7h3BDzR6lQ235TBskqSspowvnFUnWl8AyvgHitbjgj9FwfLJxTrQmcbJpvRmc73jZ9rJpZiCXcOjfvNFTOYI9OiIDgx5z6Qn2aE+ekB9gHggTKOYCDSLMN4UDEY6nqGHZQdDNLLGwXCSzE0thVZlWx3/dei04GvRujYwaO6mgGm0mDiz95/NdHf22O5Uu9rX0S2ceySmtIOzoeTVP0pTlhGtkBC8/q8gdI7PfhXjP4VhUYZGuW7Z/LOqnnaNuEbXWZEv12PTlXsRrki8wqx26V4BIQfgSszOZp5W+gGdvAWdpWO+rhlgMEuQ3K2KkhRV5VXOnj1XrGDVcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48FB+4WB3l2NCxT7WgV1TUlrwvbP4e1wq/RG3WHaCws=;
 b=bXnHCtomtH5TDnpMb4II6S7Zsu9ZrCg/n9ze7g45Phv76DzcJiIqkQlNhmqBTJaRnc2t0JVhbiil1tukQXCLEVAp+f1j3hYh+Zo72dPPPLWtr1K3Ve3MMGbfjQoFGbRaXPS6TwszH13L5/ayDSrbPI1fTi7ROVyck+7TBGoQn3U=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB0005.namprd11.prod.outlook.com (2603:10b6:910:7a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Wed, 16 Jun
 2021 11:17:08 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::40e4:b9:53a1:de74]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::40e4:b9:53a1:de74%6]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 11:17:08 +0000
Subject: Re: [PATCH 25/31] arm64: zynqmp: Wire qspi on multiple boards
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1623239033.git.michal.simek@xilinx.com>
 <80671218c97ad2188df476cf1b49bcf6f64785df.1623239033.git.michal.simek@xilinx.com>
 <71b6423c-ab14-424f-0018-fafece13150a@windriver.com>
 <d8d3f8e9-d59d-be12-05dd-5fa9b64cfcbe@xilinx.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <fcba2eee-4330-ec39-6880-70af201944a1@windriver.com>
Date:   Wed, 16 Jun 2021 19:15:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <d8d3f8e9-d59d-be12-05dd-5fa9b64cfcbe@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::32) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by BYAPR05CA0091.namprd05.prod.outlook.com (2603:10b6:a03:e0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 16 Jun 2021 11:17:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3002ee73-2442-4b54-369b-08d930b84760
X-MS-TrafficTypeDiagnostic: CY4PR11MB0005:
X-Microsoft-Antispam-PRVS: <CY4PR11MB0005374FDE77F1C0C410BE31F00F9@CY4PR11MB0005.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMHvUQ0zGo9IdOV8r1Lz3kSWP/lg5A4OwMX3jJrlVIyzZ6N19eJICp9ggqNz/klky2cjzVKB2DdJ/nNeBRYT/ewWfNIxXh8wfu+vDu2OxJpgNR4HxYt4nJNgqs73+AJIicd8VEvS0Tm82nDtpb1jDPTqwche85j1ztuVuYuUah3Ykzl8ecQhgCUOjPi27ZTK9sYDGeu1oUW6Ce9PMtteiE47ohqhA8jOTmD5bKBgR0IBPg0t7s+i6n0eQ3St67FwCWHO5UTzOI0TnEF2BWXIPA7SavHoQrTVy/N7eLXfbXFOdPZlMgNVX8sY/chTzBiPH0dDSn3f7Cf114pzB7crAxVFHj0BnAUaGUScVxqdOX1f1plJGPpBToCKkLxhcEWI2uaerTthOgaezDjQ6Q58eUjC8128enQw++9lyOudQiFf/f0wu/Am8NvWOA+7SdTSTJE+YYd34ZzgR3We5HwM5GlZQo5wCtsc6E9/z990sjfLS7g5hGlE80dKQnoEW2JO+FlkakzSpjIoeebwGLYn0TfUBOfFTSfZ91yac90IRHxMfXJ4RCuqEysYADI+YLSeyNr5hsH3CpFYMuF9Ns5EtQCDeBxH+rM7eHHyvRWVdo4d5SDIOqlfL1kFGEzBJyU3wuahUzJjGexMZC28rPtX4maZVFQthZZLkeskLpLvKLxzwOPWn7QuPFTk3Qea4N+EFmTx1S3RNrrP+NDY8XmSYOg/RzIFUIVJdwLSWPIO63Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39850400004)(366004)(136003)(52116002)(31696002)(8676002)(16526019)(4326008)(478600001)(86362001)(53546011)(26005)(110136005)(83380400001)(316002)(2906002)(6486002)(16576012)(54906003)(31686004)(186003)(956004)(6706004)(36756003)(38100700002)(66556008)(66476007)(2616005)(7416002)(38350700002)(6666004)(8936002)(5660300002)(66946007)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRRNWhzbEhQSlhMcitTSEtsYmxkbElQdjl6eVp1RnJpd1Y1ZEpLZnJ1Qmhm?=
 =?utf-8?B?aitsWU1ydlpYQW1mMitIT1ZjYUlZYW5hbzJkcG1nTGtPZFd4dXVFWXlQVitw?=
 =?utf-8?B?SGtYM29DMWs3bFJQQW9YZS9ISFhKeThBbXNQaXdYMnZRb1V2VHZsT1NMdEpK?=
 =?utf-8?B?MTZOSlUvcmlnd0Z1alZUMk04RFUxOEdocUpkK2JsREZBcGY4UWd4QUpOZ2lT?=
 =?utf-8?B?czBRNnEwZUlQQ1JTa0dqZVBwSnpaRzdTcHR2MnUzd1h0QmRpdHRPNzhvSXdV?=
 =?utf-8?B?Y0tQVitwR1ZwMmp3YlVuOVUxTzBYYlRQOFFRZU55Y0R1blM5ZktobmFjN01Q?=
 =?utf-8?B?L3RlS09DTWw3ZXl4MkFzSDY0bENiMWtpanlsZjZtVkdma0ZlWC9rV1N2ck5Z?=
 =?utf-8?B?cTdSUjVHQ2hQczNtckplYlIycmZTQVNOdDBRM0NYejBRRnI2MnpzcWlWQjZL?=
 =?utf-8?B?TWcvN1d5R1NDbGdRMDc0WXhCaWhQTkkzMkRWNXEwemtWTlZOZWNvVEw4OUsw?=
 =?utf-8?B?aTlUVGV6WjVZWXR5VVpITU5jL3NVT1hxbnBJK0h6MGFlYWtNUEpNMDA5WEZw?=
 =?utf-8?B?a213Qkd4QXJ2dW9ycXJZbXR3RCs0Tkk0dXVSdU44MXdwQ1k5MmNPa3VrSThP?=
 =?utf-8?B?WXpJNXFUai9oRFBGc0k0cWdkL3hhcG9sWDdTdjh3YkFYeUI2eHAwN216NFky?=
 =?utf-8?B?VU9VYy9LcnRHU2s0OU1FVjhDMlZFalFyTU5WeUtaZGtxMys3ZEYxNFFCYTB4?=
 =?utf-8?B?eG5nSk16by9XRW8yYnA2UmNkak0zWTBFSlBHbGdVYjViVm1vZWZBcWNGalgx?=
 =?utf-8?B?empNZittZ0VUd3pUeXIxTWNvTXV5Vlp3M2ZWR1BOZUhJRm9LUHJzWlJxUm9D?=
 =?utf-8?B?cDdBQ0t4TFVUVkhUYmkzbS9KR0VhTWtxekxHc01lSUo0ejUyRTA4YjZmKzdL?=
 =?utf-8?B?SjY2Zlh4bFRDRU94eUlxZXgzNitxajEvUmVJYkxHRG50OW13Rk43K05tNk9r?=
 =?utf-8?B?M2x1dWJOUldSelhFL1gwK3UwdU9Ja2V3NDR5TllTU01lRWtTWmRBbzlLQ0g3?=
 =?utf-8?B?cTZGV21sMis1bW9kV1d6NkREbXlHUXhVSHBYV0l6THlRbFk4Ymc4UUpWbTdq?=
 =?utf-8?B?NFN1RlZHdFFWa3lJSHhFQktEaW43Mzg4NW5QMVlJQTd5M1ozaW1rYjhDQitL?=
 =?utf-8?B?VEdoVlBRdER4MmZzbzVDMHcwZ3RpREY1cU94NFl5MVk4emJZbWRGeUdha0RP?=
 =?utf-8?B?QTdmeE1WVTMyUFF0bUhxSjZCVG5jVlFzMExxY29jNkxJR3BXOXRON0xOUDZR?=
 =?utf-8?B?ZGlTZHFzcGYwbmJXdTFCSmNlalhBSXJXaDZYeXh0R1RpQ2ZpekM3UWlCb1lB?=
 =?utf-8?B?ajdCZWdrTnJqUzFUOWRjK0Fyd0Z6aEQrU1hlUmlUaWoxYmZzbjNuOU5Tc21B?=
 =?utf-8?B?MTQwR2FzYWlSYXlyRTlpU3J1OU0vQzB0ajVoeDZLTUdhcHlKbUl1UFZaWm02?=
 =?utf-8?B?TUZ5VlQwbWswSjk5R25mbU9RYVloWkJrbmtyWmx5MW9KY29mdnFnZEo1dW1L?=
 =?utf-8?B?NVZ3bCtraklBTkNROElZazdKOE5WcS9XenBXNnkyNTBqYlRvejFwaVVGTi83?=
 =?utf-8?B?d1JTelphTzNhN3pYTXh6cHlvNThOaEhHQVQxa0Y3WlRiWFdlV2c0QXFLbFVy?=
 =?utf-8?B?VEliRGhBV1d6MzhPTDJsVU93emZSNzlKc011dXVOclJzSms1YS8vZ3RKdTlj?=
 =?utf-8?Q?Y0+iWO5j396cL3Rc1KGbJzctjEGA5Bem/JEhE3W?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3002ee73-2442-4b54-369b-08d930b84760
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 11:17:08.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AP2ZPZwiA5ZDtRrotA0PmYeiBGAQIOK+s5HmiYmWVC2JPFv3fdlWygWciIF37UF0sC1+r3PGVVlbuKCo5sKc29OdmDDQoQ5FGGM4AOFWg7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0005
X-Proofpoint-ORIG-GUID: TmYJJrA-6fPcF9CYb65-XVMHIsxoMcRc
X-Proofpoint-GUID: TmYJJrA-6fPcF9CYb65-XVMHIsxoMcRc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-16_07:2021-06-15,2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 6/16/21 6:52 PM, Michal Simek wrote:
> Hi Quanyang,
> 
> On 6/10/21 6:08 AM, quanyang.wang wrote:
>> Hi Michal,
>>
>> On 6/9/21 7:45 PM, Michal Simek wrote:
>>> Couple of boards have qspi on the board that's why enable controller and
>>> describe them.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>>
>>>    .../arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts | 16 +++++++++++++++-
>>>    .../arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts | 16 +++++++++++++++-
>>>    .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts  | 14 ++++++++++++++
>>>    .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts  | 14 ++++++++++++++
>>>    .../arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 15 +++++++++++++++
>>>    .../arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 14 ++++++++++++++
>>>    .../arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts |  4 ++++
>>>    .../arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 15 +++++++++++++++
>>>    .../arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 15 +++++++++++++++
>>>    9 files changed, 121 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>> b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>> index 2e05fa416955..f1598527e5ec 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>> @@ -2,7 +2,7 @@
>>>    /*
>>>     * dts file for Xilinx ZynqMP ZC1232
>>>     *
>>> - * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>> + * (C) Copyright 2017 - 2021, Xilinx, Inc.
>>>     *
>>>     * Michal Simek <michal.simek@xilinx.com>
>>>     */
>>> @@ -19,6 +19,7 @@ / {
>>>        aliases {
>>>            serial0 = &uart0;
>>>            serial1 = &dcc;
>>> +        spi0 = &qspi;
>>>        };
>>>          chosen {
>>> @@ -36,6 +37,19 @@ &dcc {
>>>        status = "okay";
>>>    };
>>>    +&qspi {
>>> +    status = "okay";
>>> +    flash@0 {
>>> +        compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +        reg = <0x0>;
>>> +        spi-tx-bus-width = <1>;
>>> +        spi-rx-bus-width = <4>;
>>> +        spi-max-frequency = <108000000>; /* Based on DC1 spec */
>>> +    };
>>> +};
>>> +
>>>    &sata {
>>>        status = "okay";
>>>        /* SATA OOB timing settings */
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>> b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>> index 3d0aaa02f184..04efa1683eaa 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>> @@ -2,7 +2,7 @@
>>>    /*
>>>     * dts file for Xilinx ZynqMP ZC1254
>>>     *
>>> - * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>> + * (C) Copyright 2015 - 2021, Xilinx, Inc.
>>>     *
>>>     * Michal Simek <michal.simek@xilinx.com>
>>>     * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
>>> @@ -20,6 +20,7 @@ / {
>>>        aliases {
>>>            serial0 = &uart0;
>>>            serial1 = &dcc;
>>> +        spi0 = &qspi;
>>>        };
>>>          chosen {
>>> @@ -37,6 +38,19 @@ &dcc {
>>>        status = "okay";
>>>    };
>>>    +&qspi {
>>> +    status = "okay";
>>> +    flash@0 {
>>> +        compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +        reg = <0x0>;
>>> +        spi-tx-bus-width = <1>;
>>> +        spi-rx-bus-width = <4>; /* FIXME also DUAL configuration
>>> possible */
>>> +        spi-max-frequency = <108000000>; /* Based on DC1 spec */
>>> +    };
>>> +};
>>> +
>>>    &uart0 {
>>>        status = "okay";
>>>    };
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>> b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>> index cd406947ec34..9f176307b62a 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>> @@ -26,6 +26,7 @@ aliases {
>>>            mmc1 = &sdhci1;
>>>            rtc0 = &rtc;
>>>            serial0 = &uart0;
>>> +        spi0 = &qspi;
>>>        };
>>>          chosen {
>>> @@ -339,6 +340,19 @@ conf {
>>>        };
>>>    };
>>>    +&qspi {
>>> +    status = "okay";
>>> +    flash@0 {
>>> +        compatible = "m25p80", "jedec,spi-nor"; /* Micron
>>> MT25QU512ABB8ESF */
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +        reg = <0x0>;
>>> +        spi-tx-bus-width = <1>;
>>> +        spi-rx-bus-width = <4>;
>>> +        spi-max-frequency = <108000000>; /* Based on DC1 spec */
>>> +    };
>>> +};
>>> +
>>>    &rtc {
>>>        status = "okay";
>>>    };
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>> b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>> index 8046f0df0f35..05a2b79738af 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>> @@ -26,6 +26,7 @@ aliases {
>>>            rtc0 = &rtc;
>>>            serial0 = &uart0;
>>>            serial1 = &uart1;
>>> +        spi0 = &qspi;
>>>        };
>>>          chosen {
>>> @@ -161,6 +162,19 @@ &i2c1 {
>>>        status = "okay";
>>>    };
>>>    +&qspi {
>>> +    status = "okay";
>>> +    flash@0 {
>>> +        compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +        reg = <0x0>;
>>> +        spi-tx-bus-width = <1>;
>>> +        spi-rx-bus-width = <4>; /* also DUAL configuration possible */
>>> +        spi-max-frequency = <108000000>; /* Based on DC1 spec */
>>> +    };
>>> +};
>>> +
>>>    &rtc {
>>>        status = "okay";
>>>    };
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>> b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>> index 3cbc51b4587d..becfc23a5610 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>> @@ -30,6 +30,7 @@ aliases {
>>>            serial0 = &uart0;
>>>            serial1 = &uart1;
>>>            serial2 = &dcc;
>>> +        spi0 = &qspi;
>>>        };
>>>          chosen {
>>> @@ -934,6 +935,20 @@ &psgtr {
>>>        clock-names = "ref0", "ref1", "ref2", "ref3";
>>>    };
>>>    +&qspi {
>>> +    status = "okay";
>>> +    is-dual = <1>;
>>> +    flash@0 {
>>> +        compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
>> Maybe here should be "64MB" not "32MB".
>> There are 2 mt25qu512a flashes at zcu102 board, and each of them is
>> 64MB. Since "is-dual" mode is not enabled, so we can only observe 64MB
>> size from boot log:
>>
>> spi-nor spi0.0: found mt25qu512a, expected m25p80
>> spi-nor spi0.0: mt25qu512a (65536 Kbytes)
>>
>> And I only verify the flash size in zcu102 board and not sure if the
>> flash size comments are correct for other boards in this patch.
> 
> I have double checked revA and it really has 16MB+16MB configuration
> where only one is visible.
Sorry for the noise. I made a mistake checking it at the board zcu102 
Rev1.1 not RevA.

Best Regards,
Quanyang
> I will use only half of that listed size which is corresponding with
> single configuration and also remove is-dual from 102/106/111.
> 
> This change will be in v3 version because forget to include it in v2.
> 
> Thanks,
> Michal
> 
