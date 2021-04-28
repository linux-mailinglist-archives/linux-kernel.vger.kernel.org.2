Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEB636D8DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhD1Nvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:51:39 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:34482
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230225AbhD1Nvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:51:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdpNKl7adIvKqNmsi6v3bCNomjAdBJTLiUhHteoqJm0QGItUY3aFs1rMmKDyl92gmhW9tpkqJuVaNdI1vtJ07TW2Z8CjSF7OyQyx7Zgh5XI4iSivNPOobMYvhZjq/1s7gQaQa1oR6bzTmNH80WyxcS73FfEADxW6XtNKvqXZgfGlN2/RuO/WEiik5sPBSxcwPKi3aV+WLMwDy0zFvxP3UdfewEoDikVn8DWrVKZCV7uB3GwS7OaU1oAlWaJtR0ueVjdYudL46CK3P1OqgMPgXWFDliccR+a3mucTX3BEny8GUCh9h4tLS8pR4w9kAEyei8fPDcf5Hkp6cE6qvxO+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TH7yvaA2kEWcH8FdDuJ1d/cfcQQ+fWVFSiwmisQyi5A=;
 b=MvB9CHDu/ClFHK8Pkeesdo55NjF4xX9NHwFSsv7bjsDmfOtmThxy+Tlh9DmuzHAFrvZM7wSNJP9iVvFK50G+ZYfG6fSCDjZnsI+U7ezgBHpJUmN24wCM1icl7/PCHWgOrqUjPk+E8o13tuYinVJQnjVdTaHr1tN4d6Rx1cvl0QuDc6Z2z3mDg66lnu8pCG/cknsqEo2SZhYO5aDPQ8dhRxTGpbH4LePjqDTyDeyVF5+tGQ03VzT2VUOltyhxgItc/u9nDWTq09Az0GwD0+M+SRe9peE2RF78bsu43RhqGa/xwMNdiixc9OCBTjrf/wROSWzGCwEwjejx9G1zWKteSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TH7yvaA2kEWcH8FdDuJ1d/cfcQQ+fWVFSiwmisQyi5A=;
 b=yDKekvmRJpICZ1vUrNaDHtLng6U/niueOhgKPmvrQRLBOEX6rgz0nvSGSbM6X29jBIjfReIe3IwNSnjWt7Dqk4T4Se4VDfEPEhI7YarQX1QrTvKX5EpzK396NhX9ZKnDAcNGa9B8Y7KZQ4Lky5TsmrYYD9DqZLLfrn8FHoGBaYkW+oiRTQLwPj+wtqm0BRVq6OXJmpz+G5aOFNyy0/ohDCw3GfgRjRJUhxlHyPWzPicf8pF0kzu1WLghkDqoaBa1GJZt3bYKsLyGmSWwAi8v/EZkUHTjJmX8M2TJ5qn6d3hXjGndtsZrYeeeUD8Wn2fwsYDvM/v/HMY9hZNOLX5V3g==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2361.eurprd06.prod.outlook.com (2603:10a6:3:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Wed, 28 Apr
 2021 13:50:49 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 13:50:49 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH v2 0/4] Bootcount driver using NVMEM cell as backend.
Date:   Wed, 28 Apr 2021 16:50:37 +0300
Message-Id: <cover.1619617498.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.136.150.171]
X-ClientProxiedBy: HE1PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:3:64::11) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (37.136.150.171) by HE1PR0701CA0067.eurprd07.prod.outlook.com (2603:10a6:3:64::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend Transport; Wed, 28 Apr 2021 13:50:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7c16b3b-2137-4b65-4096-08d90a4ca19c
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2361:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB236151DC5F8138A8E6B4B1A685409@HE1PR0601MB2361.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtYPBHgGN5n1M1fIrQ5uoEVbPwP6Xe61kEVNPz7F6TOqv/y7BNAcJLW/A3U67NouEnZRgHY4yQhmrNE2jwAGLrsXUODT2i61aUA6VCa5znI0xqx0Qw6ZcouQeVGGMs+ov0EJOZOYO/3Uh4vtYvlZCD5+bdjAlD1J0FeHfViFNL1bRZlM5xVd3YV63XWh6hlMYCqTwj1h+9UeKWSxIWmmyEyHlJBlnXFzGBPr7GoN6kedeW/0R1nIu9+usa3iqngflehKRxI3yBYrh5UgFrNgxr3Z/uPE6Bnz/kSmh8UazBNxYS2r2oRqJoLQlV2S112Pf5OthwnB1UFZMAmW4tdt9sCz8qSH99OoGyN78DFc2lEeMWg8kbvYMd0z4X9oAygFqRlu3K2JTUZZPR99lnUB+kVQy5e6fCZvFx+DQlc1pPq+b1/K4vRp92Ea+BkqyQdQ0hhJHioHkJl9/aaW2htdBRIRDoOieSRy900Q4GmE0oos2+5afsFDI9G/bGyeXhpZp7jQfpst+PzNvDlCDUk46LI5YEZoV5kOhikKXNuWPFXrqJ8mZG5XNVMgirunbyUyGUI3BEKtlBiv+cefUy1Yl65wp2iFuwMbXUaUHRGatEzK6GQpvC8EJMEcTNIG8aoiq/OVPk2IO38AVlscNgmdWTU6CE7HX1Q5VFEcGnz5TbT21DSR0T7bXNMVtO8IfxPmGibA8+pFYm/xXlqDeSRrBURxPw9nXoPgDWwkNwI1wgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(396003)(376002)(136003)(5660300002)(2616005)(86362001)(6486002)(66556008)(26005)(2906002)(107886003)(66476007)(44832011)(8676002)(956004)(83380400001)(8936002)(4326008)(186003)(966005)(52116002)(316002)(38100700002)(66946007)(36756003)(7696005)(6666004)(16526019)(478600001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UzZ4WDVQak16VnlhTWF5VE1iVFZsMlJxN0NGWkhxYXhyeHlNT3NMeUlKMGhM?=
 =?utf-8?B?c1l1NEpHNkFFbWVCdlNmUkIyN1A5VHdzbC9oVEtMM2RVVjU4TGhYaHQ3K2Zk?=
 =?utf-8?B?aGM2M0tZVW5RdHkxbW1rQVROOEJweGl1bWsra3hFN1YrVnR4dVhGUjdMUnBF?=
 =?utf-8?B?cTNGY1lTYmwrZGtqQlk4M1RlY0dhRHNFVUlRcDgxVkVZVmVGTHBEbFVHQ3NJ?=
 =?utf-8?B?TjZsbUpGekdCWXd0aklsdWFRRndkZ1o3cnZ2Qnp1ck5HdXEwS1JOU2hIMHFI?=
 =?utf-8?B?MzNOYitqaDZ2TDlaYU9Cd1FmOEIzTDlrWlJ0Qnppa2hldzNGd0h2VGtmK21E?=
 =?utf-8?B?VFBZSld5U1dKbStuZWQzSHpqYWhqWkZXZ3l5QjYweXIrSWxnV3NMV2cwUVJN?=
 =?utf-8?B?MFlsQ0ovNXQwTVdna0lNZ0NiOWdnWm5jSnVXdzNTajhldGYyUXR4aTBzSUhr?=
 =?utf-8?B?T3ltM0poZ2NyamJ6bHdic2lOVEd5eXYyempsTmxmZFBtT1MzTlFJaS84K2FK?=
 =?utf-8?B?NHRtUHcwVitVZGlaWUsrdThoY3hQeGIwdnBnUytHYU1SZGtxeVJ0RUdFU2ly?=
 =?utf-8?B?ZTRQbmFjTkhuQkZXLyttTnZ3SENUazY0UmhmZDBhc2tPZ205ckhjSXFWK2lW?=
 =?utf-8?B?RWs1WXA5QnRXdElrcmYrWndsQ29mUEVPUWxNbG9oWjYvSmFVQTkvd1hjNFMz?=
 =?utf-8?B?em4rOGhKazU1c0VTVDhEWmZzUEZlQnVPcVpFY2YyTFNaeVlRTE1yb1BEejhy?=
 =?utf-8?B?WGpzc2NQRnRydi84YWZrcTJGQkJRbExxanR1dStZSmhxek83c2FrUlkvRTRi?=
 =?utf-8?B?YUxSVkU3eDRBeXNpOGlxYkdDV3VpOVBlZ3dBT1VBem9iZFBTYTZ3QS81VGVs?=
 =?utf-8?B?WDFZMG1idzIvVXN5NXlHRytnWnBodTA1alRNS1BnS3JwdG1NaUNaSzVTb1Fa?=
 =?utf-8?B?eHBMTStVbUFLeHlINHJ2blFKM3gwZFJLZWM3Q3ltWkl3RFZNTll0djl5R1dr?=
 =?utf-8?B?Mno3VkZPTm1lTkVUQ1hRcW9PclM1VkZXSytqdmlRK1p4VmNDeFBZL0phc0M3?=
 =?utf-8?B?VTZ5bGxlTzlVL2hsTEFwKzhuWDdtOWU3ZVNkZE9pcWM5MFN5RVpoVGlEL2RR?=
 =?utf-8?B?NGZxeTlCSUNmUWY2bGpib2hyaGJtUXduOSttRFFVa1ROTnRjMVpMY2NTL3h5?=
 =?utf-8?B?Qnp0WGI3MXBsQ2x4QkxSUmJtQU5FZ3ovL1d4SlFJYzljWFlqWVlBeFM1ZFc4?=
 =?utf-8?B?R3U4YUtZT1ZPZFN5dlo3NHg1WU83Zm9oWEhabHNNUVNIdU5rVUdEdEtQRDBZ?=
 =?utf-8?B?aHBPajllMHhzcGx2bmRNVVhXdng5aTFZK0UxWWp3dStTOHpKOEpjdzVwTnV1?=
 =?utf-8?B?WXhuVUp6cjdvUkJnb1lRRGpWRTZyU0x6R252a1QzRkdHSHlycFVRMXFGMDla?=
 =?utf-8?B?Rm9KZ1lvdHZlQlJrcEV1UkhEQ1cvdzdLSCsrcTJoamorSVNueDRiMG0yZTk1?=
 =?utf-8?B?TE5mdXI5UEwwM3h1dGxLNTVaTHg5UCtmZGhiMFZJU3JJMGpBL2xyM0FhWkJk?=
 =?utf-8?B?VW13WmcxU1ZvY3lIQkVqWDFhNWFCdFFqUVRYTy84VGNKUXJRMlFJejN0ZnA3?=
 =?utf-8?B?S3YwbzhmV3BSUWsvZjRuUTlYN0FZZFhzbUJkTzRJWlVCZVM5dExUbXl6aEUy?=
 =?utf-8?B?bUp0eFQ5RGV1bStxRXNsTThKZU5yYkNsenhSYjFHeTdCUldJcEJGN1R0eVAv?=
 =?utf-8?Q?SCQLerMdMfTMKe6lmx8IvDUDNewyXbQKatstj2C?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c16b3b-2137-4b65-4096-08d90a4ca19c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 13:50:49.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0mKtrwtxnb9KFvc1F2p3xTpMYlgIsQSgNvaP+Ch5FSbLipJOxGgro07YFxCnFI5i6M7Dw80q77MdnqYYRSZ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2361
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

Changes since v1
----------------
- Fix the dt-bindings YAML document.

Nandor Han (4):
  dt-bindings: nvmem: Add bootcount-nvmem
  nvmem: bootcount: add bootcount driver
  nvmem: snvs_lpgpr: use cell stride for regmap size calculation
  nvmem: snvs_lpgpr: support two bytes NVMEM cell size

 .../bindings/nvmem/bootcount-nvmem.yaml       |  66 ++++++
 drivers/nvmem/Kconfig                         |  10 +
 drivers/nvmem/Makefile                        |   1 +
 drivers/nvmem/bootcount-nvmem.c               | 195 ++++++++++++++++++
 drivers/nvmem/snvs_lpgpr.c                    |  67 +++++-
 5 files changed, 333 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
 create mode 100644 drivers/nvmem/bootcount-nvmem.c

-- 
2.26.3

