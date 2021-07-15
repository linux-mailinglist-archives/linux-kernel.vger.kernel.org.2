Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB43CA285
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhGOQjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:39:33 -0400
Received: from mail-eopbgr70127.outbound.protection.outlook.com ([40.107.7.127]:12352
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232070AbhGOQja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:39:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pis9XkfexfJXymu8J0XIQxQrKdIW9LrJhcoECc2Ae/wXcp/UlwBNvg2b4ipIKUEmTqhg3e4c9UFQSuA56LDL8p80nqHezcjTmYePqLnqsCHlnAvxt3Vi37Ff5wQZJmQ3c9KrrXA0DokjztAE9yLLK0NuPMnvIuQ/Jd8K5xHNRe8+guQWlsIvAh/yhUUqMKvbHJgc/Sfnfv1ARb1AmtdV6tIqNnsEvGLsgtyRPiuQhFcVA7Js81z2AAnFEyauEXLa6clYjjvFfbyDZPtzlo1PFd7ZcdMD6lqaKF+p1tvXFa1zwiEuu5qaPaIE08CgyTD7OwvV0RMomx4AKpWrqt8Qog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3QcIN1kQ8lMrkkfXlumODvzmv7FH2Yr9odXXwraVOs=;
 b=E/hELElpgOPDBzIX8MjRQeDMvsN5pJSUVX1RVAPVt58BCPW5RrFjWIIY68iJhFeKHuKXKOKy56Mh3nQard1Kiy67sxsa6a4NlohjiluhI93/vA947DMyr+14qd9nDxVQ8uTMxPSw4kezU4zVfJgVKK6gj/C9R83YcCISmWt3yF1WvbBlFmiE6ZEn40JchYOjsBDtlJ2oCukyIwUQzQeAxpq9IDyWt2DP42VbcMC9XNTZqc/xxGQ2+SBVjOsJ3Cr4IjA7f7X82O90YBHyClvhdtH3byYcamdawDUp+Sh64ddAbEDpvjKsP1LyAenIWnwOQJS6IhPmtfeeR+L9y/drWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3QcIN1kQ8lMrkkfXlumODvzmv7FH2Yr9odXXwraVOs=;
 b=R8FYCvCHkuZdXLT/LhjQSCBNnNU4nVrU4dZNsVtum720A5je2KeMxvkeBQ32aIJAHnvfNUNpEEyuVnoSyQkNPhQF8fjKwcslI9Ex8z5VBHx2gtLQZ0CJdkUjTpEA6d3jshiNOctOnRXy+Lv5aqDE1mvjAoDJbyDPga2A2AVj2i4=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=opensynergy.com;
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
References: <20210712162626.34705-1-cristian.marussi@arm.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v3 0/8] Introduce atomic support for SCMI transports
Message-ID: <8e79683a-76a8-3213-08d8-f838c2db842a@opensynergy.com>
Date:   Thu, 15 Jul 2021 18:36:33 +0200
In-Reply-To: <20210712162626.34705-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::29) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78964f89-0ab4-4504-67bc-08d947aeb606
X-MS-TrafficTypeDiagnostic: AM0PR04MB5731:
X-Microsoft-Antispam-PRVS: <AM0PR04MB573156C0401938105BE9BE0B8C129@AM0PR04MB5731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAPfQJ+4ls/F9wHEzjlyQBHKlalLhbJFN8iN4D/stIuf0+YkKUNRor3mQPx7+u3JAy3B3CaQVhaXWLXbdKbk5dGazFaIskNr2m+pClnmveQgSjyxBrD2k9t/hfaJr0shYAZ5qkfDv+nfHKT6eeS2/YACM02yrHaEuoc1xZ7KDP+tiimQXSsWFIjtFozCpafkxC9J1uKykAPTApa/T21Hm+iNkKsyX7cNX9g9q3EH1ZFjk5lZ1BI4pO3Jm++pmM/vJj+mDP/P4tiG9QHAmpqG2HY5u7EAR+E17O4FbC7A1fP2K9T4d0JgMbJKVfSxAmwuxACPXgUwT3aZVqPw/mgiYihmakze+rI9F4fnSn6AkRMguvo0ORb7fPLTJlrfixg+enw2yk8bB+xiRevNSgZR0PsyWHVyPNA51NF3+7hf+xsAasHVNjZ/egykEy3WoNdPPqL+wtZUsJx9pcuKJjPUEof6rEIoKkZqfx/yH0zH08MIvns6RVHX7QgYq0RISw2QeSIxphOFSEwK+MT4tXz3+G+E3XBl50iOWnQg38QWHE4w1faQSsKi98OeLpRXCzRmcfZdKxI5VvLfQ7+q1sz8xVURDaG0JtkEBuEAc0ZQZcANY8WGxSLzHAQHmxSRKzJIH3v1hx2NUmZbgIc1AYpqHI+exGTr9blD47Lr2WiCY5vHkdQz2DRG0L5ZrFjZHJkeEXfq2z+kDB7LEJQbnYQxvrBMvc8NxNI/NzUHIWAfDyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39830400003)(376002)(136003)(44832011)(186003)(2616005)(8676002)(8936002)(2906002)(7416002)(83380400001)(66946007)(31696002)(53546011)(4326008)(38100700002)(86362001)(478600001)(66476007)(42186006)(66556008)(31686004)(5660300002)(36756003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0p1VlNtMWpoOUhiMmppU3M2cFhUWWFLcll4d0lpdWNYZUZhbmJRb0NNc3dh?=
 =?utf-8?B?b09wMEw1YzEwQkVoclJqMTRZcEJVcVNJMncvc0JLL1lZY1F1Q0k5dE0vN1I5?=
 =?utf-8?B?YTBYeW9qeUZDRG1kYW5LWmQ2andGQmJCaUtLT1hoVW93Qk1vbHpyWlNmMTBD?=
 =?utf-8?B?bWM5WXFqUjE1d3ljUHFkWWEwcktVOGdRUGQ5d2FrbFB2MEZnRUl3T2RpZGpn?=
 =?utf-8?B?VGtrRkpxZkp6U0JqZ1JnTFRVMXpIb1BvU281bWk1YXJ5NGNvZ3NQdjNwUDQ3?=
 =?utf-8?B?bG9SVWFXYWx4WnJkZzlQejU5Y3VwTDQ4T3hxT1ovSzc2RC9uamNQZEhmNk9k?=
 =?utf-8?B?UDkwRVVXS01WK3JJMUMyOUxReXNva1lGQnVkNWRRMHJzWUJsOUdEYUI4dll5?=
 =?utf-8?B?V1JONVhwTGl1Tklud3RmSHQ1MWcyNHZQdkx6SjVwaHUwd0FoRjRVYklFSWdX?=
 =?utf-8?B?MzNOdFM1SEtlZ29taUx4bjlQdmFGelRFWlp2VFNKRDNvT2Q1d054bnMvOCtG?=
 =?utf-8?B?RzNsL0xUNGxJdVNobmVRTTB0Y2JEQi9sSE84WTZKNzkveTFXOVB6ckYvWVN5?=
 =?utf-8?B?dmFoUFJ4YWRIT2JMd2Y2TTJXbm5SMm5pLy9GcFQ4a3d0VW9UWFJqQTZROXEv?=
 =?utf-8?B?SHh3UXFFcmNlaXlRcHRieEJOMWJwMkpmaG5aU3FpRHdFTC9sUHdHQ0xlYUxB?=
 =?utf-8?B?MzZtbkZ5aXZ2Z2JFZ0VsdStxWnpHTU5ORGNxSXFSL1M4eEhmNytoSlR2djc0?=
 =?utf-8?B?WG1zQTBkanNDVU5SdlIyK2pZOUFoVUxZbXB4NzNacCtUMlh4Ui8rUFlIOUdO?=
 =?utf-8?B?VWVyRW0rLzhJTG1uTVQwQlBQVjJwRU9WbVlLcjZiSWtyRkcyYnNxRFdXQnlO?=
 =?utf-8?B?cmtIU0kwWFh2TnY2YkU5RjY4VjNiQVYvazJqZ2hRdzYxUEdhbWhaZG9wVk80?=
 =?utf-8?B?UVprSEM1WDd3dE82ZVpUeGFUZkc0ZmdITmJ3WEtqeldlR2lPVld0aDFVRnJU?=
 =?utf-8?B?RmdSSk1QVEdHU0pwMW92ZkxKcVlEcG02bnVqTVZmNDhWVFMwQVh2NWl1UVZo?=
 =?utf-8?B?NXNNZFJKUTlJSXYxUS9oS1F5ODlUdk84Ujk0dS96Z2VsN25xMlN1bGkvbjRF?=
 =?utf-8?B?ODhpU3l0TUVyVnZlVGtyV3ArcTVvRDlkcEFoWXUxUFNrb0Jkem5pZlBaUVZN?=
 =?utf-8?B?ODJqZmo4L3dPbXpMcmtpQTV4d2dYTWFOQzJYMnRhMEZ0TWZ4QzRvMFhVOGVE?=
 =?utf-8?B?QXdvQjh4TWdPTGd5elRjeFVOV1NvS2tyeUhlVFZNK29lSS9Ib0l6NGgzclZo?=
 =?utf-8?B?Z3ZmQllKWitWd3JlTnBLNVloSkQyN2VkTyszWmtWSzQ0bTVZYkxENnJaT0hQ?=
 =?utf-8?B?ZTE4dVZHcWxNVnZhcWd2WGJwd3MrR1V2TVB6Q042Q0ZTZy9tN1JadzZObGhX?=
 =?utf-8?B?NXd4VlNJUWtOQ3VRTHNQTW5sQm5MK0pTUW1FWFh2emVxei85WDlwVm9rQVli?=
 =?utf-8?B?b1ZadnJMbEhXZnhWVUJ6a3Jkay9FNHZjc3M5ZXI5K0E0T2hyQmpvaUNnTndX?=
 =?utf-8?B?WVQ4bFJLS2IxSlJCVGRaVktjaDdjRm9kUi93U210Z1JUMWtjQ3ZIQ3BTWXFy?=
 =?utf-8?B?Q2JwZnlIY3hwOHZTeHZFSVdFV2QyM1VEYlZER2lOTitsUS9DRk4xSWZhRTlC?=
 =?utf-8?B?dlR2RjJ4d1RqcVRrb2p2YjlVS24yRWprQlVieDJVN2VYRUZMK01uaGVvMHVX?=
 =?utf-8?B?cForUXNxUFVUdEJ2bmk0ZE5ENzdab25FRit4SGZlTk1nUnZBL2d4Uld0VTZu?=
 =?utf-8?B?cCt6bmZ0bXhIaWpLaGFyQTdZQWZSNmRybGloSUpwV252cm9kS0paSm1hcFpH?=
 =?utf-8?Q?uo6qppfHIZmet?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78964f89-0ab4-4504-67bc-08d947aeb606
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:36:35.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aySm/UZLfgodOAmf6bT4dsIMEehvlQu4F5vo8Rk44Is84sOGW7E6HPDTmV0uGxDzTkIUaxq2q9QSlXkqP/SzAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5731
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.21 18:26, Cristian Marussi wrote:
> Hi all,
> 
> This series mainly aims to introduce atomic support for transports
> that can support it.
> 
> At first in [1/8], as a closely related addition, it is introduced a
> common way for a transport to signal to the SCMI core that it does not
> offer completion interrupts, so that the usual polling behaviour based
> on .poll_done() will be required: this can be done enabling statically
> a global polling behaviour for the whole transport with flag
> scmi_desc.force_polling OR dynamically enabling at runtime such polling
> behaviour on a per-channel basis with scmi_chan_info.needs_polling,
> typically during .chan_setup(). The usual per-command polling selection
> behaviour based on hdr.poll_completion is preserved as before.
> 
> Then in [2/8], a transport that supports atomic operations on its TX path
> can now declare itself as .atomic_capable and as a consequence the SCMI
> core will refrain itself from sleeping on the correspondent RX-path.
> 
> In [5/8] a simple method is introduced so that an SCMI driver can easily
> query the core to check if the currently used transport is configured to
> behave in an atomic manner: in this way, interested SCMI driver users, like
> Clock framework [6/8], can optionally support atomic operations when
> operating on an atomically configured transport.
> 
> Finally there are 2 *tentative" RFC patch for SMC transport: at first [7/8]
> ports SMC to use the common core completions when completion interrupt is
> available or otherwise revert to use common core polling mechanism above
> introduced; then in [8/8] SMC is converted to be .atomic_capable by
> substituting the mutexes with busy-waiting to keep the channel 'locked'.
> 
> SMC changes have NOT been tested so far (I cannot), AND they are just a
> proposal at this stage to try to better abstract and unify behaviour with
> the SCMI core; both patches are completely intended as RFCs, though, not
> only regarding their implementation but even their mere existence is RFC:
> I mean maybe we just don't want to do such kind of unification/abstraction,
> and I can just drop those SMC patches if unwanted; any feedback welcome.
> 
> Atomic support has been minimally tested against the upcoming virtio
> transport V6 series, while polling has been tested with mailbox transports.
> 
> The series is based on SCMI VirtIO Transport support V6 [1] (since it will
> be the main prospective user of atomic mode) and, as such, it is also
> publicly available on top of SCMI VirtIO V6 from ARM GitLab [2].
> (Note that in order to use/test atomic mode on virtio you'll have to enable
>   it setting .atomic_capable = true in virtio.c::scmi_virtio_desc)

I think the .atomic_capable setting should become configurable, not 
always-on, for the scmi-virtio transport (and the timeout should become 
configurable as well). Not sure if it might make sense to add a 
corresponding new feature for the (OASIS) Virtio SCMI device definition.

Best regards,

Peter

> 
> Given I'm still gathering feedback on this, I still not have CCed any
> maintainer out of SCMI subsystem.
> 
> Any feedback welcome.
> 
> Thanks,
> 
> Cristian
> 
> ---
> 
> [1]:https://lore.kernel.org/linux-arm-kernel/20210712141833.6628-1-cristian.marussi@arm.com/
> [2]:https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_atomic_transport_V3_on_virtio_V6
> 
> V2 --> v3
> - rebased on SCMI VirtIO V6 which in turn is based on v5.14-rc1
> 
> 
> Cristian Marussi (8):
>    firmware: arm_scmi: Add configurable polling mode for transports
>    firmware: arm_scmi: Add support for atomic transports
>    include: trace: Add new scmi_xfer_response_wait event
>    firmware: arm_scmi: Use new trace event scmi_xfer_response_wait
>    firmware: arm_scmi: Add is_transport_atomic() handle method
>    clk: scmi: Support atomic enable/disable API
>    [RFC] firmware: arm_scmi: Make smc transport use common completions
>    [RFC] firmware: arm_scmi: Make smc transport atomic
> 
>   drivers/clk/clk-scmi.c             |  44 ++++--
>   drivers/firmware/arm_scmi/common.h |  13 ++
>   drivers/firmware/arm_scmi/driver.c | 223 ++++++++++++++++++++++-------
>   drivers/firmware/arm_scmi/smc.c    |  61 +++++---
>   include/linux/scmi_protocol.h      |   8 ++
>   include/trace/events/scmi.h        |  28 ++++
>   6 files changed, 297 insertions(+), 80 deletions(-)
> 

