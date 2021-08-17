Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6EB3EEFC3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbhHQP4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:56:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58250 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240272AbhHQPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:01 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkFIE022513;
        Tue, 17 Aug 2021 15:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KRk8xpjN43r76rHt5v8h+KrzzRMX3z8fvDDt+SqiRpE=;
 b=j9SPNe73Hvv0R3tyFu7DeNtYINQwHTQwpnWVPHRmrDckFiLledbudZ1Y23Ck3Vizm0Lg
 XWEIzBCzTyjBREQV1riucAY0E5IZpiNeDAba1IVCcjpaBy8DQAwfPemiHAugaKDsw9pf
 lKjh6eOxTn0J3yIZQB1HVzEBQ59ijiIwlL9S81g0In8Q96OKcZPRpO3OajMLWrueTCeF
 g1mLpV1lIsqv1EG76xZcOkYyAUXA/Txcr2plBE139Us30oMAL+Yv7JNaBglrgmpjUiPx
 V+kdRD0lryEt3MlAhqJRX75U/3ET4WgqGdlRp0eeL4DLovX7YS9dhlCKPSK6jzLDI3YB ag== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KRk8xpjN43r76rHt5v8h+KrzzRMX3z8fvDDt+SqiRpE=;
 b=SPGVIclwSaVyyb7PK3zojhu1mEl3oQUFqi7KCpEzr6xRbIyP/QFcejugO4cYxL8wszgl
 o5h9O2u8xI54Fta45K/VE5TX+vSi753FNMVvTZB/W9yQAm0jw1Dm73fZLUEydxApouy/
 2920FfWks3rxwTwkoqlNGk3jaj1u9+9r+mF+QLB38sJ+4DKuLH+9KHVKpi7TH5l4XZAE
 qp6oIApESKI7Iy+Wehz1W9Qlwr+bveGbx/oJFN8dDyyvpNqILcUhChFS9P7eyNrw9Vzl
 +GAm9qrOuksIsMwTLJIC/43Jlqy+QRCXYMVKgPosYSXrFfctlkR0zs9XRi3BYCCKq+et 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgm8y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmf9158706;
        Tue, 17 Aug 2021 15:47:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3ae5n7styr-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GV/TQYZJp3+TxdQQwQGLevH6oVTgwQ6ifkdZif3vDELstxRD8XPFO7zexev9rR67/0/BfssPZCAGCWrg12AR4/5obDdJ2kPfLSySrfEccm4YqAghdzw9OHJPIQK8DF+3vaj/S7tmLiMdobD92bQN3bFTwzbnvOtjTovxWpsJAZ2wQMh2/7eBa2vjDAneinVgAusF907T7TtYcVpQj8aflVdkQlwnAHoJ1Lo4NCkkNxCbFvSqPt/AmQ6paUSAF5Tj1ImXx6X9oIAMgCUFbMPt4RQipD2zB3efns4JmKdyI7Z9YhNk/XE/K3PnPtCJKXe+ptMwWSf2rjYLLwNBc05iyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRk8xpjN43r76rHt5v8h+KrzzRMX3z8fvDDt+SqiRpE=;
 b=H6WkzOBj1cj8LBz0sdvRrDEc6hBIF7mPMWV+Ai6aZdpDjSpkSKbgXeLCby0UuYEIVZTmgjhDTkNFAU14gvtF4pxZpo/u+ZG7Ei446he93/59UrAuCXku1vcrqmcxvPzldXgpLvmgJTG1pEmB9n8NZtiUevnfmMYxcU86bXaQtQ8xKx4aIl55wr2yBu2+QjxuekPeOsYQRBX1vKXzM+ppjRtZdj8iGKaJLj2BxLaC0zJe4Wl+Cusm52pcV2VeSKMfbpQiIh72GbEPPLs+1IVKAXeOs0TUluGsHSdub1UoodnjsOVXfsx5liVPutfwwGGx7ueHuKOtT7sSa09Pdwax3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRk8xpjN43r76rHt5v8h+KrzzRMX3z8fvDDt+SqiRpE=;
 b=ndtnel5T8W94mJJMAzU8+We2KagvACGzAuESmK/3n9iLGEodkGeCRy5caF+8n4Yaovl16bCHPZbw31fDPBYph4x6htPkTSBdcQMhzRz3rFnJEHErqOE7BuC8i/WKnoJdYAi58GRtHDfrtX0ExPlXOGE7kaGgJPoJQRNX7bP8WvU=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:19 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 24/61] arch/arm64: Remove mmap linked list from vdso.
Thread-Topic: [PATCH v2 24/61] arch/arm64: Remove mmap linked list from vdso.
Thread-Index: AQHXk38pxQCc+QqhCk6FAjAImM9SjA==
Date:   Tue, 17 Aug 2021 15:47:19 +0000
Message-ID: <20210817154651.1570984-25-Liam.Howlett@oracle.com>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
In-Reply-To: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f7b4451-c764-476d-76e4-08d961964bcb
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB42361F6CE212DB708C2E7F43FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: es/cwl3SMmQFJ0Zbam/cO5x+GWgXbVMe0TKl/auW5zVS5ySc69MJOKl405078L6MAWq2lCOxek5kPi1+b3FiZM9Xgri9qYwDrLijXCrbtDY823bZ1V4bpQfUVSUiUIP7AjSxkznBC/MkT3gxzWJaScRGIefO4d5WpBd39hNWJMq0/x4/ouBl6RPSAjcmIoufGYEA5V4oTcQXN6nnnKS940MM9tk7ORK5J1mbbEUUKHX9DEd7aesOHJjt3zhLQ2Mo+rWzQJJ/sqgSH3x5yPGvz62O3UP5jI/5F3tvlB4Vif4+xHkrmJAn6rE1eCDnjAvLv+S3xtJ6t2jSwUCEISvNboOZDwjZCHnUOx7g4kVMQPACpp/2Xwiww1tVNb6BJ+lbSNMlPsPA0Ydq2eeutkJwSi+T85YKKGZIyCzLW2afzVmD4mE2Fn1VcfLmjt8otWVIAv1gKXuyFM8u4v6XRFrxiufTzfoGEOpYW6gcRBtjZPRs9FBCkEqX7pDIKKoVgQSH6dnlZEKTpY/+YVM3AZWQqtu5PkCpIo7jQVGfWbUFefMG9s3BXZ37vB/jf1QiQaDL9xXY2FAZRns6LPEOBvgdE+UDHEjrlT7LCt3AVIXy2DmcxTG0Pt0ihibGHfbqyeSgPSGW/iq0ptyMK7xK3APPz0Rnh2hQLvKe7emAx4298voFKtitZpZ3/lVGtLpXPn4rxa5YGG6XgML4j+uVWdAhpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(4744005)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pl22t8maq5KfHa4Cxmelwo6XdM7M9mUXZzVehfemr+Gc4rOTFrr4k6Vs6B?=
 =?iso-8859-1?Q?qOh7avuF5NKMA/AoXPyTNI0AbuCDg2GscSSY45hmyh1OUKRRlGCcYwmkAE?=
 =?iso-8859-1?Q?kPae9tkNiY2XWpI7m3d+9NjCPOCXu0hUQLT4yJ/WL+Cb4ZdwTN8ld/QZkO?=
 =?iso-8859-1?Q?OLR+GUijb4TqCxmhHm1exy7Ug5yB0jM/mE4sgXoT/xvAxBmnIJBz3kexDZ?=
 =?iso-8859-1?Q?IxSM7nbI6KWKsUjnqHBTGRvOhFtM3XUwWLO3DD2huzwlUwq7Q1tAe3ILUk?=
 =?iso-8859-1?Q?RW2KU89IS2YragF5ZS+8XIG3v5QUOUQbLYPnXQnop7Epqd6t1rLav/FdH6?=
 =?iso-8859-1?Q?LJ+w20t/PWbNO/LnUrUWGUVohx7HZa+wTLxE4SCogchHZQ8D4MzhAW2O4T?=
 =?iso-8859-1?Q?qAmCdKn6FfJI+d+DAeih39rTyEnrfaGINMeL2K5ACgp343gI9y/5bWGH3H?=
 =?iso-8859-1?Q?deakCsF1sVkzkFpiJB+W4TXhkbdQFEAtaD+Iaxru3o1/ZcMHG/HTkmX6w+?=
 =?iso-8859-1?Q?ksruEX3/3ZLR9CvvAF6iuonWQe0lHA9tIGH0P+YNOHY+aeFLHKerhtSYZI?=
 =?iso-8859-1?Q?B5dNpTeFPa/lkgZf99HQyVgn97ALwOEC3mG3ynhyqUfct48sVcOrbqbDGE?=
 =?iso-8859-1?Q?CtwLYrmTlHNMd8lF1hiwob0mGi2e5h3WgaJBEe0zVq7yRfiE+fx8Jgdq2s?=
 =?iso-8859-1?Q?4iag2Bm2WEshaEvL9A2Vc3i0bMv1+Kzd7bpq7isI3MiDNQGSIg3YI+ILTn?=
 =?iso-8859-1?Q?iEsJnb4vyL6w7JtKxoECDBwm2MCCz7/AK3ZepuOb8uWRTfaL5rm7ySYYZN?=
 =?iso-8859-1?Q?0e4bMBU1jvSzNzIJFO/Z/YXZzFZoqWyvVrl4ZLN4SipmLTrc3D6iDg22jz?=
 =?iso-8859-1?Q?6OxN6LjFciu5hy40XlYjAdwDzZJO03HcbYn0bFsYb8yZbPDg3dAFkSfmfc?=
 =?iso-8859-1?Q?Uxsj98i3WvTeFz/fQFWTEnMEaYZlxjvUxGXcXdan6F2sOfsZjQ6pfaDl5p?=
 =?iso-8859-1?Q?aFBDnrQm1grLvkc0RfM4yN+vWU1kVaGfi+5ufTDMQ0Ua/K3b4XpARmYoKy?=
 =?iso-8859-1?Q?p6GNtihHWWVmmOctwRej9D4xWgGskS1fv0WoFJbqc5H8UjJep297N1mBxj?=
 =?iso-8859-1?Q?z9EwOhUiJAJJGqZgral2oraDGD3+2cRy4twgKuWOBu8dKfTvNb5aVGbQSN?=
 =?iso-8859-1?Q?SSNikcuA9weKp1Q1CivTaq2Sko343gQIqdmfa87wO0VwHKtFbCmKVivfun?=
 =?iso-8859-1?Q?fVAdmOwyy7Jnavn8ziTa70roqfN1u9jL2Cx85uq2awYeExcn7BBtzlp7tI?=
 =?iso-8859-1?Q?GdRcDWuQ7CIopRIHX9T6WWlrnnw9B3Gn3noyHbHP2E0ZhAsLzr1TXb3KG/?=
 =?iso-8859-1?Q?izzdQgXxIc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7b4451-c764-476d-76e4-08d961964bcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:19.3662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3+l2HgcgBwGVQnGzv7ZSLynVVmbNzupMnLyI+4yEyTe+J/qlT/kA53N/mxt5UF1Q8JsenGLzOeLddV8dCT+Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: De3h7Puxl3xhV9R1C7Mxnbkpj8qNJtDq
X-Proofpoint-ORIG-GUID: De3h7Puxl3xhV9R1C7Mxnbkpj8qNJtDq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Start using the maple tree

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/arm64/kernel/vdso.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b3..57ea81fbe04b 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -136,10 +136,12 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
@@ -149,6 +151,7 @@ int vdso_join_timens(struct task_struct *task, struct t=
ime_namespace *ns)
 			zap_page_range(vma, vma->vm_start, size);
 #endif
 	}
+	rcu_read_unlock();
=20
 	mmap_read_unlock(mm);
 	return 0;
--=20
2.30.2
