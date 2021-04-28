Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3523636DC06
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbhD1PlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:41:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38018 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240587AbhD1Pi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:26 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMtdP020250;
        Wed, 28 Apr 2021 15:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZxNmnSM/wa8C+TKe2PkWlhLV94/gUhxq1Zob1/co43M=;
 b=euQsPsiU4IFhQ4CcRW886sHAPbXb4czY1hNJR74aQge2kQvqUoE1CasF0H5FLOccb2rn
 AY5vBjJKgHg+GS53dEBPhLSndiz0lwwheDMZ+PqNDUmhOs0HJpco1BPWzh4FuOa15vTH
 M6ui1e6/YCwf8oK5pmGUPeCEqQj9mjxzJ4HGlkMh8QTBX+UucQx7rTz0NS7SvRHKoqnJ
 +Gqrb+TyPFYM7pMvVtsOYaPZ54Den3bAPcIClbjENcvCW5msMahjBt/L/ktLKnOZ65Ij
 2RGXo3jazYTlkpBUIiNqF7FaCzONoLeykJZD+pR1al7CVB5+4ghIBxIHbXW7ypYIKKW9 zA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878kgg52w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:27 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbPcb024423;
        Wed, 28 Apr 2021 15:37:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3874d2765a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgozHbwY1HQoHaev0M9Cgjqn9d1sLnLfx6rWT0S2thSSKN+HaZ3TprA3s+3Olmh+3UhjrtKhv7hLqF4olsDtWqK1FUvrgmZG4wdMaoOyfjyFq+oBxSx0VaNYw9zN1CX2VA5FMf52Ru7pPf7i/6ZxK1HHsRMnhigW6uMjVhjLUFrJAKnB6tsqvYW6o1T+hM19w/Dq3Nn+Y/BFo1K3hvfI0uBE9cmOCzp2weqIXK3n+csEmRHiWP6n75syq938Wsvrh4yWNaGsO3VDt2t52v9q8nPp+QaU3mJY0Yz5XFKkelA8rftz6XHdF92YfZM0Gd2TDt9iRLy36maP1mWtwTNP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxNmnSM/wa8C+TKe2PkWlhLV94/gUhxq1Zob1/co43M=;
 b=neFMOl+0apspMKPMmhDg3+IyO4ke+p5fsOSnQ2ANzHWgW4OnpzywKzPxQhl1YIDxUjtHKTCc0Znpb9TtlsVNcxr+pJRhkWLDRS/MaTUZ9e4HclW85etHYBgkVXO4dCwReHVtOflCPYyUXJWZQijEAb16P6bEzLGfhDKCME2GVAEij4oAAoksOD1MSe3fjzCCYKlNlGpHTBUXiTOHpYhXgCXTFUSYHzg6rOP3nA/ocYI4PYKeRDKvZEm5Y8HKnJbDNpkua/R1WmPbPSaafz4mj7op70Eg8a8tr3jTrhEXtDkXUQw1JgPYk8B3/zzpmoe6pL+bjGwUTS7aRWLpU7qTcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxNmnSM/wa8C+TKe2PkWlhLV94/gUhxq1Zob1/co43M=;
 b=J0wDmxNWbwfbzhZ2JUaijDjtdKyIx0Irf5Km6gMnmFBU1YkFTbNZ7di//3ndwkM3c+/AUxJC0+mHcDSaWam5Vo50uKrGAlCfJhPL/swC8xUKuISteHmT51D0rkRngHHv9qszFoqA0XsHWz16mV1NY98lfQAJ6qrWJu3Lg70yxCo=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:37:23 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:23 +0000
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
Subject: [PATCH 73/94] kernel/sys: Use maple tree iterators instead of linked
 list
Thread-Topic: [PATCH 73/94] kernel/sys: Use maple tree iterators instead of
 linked list
Thread-Index: AQHXPEQ+t/6sqQAiVE6cX7NSbyvWFQ==
Date:   Wed, 28 Apr 2021 15:36:23 +0000
Message-ID: <20210428153542.2814175-74-Liam.Howlett@Oracle.com>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5dd269b-44e0-4ad3-b1fa-08d90a5b84d8
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB45485FC84A490C2FBE9AE24FFD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WY34nwZeqvAnzj7KQipZPM56TX2mpHBD6JO0/g1j+e7/c+A0yOAe+fglo6LY4zlfOqj+JhhSR7zXEw5eB3zRuOMfSwMyFD1KOtSUmF1MrusVlhMp8bdrs/yy349UY7EH+1R7yTTSEHUjJPHnKXu4/IAX6kpXIYdzahVzIkJVo9n5ujVASjwTrhyxA9bBIiQBbpo3TdRaNeIWLVcRqoK2VA3Kby2Y9s07WtSAYE87RI78hrwREU45m1YB+p3LcOYdtVQXdclnoTGR85LUGJxfkTH0zn60hEteNQ0FhYtwAXi/gxljPJRNZyZdU72BlkX+D08GwMVs6DmjC6hWNPQIjJaNX8lX+AFOTkiw7wBqToLv09tSkGnXLHaMCpYPl/Iy0gtwZ4Z5eGpViELPqhXqALjdvWNjw0Z8LYGrdok7AFNODe8k0Qjj1KBtvVHhsxHykk0xXpbFzptfzpIC7uSKXH7k+G7a81vkgBSQn5+azPyW00vtC0F3AT84QVOjeKkuK2+RVy7drkmcMsljWZE7Op+kHFnCEKMU1BSnBjauSPX4GtNROiyzsTc4RHNWec6kLv3y8y0Z5eF0L5WhA/epHueYoBRDfmpMaHiz/oU4MXU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6486002)(71200400001)(5660300002)(316002)(4744005)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?KOQqniuCJtiXe3LeV7yicMO2/UrrLAeINqk3JsOy5fUK9UdH06CqzYIe9n?=
 =?iso-8859-1?Q?IMfoKLqTZndGKXcrEtrPWhKtHCtpn3F+HULU9uwZZS88cQojsehqfyLivJ?=
 =?iso-8859-1?Q?1V239Tpv6WPic3jwjG594GEDcPGdq/lEoNtQ4Eu9t2mL+KHon/OYJOn3ZA?=
 =?iso-8859-1?Q?b7fYzhH81IMvFXwpKTjg4nPJvlhOBKdDPfKYkcRUB8bC/bevJO4TJOWkjp?=
 =?iso-8859-1?Q?JdWCrOllWa6yMKGGkttE/Mt8Y5Zf29OYJ0tVuTcWQb5pFEs+G0fNctixZz?=
 =?iso-8859-1?Q?aQftx2sT5w8e0eHp/p8wwMh9Ve1KhyDUmKZvJPUfgY+b2MZnOPfvdcSbkU?=
 =?iso-8859-1?Q?4TsogyxgLqTpcrtuI4/qA1X3EzHVjUB0kAWqV186atUqKvBpH1qTdFL+N1?=
 =?iso-8859-1?Q?4QfGZz6WdMVyIkzsr0LMR2HmI8TmUmeJxdg0UliZZO1o9OiUSbedh6AeAc?=
 =?iso-8859-1?Q?3kxkF6f62gh3zE81WS8AXFI0MbkSmNPHJHAnSc4f93+Do1liDSl6cqisBE?=
 =?iso-8859-1?Q?3ZaGvK8BMFErmpHPOyztpUgVgWru5hf9JHtWAKXrX16XcbUgpZrLNguGQx?=
 =?iso-8859-1?Q?WkJESVtXaLgZpev02ZjtOZ23WglIcPKmcKMYDTz0jOtVsaLcF9FobNga7e?=
 =?iso-8859-1?Q?Nwa5KsF1R2CQdmJHUv0OIJbqbNrd7xt0ahUxtlXWWkeXB23uID8Qyyzvsx?=
 =?iso-8859-1?Q?flq4xN3ixQcOMAvbQ/1vb5UE17eRKxgiuTactGNwEyHkueChy1c+Rr3bcB?=
 =?iso-8859-1?Q?y6O9Q5kqeQEWbB5yhjsN854+R+QnJduW52RTLO8GtDYcRv3IR5pLar4LAl?=
 =?iso-8859-1?Q?/sBVeQYnyyRUntYadTEZRX3A56VJr5IziL3oIV1lXA8Tyd9xAWZyCdhARa?=
 =?iso-8859-1?Q?KQPjDsjRjLBHlnefHFiT4dehMApitLJJLG3TJ5l4/e15Y+k9BAJsLkKdn0?=
 =?iso-8859-1?Q?neNVucYtkcMTNSMFx93biUpOBXDpxHHYUt4FEsMY6LpaE6FhineM0erxyz?=
 =?iso-8859-1?Q?6VszKryJOS6nT8YKUfVSaKTtRI3JgUA/Q2fcDJ98d0ca1CzdhmVC3lLn+x?=
 =?iso-8859-1?Q?/OLjWELLhtVarGesUNnW+mbhBIeXWrkBqTwXU1kJCfwtaKxMMm+/yDFUmL?=
 =?iso-8859-1?Q?GwHIYvUJIhOW7oJKfGTzBN382Azy9hVQ/cWz0LfoZPnJ0uSSfqaf7Le6fM?=
 =?iso-8859-1?Q?KYHzmS8uenrvmQctM35dgZKNBqAFI1QuYgKZYjz3kxSUWD3h2/Kyw6kbxG?=
 =?iso-8859-1?Q?VekPhEOSOT0SwC5GyC+aU16oJJL9f3qnsf3DmGD1CzXZu4jhC2s4IvAODq?=
 =?iso-8859-1?Q?YR1F93V3wkOobDaQcXS8aXadJquxK9X6/RKTufOzxIOaPaFJFDz5JSDnT/?=
 =?iso-8859-1?Q?tUw831e0Pq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dd269b-44e0-4ad3-b1fa-08d90a5b84d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:23.7186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kDlvRNCfYlT5aQcGNeuVeycKh20cfVqF2KQSeAZDhvjlsFwuuGLx+jRGFSwlURq+n8EmnLOH+CUtJ3+SEElAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: mFG1y0wrxwEogePe6RjQABtj8gD4VPBZ
X-Proofpoint-GUID: mFG1y0wrxwEogePe6RjQABtj8gD4VPBZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/sys.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 3a583a29815f..3a33ef07cc22 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1864,9 +1864,11 @@ static int prctl_set_mm_exe_file(struct mm_struct *m=
m, unsigned int fd)
 	err =3D -EBUSY;
 	if (exe_file) {
 		struct vm_area_struct *vma;
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		rcu_read_lock();
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			if (!vma->vm_file)
 				continue;
 			if (path_equal(&vma->vm_file->f_path,
@@ -1874,6 +1876,7 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm=
, unsigned int fd)
 				goto exit_err;
 		}
=20
+		rcu_read_unlock();
 		mmap_read_unlock(mm);
 		fput(exe_file);
 	}
@@ -1888,6 +1891,7 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm=
, unsigned int fd)
 	fdput(exe);
 	return err;
 exit_err:
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
 	fput(exe_file);
 	goto exit;
--=20
2.30.2
