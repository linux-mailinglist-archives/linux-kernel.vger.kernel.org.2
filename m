Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CDF3CA27F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhGOQit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:38:49 -0400
Received: from mail-eopbgr70114.outbound.protection.outlook.com ([40.107.7.114]:1830
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229990AbhGOQiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:38:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ae/qyVFosuDP+i6gqG3/m6289IxMCjj13D0hYb6dRMBmJrep1oIhwdW5CdvV9FsHJ+kGbBaeD3k+HVsXZHflWFwiauiOA+gWzl2beD0+Pq5AfwlGve4CK5QIWhCk6l+jJKj2mNT6QDd1IV0Kxeodwy7p7yLDdKvNcgAicinozDnB26VTwflI4+rk9kSC3W20WSlvlR2pKtStBjJ5AtKf78LKWMD35L+n+Y1IeoVfOpHtWN+zUOCMgJNFWQQG281FK9IMqS22qrxXIsgm4SHYJRPxMqlwklFUFN52Nv0xKeKph6rLVWGoO6OIUtD9vFoflirxLmHeKPJ2FdT2GouQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DqxUuYHhmtTo6aVzGmTmXfsk9aaNdjaQ26F+u8VUXk=;
 b=RgWbuFpg5fm4vp6VTnwhkhI/bWf3WQM69OBmMY3Hji7tS9RaoWHIgFirecVJ5Ki9Eojyvhp0LTqZiz6VttnMjxVaNOqmKlI+iicUq/iTt5E4VHQQ41ToWfJOuDJVx1Miah2jjw/a/pvd+IE0NqaS8fXUzadHw04PwPkwC0DLJY2/LCbldeu+BWLwwAmPUyB7ysbjZ5z0KU3LgIhxAvIUV+SnzhZesGNrYfoS5sSPYP8wcFOyA/41lT37AzwVWYYpc3Zw11AIMGoMARFn4Q+s9XdOTyIhah0upRNdLJBbiwgbHo7nIwqxR14xlOI3L5g4iPg9cLxHxDxj9Ypm3OrfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DqxUuYHhmtTo6aVzGmTmXfsk9aaNdjaQ26F+u8VUXk=;
 b=ZHALk7RD3y7ldc63rNyk6zdxKazF7nJ/C/mma+vXWr5/5mJ/787Gh+x5NEMYN3j+7Nvq6DBTyQY+puFkP7XNh5SOALQaW3NkPL77ioX/N2lQ7Q86jo+z37JBN1903w5pzmULXbgwS82FpnF0JGczsvXpM2g5QBYNhh2PfrvKVFA=
Authentication-Results: opensynergy.com; dkim=none (message not signed)
 header.d=none;opensynergy.com; dmarc=none action=none
 header.from=opensynergy.com;
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
References: <20210712141833.6628-1-cristian.marussi@arm.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v6 00/17] Introduce SCMI transport based on VirtIO
Message-ID: <314d75d6-ae5c-6aaf-b796-a424c195aee4@opensynergy.com>
Date:   Thu, 15 Jul 2021 18:35:38 +0200
In-Reply-To: <20210712141833.6628-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P250CA0030.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::35) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea2073af-91d8-4287-5fa5-08d947ae9bb3
X-MS-TrafficTypeDiagnostic: AM0PR04MB6609:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6609E4BC625F8D9006D0CF538C129@AM0PR04MB6609.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqWl39qrmeWL3xl9uTwtB+wGDK5bL/oAerTlIKa5FNO66msrS4CbgZseKbgxbaqBYgYx1bL4YyJGajNazdqkxlcCUuguzOtg7okRN1WgrMMLFrieYMBstpcTro5krfY5Ryfh5c6fC1ljbfz0GpZ/HYeWVCoAQmP+z9hG9/Haz9R4gxKpgWhLQ2P5ylOMylmPcptgUWmrcX6E0l/gq+GJoUhRcgUSzLs9o4R5DxnNkoMIF/pSe65Sr+ALtlm+oE5afRsKExAFerpv0ZbzhsVMpHGEQunKvbZehXaWpfXOLelGRqPWp+XK2BpEbyKUvzZjmgRCs4uoP9d9XyCZXnxd5QiLxDc0To9Ze9JkkobZA7Ivi7RrtByygZ1T3Dg10grVvt4JjKFaRlOUX/9unx3hvuTcobf518gpR27nA4KEw+XpDRW3oPnp0qp0mTXm0HKvSzRqFv6D+7FVIwszHXi2bi0s3PVWZ3HrxfH9fvRU98n3tnde+tt5QCgx3ppVf6rX0IfWZ++pihq4QNbkNHmvwg6/0O9/VtAFj/mpflZFYhRI5s7NIF1fe5iXXDjxevNlNUWW2yN3fr/V9OOa+MDKWgl1tx/FbGi1Sep2iPt5b50UHx5nXDNKapL0TkPMkBdjyxGf457YqSwLfEcaMytEpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(136003)(376002)(346002)(366004)(31686004)(44832011)(66946007)(4326008)(107886003)(36756003)(8676002)(186003)(5660300002)(66556008)(7416002)(38100700002)(66476007)(83380400001)(86362001)(2616005)(478600001)(53546011)(8936002)(42186006)(2906002)(31696002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnJnN2ZtUDEzSWtPb3ZKYjVXNkNaNjZ1dEVmM2lpQkVpZitpZ0xhcUlaNURV?=
 =?utf-8?B?TFJ6R3RCckxBeFkzU2RvU1ZucmIvS2hlaXc2ZUJGZzBaYkpTRWw1anBPUUs0?=
 =?utf-8?B?QUh6SjBjNHNsdGZXQUhzTDlqdm1NRFAwa2hYaGprMGVTcGRPSXowL1Zaa05x?=
 =?utf-8?B?RWkyVDQ2dVpOWjJ2N0ZBSUI0RW04QUpBa1ZwUGR5OWtBQ21odmlQcDBTMkpm?=
 =?utf-8?B?SmlzMXRYNDkxWlBhTGoyZ3loM29idVNBTEF2ZTNGU1J3V1hPYkVHQ0xwNUgv?=
 =?utf-8?B?WUNucXgxTlczeUNaNGR6eWFYNHZRdjE3ZXo1aDNHd1JWUFNNVDJrTk9lRW9F?=
 =?utf-8?B?L1BmbWNaTGMyNmFVL1AzcTdVcERDaExBZjgyTjh4NTdZTTY2TXZ0SndJRi9i?=
 =?utf-8?B?Ry9YMDh2dUpnWFhScHBDZGVPTjJ6czdNMngxcERFZ29nckVoM1phcEExNEVZ?=
 =?utf-8?B?ZTZJN3ptTUVxM2xpRnJlYnRJSXNrcDFWTDNkM3cvb3BIRkdvbUI3bmJiWHVs?=
 =?utf-8?B?VFBxV2ZZSUl2R1BvY2MxcUkyZC84U01PcXkrNVBwTHlOMXUrRCtCU2orYXpv?=
 =?utf-8?B?Q1FDc2VOWVd0S1VvWUd1TFA1OVdldWlLZjdMa0xiOUlNYWZSSFNQdTVOSmNt?=
 =?utf-8?B?ZFY4bUcxQ1ZEVU82b01COG4zckVyTFpmbTBLL2xEL3E1Z3Z6V25iMWZhY2kz?=
 =?utf-8?B?TlJCWUphQWdDSklLUDNBT2lsSUc5VURTdFY0YW9rZHZ4RG84K2tSaDdkam5Z?=
 =?utf-8?B?MEpCaWdscmlSOVBDS3J0Wm1mTmtFYjREK3R6OTREOHdmcmNUODJDU2pNQnlV?=
 =?utf-8?B?YllqVXN1RnNlT2dOYnJJNDgzUGNRMVc5NldkSGZ6b2Z1czZaRng0M2hiaThC?=
 =?utf-8?B?T2FwUjNoazgzV2QxaUZLOTM4WjgrK1RicGhoVUtOTXg1RXk3KzQxeDJtUDhP?=
 =?utf-8?B?Rm5rRXJVK0Y2aWZkK1FQVDFLUTl1K1VnQ1Q3NWt3Z25BTkhaR3dHT0ZEWUNP?=
 =?utf-8?B?Q3FLUlRadUdSQ1N5RjI1dzJBN21PTXRTL0d3SmNudzB5NlEvNVYveFJOeFBJ?=
 =?utf-8?B?bWhTY2xMbkh4Q3c4R3JLWEgwY2tCREFyeUI3WEtNRG9LVjg3NlFXU2J4Z0V3?=
 =?utf-8?B?cGo4ZWJKUlRxZHhDU0hYMldrQXFFV3NWenNoSGN2NWozOWQ4S2pDRllhR29I?=
 =?utf-8?B?KzdwVmI3TDRtRVNFNm42VVZVbERjL254N3gwZ09tb01CeGlweFNJMjVRWHdN?=
 =?utf-8?B?TE1zV0dodnFsQngxM0RQQ1Jya2cxOVNTQnkxOEtNYmVTeEE2VkNqVHJYbFRu?=
 =?utf-8?B?MVNDd2g4cHRrL1RkUE5TTVQzYTRGSk4rSmJFbEVKcE96elVmVXZ1N0V3S082?=
 =?utf-8?B?ZDBOc1VWVGgxNVhPdmFkTVdlRm4vNDd0d2NnenBWNCtWN2V5dWxpazFaS2Er?=
 =?utf-8?B?bFdoaVhVL1J1YUt3T0xleTBBMVlZR1J3S1MyYXBJZmxDTmw5YnhtTkQzR1Js?=
 =?utf-8?B?RVJJQXA5ZTRTNjFNcm5HV3ovbjlwLzFGbzFDOXl4bStHdW1RSDRlZVhPRkJJ?=
 =?utf-8?B?dU1BeDhNeThtamJ5NWJaakFubTZBUTV2TTFiSkdzK3R1RE1INWRoemVwSGZz?=
 =?utf-8?B?UnpmOVQvT3d5aGFDR3Z0NndUUFkxSlVkYWo5ZzVtTWQ2SWZ6cjBCWmVqZXlZ?=
 =?utf-8?B?cnFPVDZqUnIzajNXWHVkTmMwR09wRmhYY1IxWlBNdkoycnFLcW4vTUdqamhZ?=
 =?utf-8?B?S0tmTkZXdGJWSE13Sm1hczRNOHFNVUZzK2J2Y0RQWTdhZ0RpUWt3OG8wMy9Y?=
 =?utf-8?B?UW5TODlsOG43VVVWVXZKVXpyczBqWG1LdEltWmZVQlN5TlpzSERHQXA0QUVD?=
 =?utf-8?Q?bK11XGxmAL7xm?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2073af-91d8-4287-5fa5-08d947ae9bb3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:35:51.3812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4uuvw+6LHmxZrApWqqcZV/Pp1sj7EnEqa7/taL/0aVnwZp1HOguLgZNHGvT4R8otnjK8NT8xQUUruW+SRcWgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6609
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.21 16:18, Cristian Marussi wrote:
> Hi all,
> 

Hi Cristian,

thanks for your update. Please find some additional comments in this 
reply and the following.

Best regards,

Peter

> While reworking this series starting from the work done up to V3 by
> OpenSynergy, I am keeping the original autorship and list distribution
> unchanged.
> 
> The main aim of this rework, as said, is to simplify where possible the
> SCMI VirtIO support added in V3 by adding at first some new general
> mechanisms in the SCMI Transport layer.
> 
> Indeed, after some initial small fixes, patches 05/06/07/08 add such new
> additional mechanisms to the SCMI core to ease implementation of more
> complex transports like virtio, while also addressing a few general issues
> already potentially affecting existing transports.
> 
> In terms of rework I dropped original V3 patches 05/06/07/08/12 as no more
> needed, and modified where needed the remaining original patches to take
> advantage of the above mentioned new SCMI transport features.
> 
> DT bindings patch has been ported on top of freshly YAML converted arm,scmi
> bindings.
> 
> Moreover, since V5 I dropped support for polling mode from the virtio-scmi
> transport, since it is an optional general mechanism provided by the core
> to allow transports lacking a completion IRQ to work and it seemed a
> needless addition/complication in the context of virtio transport.
> 

Just for correctness, in my understanding polling is not completely 
optional ATM. Polling would be required by scmi_cpufreq_fast_switch(). 
But that requirement might be irrelevant for now.

> Additionally, in V5 I could also simplify a bit the virtio transport
> probing sequence starting from the observation that, by the VirtIO spec,
> in fact, only one single SCMI VirtIO device can possibly exist on a system.
> 

I wouldn't say that the virtio spec restricts the # of virtio-scmi 
devices to one. But I do think the one device limitation in the kernel 
is acceptable.

> The series has been tested using an emulated fake SCMI device and also a
> proper SCP-fw stack running through QEMU vhost-users, with the SCMI stack
> compiled, in both cases, as builtin and as a loadable module, running tests
> against mocked SCMI Sensors using HWMON and IIO interfaces to check the
> functionality of notifications and sync/async commands.
> 
> Virtio-scmi support has been exercised in the following testing scenario
> on a JUNO board:
> 
>   - normal sync/async command transfers
>   - notifications
>   - concurrent delivery of correlated response and delayed responses
>   - out-of-order delivery of delayed responses before related responses
>   - unexpected delayed response delivery for sync commands
>   - late delivery of timed-out responses and delayed responses
> 
> Some basic regression testing against mailbox transport has been performed
> for commands and notifications too.
> 
> No sensible overhead in total handling time of commands and notifications
> has been observed, even though this series do indeed add a considerable
> amount of code to execute on TX path.
> More test and measurements could be needed in these regards.
> 
> This series is based on top of v5.14-rc1.
> 
> Any feedback/testing is welcome :D
> 
> Thanks,
> Cristian
> ---
> V5 --> V6:
>   - removed delegated xfers and its usage
>   - add and use *priv optional parameter in scmi_rx_callback()
>   - made .poll_done and .clear_channel ops optional
> 
> V4 --> V5:
>   - removed msg raw_payload helpers
>   - reworked msg helpers to use xfer->priv reference
>   - simplified SCMI device probe sequence (one static device)
>   - added new SCMI Kconfig layout
>   - removed SCMI virtio polling support
> 
> V3 --> V4:
>   - using new delegated xfers support and monotonically increasing tokens
>     in virtio transport
>   - ported SCMI virtio transport DT bindings to YAML format
>   - added virtio-scmi polling support
>   - added delegated xfers support
> 
> Cristian Marussi (11):
>    firmware: arm_scmi: Avoid padding in sensor message structure
>    firmware: arm_scmi: Fix max pending messages boundary check
>    firmware: arm_scmi: Add support for type handling in common functions
>    firmware: arm_scmi: Remove scmi_dump_header_dbg() helper
>    firmware: arm_scmi: Add transport optional init/exit support
>    firmware: arm_scmi: Introduce monotonically increasing tokens
>    firmware: arm_scmi: Handle concurrent and out-of-order messages
>    firmware: arm_scmi: Add priv parameter to scmi_rx_callback
>    firmware: arm_scmi: Make .clear_channel optional
>    firmware: arm_scmi: Make polling mode optional
>    firmware: arm_scmi: Make SCMI transports configurable
> 
> Igor Skalkin (4):
>    firmware: arm_scmi: Make shmem support optional for transports
>    firmware: arm_scmi: Add method to override max message number
>    dt-bindings: arm: Add virtio transport for SCMI
>    firmware: arm_scmi: Add virtio transport
> 
> Peter Hilber (2):
>    firmware: arm_scmi: Add message passing abstractions for transports
>    firmware: arm_scmi: Add optional link_supplier() transport op
> 
>   .../bindings/firmware/arm,scmi.yaml           |   8 +-
>   MAINTAINERS                                   |   1 +
>   drivers/firmware/Kconfig                      |  34 +-
>   drivers/firmware/arm_scmi/Kconfig             |  97 +++
>   drivers/firmware/arm_scmi/Makefile            |   8 +-
>   drivers/firmware/arm_scmi/common.h            |  94 ++-
>   drivers/firmware/arm_scmi/driver.c            | 651 +++++++++++++++---
>   drivers/firmware/arm_scmi/mailbox.c           |   2 +-
>   drivers/firmware/arm_scmi/msg.c               | 113 +++
>   drivers/firmware/arm_scmi/sensors.c           |   6 +-
>   drivers/firmware/arm_scmi/smc.c               |   3 +-
>   drivers/firmware/arm_scmi/virtio.c            | 491 +++++++++++++
>   include/uapi/linux/virtio_ids.h               |   1 +
>   include/uapi/linux/virtio_scmi.h              |  24 +
>   14 files changed, 1389 insertions(+), 144 deletions(-)
>   create mode 100644 drivers/firmware/arm_scmi/Kconfig
>   create mode 100644 drivers/firmware/arm_scmi/msg.c
>   create mode 100644 drivers/firmware/arm_scmi/virtio.c
>   create mode 100644 include/uapi/linux/virtio_scmi.h
> 

