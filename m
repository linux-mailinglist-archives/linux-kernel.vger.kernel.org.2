Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E761A3EEFA3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbhHQPyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:54:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36290 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240415AbhHQPt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:58 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkDcj023523;
        Tue, 17 Aug 2021 15:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WAM/RusK+7/MbUtJt/oyOReD8OxosqNjU9qOouCSFho=;
 b=e5WVpMBUhm3ziYDtXAZmvZemcykAeDJyS4/LxfwTSFODAYpFi9zLNS/mYSVIfpZI5J4v
 FURvXJe3PC4djzWqRZLDWnzBfspsjo53w7DKeFZhRw/zcyi6/37jJvTqg89TMHM77Wgm
 WneJTYscG56pFx8Tb54UombSlrACtch4Xp9+S9KTWoRnqv4G/IoDmDeuhQv1ode43sxO
 FFMqWMAGrdIGHM7Kes7ebUyo0FMj6pq8DqAobOjWmcPEuS9s03ZrR6icFZZIX1SXFSLA
 SsRjLBF4hUNx61FSpX0S6ul6pRNorOr4vwAZrf2e/d+11Mp8iX8BpcMVP/RUMTFkq6dj Xw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WAM/RusK+7/MbUtJt/oyOReD8OxosqNjU9qOouCSFho=;
 b=Te52uGs/78aeKvEsRZ2qeof57HzfMNg6G9RxuawV0J4jyjeWViFVlA0rWdGkRswr7u9v
 WA/j39GqQBEUrMNR9ez7nk+PRx/Q/VoY/5aPYc5/EST2xoj6AVf4HKfy8wFmNGMNn7zd
 yPxTGbY3D5xl0pozbvv9auPQopXOe+QRrzfEZ43V51euYdTerypeSijOQG7DKQ4w3NfT
 KM2IojOPBxcUcJMa6AohsrHXYcKF/5K64KOc19w2Zf6BtYLTyes+tKmckfzX+VcavOPs
 VNNt/mA/w4nI45BtV3HDKl8+9suGD9NY51l1K9vkYhcKHp6FCWH/CH+q7vRdpQN0l6Mg GA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd4kfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3MB174002;
        Tue, 17 Aug 2021 15:48:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 3ae2y0d3v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqK4MnhBhu+BBkp/H/WWMN8XX/cIYRBOE5NXT6R53GloSqkk9PAu0LsK246OLbwGfoM5gHyZJNy8G86Ui3NkChSTEVgMiGdaNY8qgaLyGmLiyhVrvDcYDKfdekmBtJ/XArNN71cIckPqmfLBRZ6+s14BNYfgSdiWBuydrfxmV1gnp+0RCD2JDRaLjuhpDKZfNsDO8O0oRWIWDqtcYXYx4IXwQB/xCyMViaCIy2i344kMTnxwXkYWydeqUPDbN0M11Pohh2OZ1RWg/rrTCNOQGBOZQVYFc0qf2UX7GzY6gaLKJ3bmDo8N1U110zhLw6xOGWsIRht5GDUDx+aFnkMkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAM/RusK+7/MbUtJt/oyOReD8OxosqNjU9qOouCSFho=;
 b=PX0aeVfJqA3fpF1gmK1zPNr7AGvnHkDaFVTz6Vy2eK2LMZHhny+1garMYVhSj77AwS+1SA54qQGuKIHe/6T0FyAmQFzAeO7hADyZTd+8wVDfSDCbTUM0zGCVju5S3YI2N5JRyL1M8qut16sXOartd3jcTB0i1OhmDwumvSYMw+nKvmy7LshLl7+gYQox2gnE5JnUM82JOpzoxPwTw6ZFS9ofZlyTMpHVWRkaJ0X0jsIiB40e1i0jpfhbR970+2kwfi4hXKAlAYeUyheg8ldLIkay/CCuSay79bZZQVu8dHKx6cFcVo5geXCLXL6N9mNdlkeRGPYs2JV82MqY6TaGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAM/RusK+7/MbUtJt/oyOReD8OxosqNjU9qOouCSFho=;
 b=j57qj7nUNHrribvEWFu9DndKVqIpKDU/gqyPeZXrnbURp1pXPEuGXosNplLTMSvsjxskToksu2acyxVOljwqSjaxi/bTydSvGyjbxmq5tjCGc2U/7npWE+VORtOqerAc47+gJid+xjfsyK5GwmMA3KUSTKLttgfU1b3SNCbbOGw=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DS7PR10MB5024.namprd10.prod.outlook.com (2603:10b6:5:3a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:48:29 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:48:29 +0000
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
Subject: [PATCH v2 61/61] mm/mmap: Drop range_has_overlap() function
Thread-Topic: [PATCH v2 61/61] mm/mmap: Drop range_has_overlap() function
Thread-Index: AQHXk380gFkmMkrbO06NtDcsIJC/5Q==
Date:   Tue, 17 Aug 2021 15:47:38 +0000
Message-ID: <20210817154651.1570984-62-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: e8734769-46fb-40e0-91ec-08d9619675d4
x-ms-traffictypediagnostic: DS7PR10MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DS7PR10MB5024C7600901147A5C3BCB69FDFE9@DS7PR10MB5024.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9R8guy/N0GkUectjITubZg9AQ8E4j8g0INBslR5ZSn+AE+mhjqwwbBc5hH3WOCrsZnXNeNxtrjtvx/cCA2wtagSdZQJmDknYbhkkI50q7z4eBVlOnApWxjc5PNUIm1gs8DLteb6VLD88HNk3UFAGq7/2Gtua13LrKFK8Ig5uPYLmYhleg9gVXgTWtlu5/DNSJ9UdR5ulntsq/WaeW7SDytkzusB8vCdZM87K4JMiUGJHcdF8Cjqz6yHlJ/Vj15zhFn8S1HJTAv6wKDv3+O3G0CXz45DjPX4rnl2Qju0BJOlB6cfEH1kVtlhtNcfc5Ko4uJsTIDPn5OQWlOJLJfNt4qScstBM/E+0hSmrvlBWSMC8sjfsi5xAHXeXdCUM9lGk+ZBzM2fatFqz+f75SpSQxqu2VPkpjI4Je1pDYDsW/5aj2HH7+/NLQ3SMNbrrCgk58+QF499htcxOroIfrVdBij5izktCWVmHObMYlCvANdMPNMdkwjoWidufaxAhWE1e4fgrpUKzS9QAFsyb8Dx6tahGad3ZloDIRresHjflxCceAVSxZQXl2o4qv09AQQLqxrsF0xlIeCBAGd7VaAjotHbd298RTpdMn2oWjjN8EQw1rEIulrn24A64vgxLwdKj21NR0/XlyiyzLjWq9GPpEaejwqA8r2s3eBSVxSjCPlumxSF//K4GXs76dV/KP2m4HbsGaWupgfZtKyReSB4E7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(39860400002)(136003)(2616005)(44832011)(8676002)(2906002)(8936002)(86362001)(107886003)(478600001)(38070700005)(4326008)(83380400001)(6666004)(71200400001)(1076003)(91956017)(76116006)(38100700002)(5660300002)(66946007)(6512007)(66476007)(6486002)(26005)(186003)(66556008)(66446008)(54906003)(110136005)(36756003)(316002)(7416002)(6506007)(64756008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bpYXm53C0rXWOPvkiFYGPKiDFX+W4NXpd7LADfuRii+fM1jwCaZB41uLzY?=
 =?iso-8859-1?Q?SW8YJLQt6micLoE34o1N/kZoNp/orAFmAW8Yll3hMh/fl2U1lq3QD8mqGm?=
 =?iso-8859-1?Q?1fb8aRT7vWXDIuj/2ePGuurhYmXJkz3KjCf4WbnOn2fRaEqr8RLwBCM9UV?=
 =?iso-8859-1?Q?d/IPlK0BQntWlCyyCiGJpCbkVdmXa3+chQVQNJQmsRWAx1q/PifTLAY+8F?=
 =?iso-8859-1?Q?CWjuuldLZgaFiym3AklkDNSm8jyyQ23zDtFZjjSTkpMVZ4+1kcRTl06FAk?=
 =?iso-8859-1?Q?8+nQgGXITd9MS6BsiQUTmYZCQRv4GJoSBh1kXYYyaygJixf1SS+/3iX/65?=
 =?iso-8859-1?Q?MFkQN+2BWd8nU4Fk7gjUJ3e/GcDjCMi4nrwGto3XT2XklAKDiWUWxUGsIQ?=
 =?iso-8859-1?Q?gaKdpaFO5VoK3ny6rRlVIWbCNIuy9gM/OM/12G8/6USfeCCvoXD3RcnHux?=
 =?iso-8859-1?Q?jLwkZsv4GiFqfe8YtmTN35K4LrZAPHcCVFKlYevJX4qvGDRRrBz0124ICA?=
 =?iso-8859-1?Q?z6OQqvXNVzYgGlcGeS8U5in0B/vO78AuRIQmzH6ForCnRIP174nqsQ5SZu?=
 =?iso-8859-1?Q?bXVCy+AXap/yg+xI5l8tH5LpUKBlvyr6cOO5DAUWShhoHyOjCz56GzNStt?=
 =?iso-8859-1?Q?tbk+2AdHBZ1ZBzBWZy8b09s5SEbKV/jXSNlv6DqVRdrsifdI1Fws+e5sVb?=
 =?iso-8859-1?Q?uiic3wsR/zdTXxWv+kwa8zAWkqYITRJSREZlvvq+5bYvSHuMPlMuPrbjUW?=
 =?iso-8859-1?Q?7Gwv6lXLAJM1eheonSxVw9HLOxOfRxJ1LC0Hi8FgqEi83nOlvqOlncI1SF?=
 =?iso-8859-1?Q?3CmyanUlf1zPjm/qTSP5QiElXAjxxnfoVS9F8NhS+6J8SiI9AiwqLkEYRZ?=
 =?iso-8859-1?Q?XM6ACcKqckYmGq9BfVZeBiiadOtx66HpmEksqhOCsGukFaTAVgRqb04zo1?=
 =?iso-8859-1?Q?kX2cQYbHRql+5iUeL1Lc87VX6UbocJLFNJorGpXsU2a4PT6uvJheWftAc/?=
 =?iso-8859-1?Q?HjeWwB8y1RrPZdg/OODKrFRgrriurUEUMvoeSojFIiQxIdEsNCBCk4nNGs?=
 =?iso-8859-1?Q?LbA0LV/25Xo5tst1yaNfpL7eoBiC+XJyAcx30pum7eIUb0l/ElIKcbAd7J?=
 =?iso-8859-1?Q?TXnDwx6NdUVRXQbtnNGHXKqPRrBLOmQxGhJyU5iEgiHEvQN+fmC0jiQfMu?=
 =?iso-8859-1?Q?TT2uZXCqfS2JzsA2FPjqh0xaKQ7b5d1uSATxV3f1c+8JOfVFMAc7C3bI/f?=
 =?iso-8859-1?Q?i3YA9mFNgZuI9cEfPzBTPKd6OpObCQO04FBhlf6uMLi73OLmSyxW8WJ+5F?=
 =?iso-8859-1?Q?q4o9Mkehw6ZGQQsQZNWSUUzGIYQ1KWYuqVnAu1hu3T47B6+aIxkJMazfkF?=
 =?iso-8859-1?Q?N8VbH0RVxg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8734769-46fb-40e0-91ec-08d9619675d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:38.8100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TU7fpCjc2xj0bL2K8+E4e1y7KEwgYckJvbI5hSmVA4uNayGprXgIf4vJIRgivJTj4pZTnQxS58xpO+MIFIy/mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5024
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: 1rZuji0nxLus3h7-RH5-jw5kqkcIWTSn
X-Proofpoint-GUID: 1rZuji0nxLus3h7-RH5-jw5kqkcIWTSn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Since there is no longer a linked list, the range_has_overlap() function
is identical to the find_vma_intersection() function.  There is only one
place that actually needs the previous vma, so just use vma_prev() in
that one case.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 51 ++++++++++++---------------------------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 06666706d5d3..2037a330b072 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -435,30 +435,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_=
struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-/*
- * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
- * sets up a pointer to the previous VMA
- * @mm: the mm struct
- * @start: the start address of the range
- * @end: the end address of the range
- * @pprev: the pointer to the pointer of the previous VMA
- *
- * Returns: True if there is an overlapping VMA, false otherwise
- */
-static inline
-bool range_has_overlap(struct mm_struct *mm, unsigned long start,
-		       unsigned long end, struct vm_area_struct **pprev)
-{
-	struct vm_area_struct *existing;
-
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	rcu_read_lock();
-	existing =3D mas_find(&mas, end - 1);
-	*pprev =3D mas_prev(&mas, 0);
-	rcu_read_unlock();
-	return existing ? true : false;
-}
-
 /*
  * count_vma_pages_range() - Count the number of pages in a range.
  * @mas: The maple state
@@ -558,7 +534,7 @@ void vma_mt_store(struct mm_struct *mm, struct vm_area_=
struct *vma)
  * Must not hold the maple tree lock.
  */
 static void vma_mas_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct ma_state *mas, struct vm_area_struct *prev)
+			 struct ma_state *mas)
 {
 	struct address_space *mapping =3D NULL;
=20
@@ -578,8 +554,7 @@ static void vma_mas_link(struct mm_struct *mm, struct v=
m_area_struct *vma,
 	mm->map_count++;
 }
=20
-static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev)
+static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	struct address_space *mapping =3D NULL;
=20
@@ -604,9 +579,7 @@ static void vma_link(struct mm_struct *mm, struct vm_ar=
ea_struct *vma,
  */
 static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma)
 {
-	struct vm_area_struct *prev;
-
-	BUG_ON(range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev));
+	BUG_ON(find_vma_intersection(mm, vma->vm_start, vma->vm_end));
 	vma_mt_store(mm, vma);
 	mm->map_count++;
 }
@@ -2781,7 +2754,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	mas_set(&mas, addr);
-	vma_mas_link(mm, vma, &mas, prev);
+	vma_mas_link(mm, vma, &mas);
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
 unmap_writable:
@@ -3165,7 +3138,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
ma_state *ma_prev,
 	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_mas_link(mm, vma, mas, NULL);
+	vma_mas_link(mm, vma, mas);
 	*brkvma =3D vma;
 out:
 	perf_event_mmap(vma);
@@ -3317,9 +3290,7 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
-
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
@@ -3343,7 +3314,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_=
area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	vma_link(mm, vma, prev);
+	vma_link(mm, vma);
 	return 0;
 }
=20
@@ -3358,7 +3329,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct vm_area_struct *vma =3D *vmap;
 	unsigned long vma_start =3D vma->vm_start;
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct *new_vma, *prev;
+	struct vm_area_struct *new_vma;
+	struct vm_area_struct *prev;
 	bool faulted_in_anon_vma =3D true;
=20
 	validate_mm_mt(mm);
@@ -3371,9 +3343,10 @@ struct vm_area_struct *copy_vma(struct vm_area_struc=
t **vmap,
 		faulted_in_anon_vma =3D false;
 	}
=20
-	if (range_has_overlap(mm, addr, addr + len, &prev))
+	if (find_vma_intersection(mm, addr, addr + len))
 		return NULL;	/* should never get here */
=20
+	prev =3D vma_prev(mm, vma);
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx);
@@ -3414,7 +3387,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
-		vma_link(mm, new_vma, prev);
+		vma_link(mm, new_vma);
 		*need_rmap_locks =3D false;
 	}
 	validate_mm_mt(mm);
--=20
2.30.2
