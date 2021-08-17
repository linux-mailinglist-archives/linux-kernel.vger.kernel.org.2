Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0863EEFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbhHQPzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28506 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240315AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjeZ0011245;
        Tue, 17 Aug 2021 15:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BBQZ0eYQIelSgWPz4cEFXyn+OHjKpNtp75N++uu1yLA=;
 b=WlGUjBXyMclklep8YEToNJEKU9DNWhfeq2zftI8ZPstCTKTWBHsNCQoFtxc4iCVyuivy
 PJlLX/amrrtCBibe1cAReEpKdfhlgkXREqd4iUw7bpmRCp8VQ01bDbxaBzilYZv/JqAa
 iFj84CovNZrdKK6JbcgGPvtDFCWiBMb20wyCwJf3yMUv0e5uxvWE9y63d8JtMIhvL+qX
 8NG8RUXshpkcyRQJL2rUtxgOLaZZGNgxfQlZD1H8vrtxs9E7N8qsApopXk7a34AF2vvO
 KOV8qiUUtCtkK9KDa8LF9tI/QtLf4Nw4eo9l3VMdlBnIdLc+qfKXHlV9wPXv5xVmdXga RA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BBQZ0eYQIelSgWPz4cEFXyn+OHjKpNtp75N++uu1yLA=;
 b=xPDBZjkcdB9KrmfLnQSQPi86WzGT300VIRpsKcgda5aNczKqeziWjfp8ozAxSyw9O8A1
 k/QipOJdNYayeSt7gz3eEQln1JVaFBaQJS30N6MJ7ppddGicpYe+sk+LuYGMXhBUkYys
 A72Kp94zbfZ+dKcHUugDIjPMTuCxK+m6jigqLLRGU1PIYuTOrA+UuoZE6z5eWuGC9KGF
 ZEYAABahxyuZH1PCtIQiXxBZPtk/CDcWyGXmw6LW9/LUKX8tWlaokK0OzrCT8PBgBJ7+
 jNl9pYqSEWgtWM5BMEYLR5xh6Pud/HawqckM0d+DQMIcYCqqzGnMom9NIgmV4jnD+prv iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7d8bvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3OW174039;
        Tue, 17 Aug 2021 15:48:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 3ae2y0d2r9-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nss+qTIR2oEujAdrUMRy3bT+yzCC8E1TBLpGrruBNMWozsNLSdopp+xgqlizyOIVkmWu5J9y7STmU2r+rv9wWjfzSgy762Dmw0/xxJ3ReqhJPpkc/Rc3yt1E7vXPy8S/A3curng8x09zszv/lsAHcozFSY99gWy++CkmMG7tdyHpZrwkJulnkYR8Albqs8zhfaXBd05pKZkAqyQRV0VEOj0/sGiwbB4JGYAiIFBzh2hp2BJJc3FTaANaBkDZLQWL03dWbX3aFQz0aa7+K0SXW7jTDDAsaAWpGaaoaiaabkbJkGzRZjjq1I81Gqxas++bE6XWpIS/JqJt2zsEB36ROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBQZ0eYQIelSgWPz4cEFXyn+OHjKpNtp75N++uu1yLA=;
 b=dt1nUbfDGuGpAGWp/YMT0a7ZoVbulTwzsjqj3F+8QXTumhCHk0RkRj2FW6kebv7MtIlvEs15wIM8mIJEu5dMfQ7f8Bf7sUbEIkN/Ipk6MO8dlIt2Edh8whiliv5Qa23eRykO6AIinZ+ZwGT1H3EfkI3tvdMKYCvGHZTcH48KWKTAKAge3sVl1ktD8yKr5OUPMWxBSp/bGVpnHt62rErUzs5CWrbliSF3PdQv6tq7Q9Kj1aZmRclrbXVqkjbj6tAN9H4fdozsIoCheF1tdditfTnZBMp6KQlrICr7FtE0gV+TH5gerZkW+Ft0xbHS4V2DlS3nEsDeD/CXa8niqcaR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBQZ0eYQIelSgWPz4cEFXyn+OHjKpNtp75N++uu1yLA=;
 b=tFzaShQ8JH6kEGX722VodNrMDoKgHe6i+slU7iQJuSIVXThLSAMtnplnZbgcej4SE5z45YfkNzEhxQHw6ska2UaUbe0fpzX7gKG13rP/nKjEqsCsSyUxsXiG/dZaoBAs3CT9MPYo1jHObMW+sexsMhZEe/NA96ZqPb4iRTKTI6E=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:53 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:53 +0000
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
Subject: [PATCH v2 35/61] fs/exec: Use vma_next() instead of linked list
Thread-Topic: [PATCH v2 35/61] fs/exec: Use vma_next() instead of linked list
Thread-Index: AQHXk38rgHxsfRGd/0isQoVwrht0gg==
Date:   Tue, 17 Aug 2021 15:47:23 +0000
Message-ID: <20210817154651.1570984-36-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: da2e62b6-d785-4c93-f99d-08d961966010
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4236F96C4695E9385EB63729FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eaXSoRo1mA1+sJRNt4FhXZdaNxpteU67taXG3BIWbudn4UpPrZxZ7EURPItb7VYfAPa2JU/LvYqfFY3jNWcJMv6MHO0Z2CLRNSTZtg5E8drb0JTDZQHWi0ObVlOapihfMenQ35FyKfU8h5hV0by97ZvrS8DZuiecxR2mDGoe2JiY+tedrYd1OuTa8DLDUSSWhL2otqvGKCrhWS1GhX1EgPZdI5nzy+qGq7OnVe4O+fbOiKwFQQePJf26/Oe7BI0Sk7G1HMI6N4CVuW2eCcs4LMewIIvEt3iAnfj1sKky5nQ5359UCsL4A00WJGPn+GHtBXt3mwlkw0njZWhpxUb9ifluWBhKwsxbnJ5rHXfDIC7JWJ58/xd9+ue3l7xUgZhZ65Hu8tMJ+ZmIn5j4VlJ2HSaNiy2+8oatFvmfEtKi4PtWoUWBWL7TNbxQnAdhUyehb39KTdsMP3MKrqq8jrtPf82KIxuv+wUrN+zkyTU3vxPrlHShLzzjODFh5jEC9nZ0kwfh6VWqPLjI+XIjQV7iG2ktisPQnOBf0Y2U8yDNIHmlB2JYrR3ptoQWMjGHwrnTzHIRio5HRLXwGk5jDpevhj8WOKbdR0m+U1s5yaSbaRras/oAFF8Qi6uANpACGrwAa1BvBJ43uVdoDkBnBCSrRDJFRpbWdEgFqld10FAlTpNYbia7F6AqvqRp4np6RlU3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6666004)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uTmPO7kXRjxYZ8HGKDnh51v0EGUpIEQJd3pcJpiwRs10EaQY8Q+gbaP26m?=
 =?iso-8859-1?Q?7+uWfgNOYAmk8TdLctaFI5CV0j6xQA/AgjTaNdjQO2fUHqmQsIbtUBZsbm?=
 =?iso-8859-1?Q?T93W2TScwbCxy1Om+XUnTBYY8vhYAXSKC+QfaOz51hkFACnBS5ZgIJbteE?=
 =?iso-8859-1?Q?vi2IXAR2gVNZxZh8YfNyFY9HrhBzTCsBE6dIaIYT+0fzRQ5/5F/QqctuBZ?=
 =?iso-8859-1?Q?ljnpHWcj+MSPmWTFicR7OzfjglVWXMJBy6PvrtOQiCBEK6zwOxeTopNX5+?=
 =?iso-8859-1?Q?UlsxfWwk/RF4/CFzN1yq/FkCFyB5bOTWos8Y4EbHgXZ40aZKRYj9jDs+gK?=
 =?iso-8859-1?Q?ujazLZUdssqblNfwguWEg2H/pgOapSlYDVeC+LpFj3tY4j0/tNEMTYq/3B?=
 =?iso-8859-1?Q?cz/2Miu2CW5JvSEHQXkQCfcWpmY6vx4WCHWOTLr8Og7hDJgQ2grH2IpyWN?=
 =?iso-8859-1?Q?TTgifB2W2S/WuKfqIKTrnywKG3rQvjmhoIj2ljib2/4xrJHcXQYVksF4eP?=
 =?iso-8859-1?Q?vrUIgCy2kETqZ2NB9S/eekD6L23zeHuMwWM0trTRqmeYL3yInMr7Se0ePh?=
 =?iso-8859-1?Q?6gR+ZS+S9gHswiQbv6EFOViQQN3neuDbMTXEFiSCPNrkoXc4Hf6IF6TZGg?=
 =?iso-8859-1?Q?I6hEzAZ0dfCUczB3YFCJ3F0crsycANbQgJEsKVM5zrEyZuD/bao6BwrD9R?=
 =?iso-8859-1?Q?wpW8OFOXVxpooHhScY/rhfl4BYvajSTC2JKPZ6qV1ThYpSQpPjiINgMZjW?=
 =?iso-8859-1?Q?l2LdaK8d7RyX4zQ0DHVtSeL8wiXkc0UHQYSvlpPsGRXUaorqkHbEvykSNL?=
 =?iso-8859-1?Q?azyVMRiS8TP7PiJ0hRyFhMNRNufgIOLnvcdznBUFrhlshPJECkf8wl8jz9?=
 =?iso-8859-1?Q?93bqercH/uttQs6trOxiCLJurC6qUZZhSGEeTYKpSsjjGKnkaE99046/qD?=
 =?iso-8859-1?Q?t4tdbHWbZMMsK0GK1BomIaqm7ngsH0S9Zi8Lj8YC4TG+Cll55cp6FepE1T?=
 =?iso-8859-1?Q?CLCMiTdQuLx+np76YBHwkCnlPa9NEo/lgDUrirhfwJrp8BPWNHaNzcuF3F?=
 =?iso-8859-1?Q?AAzOkVCJz63VLD3wkrNgTXq5LNh8mj7ZOBErV4I2wQoivZQqwAPmNTsvnl?=
 =?iso-8859-1?Q?UfoW6WVFo24c2Y2ksvU0YwfZmvYXSMGwrZvw5rEGVqQDjJZAxqIu1PIkSK?=
 =?iso-8859-1?Q?zRJlg0zbu+ROv0WoagyxbAj8d45M7g0PRxZ/UdB3iSZrinA6moVQDWC6LU?=
 =?iso-8859-1?Q?Yw2nOGa1KL6EqNJTles7xTsURnTjZS9F5JORTCaG6P/Pk11kGlKRPoG8lZ?=
 =?iso-8859-1?Q?yFTzwyQs+FEQILMEXTmDhMiNauusAm9p2PZ8l+iLupJ3qnGBKsqJ6uDNyu?=
 =?iso-8859-1?Q?nnegNyIfiU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2e62b6-d785-4c93-f99d-08d961966010
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:23.0530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAE/TY4RRXSe505WlIhZHrLzP/n+c9v30fMpMtf+tdWfOdXPQ/kn15yM84Fy4kpH6jVtTe5yvmrxKW19Dw3sdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: Uv61yNOEotdQjEBh1AlZLnOcvzmxPYwc
X-Proofpoint-ORIG-GUID: Uv61yNOEotdQjEBh1AlZLnOcvzmxPYwc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/exec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9cc6bf3a5f0c..d3eb43866e1e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -680,6 +680,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	unsigned long length =3D old_end - old_start;
 	unsigned long new_start =3D old_start - shift;
 	unsigned long new_end =3D old_end - shift;
+	struct vm_area_struct *next;
 	struct mmu_gather tlb;
=20
 	BUG_ON(new_start > new_end);
@@ -707,12 +708,13 @@ static int shift_arg_pages(struct vm_area_struct *vma=
, unsigned long shift)
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
+	next =3D vma_next(mm, vma);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
 		 */
 		free_pgd_range(&tlb, new_end, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
@@ -721,7 +723,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 		 * for the others its just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	}
 	tlb_finish_mmu(&tlb);
=20
--=20
2.30.2
