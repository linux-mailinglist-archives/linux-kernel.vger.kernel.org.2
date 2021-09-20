Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138B14116D5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbhITO1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:27:52 -0400
Received: from mail-eopbgr80092.outbound.protection.outlook.com ([40.107.8.92]:54030
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232312AbhITO1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:27:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBJimKOqn3j7+laHDyKL/0U25ctWhj14dZP117NLne5RPEV5zVF7rjjDs1i3HZykSvOx4HnnIVtmgd9NW3wxmM8e1AHxWFh/VhyvtJQYXaFbswnxt74n4m8W0Pp35YEXOY7+I5ZR98u1kzcsOK7lrPuFX7UVVNsBaOIJcl+V6Y39WnLCtfCibEY+5WM8q0Cjuz7IQ1Ody5ALPVj0RMfxT1IfIKWWpsvNMqIDTIqV135eDEqPZ0WWiH0dEnY9EP5NTHRMJnks9apskgifmwgRK6OoLGZ7IX0T3qf3apkIrcYQkSDuebSUSjd49t3iLSGa7Bm/ByAYXDtiR5vxSakK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SuIj7Dzqt0jQ2QGQSP1WPzwuANOZG7CND/zxl6CCl0=;
 b=K9rehWcLsazmZFkUMgc9av3x+eEkTBBxJAjCLumS+rQa0nV8jIUCfMQwutZ7BB2vLckZ74JmLZKFH8kRR6CliRodABH1i9k1Vu7Z4OF8SeVdigYwKzl0BX2rZobJz9Z0mfyoGWJzyEVmHOkV1NMfWn/dCH11KG9N9bZZ6zDKAEx8rmyZhYdyUXTogkNu3XjX/wSq7hZHhwuuTpDakNBH0bUnQLLJvv6RF3ZXveB4slrfbGWrM75Ns5sAfrshxy98YiH2LQs2RB/Zq77620/Oo1fxsd0Io3bXGto+qkPfVWPzctFfqJ5mPyLu5S0lQtD8szcho47ZVy+RM9195lOr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SuIj7Dzqt0jQ2QGQSP1WPzwuANOZG7CND/zxl6CCl0=;
 b=HPzNHfISuwqCkAN3ReluuQbqYJGYEsiCX3gY2Rnb89XrOTaKkbY0JspNe7jqGPgewdWNkZ1ErFzwfyyThhUAKAsOYrrODvS7D/hjgWmkr7ekE6Uee8qzE5cbxOY1GnVPVMVYw2NHguJyEEbhmy/C4klaArp+19K69/bOilZWTvs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM4PR1001MB1298.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 20 Sep
 2021 14:26:21 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e51f:c969:4825:8fc5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e51f:c969:4825:8fc5%7]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 14:26:21 +0000
Message-ID: <039c9214-423f-0f62-f6d2-6f2c969512fa@kontron.de>
Date:   Mon, 20 Sep 2021 16:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: imx8mm board crash in drivers/usb/chipidea/ci_hdrc_imx.c
Content-Language: en-US
To:     Heiko Thiery <heiko.thiery@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Peter Chen <peter.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
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
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAEyMn7Yvc_tck=Hd8GE1a7uO8nRsrkdJ7b_jL6EY0-U6b=TjoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR2P264CA0045.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::33) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.31.128] (80.147.118.32) by PR2P264CA0045.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 14:26:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfd69b1c-6837-47a7-a263-08d97c429e06
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1298:
X-Microsoft-Antispam-PRVS: <AM4PR1001MB12982FBCC813ECC485E2BF78E9A09@AM4PR1001MB1298.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znuRnZWJknky6FiUhhI3ymvWvhkrlDJvre/lFKb1CfH52hWxn7mYYiRVrRsAjVVviciVyJdqhmb85cesz8ZISDExScq0m6nwtEpFnNksfkZyWsnsjOWVTfREKpGlNkPApWF5mmKh7+sF4Akmlql/e5fAb8YL1Alun7uhWRfm6ZJAL1LijCf3+Uk/BJoeYFjJH/XNQjsU7KlSeb0nSLZfcfRvwaQJVrwxOyaRg4ZMJceP/fcX6Lzs92FOT4vULvPbsje6fq72IWVGf+7LLykndt1W21C9fWkON1mE6xBGFdQm5Q0Jmk2FiEQQVHD0Efk2Q6o9Cp/QHzpXDPjj1Y58Cz8S6lB0A/58Btl0fYCP0jk4RmxsHLUoYAbagOVxFsAn0OeYlrl+1iWHffhKRP3zKkNBjettTUJu3DqdeCusk3gEWg/N42V4ffv2i5ky7phFqDfNzlTCcYN6BeVOftqABFZJMYuJuMzh5DNyIrzI3jtlsJdbLnxceo3HaNC6qq6LJh8S/H8uz9RYz783rx7J5G1px2bfgaYPcObm4LMeLs3HHnCqygVYcUdOzk8KXjY32vDasr68GH196LFHBZspXFAbc5wG4ktdLCSGXvPc0bo/5M+x0S/b8fR5qEropHUzYdfwyu3T0xZimrPvaw8+MEZUmYJformcDczo/4I2+K8wXP1uQRVuWhQapQwjTNLQYCyykp55SA6f1ux1NqHGVZjH4gFueVP3QDHWgYfhgpOyZXqS/3zFMpxk8H8VacgBZQwhwIARuBg3xW1NPOnyqXljZx6yUcAnx/yzWuHUhDRyXzJ5zyWXVm1mfnnmvSavNExz3oIxU9UAnF5dssIptw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(31686004)(66476007)(5660300002)(66556008)(2906002)(956004)(45080400002)(6486002)(966005)(186003)(7416002)(26005)(2616005)(8676002)(8936002)(86362001)(31696002)(16576012)(316002)(36756003)(110136005)(54906003)(44832011)(53546011)(66946007)(38100700002)(478600001)(4326008)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEJROFRQcW1aQVhmUkdWRVdJU1N4bUloME9XR29ZQ2hCbzhQazFvQnRpV3c5?=
 =?utf-8?B?L1lRT2toS0U2QUFweHJlRmRHNm1yOU8rVTk0dENhY2I3cTJtdUEyRm9lNnRQ?=
 =?utf-8?B?TEJZb0o0WGhrSU0wTUJjU09KRnc1Qm1kM2crcVlvcysrWG4vWXhKdUxNQVVn?=
 =?utf-8?B?UnF2bTcrbGZVcnVjYkV3N016WllSZ29raCtHSUhnY2RMOThkc2p4VTlteTVI?=
 =?utf-8?B?NklZUHNZeXM4YkM1RjJZclNiV24zeUNaanpUSTNVSTFpNzZLU3MzOHJxU2o3?=
 =?utf-8?B?ZzRBdnBENmJJdFM0TWh3NkdJcWQ3UkVlUCtzVk9RTzRZb09kTWdwVnFrMGho?=
 =?utf-8?B?SlpaNUNFMGZGNS85RTgvQUwreXRDS0RGY1ZGZ0l3dVdxTEV5Y25ZZFpDcFE4?=
 =?utf-8?B?WFdaU2t0RHR5MVV5czJoaSs2RTE2Rzh2aU1XQW51NUJiVEM5OEZHTU10bmhz?=
 =?utf-8?B?ODQ2bE9wYWUwZFU1MHhXbzIxWk5SSjM4UTVXbE56T2NBQitxd3ZLZy9CMUpP?=
 =?utf-8?B?d0J4T2p0MVloQjg0Zkx1dXViRzVMb2VlQlhwUjJvYVFFNUVGRXM5VTk2ajEr?=
 =?utf-8?B?WnVmak5nYUpzSVkzdW10UUNLbm9LVzVsZWl6Z3g3TkJSZUJId0wrZzRyZTdG?=
 =?utf-8?B?UlBoWElJYU10TDlpbkY5VnNJU0cxWVBhaVg2VUhhV1VRM0tRSmxHUEZxSmFZ?=
 =?utf-8?B?RnVXMVZucUROM1kyREUvWVQ2ZERIWHg0SHVhWXcwRllYYUNJRnh2V2RNUU1F?=
 =?utf-8?B?RXFuaHREM3hBR0l6TDZkcVlmczB5SElkN0RRWjlmZW8vZ2RnS3Y3OVR1RmN1?=
 =?utf-8?B?NjNSWFZkWWtSaUNSNlhvK29xcmJBcVZnSCtkdVpxcGtXVVB3YkhPWFNSRC9p?=
 =?utf-8?B?WDdZWElGREJnVVdoSGJiTmtROTIwQzVUazNzYTVZQXBMNDNlNEx2Y0FpeVV4?=
 =?utf-8?B?Z3diSDVVQUltaUJzRkhMaWJaQjNmUWhhOXBCczE4TGNEcDlleUlGeG94UEdi?=
 =?utf-8?B?OUYvSG9nR2J6WDlYOFh5UXZISWdBWXB0RDZ0NHQ2emwvZEJYTnlSUzRUaTdQ?=
 =?utf-8?B?TUZKQUxzQUNKQmp1cXBjd1VMK2l2N1Y2LzVLVmIya1UyOVd5UTdmSHJxeGkv?=
 =?utf-8?B?SjVSMExxby82SENQNjU3YlJKeHMydHJSZ0dhcTdoVlh0TWhJSkVBZ0M0Yml1?=
 =?utf-8?B?TzNMVG9rczhJY2p4L3RLRHc3SldqNnl0MlhSbHA2ZFNoSWM4MFVtNnFjUG5p?=
 =?utf-8?B?bCtoWlVLSHpxUEV4RjQvUVB2a2xzTXVXYVVPdzhidlR0WGtWK2RYNktsKzNL?=
 =?utf-8?B?bm56eWw0dFdVdFNwalRSUHRrTDg1VlJJQlhYb0liRFpaK2p4NjZlMHd6bEVk?=
 =?utf-8?B?VCtZUmdRL1J6d0NDdlhoY3JSM0J0NVNNOUxqbCtyOXFyVkFyUEllQmttQWVz?=
 =?utf-8?B?aU1VMjdnSSswM09UQldWeXdIS2pGZTRUZk84azAwdS9zVHc3djltWko3YWhO?=
 =?utf-8?B?REgxVndzTk91UWZoeUFLajlndW1IdGpMOC9kMytWR1V6TzR6c041MGRYS28v?=
 =?utf-8?B?bmZMZHR5L0lpR3daeFdZeVpiREhEUmdzbi92ZmtRMk1yandod0U2MzdsdkFj?=
 =?utf-8?B?QW5zRkUyRUZQUllTZ2lzNEtzUy9adm1jeVBLTnJQMU11N1VWTFJUazdKN1B3?=
 =?utf-8?B?MEM0YXlmNWJvNjRwWk9GNVArNnExNzNTaFhtaTVMK3ZjNXBFenphUDFTRitC?=
 =?utf-8?Q?9qvpdYMSmczixf0Yena8O8TO9bA6fIXEs1OHFcC?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd69b1c-6837-47a7-a263-08d97c429e06
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 14:26:21.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kiq5fbQ+iUGNike7y9ABpm3o6rjkVBf6tTjaf3fFIL+lK1jCCo0fGpLelevySshXu22UiXhYHURh88qL3lH3yGfhMJi++jjYA3HRTzJCB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1298
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.21 13:05, Heiko Thiery wrote:
> Hi,
> 
> Am Mo., 20. Sept. 2021 um 12:52 Uhr schrieb Fabio Estevam <festevam@gmail.com>:
>>
>> Hi Heiko,
>>
>> On Mon, Sep 20, 2021 at 6:17 AM Heiko Thiery <heiko.thiery@gmail.com> wrote:
>>
>>> Now it is clear to me. I used the dtb for my board that had already
>>> changed the phy node and tried to boot the "old" kernel 5.14. Thus no
>>> phy could be found. Nevertheless the kernel should not crash in case
>>> no phy was found.
>>
>> Agreed. The patch I proposed earlier should fix the problem, correct?
>> https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2Fraw%2FyZKz1huL&amp;data=04%7C01%7Cfrieder.schrempf%40kontron.de%7C7f02c93eae364cf2fbc608d97c269eb6%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C637677327580221365%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=HMFJKptc6UBzfnpPcPF%2BSdP0g1s%2Fc0OSRfFliD6HibY%3D&amp;reserved=0
> 
> Yes this should do it.

Commit ed5a419bb019 ("usb: chipidea: imx: "fsl,usbphy" phandle is not
mandatory now") explains, that the core driver already covers reading
the "phys" property (see ci_hdrc_probe()):

  Since the chipidea common code support get the USB PHY phandle from
  "phys", the glue layer is not mandatory to get the "fsl,usbphy"
  phandle any more.

This seems to be the reason why ci_hdrc_imx_probe() doesn't return any
error in case "fsl,usbphy" is not set. It expects that the core will
handle data->phy = NULL and already checks for a "phys" property.

Therefore I'm not sure Fabio's fix is the right way to go. Could it be
that the ci_hdrc_imx driver expects that it will be probed before the
ci_hdrc core and this isn't true in Heiko's case?
