Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6379A40C4F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhIOMKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:10:32 -0400
Received: from mail-eopbgr70132.outbound.protection.outlook.com ([40.107.7.132]:32674
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232882AbhIOMKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlO32feDsRc+h3WA8zX/iSSbL5OO8IpJb79wJHiUaK9MPHrYyZ4R0C9RMjHP72Jb/vWu76QxCmba7De5EsF41hyzQbVGNf5upY3+e+r06X+6bcfLaclInIjEjxqrq50v6FuZU04hbIKlr35zfPIixWX/4+nsCG64en0pIkTSmmnZUsgGoo+xuo5RM2+Wn0IFHd/vb4NNzEu04tpxzLd8HWK9cmYuUhJ5DWJlCEzlwXMLTtNrK3wiiHVbSaIpg/FyOAO+MOv374NxsM91Z25rNSCbprX57Hy4Pdp/V9UkN6Kv1SXjsvQ37Lar8tIHRrJDycnlqQfuG/KWnelIyWRF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AYgRB8vjhJycmpVMVToxtm86ycCvco20BkJhKqPxM8k=;
 b=WAgFXOaFdRutLyITrjY/LKN0G99ojOUxVix9nDOMZqJMnzOTMX0ccGVxF/RRIiqeXwRX02pNgMIJB5b0vCc8sY49U1mhYdfUXvC1gL7DSwIYaTJFEyaShWLN1r8+igwK6g2N3mYL4TVXPebJCFA7SHBa3QxMO5dsRmMcEkzoYB4ESlfRgR/VZJMMYvF413/+fpSstGN8u3gAmkIVgOrco1YTI7Bz/BgerGY6DrjH38kMCNxMqF929Ac8Kdue+UJcA6cy3g4ArqhYCTiESbxUhymW7Umg5eXRRCLfUVwzs+nHdsPzKjjmTwL+aJlkuxnX/tMn8dfttoFcHDYyWo6Nig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYgRB8vjhJycmpVMVToxtm86ycCvco20BkJhKqPxM8k=;
 b=k+pXAdLpdyn4utrDLfQRm0olKj7P0qs6m+VsHSdK7suGNWqWbxJkosItNdP9nkOKglSwJLXdr++Z3ITyMQcdVwyWJ9ypkaRUkvDvQyROywlsU93Tz2OiaUIbmIElrp7pdfivPsLsYo8TdLKjOE7HyfgOhl0m+HPxMFy0eDoJEaM=
Authentication-Results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=kontron.de;
Received: from AM6PR10MB2968.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:d6::31)
 by AS8PR10MB4882.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Wed, 15 Sep
 2021 12:09:08 +0000
Received: from AM6PR10MB2968.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d124:4253:83f9:d8e1]) by AM6PR10MB2968.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d124:4253:83f9:d8e1%5]) with mapi id 15.20.4478.019; Wed, 15 Sep 2021
 12:09:08 +0000
Message-ID: <898fd5e0-2073-3689-89b6-2c5071773786@kontron.de>
Date:   Wed, 15 Sep 2021 14:09:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] arm64: dts: imx8mm-kontron-n801x-som: do not allow to
 switch off buck2
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20210915120325.20248-1-heiko.thiery@gmail.com>
 <7e7ee4244ababc0a46e0875222c7e37d@walle.cc>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <7e7ee4244ababc0a46e0875222c7e37d@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0003.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::16) To AM6PR10MB2968.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:d6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.31.128] (80.147.118.32) by AM0PR02CA0003.eurprd02.prod.outlook.com (2603:10a6:208:3e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 15 Sep 2021 12:09:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cb2188e-0a6e-415c-82f2-08d978419ee3
X-MS-TrafficTypeDiagnostic: AS8PR10MB4882:
X-Microsoft-Antispam-PRVS: <AS8PR10MB4882A5EE786534D036503A14E9DB9@AS8PR10MB4882.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljEKSce3Ek9VuPTYUpP3PPwoxt0KB2i2b/Ur9+yuOsL3WXiHKkKJ1EdrRJQTvj0lwCpdlCCZQUqS/RvYVL7OfBitEd8Miv2EUTCCy+2s523FjKJdkysTg+sKCSV/mO7EO6FAsw+5N8FxbFyaMP2fqaxvpgdp9eKumtGE3q/XMKXHGktBp3/Ih81F5TpyD+l+dJYix2g3+5R6S7QAiG/etQT0c0GygzIIlTVhK6GucGLVRtAcIZnXs3WZzkH71eiECUVi9DjtLU43BxuPHQi/gMXtOUH/7OjN68HkfnOSLnfmG5nqSNhU1ZNAylmmJOo9O1q09Qv88++YQC8NnnqVD79JM7PEli0fypJQBDsvlL2CMMZXvY6GobW9Qyh5SzmNAB2lewj0IgofriW4NAtMnJs+Tf/mBvwq1MtqDOjRRg2iffJRErdIf7JB2AlnJvTOY3lkK8gEcbM9eIzcBvm9in6Sg+WezrdZdjbRueWIiwj02rEXWfDvdpWs2QhVHlUzlPj3/xNQhscMXPRCkKHnHPnVaw9/AwRbPLK/eGTi58uqklgzqNtxJlb6q0vE69E/hEBeIgf9ucrAu3sYIM5ycF0biNDFbgbenfqFE2okLGk/NFmRbJD+Bh80pVKkqCL8kSShX+ayVctvR5IOCmLQa/yuk5ON0tw4po3ls9KiJfHXA59oZTy7ATgA8c7YDwSHj4JynouqGZlwXwBbLExH5K3eRKKeQeBOp5u85OXSrQzm1bo9q2Zp6UTpHh/TeX65EDlRUU+quZnICoPR16bjZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2968.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(31686004)(186003)(6486002)(16576012)(2616005)(956004)(8936002)(110136005)(478600001)(26005)(86362001)(36756003)(316002)(66476007)(7416002)(66946007)(66556008)(2906002)(44832011)(8676002)(38100700002)(4326008)(54906003)(31696002)(5660300002)(4744005)(53546011)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkNOZW1qNDd6dVk4aFNudHJvWjdFcTNTOGQ3RlZsaS9YNlNMZTNXdVRlc0Fl?=
 =?utf-8?B?N1Rad28xOU9uK05ETHB3bndlSU9pMjE1d3N1RXhwOVdzTlRYTitPZ2lmU2Nj?=
 =?utf-8?B?OFc4NHg4MnRpVmpmMThtVkxWVEQwcUp2UDUyeVV0WVJnbTJPMXFOeEUrQ09G?=
 =?utf-8?B?akk2MUZ4VW55UmpQaXdPL2d1cWU0Y3ZOOUZzaTRQNjdrVTdqMEdWRGlkL0Fj?=
 =?utf-8?B?NFFNdm04QXBIbkpPL2tpUWg5aEhnWjlEd2hyMVVEK2szc25PUGpJaW5wdTk2?=
 =?utf-8?B?M1FDeUU2dUlVRjZrYUZySWhadmN4cENKNEJMWk1NSmhjdTkxQmlDdlhIYU16?=
 =?utf-8?B?QkVsVmRWRFBsTURrai9kaTBpMk5wSHNZeXhlb3BvRkpzVUE3dEs2SkVzRmgx?=
 =?utf-8?B?QWxzRUJYYzN3UTE5WmtzdkVKeTFVQldNVlcrSnFPN09MZThoZG1lYjN5aWtG?=
 =?utf-8?B?Q2RMTlBtMkVZWjdaNllYRmtrSlp2RjBGTUxYU080SC9nSVRFa0g0enV4MC9p?=
 =?utf-8?B?ZkhCRVRiTi9KQkdmeUxlQmJiemxXYTJMSmQ5ZHY1YmZMVkNMSFBRZGpydy9R?=
 =?utf-8?B?WHQ4R2NCeGZmR3hqNGtNWm5KQnNnWVhaUEhQNUo5WStjazRBeS9Pc2xFNnNq?=
 =?utf-8?B?TUd5d2tqZGM1NTkrR21udXhpZEVJdG8zMkVZWlByWGJEUWY2NGdPYjNuN3Va?=
 =?utf-8?B?eVoxaHVETnd0REgyc1Y1d2x0OTZob25NakhQSlhvZG13a2I4VjlVSElOd2JT?=
 =?utf-8?B?djBLVG5FQ0FuVm1OTmgxSS9GL2JQbVRvRW5WMWFUdnFpWEVyV3hhWVpDdlRF?=
 =?utf-8?B?S2xGT1pqYlN6cmVLZnBlTXdoczBjbHpoWE5mTUNhRnVMc1ZjTk8xWVJqaVJX?=
 =?utf-8?B?VHMreGNqVTlvVnhwWDlYRExEZi9wMEtPM3lWVm1XRjFieG1DOExDb2VtaHFL?=
 =?utf-8?B?OHRqd0pZS0Y5QzBYRjJEaDlUaDI2WnBOVDE3NnVJLzBmYUVDVERTamJxYmdC?=
 =?utf-8?B?OENkWHBHMU5ER3JydzE0VUppVGpvZmMxMUdhNlJaWE95S3Z2K3hHWmVFU0kw?=
 =?utf-8?B?eWkvelNFbm5FOXliZjJEajRhYnpQcUhCVmtoUzBlejRFU2drVUpzYm1PZFZC?=
 =?utf-8?B?Z1VGRXp0aXY2RElmNW9BTmNKWlJzbVpaVnFTekNsUCtYbE9PaENrOS9mQmQ3?=
 =?utf-8?B?ZTJKWGZYSm5Mcm1hd2lMRUhZM1JtZUIreUxQSFlRb3RlMTZhU3IwMnRGVEsw?=
 =?utf-8?B?emJpa3NKYUhhb2NkYkI0dTRwUXkyMm9FbW9uRUhrK1JtdEJWTWtWZ3J3NEE2?=
 =?utf-8?B?OEFhWXNQODdTRWttYVhTSHFXTG8xeFNkUGl3QmFsVnF1ZHhaWkhSS3lLZW9V?=
 =?utf-8?B?TkJGZ0p2RnFPUWl1NmlyNDRnWWhzbFh6bFFrUEJwamMwdStUVEZyck5NKzR5?=
 =?utf-8?B?M1RjaXd1bWZvcFdwYjBaSGJLd2R3TG1kbU1IK1RTU2l6eHo3dVdGVkpBMW1v?=
 =?utf-8?B?Q3Q5ejFrWFhURHpXOGc0SkpoaXYvNEl4NlhGajJnVGhWQmZSWmN2c2N2Zzln?=
 =?utf-8?B?M1orRnZiUGJzbzUvNmhyMGdmRlBhZnJrcVFqaVZxZVkraXVEeHFXeFZCNUhQ?=
 =?utf-8?B?MHR4UFJvcWRHbUx6b1JIbGRiY25zL045NWZ2VE1NSVY3OHdaNlhiVUpLS21n?=
 =?utf-8?B?cHpJK28zS1ZKdld4N2d1Y2s5TmtGY21DRFd5Z3lJWjlEYVA0V1lCNVNXUWJo?=
 =?utf-8?Q?xiqdKxmtFZ83o0CS133oZMC5rjhq4WN5ua+s1Ky?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb2188e-0a6e-415c-82f2-08d978419ee3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR10MB2968.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 12:09:08.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEarKNI8PsNpgRQ9GcK0X35BbSoPVCvHiyURd9OtPuzceRdqbZVIS/fe/vGnHb70+rIyrpSw8W7aD4GAp5+mEvG/8GZHjzIwKhrLtGC7HVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4882
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.21 14:05, Michael Walle wrote:
> Am 2021-09-15 14:03, schrieb Heiko Thiery:
>> The buck2 output of the PMIC is the VDD core voltage of the cpu.
>> Switching off this will poweroff the CPU. Add the 'regulator-always-on'
>> property to avoid this.
> 
> Mh, have this ever worked? Is there a commit which introduced a regression?

Yes, this did work before, even without 'regulator-always-on'. I
currently don't understand why this is needed. The regulator is
referenced in the CPU nodes as 'cpu-supply'. This should be enough to
not disable it as long as the CPU is up.
