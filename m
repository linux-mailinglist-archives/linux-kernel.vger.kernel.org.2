Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13F3B8F03
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhGAIpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:45:32 -0400
Received: from mail-eopbgr10113.outbound.protection.outlook.com ([40.107.1.113]:22081
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235608AbhGAIpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:45:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcLzCokVj1qXMhmVHfoAliwqv0d5aHvu/StQMXqT1I3JHZNXlxrY5ZtiuDN5DmiJ3DAQ4ctKnciqoo5JUtGGp5CmGvn6u/3w79XRIp65aJ0pdZXOFQ9G+WMxiC84PqvWTqhJq7yl+UR7BygPRKtExiuTlHCpgiV35sHSLE7ol1ciCRg+gKR0VdLEl6WkW3OmXs1i6dyo/NUkRB2JsCFrVv5tWuy+FSYUeNdLIIsDj0DfWH1waW1obdbK19h19UQkkU1gTYHu11cS7z8aO36IC6rfmlS/5V1iyQy8qujzh73HZ3vM5uV+K16TOZC2DHukgFFUUNMFES/S43I8gwcN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PlbbLQMlEhSoMF5nL9QbVGS3AogZvny17ZqGWA0bkc=;
 b=DulYgAvrD02Urw+jAji2tiRy+TL4kAvWpUnHQ7f0iDvx28ISIMkbJr/PUDUA120eDKJ+aj8YfmJcsK+R9V1mw1IZeOpG1gISDYGZpgR1iPwT2aTdesJOMjGA3FHUY/r3HbSPScMG1puVgfWQHbzYXVjVYeA6AO5aeQWtdjodz2LrAT8QV6bp/Rur4HLgi9CMYh+2SuiUcz+tQn3ewtH+7NiXEC9ZVKW9M89QpbbVWOTUQFemRJubMMJp21+Zosr/i6G2X7kArB+Ohp61QhdA+trwQkiFF/ahxVLHMMhlWDeH3yVm9nzZATqu14DO1fJiXPIRZSzJAO0EqVZlp+2Xsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PlbbLQMlEhSoMF5nL9QbVGS3AogZvny17ZqGWA0bkc=;
 b=oHSl4sbQlS7hl0CBeq1+rUCdf5PRsZY7snrVHJwGqVpGPazhMQzdnU3IQsmf9i8L2W7WCoEBQikrhMJFwn5NwvP7FuYh3tVhnHsFtCf0NYW1rlufPQwSVMQpLrdRS11qzTCx8GYmp0u9Xsxr5dCV3fFVejqLl3BIytqdBqqOkic=
Authentication-Results: opensynergy.com; dkim=none (message not signed)
 header.d=none;opensynergy.com; dmarc=none action=none
 header.from=opensynergy.com;
From:   Peter Hilber <peter.hilber@opensynergy.com>
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
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-7-cristian.marussi@arm.com>
Subject: Re: [PATCH v4 06/16] firmware: arm_scmi, smccc, mailbox: Make shmem
 based transports optional
Message-ID: <039f1a64-b4b6-5274-1fff-253f1dd6eac8@opensynergy.com>
Date:   Thu, 1 Jul 2021 10:42:56 +0200
In-Reply-To: <20210611165937.701-7-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR01CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::40) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b96d4329-c75e-4946-bdba-08d93c6c3a1c
X-MS-TrafficTypeDiagnostic: AM9PR04MB8356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB835619C1F3B61AA261E2CE2E8C009@AM9PR04MB8356.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acuFEaHj75UugO6vfTul4CKadMHH6gYJEI4LgShUha2oDck7T9dyHkjqDLviyTFSMXeL7pGQ/CvVYXmZYtBNb9lVngDVeS9kGdw+2YPlJgLadvqb2B1sFQjd9kSMHvikH1EpiN+eeWee6XNmMRPWdBdlO/2AOoAZRSCiBlqWTGDHWi68+/qqOaOD03t8e87cNDzxTDdokanUjkCDzNfi2c0so095KPAXkZ30ZPDiQyLcwaZpGIfTYJgVrTIpj0rMZzsahqjkCGoFPJ2HNoTGzDewdrKeS7mceXaWibuxXMVRRBadyvwl7uIbFhk2HnzPDkhpMyevNGny6Hh5nwjOwgxjEscBwaldTuaQVkew7fUJgCMW+6PcBFVr6Lsc2nKe5ev1m3VYV/tcf2OEoHH1/F9g6O8erlaAk17TK2LKg0BkTq8HQy8ncG6ax9e46gwz3BynDpfSilNbTARJtrCoT1Xd6OBk7w1PlCw2ShllL6VKZtVBQiSrLjn2l/yVo8hGHVsz1SOsmE2p87CWNSl2YKIULFL3RCYL9ufaXVbGr3TWkS1qU9aUTcGb1lZQc2iW8KfJ8cdra9Mn+yroy+UQow9WlpUkj1Vi8J3ivNjNoLPk2IFqB6ivkZKKPPFL1D4rITQVNXRVJI5Z17bpUIry5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(346002)(376002)(396003)(136003)(186003)(8676002)(4326008)(38100700002)(5660300002)(66476007)(66946007)(2616005)(8936002)(316002)(31696002)(66556008)(107886003)(42186006)(44832011)(15650500001)(53546011)(7416002)(83380400001)(478600001)(36756003)(31686004)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTNsdTcvVmFCSkxJOFF5b2ZVYTZPelByMFdCWVo5WDdMNGczL2dUY1RkN0tY?=
 =?utf-8?B?T0xQd2RBRUt6QmYydlllQXJtTlhVeGg3MHZQVVZ5anE0N08wS09SVXEwanVO?=
 =?utf-8?B?WGpxTlJoYldMQUFmbU5UUTV4RU12TW0rVXFabXZQYXNFTXJYeE9STmZjR0tw?=
 =?utf-8?B?Q3JLOWRHK29FbkRmcUhVZ3R1c0t0cndCMWFPU2pXeGdvTS80YzNxRUlXUXVa?=
 =?utf-8?B?ZXpPYVpRZEVXQjE5Q0JNQmtjd1dScW9PeUhFSE15eWVRL011Uk0xVWVVd3Zm?=
 =?utf-8?B?bnBEbElkUU0rZzE5RzhlbUlCcUVUQktZdWFCUlp4M2FLaElpU3J1M2V2RGQy?=
 =?utf-8?B?b0VwWS9qNDFYMlZsU1VtR2dtaGwwTkF4WUxqSVFickhEdU1mc1htcnZaSU92?=
 =?utf-8?B?dFA1UnA2THVVTHUxSkJDREZsWXI0d0kydDUrZHBOSGJTcVp5Ui9sdXRXOHk1?=
 =?utf-8?B?QUF5cEdUNXQwQkpCL2dEVHFIb3VPZWUyWFlHTjFxMUlDWWVkSDRLeEp4VU9x?=
 =?utf-8?B?MUJVNWhaSlJTT1ViN3hCaVZrUS9oTGZsZVVHazMrYjZ1N1VtSk1Tem5sWFZt?=
 =?utf-8?B?Q3d0VUcxYTVhaDRKRElUWXlMTmM2ckNsYmEwZlFxNHhlUnJKZlFHYkc1TytJ?=
 =?utf-8?B?blphbW5CU1hLWVZxVzRlUWRkRXByTWVZelY5MGxnMkxCVGxKd3VKR1ZTSUda?=
 =?utf-8?B?UW5MczE4QXI0UzBTc3RzSTJ3RStnR0ltYTE3d2RVN0hEajVoLzI5SmJkb2Fo?=
 =?utf-8?B?MytHZEl3MEZDOTUzc3IwQjZRTnd4REtad2pHY0RmSlV2S21wbVdxOEpQZ2Vt?=
 =?utf-8?B?Sk9DczVhSHRFdmI4NlBIZm9XdmMrb1U3UXVHQ3F5TEVkUEdGZmE0NG1iamxu?=
 =?utf-8?B?Snk0UXk0bUhTWHpJWEhVQmhnSVRvVUNRaWl1d2lka0l3bktNOVVxTE5BRG9E?=
 =?utf-8?B?dEZVRDVMazdyUzBlL2lKbFlGTFRMK3ZmYVdUNks3UFFiSjlkdTJ6NzRKcjlW?=
 =?utf-8?B?MWt1ZUNWcG1jN3lPRTh0SWF4ZThaQ0hvQjhwQ0tZTDdmZ2tUb3hXRTk1RGUv?=
 =?utf-8?B?U0s5VnYvdTlmb2Q0b3BBb2dzVGtLa08rZy9Ya1FoVXpCcGFqa1hKaUhQblJW?=
 =?utf-8?B?ZjQvWUYrVDNTNWdTUGkrWW9GZmpsVDIzR2VYYWYyWUdmRHdYK1JiVW1rUUlm?=
 =?utf-8?B?c2V5ZnMweXdkaUhnUmVuWVFUSTZtbTFocjRWSTFlbUNkR1J4dWlINVg4dTAx?=
 =?utf-8?B?eVBUTUJkTWFkVDE5NVFYSFlGcG9LRm5BNlZUMVZhSXEvK01vSDZNZ3J1c0Rt?=
 =?utf-8?B?UTdKOTlrY1lSR2NGem0ySFJaWWtKdktPTlJjRUZ0N0cwMjJmU2lES0Z6M3do?=
 =?utf-8?B?VVZyMUhIVWpudUE4eTY5TEF5TGlvLzJOb1IzTmUvcG5oYjhrL050NVVEcS9G?=
 =?utf-8?B?b0hwUEJtWmtLSFp1aHB1NmQ0bUVTeklhYWZ3c1kzUisvKzloelBwVmUzVk9M?=
 =?utf-8?B?Qk01VXFzeSsyOXY4WkpETktnY2E1V2J5aDc2ajkzc3dCK1hYNW9xT1N0b3Z1?=
 =?utf-8?B?RElQb3MrQldhclIybWgxZnlpVmJDSGRLNVp1QllYRnZQMG1qNitoeXVxWFBj?=
 =?utf-8?B?TDdTK2tEZTVEZGkzbEJIMWtEZEUyNFllRjdSTWt3MUxMSG13QVdrdHh1YlVL?=
 =?utf-8?B?Ymp1UVlOc2J2Z3dJa21xSlY4V0VISWE3TWVmQ09XOExtazlEclIyY0Q4WDNk?=
 =?utf-8?B?WHlMajNSSFhNcHRyZ21XT3ViWWFOUUNjakk3MGVEMkx1bU9rTEx6aGkra3Vn?=
 =?utf-8?B?NWdPcVFiS3RVZm9CUWRHQmJUWEhHVlBnU0JFUVBXTkRZU2N3L3RYVmRKYjB4?=
 =?utf-8?Q?O33UQLDWmQwdK?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96d4329-c75e-4946-bdba-08d93c6c3a1c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 08:42:58.0972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5N8y97v0E83D9YDELkpqhTvxOuK722DSLBm3M80nBF8wn2SOdHmoz1DCl5AEHq1BqHvTJbmoyOGEWYn65dR9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.21 18:59, Cristian Marussi wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> Upon adding the virtio transport in this patch series, SCMI will also
> work without shared memory based transports. Also, the mailbox transport
> may not be needed if the smc transport is used.
> 
> - Compile shmem.c only if a shmem based transport is available.
> 
> - Remove hard dependency of SCMI on mailbox.

The hard dependency has now already been removed with

   c05b07963e96 ("firmware: arm_scmi: Add SMCCC discovery dependency in")

> 
> [ Peter: Adapted patch for submission to upstream. ]
> 
> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> ---
>  drivers/firmware/Kconfig           | 8 +++++++-
>  drivers/firmware/arm_scmi/Makefile | 2 +-
>  drivers/firmware/arm_scmi/common.h | 2 ++
>  drivers/firmware/smccc/Kconfig     | 1 +
>  drivers/mailbox/Kconfig            | 1 +
>  5 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 1db738d5b301..358f895847b5 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -9,7 +9,7 @@ menu "Firmware Drivers"
>  config ARM_SCMI_PROTOCOL
>  	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
>  	depends on ARM || ARM64 || COMPILE_TEST
> -	depends on MAILBOX || HAVE_ARM_SMCCC_DISCOVERY
> +	depends on ARM_SCMI_HAVE_SHMEM
>  	help
>  	  ARM System Control and Management Interface (SCMI) protocol is a
>  	  set of operating system-independent software interfaces that are
> @@ -27,6 +27,12 @@ config ARM_SCMI_PROTOCOL
>  	  This protocol library provides interface for all the client drivers
>  	  making use of the features offered by the SCMI.
>  
> +config ARM_SCMI_HAVE_SHMEM
> +	bool
> +	help
> +	  This declares whether a shared memory based transport for SCMI is
> +	  available.
> +
>  config ARM_SCMI_POWER_DOMAIN
>  	tristate "SCMI power domain driver"
>  	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index 6a2ef63306d6..5a2d4c32e0ae 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  scmi-bus-y = bus.o
>  scmi-driver-y = driver.o notify.o
> -scmi-transport-y = shmem.o
> +scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
>  scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
>  scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
>  scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 0edc04bc434c..4666777019fa 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -375,7 +375,9 @@ struct scmi_desc {
>  	bool support_xfers_delegation;
>  };
>  
> +#ifdef CONFIG_MAILBOX
>  extern const struct scmi_desc scmi_mailbox_desc;
> +#endif
>  #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>  extern const struct scmi_desc scmi_smc_desc;
>  #endif
> diff --git a/drivers/firmware/smccc/Kconfig b/drivers/firmware/smccc/Kconfig
> index 15e7466179a6..69c4d6cabf62 100644
> --- a/drivers/firmware/smccc/Kconfig
> +++ b/drivers/firmware/smccc/Kconfig
> @@ -9,6 +9,7 @@ config HAVE_ARM_SMCCC_DISCOVERY
>  	bool
>  	depends on ARM_PSCI_FW
>  	default y
> +	select ARM_SCMI_HAVE_SHMEM
>  	help
>  	 SMCCC v1.0 lacked discoverability and hence PSCI v1.0 was updated
>  	 to add SMCCC discovery mechanism though the PSCI firmware
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 68de2c6af727..fc02c38c0739 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig MAILBOX
>  	bool "Mailbox Hardware Support"
> +	select ARM_SCMI_HAVE_SHMEM
>  	help
>  	  Mailbox is a framework to control hardware communication between
>  	  on-chip processors through queued messages and interrupt driven
> 



