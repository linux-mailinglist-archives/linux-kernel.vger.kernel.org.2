Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D7D3B879C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhF3RXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:23:04 -0400
Received: from mail-eopbgr60137.outbound.protection.outlook.com ([40.107.6.137]:20259
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232358AbhF3RXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:23:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+N7lO6Dk+dUGw9Z20KTtJvde3UwqsQm1HeP7eMYHJzzNQQlc93sFK56DSZL5maHMKqcofqc9klsBr+nftblzA2izasv1tkXkkWn6xmErU23MRG4G3oTa1v1ONngR27H93RWBc8eNSco7SQxXqwFufoIqxg/PCwab0s0yRX1vEHHXkSjrcNTSmPOKCXiKPnoqGo05VJyNmOi3sUOgeIYE7sU2uxIhZZzuS9Nb/4VihJ/s/WLuBBVtTe8Sx7xmpS6OhHLl+GHGBITDewCDTGrtgr7lq4BfLbmoIVnQeqyhmkhYI2t/VwfPRSXsi73ukQnlds/IIjlI3KzmdzJrtk91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDq3HmpC7texZ67qlUtCBtHDL4rURFRM+kiKELDIqwM=;
 b=PCUjYuf6ycdGQyVUNxcP0XIxLMDwa7cKBsQW4wq1BQv1ogSK0phS4MyWmzHGGiliOyEDKtCSbAzE9z7wXx9MEkHRQVfosAy5eGgIRwP9dO0Zn7LUuvRUlr4M34u6VYb+qmzGZfWsFsP14WrQZQV60G1UHY2b1vx8xWSJz3JgcmzFJJUk7zrhQjBGEekVgkzjdyV4YhHIFit1C7YyKT7xnzTqqkp/mO8zXPPa/QdCxvEQS7DUxZWVUVdk3yW2myGmT/SyyrztwtrMAh2C/1wY0OiHuPVrKZMTwbkpMrc7aRlGDozASKjcv+autZOBhEy1eHFEYu0srFQUvwxmfjOi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDq3HmpC7texZ67qlUtCBtHDL4rURFRM+kiKELDIqwM=;
 b=LgjQCbVe39Red2gtFmjJu2ULS/8OZYBrATUZ9RiHmWxpbxlk+sPzAACb4fIVwEx5OK6fXBjJeukqhO8nOpjX1qimshwElP7MY5xiPcCThRR7taMVwTsLwGfBfaOxLsdw1k+M2soGqtLenB8jhynqGqyfqhIckfZbt6XPlWq+mSc=
Authentication-Results: amarulasolutions.com; dkim=none (message not signed)
 header.d=none;amarulasolutions.com; dmarc=none action=none
 header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB2529.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Wed, 30 Jun
 2021 17:20:31 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703%5]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 17:20:31 +0000
Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
To:     Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>
References: <20210629072941.7980-1-peng.fan@oss.nxp.com>
 <CAHCN7xJgqRfg1sHNbcpdEFaLHUwhYxe7_r5SEMDqSaCPFXX7UQ@mail.gmail.com>
 <DB6PR0402MB2760B05081D54D775B8949CA88019@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <CAHCN7xL6Rr41fHaaPwi6OA5Du8x09EHcE-bWyiGpz0pVn74jeQ@mail.gmail.com>
 <c6a00f74-6c34-4208-0b17-7fa15835eb3a@kontron.de>
 <181ac373-7701-361e-6364-6fc74b2d71fe@denx.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <fc7fd710-a834-8273-62e7-6a151de03036@kontron.de>
Date:   Wed, 30 Jun 2021 19:20:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <181ac373-7701-361e-6364-6fc74b2d71fe@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.244.188.134]
X-ClientProxiedBy: AM5PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:206:1::33) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.32] (89.244.188.134) by AM5PR04CA0020.eurprd04.prod.outlook.com (2603:10a6:206:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 17:20:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb2bba1c-dd75-417f-c951-08d93beb5cff
X-MS-TrafficTypeDiagnostic: AM0PR10MB2529:
X-Microsoft-Antispam-PRVS: <AM0PR10MB252919CA16D6A3BBE8B7DDDDE9019@AM0PR10MB2529.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeO4v88AigSJ4WwJ9bPvcVmiHEyjNYb70xAIY1d4Rjw7xQDtntG5VcoF1mMNb6su/kx8PDR+ELl1aEVlY4zVpUylGbq5O9OLrkBaCYSaYs25KpsDHMGPTV8xO2R2lroJgqHMNGLvlCNVE6TqQ/kpkKywYFQzDOzhhR5CHPh1zcLWCrkmSF+5cTvLvcy0NAjGQvPpeM4G5THwh3TC6n2aSId2EPhPmR9/KeSoLuFWgKe92n7cI+MD781MKiRiGY6XysxIEWDsm5ij/4gj/UZW9S3zupwn4NH49MgCB/59rygPiIhBVQ4mNwm6F8Rwtu66Jg2G39KaGFxECuWik2RsamU/DinEYydaPSNwtgjwBngA7B/iVqCfvveB+aOzc9G7u6M1zFjcEDoRDFMRAYTfLXSw63nl4/N4BV891IiCzAZpIwcTc705liGUX7xla83lLCgzNa01ewcFdt+abvgWB6ou6fCrsNdyeoJVSJB+P9rA4PGz2yzizhf0R3VYs3Cns4XdoPCDl5BMASqNfqXNbRPmVGcf3vMZi8dUxy4uT8wdTXoKoltRExYHApGvRuFKL+AYB+RU0d88YHei3yReCueebeDft4fs2d4IVz7I3vUBwb8OzV9fhqyKUHtqECAEm23jTnWcoXhN+WxlGWUH1KRpMVSXrT77HiJl1QLjddDFzvfjEd30KoIEl7OYEBJhp8Of/UV70zARZY6D8FDHBjgGxpUrdw4C1DJpoDb4SGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39850400004)(346002)(396003)(376002)(8676002)(53546011)(44832011)(4326008)(6486002)(66946007)(36756003)(2906002)(31686004)(478600001)(26005)(5660300002)(956004)(83380400001)(66556008)(66476007)(8936002)(54906003)(110136005)(38100700002)(7416002)(16526019)(31696002)(86362001)(16576012)(2616005)(186003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFFXeW1aeEVSTW1KUHRQQmdvMFBIQVJOZncvNHdSZzVuVHB2Mm1Sb01mN2Rq?=
 =?utf-8?B?R1dKWlVhdkVsYnNCRHVKZlJ1M3NmY1hjNERRZ1dzcS81TUNKN1pvWURUdmMr?=
 =?utf-8?B?MUVCY1ZCZVZGdTN4b3RIYmVSV2lQb0NyTWtjbWc4YkNMWHZKVzVYMGh1cG1X?=
 =?utf-8?B?ZmVzWmJNTWtYL3l0YTMzWUsxQi96V2RYNitMcHJQVTZBWXBqdm16VUxoZDhE?=
 =?utf-8?B?ckEvMUlaTjR3SUI3RVF6cXRkL2Z4TVRtQ2JRcnJNNHpxOFZNRnoyelJjVVpp?=
 =?utf-8?B?UEtKeUxXajBRYkRDcHl4NDhPcDhKVGtIcG9SNUt4YzJ6QzIxQTBnaTN2OG1a?=
 =?utf-8?B?OUhQZjY1cUZHZndYRUtGWURMR2VUZUVPYkdwRStyRythMFlSWDIrcVBRN0ZE?=
 =?utf-8?B?R3IyZmRDVmtPbzFHU20xMnVwREJVYmpHQnVGMzVBa3dMbHZWMzExaWgyUzEx?=
 =?utf-8?B?QzJMSVdhNlVpTVlQc2pMYnM3WHhHdkR2MWZMZE96Q1Q1STZPYkQrM3pOMXAv?=
 =?utf-8?B?Zmp1enIzZWYwTU5zd1dDQ01OZCtYMGYyMG9FZ3hBKy9NdlZJWXJONjhJV0dj?=
 =?utf-8?B?NHNYd3JSK2lxaE94Wk9XWHhSTDAzMWhINFVWNHdZZWJ0TXRuaFdtN0NIa0RG?=
 =?utf-8?B?WUtTSDE4UHdpWDZVVUIxUi9ZT0ZYdVg5c3BycnlHQ1lPbGN2QnhKem5wYmEr?=
 =?utf-8?B?aWZsRy9weEZaUmhvV0gyMk1HY3JReDJqNWRHZ1BCU2pyNy9GSUsrWUE0OGps?=
 =?utf-8?B?QjJtTmJaU1dWY1lrTGU3eXR0cnBENlNyTWNlNUVSUnJ4enQzNnBnUGlIejkx?=
 =?utf-8?B?MU1qcVVhRDNOL3Fid0dYVXZidENVZVRHejB1ajdvM3RxU3BnY2tPSEFDUUZ5?=
 =?utf-8?B?NUlpK01wbFNXTmEwMUJwZ0JON1ZITnlGOUZZQnFOcDg5MGFLWGhMSnk5b1FM?=
 =?utf-8?B?TGRUY3pMeldYTnF0SHJaVTZZV3hXZWI0Q0gxUEFvbCt6UUtYUytwYnVKWHAv?=
 =?utf-8?B?eEhGT2xtRFFUVGtMcnlHdEltQ1htOXJ1UWFTWmJHUzk3SnBLVUdMZHpTUFho?=
 =?utf-8?B?Sjd6dXczbHYzK3ZuQ2RvZkZ2ZFpjaEhROWNwMlFteE0rZkhrVkhxcGxyL1JL?=
 =?utf-8?B?bE83S0ZYa2Qzd2lvazBpRDd4Y2V3STd4U2pHWEJtVXdMeFB1STVISDQ5Unlr?=
 =?utf-8?B?K0ZIMElnc3NvRDZtZHdTU0VhaDhOdVJCNEVPSUhobmtHanBSMERiM3FWY0Fk?=
 =?utf-8?B?UzV6S0tQS0RmMllLT0U1RTQ3MTZ1VWE1SVhmOE1qSjRVeHEvWWtrQW5zK1BZ?=
 =?utf-8?B?UmpIRW4rbFBsOUgvTTk3amJCNVY1SXhvK3ZVRVF0SXNEZkpFY0R0MUF2dHFP?=
 =?utf-8?B?Y1hwZVNQTkhKRktPL3BsRXZtaGtVeUNVUTBQYmNOakJ5ZFhNeUE4dDFDcGw3?=
 =?utf-8?B?ZTV0b2lBaDdlSnpuc3FQeWI1QkJDWGF1VVlleVBCR1RnaExGcGdicWxOdTlm?=
 =?utf-8?B?VW1KRTJ0Z0o5OVEwWTBCWTVQZWEvbnBtWHkyT0ZONXpNWVdUMlp4T3lQV052?=
 =?utf-8?B?RmxsR2JCQU9UbXMrZGhyWEpQeFdJeE94VzliTlUvTnBVMGdiTFVwWjBmaGRV?=
 =?utf-8?B?cjl2OFEzSUl4QmJzRjBNQm9tYkpiYXluMlNDUmFmOXNhZk43S2FDcXozZkNO?=
 =?utf-8?B?MnVvaWVTdTFtUU13WENKQWpMeU9QUWo0ZzVJVWtVUldqbUk0Rk5ZZ0lON2p3?=
 =?utf-8?Q?ggGAWbdY3eQkagZSM0lVL6dgD/IR2+7/IqUQbOa?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2bba1c-dd75-417f-c951-08d93beb5cff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 17:20:31.4615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEQVaCiEniJNv1Vjf0D8KluwTZ2EfGhLVMqXT+htUrOUxq7GFnRsVLh/nrBFC+SUzMeaTkUzegcZrA6Kqj58XgwxxsFPPKXF/x/fqzbZujI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2529
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.06.21 18:28, Marek Vasut wrote:
> On 6/30/21 4:46 PM, Frieder Schrempf wrote:
>> On 30.06.21 14:09, Adam Ford wrote:
>>> On Wed, Jun 30, 2021 at 4:34 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>>>
>>>>> Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
>>>>>
>>>>> On Tue, Jun 29, 2021 at 1:56 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
>>>>> wrote:
>>>>>>
>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>
>>>>>> V8:
>>>>>> Revert one change in v7, force goto disable_clk for handshake when
>>>>>> power on in patch 3 One minor update to use if{} else {}, not if{};
>>>>>> if{}; in patch 3 Typo Hankshake->Handshake
>>>>>>
>>>>> I am using ATF, branch lf_v2.4, from the NXP code aurora repo with U-Boot
>>>>> v2021.07-rc5
>>>>>
>>>>> I applied this patch against linux-next, I applied the pgc patches [1], and the
>>>>> suggested power-domains to the otg1 and otg2 nodes.
>>>>> I am able to boot the device and use USB, but with this applied, I cannot wake
>>>>> from sleep.  If I revert this, the system wakes from sleep again.
>>>>
>>>> I just tried linux-next without this patch on iMX8MM EVK, suspend/resume
>>>> not work. Per my last test, it works before. Not sure what changed in kernel.
>>>>
>>>> Which kernel are you using, any commit or git repo? I could try on imx8mm
>>>> evk and debug the issue you see.
>>>
>>> I used kernel-next,
>>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>> commit 889bab4c367a0ef58208fd80fafa74bb6e2dca26 (tag: next-20210621)
>>>
>>> I then applied the GPCv2 patch that Marek sent.  You were CC'd on the
>>> e-mail from Marek, but I can forward the patch to you if you can't
>>> find it.
>>> I tested his patch and I was able to suspend-to-RAM and resume.
>>> Once I was comfortable that it worked, I then applied your patch
>>> series for the blk-ctl.
>>> With the blk-ctl series applied, the suspend-resume stopped working.
>>
>> Same here. I tested with linux-next-20210629 and as soon as I add the BLK-CTL driver and devicetree nodes, the resume after suspend causes a lockup each time.
> 
> btw do you have etnaviv enabled ?

yes, but I can try without and see if it's related.
