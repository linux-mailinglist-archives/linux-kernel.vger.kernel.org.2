Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA6D330AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhCHKNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:13:15 -0500
Received: from mail-eopbgr770040.outbound.protection.outlook.com ([40.107.77.40]:41025
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231221AbhCHKNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:13:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlGf6D3MXrK8/MH9CcpfeqSlV9eTwpJLkaKrgFcqkUkknF4i01lwZVXtd1xGzDEu+8sLhp3U1PgjdapPst1+X9v6vF+xuvNeKROTJfPJWYmS+jWnPtORl4h69n1FR8sN/gfUJgIF4ly+UxMC9EEfzjdZKNudoQhAeEnw5JpzIbYZdEzvJd+nD5FdGapg2Cxb17sFxEjgTwCV5/MfeSbt8r2v2zQvwiG7Nyhofe0owm117GaK/BP5/WXpeHd5CtriUouYpt34bsifo3FNOIJHT3xmlAHVS4BhH7UPeX3bLatMeeOtEL5p87prEQpJj+1cRNJ7KDu4HLnH91nxesmbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AaIccdOnRKm0IX0yPPiwJtcqNKX+Fz93Y52MsoITeQ=;
 b=dBeJnpq8aVlVuNzq9Bqa7Bu0C2fnThmqIUU5C4X2C43+Fipe0u5BDTmSMmqsJMfh9xUJaU/VS1VBeGZulqjswtUp2heWWMwp9cnC80nmqRkOVDhk/wAdf9FwdgkN6OREVTYfDbm70sXcZqQKwYWyPNTpQiWDCGXIcRVgQfLMMEYDH4UwgB4jw8r9Xk9MMc6LfSHsnE4nwyoR/T3MYUqfb5Qxc8bjkHFnDT37CRSgmNj2pLfTOyEQbgGCDdIHRcNO9KmotgqvRo7J1TL8iiVbju8LMvk/+NfOZ27zrQ7pU9Od4KddPoYfQG59RU5gGetOkAZ/e3PGngG+TwIDHcoO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AaIccdOnRKm0IX0yPPiwJtcqNKX+Fz93Y52MsoITeQ=;
 b=JVw5TlXR2ok0oLxyZ2cq0GL4f3wXT8DmXNdJ4zZLLpOxS7zAlI80cFdoha9dedGIk1wmRavCXJpiLonPgyjrGneQXTuGU3VK+O813GJAqP64T1E7ukkC8v4ZM0nSHCaoOtZ6gTOX1DN+B5Y1NJpwN1K9U6vaxTdIWGvHnAV2gdk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB0072.namprd11.prod.outlook.com (2603:10b6:910:76::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Mon, 8 Mar
 2021 10:13:09 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3890.037; Mon, 8 Mar 2021
 10:13:09 +0000
Subject: Re: [PATCH] arm64: dts: zynqmp: Add compatible strings for si5328
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210308070843.2096992-1-quanyang.wang@windriver.com>
 <YEXhuGeMoXbfWI6I@pendragon.ideasonboard.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <614a2d54-f4f4-7859-81c1-3ce2073dd30c@windriver.com>
Date:   Mon, 8 Mar 2021 18:12:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEXhuGeMoXbfWI6I@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by SJ0PR05CA0162.namprd05.prod.outlook.com (2603:10b6:a03:339::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.23 via Frontend Transport; Mon, 8 Mar 2021 10:13:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fc7d49b-b936-4755-d619-08d8e21ac5bf
X-MS-TrafficTypeDiagnostic: CY4PR11MB0072:
X-Microsoft-Antispam-PRVS: <CY4PR11MB0072744549480687F8117797F0939@CY4PR11MB0072.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQMxSrgQxn3of7yU/8twdfP3fB3Ds0i4rzbyO9vGkc2Cfxb18fpmrhnqLQZUrIEN/QSApNBoOqCwXsOmkRqyQtMPdwv5m3SNdKHPhImMDAQSQydPj0qIv4BxZ8K23+Q5Ii9rVldomaExKPNc7WI8TVo6j32QhnPu5EWdo091JNWae0Wpl0BZAXUwSKpvVW4gaJaTTEcTefpMpdMY4/r0aBSe+HoeRwbW5L31f+UELSVsiehCqsUUpWyp/wzf/Yo0xhY6QC+esOx2ZLZL/HZdFXKbrvIzqM041uT+x1ry+E2EoYZvDpbPMjkzJxbt5omCmbDwHjAQQEiOK4hnWa1aatDiyUcgJsBOVuHHqo0cXW+fgG4/MVNAoREcTHZ8L3eavYzHJ+EGbXwHzf6jErn0I31j2lBY6/qJl5j9yp1k8xvcKa6r/UY6CTGKmnzTReJNtEpo8RLKIzKQLjBmI3KNtH19TGVWvS3OCNyAlb+4Vj/Mdhj76cHwCc8aiL6gDj7V/HXJrhBXSpWzmVqpUshCAfLwCDHu/QdaaFPU9b51LepOdBvODHPOr1wv5Sx5IF5hfHNV1paEdtdtUVP9gFVQmJVLDAGy7EDioBUuo9BZoxpIOuPhl/edQEDgmE8OodRp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(136003)(366004)(396003)(376002)(346002)(66946007)(53546011)(54906003)(83380400001)(66556008)(66476007)(36756003)(16576012)(6666004)(5660300002)(52116002)(6706004)(6916009)(16526019)(316002)(956004)(26005)(478600001)(6486002)(186003)(8936002)(8676002)(86362001)(31686004)(2906002)(31696002)(2616005)(4326008)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aXozb3p6T0Z2dTYvTFZnVTFmN0txZTNJMkNCR1VjcDlSVUlXU3hiS2hWQVlY?=
 =?utf-8?B?RzVML3UzZGt1RzFPQ1Z4SDBra3hIQkZ2dit5K0d3L1RKeTl0S2lpak8zWUhw?=
 =?utf-8?B?cExRNnBFdHorTEhGd3IvTXU3YUJHUDk4ZWxEakovQm1DUDV2NnVDemJjdWxO?=
 =?utf-8?B?RUpjdGtmdzlnR2R1V3NEZDg3MlNhTnFwM2FaOElHZFNlR0oxRHd5MFYxQ0lT?=
 =?utf-8?B?dGUzcHlQQlczQW8zL1d5bTdLWWxDQXpNbndxbzlxdHdxc2RscVdaMUxlcjdN?=
 =?utf-8?B?SGEwU0hDWHdia3d0V09nRUNUbzhCMFdwdjluT1VPRCtkMHkvREVrNllaMDJq?=
 =?utf-8?B?akptSDBVODd5d2NsalFWbTYwcHhHR2RnSzdaWC9TQmthR0xBQVdJcFlwdGl6?=
 =?utf-8?B?OTNhTFoyQVU5U1JrK0docVZJRklMVEd0cUF5SUxoRHFReVVKbWQ5U2dFWUVQ?=
 =?utf-8?B?SklpM2dpYjJmYWlaSXA3ZytFVnU2V0xFYU1RTm44STFlM1ZxYmZCNTYwOE52?=
 =?utf-8?B?U2RuZXhuZFQzT2kyVVZ4RklKRnJqc0RIUmFFbk1ZKzVGQTZLSXNSNFk4T3dY?=
 =?utf-8?B?eXR6S09uNGszWUtkcVJWZjU5a01YTVREc3BYT0xKbTMwb0IycmtvQVFtTlQ3?=
 =?utf-8?B?bWMwZWVQaVczcVA1ZXVmWGtQdCttQmF5ZmtmcWJhRVYzQjFUMmV5bnpndjF0?=
 =?utf-8?B?V1hQWGZrVkZqT3IyMmV4MktMb1ZoNEZwZDRyckV0dXJyaEdiblFkSGgzN1J1?=
 =?utf-8?B?U0Jia2trYjhWcFVCSlZFN1Q5c1BNb3lwcVRXejFUcCtoUnVPK09ZT3BBSWVH?=
 =?utf-8?B?clBFQjZucFB3TnB4SUgrNWsrbUpYVnovVkpwMS9zbXdoRTBaUzMwTUVNdnpG?=
 =?utf-8?B?Y1hYVlliejNSR2s1WGJGOWdjd3NiZHc5OVVTdWxmR2JOK2I2OUNWRWlQYVdD?=
 =?utf-8?B?aElIbkFkYmw2TjdZem85K0dlRUdUSE1pTFpoaGFtN1dGRGVvdjJBdVVZd2ZJ?=
 =?utf-8?B?SUdoK1VIUHZZMXdaTFlPc0ZueTdROFZYZ3UzNk1kWFhjakN2S2g5ekgzTkZr?=
 =?utf-8?B?VExaUGoxTlBvZC9hS0VReURwOTE2THl5blhkMENZYWxoTmFmV0hzbGN6VTU3?=
 =?utf-8?B?NzJtN3UzM3A3NkdWZ3FNWHQ1SFFQbFphbU9JaE9ZKzRMUVdTbzE1ckswS1c2?=
 =?utf-8?B?cUZEK2prWlUzMTFzcGJnZ2tYcEdqNXRlNncyQXliS1R1NFhMZWlqSjlGNGUv?=
 =?utf-8?B?R3d6NVIzdUtlZVlKOGkwWWI2c1hBWE9QcFlXWE54cEVGajJQUUFFTzZETm9h?=
 =?utf-8?B?cURpWEp1d3VtcHpoNFRXRStlNU5tUTFsTyszT3E4c1VsbWt6UUpGQUROb0xW?=
 =?utf-8?B?eEkyTkZ4ODRJaFBSWm1TdFRpc1dqVHBub2lLNnpqVVFrRnFmQzFoUkJGcDNH?=
 =?utf-8?B?M0ROY2VMd0hhUXgwUGFhcVRKcVNreGFZaEU3UmhCcFdoaHFHbXVzRHBvc1Bk?=
 =?utf-8?B?RmtuNTFHcWhvb1dPU0dPZ3I4TXFLV0IvV0YraWJUMGVwVEhJUkZMUEpsUjZB?=
 =?utf-8?B?eVFZM2ViZ2pLOXYzZnJRWE8vV2x6NEJjdUxoRU9WSSsyTVAzZTR1WGs3Uzc5?=
 =?utf-8?B?dmtHczZCdzFsNC9BUzZQVmhHL0ZzU1psT0tHVEl2eUtMSUdxdml4ZlZwWGN4?=
 =?utf-8?B?MlhyWHdXYXpFSnRNYk9uQ1RSemhpS0pKUk5HejBJVUkvRnVHaHZTWWQ3SEdW?=
 =?utf-8?Q?kjhJwO+ODUN+zt2PBHuMJ+HexwjaU3r1YEUVb+w?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc7d49b-b936-4755-d619-08d8e21ac5bf
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 10:13:08.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMMKpefjZg0IdOAaSbY/1/cz3P2VrzE0Cj7ucB53QcTo9u37+HzWOhF1aMae9cpvFKbbp7W0mAfg9lWC0pptD159U42FbvhQSmDNJMfDnXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 3/8/21 4:35 PM, Laurent Pinchart wrote:
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
> As far as I can tell, "silabs,si5328" isn't documented in
> Documentation/devicetree/bindings/. We need DT bindings before making
> use of the compatible string.

Thank you for your review.

I will send a new patch to delete these device nodes.

Best Regards

Quanyang

>
>> i2c i2c-10: of_i2c: modalias failure on /axi/i2c@ff030000/i2c-mux@74/i2c@4/clock-generator@69
>> i2c i2c-10: Failed to create I2C device for /axi/i2c@ff030000/i2c-mux@74/i2c@4/clock-generator@69
>>
>> Fixes: 82a7ebf00224 ("arm64: dts: zynqmp: Add DT description for si5328 for zcu102/zcu106")
>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>> ---
>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 1 +
>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> index 12e8bd48dc8c..a73841ad24ce 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> @@ -590,6 +590,7 @@ si5328: clock-generator@69 {/* SI5328 - u20 */
>>   				#address-cells = <1>;
>>   				#size-cells = <0>;
>>   				#clock-cells = <1>;
>> +				compatible = "silabs,si5328";
>>   				clocks = <&refhdmi>;
>>   				clock-names = "xtal";
>>   				clock-output-names = "si5328";
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>> index 18771e868399..24ce64364d63 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>> @@ -591,6 +591,7 @@ si5328: clock-generator@69 {/* SI5328 - u20 */
>>   				#address-cells = <1>;
>>   				#size-cells = <0>;
>>   				#clock-cells = <1>;
>> +				compatible = "silabs,si5328";
>>   				clocks = <&refhdmi>;
>>   				clock-names = "xtal";
>>   				clock-output-names = "si5328";
