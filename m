Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F82324BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhBYIYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:24:31 -0500
Received: from mail-db8eur05on2118.outbound.protection.outlook.com ([40.107.20.118]:40928
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235745AbhBYIYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:24:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJkfIQOXeEZMybnaN4ZwLebNIkSxcvjC6NNEKeBbayqOyE7Qnlem+MWmVIgyHp1x4f74E4aZ/EBF+oJrVlKRsFiNm36WwuIr8Mv4SB865+BQFafq9EaoIykDlB4pJ2nDRzux0sOcoxxUZe5AeHva1YzURt7rf5ZpMzH25GCEM9OxLAdHMqAJ+bDvUvKyDuar0Isf7RxzfmFhbsggpLNvcfJ0G25tzG3YBi2+/qQldV/Rrra5kAWuW7O2+57RLq676icDeIX2vkO7rGmtWiJWUco0v0iKgDETJz80qu+9xgeYGWRV+6i2K03PmHVkBvrwES+ogMJA39JyDzja0mBO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMedY1oLRo/jDf0B1R4vsWg91QRQr3MNg71pOTjoLNc=;
 b=cbXJyS1MzD3j3ikVRBAFrlu2KGDwyx7Ebim4eI4J9RpzcRY2MDfxsD1yvqkedeUEU5x/N9Oi7sIVCkT+I4CIix2c3rIRFKAFIQP11agnAvfIR3CwprvPK9CgEaMnVBwqnCUfDbaEjS45yI2cnELYtpkVc9QBVQEAtLyawipO0hgNHk1d4tCADRzD0UEqwMbWFwwCK8DcA2z6dE9HRT+TEqL0Dm4zEFP5v2JF3S6ZLwzBSuvfwy8sIFlCAPn1Sr3w8W2yxBNk+wmqmKGz+Zcwdyc4NSUKbGrk2YFbe0VKBSKItRUNytGrMdtxes4GsoSxdCh6wPYS7NdzO5gqJYAlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMedY1oLRo/jDf0B1R4vsWg91QRQr3MNg71pOTjoLNc=;
 b=Q+Bu4mH145XFboB/bN8zfO4ZihMYL7atrUnwRNgVFoiE2qjlNlXYS6rSvHUebA0GftkDsdj/hbUcuIGVx4qlYXcerUxxoB4YfWxQHyI5qJQz9CRW67bb7qxPT24DcQzoCFDu2Tkw3y1G4XeLAwhFK2Dn2ZKeEL04+H/KKtHnSho=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 08:23:27 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a907:416:cdde:9538]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a907:416:cdde:9538%3]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 08:23:27 +0000
Subject: Re: [PATCH v5 10/14] clk: imx: Add generic blk-ctl driver
To:     Abel Vesa <abel.vesa@nxp.com>, Dong Aisheng <dongas86@gmail.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
 <1604402306-5348-11-git-send-email-abel.vesa@nxp.com>
 <CAA+hA=TfyW6Ya9adcQFd1=-sJyoCgMyaENmGumtV1ZYar1Ud2g@mail.gmail.com>
 <20201117144828.omlwhu5y7cwsf5ci@fsr-ub1664-175>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <6ecf593d-bee6-b0c1-718f-edcee90650ad@kontron.de>
Date:   Thu, 25 Feb 2021 09:23:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201117144828.omlwhu5y7cwsf5ci@fsr-ub1664-175>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.247.38.166]
X-ClientProxiedBy: AM5PR0201CA0015.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::25) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (89.247.38.166) by AM5PR0201CA0015.eurprd02.prod.outlook.com (2603:10a6:203:3d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Thu, 25 Feb 2021 08:23:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3137311-5d43-4053-a741-08d8d966a049
X-MS-TrafficTypeDiagnostic: AM0PR10MB3588:
X-Microsoft-Antispam-PRVS: <AM0PR10MB35886099EF29EE6A66FD6598E99E9@AM0PR10MB3588.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWCwI81VyA9JNyZP0i37N2I/OpWecohDr+kSpYEuCpzOyWbgz8HAcrhUJXsj5deB6Pj5jQCvaltB2xk/5PmoP6SPzPNAXmvRr0A2fvwN50iRjDvBAbJOMhbBDGaimsTOWLRpv2GCaBX/TTcOqdr1+LO38dsl1HtYR0UgD/ZSTKI8Y/+FynrGBLJS4WSDbXiHeW42GfGsvY+tftaMDUL3UtJTFSWX2C1Ku3Mnc+vhnR0M4yPy+zcwd+oKQRRhOm539zKG4OT3rF7hZmmh4somclBHEDX6G9kX0otG4IdXHATw/Am3OEHAk8WbhZMW39oDRhOmjTiemyKldoNaUfbgC6eFppHXx4o/cRZGBG77qQsL3AWQ3rcrdP92wH744kAFKo0ONp8/4bhf5Sa+poz3HiFrDPJUaowKx8Adbno4PUMBoWPzRBO9QrnOqBSNdX0lRT/8HuBL76VAtYR9INUTXA025LqUkZUKUordPJA3kXxBQPXjnID7bUm5cHqSC7nIdr1cSKijpoghKWHl3UzINQBHHBG0xZgnkSgdF6L6WQEBGaq5SCIO5DO4rG7aq1jf0a0rxVFdac8IuGWIHYn3eWLFONgvQ2wbQvGcH9uJe2x7u1NgE+c21qBme9eIixsV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(66946007)(8676002)(186003)(26005)(16526019)(31696002)(86362001)(5660300002)(66476007)(66556008)(31686004)(53546011)(52116002)(956004)(83380400001)(54906003)(8936002)(2616005)(110136005)(44832011)(16576012)(36756003)(7416002)(316002)(2906002)(6486002)(478600001)(4326008)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R0RjRkN6Ti9XWkpwTnpibGswQzNPRDFFUjg2Yjd1MEZwOU5NOXRmY1ljVmVR?=
 =?utf-8?B?K0pXczlZSUR5TUxPSTgzelRFSXh1K3YrRTJPcTlKZlI5ZFdLSjBsY1Y1cU5o?=
 =?utf-8?B?djB6N2d3bzZqUjRoRHRGSkpyU1JGT3NFbC9IVEJSRW9wRUl3TU1WYk9Bdy9F?=
 =?utf-8?B?SjVsMWFreC82V1RQRis5eENWWFM1cnd5ZWlRMWFrSFFNcXgrL0tyQlRJZ0kr?=
 =?utf-8?B?b0crckpFdkUzL0JBKzhmVlpYam5VVUVSczhEWGVHdUNZbzIzNy9OWmlDY05E?=
 =?utf-8?B?algzZmpDOGVCdjFWSnZodEZUZGNQczVTS2hoaE1zemFKUktWYTg5R3hNbG54?=
 =?utf-8?B?N25xbVBZZkNuTjJGUkxmU2E5RlJjWW9MeE5PRGs5blg1YjZsVDVublFPL0g1?=
 =?utf-8?B?NjNrOEpCMDlNeVcrS1VWNHoxbFZ4VmtTNG92TWErall1eGFaVEs0aDhDTU96?=
 =?utf-8?B?b2hBNm5KeWVVS0VYaG0wQms3TVM3SnRJeDNxbktkQUE5dDVVOSs2aFJTOWtG?=
 =?utf-8?B?YU9nYTk4MDdIUjMzdGY2bXVJWG1ra1loeks4cHJabVdnS1MzYU9oaVlkeE93?=
 =?utf-8?B?emUycENRRzlnMHFGWklJaDdTWFNYR2J6ODYxNTJLVmlENTZUWmdXdlJtbXR4?=
 =?utf-8?B?azhrVGs2RHA2cHllTitzWFQvcVdIb05xL1ZjQzZZWVBZNHA0QyswQStIcTh1?=
 =?utf-8?B?RUFncWY4c1lreVFyNnE4UlFhK3M0clFWdnhqT3Y2aU5qVjZ4dmRocnU4b212?=
 =?utf-8?B?MTVYTlZoWGpjMGtWNmtsamxza3J6eHZwK2VJYWxWcEFISDVlWnNlamM2ME1w?=
 =?utf-8?B?OFJvVUVQQ0RrRFpqanZ2VjJLTXRQL3RnTzBHZ0xFa25UeTdkam5Fbk1wdUt2?=
 =?utf-8?B?M1NRYlhyZ2NocXI3Y1Y0bjdYbEhqMDZDbGpneWZIblFPMjhTbnNUNTk0R25Z?=
 =?utf-8?B?U1hrbFQ5OFR6TGgrcnd2UEFiWTZSeTZZaXhlenhsQmdlZXh1UGRMZUZnQzR6?=
 =?utf-8?B?R3dmMVJ3Zk03WTQ4eUlwYTVLSWdCdXRQRVdQZmFQc256QlNRdUtvT2pid25K?=
 =?utf-8?B?ZWkzYVJZSVNTQ210ZXVYR1RvWmk5OVpmcGtMTUorN0xKUmNJaFhDUHpTZzho?=
 =?utf-8?B?RmZUVlpwVzJBVG5MeXcwd3VQd3dOaUxjcjhDZll0UzRmSEVYNmw0ZkFsa1dQ?=
 =?utf-8?B?aStKODFUVFZrOFJyQTI2NWtUYVUwdEdDTy9VdWU3TnBqOTZxTEtGZ3NtVG83?=
 =?utf-8?B?YXFKOGt5QXZEeTJwSEM5Sythd3NYc2FLTklYS25YK2ttN3doMXpIekUvOGlQ?=
 =?utf-8?B?YzJucWpJTjRjdVJKZGVtdXFhcUM3SXEzWEErMzdnN21UT01ucXZXUjlYOXlw?=
 =?utf-8?B?UVlqVHVpaTBXR0E3eTVVRWtQbDgyb3AySElKYml0OHh1N3pvY2pYWkE5Vkoz?=
 =?utf-8?B?aGJ2bElLZUFKcERJeGhwZzJxWlBOeWNVaGl5TlFpSWpOVzJCYnpKbWZjTlg1?=
 =?utf-8?B?dFpScUNiRE1yeERUQVYrUk9ISG91aEg4c2dDZlVoNlFXVDYvS0o1UDhJSjNQ?=
 =?utf-8?B?YUZxYjQ4ZWZaS2c0cDd2cDZxYkJEM1FhOTdCWmRObE03UWV2V0haMkg2MGt1?=
 =?utf-8?B?M3F5dmVXdTVTUjZRRUp3TnRIUmJjOUNHWUNHLzIvNXlXVVN1azNxVmk5ampo?=
 =?utf-8?B?cjI4ZzdUK0NpT0dmUktCQk94SWxmbGZrclYxNHBiOThjYVc3bDBTRGpDT3RL?=
 =?utf-8?Q?rd638KcWKucOGNOyjIyMge79pN93GqWEF1Ap80m?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b3137311-5d43-4053-a741-08d8d966a049
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 08:23:27.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGSCx8G+MhmNILOtu6+vTtIOxasLg4y3kaJ/dOzXmXQGy2qpomxLOsxWr9oJwHFz8o++6VvrFKLkTEqg0t4729ibnC1JQYW9z2yKnMIr3XE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3588
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On 17.11.20 15:48, Abel Vesa wrote:
> On 20-11-11 17:13:25, Dong Aisheng wrote:
>> On Tue, Nov 3, 2020 at 7:22 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>> ...
>>> +static int imx_blk_ctl_reset_set(struct reset_controller_dev *rcdev,
>>> +                                 unsigned long id, bool assert)
>>> +{
>>> +       struct imx_blk_ctl_drvdata *drvdata = container_of(rcdev,
>>> +                       struct imx_blk_ctl_drvdata, rcdev);
>>> +       unsigned int offset = drvdata->rst_hws[id].offset;
>>> +       unsigned int shift = drvdata->rst_hws[id].shift;
>>> +       unsigned int mask = drvdata->rst_hws[id].mask;
>>> +       void __iomem *reg_addr = drvdata->base + offset;
>>> +       unsigned long flags;
>>> +       u32 reg;
>>> +
>>> +       if (!assert && !test_bit(1, &drvdata->rst_hws[id].asserted))
>>> +               return -ENODEV;
>>
>> What if consumers call deassert first in probe which seems common in kernel?
>> It seems will fail.
>> e.g.
>> probe() {
>>      reset_control_get()
>>      reset_control_deassert()
>> }
>>
>> Regards
>> Aisheng
>>
> 
> OK, I'm trying to explain here how I know the resets are supposed to be working
> and how the BLK_CTL IP is working.
> 
> 
> First of, the BLK_CTL bits (resets and clocks) all have the HW init (default) values
> as 0. Basically, after the blk_ctl PD is powered on, the resets are deasserted and
> clocks are gated by default. Since the blk_ctl is not the parent of any of the
> consumers in devicetree (the reg maps are entirely different anyway), there is no
> way of ordering the runtime callbacks between the consumer and the blk_ctl. So we
> might end up having the runtime resume callback after the one from EARC (consumer),
> for example, which will basically overwrite the value written by EARC driver with
> whatever was saved on suspend.
> 
> Now, about the usage of the reset bits. AFAICT, it would make more sense to assert
> the reset, then enable the clock, then deassert. This way, you're keeping the
> EARC (consumer) in reset (with the clocks on) until you eventually release it out of
> reset by deasserting. This is how the runtime resume should deal with the reset
> and the clock. As for the runtime suspend, the reset can be entirely ignored as long
> as you're disabling the clock.
> 
> This last part will allow the blk_ctl to make the following assumption:
> if all the clocks are disabled and none of the reset bits are asserted, I can power off.
> 
> Now, I know there are drivers outthere that do assert on suspend, but as long as the
> clocks are disabled, the assert will have no impact. But maybe in their case the reset
> controller cannot power down itself.
> 
> As for the safekeeping of the register, I'll just drop it due to the following arguments:
> 1. all the clocks are gated by default
> 2. all resets are deasserted by default
> 3. when blk_ctl goes down, all the consumers go down. (all have the same PD)
> 
>  From 1 and 2 results the IP will not be running and from 3 results the HW state
> of every IP becomes HW init state.

Are there any plans to continue this work? As BLK-CTL it is not only 
relevant for the i.MX8MP, but also for i.MX8MM and i.MX8MN, it would be 
nice to get this ready in order to prepare for proper graphics/display 
support.

Thanks
Frieder
