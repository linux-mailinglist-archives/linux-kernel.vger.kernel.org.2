Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD55C3F1BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbhHSOfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:35:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19960 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238547AbhHSOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:34:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JES7Ws019469;
        Thu, 19 Aug 2021 14:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BcKPGXOEjrTcT2yPIQ8XRBVvMUh4qpKBTWJ15mEyvBs=;
 b=NiAw3FCSoGlvdmeWr18lj/dMCZKVpq44CfntY7K86YZ2L/Vd09rnfUDwYSL7aG7BYHE1
 sNHa0eiohwW0zZbWU4CTXoiE90uhOM9AdAfw4sDU87/w3EAx19ZHDWoWI/DITaCJe9tU
 bmds3UiW8VKjXBnwEVZ9QmRj46Gc6IfJ1rCJjtzYB4lk4tlF12vwxCsrGBXevMgvETzP
 1IWRoRxTkOc8iPVE84fBSfRuc313TCLMJroxFWIAxsFgZ9nfqBdMzb0v7SB8+43YtiSj
 pA0fAAPEsAQpdYM5rflWjvvmIgNHz/yIkaRW/WERBWsJyTiPNBLWLs5bc+Xha6kR48Fh bA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=BcKPGXOEjrTcT2yPIQ8XRBVvMUh4qpKBTWJ15mEyvBs=;
 b=iPzC2OXurQNrb6NbVnNdXvwtL1s+sOhkXWI/am8ltycf4e9FNnmlNyAoCjtRwkCrSv2L
 Hf5jNgyvDAWic/qJHQRVLU4YHM6jykhHuxm523nAine24T1Cj3DLzmcdtEjdGAXQCljs
 TtqHBkEn3odGhMoF9twa/e6zszinU/agSHohKhd4ViEzPDo0w7l7iO7oTz1vc9gjwGt/
 fC2v2IOfJsyGjA8fRb6Is0Sq0yMnyoqZxE/eNaKkpLhhaBl5k//BF5+qsCkZSZ7E1WNz
 ZGpDMKAhy6TljHPZMZYEPcWh1YHRPyPexOsF8lpYyjDMpKVIB536P/TzFshc+r/2B7oS Ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agw7t3uq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 14:34:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JERFHN119996;
        Thu, 19 Aug 2021 14:34:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 3ae2y4gdda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 14:34:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVzKE7+v57DglbIH1FP+76xszbX1qUkcjzJ7NQFv0fcOa+Zjr+YD+F97piVUgYqSijLbfwhbRdKltYBXP/EVeilYp+seqWWHdEH+Kie39+KEb8dfRlSAVVGPi0krSs9EpbbkBbt1TgcbG+pGB3Et730muJ7GMUbkVAwM6fudMLGBqqap1xMPNnQKJleHt9o070UqvNrCu7CNAiE/GuZG4LiYXVONPS0UaJR3g9FSQJwu1G6j14JX29rIuR94ak1LnRY8SjH1lwPp8wSgD98TfeQ+o+1qjqKOBF5Rgx670qSwFcr2qraS4PbEg/wNBD6yiHE/822+EkvQnkLtTqDSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcKPGXOEjrTcT2yPIQ8XRBVvMUh4qpKBTWJ15mEyvBs=;
 b=iD68Sj8KTE5nfzWXXSjx8VfSejbENxpDsmfae2LHDBsa62vCR91rdSa/VfuinBl+KteUnDEkHul3/q/42lP1Axpz7FFSvFx3kMsefrXeKXQESb0fTFwREvibhU1NsK7rXKYd7DTSSAGgh2ySThM2ll53wPS2Hix2GRSfsaEc001FsvZIQn6OAtn1V7JGT5fWNDxpd+XAfNcBXeoeOnRz3FgIfLIfrEtx2qhga+FUuZnC3LDMQjH+CIc9JlAOoSVPrT/m00blTJ4opPFSZcJDGS+zQTMF2eH/isQJ5m/GH2wqkLIj4/DKEoVjStfE2jrOaZc/lBoRZd2f9+35C+2W9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcKPGXOEjrTcT2yPIQ8XRBVvMUh4qpKBTWJ15mEyvBs=;
 b=0FYNlVBxl1l1xREIq+9xFEEzGwwNtWyShfNX2wqaVKtUX6iSfywhu7y4B5DlSDU+XKiPshxvNTQD/iIE2CMs60o9AuK+nfKtqBr+W+WlwoOtTDxVdQ1c8w63ZUPIII21H4dX1Qp0RLdvD9xtz21KvkoGZI50KQDaihRnT5nN+n8=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR10MB2030.namprd10.prod.outlook.com
 (2603:10b6:300:10d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 14:34:14 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e%6]) with mapi id 15.20.4415.023; Thu, 19 Aug 2021
 14:34:14 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, christophe.jaillet@wanadoo.fr,
        mihai.carabas@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] misc/pvpanic: fix set driver data
Date:   Thu, 19 Aug 2021 16:41:21 +0300
Message-Id: <1629380481-4363-2-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1629380481-4363-1-git-send-email-mihai.carabas@oracle.com>
References: <1629380481-4363-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:806:24::9) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.201.25) by SA9PR13CA0094.namprd13.prod.outlook.com (2603:10b6:806:24::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11 via Frontend Transport; Thu, 19 Aug 2021 14:34:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69984465-044c-4039-4521-08d9631e6ad0
X-MS-TrafficTypeDiagnostic: MWHPR10MB2030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB203042BE2737D2467D6D686A88C09@MWHPR10MB2030.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjgs7eFCE1pbchi9Th651ULFgZOURfVPR7tkwEX27PXKapaFzhyo7CFVsxW7egv+bhE+ZPTXdqp2e2qvX47Z8AXlDrRqzIOj3q1zQLFTUYgECAucIbmxT6dZHra1jsxNG6LuMbpT9TYSwEQnHlt84/omErDq/94XtzhOrBqTnLWj/QArE4+K/WRmVBxLPgr1CbVKXDI+yqb3zclZpSp+AkGjgVUkwCiXfUmLIIIAZ55oJwNLpzfiyg5wePYPCJ2u9ikaUkKxmVzbzA2sCc6YbmImjo+ru8ROOEXb6d0wC03nk3J68mq2kWyr60+4bcvOhS1Sh/foeGnGOGOk+EdxOUWYlWmKCD3/5tQhqjNOltL7k2nB0X648o8sIgE1jtMY4EzXd9L1eG9n9M0fJ9WJ5wsUxhDfHT1T/tEwwLhpzEiI2rD0F5IiinfQJlHIhPo2OelZ2WbhH75MN7m/GOllEc1CV0ux2qV6IyWYcd6FzFSgRpdAuYLchHvqYRBg3Lp0JbJ6LSLWkkWGtSa4/fkKNAYNIN7GHED+zG0BC6qFFbHYNgMM/Rp+VAEutfwEyJowev7IqTpKp/k77+cpOe9sPZFkZxSKCvweT+33Kfj24iKhBbRJSlS0RziCwwlS6QwABS8Z01WX1s3Qwqeguc8Tue1AG0VAqCXB9ejONrxF7p1/D3J9pH8M9iTJgJAsA4JNK6z5fMu5gIoZVffKkK9GiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(366004)(346002)(8676002)(6512007)(66476007)(26005)(316002)(8936002)(2906002)(2616005)(956004)(86362001)(44832011)(38100700002)(38350700002)(83380400001)(5660300002)(4744005)(6506007)(36756003)(478600001)(66946007)(6486002)(6666004)(186003)(66556008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vYCYA5UJlW8Pp5uK6yl7iJPfqKp8SYLnl8lfTKoLGDVZp6NGeyA074f1/xdc?=
 =?us-ascii?Q?VSoTdE0jUNO2Vk6RuvpMqLrf1nGtbZRf2k67PGzAU/ygom39ogI1hPNhOgGO?=
 =?us-ascii?Q?+oSu11P89qzCULIxWNMATRUCUWQxOUVyhLa7cF4/Hzg72gTwZSIbeKwEX6TA?=
 =?us-ascii?Q?iulLLiGUtDn4ILRrzU89v6KuCv16fKIg6XzXIoIEL4J8wXQP0AEC3BEjN6WX?=
 =?us-ascii?Q?q07B7ScrdYeSw9uL8FqdcyXxe+mnSF+dQHKopznGqKTsu6xlL85fgsItvIci?=
 =?us-ascii?Q?5YhQJPwZJQnNguWMPYD4OZJlb3MeYUXcSF7QV9fbPdJli3i0IWwXjqNzk4sI?=
 =?us-ascii?Q?+Unr2yliRyJE4yh68KptTDaUu8ytpuXSz+1N82sayh8/fIQIjBxrSqzRlH7n?=
 =?us-ascii?Q?s39UTrld6V8DI/d8qVUV+eV0VuNx063Dry8IXod3uAe50BWvotQCeONsToVL?=
 =?us-ascii?Q?aSz0KeKPGFIvrrUynLwRclzF7FKezBz+mlCdKiqfe5ydHBmXmcOr/q8s3bIZ?=
 =?us-ascii?Q?vxzxjl6Re/iJ4TGiYJctUde9/JFx1KmGqJPIsJUa8+XPYYALvGqBjSTn91MT?=
 =?us-ascii?Q?3iRT4wRqgHbTT4ZD6KjzmItSQ8KpfOPz/lwiFl93X2FfZBUutayAkxpMoyWO?=
 =?us-ascii?Q?wp0Uy7blIQ0ZrcD/oyk75sM38/0xK0uy5Av9UeydUA4o9xsi1hud/kCMs4eE?=
 =?us-ascii?Q?9Yj0ZA+NiAKlGJJvb+jPsF6sjEgkRrU8FVwBWOc1oapjxgZKO5pKu8GgnAhX?=
 =?us-ascii?Q?dLbxFmqSWdVVoNg4HJ0VVn3sApyYDWg+L1IprFwQX9lh1u/Z8ohGg4FFD2Nm?=
 =?us-ascii?Q?4kn31NhpmjJgLGOWuiPMz4E51PzvAQKQRubvcDuUn9PWB34xd/A0wuKUG3DX?=
 =?us-ascii?Q?GbGkUdu23LArf2de+ZLEjwQKwrvMwAr66hiLL5ETnHGYhRvnuNyJZo96fAwq?=
 =?us-ascii?Q?rFFfq/uw7da5n85bZnwhj5DIFJ80y4LfWhqSmofs8etb1KQ1lRxu1AobHolR?=
 =?us-ascii?Q?R59DJsDquWCHENN2+xXpoT121wqXLCS33kMKQB0UFf5INwbF71po+95r4HII?=
 =?us-ascii?Q?hs0LzFpEBtbtnwRVC6D478DAsuJVGDblygUpBjGD3l78xNmfjgE+qahMMqpa?=
 =?us-ascii?Q?4t2ARzy2AfBINDgcUO+pqRketrmcEbuoqu4vcFCtRWBdViFIDdClkDq2SUVe?=
 =?us-ascii?Q?GVtoHlensTl7TrN8wUZlj/hY9p1CqrG5BoJSYDmotraKcWHQd5TA1y3WES6q?=
 =?us-ascii?Q?eoIKOm64v5DbGnuL6jVng5qoty4w+c/CUcIdYHUvVCuZyGcDiiIlrPSaVjw7?=
 =?us-ascii?Q?LtJS+skhTR1G2sBS2VdwU9TD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69984465-044c-4039-4521-08d9631e6ad0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 14:34:14.3717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDRwbFdgW3Z9lhPzjICeOri+XpQ6OBGKXpUv5LAhCUpd511vERJnwYd5fo0BKbShP06GtBsb2Y9cTiw1ERuG5u+fMwHpvCdCBRXXcNJo+3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2030
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190084
X-Proofpoint-ORIG-GUID: KCIgAZvbgkQa-rGTSP5QMUyIiukDLQcH
X-Proofpoint-GUID: KCIgAZvbgkQa-rGTSP5QMUyIiukDLQcH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add again dev_set_drvdata(), but this time in devm_pvpanic_probe(), in order
for dev_get_drvdata() to not return NULL.

Fixes: 394febc9d0a6 ("misc/pvpanic: Make 'pvpanic_probe()' resource managed")
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/pvpanic/pvpanic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 02b807c..6ce48ce 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -81,6 +81,8 @@ int devm_pvpanic_probe(struct device *dev, struct pvpanic_instance *pi)
 	if (!pi || !pi->base)
 		return -EINVAL;
 
+	dev_set_drvdata(dev, pi);
+
 	spin_lock(&pvpanic_lock);
 	list_add(&pi->list, &pvpanic_list);
 	spin_unlock(&pvpanic_lock);
-- 
1.8.3.1

