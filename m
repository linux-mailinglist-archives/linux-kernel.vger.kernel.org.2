Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9415136EC13
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbhD2OI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:08:26 -0400
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:22880
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237419AbhD2OIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:08:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DM0Mma6aTwJ6h+asU/y9o5uf8P788SBKXYdIyuVEqqWL3437ZZDkqwz8+ejw4W2VAttrD8Y+8UlgoMi4uDAMU/231VxOCsQ5v1H0c+fgq2hzo4bmT9efx1z10dnCsBfrRNIUfnfSKRgpH4TWnmA7Q6VFGbx8/vvhHsmsTyOE18vyfftdzsPh21xN1+aIXOFBbx+V9YBDRb37+9Okpk8iCxlurQPylHAdunlE+HXtnd66ICfo9L9tSgErgQ04+uL5bzlcbnEWzzcEsZEv5kxIjHP8kKlB1bL+1GBrA23ByK1Wk/yOjC9n7AF5ndc80A9/ijsMeqWKbvGdfTd3Or8Yaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJbkIqpa/7UyK8VfxfhXVymsh4K+w+N3MIyjg6yIceM=;
 b=MoG6yY93qzTKJvCCxtyBciXdfuCFBaBhiUSIougWcjBaCeTvm/0+XNNOH9GhwPJrEVFIrzkdX7Qm4C2loqeM5RYM2Dd3ijrU/dibkge2oCW9XB8OTwK7daw+QNgS1/VoXqgXLlCEPPCK2S/iTnQPtWHwVYOD2ayte0zYfmRCRe2eZXHQNrNErwKED61Wiq5EbPIcUsRRODDRoanIbql4eJpqOW0Uh0fzXvTtAP2Ep4s09ANgyJZfY9uKqrchT7SIZDb1HmheTjhohzkOq804IFEkJ7pdLqpDxYGayHBEO30v5eVE2DmESWaZ8iUR2Yck0keYH9uHUp59bGl0hX1uBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJbkIqpa/7UyK8VfxfhXVymsh4K+w+N3MIyjg6yIceM=;
 b=A8vhcqZMIXesLCBfIoQLFv4tz+iQfr3o+V7Mf7WyT65x/uqsFZcYXmstXcGM3b+yh07Y5VdBE5bcvFr9yNSdRPsU6JURnm+wMlNcCMv09Zm2ilooMY3CYn9+00pxGLib5vr5ENTKPuiPoBHYSmBSovVlxT/5DzhziE7qN1tbuYPcSoVYWL2HN504TyxFPpC7dppEZ/Up1DBL/bMTx9mUVBGbC7rBPUvNRv3BgZDpXXlQSivwb+UxLIax2gBWb8IrpQFd+r1NZJsxq+PcsbyDceHPNYl2BylSOf+q2mjEwdo/8BMQf79n2g4ysi7QM2cOYoEYEm+stV6qqcC65Z5tPA==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2315.eurprd06.prod.outlook.com (2603:10a6:3:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 14:07:33 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 14:07:33 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH v3 0/4] Bootcount driver using NVMEM cell as backend.
Date:   Thu, 29 Apr 2021 17:07:21 +0300
Message-Id: <cover.1619704986.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [176.93.24.30]
X-ClientProxiedBy: HE1PR0902CA0016.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::26) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (176.93.24.30) by HE1PR0902CA0016.eurprd09.prod.outlook.com (2603:10a6:3:e5::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 14:07:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9babc316-88f3-4c41-4fdd-08d90b182287
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB2315AC82E3AFEC68FB166ED0855F9@HE1PR0601MB2315.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cNUDBsuJIf3o73CscdTFldFsL2qNN7mj4t5i8B16lmQwsJNmpPbFO6jRMgoxu8lNfdtKq+2CImzru4PGbU+AXzX8D/Sp4mU/Is230MdHjITha+kTTwzlzFxWOghXwF/jZRdnEixcy+IUit0nlGB1nJ6SYTiiKpWQwf2AysqqOHZDkARX9Ds6Iw+FbHJJIaT+2RPDJT2WzGUzUf/FeiLYLZgTfM4j02DkMyOEQiRPvTtVDFy/u4QbqtC5T6Nrpyd47zDppI77Vhm7Qt+OwEc+NKZiSzWUueUDVoX85/YLmaZ+bZQhi/M3ZzkfTyeqxiUWUjBGVrq9RHbuEmiPwCXWGpXhWf7o5qAvIg1lxnDM4qHLyQKULkqCFW/DvPDwS677gQOi35PsYyw25hzki6NS25aovmO2416tj5mFcELHoIKafb0pYeLWJenFyza6m2pBjodWfhlRthkJ8+8kWAgLTd/JTCYyGv2L6RngGWg51fwTU37dXBBtXF2iBpwjCHZauf69zGZm8O9sRTzbdRXZZJw2njCQHqxeMeCDjjule41RenFEcipBATzf37UyAE8VsKIonNZFA9uEvhV9Rsc1+E7I6d2aBK4/EPGAAHIyQQaiNAiiNYLvZE1oJSPCj7ZOOxlR7f+PmYLHitEz4dYLUynk2auwu50HeBHkrkP55fGFF2zpYKJeFGRPI6TtJQdQqsyRsDTtB/Y9cyOsM0K25tvbTU+e/2mDiYtdXCRqaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39850400004)(366004)(83380400001)(86362001)(6486002)(36756003)(4326008)(2906002)(956004)(38350700002)(52116002)(38100700002)(8676002)(107886003)(44832011)(7696005)(2616005)(6666004)(16526019)(26005)(5660300002)(66476007)(316002)(966005)(66946007)(186003)(66556008)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MitRaUpodzRFRDVyREcyWWZHRzNtWkd5RTN3dDNLNDRhYzNocnpMK21LRmNX?=
 =?utf-8?B?Si9jRlBUVWFEbXcvRWd6MmpIMWttVHQvYVNjWDdLc0Y2ZGNwc2NTNkNmcGN4?=
 =?utf-8?B?OUV1N1pKZXNKOGFtamdmT0owSHFqVWgreEpkMEVJZTNVbDlIWjlBbVFUSFpV?=
 =?utf-8?B?MlNkdVVQSEpRRXlJWklKMTJsZUdnZU14SGRNK0ZWaDA0d2NJN3FRbU9iMFJT?=
 =?utf-8?B?WTJYaUtpcDMyT0pNbjJYZ1BieGtSSWVxcnE1VUMwSG1rc3JCV2RkUzd2d2lh?=
 =?utf-8?B?YUREVU5HV1g5S3dBKzZqN1VJTmxwREtucmh4aUFHR3VTOHFycm9UNWZvRG80?=
 =?utf-8?B?ZE9Lc2w3QUJJZnh2aHQyb21MbWZPMlU4Y1BYV1VwRElySWtiQ2pQVVBuTk0v?=
 =?utf-8?B?U3BZZ0JOVzBRV1RyeEVCUm5NUU1iUW41OHE0TjY0NWFNRXdvSzZzNEVGS2p0?=
 =?utf-8?B?QlplRFlZWUZNM3Nnd05XL2NSWjBlaDdpVmJSQ0I2K1FHN0NGallMV2YwYWU1?=
 =?utf-8?B?cUp0b1J3ODlVRGllZGovZXd0dk0rOGwySzJJcjVkbkNBN015am5aNCtwdS9l?=
 =?utf-8?B?VmlFQ3hDRXB1R1RmbVU1ZnpiS2FiT1FvK2wyL0NJRUFuR29BdE9HYjNUbEh2?=
 =?utf-8?B?anUvc1FQR3dDcDdNeVB1NmptQnF4aXFuV29lcWZNbzY4U0RJR0lTeVhFaFo1?=
 =?utf-8?B?UTIxYmpwemRjdWlocUc2akJqS3NTWTkzZjVXTnRiYjJEWmFhK2QxVE5xalpv?=
 =?utf-8?B?ZGQ5YVU0OWo3NWFMTW1aZVBKOTlUYlBiY3RKcGt1Q3dpQlJvVCszRUd2dGNy?=
 =?utf-8?B?bzlrUHhrVXFHbFZmZU9ZVXc5NThuRmZ1U0xoRTFSMlpJekVLNTMyT3VpcS9y?=
 =?utf-8?B?cGIrLzZwaW5OdURYWjJnaFJZK2RSUU5QN2N2ZERGVUFrcGZ2N3diMU1jTTAy?=
 =?utf-8?B?Qnh5eTRScHdSUHdHOXI0aFo1dENZS3A1dTFkLzRNVGdLYjZ6SHd2M1gxYXZO?=
 =?utf-8?B?K01HL2xmTWtIVUE0bjY0U3VDdmxLeUI3cFc4UURKUjBMc3gwT1R3bEZxTU02?=
 =?utf-8?B?OStiOXE1cVh1cEYvN05oUGg1Wi83cVBzNEFzcG01WHBoOHZGMFB0N2RaWWlm?=
 =?utf-8?B?R0F4aGtMbThHVUFYYUdkUS9tREE3YlduZzJxSUJMOXNMbXh0Y21jazJtYUFk?=
 =?utf-8?B?QlhoLzNMaTV2U2ZPUmpPVElwd0tDaEhydUtsODcydkZhRGRheTU0M21Pd3hE?=
 =?utf-8?B?NTYxNVQ4Qi9zVFNDa284c3pRTktUTWdXQjFvQ0pvbTArcmp1Ri9IemlOSVVw?=
 =?utf-8?B?TmJsS3FmaXhMNjZSUktHNmFxdDF0dGg1U0ZhR3plcEczVU9wYm5ZTjZsTmhv?=
 =?utf-8?B?bmsvNHA0R3d4bklnM0dHUGFCck9acDNPdUw5Z0N0VFRtM3hWY3oyV20wNnlr?=
 =?utf-8?B?b001TGJYZExwVE01WDUxaVRnZm5CSVRwZ2V5Uy9adjg4SW94ZTZyTjdaRm9P?=
 =?utf-8?B?MDU4M05XOSt0b09RM3JQQ2M2dFZmQUFrZjFBODB3OGFSZmJ6S3o5ajRyclVP?=
 =?utf-8?B?aWVNNVNOcmUrMWdiRGFNSlpCZXZId0RwcVUrWHhSUzc5c3R4RkE0TWJQcE9V?=
 =?utf-8?B?ckJLVW84VzQ0cDFUMUpHUlJJb1NvRDBURzVqVFg5ZGJ4WTZmYy9mSWc4RWVU?=
 =?utf-8?B?L1lPL0VwaVZrQ0RUQ1lScVh0UERadFhubU1EeEpzdXd2S3gvamp6Zmd4dll6?=
 =?utf-8?Q?KF1DMFpzzxgje72JBVEVoHfq5d/YeAsudIwVmkg?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9babc316-88f3-4c41-4fdd-08d90b182287
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:07:33.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWB+DVXD4vHzYRIS+0NyJtGYTyG9hOV0wzGBUNp4K2qFmsain19UKD5clSWsTipcVXk7Os22YE+grslMDQBbWw==
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

Testing the bootcount YAML document:
1. Check the document by running the command:
`make DT_CHECKER_FLAGS=-m dt_binding_check`
2. Verify that is successful: PASS
3. Verify that no warnings are generated by bootcount related yaml file: PASS
```
...
CHECK Documentation/devicetree/bindings/nvmem/brcm,nvram.example.dt.yaml                                                                      DTC Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dt.yaml
CHECK Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dt.yaml
DTC Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.example.dt.yaml
...
```

Changes since v1
----------------
- Fix the dt-bindings YAML document.

Changes since v2
----------------
- Fix the dt-bindings YAML document warnings.


Nandor Han (4):
  dt-bindings: nvmem: Add bootcount-nvmem
  nvmem: bootcount: add bootcount driver
  nvmem: snvs_lpgpr: use cell stride for regmap size calculation
  nvmem: snvs_lpgpr: support two bytes NVMEM cell size

 .../bindings/nvmem/bootcount-nvmem.yaml       |  74 +++++++
 drivers/nvmem/Kconfig                         |  10 +
 drivers/nvmem/Makefile                        |   1 +
 drivers/nvmem/bootcount-nvmem.c               | 195 ++++++++++++++++++
 drivers/nvmem/snvs_lpgpr.c                    |  67 +++++-
 5 files changed, 341 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
 create mode 100644 drivers/nvmem/bootcount-nvmem.c

-- 
2.26.3

