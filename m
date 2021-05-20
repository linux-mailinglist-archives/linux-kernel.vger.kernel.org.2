Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3713E389E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhETHGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:06:24 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:63068 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229547AbhETHGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:06:23 -0400
X-Greylist: delayed 816 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 May 2021 03:06:23 EDT
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14K6mxqO008198;
        Thu, 20 May 2021 06:50:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-0064b401.pphosted.com with ESMTP id 38muc70wav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 06:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0Hs0ImE+PzQYfR4nOYlW6VOcQmNRQncmWawo94wA+JwIeov62bbfvqGpxscjxCrKsolJ7NvMYKy/pcNphfZmRy0F6ux1Jj1XJ3aAHv8kDOKzhhDba3TI6zuhDtYSBSQC7j4JFuGA75wAhwqZa3XXJsE7E4TekJKbASk9awBuZcUIPAOHIQYQdMrD7HeRSRqprNolABDmieW+9JwxCte6aLhQAIl4shtrWwPLaAsjrTaqprDhQUS9f4ZsRB66aMt8KbTL/eWLLCLxjdaay3X6kCEKgdaWmljJULaQ3wSiH9zkY4ExPYrpl3KDB5y3TF2rUnM4CLIEc8oBe4WYJw2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuQDmmu5kc+yfSKViWlTKqSOQi/ExgE2IN0aXULppB8=;
 b=lAVEFcy5pVQfYFr5PtrQWyUBxM5sbwGM/aCYM6TIaMS4t8rPjsFl9LeqU0amjHuINjVdr/uZX+VowL0YltR4BCZuUSnmavFh9LPeI7EsZ00+zeodpsYEIkRSsm0mz4mLhKBPcXrPwNtCgHST3pA9Gb02wpQS7Grch8nV2pec7K2oA0+3t/+JfbFN7Gb4wJf/HFHJss3RJH2p6uUeP6R9+b8M117qtjmx6HbjbQrsicXHDAjjUHmhHxCjhwO1BmQ49Twz9JwZ6aQcPWGIWKjcIffArhnlYyL3b1fHiMs8evr5LbF+vfgtGOUtkgNDzUaILs0sv+AvkZwdnE69PBU06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuQDmmu5kc+yfSKViWlTKqSOQi/ExgE2IN0aXULppB8=;
 b=edq3ACnFrHxF/FjUBAGZIGGlbNdcC1OVXvjUjrG8mJQy69OirL64kU8MtQJ6l1Sl53c6prfYMhDos9VSgSFBhsv1zgQKUj+3JLLdaVjFDdPnCjl3JUWJP8GmQ+DJQ9tfxMBf6lUE1h3k4Yh/trNbchRDPJAUqEGGRcrMUHDsrk4=
Authentication-Results: thorsis.com; dkim=none (message not signed)
 header.d=none;thorsis.com; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.31; Thu, 20 May
 2021 06:50:47 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4129.034; Thu, 20 May 2021
 06:50:47 +0000
Subject: Re: [PATCH] arm: make the size of vmalloc in cmdline and meminfo
 uniform
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>, rppt@kernel.org,
        ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ada@thorsis.com
References: <20210518111254.3820480-1-yanfei.xu@windriver.com>
 <20210518112932.GV12395@shell.armlinux.org.uk>
 <20210518120633.GW12395@shell.armlinux.org.uk>
 <63618f13-07cf-6867-bcb1-7a725e6f3ef4@windriver.com>
 <b115f727-570d-d3c1-2a5b-01ed89c450dd@windriver.com>
 <YKXrIotnzsHKP+qp@ada-deb-carambola.ifak-system.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <4659d117-d23a-8c9d-969c-5ad2fa7cb5aa@windriver.com>
Date:   Thu, 20 May 2021 14:50:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YKXrIotnzsHKP+qp@ada-deb-carambola.ifak-system.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR02CA0186.apcprd02.prod.outlook.com (2603:1096:201:21::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 06:50:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8a7cbaf-273e-4ab9-515e-08d91b5b98a3
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5053:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5053A35999D3EBFBE960621FE42A9@SJ0PR11MB5053.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUPrK5y3DNCJ1SVqgPlO6SIzr7/NyigXX+JNAyOLH5CLo50V8Mx5KXUooy382ASxQlUyfLtLy7x95sXoWX3rRsTVWeSY3Rl9LprvyisDBoJ5SL6LMi4MeOLQSs13m9OWDldXzQXuPG2746ey+c2wsL9wfnXdCnI5h0TvweNmGQx4aiW0lIDxjV8Y1if9FeYW856AK19V2gdYFITs4kBh3qSVbfst6BAKcqee2q9oD5E7lgYP93iYeMwTGmGbGEmB5aXHiEy4vDLLF+m7EYasSna9Gf19B5PPIU2bwSQU3SL1+SBO/LL/tR6b4n4gje9aXpokuyglVhIJvTg/6Os3HSh503jK8f0xTno2kd+S8xfhrgSxUSUap0x+U70X6huYFlVUP/HC/HXvfjxB/MFf6FUyC8hhEI9tleYElw4i6K6R9iTTxQxU70dpJ1TxOc6YXovlnU7ju2l6nmJQBVb6LnL26CevkifM5VzUh08zNSoaJDgGsM7jpZqbk4ICZUl9HcJRzOLgrTTLSmhl2tAmrt64Qy8rMkAJ0zGUR1D3ZrGCIPLrmn0Y+nKvOMOHUL5IviStPakzcxkshlYlrt46SKENHo8uLPqkkmyXPzzRkK2VSrjLIwr0AXstSS1smqa6TcHEGoM1P0EC4VaSOFj9bA+Ct2THxQLf2F3G82KV5kHtkLqabIMb7nlVrxJrf1GIheev2TtHp9uRE5NcBU8Q1RUWksU6DR8Zez2QtGu1XevLfn2bzwyS170gWsUx26xnuMGB8jUxf1o4GjbamaabRTuRmVPUNeGnu40Uy0fYj9OCtpaIkXk6ZZaEa02RIIxeWJn6mJDrHc+UUhqCYVmizw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39840400004)(396003)(31686004)(6706004)(66946007)(36756003)(66556008)(186003)(31696002)(478600001)(7416002)(16576012)(6666004)(52116002)(86362001)(53546011)(966005)(5660300002)(316002)(16526019)(66476007)(956004)(6486002)(26005)(38100700002)(38350700002)(8676002)(921005)(2906002)(8936002)(2616005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TWVLZmZIK3g2NStBcjQ1U0Rlb2JJTlNOdlRkb3BFYU5oQUpwckxzcnFkVjl1?=
 =?utf-8?B?T1JhSU5YZ1E5RTdvNW1ReDFvSWdISHpBa1dEenV5M21rRHdheFJTUmZUdi9Q?=
 =?utf-8?B?VHRsVkdVeTVVQkNWeGtKQTdpQUxFdGZ3eGxST2h3OURJQXAxMGtVL0owUm8x?=
 =?utf-8?B?NlBTSEJoQ1psaTRLNExFOGRhSVJzT2Q0RVVmdllZL1BwL0JWTksvMUNCSzFS?=
 =?utf-8?B?T1hnRThURnJ6WUgvS0xieHVXaUhueEp1UWt1S3ovakFOayt1ZERZaFdvS0NN?=
 =?utf-8?B?TXVJSW15ekdONXRKc2ErMCtpNlFJZ2xzWFFDdTdaWHdxU2xMVzJJUmZkaXVz?=
 =?utf-8?B?UkVzMldqR2FzRi9mVVo0d2JSbkVJaHBuZ3d2QWh5ZmZRcHRsR2xxWUFWSGVy?=
 =?utf-8?B?bzIxKy92UUdBVStOTGJ5TlZROGliOUd2NHRZTkIwcStZTzN0YnFOOUtPOFNG?=
 =?utf-8?B?V2RFR2MrZGVpNXNVZjdvVGJmRlpwaGNzcE5BNk5mdnZEYmx0d1d3d2xnSEV2?=
 =?utf-8?B?bVFDVVk3Q1RxZzhtTHVjYzNMWTl3U1Z1WjBqVlAvZWR1OSsyNEZhWHZoQlNW?=
 =?utf-8?B?OXY3VVk0dG9PNS9TOEhEcWU3Q3Y2V2YwWkQwSlpzMlNpU3hNS1ZYT2d0Y1Bn?=
 =?utf-8?B?Y0dFYkE5eUtkclppYmFvT0NHZ0tZWVg1dGJjQ3o4VkFydGM2dUNqQ0l6UStq?=
 =?utf-8?B?aGthS1RjMkQzWFoyc0QwL24vSzhiTDBlYVdnM2N4dExMT0pkWkh2cVVEQVdS?=
 =?utf-8?B?VWRZbVBSYXFUUzBseUNqTXhDbzVDWWFjYVhUaEdhRGxwMWJvbStMaExEQXo5?=
 =?utf-8?B?SFpWODM2c0s3d2R5R0c1YlRPb3lFenl0RFNGVGFJWmV1MzExbDlhQm10Nkt5?=
 =?utf-8?B?b2Y2RnF2UVRoaFkxVDAvb3hnZ3NXT3dNSmx3SUl5VWxqcGhKU0VuM2ZqT3h6?=
 =?utf-8?B?WWtmOGprd0dCcFBEMWVUNXloWWZrT2pMVUVYaWNZd3kvSWFkUlcyY2ticExS?=
 =?utf-8?B?M3ZmcVZLSXBxaEprdFIyK0FFcmVDbFUwRTMzb3U4dldvdDF3ZTFvK3UyTmh3?=
 =?utf-8?B?R3J2M0k1U2ZjVDdsNlc4UnZvRVJ2UGRMdmpVTXBoMGttbVpPblpHTk5CeVpj?=
 =?utf-8?B?dHNUWjg5cUxDQ2M5U2lXZGJKMW0yYkd2S3NMUTlCUFBoQW5zMm1RU2hyK3pt?=
 =?utf-8?B?UkRYR09oQUNQUlNJeEJpVGYvOTlDVXd0Q3BsYnV2M09NZzJHZWdoeXl2b0Jl?=
 =?utf-8?B?dGJIODBrUmlTVUt2Vm9Fb1Y5MHFUWk9lUFpWczh5dmh2cGZFdDE1cGtXR1ls?=
 =?utf-8?B?UldhMzFLNnRsNEk2aEcwTktSa2ZNMnpzN2JqTkQyY1IzbDU2TUhodDg2bjVF?=
 =?utf-8?B?VlY4TWVsNHdGSklPNERaRHVDaHlBM2ZjYWxTNzJ2SlQwREs4TzFQSllUcitw?=
 =?utf-8?B?ODlHZXRsdTNrOHFPd3kveCt3RlBLMlRZMCtiSytPTVRLZjJ4QkpEeWlIVC9N?=
 =?utf-8?B?VFkwbFMyOHVNNVpXU2RJcW9MdzZubStFODBiWHU2L0JOMjJxT0VPbE5qalR0?=
 =?utf-8?B?T3F2aS9hV3A4VjYrMlBYVTJSemNTWmhkL0VKcWhLTGJvRmh2c1AwME5yZCt2?=
 =?utf-8?B?QStlSDFwQzdkNFlkSFlzYjVMTHlOZ2hxV0J4RHh5bkRTVkhGbzMxZXZEVWJz?=
 =?utf-8?B?eWJQM3diSUlxcmxRbUVOd0x0bVR5Nnc1eWJ3YzZmUGg1N1pTUEUwNzVXYklr?=
 =?utf-8?Q?yvFuJ+EcuLEY9yW0XoLThbKweMjz564L3sVSSee?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a7cbaf-273e-4ab9-515e-08d91b5b98a3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 06:50:47.0727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awnfKpkbm2+LQpnDCprbe771u0f3l7aRbrS5Pg5Bysf6CoESi/83pIlVwy9j/DEQU88dHwHOwBHrnCcTDEXBqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-Proofpoint-ORIG-GUID: prN1iJfmFuwo1P08jwtdYiKUDNjZm6dw
X-Proofpoint-GUID: prN1iJfmFuwo1P08jwtdYiKUDNjZm6dw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_10:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 mlxlogscore=778 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/21 12:52 PM, Alexander Dahl wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> Hello Yanfei,
> 
> Am Wed, May 19, 2021 at 01:32:23PM +0800 schrieb Xu, Yanfei:
>> I am not much familar with community contribution. In this case, what
>> kind of tags should I reply? signed-off-by? Reviewed-by? or any other
>> tags?
> 
> This is explained in kernel documentation, starts here with Acked-by:, Cc:,
> and Co-developed-by:
> 
> https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/process/submitting-patches.html*when-to-use-acked-by-cc-and-co-developed-by__;Iw!!AjveYdw8EvQ!OL3Mreb08WjGwy5YGRsfsemJBhWkEEIzNVgIGQsyzKYoiF_U2c8ajmauulVY8-lF9N4$
> 
> And is followed by Reported-by:, Tested-by:, Reviewed-by:, Suggested-by:,
> and Fixes:
> 
> https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/process/submitting-patches.html*using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes__;Iw!!AjveYdw8EvQ!OL3Mreb08WjGwy5YGRsfsemJBhWkEEIzNVgIGQsyzKYoiF_U2c8ajmauulVYmm6AM_E$
> 

These links really help! Thanks for your kind explain. :)

Regards,
Yanfei


> Hope that helps.
> Alex
> 
