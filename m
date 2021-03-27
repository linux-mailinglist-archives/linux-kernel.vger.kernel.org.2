Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68E434B81F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 17:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhC0QSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 12:18:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32956 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0QRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 12:17:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12RGF4m8116712;
        Sat, 27 Mar 2021 16:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=mWMh64D0sVXRt/uJhMkfAdvYMZdLKPadq5t2lwh5VNQ=;
 b=RYrBPKPGloYTvb8utPdUaf5lg212jLRPF7SzjPADYaN/gq9s1D1X6Q6qHDJ+krFg8bGt
 aux3BkZm7NcuSPwKsZeDtLpc1hN6+Ani7A9rMl/YgXcxJd6Cj4aHVQs1edznMt6xe09w
 DuK+3a8x/rxxOcPWdwN4XIULSyUxYBxfHuNaxj4TMb/GlJEcToGvBZKWzxmOyPY9IeH1
 DOAv5FMQxO10xYiGF7b1OnjYjj0xDeH4VMiGrFYqYiKeo4SeKx2t+6hmI5XDiFyMnjBk
 uJRn94KvNKsj6Xzlm84CapvjHLrwbDlWe1FFADwWrgr85ebvyDUTmN+rIrbopKoGgsgw lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37hv4r0ngj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Mar 2021 16:17:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12RGEcxp036480;
        Sat, 27 Mar 2021 16:17:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3020.oracle.com with ESMTP id 37hvh1wenb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Mar 2021 16:17:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKmFnwlhDHg0q55+c84gJ1V+e1iNLyrrs0XWfgDsZK7IDNCO30O9S8w7ifpVjRjsBROA4ID1vAbOZRCgObPjDeD0sKpgfpQhr877zHxPMlTTYaELy2XJMhecYPhM2HPeQhgHZyQ7VFsLp1DgR+TE74QtgrcJ/1xPsUb76gxKGJSH0j9n4DICfUmE379vtBjcxQW88xIW1ekEUpCF670p1SJVj208vbGdey0AMhrpvZroEOZ1DylZo0O6pXUJfjPOT17X21PF0WspRkWXmmExOiwzuEn6ZhvrxenaB2qDEzWZDA+0k8s/K/QEkFJp2pHow4JUbKvEOxN9m7C4eYy4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWMh64D0sVXRt/uJhMkfAdvYMZdLKPadq5t2lwh5VNQ=;
 b=BaCgo0ctGH3VI6VZRrYsZZYu7SloDDCRiuEc7ybueMvBwlvQUet5dE1iZkwvL8S2g6IGJcWgMFWWp+T3aphcBxZIx+JsLTNZBoYbOBJrmETuQDpE1vYJ2hTP+dZlXT+lpm2RinAT1hvAFLu30/T7Pa2TLOFLyhbUrZOud9PrxF6qvliN1GsU82ONTueJnBQfCF5sKcIMO8iXykFEmHeNqVdjXk91+ksAgJp4xrl9GJdg7GNcOE82rxLkXHC1A38MF2I1nCUYw6weq1j+Bq3cpx6F79kOTqlwGlw7ZdlbVTfvGn0g8xX9l7S+PiUbzfEVm550QjC90plyHgrNik3clQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWMh64D0sVXRt/uJhMkfAdvYMZdLKPadq5t2lwh5VNQ=;
 b=LQNFkbF5xOlIRJur4da3q8nVQ3jPtHPbcDloTHxQsWCIACDLipCE0D/SQZfhKTtvHBr2+2jrJS3chLvcYpEH7XMyoYlRmK0hLLGEKWBLlub4NXt5vROJuTwALMxcuYXBdgH59rbzGzPWFUWXhEVJR0eFsCFk7mXmO64PN29AuYw=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB3431.namprd10.prod.outlook.com (2603:10b6:a03:86::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 27 Mar
 2021 16:17:22 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3955.033; Sat, 27 Mar 2021
 16:17:22 +0000
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Colin Ian King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>,
        Tom Saeger <tom.saeger@oracle.com>
Subject: [PATCH v2] scripts/spelling.txt: add entries for recent discoveries
Date:   Sat, 27 Mar 2021 10:17:14 -0600
Message-Id: <4a594a9e1536b1d9e5ba57f684c1e41457dd383b.1616861645.git.tom.saeger@oracle.com>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8014:1041::1c]
X-ClientProxiedBy: BY3PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::7) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8014:1041::1c) by BY3PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:39b::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.17 via Frontend Transport; Sat, 27 Mar 2021 16:17:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f2028dd-df3f-46f6-163b-08d8f13bcd0e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3431AA1F551045CE47E3C977FC609@BYAPR10MB3431.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:168;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2CLeBHpit9l5YcdnYRVsAmo4EMbCSn3RUhw1W1KcgV0zdOzIQZ/hc7C5UB/Z?=
 =?us-ascii?Q?c7rurRsddeRF+q9R52hDo18l2zrKAHAA3nG/9Y6XxxdhHJKDl4/1YSgXXd0d?=
 =?us-ascii?Q?KaSyJkm6E4Gr06iKEN1p09OY2ljWM4RNs/4dmNW/GeyX6oRrh7ehbO3KRVxw?=
 =?us-ascii?Q?zQNIqF2CD6yrK8B6cSBsLX3ZfCWMc3oxdRCf/vXKX79pg2OvCVi/r2vXC/2l?=
 =?us-ascii?Q?Ne9E/s0+Vs+LAi7a6wtMtLpy9rJ/1Kt+pN+u63QE/K4n7+DoTaZYNTSUdT0S?=
 =?us-ascii?Q?hBmk6lEkq8FkBYmnM84nJGA7tD4VuVEKcm+k0geLcGEcfKguTlUBQcGPuIXd?=
 =?us-ascii?Q?2NDg3n7Ut+qV9ojeKYPHQ/OGId4xMWc65fz3MtSskFcCt6H8oopIjJo5MINj?=
 =?us-ascii?Q?clTLxJ3Vk95rl6YEBebehrMYQoho5J7u19TjZD+tL9kzRh2YRVkSzaPnkyDD?=
 =?us-ascii?Q?CByGty8Q9r1hk1o4guUHh4tIJZc7Iheewr0okWwIEaLWtjO3IY85o+WxzFe2?=
 =?us-ascii?Q?3FtOFiQOPMzh/rFGdki0GWRyZhz/8+fSOqZByu2luIewFnGp/N7RX76Vn6wl?=
 =?us-ascii?Q?4CP60qitKzI87XCEoObkBu/bJKSYBQcuAoTefj9qtfv8wiqQjcH8m9EK5WRa?=
 =?us-ascii?Q?3oTdiAAXzaf98ki7pkqck8lkxpfNdTBc8RsXKdai8EVsbxDnCJeAN5kP4XNd?=
 =?us-ascii?Q?o5KxMAOBXcUDocD/rHfsu8CX0NX4Pjo0yAdknRJD4K3poGS5aaQFw8CyX5l1?=
 =?us-ascii?Q?Idq7ijchnTgwfd69TKxfMr0S4ZBY9TPRdjjYYwAnWroS1JXyBW3CrIPmLPzR?=
 =?us-ascii?Q?0E5jyYYo5IbMumupas3lW3jMR40W9bVnv9pIhBdt8mB8aSFbpU0LTRPQQ960?=
 =?us-ascii?Q?UgymzpmuVJ6AKSlVEsr0EH3hdKnOa3wo6nHdYhfIwqa5HE+8FjrVN29QX86P?=
 =?us-ascii?Q?Qt1KfRDKVpLI6IS/9Nvi8cwwYM4zM/Sr6PeF09nz94ryRiHsZdRXoEPIQpfc?=
 =?us-ascii?Q?SLTbkQij7CAugJoFtbB+UOY2wsTPDMh9zouPLIMT8+UXaAg2E8y1DTlKxwyl?=
 =?us-ascii?Q?zumS7KpM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(39860400002)(376002)(346002)(136003)(366004)(396003)(38100700001)(966005)(110136005)(6486002)(2906002)(107886003)(316002)(54906003)(6496006)(16526019)(83380400001)(86362001)(6666004)(2616005)(66556008)(478600001)(8936002)(66946007)(36756003)(5660300002)(66476007)(52116002)(4326008)(186003)(8676002)(44832011)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QAEHsUI+gan/iovbS40y1kOjbklpYpNLvsTWkTXBkE5ffxQX5/6jYu1Z49Aw?=
 =?us-ascii?Q?mN7sR8KcyxIP1SHW+vz/r6Ug39Xvo89NVoRj5UqwYHbEp4n9+LTX6GUogMy8?=
 =?us-ascii?Q?/+oXaUC33v1hUDjSoYkJdAoBPfemj7UjISbWacBiHYmqARazab2b5zzy1FvL?=
 =?us-ascii?Q?yMYNm5K56qOxEIR0+0k3rUX0pQT5ZKNa2Lwq874tfeVZw+XHquAA+xvCGq7o?=
 =?us-ascii?Q?HAOssm7Bd+9/byrD6HB9N2dGwoqM74LwqHlQrte0HEN+n92IBjzM1btgdP6X?=
 =?us-ascii?Q?uBdmD5BMR+/Ompc0kXKtDW7QuRTvAvXNgZo+ro/EKVp0ANKLoyT9iYIuaX90?=
 =?us-ascii?Q?96iSU2RPyE3AW+lhDRwFbQPvY7VAidIX62ZpVS2/hFoDONOQfAD1lsO4VC2Y?=
 =?us-ascii?Q?Y3ma2rqr+ABFVidnbuFa/BB60pogKL3EK857xtgd360PfttrORQGTVbzL5At?=
 =?us-ascii?Q?eeOrsWi8DjMU5Vux1irjZmmOjjDCmE1M2yr0KwrO8nuvAqvGMP6MP690bbG/?=
 =?us-ascii?Q?jDY7jRyC8gVgO1JehpjOERRtvC/q1R7w3PfRS8A0gJWH8yCFrm+RbFQ7KmJz?=
 =?us-ascii?Q?WSF9lWFGfeZbBebdRCuUSqUH3KDb/qTqyxois0HJXUwpnCgZSmyjwP8BiQUJ?=
 =?us-ascii?Q?+KJd5qT1+SP3VcrZzparvYxmLpwiyZg2gL1WzfiG5fNdEeNlgTM0wSmuCYrQ?=
 =?us-ascii?Q?MNsdKdujMdMhB/WbZMue/R98/sm+pdt5DNpNOXMxoZfKMcK8ogZdF+Q+SECg?=
 =?us-ascii?Q?AnxANDKEc+1oXKL/5LnI0Wzbfp45Z74ukQdK+Jbcshl4w8TzvgZXzYmcshvM?=
 =?us-ascii?Q?DVgQywzmsuBXpLOkDnNu3S1Ym9xR309BujzC1oGyXlQiDFJEfbFu1kStl/VK?=
 =?us-ascii?Q?Ps35sq/vcbAaYPj2hLqUw5PrERmplRwZQjU3lXXnwz8f7Zg6OmirQoN3j3gR?=
 =?us-ascii?Q?peTAMLBMuPGvw/X7Ni7KzmmYm3PegaOcaDpPQ/0E82TXCvXJf0Pnfw8Uu9Zq?=
 =?us-ascii?Q?yXhsx3XqWZBxc0DsnBtu5KYpT1hHKyiGBv4UPOSPlsh6FYfgTv1GKdaMzJ9W?=
 =?us-ascii?Q?2pTJFF8id1Wvug/N6oIyevIWrRv9r3dwm0ILxaqQMax+MfPMPLjy1B/dnFEo?=
 =?us-ascii?Q?Oo3C3DeATEvNU9vOs+hWTyNG4WKS4efKZ+JFjBYCky67i3CUwxTLgDXKc4ul?=
 =?us-ascii?Q?8ox8i0Z7N2x3LQ7eYuIA9tx9IcUDvJsacHvhJNmb+jwkJM42qvVsmpvDbH3H?=
 =?us-ascii?Q?L2g1/BwO12nyMn4Kd/xqyMI6kt+4QBG6TkU+DUekVsEF9ntT45EhU6cSu713?=
 =?us-ascii?Q?/qe2iugzk+AvqLoeDnGGPYseRnG6jzb64bzv/0F6PDU1yQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2028dd-df3f-46f6-163b-08d8f13bcd0e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2021 16:17:22.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsAUOGTDpeIoNcDahr6E+nfkI3liIjw/TELv3DSM00VTmhLoq+4hqoOohss09SGVbKbAVrGLIWDTwlRv1M5TSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3431
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103270129
X-Proofpoint-ORIG-GUID: O9_QlfgSexZHYY155q7bYbUA7u5_2nEe
X-Proofpoint-GUID: O9_QlfgSexZHYY155q7bYbUA7u5_2nEe
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103270129
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
Changes in v2:

    * drop entry `readded||read`, "readded" is in fact "readded"

    * Link to v1:
        https://lore.kernel.org/lkml/14c54ee47bf0e9aebfe71e97cefd11b2b8f0332f.1616784384.git.tom.saeger@oracle.com/

---
 scripts/spelling.txt | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 2e3ba91a5072..7beb4262f719 100644
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
@@ -1265,6 +1282,7 @@ scarch||search
 schdule||schedule
 seach||search
 searchs||searches
+secion||section
 secquence||sequence
 secund||second
 segement||segment
@@ -1312,6 +1330,8 @@ singed||signed
 sleeped||slept
 sliped||slipped
 softwares||software
+soley||solely
+souce||source
 speach||speech
 specfic||specific
 specfield||specified
@@ -1320,7 +1340,9 @@ specifc||specific
 specifed||specified
 specificatin||specification
 specificaton||specification
+specificed||specified
 specifing||specifying
+specifiy||specify
 specifiying||specifying
 speficied||specified
 speicify||specify
@@ -1436,6 +1458,7 @@ timout||timeout
 tmis||this
 toogle||toggle
 torerable||tolerable
+traget||target
 traking||tracking
 tramsmitted||transmitted
 tramsmit||transmit
@@ -1558,6 +1581,7 @@ wiil||will
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

