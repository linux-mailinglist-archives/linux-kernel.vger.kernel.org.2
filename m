Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4523A3D1FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 10:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhGVHw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 03:52:29 -0400
Received: from mail-eopbgr140100.outbound.protection.outlook.com ([40.107.14.100]:41348
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230048AbhGVHw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 03:52:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aI+8OWS12hizQDpoZv/oBkJGXIPsJDmxgmb/WdCp+LSGErL1v+Pl1SDkep65ufhgmVL36el4Alk8cupg0vIpTT8ZufaNyRE4T2fLreWn0P9NV3yBLExFJGqhQRm9vudod5W3i0UAX/dyShm509b9RmcTiPy/FymfOh9z2VkvRRg6sVQ1YdXZrNjoLJ2qvGRxq1BjkBvHw/UaFoP+fFgh5xmY2ujudHLMsjbADmwWJhxQugRtJ9fmg70gqqBjj6tz+bMJB/JJZ/I4/I2oUW3QwwCUjFDtOuDCNXDTFhgyWl1gmycsHDCX3zgp8zOHtm7A6ZNIdYYJXEFB3t8H7aZhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddhN7S7FPM3vKpoIhp8lBTeuviL8zSZtCOuOVseHTA0=;
 b=Gl7DUw0oMcCFXy+hbd4+d/8x17/G6lo3chy4K11ZYo8nc+a59rGc0UBj82UILTopzyzmIyKwOnPrg7xegelzrSk1Ph1NZs0eqIq7TEutk/AGMpoM5e2I3B42NhFmDe6EnR+Rfj05xl3qGZxFgy8TbhL8fWw6w62E43ij3goKLDNsPCgH4q9Wmn7kPJqywUGa5Vmrart2jJ/J6eSUXO4EgCr2X490M8gTL2Hk0V7jekoFSX3rALS60k2LudO5ru0SN+HMTSgTnzynjoxGog5UPzwccfFY+b64QEr1qM2bn+RLgOZnvvtARYP6oVGT1x3xNbcH2DEAtyDdRlolzV4RGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddhN7S7FPM3vKpoIhp8lBTeuviL8zSZtCOuOVseHTA0=;
 b=grsp9ftp5Z22gWXJUcR/u0dNdMIWuyGpPOPYv/xbup40ZGnPkZRlZTYzXUDNf8NBY1ABYZNAM46rnSBH7k7TYUwaTLV5WytcJiFkf7p6gOO9VVDilqzupzjNJUTA2s9ARCY7SkG75CU0X8Ebhhi85rf80RoeHbmr+uxWNPBAs7w=
Authentication-Results: opensynergy.com; dkim=none (message not signed)
 header.d=none;opensynergy.com; dmarc=none action=none
 header.from=opensynergy.com;
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        igor.skalkin@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-8-cristian.marussi@arm.com>
 <a163653c-51f9-adf0-c978-b747ddf2498a@opensynergy.com>
 <20210719091451.GF49078@e120937-lin>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v6 07/17] firmware: arm_scmi: Handle concurrent and
 out-of-order messages
Message-ID: <85868de4-54bf-cca8-3786-61a404b80117@opensynergy.com>
Date:   Thu, 22 Jul 2021 10:32:58 +0200
In-Reply-To: <20210719091451.GF49078@e120937-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::12) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c94fb4f6-efa7-41a1-f7e6-08d94ceb50dc
X-MS-TrafficTypeDiagnostic: AM8PR04MB7891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB78911FEC87085023D498FAF58CE49@AM8PR04MB7891.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQap9XI3O137Y3Z+Ovy6ANVNOvR628lal/3aj6YVOiaEH22MNmFJtM+YgGqA92iGAY3Av/55o2ZsQuGD7Rzvioa7xfhVkMPbkV7KOJiWnG+qZQnmScKQA3Mo0LQLkUgaIlVEMMHsbmTapw4RD8LA4UGDrjLvdCy0MxdfhqmIKt7lNVuqgEIovvKFBurB3tbG5w/b2m+oRrHWOB75dc8nyRNkPSnpQHxWN7OsnNAssSggKeInJarhb4ZXZWLnSB2Ocac6dF3PaeIwiTsWBE7K0cMVoyNMuW98N6y4IB9YrmK4CVuYbW5X2nHc44wDHamMvfxN4HuZuMorQZvIzVY4+cFFRcBpCVVXzUVnSPR+h1vIru1VfKSpWJ8VLXM/7QnemZptL9+FlZkb4LWDcj2RBsOWIngfHVvSgujPYrahkxOkOaB2tr/FQzUDj/tbmH4416el5UpKvE4mMmmeNk7yKjRn5cYr3tEKhfSCl3LnMi9mLKzMGqKALkmJdkd6mEDp6vkAbvCx/Q38lKt3khDAUALEMTHsYlh9iXxsgdru6CERCBO0tR9lHZhlQzO9HBKpNN6UAyZriTz3XB25X719Y47BRay8nbMe/MDi8tjWi+dYY922bcynjK//ufVsKSikMkPOBHG+LH/AaSCKoyzHmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(396003)(346002)(376002)(186003)(44832011)(4326008)(2616005)(42186006)(31696002)(316002)(107886003)(2906002)(36756003)(5660300002)(86362001)(8676002)(7416002)(6916009)(8936002)(66946007)(83380400001)(66556008)(38100700002)(53546011)(31686004)(66476007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wld5MVFIaWdQaVE2TDdrdlRhU1R0QndjL0UrbUZXZFRDeml5eDlUaWIrZTZM?=
 =?utf-8?B?MkV1cXZsb0h1TWRHREtUMTY1aFVMd0tmWWJ4b0NoQTFPeXBZNzdHbWswalQ5?=
 =?utf-8?B?M2xTZzh0ajg0VzNZczZsbVQzRmE3NmFDeTQzbFhraXpzSnVRM2RMWXdUWE14?=
 =?utf-8?B?bU1oekx5c0tLQU05S2J2WEluMTdjeUdybE9ublVjdVI4Si9XNlIxSnQxVk5G?=
 =?utf-8?B?VHh0a3l4aW5CWVJqTVVQM2Mrbm9LZlBpQkZSMVJZUEFlSnBrY3MrM1c3eHVP?=
 =?utf-8?B?Z3JkVTgxbjlmVGg4eVlmUm1ZNlBYa0tWOGJlYS9iYVhERTRYUlF2Q1ZhK1h3?=
 =?utf-8?B?cDhmcE9IN2Zlb2ZtOVVQVmdLclBtNUdsanZmeWhRaG5NaWpyeGJLSGs4b0pt?=
 =?utf-8?B?ZWpubjRGU1dEbDVkQ29lUWxxY0thN1RJZ1JDNG11VEx3cW9CV3pZRW9aZGQ0?=
 =?utf-8?B?UC8yOWx1aldqTWk1KzFBNXVhb3MyZWk0bmRlbjBSY1o5MEtQWkNLeXBZV3h1?=
 =?utf-8?B?RXV4a3Bod3o1S1lKUGFIbEM1UEhpZ1RZNXBKdlB1VnJ2dENKVEhkMzdybVhM?=
 =?utf-8?B?a3c4elRTU3haNXZJeXl4Y2F1UjFXSmZJR3FmTndhTkhMclhOcnIyZGFrY3lH?=
 =?utf-8?B?MWFVM0wyVTM5bkYxZHN1aWhhVEFrUlpleldpWjJiTnN0cmRrM3N0WUJSdUNa?=
 =?utf-8?B?ZXpHTkQ0dUViOWhiTXZhamZTQWJPMDNZV3E4N0g5UXFqOTlka25xRVF4VDBo?=
 =?utf-8?B?K25iR0RnaVkzU3NYdmJDVEhBeXFabVRHS2NDSmNaTGRYYm4xR2JvM1p2V1Er?=
 =?utf-8?B?b3hpSjduTkdyYXpvT29hZkl1c0MxU1U0ZG1jQ0oybmprR0NXSnNQQW4vSG5n?=
 =?utf-8?B?QzNvV3lEbGdwSTFMSzlNczNsaStIWm1yUFpNNVNnRjJzVGFocmszQWRqdnVC?=
 =?utf-8?B?M1hNdW1NSEVLeVlEWi9sMjJVNVdTZ1lBaFZvWG9ZdUF0TjdnZ1Fjc282bEwv?=
 =?utf-8?B?dEpNZkNNcHBqdWgyUjgxSkhsS1J6ZEZSS21FQ1NkRlpkdmpON2w2UnRhQkZV?=
 =?utf-8?B?QlYrbmVOeFU5VWE4WTYramE5YnJTM2pxRjdmTERXYk9haVlhZ0ZST0Vua3R0?=
 =?utf-8?B?WTVQbTN3SUVlTlRYUlhOZ0pQQXhMMnMrZjkxS2MrZnN2b3F6WWVMbFh2OFhF?=
 =?utf-8?B?cGRGTGF6a1FJUWFRK0tQcFozdmE4TkY3eEZhcFBhaGpmcElybVFCRjFEakhj?=
 =?utf-8?B?ckozQ29ySE5zU3dPRXJFMEgvTGRxT3JIczdMbFUzSkVZQnRhYm5OTDZpczJD?=
 =?utf-8?B?WTJoR2NrZCszaG5Ibk8rV1dDcktybE5zWisxOUlOYTN4WXdmcXJSTExsVXRx?=
 =?utf-8?B?RUZJOTREcmlUdkZHMzdxVXdsbmtPOFlXYy92eE45TTZBb0RSYnZUNm9URlBT?=
 =?utf-8?B?VFFBVXhaS2xRUk9ULzQ3VW1rcGNYa1JMSnc2c3hoZEN2WnpZUy9pL1YxRmJv?=
 =?utf-8?B?cXRaNHM4MkFKcWJOSUpGMUlraUc5M2tUWWt0WlA5VVFaMGsyNjlNNTNDY0oy?=
 =?utf-8?B?VXdkbjRsQzJESkpCY0FJTmwrQzR4WUhvTXVQK2xrbVJsaVJUc2JGenNXc2R2?=
 =?utf-8?B?Zkk3RmxQeUxQdUdqekdCNFdNMmVlWTBmK0U0UjRjOVp2MGREMFd0WXJIRm8x?=
 =?utf-8?B?aGpMNEx5R0VrdFFwaDlaWkcyUkpiV09RMURvU3V5eXpZbVNWK3JERjlpUHo0?=
 =?utf-8?B?WERoZWZnOENYQkpYbXpiTExHQnoyZEhWNS9jVFNOYTVRdm5naTY5T1VOQnJD?=
 =?utf-8?B?cmhQdUlRaVVDRGQxQ05nbnM0T1JtTHFNWXZPODBxRWwwYmxIcU9FVWZYc2Z3?=
 =?utf-8?Q?R3dmQOxftNoaI?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94fb4f6-efa7-41a1-f7e6-08d94ceb50dc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 08:33:00.9112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/AJSfekdSMUiAMINn8FUW9tAE807iMc234S0ZIywf4ROMM46RLNA/kBz0HQUMI0Aby5rzW7mYBrHE53lrzakg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7891
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.21 11:14, Cristian Marussi wrote:
> On Thu, Jul 15, 2021 at 06:36:03PM +0200, Peter Hilber wrote:
>> On 12.07.21 16:18, Cristian Marussi wrote:

[snip]

>>> @@ -608,6 +755,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
>>>    			      xfer->hdr.protocol_id, xfer->hdr.seq,
>>>    			      xfer->hdr.poll_completion);
>>> +	xfer->state = SCMI_XFER_SENT_OK;
>>
>> To be completely safe, this assignment could also be protected by the
>> xfer->lock.
>>
> 
> In fact this would be true being xfer->lock meant to protect the state but it
> seemed to me unnecessary here given that this is a brand new xfer with a
> brand new (monotonic) seq number so that any possibly late-received msg will
> carry an old stale seq number certainly different from this such that cannot be
> possibly mapped to this same xfer. (but just discarded on xfer lookup in
> xfer_command_acquire)
> 
> The issue indeed could still exist only for do_xfer loops (as you pointed out
> already early on) where the seq_num is used, but in that case on a timeout we
> would have already bailed out of the loop and reported an error so any timed-out
> late received response would have been anyway discarded; so at the end I thought
> I could avoid spinlocking here.
> 
> Thanks,
> Cristian
> 

I mostly meant to refer to the possibility of a very fast response not 
seeing this assignment, since the next line is

>  	ret = info->desc->ops->send_message(cinfo, xfer);

and during that a regular scmi_rx_callback(), reading xfer->state, can 
already arrive. But maybe this is too theoretical.

Best regards,

Peter
