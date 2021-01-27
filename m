Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA1305DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhA0OH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:07:26 -0500
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:7240
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233409AbhA0OGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:06:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGa1BNY+s+TpTCjzS11rrh2kn+4wcOiKwpuC+USkfx6aZlU8534gJ6dLj6Gm5hXAGq3uwBPWUzShz6si6rsFp8xLO//gNY771LgCiIa0DLlhkLCGoSXqDyhcGjvgdZmnf9+V760r+5IVeFPl7C+njFHBRexp9oEcTF60nNkoFQegV07xkEDgp4p1B9Ke/tUwKNeC8j+gSZSnpPjkp/dkepxrnNBH2YQMPfC7PcZiEYkjOux1xgZ1pytybQn4xR42ppYiGI5EbCfZAV63NPdNJyhf5I7ldwwLAmGoUN9WkDUNRojF/3fCDQjIWxC8NIxXBr2n/73n1IrAeiIIBFT0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulMu7PJDsO3NE5LUErPsT5YIoq6KrjfNcZ7es+XxSTg=;
 b=WWTUEma4OLvRed8wNT4NuKUSZx90d86H7pflEPYC/9uEmyvG3X3ifiOWxm8eqCRDxhMSy1jaIDRT/weIRaqzyU/3E9LvvYukmE0nG2iM3y0E28SbwiRlRyOYFbpka3xXbT34rzaU0SAWjzM7F8ZXAqWx4s6NCoaZDZDzflDWcuErAlUDeO1aJeN9unfMXi2Kiw6JFiixJnsEmxdatzaus4bl+qQ6UBR4KYdOtSJVhYInl+8MsZ6YKC9VnvDORYv35KPP9YWUZlNqGNBcyPPKmVpnhNtTDiwTX4MpNPciMClAlzofKbu4jY6CHOLn00naHsCo/QPbH6fm9NuWUtru+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulMu7PJDsO3NE5LUErPsT5YIoq6KrjfNcZ7es+XxSTg=;
 b=C+MSlh1kgn5KfPQWjgG2dz+2XoUSDOwkaU5LFIQg8Q7dSXTZe9wj8C02J/6uCck7008VdOqXm+ztrPJiEY/ta8i5GHOqFcwjCpQKRSMKXGRv3Y/cBKT8Rt/NYUk2FhpPpb82XAa/Lwh8iJJfeXqdfM75C4KpvV2J/lCA9o+xoMs=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB4239.eurprd04.prod.outlook.com (2603:10a6:803:48::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 14:05:16 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::6467:fb5:1181:e8b2]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::6467:fb5:1181:e8b2%6]) with mapi id 15.20.3784.015; Wed, 27 Jan 2021
 14:05:16 +0000
Subject: Re: [PATCH 0/5] bus: fsl-mc: add userspace support
To:     Ioana Ciornei <ciorneiioana@gmail.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20210114170752.2927915-1-ciorneiioana@gmail.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <1b03352e-38c6-e21e-8838-3da97c73f312@nxp.com>
Date:   Wed, 27 Jan 2021 16:05:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210114170752.2927915-1-ciorneiioana@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [188.25.96.12]
X-ClientProxiedBy: AM3PR07CA0110.eurprd07.prod.outlook.com
 (2603:10a6:207:7::20) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.111] (188.25.96.12) by AM3PR07CA0110.eurprd07.prod.outlook.com (2603:10a6:207:7::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend Transport; Wed, 27 Jan 2021 14:05:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b14bc52-fb7e-44a1-b0cf-08d8c2cc92cf
X-MS-TrafficTypeDiagnostic: VI1PR04MB4239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB42392400DFC62DC9A9A35E98ECBB0@VI1PR04MB4239.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4mHgoJqdjXwz2RH7OxQ+opa0NDrlc1XcnDyXj6zZG9p240roqZDMjOnHWNoQh5dClm8AQ3FKEs15rZYYtzhGZJYnPGFjvb3lrvBM4aydC6Y+q879p1EI1jdcNLGnniNZ5wUaJOUtNCufFG0+N7cCzhKvUi2xE7NuDiuJ7Ixa5aRoQ1ADC8TG63VAvsWwJ8+3pmPZ+CWMDyNvymLyHAPcXoNGJBnTAqdYGQR3MyaOcObx+1EsyeO0UG9lPi09eRBplyXFjccH0+tm0WYMQhbp8Z1R1MRCNn7pWcCh/MYOHeHrWtoeCfaFmzNLWcJzgSXU5AMBWNRNwQaC8OO8eIcnt5m3TI5mDctlBxytGNPWSNgdpexbJzQ9F2feqbXl+2jrQwZE1ej8XncqrCZViLkbQdl3UnEjcgV9AHtKsSm/GZ57TZZCOLYu0KBXzwV6c6DFpvbBrmFVJDdF/RvbdI4E4SpiME87SuxxXIXYrqgeTk6iBkCeu562xaKg5ofn+2S4Ijwc9gxZQMes/SzHHgdLG8AWewC47r1ADBu2zWYGjUjxOJRO6jOkT5jEGRcGA8EFSA/AfTS4MOFKLdQ8J60OWJKxTp1YR5IdhrFfbjj9Bor49R7ERgf/Fey6qWgIyzZDvEaRBUUXzUnOasrNljCJHMWO9/whBu5J7MbSvkeZy7EpgE5hriPLvLa2xp6/V8F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(31686004)(5660300002)(31696002)(8676002)(44832011)(52116002)(4326008)(2616005)(83380400001)(53546011)(316002)(16526019)(186003)(478600001)(6486002)(2906002)(26005)(66476007)(36756003)(8936002)(66556008)(86362001)(66946007)(6666004)(966005)(956004)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MGUxTzhTdUEva2hwMHh6SGExQVJPMXhLZ0hhaUIxNW1UbHFvaXlTOXVDQzU4?=
 =?utf-8?B?dVhsMW12WEtXcjBGT2o1bGNhcGFFWDRSdTRPZjFpZXp0N3M5cjlxclNzVlVw?=
 =?utf-8?B?eWt6Q1pnYnVtR21seUhZYkJYRTE5VWo1TXpBOFNLRmNDVm1pQ2dobUNaenRV?=
 =?utf-8?B?NHBUZlVocFdRQ3R1dXcyTndlUlF4YzNhU29Rbi9pZ1orUjc2TGdXZHJtQk52?=
 =?utf-8?B?SXVmclNSa3EvUHpNckoyOFRkcFVGWUxjV1BJekdtR08rVW5pOEY4M2pPTFFo?=
 =?utf-8?B?ZndLRVcxTmNuN1VpQ2s0UWUrcFBPNWRpL2IvY05Ga1ZzMkh6cGhqOWtPNFVQ?=
 =?utf-8?B?MkIvM3FwdXZyTUNMdmpUQ2cvdFJnYWllWjJ0Tml6NUljdFViZGs2NUJ0SGRv?=
 =?utf-8?B?MnlHT000OXViNWZNOXQvaXY4cXcvRE5yOVF2NlpoQW5XeGZ3T3BVV1FNWjJs?=
 =?utf-8?B?SDBBT25MdDdpN2M4VHBIU0k5Ui9qd3FQQlN2bTZXbThRSkdFNGhwUFJyeTZv?=
 =?utf-8?B?K1pEQ2lITCtvbFR4a0I2RXdreGRVb3lZY09kZDk0MC9JVExybEU1V2FTZ3hV?=
 =?utf-8?B?V0RDUElnVm9aeEt3MW91ajl6ZEQrQldSUnNXZThQb0s1dWo2NWdXc3E4RkV2?=
 =?utf-8?B?KzZSelZlaTJkK1U1MUIxQVcrQy9LcE9VeUxBSFo5MEpoUGZoaEFONHNQdWEw?=
 =?utf-8?B?R2x5NGFzNTNHeXJwUnkxOXZOUUpwU3lmUjY5aE5mR3E5M0tFQ056V2Jkcmh1?=
 =?utf-8?B?Tm5GQWwxZ2Y0MlJzVmdJa2JUZFdVZjhXWmx0UGxpRzNQM3MwamFjTU15MTlr?=
 =?utf-8?B?M0xaNGZJd1p5ckd4MzE2cWRtbXh6MnNwekxkNGQ5L3AxcUpyR2lkYXV6Vk5j?=
 =?utf-8?B?Y3huZkVscGk5TWZhVkhJWFE0bWpwRy9qSllSWlRpSTBQU29YR0k4bWdrTlUr?=
 =?utf-8?B?VE1lVUYwdExsTGdQeUUxRnpnQVVmV0YrVEFIajNjU2pjTXV3VVFqZTdoWXpH?=
 =?utf-8?B?Qnc2NEFDQzdFaWxKUkR6VllmaWRhWmt1ck9JcHRHSkt0bjhBV0piWWhHTHBU?=
 =?utf-8?B?THZJWXErbXVZUTRKOVBYV0ZDdHZFNmVWRVEvTjBjVVN3VEpob2Z5NCtSem5u?=
 =?utf-8?B?MTlYdzRkZ2I2TjVzRXZwUXdTZHJBY0tNdWJYNDBybzk3eVVjbWhxTjRNTDhm?=
 =?utf-8?B?VE8rREJ6OFprTUQvTjZrdDZtK25uMU1MRlY1a0ZYU1pvQ3B1NUZmZTcyZ3I2?=
 =?utf-8?B?U0dlUFRwUy9VeUNHN096TkhvRjZuV1VEUEx3NHZ3dWhMUFFBR3JWZlJmcnJ1?=
 =?utf-8?B?Q0VZdTgzUTBCcnlPcEl3dnlJT1pyc0ZKV2FqZmtDczhxQTNKOFZyNExtMzlP?=
 =?utf-8?B?NFIxYnRSOGk2anU5QTNEU1RpNGlCOWhwaGxybmhvVDM4ZTVPZDNZUFM0b2FZ?=
 =?utf-8?Q?OwjUffAP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b14bc52-fb7e-44a1-b0cf-08d8c2cc92cf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 14:05:16.7115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoKnxP6anP5DWDWLievjBct+/yqL7et+hXlJv/GMVaVGjtKefljTRRuGhmyGLuNmMR4dLrDD1zN37CI924RyzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4239
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/2021 7:07 PM, Ioana Ciornei wrote:
> From: Ioana Ciornei <ioana.ciornei@nxp.com>
> 
> This patch set adds userspace support in the fsl-mc bus along with a
> rescan attribute to the root DPRC container. An earlier discussion on
> this functionality can be found at the link below. I didn't continue
> with the versioning scheme since quite some time has passed since the
> last discussion.
> https://lkml.org/lkml/2018/11/20/1162
> 
> The FSL_MC_SEND_MC_COMMAND ioctl acts as a direct passthrough to the
> Management Complex (or MC) by passing fixed-length command/response
> pairs. Keeping in mind that the MC manages DPAA2 hardware resources and
> provides and object-based abstraction for sofware drivers, the proposed
> ioctl interface enables userspace tools to do the following: 
>  - Get layout information about the available resources abstracted and
>    exported by the Management Complex firmware. This is especially
>    useful to generate a complete description of the current hardware
>    resource partitioning.
>  - Manage DPAA2 objects lifecycle (create, destroy) and establish
>    connection between different components as needed.
> 
> The ioctl interface is intended for dynamic usecases where DPAA2 objects
> need to be created on demand or destroyed so that the underlying
> hardware resources can be further repurposed. In static usecases,
> depending on the requirements, a firmware configuration file can be used
> to describe the needed DPAA2 objects, their attributes or any link
> between them.
> 
> Each command received through the ioctl interface is first checked
> against a list of accepted MC commands. Also, commands which would alter
> the hardware resource management require CAP_NET_ADMIN.  The command is
> also check so that it does not contain garbage beyond the maximum size
> expected for that command id.
> 
> Ioana Ciornei (5):
>   bus: fsl-mc: move fsl_mc_command struct in a uapi header
>   bus: fsl-mc: export mc_cmd_hdr_read_cmdid() to the fsl-mc bus
>   bus: fsl-mc: add fsl-mc userspace support
>   bus: fsl-mc: add bus rescan attribute
>   bus: fsl-mc: add autorescan sysfs
> 
>  Documentation/ABI/stable/sysfs-bus-fsl-mc     |  19 +
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  MAINTAINERS                                   |   2 +
>  drivers/bus/fsl-mc/Kconfig                    |   7 +
>  drivers/bus/fsl-mc/Makefile                   |   3 +
>  drivers/bus/fsl-mc/dprc-driver.c              |  33 +-
>  drivers/bus/fsl-mc/fsl-mc-bus.c               |  96 +++
>  drivers/bus/fsl-mc/fsl-mc-private.h           |  49 ++
>  drivers/bus/fsl-mc/fsl-mc-uapi.c              | 547 ++++++++++++++++++
>  drivers/bus/fsl-mc/mc-sys.c                   |   2 +-
>  include/linux/fsl/mc.h                        |   8 +-
>  include/uapi/linux/fsl_mc.h                   |  34 ++
>  12 files changed, 789 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/ABI/stable/sysfs-bus-fsl-mc
>  create mode 100644 drivers/bus/fsl-mc/fsl-mc-uapi.c
>  create mode 100644 include/uapi/linux/fsl_mc.h
> 

For the series:

Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu
