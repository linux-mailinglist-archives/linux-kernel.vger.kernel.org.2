Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C9B3EEFBA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbhHQPz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29926 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240331AbhHQPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:03 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkHqT018099;
        Tue, 17 Aug 2021 15:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=deZTEqPxVn9n/v7G/J/W8/HDLRsExa8gUNvxO4VDWKA=;
 b=rFhePkpN5vXVDTBSFG6g83/veYYTqPwjxs9RELerflUrhkEyjOhPdliwJUY5a1YYtXa8
 /1hAYYO7iuyiHoVk0QfLG9+qs27KtBNu2CNHWcbJ88Av+8RRC5g1mH+D3ddAeoWjvR0q
 wnZ2AJ9uHty0AI8qu3Z/XH9tndJK+KpxRlCRPsu2esYGzZbj11PeTFGknTCUpL9qe6Ie
 +SyUe4mZ5yRjZi8GuLWh0t6B4Mu81IpGgHIqPveULqGl8jAHhVfrLYcI9LsR6GfpxfQP
 0yx6S3Ug18rF+P5IraZEk2ESMvwLZCc8LJAJVSuyzUm0WhmOsTHxfB8JFrvtDMfREa14 sw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=deZTEqPxVn9n/v7G/J/W8/HDLRsExa8gUNvxO4VDWKA=;
 b=k9uD8+69bSbPGc/BbXSEidcS/TxZkwO3umq+62EqjuswwCCFWhQZAmkNlVaX/sb+7bOR
 cs9TCCo7AVXgaGG3t/GpPvJtDwqs6dqNn/4tlbOrOUCOVE+AtBmy8EY+RsFNDysGn4Gb
 K2jEtQQ3bcdzF5OnGVPAd2+uwdfupfCefsMhO7c+1G0IbLUGb8H7ReSDKbAP8KNnljIx
 ClX8Ilh0jY7CJWuBQKTg6J8bGqdzL5AnOTPiQUYV7mAnB1eGIB20X1T7qKxmOC0TTSaK
 tKkXjDWNwF/PuGp55Pxrb7Ac0hWHtvx/NV+ovp413DG2xzjXnURQtSrx0DlEjRADKvf9 aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mrc5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3Og174039;
        Tue, 17 Aug 2021 15:48:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3ae2y0d2vn-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkcT0cN53qVxNFRUWRWudSSZst5sW1LqDlIuvNbqOTf8AxtvNyarCnn3yfxfn9TT+PM+WbyzF9yILRcQLJvMjmStsWDc8oSB4DXVud+gpJ5sNDMejFxPc+V4xDrL2YWpNsxX+zTSukzCo8qskn40FTQkxCSdopm5ShSSWQygtjxJRuTRncBPf9COKBnJaE7j5CEzWAfj4Bu1NxWcrwQeUa1QfoyDW6PNcHcnqHtOcRdcYhU+S4bqdWcxZom7iWpi2oiUrdZ/+m3bJ+RkCzvn1kBwF4GvrgWvf1X4CE9fujiE6EQiyiy5ZOw+k1E+AA24yivAdILzSpSPFXJdKhE7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deZTEqPxVn9n/v7G/J/W8/HDLRsExa8gUNvxO4VDWKA=;
 b=gahoL2PYzXNYeHeQm/9ICJpxobArilLJ0iipD0K3hfXocuTFcglDMuXRmfnOv9zBPxctZKbwD4Qm0NyYDjsG64X5MdqwD6qFrhmEgyg/mT0ZbDyft6/nkomdbIWfkC4c0QP6Pf/6Vxaays5bSBFxjhvbYAU2J+VZMyAlz55+IQgDJ78fzzhlxzSpNJGqyq7isjK/BbaudQedZvljhlO0L2+UBt7K5rc2ad+SOn2KWxt9jF/s4HAC92lI6wVVtQjZNdJNp+UmcuUBoFjXMk1HJABXnQ++oT2PO/vl3BqQKuDWuKlmiLf/SvkfgIAGXBLqCdrerLDcB3r589jFUvEaHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deZTEqPxVn9n/v7G/J/W8/HDLRsExa8gUNvxO4VDWKA=;
 b=Uz/EkxchlUuDskFI04syrjMOYVO/PlqW0aeHMBC2z6rNXiQ1pIFi1CnXjVqxaNWs0hoY6gFwp5ITOStyltNnhAV6f8mNNqnMjbW9KVotS6Ubegu5hEtcK9ciJbQ+klTD8tfBgkPxTVHrJqGo4CDfwR1yoMgMAXTHJWFYdVyDHBw=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:58 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:58 +0000
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
Subject: [PATCH v2 56/61] mm/msync: Use vma_next() instead of vma linked list
Thread-Topic: [PATCH v2 56/61] mm/msync: Use vma_next() instead of vma linked
 list
Thread-Index: AQHXk38xjI/1b3543U2RwtmOvI9xqw==
Date:   Tue, 17 Aug 2021 15:47:32 +0000
Message-ID: <20210817154651.1570984-57-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: b49f1962-ddd4-4c9d-2d18-08d96196633b
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3580E529AE63D3B5229EAD02FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: veIQm8w6fCRisMEjdtCrt0lFtEU2VG8tb877AFWMkOUlkeXBHEqSi4Rn/NRDBrrLJCLYaVrBeWcMTA88KKtjR8jdNSpvOkPZ/11bT/KWPqeM94ZMa7KX36/d9Bvfzn+Nl0Wq+Zfyp3retzfkceX0t0YQ71MR0q64YX4sescG3QNy9GoPSapLUWQqcZGNaZjU80krO5q49xcybnBXYpxNvUlbhDPJej5fJg32UkXGv4Iy9JRiC9bg25XLXwEA9WAoC2HP+wX6CdcFDqylzxgqPfXkE7KZl8ndl6UYMunWrqSkZ+iRv8wiVCy/1ur3b1YEb0jC2cWulKfpUv6PLrWKhU2nP8k0PPwJlE9rH5WFzsSmCAXy2MZJPfdOOX8TrmUASoyLRjIKDyW06iRuvPmvGqOJYvWgOjtwn3S/VUam5OliRORcvNTUomj52YAtd5LBJkx72lwfOam0NC/kA76bkSwhN6fIxRhgaW2sNznJABxW6YMNgmJhJ7OQBEtR+tY+y4Qz/nwJ734JmanWO2/gDv/qm/wTIY8ZMPB2a7ZdN/nisi3NKerQLD6+96jNeq63TmlWQheYEBdCfPwFjg/6G1/HaufBSHm2HqE0CLkams3NplVKG94qeiOY9GNOSVXmH+1V+vjopfa5Xu/oN0kdZLmQPmQPLJf/V7kBk5DQ7/SZOnbtGEX3dMoCG1kcJD1i4YiTTpnswWYo7YApLqzF0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(4744005)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2AI7Nx+b3skBnRF5QdoJ6+cZvbmvetzNPMBTEW/o/lmxhCyVnheZrh19rO?=
 =?iso-8859-1?Q?M0+CjB8DeL3b4msB7Vw1+z79yfgZkDEDIVumCsLPnFyJcWWxAtKXzSKuH9?=
 =?iso-8859-1?Q?TVgqthMYJtF3iYOXSKQZdhnEXPD5qE9BXHILSYlJtMXGXP1iuK2VuSJQtR?=
 =?iso-8859-1?Q?xWWa0H2nWrf/Gu1K5fejhhv4WeUR9Y8Incy802b+a1TQ3QacxUL7nsL0j3?=
 =?iso-8859-1?Q?OrO2z6VFJ5y7y+ZeN1snkykWWPY81dsT2yzw1PWYipFjdMTm+v/hdUnbc5?=
 =?iso-8859-1?Q?uM/VGZuNoSxGARZV5lo/zdTz8p9tRUcGFaKe/eViYUsZzpZ/CFYI0aELj0?=
 =?iso-8859-1?Q?BHD5de8Y5mfdmjIiZqMpV3+KA7a+aoPV6cQAyyGKCofSDFZB0H2NU6V5wJ?=
 =?iso-8859-1?Q?F1yIcXB9Mt28L+E3eaxhTedTvf6X9ua0L6hpyRKnNcu0Xr7s6eA66cw/57?=
 =?iso-8859-1?Q?nx8q/4hsIla81uZVpUSj92m6QdYH1x/oQHgDOzDWHGD5PydFjguwY19shH?=
 =?iso-8859-1?Q?XncNxBneeoVJGn2bhEaD3LefNnUXkp0s/7ntFgacIW5FS1313Y8cqpj8oF?=
 =?iso-8859-1?Q?qFOJRudHb550uY38ICTOP7Ded1nBcO5tsmiRGAf0LLz6fAz95SDaniJ94o?=
 =?iso-8859-1?Q?ZXo44iZ9xTzkt/D4EvF0ozknsZEtpR4fCiySGrBVmgwTh2w6uYrSqhiqAi?=
 =?iso-8859-1?Q?o6+QTrQvC3B8BX36DqXUAlgs43kbbcXYOl1Oe5oQcVNtch1scZmz0zUUav?=
 =?iso-8859-1?Q?O97yN+GIi/cEj6FmXUOmihqak6GgPx+k3qd5AXdhn/bGwGTnVZXEvrjMPC?=
 =?iso-8859-1?Q?zH/B0t1ExOpEb8UdvSRQd2uLO94FQ11M4vdDYY6uabqodbSKp8LOBYn8cA?=
 =?iso-8859-1?Q?0ykVfx7kmrOqcs7VlJD4iFaeUCWp8fwgPDT3UNJt+lfp6c7SaKWx9Rmmwp?=
 =?iso-8859-1?Q?/hNhaZ6T51+qEiOevEWsEs9iBq1LziOw3qfMmVwGNkgsnNPY0Y2Gt/LiHY?=
 =?iso-8859-1?Q?TA9fw+g/AZDKs+hrNAy7+GrByjsBpt+f8Uy8F9Ykwzc29rXdG0Wue/jaOQ?=
 =?iso-8859-1?Q?Kq/n6UgWOFgs/cWNpBHkOTijsEQnEBQTXgqYNP4Pl1s3OBln0VfMVoZpoC?=
 =?iso-8859-1?Q?tUWtOcV7WbU6pNa/B1iv5G1lY9ra4/yYnWvgCabBojtZkKWMloWmG9GtG+?=
 =?iso-8859-1?Q?M8AFmMhOxYqzE6MYWU7DOtHulbAhh+25ZFaop/DPu6IrWjz9S7YPyoJgXW?=
 =?iso-8859-1?Q?5jAiTSmRVofavHB00GakMG5+8+/j8tBqj/CJ0LP5TtjZOOIW/TOdDiMuTP?=
 =?iso-8859-1?Q?T/Oni93A7XFwD16oJ0vxOHpO25QsK8aXxZ+Vs8FMaw+Z/bP30dMh2sGI3N?=
 =?iso-8859-1?Q?XN1QC53wt3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49f1962-ddd4-4c9d-2d18-08d96196633b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:32.9437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iim7Gf5fLqhSJHmD45INw4DwTtdhmFfnD3wCzaOzvVHq/wReLM5blTv9PYNK+zDAZqUa/Nig2mDOlGObatyzxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: KTO48YnAhiuDdgbmifl-PCOI_8VL6KXG
X-Proofpoint-GUID: KTO48YnAhiuDdgbmifl-PCOI_8VL6KXG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/msync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index 137d1c104f3e..d5fcecc95829 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
 				error =3D 0;
 				goto out_unlock;
 			}
-			vma =3D vma->vm_next;
+			vma =3D vma_next(mm, vma);
 		}
 	}
 out_unlock:
--=20
2.30.2
