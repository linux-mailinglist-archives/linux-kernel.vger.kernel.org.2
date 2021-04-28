Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F0236DBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbhD1Pib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:38:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37534 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240081AbhD1PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:01 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFPXux015928;
        Wed, 28 Apr 2021 15:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JnYCMbVDsGk0RE208+vyo8P31rDLEyJaxvHnJU5wRdg=;
 b=SRVbzf9HGBBZh3T7U03XJa7A/0Kto2vBrYhgDYi/GIjLyifvhKqTcEwDSycj0D1L2pim
 2zXK6ap0YUu/HTbfS3bvmg1MJ+z+3jpE3nUa1l0rlzzj34ODI8cxZ4ln+Igg0rnV/zw3
 rSgqYjPNG0G+aSx7Oh+UNjnVR8x1jLLosOZOgRdOua4/qtgwSVR9cmUp3eBWtOTEaZQj
 B5x98mUqlfpAWAHZ21Aku7a78jFzPQhS6aNUdVzeeiEp0WZ8urclvbji6vdv3EpgZx0u
 tU9Uo8v1ikrO9uLnGOFXrLzBkvBLOTC1O/gSNzJeLUSuV3lsK6ztHddujD4F1nWmfucI LQ== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:55 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFZorE158269;
        Wed, 28 Apr 2021 15:35:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3848eyqw48-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWFVDYZi5pdrJA5L3SFcW/IAqtCfYKbc6VYdDbaaVlOJYGARRtfbNk2y2Rem7kY5OcmUane/UE5xEm+X18n9GPkk1ZgLCn8uGGMdD0pyr2hmGlVeOwXBiuygj+gGwN7iIa5Nmxm7QmFeZ+JSedyZCUs1sNE3wYMfsDtcjph2dVJIQba4TG1mMYvnbQJSGClBVO1ZF4vThc6tqo0hyJ+BgWwn4lxyZnwKgMTqnyuUTZ0J7Z7uxDMCspNhEhPugfMweSzh59ZVEf4mjaTulCHGqSGSRfio7g5/4hOmT/xYeEc0pvINa/2ZQ95mxwVgpK8WM7t3sUdGpISy7HC/l81Xcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnYCMbVDsGk0RE208+vyo8P31rDLEyJaxvHnJU5wRdg=;
 b=eY6Lepv+7LEO0w/lL0kShNLpa3jGCdlZ4yuD57c6qltDyh+dTQFzDr9f31BeAExOZ4lYTgCDmBogREBqjgODeXyqDfMZ06jWg1O+QZhrMXxNoce+3nK+j69w7grearM/dO20ewNvjmsB9ITEpoSoVKakPqW+I5QsmvM4c7Z4w6IOv6EPFUd9dndBUiL9W2ftccOmJS/lVWfTJVBHQHY88tkjvzWv/d5RQfAfKVWuwj/jCahiMGgDZSx5gvY8600qqxGokjSazOINwzpqVuXChXCfoFhghGKQbo/01jo3GSCUfVwAfzDY4OMIPB8ODQIXLS8jTjH0YH3jXJxlciDrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnYCMbVDsGk0RE208+vyo8P31rDLEyJaxvHnJU5wRdg=;
 b=sgSad8Fe0VKTVoHsRJfRHWhqDw20QzbfQfm2GM4pm7c+PZGC9Sx7NjwwA6BVeEekw8jbW0KHHrQuXiSoyzsVmryu488OeSPpVHIqQBbADEde7xHWhJ/0GvgTCNTng6TxMTnaMhsl1GS+xCHjv5xxNOZhHhvto+Wt7g55Hwa3kRY=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:50 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:50 +0000
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
Subject: [PATCH 15/94] kernel/events/uprobes: Use vma_lookup() in
 find_active_uprobe()
Thread-Topic: [PATCH 15/94] kernel/events/uprobes: Use vma_lookup() in
 find_active_uprobe()
Thread-Index: AQHXPEQqythd/2uMPEKaP8L1OrDVOQ==
Date:   Wed, 28 Apr 2021 15:35:49 +0000
Message-ID: <20210428153542.2814175-16-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 414eb232-60b5-466d-d14f-08d90a5b4d07
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB449707004D5E044E55871465FD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z6vgbfM7lAX4pyxYdr/L4heyN+bPVHc5xxvBuHnKAk3riHlY49iM13BYz+v9ABh01youpuiGcnQPNErVwM1z5I+SJ5PuzyF11Bh+I0M4h5un8OC8VpQIQ60zvKJRnzzY20QCo+gI+3SeMnNCC/oWVbX6TuvIKMLlXOvuXWIarwHrk+cuEyE+UMv/kAp7SSzI2+nTOxfM3Vgu3ZqmxizuMNfuSZTuE2afGqDlG/obSw2kCfLbWZ7BCK+FCYJd87SJAYV5u1l4O/jTbp8eghtAGgVk9ftng1gz5SIezhGQT3hOJPz3Lef66E6DHmA4L0QpQ7oXrcnXSe/TfLyEUNpUPA93wHi+2v0WCLf/EXHAmmxMm/D+zp/Tw+y6oteFazEFzZVrXu+Nzxxy5PRAGT6E0CnPB67uwXkxcfS/ugXzPMUMhoJRaqBFevXFaLPSDGlzuvrAIgkRuIGX3U2zot+/eSQVCtFyGvd6ka0H+OtVEum2hBVEuuYgi2IEXGUV3H52mqDR72Res5esbDqRcuPV8w/4uAjqUKb/eVWibxoFZIf3fPuafpztKLPW+2MHQdrVLSlWUokY6BTaRO4Bfd345ALWCUQvez9zkrs7nWq3c4o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?xHZ9xcYRaosVBArXUS6UJ5wLQCef1WXuFToxdDxRuka5LrpFCjvPJA2Ct+?=
 =?iso-8859-1?Q?kj+/zZU7YaAWVQ7CAPxWdk8Lx4s12qL5wr7fNRgCwh0xWvLPgxkbKBuD/F?=
 =?iso-8859-1?Q?Z6rcrj73qBNz7fEMh3FlgdSlifKKuCblKAQPfwAm8ma/laj7akNWyChB8f?=
 =?iso-8859-1?Q?eJ2NNKe5ypcolk+2sItVwNLyYqbIoVfqjqPkl+IbsBWG5SZIcKJHUJR9bs?=
 =?iso-8859-1?Q?Qytln0NP85XgPmtePvzURTAqVfBvIx9tftKIcwvjPtM5ndihfvLfxetnsx?=
 =?iso-8859-1?Q?UMamLCqENmGuSMn7AdvXQCX1vZf8T9HDowXacG9Yg6fqwe2YQ7eRXnrfl+?=
 =?iso-8859-1?Q?ir72wtgp9U7xmfKI8WpDnilrhxEFuYxiyonBpbhMu3YhPnQ5O//m4gXA69?=
 =?iso-8859-1?Q?3sKh2u/sXiK+AZuiESRZn4fdEdt2ilscd8eMmeNXtovZkUSaSW8Zvd385a?=
 =?iso-8859-1?Q?LjHe+iPPoSY2kAJfFFwNUqJmK4ZwbS6Fxm1+rWCo05L2GjGGf0JdRb84jO?=
 =?iso-8859-1?Q?JN4RJR8UgJ//785nTezOurQkvyiOHPljUEEtBFA0YX9+DI1hmdDJmSCmZG?=
 =?iso-8859-1?Q?ZxBJQ9Z4Qn7cldEUz5NZpqGPWtEVWPaJPpyXlgwcl2VyD4Xx6ZYJeTnj3H?=
 =?iso-8859-1?Q?FTgeI35hhig7jGfm5W4KRBcslqB8JGflz+hY6E6DBlt6s8WOWGq3rQ5vyl?=
 =?iso-8859-1?Q?RvNWjkIujyz+YUj5c0LOPzyxLBYJBl5ZzaxX8t2BvEqm8n8DndF9Cb9BB6?=
 =?iso-8859-1?Q?2ZfBJYZipIKhOJ2VItjwXe1rQWU4jMEMKk6y/BKefYsyrAPFJZF98U/Xef?=
 =?iso-8859-1?Q?fet8rickqZnM8ZcWT1c+QF+vA6NHuSx/VdO3BUNcug/NZe+4Wl/1emg2I+?=
 =?iso-8859-1?Q?OuzM0suMyHAm1UEdJ2Y/yLFrQxIX4WYN/wazmm7232xjwpo2dJaEcdqcwK?=
 =?iso-8859-1?Q?XpZOZwpG+6fVWDdUV65i4AfVuCPUwhrgjV7S/5tgPJiYfPwM3EGwC5lSkX?=
 =?iso-8859-1?Q?0MLxsYbVO2NTqEGDR5ucED20su+ifsqdaWX6QOvUQOuK5iM+wwOLcmy0zh?=
 =?iso-8859-1?Q?dY2CQdORT1zEk9EMnJ/UgpJhTe0XBPbrTTfrj2AXTW4iVZaVANJ8rR0Fcz?=
 =?iso-8859-1?Q?7fanv0gb5Q9gFIdTFrlxN2e7uDBKxMCROYzsLMBYhi0wEK0s3DYQDYIQhL?=
 =?iso-8859-1?Q?zgMCYCb6QUamTHFWN8g/7qG5YFVN/P6VHPmPmqqDi2XlDLsuwEwuiT4kyo?=
 =?iso-8859-1?Q?sd3iHBIm6KLFXIIlQKZGECkfsAwn5cK8TtRByRTr7uXgVoW4K/p1xxJGKY?=
 =?iso-8859-1?Q?Kyii3AxR5XRm0ljevto0f3pAFPm+Ijmrot0q2RDeVstLbspq9VjnQmhRA9?=
 =?iso-8859-1?Q?+pf2DHCaNjhuDkksIQBj33Al/tydsEyQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414eb232-60b5-466d-d14f-08d90a5b4d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:49.9695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzt/mqhDDN76edKbRcnfx0HZyXnLZ75H26ASZQgZgHgQgBWOcgLbVsl3kItC8OksgxijCYQ0Hx7fX/0SYPWeWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: eJkNcWPR6k2u4ndV2oH8zVQcpPE3u0gg
X-Proofpoint-GUID: eJkNcWPR6k2u4ndV2oH8zVQcpPE3u0gg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() will only return the VMA which contains the address
requested so the code is easier to read.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/events/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6addc9780319..907d4ee00cb2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2046,8 +2046,8 @@ static struct uprobe *find_active_uprobe(unsigned lon=
g bp_vaddr, int *is_swbp)
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-	vma =3D find_vma(mm, bp_vaddr);
-	if (vma && vma->vm_start <=3D bp_vaddr) {
+	vma =3D vma_lookup(mm, bp_vaddr);
+	if (vma) {
 		if (valid_vma(vma, false)) {
 			struct inode *inode =3D file_inode(vma->vm_file);
 			loff_t offset =3D vaddr_to_offset(vma, bp_vaddr);
--=20
2.30.2
