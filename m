Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E2A34AF4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhCZTXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:23:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCZTWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:22:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QJJk31101426;
        Fri, 26 Mar 2021 19:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=3m0pG/bOXFA1J91YAZ6jRS+TnDZ/RBWaYOnuWX+y4gY=;
 b=EyYpIsLB3VKIn0UFPWGqCSseLJanN51IWZ9P0AgKPCm+UqdpvPTH4w/9txzrEr9hwPlP
 iF+uz/x6j7JErqKsvdYXdDEPYy+wDyk/kqNloyL2jplmYtfF5/75ysjMw34L61W/arH7
 ChscJvvD/DtzRzUK/87HR/9sy7CUpcZArQ+51jA5gdIW0hM+KQhKuBsZeg4102cxYTY3
 Z23uEFuS97MzPU70EzTsf6+7Tm+KiI8b1UTOxaV2lpORwq/qZQTAtZHcuqJGnskhf65u
 9NrnNIqkENXYywucbfZkTkjW3a6Q5p9sh+GG1mF4meDrTmxGbvK63kdQbjU0D4ywLG4N Fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37h13ru53r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 19:22:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QJKZeQ047311;
        Fri, 26 Mar 2021 19:22:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 37h14ngjs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 19:22:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djfw3NKjdYeleswwh5f2irOwjxszUZPopFZzx755mh2pLxWpXsPZ3DyjCVI5L97OAzigEma+r/WQbYYNsJGGDo1MlaePhAVAMCcJPF+u5JNaS+3O8jNsMG72wmQ4schb61U02mUlEK+iCOroADyPU+N1WTgqrFafZomaQczRmaXJhKLuQD2a+pAQid5IbKXw7zfdmXm/oURxaw+VrECGmYrqegBv41AIzIzMiT13a/cwNU0kHe56gFfnhvM5lnKxeu6lb+vesmE8jVnMYdNPH6PHufq7xIcD2YeFlzqhyWxXwXzVqn7Kik94yDBQDN/5AEYDBpYSw/UAPsZHQ5hStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3m0pG/bOXFA1J91YAZ6jRS+TnDZ/RBWaYOnuWX+y4gY=;
 b=llHl9eIgXKUVkpfuh9+pG95j+VXztAArPiOWXmuQl297Vul1xCJxU2GYfUNnr5y+zLYKLMw3T+eyNoMVby+b48uuSXPZx5ntFkPor0Qp8mmu0o1c8yRHr7aApL0mFXUS8D1sUy41PY6wUFnQTONzq2Lrl8TmP3mkn6Uuq2EWupiICzw/4duFNgBhyzqeqYskTHbGn/2gPdYEqyPjnRBZwgPQUO4bWHIsNSJghiy5PQlnBP9fStwPtwtsLl5uzs60PMkvJE0CRIPMWQumhoZ/loKFGa/4G8zgyBvVHhEYVn9Rn+MvEuUgvhR0XY6RQMPBcZ+Fam+x30W45HNyCp0Dgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3m0pG/bOXFA1J91YAZ6jRS+TnDZ/RBWaYOnuWX+y4gY=;
 b=IN28TOi6hAokuwT4MQSJYsrdi0iaN0g9BBiJMBhImS1KkvkfRRz8Eug2GkDmPCvu4bprYj6yixCla06Cg8y/3nEkh8asXFjidmvvSQQLHajkin3yyeo+96dc/xrlxdxcPjD2u6hOPUavrGSFUs9dgN8oFQBZP9qhH1ZuUd9xI/I=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB3127.namprd10.prod.outlook.com (2603:10b6:a03:158::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 19:22:38 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3955.031; Fri, 26 Mar 2021
 19:22:38 +0000
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>, Jens Axboe <axboe@kernel.dk>,
        Tom Saeger <tom.saeger@oracle.com>
Subject: [PATCH 1/1] scripts/spelling.txt: add entries for recent discoveries
Date:   Fri, 26 Mar 2021 13:22:31 -0600
Message-Id: <14c54ee47bf0e9aebfe71e97cefd11b2b8f0332f.1616784384.git.tom.saeger@oracle.com>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8014:1041::12]
X-ClientProxiedBy: SJ0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::16) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8014:1041::12) by SJ0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:33a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Fri, 26 Mar 2021 19:22:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3daa0d33-f0e2-4f5d-f268-08d8f08c8482
X-MS-TrafficTypeDiagnostic: BYAPR10MB3127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB31271425C8955360AD242501FC619@BYAPR10MB3127.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ONJ/hUEhrkkLAPc5mQNEeQCsTJfWB+JI1qVNs49CzJMVPQlSJmJylLTMZYpE?=
 =?us-ascii?Q?jArrB6R2mgQVyfM32rY/iKQdumrGPKWgNbX0/lQcaxeJ9zE2U8DDwU56gp66?=
 =?us-ascii?Q?YDllgCp13PGubU7qRNwGKXVIOGMkWQpvGCwddcfCtTMYlqBQtZwnD0ECcgq4?=
 =?us-ascii?Q?D5Ra+p4sciljBBrLS6U9I2K3qy4Yuix0sBOzayZcu/bbbqMXwY9up1zeEWQX?=
 =?us-ascii?Q?xSemMfx/9rxii/yHKXr2r20qy3Bj0Y4qnWpoMWP7gBEuZl2/FaT7bk6RUhL8?=
 =?us-ascii?Q?owLG8GR8/I/bQxQ5mnIb8kxSI8mWwRZKXpZ2pZQHY4GoO69kmZHdMn0jqYZ7?=
 =?us-ascii?Q?IUvipMstLcv8BYonkZOAeHpkCns1vK3jPrjAEB5lwce4BtDpMm8Vu45buZip?=
 =?us-ascii?Q?udc6U4ORB2JJaDMRudpkwLk/tT+g82LMJvV9fXQttbj6NFaT5yJ7I+2dYpRo?=
 =?us-ascii?Q?pUSEpSsk0scnAghcfo0QMVqX604yeqvBWJX9NG6uZnNWm9DnVCsogmN9ojPT?=
 =?us-ascii?Q?3VS5rAnXmO0sH63eilsI4X5Tpz/kOYCtFGYZpwQlTjW7edJ8o+KgOEmCJJp8?=
 =?us-ascii?Q?g2Y3OG78HYk/8n1KZcqBU/IuR4ae0ZqOudqO5jG9Iu7KBaN2PlAC7jdIb0uu?=
 =?us-ascii?Q?+NKEcICNvTqEnbtluTVV7x36E092yWZnBn954mwG25VhzgcSDzm547yQYSfA?=
 =?us-ascii?Q?JsHEpLbCSXW9x/gLbvE+ov2MZWaHTmlj6vcENCy5Ee40ZFrSwq90ln0v4993?=
 =?us-ascii?Q?lQ+fzKUjIP5ipIx+F+xC1RSNPvNfbBE9sdUrkklC3ZYkL6IoN2iqbliI9tOh?=
 =?us-ascii?Q?PMxQ3q2/gD0S8ERqOQdMVUAWWWm/3Y9HQBHt+RmchLvtANqNRFuWHo4M5aUg?=
 =?us-ascii?Q?n6dN0/ykg4b41QcFNHma4BlxZRZc8RFbJzqsNOIG0byAoHlb97O2b7QTT8lE?=
 =?us-ascii?Q?rlp1GdvRcLHtXS6MI4v3MG6c+B5t3YBsamLIpQg+3GH5awyOnAowbLsMnr8A?=
 =?us-ascii?Q?1oYt2D/64bxSmFXX1lgQoSw7EUstkBwrrZZHtzN3escfZyNSZi60BdGeO0l1?=
 =?us-ascii?Q?1QBuattZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(136003)(366004)(39860400002)(376002)(396003)(346002)(83380400001)(38100700001)(66556008)(66476007)(2906002)(86362001)(66946007)(16526019)(186003)(110136005)(54906003)(5660300002)(107886003)(8676002)(4326008)(2616005)(6486002)(6666004)(52116002)(44832011)(6496006)(316002)(478600001)(36756003)(966005)(8936002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8FLpaHRs2loDM3jbTkuA8CeEprDWAc2qVtNQO2DV6182YR7DXzrGEQ6hFhUk?=
 =?us-ascii?Q?X8YP0mYYgWMryBJ7PZEaCJiF7DqJZKEFf/d2pi74YUbHQLVmHdVe4yHTxMz3?=
 =?us-ascii?Q?tu0jjEbEf2Gr4ToREiHmDOwhfA+LaJe/quTbG0cA+iOXTD6oEWDGad+VgiVa?=
 =?us-ascii?Q?4WJmwNrPqJJXnGLsg3kZ4ebXkwSlsahJTq6BUgH3WxyBx3LEN1l9F5ez2lzG?=
 =?us-ascii?Q?XR2PLzXBaZavi41y9xPZ0SZJ9zzQOHBd7Iltd30z68II9YW+0B2rnI6qH14Z?=
 =?us-ascii?Q?b6Q2pGIgVuQdmnhV0clAcZ9e4yo+XE72Wn1rux0wH26M5FJnPdnAcetYpnmC?=
 =?us-ascii?Q?h5AVDhrwMicXdEuwzEBPBXzFyd+WeTesDAhIo3Cqn0GjZeYNA3QjKYH9FQZH?=
 =?us-ascii?Q?xQQwNJjhLWjjo4bdUqNaR7EQtkzvsO3VB+jCV4gJxaAmbbqE8Ppm1U84K1to?=
 =?us-ascii?Q?97j8Hm/enO38kYzK6KBm7tq3SS7wh7PIQ//T8mRddgoJgBhlKCcTuweOd4ik?=
 =?us-ascii?Q?x4SEjMN5boGnowMjdIq/GAV/AXvC8DZTfBa/2WlMvJRinYth/0xkcL/yHXFj?=
 =?us-ascii?Q?aCvuZzMRnjRp/XuWLTQQA//OwJFdPcYvitTDOezj7t6PWfK0g/gq8MRsTdNk?=
 =?us-ascii?Q?HSHUUIGsC9WY+46X1Xvr/DplrEojrFDGRku1MrtoGUn1Q5LWVtflwgnmYGst?=
 =?us-ascii?Q?5mbbZ+uTtKEKxuGrLsTZcd9TSS37WXIi6Ch5iFX9OIOJp2AC1PKvM6jkcAzp?=
 =?us-ascii?Q?UvQKk3PlaqwLAEM3kM+an0tofBE/TTZXvHlWLMBOt9/zRn56QEcgVC5kd0cv?=
 =?us-ascii?Q?tK4xiWlQict/gohJHS7nMnoKoK6dmqpxtL0U1ENrjS+5whgRA3pJR2uY4MXR?=
 =?us-ascii?Q?5zRw8ogAI6rB5dxWgKBF192Zou/fYPRi5uq3SqFteYUlRX3dCZh2IxO/z5GZ?=
 =?us-ascii?Q?C00skhiKJTHL6JAXAWF0KUPbl82Co5C6YcFXx+OGiuNC9ect6JT8EtNjsrVY?=
 =?us-ascii?Q?ZIgkUTtZ6Cp4OgQx/lSZ8JDx4jkxJsVU6aeMhzdMOWKWWfb+45+q4QWQuBm9?=
 =?us-ascii?Q?hX8gUimPm+TRXg0JrSZS7HWlemp52g58lhZr7L5nSPTLi3j0GZ3+wnOJvxbg?=
 =?us-ascii?Q?lPwmhQVKK7mFb9MBgZLcpfUPD52xrcxtt52sd/YivM8ro/LNf8x3M6AwCsU/?=
 =?us-ascii?Q?08uEkdOhxiywwISnIkBSXFEG8K1IANsLNpFDK+cPES3LRfTuzOB059vkwZ2a?=
 =?us-ascii?Q?ENh08hO0o42pzJScoJk6l1Y2d1WmJ/PoGHJP02ZmWCDobIbrV4Lsd1+WJpkL?=
 =?us-ascii?Q?JJc2xTEbl5dDDlMLO7vehFh4Uj6kSpLXcEENvsPofj4kOQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3daa0d33-f0e2-4f5d-f268-08d8f08c8482
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 19:22:38.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35m5s2avyrr/iZbeikbhGBpJQZ0pkL8g+OdCpVcEeR4MvZCDGAJEy6IPv7ofn9U3c4G0E3smg9ZyVudO5Y8oSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3127
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260143
X-Proofpoint-ORIG-GUID: D0CxMpmC4XRFsQfZOBfPkSW2CiF5s62I
X-Proofpoint-GUID: D0CxMpmC4XRFsQfZOBfPkSW2CiF5s62I
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1011 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260143
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few entries for recent spelling fixes found.

Opportunistically de-dupe:
exeeds||exceeds

Link: https://lore.kernel.org/lkml/31acb3239b7ab8989db0c9951e8740050aef0205.1616727528.git.tom.saeger@oracle.com/
Link: https://lore.kernel.org/lkml/fa193b3c9e346ff3fc157b54802c29b25f79c402.1615597995.git.tom.saeger@oracle.com/
Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
---
 scripts/spelling.txt | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 2e3ba91a5072..f7a3bfd75787 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -84,6 +84,7 @@ againt||against
 agaist||against
 aggreataon||aggregation
 aggreation||aggregation
+ajust||adjust
 albumns||albums
 alegorical||allegorical
 algined||aligned
@@ -161,10 +162,13 @@ asign||assign
 asser||assert
 assertation||assertion
 assertting||asserting
+assgined||assigned
 assiged||assigned
 assigment||assignment
 assigments||assignments
 assistent||assistant
+assocaited||associated
+assocating||associating
 assocation||association
 associcated||associated
 assotiated||associated
@@ -177,9 +181,11 @@ asynchnous||asynchronous
 asynchromous||asynchronous
 asymetric||asymmetric
 asymmeric||asymmetric
+atleast||at least
 atomatically||automatically
 atomicly||atomically
 atempt||attempt
+atrributes||attributes
 attachement||attachment
 attatch||attach
 attched||attached
@@ -315,6 +321,7 @@ comminucation||communication
 commited||committed
 commiting||committing
 committ||commit
+commnunication||communication
 commoditiy||commodity
 comsume||consume
 comsumer||consumer
@@ -349,6 +356,7 @@ condtion||condition
 conected||connected
 conector||connector
 configration||configuration
+configred||configured
 configuartion||configuration
 configuation||configuration
 configued||configured
@@ -402,6 +410,7 @@ cunter||counter
 curently||currently
 cylic||cyclic
 dafault||default
+deactive||deactivate
 deafult||default
 deamon||daemon
 debouce||debounce
@@ -417,6 +426,7 @@ deffered||deferred
 defferred||deferred
 definate||definite
 definately||definitely
+definiation||definition
 defintion||definition
 defintions||definitions
 defualt||default
@@ -571,8 +581,9 @@ errror||error
 estbalishment||establishment
 etsablishment||establishment
 etsbalishment||establishment
+evalute||evaluate
+evalutes||evaluates
 evalution||evaluation
-exeeds||exceeds
 excecutable||executable
 exceded||exceeded
 exceds||exceeds
@@ -696,6 +707,7 @@ hardare||hardware
 harware||hardware
 havind||having
 heirarchically||hierarchically
+heirarchy||hierarchy
 helpfull||helpful
 heterogenous||heterogeneous
 hexdecimal||hexadecimal
@@ -796,6 +808,7 @@ interanl||internal
 interchangable||interchangeable
 interferring||interfering
 interger||integer
+intergrated||integrated
 intermittant||intermittent
 internel||internal
 interoprability||interoperability
@@ -808,6 +821,7 @@ interrup||interrupt
 interrups||interrupts
 interruptted||interrupted
 interupted||interrupted
+intiailized||initialized
 intial||initial
 intialisation||initialisation
 intialised||initialised
@@ -1091,11 +1105,14 @@ preemptable||preemptible
 prefered||preferred
 prefferably||preferably
 prefitler||prefilter
+preform||perform
 premption||preemption
 prepaired||prepared
 preperation||preparation
 preprare||prepare
 pressre||pressure
+presuambly||presumably
+previosuly||previously
 primative||primitive
 princliple||principle
 priorty||priority
@@ -1153,6 +1170,7 @@ quering||querying
 queus||queues
 randomally||randomly
 raoming||roaming
+readded||read
 reasearcher||researcher
 reasearchers||researchers
 reasearch||research
@@ -1265,6 +1283,7 @@ scarch||search
 schdule||schedule
 seach||search
 searchs||searches
+secion||section
 secquence||sequence
 secund||second
 segement||segment
@@ -1312,6 +1331,8 @@ singed||signed
 sleeped||slept
 sliped||slipped
 softwares||software
+soley||solely
+souce||source
 speach||speech
 specfic||specific
 specfield||specified
@@ -1320,7 +1341,9 @@ specifc||specific
 specifed||specified
 specificatin||specification
 specificaton||specification
+specificed||specified
 specifing||specifying
+specifiy||specify
 specifiying||specifying
 speficied||specified
 speicify||specify
@@ -1436,6 +1459,7 @@ timout||timeout
 tmis||this
 toogle||toggle
 torerable||tolerable
+traget||target
 traking||tracking
 tramsmitted||transmitted
 tramsmit||transmit
@@ -1558,6 +1582,7 @@ wiil||will
 wirte||write
 withing||within
 wnat||want
+wont||won't
 workarould||workaround
 writeing||writing
 writting||writing

base-commit: db24726bfefa68c606947a86132591568a06bfb4
-- 
2.31.0

