Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A513957F8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhEaJV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:21:59 -0400
Received: from mail-am6eur05on2082.outbound.protection.outlook.com ([40.107.22.82]:10539
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229550AbhEaJVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:21:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go8KalCOjpNjfNBF6TeQDWAzov4pGe/NrwSeQ+UW+YG194YiDcxLdbDyLHh1txN4vrzTHcykVjA3caqVkyxQQMPSoueEjZwKJLNWK2OqBhbBSMI/IhVLr0dAAe6quDSZDi8GcTG8zabCOmi5Dmu4YJdwC0MLomtCdK5WqiOF1Pt7Q5LbG5RH+CK5FJ1ic6ljtLiab/Ih204Em6BVgQQULZl8v9cX0bPnDyCpE9kaVjTbks9/ubJ4UCrE9QYi3IFXdWw0XHxWqhoKWwzUNUiYbsgTWwNnk+CkgEMvEfHotPMihGvzuTHsOEJSZ6GZbPNFsQkXJzmGcNgb38SJ2rUblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+Nmul/Drc0OK3vSPWTmyP3fi/KBsP70qhqDv2HRrrE=;
 b=CFbkY2C92A3zrqE2LeDL+NPIVu+H/ytpQiuLUhG1qkPWsUiUhazyrRCQPzgLvmeDSsMr/I2YBayg1pMdeOUQWup/HX0rcJv5jXfeIDZqJNyaqdcRac71T1iVStC2B2Z1jVg6qSlsO4LymJjqSrk8GnH4E1CLOa9lfMADPeyxyWcb3+34RSsuvQqBPTPvwhSofW8b9rLxcd41LvaWBvzpZGvoUqOtEtFdJQ0lbsfcC/zj8nzEYM3Tyseqk1zCUr+B25wDVF7WrUkVEBWOSE37fSowGiDquTtpUnsF6YWxAXrIIwCoi1M+qyu1l0hQrwZjLecFVIXZZF7oLdZwyABLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+Nmul/Drc0OK3vSPWTmyP3fi/KBsP70qhqDv2HRrrE=;
 b=tBQPnjPKrbf0rAy503x2n/NAXwmxDNjwJlEZZWsxNwr4gMO6m0p4sK3/e/IS3uzk7nMDzIXsl5buyH4gX+0/rtp0gerVQ92L0STMtMFd7tbZjrJi4ewerGzZIFLos6nZW02G0y3PoLuIYYGDnXo87n9ftwTweli4/ByY/IVUQvk=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 09:20:08 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::508:d95f:f63b:714a%7]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 09:20:08 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 0/6] mm/sparse: a few minor fixes and improvements
Date:   Mon, 31 May 2021 17:19:02 +0800
Message-Id: <20210531091908.1738465-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To DB9PR04MB8477.eurprd04.prod.outlook.com
 (2603:10a6:10:2c3::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0157.apcprd01.prod.exchangelabs.com (2603:1096:4:28::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 09:20:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59e8b261-9d85-4871-a072-08d9241548da
X-MS-TrafficTypeDiagnostic: DU2PR04MB8599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8599B1D3F6B7A777D917F72A803F9@DU2PR04MB8599.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsiXNOlyAuy2oNuEa+D2dhoW2vv0cTCbbZX6kwhyQ0dSmdyn6IAv0iydCXz8J0AV/M4sFEQ5M5siP2Do9jtJbUBCBVh0p4Na2B0j4RiQX7Dkvmmxq6FpyipMb4GpSdJVZ4oyBQlg0BboovEvwIOTzjNkUATO9J4YmZ5UYyHpIkRFp04MZHYGZ1Y92MQ9RH692LA874yKlybZ9NKx/u4mVBxWNH454o24Cm1VIBTCgtsV2QHytowbCBljQzoPQLUo4GUjB5k3M9mrO/5cYNXAndKXEemDKIr/vBPP7Zgnh8ojh/M1AqE7JiYnpKMjhGnfvvp899f/rXf+/5vjGr+X7FcdSPSfHcKyLTLZq0vsYt9szIhPmkJC2RXlnkZ2ATStQV/o3C1/vbKsK6+WMIawAl7cby99nNLJ8ruMbIqE3XXSvE4WSRqYr7zJp0unc050jdy5XpFIE3KWWJvQO/sa5xJaOUoED+t8GdoK2G5GVhj6j/dMcQmLdxwUlxkVHw+gqr/KSf5TYJ8/6WSlHAWN+ifjTt9dZTqiZcoX0zBRsR4ZpQmzmgvFgvc0OMvhmfEY+Fup/HwzYiXQ1UcARSRmZ9xp//ez1hl7w+oyJrAKekceeYKQ+3A0rNyrtS/Spzf8+V6lcDleIR//4EkkJPmlXUdNOeKfAU3WGVwWYZ0rIviqEikB4ivK1F/6O/GJLOQ2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(478600001)(83380400001)(86362001)(6666004)(36756003)(38350700002)(38100700002)(8676002)(8936002)(4326008)(2616005)(6512007)(6506007)(5660300002)(1076003)(52116002)(16526019)(66946007)(2906002)(186003)(66476007)(66556008)(6486002)(316002)(956004)(26005)(6916009)(4744005)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fJAinI2XGndY8w4KRVCN4PHIkf/ZR6UKNdBxsczWPEJSKXAkKXSeds6dmxPK?=
 =?us-ascii?Q?NnJBv7Y9MCcQszM1Dvapivi6gsKspxjPVsR7Xc61OjG4qpHDaaDrXOtf0Urv?=
 =?us-ascii?Q?OG4N33u+2dZFrO5Ek8hjfm1IEkJu25nCDj98dAI06XLSruwp/nLihkgYinlu?=
 =?us-ascii?Q?200vgiUO3pMrkjcxiEEQaKcP0a2WMre6ozyfc5ZmGL8rBXSPhdofkDSwAq4h?=
 =?us-ascii?Q?MkkWQICuTZCqxbET4PqsEhw95vJcD93yQjfvcBWmrsTA5YhrH7oMBalJ6kk7?=
 =?us-ascii?Q?Zovlfms8e67g39/Orm87cDxSK7l3XZJDDqmqb/wTwwx9HM277tD/CvRZKh2I?=
 =?us-ascii?Q?jgib/BRzlknJkKOfYj0D05fvkxRcW6zfDaINeG1FfCac8elCJzRyHvb8u4e9?=
 =?us-ascii?Q?RuT7qVNi4IR0f1mZ38LcN8tGzSGHkuQxfRDsuGsFVBkMA8LNKLxbDKjqSZOM?=
 =?us-ascii?Q?02k/ofKqGxUBwYeLC/YYTODfEKZQnmg2GxIk7a5Q/vTpj4t7x8J8yFWpJTrN?=
 =?us-ascii?Q?8xqgpLJhycr5s9E6bEtSDW4HdfG5/R4YPb+wx5k72VQvFRU6v485m+nVMeV8?=
 =?us-ascii?Q?Y6/zmYQM1n0YdmDowDimEnP9ycILeWq+7c3uVoAtFWj7EEN6pr4GN0E1Hkmw?=
 =?us-ascii?Q?LAbWWhCUnnOE0GC5gzx/2QbKCn/yX9nPos5CFYku63x73PXumqAhq9gsctlf?=
 =?us-ascii?Q?C85nP9Cb9izdTX0dBkXWPCkla+byAbN2GKBaVKPlrop7PYRB5JK8dHSE6n76?=
 =?us-ascii?Q?VTNCUayyoshNinq5nZVbgti6jc1D+y4BgnzII9d5Yx6IGg5DmNv2+smBXxGq?=
 =?us-ascii?Q?6B5yN7u4gXazQp/Xr1tXiD/IYSDh01j1lreWQ8RtT9T2nLgvOxCr6M1jm61L?=
 =?us-ascii?Q?iBydzHms4de6Bz6B05Rc+nWgKnNuR/fZjlaV9ruefD11tQYO+pJxU+iCPguS?=
 =?us-ascii?Q?EHXqGhhOkfVKtF88/I78dOWEKhM33daiFx0ZvZEanUIthdFi1ze+RdW6DpFh?=
 =?us-ascii?Q?/5SToFXvx4q7E8Q80rU1Dhr7B2YmbA7sVxol5SxFm10KfXoJJ0IZBn1Uf2Ci?=
 =?us-ascii?Q?C8+JY/EIoZ39DFfoODC3M9hhSQqaHX9imveR+V4duNvUdGBjNtdG7IP5GwcE?=
 =?us-ascii?Q?bzVU4XPe7GWQYHxEAb+UTBDwjmbXZnHCTlYo2+avzE/TTW7vxdfbILqGIqz/?=
 =?us-ascii?Q?nd94qH+N/qaYvZQ0rPlmNO/lnPlY/dpMeMxDmauVHmhYWMbTKCfrRJPgH/a5?=
 =?us-ascii?Q?tBVKZy5VOW7rW2tuCoeCDJMYspBecv3pstdJMuUe6Rt7ZgwETOHAybfv4fwF?=
 =?us-ascii?Q?bcjwOv7NHmFOSSPGVA4oPjh3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e8b261-9d85-4871-a072-08d9241548da
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 09:20:08.8410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYr3THU2xahYa+cnZpAIEsI31wv75NCYZ1BI6JD7BbmlKERqx5ix6tTKO7gBNJjEPgub5UTxAVS6fStPxGWJJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8599
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a few minor fixes and improvements

Dong Aisheng (6):
  mm: drop SECTION_SHIFT in code comments
  mm/sparse: free section usage memory in case populate_section_memmap
    failed
  mm/sparse: move mem_sections allocation out of memory_present()
  mm: rename the global section array to mem_sections
  mm/page_alloc: improve memmap_pages dbg msg
  mm/sparse: remove one duplicated #ifdef CONFIG_SPARSEMEM_EXTREME

 include/linux/mmzone.h | 12 ++++----
 kernel/crash_core.c    |  4 +--
 mm/page_alloc.c        |  2 +-
 mm/sparse.c            | 66 ++++++++++++++++++++++--------------------
 4 files changed, 43 insertions(+), 41 deletions(-)

-- 
2.25.1

