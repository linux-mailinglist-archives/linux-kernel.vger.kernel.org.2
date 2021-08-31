Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A9F3FC2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhHaG0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:26:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19614 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233406AbhHaG0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:26:53 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17V5b6Ch004368;
        Tue, 31 Aug 2021 06:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=5DNVaJf/8L6u4QMscZdhaGYs7ZfbidalGQX8dqsTCrQ=;
 b=cU2btWh9BsPA0MzwHUXtiqg4DYFaoyxMx+j/8CNJlw/26UCOWBE1hXyQnMomw10I3OQb
 GDPAQryW/LuLruVQ5gQcBW2WRoXD/mCAmiIbwnnFCVAjBNlid3sb/iBm5V0czwkmsUTC
 TWyZGK+Oz88C0haqnIuxqoLdbpcyR4nsr/QzNKEYzRgGn2YwTC8s+oRK+KDiHw2q49ns
 DtMHdgHMVlUiBdkLbdIfWgekRoB/Ry9nSP8IHPF78eGUfxvK3vscUYJH9Kyq1XIPV+S1
 OO/0f++oVRW720aNJ1ZwdMD94m6Y6KMUT4xFwTOgzQkTzWG5+StUjybVnXk9G6dRumSb Rw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=5DNVaJf/8L6u4QMscZdhaGYs7ZfbidalGQX8dqsTCrQ=;
 b=gjGbK9UA98zKcGuBolh28l5KzOw/WDIFh9AW5L+NJ1e6bojsSjAMJQAqsEzGfASVZE3Y
 b6leGTR7EUmDXlB5PbnalU4vce9AH9miqvD3yXVY6GOEIfr6er/k0WHNGYz94ODLjzjc
 VfWJYY+kUc8aoKhXgELanuoHX1dvDNZN6k7rqBQt9jv67J/B/n+L521aAw3FRqp91+Vp
 cnmlcxuT5cecHvVrGWXH4Ehju2gHRXiEzvvH9RyJ7PyUU1YgOI5agJUqhv2VGR0V3L6q
 A8dAVdVdjxm6G84qT1Q0GKmk/+FI1b0HyWbv4Ifo9HV4KjHQ0cJBtWz0/n1GbinxxWz+ Rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aseedg3ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 06:25:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17V6FaZO119024;
        Tue, 31 Aug 2021 06:25:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3020.oracle.com with ESMTP id 3aqcy4599g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 06:25:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJT41Oydk0QNFZ7FwzoPTxlCQQUV4BxUO0NqEZY3zcGBUYvGjXGeU2j/zLXbDwluwA3ilxDxHazuWmKhB5uSU29Owo8h6CSjlHTBVBR5qFvA4ZlzX0JSYs7BTNHCnZiV7ja5PXlapFxwzjGPO94648oNaW8Q0s4hbWSinmVC5fV6/IgeSs7s6ZefogBOdTxdqUUwAPGg2IAjNHNo85NS6qn+xFDtX9rmb/9DRR0XK5FeMejCu71DAjqjr1CMH8VQcanJhiwujptFsj2QURq53xcyr9qUAJjkwxxYFInCd3tMHZQ3jB5fUzUCv66ub0aZrMOsL6OxxAxyQm5D5Uwpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DNVaJf/8L6u4QMscZdhaGYs7ZfbidalGQX8dqsTCrQ=;
 b=FQ98253YM43UF6mqRhXJ4XmtqfyQId0bfdhqs0N0fr59X1dO+6qyjT/IyAQszaOoEtmXdZrhyTN3GRW4PGaC4BGt0ekfGafTzkAnFc9GVpDbx6ODY69dPFS2yfKAOAAaW3hPGFiAsW2UHoPLEteFpo3yGUKg9CmM7CxpKDanB0J2779tm6rseccQkNPJ64KPMhhoeqtD91C08q7SRwWalb7R9D8bsSIxxfB0QAteNfCii7XPxpNZTImbYrpaePfOFnXDkaTLJ7zu1MZSllxQtvTdTyS515l6RImtuYv+dlSW2PLU8MPEKDMqSbf7EXs8+OPP8Z3UH3iqi0yWiXLGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DNVaJf/8L6u4QMscZdhaGYs7ZfbidalGQX8dqsTCrQ=;
 b=anw0GtTCZCC8MLT57BUrNhAM7qYtJHyTcNqZ10HRaWiVKFZHbQN4bsaxQK3k+zRxlpr3JIIDuCitlUPCggO+Q+tcAGhW1HEENQAfsc0+eZj5cbeKhvsRUR7x+MCpBohfKvXFdi3BeEVYo64bhgGoha3cDYBHnKYBTnMjearroZA=
Authentication-Results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1999.namprd10.prod.outlook.com (2603:10b6:300:10a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 06:25:53 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db%8]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 06:25:53 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     cl@linux.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] mm, slub: Use stackdepot to store user information for slub object
Date:   Tue, 31 Aug 2021 16:25:37 +1000
Message-Id: <20210831062539.898293-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0009.ausprd01.prod.outlook.com
 (2603:10c6:10:31::21) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (110.33.47.182) by SYCPR01CA0009.ausprd01.prod.outlook.com (2603:10c6:10:31::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Tue, 31 Aug 2021 06:25:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79ed6b32-9495-4cba-61b0-08d96c482eb6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1999:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1999C6F4AD8857F5F8236E4FB0CC9@MWHPR10MB1999.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LpiS8/hJu2DRgkDfbZdKpvlEM8wx77mBEQ6eIy0/eixQicLRGKals0SeF7emqgkGaGBywNXtvuYdKwpzoMicf3zB501NArf79w5NEDqSmsVn6DV9YsWqWaJK21QE131qSDbw8MBK6FLUoFbgkxxfgcsOZCc7PuSPXGxhndmkxT8BD57SBcEN7Ej70oziReXQTp3mFilIdhGRQ1ekPQl+AcbEjM1SdZvpKH5fwRFfAB5IK6WwUpzfwy3bHXP8PdAek5mgyL9p1wwgHrpTvS462jMqFEJZtX+9+/BuhZlOY5knRloUHy8x1c30p4Kcju/nPvldx1rE/MhiJgHqauH/GORke17AzkggZ0bdMyvzZGvdBHB3AJl8QJ8FjyF18ceukvyZtzX0UgUlm1wARDIdffPge1EUcszMFtM1QWsDy1Aaotc3F9AZ4sPU3Nil5OaST9YWT/yjE1hZTTRFoXJh389K/5W/LorwoV8EpRBxSjcinrtKPjCojbYdKE6/Cs65V9xoYONd95UYbnTFNqvQ/5xcjm8Ih3bGgKfoluLvXyY4RE9V4Wvu7EgGXb2tPg8jIZOLac+jqViEpE+lg4RY7ErVlpcEUHBbmjqugxTuG80U3nNU92mmmeZHJpDXqLiqRhQRaa0gzgAn0txeSyFMS7t/Eq/EhzbEuLSmALm+c9aUe4zteZ9g3M8lsC95Nn3JR4I5q2wRPkOWMTi0iRFIvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(136003)(366004)(346002)(2906002)(956004)(316002)(86362001)(2616005)(5660300002)(66946007)(83380400001)(36756003)(1076003)(4326008)(6666004)(66556008)(66476007)(8936002)(6506007)(6486002)(52116002)(38100700002)(38350700002)(8676002)(26005)(186003)(478600001)(6512007)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xZDPErg8hXshvL7LDfadXqyFaDRNX10Y8HRqVBszwE+9UwJN0vtZAINQVPoY?=
 =?us-ascii?Q?WeJ/TyjsvFb+zKPFsN09Iq5UGTFGiOlux+15Rq+x5xhrCWDvMHux8R9nwVRT?=
 =?us-ascii?Q?tLZll25UqrlYqx7LgcdNvyMzg2C0UtQoNX5Z2uKiodcbiElYDgsz4D0NuRWf?=
 =?us-ascii?Q?7S7v02QwruHroZjFOLNCBLgpcT5omVZ5T7JWVlBJFkeOun619IA7D5B05fO5?=
 =?us-ascii?Q?qy59yKsH/cwSIKUQ26EfQg6kkO0oZVvxfnZV57L5cSNZcrj8xiPrRNT9pUGv?=
 =?us-ascii?Q?39bcsSbR/uxH4mVkpNRVJcTQoSKRsmS0iIq7qo8xKfGrwf7/t/9dkGH75Jvj?=
 =?us-ascii?Q?M4PdvA2bQyFqZ3K0LdcqsIZzmkxaD/WznZaM4G/t44q9ptjjZGWWw/SzxsDk?=
 =?us-ascii?Q?9WyXLzGEBfNqy3yJyeEi4tG6e2duipDcVpxa5NjVp7KqDeL6QzjW+aw6cr5O?=
 =?us-ascii?Q?j9SBSEbW9/PN/lThfu1ShNXnDVNXvl47MJQ2+elkE3J71kzrJi1ILCocuap9?=
 =?us-ascii?Q?7PziooHkXNCUqKSQYItquPsX1Lg0Mo0ujcac+v/L3qThMs93RUJ5z6efj0mU?=
 =?us-ascii?Q?TzWx4nKNYnSuEQJtObhzdSCXqHZLFmKx71uMUT+P9YhI3a+PU2MoGFg4bOX8?=
 =?us-ascii?Q?mW5lJLdsDf1U4cbEHZegpTo/kjKrX9SBY0R+Jos2fbZymXa2LEkKlf27XzbF?=
 =?us-ascii?Q?/ycIOwDJlBCVDKGZBdkSk2RG316vRjHDPd2awepBxL1I9ZiFwPTQAM6DjuUf?=
 =?us-ascii?Q?Mhjw/xPhjwelS1ZYYbszMOzHYzyHwLPHVavpfkoemYDyLclU6y+yQoEThpOy?=
 =?us-ascii?Q?UqCRchJm+BaWjocZtSLl71X1G5U3Xpp/uIujJACPmWKetI1f152ceybUmPpB?=
 =?us-ascii?Q?EGaj4LrnBkQCqFq72xPHq7JluwO2GqswgJN69dvAs5TYdn0XI2YauqOhFyLk?=
 =?us-ascii?Q?/1tGPnl4bWw8vIst0tHg7SvDjYs9V2inmgLU0ccb09atACivGM7rs3c3GUCY?=
 =?us-ascii?Q?jN4DvbrK8ldYAipd+YEVqTvOOvV8KAUBIkCHn9bUEbaCVrHA/UNqsExNYJUM?=
 =?us-ascii?Q?8v1lmw88+25ABhqth7OoS5yPwDE7KnFSNNaTjiY5e8JEelWWZXfOI7znOv2G?=
 =?us-ascii?Q?a6Uddtiarlbw9LExSDhts8TV9VP0K+aUPWhKReONfBHqvnQ2YZjxPe7zIVQR?=
 =?us-ascii?Q?72ckdM75FWzLAYPR74tMq0TDFrIi/BTLG3NUHDcDxSJOpIBva2Cspxdf6lFb?=
 =?us-ascii?Q?KcbaFsPM05sVH44xsbg9XeoQ8Vsb1FTmn8UMwYDaw17nbRLalpKeJySK/46+?=
 =?us-ascii?Q?4eSTXX2QFO9v2WIAMMXwcdjN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ed6b32-9495-4cba-61b0-08d96c482eb6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 06:25:52.9722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOxl1rBrggD18YAVuMKw7dClvecdJxbe+irIug2ot7VK2Xl787ZhTdngGfbQx50UPRB4o+GoAOGKWuM2W881xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1999
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=8 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=964 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310036
X-Proofpoint-ORIG-GUID: WzSvupPnN4kRaguejU5h3v8Q9KKussH2
X-Proofpoint-GUID: WzSvupPnN4kRaguejU5h3v8Q9KKussH2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches proposes use of STACKDEPOT to
store user (SLAB_STORE_USER) information of a slub object.
As stack traces corresponding to each unique allocation
and freeing context can be saved and retrieved from STACKDEPOT,
we can reduce size of each object (~256 bytes) and hence save
memory without losing any information.

*PATCH-1: Makes STACKDEPOT explicitly configurable, so that
it can be enabled for storing allocation/freeing stack traces.

*PATCH-2: Uses STACKDEPOT to store allocation/freeing context
for a slub object.

I have marked this series as RFC, so that I can get feedback
about this change, because this change just involves debugging
framework and does not add any value to production scenarios.

Imran Khan (2):
  lib, stackdepot: Add input prompt for STACKDEPOT option.
  mm, slub: Use stackdepot to store user information for slub object.

 lib/Kconfig |  3 +-
 mm/slub.c   | 87 +++++++++++++++++++++++++++++------------------------
 2 files changed, 50 insertions(+), 40 deletions(-)

-- 
2.25.1

