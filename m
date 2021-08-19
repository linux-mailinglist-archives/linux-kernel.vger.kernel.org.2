Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50573F1BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbhHSOe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:34:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14824 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238547AbhHSOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:34:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JES5YR017458;
        Thu, 19 Aug 2021 14:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=w29XnzNJl1ASu2tSQQ+MVN73YmWTqp0/bTN+/Rq0Z+A=;
 b=GHeoZDXv2Msb9NE/avIimfVcpIL4flBTg4ymIbEjfAC//Eut4H3GS9mOwxVOUU3pKa0R
 zfAV01QuS5QmQNoGpIpdfP/I6rIRUrbwpgKpKEHpdU5YIa+StkQ9h8Zin3pByIkudXHY
 mKesd+wUYdSX4+iDfVKnGvaFyBvR0BY5qg3nI/qV5fcnPNxvx4EJcv4Q72kGkrSH5CdH
 plb09IaeWSyymcJ3Q4vIn50ZZe/FpnqhLE2iqgL5jx+8VHZ0lqGPNoMEmmOColAGLxho
 MPDXi5YwA7+sP9m1MtZPfSBHLZl4dvh/MWAJvN9ummHqenXjOdC1CWwsu8BKLawDHOjt qQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=w29XnzNJl1ASu2tSQQ+MVN73YmWTqp0/bTN+/Rq0Z+A=;
 b=beNUnhzlnbM3nejFn9sGu24lAx1GC3iOuPwiHAF09UX5LkeINvtJ8CfjGRD/2qJNWHLo
 uE9jfNgM2+5QImcHNqeUlYJ3/PTvQFB2jkpcLCcSi4EoyHWdxk/GYKoRL3D5d8snp8rL
 GBAtSonRzaMIwjWwG2/C3agG4NlqJ/dwm97hXNBYSXENryf+ycJ0XeWBYTIlMrA4+Jkj
 4JG472GU5hZE87ExzQex1LXgodRq27elhSciZltzCnwbRnwua/ztYGlqIpmTFW4Egy9/
 WFcVfG3ciZ8qXaFi1c3HtAGDSPxOjrx50K2/BgVbTJu5oaG0d2KWOKlHGlD4enmO4t4D JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmketw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 14:34:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JER83u098163;
        Thu, 19 Aug 2021 14:34:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3030.oracle.com with ESMTP id 3ae3vkkx0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 14:34:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp1ckWExIjhWEGnfwO2HGKrLSJPGSykd9bgdbAf7qv7Fmc4QHl5bY6KD2brHlCVGkgEAy0Fxd/IwHpoQxhlIhuF/mfNjtXxxoJFRWsIGjVzITGElu2BqSCTabPWeraF9xhY6nyvrMVAcLTGd6Z4Qaa9L5VVwaObgvxzxDLt0ZSDBiBsOpV/OBg2l71VudvSAuzOAlMwzkLEVVAl/s/vlXgd0L8xYIiRu9q5O3xGP3H6va7gd1R7H0rfLzWScKSIP1NQk6A4HkHlG8au8D7xpR31Obtx2tL9+UBduvlpsAyS2VAfoSRPe7l11cyg0SiKONeZQPcVi+GB5Ngh8OVGmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w29XnzNJl1ASu2tSQQ+MVN73YmWTqp0/bTN+/Rq0Z+A=;
 b=VTshc65AE3qeor7nlDAGbJ6wdxLS7A3bf18AqXiNMrO7Pmj2kw7VrfVpUjvxPKEBm0hflGO+fbmt7nrHZA/GD+2Ri6Fum6MWNHaTCcnBE5/ylwzx8v9aAcTh/5d8xgyiIfQGflVEpZ7B2LySab1Abc6yvyyPvJJjGOMc+ZrMAjmtRGqxHUt0BNH7sFFUAsV8NhysFs4u8LFz2ZnOmKHsgJ9EkwkFUWe9VhrF7spKU2mz4YrcOmWsOxyH0Nu9ERLiFbAl2PAfXZO9bkVXTq0ZzpYYXJLaDA2ol0BJ9cOoq+jdZTkOnnHopnEoe2RCuVJMDIWLnLCBJb0vXln3zyCzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w29XnzNJl1ASu2tSQQ+MVN73YmWTqp0/bTN+/Rq0Z+A=;
 b=UDGRAa55eyNHZR5qrbBX00d2nvVXkwqbjIS9f3kLnojfDrh9jvcWgsEE8x25YcMB1maTEF/CD3yPACdBAHDD5H4HXPx4kEM6SElnuVX91bWI+NOGEFX6u2yHTJZhYxUAz8DOIr02UdS6mJOrda2/qPQu/mms3YpcyL+kzXTDzz8=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR10MB1696.namprd10.prod.outlook.com
 (2603:10b6:301:8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.24; Thu, 19 Aug
 2021 14:34:13 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e%6]) with mapi id 15.20.4415.023; Thu, 19 Aug 2021
 14:34:13 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, christophe.jaillet@wanadoo.fr,
        mihai.carabas@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] misc/pvpanic: fix set driver data
Date:   Thu, 19 Aug 2021 16:41:20 +0300
Message-Id: <1629380481-4363-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:806:24::9) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.201.25) by SA9PR13CA0094.namprd13.prod.outlook.com (2603:10b6:806:24::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11 via Frontend Transport; Thu, 19 Aug 2021 14:34:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e9bd769-a7fe-468e-1b02-08d9631e6a09
X-MS-TrafficTypeDiagnostic: MWHPR10MB1696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB16961F2F8A725C596E9034E288C09@MWHPR10MB1696.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBGA0+gUucBZ9fM7wKKB5ipFhG8YFhjCJjxtk0UZJXPdERgbB4NRk7hS9eAem+Ymcs6zVe752jSKIq8LAgqY3wtBpB+j4qrpfcFKba0/iZu5hm+95mVCZRfxfch3du76vXp+LLccNx4FGi5zFi/8gFaJJgtpRHHrE3HcYwYn1h8N0r1SJOY55eXWyv/6vQU6HmdK55YcKEfTWswIxuT3ArzvB344Ued4mmCDkXngXyP4/9JsFy1iuaHY13/97mSHpgh7YtGHC8Pd/HTl0+BN9Cue4KwnzQC3YF5tEOUiqmbHbP7boz7Wxklv1PTluMD4buyH8inRfoe4B7U8h6yr5sH/oMZ2swmG7PePemp1uTTHVlgRa9QJlXWgL59aU9ohROr7p/T2cbhfOYh6ZCVUgexihXp+6WS2HCUoE9O5thY0disI0RC1/RFUqnzojYimZDOylD9847REYn5DOQclZNFNKqCcIvgeMP/Zu82DT+yTFqcAN1am3YgrzstsEGyQwMb3E8Vleitp+spHEsW6lFqLIFsRtCnFo1RrJx3TtXqoLS3KgB8GqRiMb2/POdlO24ORNZ7ZBGNFAiamfNIuRy+W7FfjFz77v1GcJCCmOVzVAw69zYQaYjXHP6Au3L9ihtyoqBOvrkZJ+Y52fBzulymaDB58PlmTQKNVETV0yR/aYtCAzpk+NMs4g0KQcl6eg54CFqCkWqz4guczsmO/iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(6506007)(2906002)(6512007)(6666004)(2616005)(4744005)(5660300002)(86362001)(52116002)(83380400001)(36756003)(66946007)(508600001)(44832011)(66476007)(66556008)(38100700002)(38350700002)(8676002)(26005)(8936002)(316002)(186003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Kf7JEgkECxS133OOWz6EdlzPNvFaRUN5IYym5HuE8buWUphauFhAhhzLST4?=
 =?us-ascii?Q?wuarK3LLVgCpcvx9ucqf4ayh816Edoe5E2AAYFxisobPe9QoNz9i3Wh7lIMf?=
 =?us-ascii?Q?vDq0E6YjNToRayyn0tvxAld52MYD/U4S3RCayIT6JJmA7R2bupn8ywIUE2/x?=
 =?us-ascii?Q?pNMsxXGsqk5B9DQK0Pf94TCHy6zJhA1wmT7vHwXHLQgBFXkj8kkm3/ZINRik?=
 =?us-ascii?Q?zLRinEk3feRAmK4UwdoKu0M+ImRgrV4beUrYyDokdL5NmpmxEqFfAltunvzS?=
 =?us-ascii?Q?lsggWQvC9p84qjlUcIUyLXz80tau1Nal6ZZRY4K0ZWVn3GnqF12qAa0bIK0Y?=
 =?us-ascii?Q?ETJl+QIeMO2cx2tUl/JQIP19G3Y2bNSOHAqm/+zUqZuQx7OaGKT4NzRiYCdh?=
 =?us-ascii?Q?u1ypR8GBAsFLTYm3IP6rzEPIiAKMein8H0UpKuRMLpxuGP5o0nqkexQtx+GQ?=
 =?us-ascii?Q?G0X7mNoRME11pbkZiNouAPAmrqh3Y/zdF6Nz+8z7S9kswhNtu2QGDmiyHPoU?=
 =?us-ascii?Q?u1ivaxjGPW9j/VliiZrU7ldmhFKyPicxxRZuf4dmlwzE7F0H6lxn9J3Y7TYY?=
 =?us-ascii?Q?4SKKGLFt0RnCWRbj1HzayZCujLahgvTpuK3lYphRvrZPC9VgbuXeVI90y2y/?=
 =?us-ascii?Q?cExydgM1v1kl7LWm4Gl2famedmvRBE6B94odYbs0TeKfQxpXZIW5j6thnlkY?=
 =?us-ascii?Q?cfJfTlHR8os2WXuIKvlKFi0FNR6GqncrCI95Ypf2Gkq4MDq/fUoNqlJ/eRY+?=
 =?us-ascii?Q?nz3jBYWuYlR8as6fY7afQpYGed5Y8e5cx6mmjHvEujyMsyJpU9t3ma7vgcMN?=
 =?us-ascii?Q?9LgUZj7K8SXoY41AcZgvBfoTUWmPVgCK41bbInEtmXpXUbJVOcz8uJKtXFca?=
 =?us-ascii?Q?SHrFV6977VXvENO6h4TLFv+9eKnNCkUGbTNUSY1dAgaBMTBZ3lRaNU9wOjAI?=
 =?us-ascii?Q?9QlGoxbYnAXppn2m3ZWBTQuZQdOt7AIsoKDe31fe7M3HEWjE1dIrHbTywB2s?=
 =?us-ascii?Q?S0bg1kzsyi5KRknzlTJXSg4Xs59YKRnhW2Gv17affXM9VBWPdn55nT0AoX0j?=
 =?us-ascii?Q?GGZHFjLPLMnTydXRiNZMhjy/DUKpY3QI+3YcClQUGsw6RF5/1bCRkx+dN88l?=
 =?us-ascii?Q?Ytht7V2b5p7H2AkgjFxptuYl5O7nLaHunfMDqDcOrN2sMZsZxQALOVxt14Ge?=
 =?us-ascii?Q?Evxt8eZ9fi4xQ1VD6VRgG+8a7xw2GRCnyvr/1cStzs03cp0qElxGEbK23Vrm?=
 =?us-ascii?Q?QP15qeQNmeaLToCZc8C6uHwcgxkX1HhvUbkuQsMicQKjkyrMMZQCN+8leH1U?=
 =?us-ascii?Q?VzELq7aMlpOP6JWCv0lbDjqr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9bd769-a7fe-468e-1b02-08d9631e6a09
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 14:34:13.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPqL35Es+XtRNPgPOCnUMozVLO9MOe+HEDbq41n+y5rnsx1jjhloumhDl707D32gcSsJMAeJl4lzd3C49dRmHuZzfG+d5IbuU2BWXwk4kvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1696
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190084
X-Proofpoint-ORIG-GUID: faiXBdvwO4RAdP2kVcsGK0JsLMj2Kgz5
X-Proofpoint-GUID: faiXBdvwO4RAdP2kVcsGK0JsLMj2Kgz5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 394febc9d0a6 ("misc/pvpanic: Make 'pvpanic_probe()' resource managed")
removed dev_set_drvdata() from the probe function and accessing sysfs entries
from userspace is causing a panic in the kernel (pi = dev_get_drvdata(dev) ->
pi is NULL).

v2:
- fixes a compile issue with CONFIG_PVPANIC_PCI
- move dev_set_drvdata() to devm_pvpanic_probe()

Mihai Carabas (1):
  misc/pvpanic: fix set driver data

 drivers/misc/pvpanic/pvpanic.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
1.8.3.1

