Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B396391052
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhEZGIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:08:24 -0400
Received: from mail-db8eur05on2074.outbound.protection.outlook.com ([40.107.20.74]:19297
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229494AbhEZGIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:08:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekCZwxACEa2mezQyuhVrwxIfmU1fCFpDvV6cKh0h94pqRNuC13zcJf3netON178+eWt4Ewle8BwcGLtWe+DE+jB98Nt1YCKCBqSnIKW6AUNl5TPjhG810vFdy8sN40mn9i8sysB+2h2Vg1nupa2SGFhegxXDQj+aAW4QzEmAMHKNUXjrXj19pWoZ2KWK4vNqRNUVd6kJX08a1/NBHh94jrah08GlV+DF1r9qRP5qTjoHYtrUzYq9BkbtfsqXofYlZekdqnMsFy/1qOyQPd9Ync9NaY9ffqJYiPNEX9MLSqTOK5MslubHUg3TcL27wGnrJOQCsYbc575LlF1GZtgQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZluYmQTBhnB7rQ4uKN5WJpm5p0J7eQjizqN7s3pGjA=;
 b=DVb6D2DbFBugT12RhEkUctvbc0Fw+DBJKFEmNhf6WnPLfSn3tY1bk3MRUNghVHjS0p0a/DzdMxJpIcQemPQJsILnVATCxtGGb3imd934nvUWPvfkiFBSS5oiKfMg0l6HcCguSqJtzIfLS6INO/8C7brt4rZ1V+f8semglUthDWeUACRL26zN5eUkuVZ12Q44n9vE5kG12YxXk0mlxZu1Wa5u9BR2pzX5enodEXvHHF+MydBzHe+v0yX983A2F6mWoA+XogxWL7PjsrI6ee7KsuRIhs3CXkcJE+POvnPYiwYsMkjl2EKvepCPzF1P55hwHohvadS6YX2yGvFCLD339Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZluYmQTBhnB7rQ4uKN5WJpm5p0J7eQjizqN7s3pGjA=;
 b=Xei/Sirzk4qOqRHRihz7T2oADLw69wLD+U9K4LTCkvCEagxYhfcQv5OVPo7dy0SyTJqMOZZ9uiU+xW7JKiJPoIUFJpjK5ai+54Z9AwsQkjQDlM29EIhkLJO6dThj78Gex0h9lQrKPEnqqP/EBvDDKyJ1qUmUsICaEIE7x4ADrE0=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6860.eurprd04.prod.outlook.com (2603:10a6:10:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 06:06:49 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 06:06:49 +0000
Subject: Re: [PATCH 0/4] mailbox: imx: add i.MX8ULP MU support
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20210507101926.25631-1-peng.fan@oss.nxp.com>
Message-ID: <9d4e12dd-6462-5c9a-434a-0104bf943294@oss.nxp.com>
Date:   Wed, 26 May 2021 14:06:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210507101926.25631-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0126.apcprd06.prod.outlook.com
 (2603:1096:1:1d::28) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.193.102.178] (119.31.174.71) by SG2PR06CA0126.apcprd06.prod.outlook.com (2603:1096:1:1d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 06:06:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad8995da-3989-4a25-8250-08d9200c731a
X-MS-TrafficTypeDiagnostic: DB8PR04MB6860:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB686006CB4E60F6FFB44A2B99C9249@DB8PR04MB6860.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/8XnEWJ+ILvD/d1MJ64a3McuJNCtawVg9qKrg9L5f3NpCEY2miYr3Fz53tZngJDcFfIa2B0QOSHIx9mdP766oMthN16HOReLb3mAMAUhmbkBJGvxxeuhusXQG4JYGCfKsarkz2H9HYsRPbimooYXLmM+FaYmXoOzy/JGOQqWuruAXl+DgffN0BFcNeMt/MIn47YyAAeN3uWxJf3fYVvujSgCImWP/R5WjC+xKs5URog4+qi7E6/30vyv/wClwRRzRkrUiTlurGkxfKmf7QRlA9M3HwfWu8KbJ1GQ21r0KpsG0PrNWg43Vp5YC3Byt9JXsi/BTvqI5mfrA7BSQcTL15QPIzxiQxPoF7b3dhqn7ljX+g9AfYKvSQEubkgadZl21PgcHNKyJdjeVfQCKn5VUX0mnvXLEpJ7FOqVsblrG36/o+O7o8+1uBQezn24UN3Jv0geLkJdBRdSQXZ012L1LydhUmCp+oNEam0o/um9JMHU61bIkXfub9/6OaFo8zHf7PSdebGP2e+f7Fi6tAgDGl9YoQW0tBJPZiwkOcK6V2VrIPHX+/MEdSYgtsOfkLE/8qcd4+1Tfh69TVPYu7fggfVZsmmuKnDKTpiT1S+6+WXZ1i8FOyVJ1ky5RSf+ir0E2uMEQaBu7Crtr36uZSSf/Mqq0rGuXwBnVxFqQTFpVCzp0PQ91PhfrWfkjm4nr2+bDCgm0EUlorLpQyDwRXetmUZRG/cAOjLGVMOijCgv2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39850400004)(478600001)(15650500001)(5660300002)(2906002)(38350700002)(38100700002)(4744005)(7416002)(186003)(16526019)(52116002)(6666004)(26005)(956004)(66556008)(2616005)(66946007)(53546011)(66476007)(16576012)(316002)(6486002)(86362001)(8936002)(31686004)(8676002)(83380400001)(4326008)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cldYZEEwSlBrZWlpYVg3RTAzY2owaThOb0x1c0lnN2FraWZCMkxOMXJkeThl?=
 =?utf-8?B?OGM2WG1SVG1oWTRuTjllZXl5SjEyRUFqTGM5NDZ0b0ZGTzAxQ0hNTHp0b0Zw?=
 =?utf-8?B?bFFDV29HcGdpOW4yOTJlNFlCSWVrZ2hMdkFDbHQrY2d5YWpNYkxjMEZYYVhz?=
 =?utf-8?B?WXVYZHVRM0Y0YUE5Y055Rmx6TXd3UndKbmc0SmxCaFFlKzlmdWFyM0RYVmpm?=
 =?utf-8?B?WU5qZS9JWTRCM1FmOUV0N091YWFCTXIwOFRBc29DZUR1N1ZMbU1sdmFMaXJ4?=
 =?utf-8?B?YTJxNGRXSEk2dFhUSjF3cVJTdjVwcmZzNjZTazBTUFhuOTljY3A0MlNEWUtm?=
 =?utf-8?B?V2FLa21WMmxpR0pKbjM1bTJ5MldoYXhUWVZRc3drRkZQTWNjU2M2V0hFcmRT?=
 =?utf-8?B?WlNqMUhZa01hTXJDblpteUY1V2ZlZjVWVUw2ZnByNkNiRTJyak5GV1BMZ3B4?=
 =?utf-8?B?M0NqeHliaDhIV2l1MExVUVM3aWJXazUvc3JhYm9VMTA3b1QxdEtpa0hCT0RL?=
 =?utf-8?B?QW5ZaHpsSFd4enV2bFcrMTAzS3VyWEhlTGlCVFZ1eU5SaHhkOHJVaktsTUM4?=
 =?utf-8?B?SW1sS1lFT1pwQ3pJSEhxV0tTL2pZMmZaRGdMTERIOEhRVitqRVp1YmFrY1BK?=
 =?utf-8?B?VUlOZjhpR0ZQTEVPT0NlZGMrRU16ejloTElYK0lyTjFXMGljSDgySlBMZUFw?=
 =?utf-8?B?TUNRSDVra2tOeGFxN0EzbHFhbU4wMk5sU0pIS0E3UnQ5Z0JJRnVrUktJR1pQ?=
 =?utf-8?B?dVRJZ1Vuek9KK2laMklTTHUrbWVqMnViR3lwRGZ5QXY5ZEE4QVUzTWJsWXEx?=
 =?utf-8?B?aGxGSk1KTHo2a29aK1RuUVljWmJvRFdUM1RKMy8xbkN1dklDTE05ZkhmV1h3?=
 =?utf-8?B?enJwVXd5K0ZBbkFhSlc3RVJKMEdHYmpvMkU5NExJOW5VMGJxVGlPdTYwdnZQ?=
 =?utf-8?B?NnJzZ1cxQXhEWGlXcmNBWUc2WXU2OE1oTUJPeWxrRHQxOTZOMVpBQk9MMndo?=
 =?utf-8?B?aUxWbEVmL2VCdG9PR2dJZVQ4Q244N2pZdW5JUFVkc21FSUlpb0tsK1QzUHNH?=
 =?utf-8?B?SW5HQ3IzVEVJSG1US3VKcTNxaHk5Y0lDOEdPM3NYaG91Mk9YeHRXdEFQWGlw?=
 =?utf-8?B?cmRocHZydUc2QnBqMzdPc0E0TUhWLzk2N3lJbFlnSU1aeXU3Q0dEK2toUmpr?=
 =?utf-8?B?TStEcGlNWWhsUVpmMllRSSsxaW1HNFRNZFQycXBNMHNMaW9OOS8rMHFhU25a?=
 =?utf-8?B?VHVqOFRuNzNPN3FrZW10RGJJTFpFUFNpK2ozTzBJNUpRRyszdWlWbnRaRnlS?=
 =?utf-8?B?dEdTV1VZcE04L1FjamlQLzMwY1V0ZE1lbnVjSldLa21UcnF6UTJoanpNNnYw?=
 =?utf-8?B?aTB1WTlERi9PTW5aRUNHc2pseEl3UTNIbSs5WjhINDVhN3BTVVFCZnhRT2lv?=
 =?utf-8?B?b1RHU3A4L0hFQlJPeVdxQ29ZQ21WajZIUmpoQ2VXUEFFdlI2NGZURkYyMlpM?=
 =?utf-8?B?SUJjQjd2Um15dUNxcGNhaW95WjhaU25FRTRqTEw1cGcxUVkvS2FmbUVoZzBG?=
 =?utf-8?B?TDAxZHFXQlc5OE1xU2VzbGg4cllFa0t5SmlaTjFaUWxkSEQxVVFESDdLU2pi?=
 =?utf-8?B?Sm12T3ZzR0NVVDR4NFV1ZVBtdDdjaEg5V0RRTWo4bTZjVTdJblN2cWt1R3hY?=
 =?utf-8?B?dDkxcS9wOWE5K1FleCs5V0Y3bkw4ZU5mOElKckJrSHBxcGJPY2V6NG1XM3lW?=
 =?utf-8?Q?5CUZxp1bMYj06OFiWKnqMPwoWgnop+4wEJnlxZs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8995da-3989-4a25-8250-08d9200c731a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 06:06:49.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT15XPgaEn/MdzVw0W4WD+asqUM2mPQXzQ/p1PljdwG9adIqGi/leAmxpHJhnHtWhWuQv8PwXGin8Btw87J2LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6860
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi, Shawn

On 2021/5/7 18:19, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8ULP generic MU is a different IP compared with previous i.MX chips.
> It has different register layout and bit position, but the register name
> and bit definitions are almost same with previous i.MX MU.
> 
> So we extend the current imx-mailbox driver to support i.MX8ULP.

Gentle ping.. Except dt-bindings patch get A-b from Rob,no comments.
Is it ok for you to pick up this patchset?

Thanks,
Peng.

> 
> Peng Fan (4):
>    dt-bindings: mailbox: imx-mu: add i.MX8ULP MU support
>    mailbox: imx: replace the xTR/xRR array with single register
>    mailbox: imx: add xSR/xCR register array
>    mailbox: imx-mailbox: support i.MX8ULP MU
> 
>   .../devicetree/bindings/mailbox/fsl,mu.yaml   |   1 +
>   drivers/mailbox/imx-mailbox.c                 | 196 +++++++++++-------
>   2 files changed, 123 insertions(+), 74 deletions(-)
> 
