Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E51736C0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhD0I1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:27:37 -0400
Received: from mail-db8eur05on2089.outbound.protection.outlook.com ([40.107.20.89]:21985
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230324AbhD0I1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:27:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5rB4Flx22fxhafBBU9kMN/GRcDW2XuWUKUlmQKbq48QkCFcXLI366R2UxHFiLepb7iV5i294Tp1/wAVPwNdjpJHWfcTGiSuJpTelPdpHqo3043ir+i1fwF1tnM44SqWFk6sHvGWXb4YyYdCrHtBRZz5Pvl45kLuikHEBDPJ+dLVHtUM7GwWa+xYc/Bt3QYd4uvFs1t6Szmuy7QZ9qejLu5K4V3hOqS2Rg46Lwdam0xLa7o8oet6eQeo5vGMLVS0pE+OX8v+WYMfmdHKDqhFPqwJaeN1c6olLio4+loCYSpdNOuzVKa855Lwchgg6ytQCVj94mPrYDv5tNK7ikU98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiFpmGQv6ssOxyII0dTmJ3GPv5LBSLVLvTOGyMNvaGw=;
 b=N4ifkC5A+BdGiNx9kt6RJYtFc73k8CW+sED3gEOl0cfk6D5H8Mltg5N1xC527vgQb1eJIHRk1cYtSwNlAluEemJXCqeFsGN3qfhYdcCQayU9s82oNsTl999WXhEqEi3t5YblLWbNosKV0xdGiwRGrQCiCtMFIRjtoF1Of8ZU71AmRNsAqN8Mey3z5oKkUXI5qUN2yPegF9I6662qtD006Sj9UkA8jtOFKcdIYjkx+YhIEZ0v+znGJKFQrWGnlPMIwFa6FVHzju3envFvXNZpWIORQmcNVukpM7s8U1IbfASWvfE3EHIXyIh1+z9E6sF4I5AkgzhFgrI/oLJUF4vwxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiFpmGQv6ssOxyII0dTmJ3GPv5LBSLVLvTOGyMNvaGw=;
 b=xpY4w9vqoVcXUN3wraIrPUQ2Xjwhfy7Mj3O2XHexuVf0ZlhfPK29d7X1mGLnR4XTxGrAW/y6qBnOn2uSBeeX8n8RrNUh/aKc23ojcW28B4j9yVkdzhBKFNCmhra2zP0DlVXydC/ffja1X4Golwud74Wfcsvud1/2Y1ylojkXiMcNE7l301EWRIkLDfI+I0EDU7w+JPzUhdv/w9WXXRZDpwPM3Kg02TWf2kg7kJwvlQeQdADWs3dZQX9JUq8KAa1lOa0L1GjsIHA6aOaNwZUp/9vU/ySlmk5kmhWqGbRUKqrekiXZ7b9EgRSzclHkt9tB6+79+RHWes0gGizBP6i3PQ==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2315.eurprd06.prod.outlook.com (2603:10a6:3:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Tue, 27 Apr
 2021 08:26:51 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 08:26:51 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH 0/4] Bootcount driver using NVMEM cell as backend.
Date:   Tue, 27 Apr 2021 11:26:30 +0300
Message-Id: <cover.1619511801.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.136.150.171]
X-ClientProxiedBy: HE1PR05CA0162.eurprd05.prod.outlook.com
 (2603:10a6:7:28::49) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (37.136.150.171) by HE1PR05CA0162.eurprd05.prod.outlook.com (2603:10a6:7:28::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Tue, 27 Apr 2021 08:26:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39675a23-0848-45f1-b335-08d9095634a8
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB2315C89CE70308DA9273A3CF85419@HE1PR0601MB2315.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HzQV41Svrj63/3UhCe+qd/E3LEnyn/bKPTwxvHesakH1pViHZsgu61+wxlz1oww3iyn93e/2dOTh1+N8PAWA8ZDVKlJJoRYfNMdJBCw5vqNA4Cbum5hHo5z6/uw5VDAUhbmx/ayu8dV1gF2uRt0QahEZlWFR/gK/WZVdPhkTOj8k08/twn89yxCisYaLcDKCwLJyG4cLYOqadOkQgzI7BI4mSu4qrm5COGFep29S/FNEsVPfKYfckWhc5GSQJY/6HBWE7q0sIrICZ8k5zGE/suGrUblAGaHqZ48gXxDyc4x8zWuzx0Y7lYNW7ijmlvEox1/OPYppDGBcIG345umqjDroGTxkirjl/JDLZNJpmc8Z9mfivNCO+/qVIVmYhgOe4+aSC00lj2TOWAQRKruOF8clk2iU0QGZHdcy1Rem6sK7kJReCfgu0wPyWOj/s9yssfHbFSHtDhDYRfyUajUQTmOORUO0iHkoft00soPT/YZk15B3k+8Ku5G3hfGxIyyFhC3vUet5NX9WOGkiU9DoitHilu/eoguEfgUufW4M7yi6bSShzKglAoIU70x9GY6QlFqZPyKN+2M+tHbJ1jHcZ/nqHqSCWWspjy+m4dGiHAv2jEeQgwiaRGh3rAnNxRbOg4bYCldfPCtCKswIeA9Fk5KCoxsigz5K3S62ulZ/AbuLcbNagQzeQUpicWV8So7PMlqg/UtEkpszagF6t7RBCWJQvgPyXIMSY+NvtUeoKA0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39850400004)(346002)(136003)(966005)(66556008)(66476007)(5660300002)(44832011)(478600001)(26005)(6486002)(107886003)(16526019)(186003)(6666004)(2616005)(316002)(36756003)(956004)(2906002)(4326008)(83380400001)(38350700002)(38100700002)(8676002)(8936002)(52116002)(66946007)(86362001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UFl0dFNrenJRZ2E5cDQrcTJTVjFPcWFjdEhOVVk0THJTZkROMGJ1aUdOUkgv?=
 =?utf-8?B?aER6d0I3bXVBcmh2TnI0aW1ROERCbUtIa1c2Y3pCQU5tVGJ4eDJJSk9zdzRN?=
 =?utf-8?B?TFM5SEJJTnR6Qi94U29LT0J3cXNrYTExNDNTd29xL3JtbUZBaERHNWpIZEl0?=
 =?utf-8?B?eHV2eDUxU0pWbGEvdys3bndRTGN3cEJZMUJKb2hVTmhiWXhxbXk1Si9sUSti?=
 =?utf-8?B?bUdrWVYyNXlLbzdHekFFYm8zS2dtdzFOMGFEVE12dWV2ZzJtU3VKNUE2Rkhp?=
 =?utf-8?B?M1VSMGVsUXRzdFp2UENoc0VPSmxTTWdSMlFxMitzbXAzcEdlWVpJcWxNcjR6?=
 =?utf-8?B?bDkvR25IbkYvY1ROSGJUcDRQNkpobEg2OHZIZXNNTk9Salk4YjJJMUpUNWFO?=
 =?utf-8?B?WVk5TWhFSUpnR1NGNzdkQzViUVA3S1BMKzY1T3dnUXNaQ2NOaktGOURtclFX?=
 =?utf-8?B?N2tjZWhsQWJ6eTNTNjVGdVl0Z3EzWURRS1UyaFdFenBWUVhVSnhqVWJiejhI?=
 =?utf-8?B?enFVekNFbVdMN1lTTDlFMUJ6ZXVLVVY2WE5ieUNZM1Q0RDdGNEY5TXo4MnRY?=
 =?utf-8?B?SW1lZkRiUjNZbXl6QzNITUNBczJqcDBIbUtXT000TmV2bGZlRjhqdEhtbGNM?=
 =?utf-8?B?bzJpMm5OKzVNL0RuR0FzamJPb0d0cXFZS0l6SmVmL2Y4SHRWQkJ4ZWh0RXZk?=
 =?utf-8?B?MWphdC9uU2I1aWUwQUM1NU44YytEUUJnbm1lZEtkSDFJSVF1NEJPRGM5c21G?=
 =?utf-8?B?UlFWV3dGQUVIdHRIZGl4V05oV3I5M3owQTkvWWMxb2R3VkpiOC9HNWcxRTE0?=
 =?utf-8?B?aG04KzB2UERWRTV2Vkg1WWNSY1Z0SlFBcWYzd05pbnArQXc0R3JUWTEwMTZr?=
 =?utf-8?B?L3FUaklFWmJnNUUrRUNSU0tLLzV3Y0k5ZzBJaXc2ZXFJTkMzVXYzaUhYRFBC?=
 =?utf-8?B?TWhjMlNOTHQxTVMzcy95RTYxZU9PSHF3bFk4S3VVL0Rma29nWHYrWlg5djdu?=
 =?utf-8?B?aVVFSllvaWlWQXh1VEE3TTdSMTRGZ05XZTh0V2lIUEN6QmVxSm9kMHZlRFVI?=
 =?utf-8?B?YWovLzRJLzF3THdMdHBSZVIzUElwdXRja2xZYlJhOXNTR1dSb0JlSFNybFR3?=
 =?utf-8?B?RzRyN0c5U3JWUG1UNnZLMElJRG1Xbkd5dHR2cWRuOUFCUU5CSEVuN3NWbURI?=
 =?utf-8?B?bmx3YTJha0EvOEI2THJOa1owbnpnN3NJUkZRWHp6WExkU1JRMHdlZlFiWmpx?=
 =?utf-8?B?ZE5ieWpzTXJZSEpMZjVsRmMramtIZVJCYzY0S00rWHNIeFN5aTcvaHpZTHdW?=
 =?utf-8?B?eHJZaUpwRUJaQzBzZWhidFZJWk1pb2E0ZHBQd0kwcUxnbU1yVTZHZVFCMzV0?=
 =?utf-8?B?TXl5WTZ2VGtCWUdYbTIzbVU5bDB5c2ZQRzNOb1pXMi81NDhFWDNQSzdwOXhR?=
 =?utf-8?B?bjV1Y0Y3RGtNbUpKNHFRZWVIb21GNkwvVXBWVktJaDBaVFI0RDZPN0Rjem9i?=
 =?utf-8?B?UlF3bnpEa1JidUtvWEhvOG5TT09hRHI0V3JudThwZUVXSGxzMXBzeWREK3da?=
 =?utf-8?B?NC85U1B2TTdNbCs1ZlB4dTRiTGt5ZTF0WU9jKzNaZ3ZVWEJ4eHZOUUZNVkl2?=
 =?utf-8?B?dTltM2lPcDBjbmlCZFM0UXNSMDJYQW9iRjN0VklOdXN3bGJCa05TNnBhbGk5?=
 =?utf-8?B?RTlRcGFIbkY3bEs1bGdJQjVSVzBlc2YramNaT0M0MjNsUjBFcGFpY1R5SWRC?=
 =?utf-8?Q?OMTt6s/37Tz/WdATLBp9uypN5Sw7TcdIUC5I588?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39675a23-0848-45f1-b335-08d9095634a8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 08:26:50.9671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TLuUUvO8ejkLlBLnLjMiiMpYJpOTgYBq+/ywlepEpGEORRK+ih9gvhedKcqUXrJEK5ZrnvGrxKo72+FUld7Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2315
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Description
-----------
Implement a bootcount (1) related driver that uses
NVMEM as a backend. The patchset will also update the
`snvs_lpgpr` driver to support 2 bytes NVMEM cells.

1. https://www.denx.de/wiki/view/DULG/UBootBootCountLimit

Testing
-------
Hardware: i.MX6sx evaluation board
Kernel: linux-imx-5.4.24

1. Configure the bootcount hardware in DT to use a NVMEM cell provided
by `snvs_lpgpr` driver as backend.
e.g. This will configure a 4 bytes long NVMEM cell
```
  bootcount_regs: bootcount-snvs-regs@0 {
      reg = <0x0 0x04>;
  };
```

2. Record the current NVMEM cell content:
```
~ # hexdump -C
/sys/devices/soc0/soc/2000000.aips-bus/20cc000.snvs/20cc000.snvs:snvs-lpgpr/20cc000.snvs:snvs-lpgpr0/nvmem
00000000  00 00 01 b0                                       |....|
00000004
```

3. Write the bootcount and check that is successful: PASS
```
~ # echo 1 > /sys/bus/platform/drivers/bootcount-nvmem/bootcount/value
bootcount: Write regval: 0xb0010001
~ # hexdump -C
/sys/devices/soc0/soc/2000000.aips-bus/20cc000.snvs/20cc000.snvs:snvs-lpgpr/20cc000.snvs:snvs-lpgpr0/nvmem
00000000  01 00 01 b0                                       |....|
00000004
``` 

Note: similar tests were done also for 2 bytes NVMEM cell size.

Kernel: linux-next, tag: next-20210322
1. Enable bootcount and snvs_lpgpr drivers
2. Verify that they compile succesfully: PASS
```
kernel-master> make -j2 drivers/nvmem/
  DESCEND  objtool
  CALL    scripts/atomic/check-atomics.sh
  CC      arch/x86/kernel/asm-offsets.s
  CALL    scripts/checksyscalls.sh
  CC      drivers/nvmem/core.o
  CC      drivers/nvmem/bootcount-nvmem.o
  CC      drivers/nvmem/snvs_lpgpr.o
  AR      drivers/nvmem/built-in.
```


Nandor Han (4):
  dt-bindings: nvmem: Add bootcount-nvmem
  nvmem: bootcount: add bootcount driver
  nvmem: snvs_lpgpr: use cell stride for regmap size calculation
  nvmem: snvs_lpgpr: support two bytes NVMEM cell size

 .../bindings/nvmem/bootcount-nvmem.yaml       |  72 +++++++
 drivers/nvmem/Kconfig                         |  10 +
 drivers/nvmem/Makefile                        |   1 +
 drivers/nvmem/bootcount-nvmem.c               | 195 ++++++++++++++++++
 drivers/nvmem/snvs_lpgpr.c                    |  67 +++++-
 5 files changed, 339 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
 create mode 100644 drivers/nvmem/bootcount-nvmem.c

-- 
2.26.3

