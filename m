Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C756B3738BF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 12:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhEEKnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 06:43:55 -0400
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:45339
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232853AbhEEKne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 06:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+XQO265O8tM29vDKqIH7hQ7SssHTvom2rPxr/bmD0xgZSB9Qko8EwfukoDJ11IhC5hIQaSBV5x768mGaLDPdLATlbGviGikRzwyN1oUVQ2F4AoJT8ElRFBD0ZaeZWVfIglJZlWIcW5huZySDaJEo6AI/Tnfis/D2iGVjIOp/wyFBUZw4so+w1/BtEl6mSYT96v9c5F1yOiWCqWtjyGnV/0JWLsEgswaPJKiJrk/rL6f8N5N3T1KUU/8+HhGtb3QsAP+vI8H2i0kghhUVWLqsLtuXerbRJ82PlC6bcCep6M9JCUP9S0ksftbmnQk8+iD3RvkTXU7vFvbubU8lUM/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlMPBYOK/SppuxohnhKWD+YNFnQfJgtMwVxkWS1wgBs=;
 b=QBeLY3BZKaMftbT/ICN7cMdDlfvhqSg+U5ziXxsswi9eR9rK38HXOXYy2VjEo5UUUCGuy0Jb5jZ+/vM1FQzKyyZ+dmBIp18iVd+a/fIchN545sA8LC25Mad91Rz13FAyirhB+u0xGbAT+Z3pULU3OdSlWfMcqU2PRXJawchqdYvwg7CAGV3LW+8V6QZF6nEN/vII+aG4vKizqwlt2SLaCmwYT5wqtGT8gkwKKwdMbKxzal/TNL1fE41XF2KHlkDD4aXyxt9p0IxERU0BGpVbYa2xPUkaSO0Gd3LYhRFMDZYRANSonTQKUSEbBmhtkWp2qLfujix/j/P5C4nu3DrjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlMPBYOK/SppuxohnhKWD+YNFnQfJgtMwVxkWS1wgBs=;
 b=xAdgmjJ8KQoIfqw9ofv3u4fFT7FTDXaavizeUVNqlUadicqCaKVqqTfgP7YMe3oHl8IXIcWczYgfeFCDWrMAl+rRDJrBUhcpTiri0MVKhGJqc5TePNhObmrOLLiOvnf7e8xb7ZOp9g9dVCn61CB8isuGiy+8ICt0N/oQfZt1xs2//JNr35Ul364Htk+Mp2iP1FudeLNG9oeIz+euxEH+JhgBniQJVdP5kLti8p7rtjqgfPlVSZdKYrA8EY3hhuFc/1lmAovT/AqhDJiVg5zgyhPwrqhu3QwVeL6zbzK5NHAWONBlU+ukYCJ8DSlxSIk5JRkrH3aIdUmltG59YkDyug==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0602MB3242.eurprd06.prod.outlook.com (2603:10a6:7:1b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Wed, 5 May
 2021 10:42:30 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::9ca0:8dd:38d7:c7d4]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::9ca0:8dd:38d7:c7d4%7]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 10:42:30 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH v4 0/4] Bootcount driver using NVMEM cell as backend.
Date:   Wed,  5 May 2021 13:42:17 +0300
Message-Id: <cover.1620211180.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [193.143.230.131]
X-ClientProxiedBy: HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33)
 To HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (193.143.230.131) by HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 10:42:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0970bff9-2e03-4435-8235-08d90fb27b5e
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3242:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0602MB324225D99CEF0F3DE713843685599@HE1PR0602MB3242.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRG54+WrNbFa8+ZkZOT7fDUQmva7PL18xGC5RbGHxjAy3rOuXYXm7Dnr1NtTLhpIfpn02TGXQN1EqCLctggV3N8/G50p8eJMuWmW4FC4Becosw0rV54DB2j89AI5H0h0Cqsar796cKS7NmNaunnvLLebERI5soLdhe5TSD/ZZoUqroercviz9MmRL797HIbTnLcox3A2Vb9wbmJDGwdPtFV4dgbZ3WpHo6/QpjTHFdVCd3YLoPh9E0wooPKhAHJIOmnIthOjv0B9kMaF+G+dZNUQaOhDGc3eIv4xVH4vCJQ1WhIsZJJqqe02utpq97cwn7GtjYDlIctILJOiOEvaQLDnSJonluhv/DSriH0qkLHG6QMlDxa0CT6LtaMLbH8fAQUtgovCxJhR4QYQgegZxM7tVMv+ynnbwTQzTazux3HjzglCuZ6R4Gl20yqpswF4D5lTPzqH8X90ZukqRcnSgoWmLdkOrWlO/smNyI7SiRyn7oVjnMvdaAQeqEnF6VgJR2XGCqVJG6Cr6M2yqiv6HzTBii3w/rN7Mm1AAcxSGVR0dRf4wR3+hY8z9eWYeIBxWhpRQDXyjsD5QtOJl0fW6ykdnKSmW1gHMNHpdcRDXwrYp+jXdR3AmEPCNrHQsfIK9TW/wOunR32BG+2c2aUgKq4HrVG0vB5ikNE6iVS1lNa+scZ/3OVqcQMaxa3y0oVULW7fOQPMrW0UhHw7Ea22ZrLVuTTnCUi32xbTJYuepaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39850400004)(136003)(6666004)(8676002)(2906002)(956004)(83380400001)(26005)(16526019)(8936002)(186003)(478600001)(107886003)(44832011)(66946007)(4326008)(6486002)(966005)(6512007)(66556008)(316002)(66476007)(5660300002)(52116002)(6506007)(38350700002)(38100700002)(86362001)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SzJ4N3B6K0gwaFhVeUc1WGdqdTlZVWZBTGVJMlppVCtMTTVzSTlVUnkyT29C?=
 =?utf-8?B?Z1VVQXIrdnEvZEFzaDFsb3VsLzE5bGlkRDlDcE1zTGp3UVdSTmxBQW4rV3FO?=
 =?utf-8?B?Zm0vdFAweXNyeERYaFpQaHVhalQzMGVCcVJJaVBrUXZyenE1YXFnNEJxK01a?=
 =?utf-8?B?MXBJZ283a2gybHRWd0dWWU1qVUZHQkxXK1pyaWlrVEFXL3JRellxZ25RMXF6?=
 =?utf-8?B?am9adHp5eWd5NGE3K0h6ZmVUV2N4MUZmdGlZRlloejV6enVrRXBSSm9zOGJo?=
 =?utf-8?B?MC9jaG9GbjZxcVprTnN0OEVEMnVSU2xMYzM5T2NYVFJZei9RSVhTTVJiNVdl?=
 =?utf-8?B?dzFYWDg2WVJpNGZKZms3WHRWWlMrMWhjejZsLzJzVjdhM0Q2eXhYN003VS9J?=
 =?utf-8?B?Mis0QnRLcVZnN25KeS9BYTNFMmVwMjNLbklFQ1hoQXZhSlI1V0dURUFGUmx1?=
 =?utf-8?B?Z3NadWR3MnhJSFlneUt5cjY2cy92eDZtenBTdTVlZmhYVFFTNWF1dVc2eHJG?=
 =?utf-8?B?dEswYURlWTlzUVc4cytiSjd6Q0tSVWdaMWFNTmVqY1NtVGowUTMzTWpES3ds?=
 =?utf-8?B?eEVsVGg5VXk4MURPaCtmZ3A1eGlKSmZTMVlGWXlDM0F5VmMyMEpNbXF3bE96?=
 =?utf-8?B?bEJac1RlTGQ1MUVqR1FrcnVaZ1FWai9QQlU1M1o3Rnp4c0lCSzVKb01hZzZQ?=
 =?utf-8?B?ZnMrQWJmc0xjcEp6UkU3MHJXSThjc1J1d3dDd3VIL05Kc1Bvb3Y2M2lvZThR?=
 =?utf-8?B?VUJKdWxhTVBjSXFLNFJLeldBa1dDVGt2ZjRXU05ubmpWdmZZMktwRVZhalVi?=
 =?utf-8?B?T0FxMDBwOEJPNE56czlJZit2MEJyZ2lKajhCNDRYRGxNSnZ5RG1PNDU3ZGFH?=
 =?utf-8?B?RERGcjZFeFVLOGZGeklTL3NHak1UTjBYSEplVWdHVEJZVXlNckNlcjNyYlAx?=
 =?utf-8?B?WXNVSlgySE1ZMmsrQnY2Um55eWVRMno4SnlzaFFvY1B5TVNYdVprQjE0Szd4?=
 =?utf-8?B?cEVVcGEvSkx2YzJ4bzY1VU1DcndHZk9tOUlkS283T2x5bVZickZENUszVktn?=
 =?utf-8?B?cWp4M0Nud09MTXI1VCt0R3pLQ1ZiNEplMTl0L1hUU0NiSHAwckRROVcycEE1?=
 =?utf-8?B?RURmSENmYno4cDNWRTdFRnVadHAyaVIyclM0R0dnclEzbTRtZkNRSkFRYldL?=
 =?utf-8?B?N2U4elJ6TGk2WE8zb25MRUtlZi85bTBURHVMcXA0K2o2c2dPbmhlNXdBS0lq?=
 =?utf-8?B?YkRidUhmRThNd1dtaVc1MmdKK2lXaGFNalJReHpoRVpXR1hDS05Pbkl0eS96?=
 =?utf-8?B?Skp3Q2FydE81NzF2QitPd0toUitxcC9OZGNEOWdrczZNL2lTVzZ0VytnbGVz?=
 =?utf-8?B?dENyRnhJeStJZFc0Zm03N1pmVk0vWTZRZUt1SzZQYm1MVjJwdzBJS3N1QnIw?=
 =?utf-8?B?bHZvUzJqVk44N1BiQnZQOWNORFdvS2RScUVwN1ZXYmtaMVhRTWZqc0lKSDJN?=
 =?utf-8?B?ZkVLWnN6ejNIZHdSNExhTHlUU05aZzV3T3BXRnR0T0hwajhUVXo0R3dZYWdQ?=
 =?utf-8?B?N3ZHZzRsQnkxSkh6cXY1Q3FQQlJJTjdJTktEMngwUzR5b2ZjRVdVZXNiUU1u?=
 =?utf-8?B?R1AwekV5eDF3UTVvSXlXMERzTFJzR0xidVZqOGVhME10dWJ3d2JMcXhkaGl4?=
 =?utf-8?B?MEcvbm80eFdhTDlITXJ5V2NPdjhyK3NXT3FSYmZ1Uzg3ODZuSzQ5RDV2TnpE?=
 =?utf-8?Q?7Zxm+LTH+sLMYBakuI46/NGe/lrVDb6GwRw40oq?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0970bff9-2e03-4435-8235-08d90fb27b5e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 10:42:29.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3+oGYx7zWIwUESs78JUALP3J1mFTR08iwPocARRwhy8k7z7UXavkmhCizCCN0Rr5qzueKZzbtbLCVwkJ47Ekw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3242
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

Changes since v3
----------------
- Remove the dependencies from the bindings documentation
- Fix the `bootcount-magic` description from bindings documentation

Nandor Han (4):
  dt-bindings: nvmem: Add bootcount-nvmem
  nvmem: bootcount: add bootcount driver
  nvmem: snvs_lpgpr: use cell stride for regmap size calculation
  nvmem: snvs_lpgpr: support two bytes NVMEM cell size

 .../bindings/nvmem/bootcount-nvmem.yaml       |  71 +++++++
 drivers/nvmem/Kconfig                         |  10 +
 drivers/nvmem/Makefile                        |   1 +
 drivers/nvmem/bootcount-nvmem.c               | 195 ++++++++++++++++++
 drivers/nvmem/snvs_lpgpr.c                    |  67 +++++-
 5 files changed, 338 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
 create mode 100644 drivers/nvmem/bootcount-nvmem.c

-- 
2.26.3

