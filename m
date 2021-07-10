Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419F73C3461
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 13:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhGJLq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 07:46:57 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:49588 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230468AbhGJLq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 07:46:56 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16ABi6du027799;
        Sat, 10 Jul 2021 04:44:06 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-0064b401.pphosted.com with ESMTP id 39pjap8vca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Jul 2021 04:44:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8NnnuF2nQ8w8d1L8ORsGeJJNUT6HxirwWbcPvhe+PrqdnwsJBdDa23JGlT7PYu5HJPXrHT/lGq+YsNQPEHyQQhGmUCJIETjpCvEenvw5K8S/tXmVzsgp1wuqWdzt5YGxIf8saRjdiVJaIXE1uJ/3B8iqid2MrZ+D6VoA2LxXgrazqXRnfHwJVlv0rQQOLjiIYM60aMc9CCdGAgDpDlUpU4uEx/gcAigY+uxm8QL31I8+MMoqc/Vl6DYx6Krr5QrOEqal+Gz7Do6A/hqAudgUJiZIT7QQY/+b7GAFZ/L1qfLSdHGQay5ZtuCFamzt90LWSxyKjBdr48eRs0fu8JAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip9OamNf2I5rNCs1zmnoO+EZRvLc2uQZ8dvrN3k7kG8=;
 b=Mdf9g/WZbnnTIkU7rQiAiuD8E8/rFBY6e0TfA1+/kIut4m73yF+XiF+LVQ79m8kIUgTfb6O8Ao9eTqW4xocCb6gFlCrH3En6QfFpiAc+zDX/18NyjTFx/Sjp4NZiIPmvK3n/yhUn2EfNORyxsnD00xsOWArGaYNJJtYH+6HwAXoOLDgXCpPiAjoPipJPXwyZcnq8LkdU0Y9qRBY5kPJ/9oulpdJqlikxvK58xrPCtE85wJpnXhq9dVkGKvcoTuo5tyaeYcfuo0snJXQA9EjDqsRDJKX8+Bj/xDHmZCTZAf6d/aKWLIa4QqM5dTZHdaRmvNHx0A+WYbaTPhfRUG9g4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip9OamNf2I5rNCs1zmnoO+EZRvLc2uQZ8dvrN3k7kG8=;
 b=XHMZmMbLfrR3v220sr+OArVmlcpI4ra866Uf+D6rPt067RIWQC2Z2VpsC4mi/ASNwbrfDxK1Uz25pfHzQvkl6plvUP2lkr90gqXKxyqHXdpbEECnW1lwQGhYcrytLUMzg3AkLB8mRmxQwi3D9TtCqcOLzoK2+LEPMRJizDi/Swg=
Authentication-Results: techsingularity.net; dkim=none (message not signed)
 header.d=none;techsingularity.net; dmarc=none action=none
 header.from=windriver.com;
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by BL1PR11MB5221.namprd11.prod.outlook.com (2603:10b6:208:310::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Sat, 10 Jul
 2021 11:29:55 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::a140:b563:8725:5c2b]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::a140:b563:8725:5c2b%8]) with mapi id 15.20.4308.026; Sat, 10 Jul 2021
 11:29:55 +0000
From:   qiang.zhang@windriver.com
To:     mgorman@techsingularity.net, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: avoid hard lockups in __alloc_pages_bulk()
Date:   Sat, 10 Jul 2021 19:29:29 +0800
Message-Id: <20210710112929.232268-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0213.apcprd02.prod.outlook.com
 (2603:1096:201:20::25) To BL1PR11MB5478.namprd11.prod.outlook.com
 (2603:10b6:208:31d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (240e:305:7883:21a9:70b4:3c74:7e20:15a1) by HK2PR02CA0213.apcprd02.prod.outlook.com (2603:1096:201:20::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Sat, 10 Jul 2021 11:29:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 471930a8-e821-4f99-7fae-08d943960a8e
X-MS-TrafficTypeDiagnostic: BL1PR11MB5221:
X-Microsoft-Antispam-PRVS: <BL1PR11MB5221E0CD9C5D7E0CD9A5F3ACFF179@BL1PR11MB5221.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yt1MI/E6acD+6revFCaSw6/3LeA6SstvvpquItVATbFdCcTpfvAJsVVp/ayaRjU0v4OViucECNkZOlMqPViVY5dNCidj7wX0Dl0ZfKbGqUBU+RAB7PqW8LWlru3q/nTy+GxA8oDMgVimg3yO9xoYxzE5Wwz5ZVR1GK4Lua+b7hSfUkgsGitcEuWGFEUpst3VmdJBxWwF3qnq3NriWK8sNfG43lj9h655m+dshxaq4op8RQDwwWVIMQJvouaa4FCOPNzDqXSex0OpFqNDTSlYqUbQPTAvEkYgM32ql2kZjTFTlL2gaxTyHDCFWyuKYwWBhktus/sajKez5ZhFCH7qJWiZR6/Fqv7sLn8MmIkBa9rOQs4xrUs75+5izC4GjRhVp2n8GMDRfz9fzY0NzcN/W5djiFX8gSnzj0/C9sLcIZ2bvdP9lVlKmc3h2mSBKpv5dH/kXVZV+yd2jtOVArxjCc5Ftxl7Pv6n/b+shi9Mcgwt4dNeyjZnlYK4KI8FSWlYG0oqgdIHZTkimw6YLazLd//N2H6/q69rk4/dYB1f3wSHLORusR2f6wRMOY5T4E8lrJ55Z6bfkWTpdYcwQfxBtWElYV8Ljg2I16H09fW1yogCs6xigzZ8CZwNqxs76MDp63Od6JuNnr72sQcSl/hD5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39850400004)(6512007)(9686003)(6506007)(52116002)(6666004)(1076003)(66946007)(66556008)(66476007)(2906002)(6486002)(38100700002)(83380400001)(316002)(36756003)(478600001)(86362001)(186003)(8676002)(4326008)(5660300002)(4744005)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8LXMo01bXzeH3iyLU4BOL20cw7xxKVN2duGnNEK4h6CabWFw1Lr8f5FBwH47?=
 =?us-ascii?Q?dtc70NCvPPA6ihLscAZeMbPjdJ+XckGqiSG0usvmuL2osfM5evwyN6RGNwCV?=
 =?us-ascii?Q?vegLvUpSXhQz4QTVHJI/FLdiz5eARLfStgX++UsLVNfID0E2HgUPcj9cYEk1?=
 =?us-ascii?Q?6uXkH9zh70Q2wWsUq7WI6+JZyKeD300nD0qrmTv7RyvMZZCvazUKkheIS58e?=
 =?us-ascii?Q?+FJrTjRqqUi424P5HQJ4zf8/PKxr71Fkx9YHbTtvugVYmBM4xnZPstznuKdf?=
 =?us-ascii?Q?VyPf9hsBo7093+1PZUz+9IIGyQJ4zsCBB4K3zlGv9MJx9H3k+zEiJyHc/9oN?=
 =?us-ascii?Q?1YqCU92j4oMVEuM+cFeRcKH8NsStKCQiqGfffd2mHWJhfX+5muFSbHOGH5wD?=
 =?us-ascii?Q?vHdT6OBVweEA74OilgxVex9wP8WHW5pFCLnumhs5okT+C2KxYbK4uJ8tOFVg?=
 =?us-ascii?Q?SwPY4OzaUoHW/b5ZUvDJl1b6J17jhdZzGSlqQEwq+4Z6VbswmnM/w8BZPma8?=
 =?us-ascii?Q?2BSgG7GA9eVWHTbcW7X2AUrSnq3yFbrJ8fZk9nJpfeRWiQ81f4ZQ/X3nTNiv?=
 =?us-ascii?Q?r9GINfEuCj2q7ws40n+IHPWd9vs6cy4hWWSVP2bWuDkyS6reMNys2U9YxFwb?=
 =?us-ascii?Q?LhUeCHaK06mqP5VHVLxrk5ywM/E+XhMfjovxH2AvkAXsTkO3B2BHqxpAkUL3?=
 =?us-ascii?Q?aZhOXE/jsCCx8u/+04D5arD1PS9xBSimaHck/43GQOMEM7pYXloEo5rLFh7q?=
 =?us-ascii?Q?EoAvJqKkvDxmDYcdYPC0ZWHjoURCuE7AuhK/Z02IPJSWl75Db39ScMomBVCu?=
 =?us-ascii?Q?IXCUAjgO7lrvgCXQ8M5JdG0xmgHkUJeGKhJTo7qB8O/+fSs+YxayzjZ5vypu?=
 =?us-ascii?Q?jp8cHlAOB5nIfGLHPgZpNG5bvLE3vw3+W70Z6MJN1/wayhrZVwOFj93g33GD?=
 =?us-ascii?Q?6aV3TWCnPR+d0tWoVffnoQy0bv35F35u8NVsh4zy79ICeJyUvfWIOHolf8A+?=
 =?us-ascii?Q?4qp49+Vn0N7zDGYB0QVTRON+fLhBU4kHMFECh4bkNGKYAHSHBE2bsUWAhokc?=
 =?us-ascii?Q?CT3Y9QEu6B3BdEogPKQZb8RILqRSMg5hamgyEPsSiBo5akImvl54DUvlTpod?=
 =?us-ascii?Q?4SbU1PpIh+TIzjK0a7ERbVwlPqXluiKcNxculiGzSMAMxIPz7beClTRCIFZH?=
 =?us-ascii?Q?WFB4P/X17ILy6vhY8yzpvsOI2M8MoDp9+qBqenGjmCGu7OQybvB6FWSKWGfg?=
 =?us-ascii?Q?83q9xLxt3PbrWz+/0BkL9CMCmrGiFu5BeMHi7ZUlCYnE6TwTAPD00zd49rKG?=
 =?us-ascii?Q?W6zb8CdoC/PwNMNrYnKzzTwBxzfyDIjCm3Q2gJX8WF8hFnc7Tz9kd2pmj1oz?=
 =?us-ascii?Q?MtQ5BygI2owOHCd+fHDOwLC1AqYO?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471930a8-e821-4f99-7fae-08d943960a8e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2021 11:29:55.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKMnCEsvKi4LRIEnIv97oAH68+prrNHvYa8Doua6CrDdbgm5yd6uwqAV0XJGIiOCM+EpXOQoapSyTQADmUJYdLPYwM4CoO2oYIMWP/BEAxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5221
X-Proofpoint-GUID: fGDd5NQiv-0PfPVjDrRjqWw98dgDvepw
X-Proofpoint-ORIG-GUID: fGDd5NQiv-0PfPVjDrRjqWw98dgDvepw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-10_02:2021-07-09,2021-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=825 adultscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107100024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

The __alloc_pages_bulk() mainly used for batch allocation of
order-0 pages, in the case of holding pagesets.lock, if too
many pages are required, maybe trigger hard lockup watchdog.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d6e94cc8066c..1127db25507f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5315,6 +5315,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		else
 			page_array[nr_populated] = page;
 		nr_populated++;
+
+		touch_nmi_watchdog();
 	}
 
 	local_unlock_irqrestore(&pagesets.lock, flags);
-- 
2.25.1

