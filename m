Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A70641D816
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350163AbhI3Kw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:52:28 -0400
Received: from mail-bn8nam08on2067.outbound.protection.outlook.com ([40.107.100.67]:42337
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350157AbhI3Kw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:52:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b25JIX3bPazqwae7P1w98hSwHEYGxIAEpHUM8IACX2MX1oRAYgsQrcKLI73I2HI2o85Th9i+urgT0AyR0iheWeo2NGq7gEaphBTqNX4k6cvJOCEGyIb2ia3tCEbrpEUIz9fjM1FurEAUiIol23seemxvU81OYKvOAMp4Xw4pcMy2zfbRqytATJbdYChB4KW1ONGTLj8JLxrjCysOvO3JrRKT54m5418rCJJvSB3zHgqFMb0Q61FDGrxA0BvvgKXRQQxGptpJgKaSMcTwnfALxBBcBYkQDou2cW45m7FxnzczfxLwoDU0gAWMtwYWeyddkGjizP9JrQE9m/GSe74N3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GK+QUfWvw0cYqYwmuqg+yPPv3B0AewQdmXMj9bblINA=;
 b=OiU/bSK7HFE5DY6DXw5t+3MvKN9N2nUjuUBA8keoBAdULru5MXNcJwlaJNgSIdZm/uNTNVF1hSbMJZygimSMFWFMuJGgTE2HvMBLllI9oQqILmN8wYbWsVsO9Je1/cQPt4ArjT9rPVdWd8+VCAGU9p4yWQQPRQFW21vuW4c8tiCfs7SzLquHZ9Jb9hQB42AtKVHhlgYdd1YYO/sOOMG0Pe3cU9/3hKIgyTkQ26XgAT/FwWUIcI8/JU87CRLQF2BiqDTtUcpjXLCIFJBJYIzC2QaoIW9fJffXoE+ed/AZnsbm9ryWu4f89oBR3V8HO0rbcL8XliNZCk7uRIaIX5wE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK+QUfWvw0cYqYwmuqg+yPPv3B0AewQdmXMj9bblINA=;
 b=FN2dwSTqe0QUEFxSeJ02F0Fvb1IjFIkfvbBsgoWg4gClgAJ7W1ykMj9pQhvnv1UwA1IW3hCrj7AQsLBSb1uGUxZA3wuHi72nBYq0d4v/VT5JqioQqBnEQT3sVsL06KKkdlkNV5ubHAvsgf3NrwvBdo5C/pzvF/iMu5Hr7Oa20FQ=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN8PR03MB4788.namprd03.prod.outlook.com (2603:10b6:408:98::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 10:50:41 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::19a1:1a10:ff3b:be65]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::19a1:1a10:ff3b:be65%7]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 10:50:40 +0000
Date:   Thu, 30 Sep 2021 18:50:26 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/arm64: add memory layout with 4KB pages +
 VA39-bit
Message-ID: <20210930185026.1609f12e@xhacker.debian>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::29) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
Received: from xhacker.debian (192.147.44.204) by BY5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:1d0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Thu, 30 Sep 2021 10:50:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ee76cf0-d1b8-4dab-1d16-08d9840024e2
X-MS-TrafficTypeDiagnostic: BN8PR03MB4788:
X-Microsoft-Antispam-PRVS: <BN8PR03MB47882C5724CC0D2F20BE52FBEDAA9@BN8PR03MB4788.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+Q/OCx9QYjlvzI8Glxac5ZIRkOe9M5PCGPVtvMVYlls4wudS/egYld7YEQ5c6RO8nCYIxA3538KZFeORzFrXrqgrK1x1FqnZh4GrytdL+jRz2vRhJhxYLkaMJYo2rQTUR/Vfths5X9DuYKGzIwvfLndPibpzIbBLgz+NFjsEiE7VuWdqI/qpY0RAKyaB0eL4UevsRbUvu/e+VFEaxttQ6jJsqKbvlur6Qzdw7jwIoe/4OAfb8kZfALLA95IdrWPIEhbLnXMFNYhtmWAjkgz0vZuiypphi6r+thfa3b5rgai9cKV8WDLLZYIyyPg4l9/TCFd/mqZzrphwon3oQbp2JpUYeegcxmKn4CaJZs6k0dN3mWJpMlyxCu6BSMEqkCMlXVCGbAXIOUFhHtHovjJ36Vfl6jYPQ2FYeQkcSpBGRmkMMTTdNScofKFdYnqR7bUO3h/yns8y+E21S7F5lkZMvMwX5nPhKWdvVfbI+HuV1ZbnEiGV1qD2+uwx3XBvETw3tY7bcK4wqNS98oPofZ0LqZT3Onu5O69hfF1IzrbgtfvP30FuYTYLoxgq1aACRuHh7l3/IQS7+PqxD3AluLWYL8rwN/bnWDgCb2H37cHf5DV+Mkc3pBJVSBqcFEhaeW/fHi+ipOjBFC3jv9QCZGq7yi2w2fM1bIMqi+jIxCVWMSMMqHp0M3o9ahi0gxuLfBa0Y1vBIlT+g5+wyZDaS/Jqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(956004)(2906002)(55016002)(9686003)(38350700002)(38100700002)(6666004)(86362001)(186003)(5660300002)(52116002)(1076003)(6506007)(508600001)(110136005)(26005)(4326008)(7696005)(66476007)(66946007)(8676002)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vnSUaT1kto3nIbJplDExXEpOSAyOGeopDqAEi0QvJDwjqzLTglQ3nqUybQ/T?=
 =?us-ascii?Q?6JUW+d7S6BZz4Ku11MzS8OP1iISZBgPmIrquemEmJ/1TMBSAv/W5vR5Cq1g7?=
 =?us-ascii?Q?96Gdab+Zc4/WcFscG79huo4IR7S1g3AVYuU+Ct8vapAujRAsDPAFEeaqZgcv?=
 =?us-ascii?Q?NVnbmA0lKVkIRGd14f0WRjIfTsTsqd+65lJu++f5BKPFmHCDeMLWuvRt4P+G?=
 =?us-ascii?Q?PRHUojgzKtEtJeVZ92ncc1yKi7Zlesl5FOMq2mfaMza5oUnj1+zHMsqSquMN?=
 =?us-ascii?Q?FqAWtR+q1zYdfB5ccqWHPdeXwmDKCQ/+xjaAOVL0mkk9Y/qB5ewAEqF0JQaO?=
 =?us-ascii?Q?EeiZQseimEvAPwzGvoLFvUhDbUAoAKVrV6W9LGKAJ+bQuq1K5sQ4pFtx7AAZ?=
 =?us-ascii?Q?S/KPJmgOgoIw4u+Y8Sbmm23GGPuqPubc1bUXLXO1WpqwlPTiauYjFpGEZfGl?=
 =?us-ascii?Q?2DlWsLT0HiQxOVQRgn53SbyfWkJKZAbidLMdvlxHmKJL2hP0vTyjToqQ+s99?=
 =?us-ascii?Q?NnarXHAgwrNDx/4+2bdYWLi3PLvLIAOBjCn1qeZMhdGO6wL0xDqYGf45OhJb?=
 =?us-ascii?Q?6LA8vMWJw22iOqel9a49Bjf60xCW4bpOfhfmUTTDGNqRB4omH+JbPM74isaQ?=
 =?us-ascii?Q?sQnw+e3CwvYiY1ZKEiKSW1c/EUitnUPJJFWlKCODDJjKUaFNI0De3AF7vhcJ?=
 =?us-ascii?Q?0WT1SRnWNp7qAXu8q7wYRaXtBhWr08IHE5IhZVLRZ7lVDpHzwN2yg/NbpGdi?=
 =?us-ascii?Q?c+Kiz7ZAYdv/chuccmMyHl82zBMDACjP5WisMnLzHLBXU5aIuZ6M5Gu0VKrl?=
 =?us-ascii?Q?b7YesJkma2Eu4SxqxuEocmCUHk/01OaBhR9H4udHMX/CtsGFrau3K5rbS2y7?=
 =?us-ascii?Q?5U6gwZ432/QTsvvZK9iLDSN0APprDs2Ci9W/CjVjUJcWHDv9TrXh0CygMIcF?=
 =?us-ascii?Q?b2uuU59GwZuk2ATkXvqhc6hfoV6re3T0K2kPx9f1qrTf3SijCDn5BdMpqsVI?=
 =?us-ascii?Q?/g19loROoxXZTyn+T9fH3FCOyy/Gz/NzISYFomwuPipS6R3Z57G3qQ2jPFke?=
 =?us-ascii?Q?n9wpVIGAYqRt1V7AoPfA4b/PRYz0UoodsvGRCPWLYmdnqCi7oK8fdtl+iM83?=
 =?us-ascii?Q?t1tPZcx/y3j1ooFVqOIAgEkGD2MmLUXEBQAHPiTctZjU7+hPZzTt7578nbGA?=
 =?us-ascii?Q?uDLK3hPbHoLltdJLkubJ/PZq6OkxJnq/wEQ1Jr41RysNfUQPjY1rqG5OZ7S3?=
 =?us-ascii?Q?DUVSU7kxHfK5kGfnQH0GthwcRidDgpZqUZS+izqZyR16jz6nwQx4XK5/4Y2c?=
 =?us-ascii?Q?BsJ9ue7aW5ilNrN2WqNqEUCE?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee76cf0-d1b8-4dab-1d16-08d9840024e2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 10:50:40.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMtgVtP/M2falngc3lZxIKcsDwdQl6SwNeO8wPBrrzW8JhlfqTlXGGJaxIOGlZzOgixw39P7xNB2rXvUnRFNPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4788
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 4KB pages + 3 levels (39-bit) combination is also widely used in
arm64 world, add the memory layout description for this combination.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/arm64/memory.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
index 901cd094f4ec..d1745b570f0c 100644
--- a/Documentation/arm64/memory.rst
+++ b/Documentation/arm64/memory.rst
@@ -26,6 +26,23 @@ The swapper_pg_dir address is written to TTBR1 and never written to
 TTBR0.
 
 
+AArch64 Linux memory layout with 4KB pages + 3 levels (39-bit)::
+  Start			End			Size		Use
+  -----------------------------------------------------------------------
+  0000000000000000	0000007fffffffff	 512GB		user
+  ffffff8000000000	ffffffbfffffffff	 256GB		kernel logical memory map
+ [ffffffb000000000	ffffffbfffffffff]	  64GB		[kasan shadow region]
+  ffffffc000000000	ffffffc007ffffff	 128MB		bpf jit region
+  ffffffc008000000	ffffffc00fffffff	 128MB		modules
+  ffffffc010000000	fffffffdefffffff      253440MB		vmalloc
+  fffffffdf0000000	fffffffdfdffffff	 224MB		fixed mappings (top down)
+  fffffffdfe000000	fffffffdfe7fffff	   8MB		[guard region]
+  fffffffdfe800000	fffffffdff7fffff	  16MB		PCI I/O space
+  fffffffdff800000	fffffffdffffffff	   8MB		[guard region]
+  fffffffe00000000	ffffffffefffffff	   4GB		vmemmap
+  ffffffff00000000	ffffffffffffffff	   4GB		[guard region]
+
+
 AArch64 Linux memory layout with 4KB pages + 4 levels (48-bit)::
 
   Start			End			Size		Use
-- 
2.33.0

