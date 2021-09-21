Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B4A412EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 08:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhIUGoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 02:44:08 -0400
Received: from mail-am6eur05on2105.outbound.protection.outlook.com ([40.107.22.105]:58336
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229862AbhIUGoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 02:44:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRtYJFbm8jyDAWODi+TpxF7GqahmoRZtpScFT5lopX/UdQ0jiC3T3QnhaCkzbyuqZfjxO/ZtDaOBKT/gzma8Uoph9OFqQdIDDVdf8YX3e/Tqkf7v2ssTxbyfAXA98uH0ce14WB82mW4pvEGS1LvQfkN5eCy7UW30g/XaxOsSbL5Braun7beWUxy0c5VkTnBncrZbrHbtxzTSipAk/mMZCUCPMeU+oFdy7KRyME+sc3YkATCODH5feyEUhqPkHG6lY5HjK+fcFYIB2Anaj6yTSBhFhE2cXI0QGzLNecOl/QDEmsO0WFZ8R+VHYrNhtznIJUXWRum+mjnSF9fTFQFLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MWqKg8PoPrYEa+WND5ZLsilXi6+jlfoo7nD5rBel4bQ=;
 b=U3ELvUWUI9NHEk/ybQJ/bwstqwJ2H/dL8A9UxMMo+7VO+yTxHjEAPAge4a+T3h7bxO8jJh7wwTPVrK+/OBKiLD299zZQmL4U/Rdo2OzKzd4DUh1QYMjEteOPrzLNjyeqRQvgGV5nAm87etq2YcRttCKg5lfHaVx8od5w4uTc25JnxGpccaGPb23Tn3u4TWXn+xHgza9LnxUvLZCeHcvb8xc4bSOXCkHdjGwjYecdE5O7ZbMvHJFtHBRe64ppsGdy2GV+pdP1IDZtLXkCz6dxKAAykQda+9j2nTBy3kQz7gdFcJamhzQfGo2zyolyAbbdTkbIX8NT52eCQ4h1gI2Ejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWqKg8PoPrYEa+WND5ZLsilXi6+jlfoo7nD5rBel4bQ=;
 b=ZcTDiYxRUqWUdpdYokeWhuancjCNBlBtxZJJfT/bpeB8yB+WGzUnD244AByBkpNratxDqNKPWDT5I55nRkOZu8Qb2agX3AHNTZvwP2Xa6ZWjCRYm2AoOCbygDGDolm7nMsQksH8UxsXBDkEb+xDkLcaLG7qk5oYplX0uILa5GZ4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM4PR1001MB1250.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:8d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 06:42:37 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e51f:c969:4825:8fc5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e51f:c969:4825:8fc5%7]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 06:42:37 +0000
Message-ID: <5d5fd917-a330-21b9-f8c1-25792a0f11e9@kontron.de>
Date:   Tue, 21 Sep 2021 08:42:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: imx8mm board crash in drivers/usb/chipidea/ci_hdrc_imx.c
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Heiko Thiery <heiko.thiery@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
References: <CAEyMn7YqrRttqvJzJLA+yVo6WtBZww6QcXT12MMCi+bhjP4pTg@mail.gmail.com>
 <CAEyMn7ZhBfG7703YMr=EDQyf5mHDkLyET5iNqdXDOpJy9ti+rQ@mail.gmail.com>
 <CAOMZO5CZKdc=AmG1eds9Oy_uwqXDWLwPXk74phCDWdjrzkRC4A@mail.gmail.com>
 <CAEyMn7YaQbLoVy_5Rb+hiwhEj-kbnmCwb0B_soa+Kf0D6iH6oA@mail.gmail.com>
 <CAOMZO5CGuKQ0yVyoD86G3KnxoBd2fq+uCTTLoqVR-13Y5a-36Q@mail.gmail.com>
 <CAEyMn7bN247-J=Qz-k3LZMVYb8pdYSP3BSCsNE9yyvfDfmdK0g@mail.gmail.com>
 <CAOMZO5DEg81E23QBpsv44BxytEhNNoXy-r5BbnubUJTERzWYLQ@mail.gmail.com>
 <CAEyMn7Yvc_tck=Hd8GE1a7uO8nRsrkdJ7b_jL6EY0-U6b=TjoQ@mail.gmail.com>
 <039c9214-423f-0f62-f6d2-6f2c969512fa@kontron.de>
 <CAOMZO5A4x_v8wtGyDjLdMg_hS1=UZH3LV-e+Dyz=spmSaLyAaw@mail.gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAOMZO5A4x_v8wtGyDjLdMg_hS1=UZH3LV-e+Dyz=spmSaLyAaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P191CA0036.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::11) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
Received: from [192.168.10.40] (89.244.183.176) by PR3P191CA0036.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17 via Frontend Transport; Tue, 21 Sep 2021 06:42:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af550eab-9f46-4444-78b0-08d97ccaff7e
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1250:
X-Microsoft-Antispam-PRVS: <AM4PR1001MB1250B1F6895B0639D3D2D9C6E9A19@AM4PR1001MB1250.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wMLyp48yFqkp8wryEMcPwi17o5Dw82GZlvNjLMWENGmSpqsabVY0gWYu924h3HB8fmPGV8wIRvUatF6rrjtRUdLb8qAPQXzJWQwE5DsWPD8no0DBZPiiKpVlJyp/bJgVP21aV6ktyLsQOH2AFQQ35nQ6jTGPAji39nA57gpBrobRmsMIvM6ld2XCNHzI2QRtilN7Ao6/9PHU29qSUBvfu9t4fKNYcxZ1oabNZG4UZOnA+80857T7JTTDXfZtGu2ZdA58stIYqbOYHdg2IN0Q1wsMdQoMtyqM3vdf1VnkSaybUcNwqlJ/PUHRtbahTlyRJbqJGmFzEchnWxjNsEno02U+8dr0tajHdt/LMFfdLjgiSQyMfdy0Y85JvQwczDpP7XAVHA55g1M172vSX6jmyKjR2g9jwtvHmF/d1kWLYwn38XM0pt7pUMnw0W0ZT3niKOFvR/hanWH3QSTh1jxCb2fz6L/n13YdqldL5WW6kUJ4qFq+jlAgk4rywe7LKqBYyAQa4C7LDhs7hkzgqGsERTkGp7SVJ/rKkqTnD+2CgZ6rQnFG/Nt6CPPJUD/js8khWw6CiwXLgKjzlp0EGvIugQeewLgr47mqJN1eHk8UDz7wxkMSQdAoliFQVt9MIUPTwkz92eqty6OdytqHZxrodzIiOMPZ6rKyWxzitTmSkmdKbEILrev7HPuku2K1ucEt5NGyF+z3K78O4fSw93NsFnLhYy8nHiJks6u1BF0yNj+dmCtG7rWaYes6tviKyQj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(186003)(6916009)(38100700002)(5660300002)(956004)(53546011)(86362001)(4326008)(6486002)(508600001)(31696002)(36756003)(7416002)(2616005)(66476007)(2906002)(66556008)(66946007)(83380400001)(16576012)(8936002)(44832011)(8676002)(54906003)(316002)(31686004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGg0KzEzUWlBL1pBWnJhVnlDZk9uaDRHQUE5U2ZtY2VtVFJlV3dZSTFIQzdZ?=
 =?utf-8?B?RERBZlpVM2gyOWVZNTJraktNRmFJRTVZZGZTamVuVURacTRZdzhBTnh1a1lK?=
 =?utf-8?B?cWNzR0NjQjlJVDhCNTZYL0VGajJIK3dBQ2RRQklvczVVY2hFV05CSS9lVUYw?=
 =?utf-8?B?aWpDcVFzb3lFM3R5aEQ0YkVpeGVXSUNCelJyYmVVYi9wRjFDRWp1TmNvR2J5?=
 =?utf-8?B?aFFKM09MRjNMN1Fib2I4SDlSYXh4YnpPOG8zQ0szRDFIMGFQQ3FIRTRRYXFR?=
 =?utf-8?B?SDh6Nnl6YVNCTnZkZXkvSFVxaE1yeUk0Q25rdkd5dmx2ZHlMZDlhK1pJRUJu?=
 =?utf-8?B?VVdnMVJUT1VtUzRhdWVqOUY4K20xSlhHMnhkYmI4RE9USGlkaWtHcHhpdzNO?=
 =?utf-8?B?UUJRSEF4Rkl2dHhCenZ3VEZZSURYNnZBNmc2bHEyYVEwbFAwRzhoZ3BLS2da?=
 =?utf-8?B?cjk3NkNLMmFhaStMWnE0NERXYW82ZWRJZG1NTjJHM204S2Rid2RzeW1zTGw1?=
 =?utf-8?B?MWEyclVFZmthWDBsVjkweDFrYTNoSkdtT3g1TnN3VndPQTVocU45aHVENlFn?=
 =?utf-8?B?SVI3MG8vL0JSMUpENFlPSndTcFVucTJoMlNmVTB3MFVYUmIwV3c5MjdHZTRP?=
 =?utf-8?B?M2lUdFQ4M3B0UzFrTlNIRVN4U0VjSVhVNWtoWitmZ2NjQ3lLdnJDMUhjSXRW?=
 =?utf-8?B?TEZvdU5RRVMvSjdzNlZGcE5HanNCd1ZvZ3lOWGdWTVVkRHlUTHFkTEhod21Z?=
 =?utf-8?B?NUZjY3JqNTV0QWZOSFRha3EzTkJjcGFneVhBWXRGSU9YOXp0M0RCQ0xCb3Vm?=
 =?utf-8?B?aHVHZVo2a1o2RHpIbXNMUW1ZeGY1b3krdXNXSWNOMUJPdEowTGFhZUU3TWVY?=
 =?utf-8?B?TEpQdWZKSElDR3FyV3VFcVFmbll2Mm1pOGh3UTR1UWNIVUxqYWNGZWIwOUth?=
 =?utf-8?B?bUpWNExvWS9OK1RFZDk3RFloT3A1NE1SaldnUER0UDBsNjU0WWZxZFhmVVVM?=
 =?utf-8?B?UFUwcFROU01PZS9FVWNFbzAzUy9ZQVdpS21RMi81MlVUb2N6WFgxWFlEelkz?=
 =?utf-8?B?akhzTGF5NzBVT0NTZ09ZWTh0clFMd0t6Vkt4ZWR0ejBGTFVRaWpnNy9Tak9x?=
 =?utf-8?B?aS9QNGxDZ2xLajdzQmtlT1oxVnJPWXh5Mmh4YUNEV1Z3NER1Nzl5aEU1dVNZ?=
 =?utf-8?B?Z01tbXJwUjB4bHBOMklzSkswanZnOENyTWN3N2xhRk10Ri9peVVHUjV4bjBN?=
 =?utf-8?B?Mm9ZZm5kdzVBdlV4OTRLekxJQnlmdWdib1c5d1haSVJZTVYzOUp0UHFMSmV2?=
 =?utf-8?B?ZHQ3Wnc1OHFONHVFNDJ2ZVFPK0UxUUxKNDIxcmxOeFNtaGhOSjVqR0hYZG56?=
 =?utf-8?B?M08yNXVxTVlLdlNqUmM4UGFjdkZyUDQycU9Fci9YN1FHWTVpVUZqMTRhVDFI?=
 =?utf-8?B?RW4yYTlHUE9xZS9KVWpBNHhJWmtaRERYY3lsQUFXVkFDK0c5ZnBUUnZjUHdH?=
 =?utf-8?B?OXcvbTg0TWdOck11K0VCRVFtcWxsWFZZT0VibEV5QXZnUkdGYnVGTldiVHVT?=
 =?utf-8?B?cFpuWWdVTjk4a05ZR2ZPT3ZpSEJSaGpuN0pLbzhnN3pKZjNQOC9QcGg3VDNK?=
 =?utf-8?B?L1ZSWHdNdUQ3czJCTjdEZVk3SG1oOTY0bjRPaU1GWEswRlZYTjRxekt5QjVM?=
 =?utf-8?B?NUJZb2dUNXlvekwrK3dCa2ZhaWJFSGdkZ2NUM2xkYnUwN0VEbWQwMHFhaXE4?=
 =?utf-8?Q?pdjhm0cSlA+1U/oCABJxu0zOmkoXpjZQHqKDJLE?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: af550eab-9f46-4444-78b0-08d97ccaff7e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 06:42:36.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBaOJQLLrFpaAIScvKZMif2L8g79K0uGdyFEbMlwOeu8hgE8mLdeLAjavClHnVIXXLKQNuI11EYMfCzr8zDOcvpZfJGQCyzii/MF38MFGy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1250
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 20.09.21 22:50, Fabio Estevam wrote:
> Hi Frieder,
> 
> On Mon, Sep 20, 2021 at 11:26 AM Frieder Schrempf
> <frieder.schrempf@kontron.de> wrote:
> 
>> Commit ed5a419bb019 ("usb: chipidea: imx: "fsl,usbphy" phandle is not
>> mandatory now") explains, that the core driver already covers reading
>> the "phys" property (see ci_hdrc_probe()):
>>
>>   Since the chipidea common code support get the USB PHY phandle from
>>   "phys", the glue layer is not mandatory to get the "fsl,usbphy"
>>   phandle any more.
>>
>> This seems to be the reason why ci_hdrc_imx_probe() doesn't return any
>> error in case "fsl,usbphy" is not set. It expects that the core will
>> handle data->phy = NULL and already checks for a "phys" property.
> 
> chipidea core populates ci->usb_phy when phys is used.
> 
> The charger detection function only checks data->usb_phy, so they
> don't see ci->usb_phy that was populated by the chipidea core.
> 
> We could change the signature of all charger detection functions to
> receive struct ci_hdrc *ci, but that will be a huge patch that will
> probably not meet
> the stable requirements, so I think to minimally fix stable we should
> go with the proposed fix I suggested.

Ok, thanks for the explanation. I agree. Would you mind sending the fix
as formal patch?

Thanks
Frieder
