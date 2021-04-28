Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBBB36DC21
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241137AbhD1Pmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58922 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240650AbhD1Pio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:44 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMZPb020193;
        Wed, 28 Apr 2021 15:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5ESv78N8Ki3xDjZ8gkhT2DOJrkrNc+eZLyeodwU3Tds=;
 b=ad11wUekgFRXwRc28T7IVbOX/U/dyW/ydo3kp5/0CSYa1pgRaEUVcWc7dD1PaDtKEFth
 7PgUhysnGIH0An0MhdTGDcPFM2LMn5zZcMBaqTZQZT9vMHVQuA0KDBGAgjciZxYu6PkF
 pn0Gs/1iF+219XD1f+YcvxX31LA5dtm1rnkO1XGNimM1CPYtdnBKuXhY3wvJvHVfhM0Q
 m4rS/rxIlOhqOoaawSwvnghjnYt3f3TYk/ZVUxFPZ/9oH7thRdrS/j5qxyQOrWoslV6G
 xUbrnpoG8Rf7AH0w18wBcIMMpUYb6pl5Z+1Lg5hDpRiR82eaua8pYL3vpZnOlpS86ToI Rw== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878kgg52t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:22 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWZKL146776;
        Wed, 28 Apr 2021 15:37:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3848eyqygy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8SDog5wDOjW1OgrNFYxWuHgpfgYjM+SXql9GlP5GFdQwvoUueWgSqqlxgTUFc2SHClmMYAt3mTvKVEKsIRsbXvHX5+MVsRbaAIwkU+tOow9ym1RbE9HU60nkdZ0oV4BhyRFcPvMAeorz5+H/ZifxAWzFIw2rIbAniMjjoxem+rFsIZ51DJHTsqO8VG7cAEx58DRxGjY08F3ANmFBqL9BBlP0WblEqsdAaSHPYkj7UgV8fYUsTUQjn+YkXQKMEnz1A40jaYo84KS4/bldDIRDri1beAhoTVfbiji3dKkzBhMZtRcgb00KIfQgtLTK7ntVnAmHWHmc3tmBRzokVaR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ESv78N8Ki3xDjZ8gkhT2DOJrkrNc+eZLyeodwU3Tds=;
 b=UkwZdz3Z6pa5lGUrqtiwAQUa6nxshMyCWQPr4g4bDzU0qksDL829bvpLWR2EWhnl4hOAOqvMZf+TvYR6pPVoF/bBTUPArX0UAjto4YFaLZ6ZmIiEd5DzxXpWLGarDdsVzFkI0MBv3C4jr4g7B6TslOmVWAn4BIfKGisk8yYXcvNeeRfKKHmUoAJh+yzWoKzNM8iADzcGsXvvFPhsDI8RcV3NKHSbNdfHl+GkAzmbZ5hA1r9hA6ME6urEQwG1XiJYBMt2ts4tmxpl6Et13ZuJERjbJfrvvDpfMc2sU341Zjks0oZV0MpGsaGIc4LbziN6LuZl3okiGuQuEiiEIkD1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ESv78N8Ki3xDjZ8gkhT2DOJrkrNc+eZLyeodwU3Tds=;
 b=cC5i+UtFPOGQR1siDFjXgnB6jQMuj84Of+CfC6YargyS6Op4ygizIsR3aV1v6mpxtuIIVCt2Sj/48gCwUMy8V25K353kt0yvx6qqhunXkXitusjdaI7zHdwWPxifqNWjUDd31MD1eid9jSe6SkRsHMEe1laERkOfEdYxk1Y1pys=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 15:37:19 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:19 +0000
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
Subject: [PATCH 61/94] drivers/tee/optee: Use maple tree iterators for
 __check_mem_type()
Thread-Topic: [PATCH 61/94] drivers/tee/optee: Use maple tree iterators for
 __check_mem_type()
Thread-Index: AQHXPEQ7xuXJ6UlC3kSfGhSBsEEd3w==
Date:   Wed, 28 Apr 2021 15:36:18 +0000
Message-ID: <20210428153542.2814175-62-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 7edd9777-2481-4e6a-9122-08d90a5b8258
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB187175D4FF76D074C9F7DFA9FD409@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q+5dezaNRtz9KOwea9gVmdKDVo6TjDr7AYcxajDQ5uXEfL/tY9lnHb/OL0rWOlqIHbb7Eza3+MUYOF7a0vvTA3QoKiaoEF3HZS9Kytc8mOwf38RF4KHL2SQCq3pVgMVzTr011KbX8ZFXC6WmUBHQo/czzS3d5rJtl5xsTTEgPBVC7Cnllk05zS+raTlmKY0eDHFpECD4z1DSGd/QZ/SPX+ys8sb/gg4A5NtuQBuwJDbls2MJFvCQcNPAgueNnkjo4RthewVSyANHya3qQIdwgZk4z3Kt52r9x/nP7kEhRDUwvgqkJxW7KYhxi5qMIy2DLkZn/bbD56YSvLZ6N+37qhKlIFI5QXGRg+Vvkhz182awgoWi8Z3TW4yVDOR47vSGJ56jXr9KRVEiFaWP5LnhXAHp88x/eFr6i7U21sMG0texCi/Ymwv/cf2vu4NWdHXQgwYal4olVJEB4G9sTic/9Q/rsgXiU+k4beULaou9+jU48llXbx6FyhWZEkjp5UaSfHMUyJ1TmOF3bllltxEUlu9FUPQZGq9MAS8aVF/lbcaftvACltbDxHD1yxo9SRQ4ikQRib7On5rJ/iLbo0kKZhkyqqsAFHXMVRnWoceozCU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(86362001)(186003)(6512007)(66446008)(6486002)(4744005)(66476007)(316002)(107886003)(5660300002)(66556008)(71200400001)(110136005)(54906003)(478600001)(44832011)(76116006)(6506007)(36756003)(7416002)(26005)(2616005)(8936002)(1076003)(122000001)(38100700002)(83380400001)(8676002)(66946007)(91956017)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?0E28UFWW15eT9iLH3uidHJL5vEMw3YaD3ZCGNRqt35G2xEZgYTL1gYSdhB?=
 =?iso-8859-1?Q?C978llf/lKju8tiCbDH1h6dlQHqUdLqeCqZ61VWOuxHwXUhOqTzEnGJwKY?=
 =?iso-8859-1?Q?1uspwR3WKzM8PuTHQNHAXKEdCnacjvV0fdDkw1kH3wQVMkQQsDrxSR8+6b?=
 =?iso-8859-1?Q?/6NcP6GorIdv6nTPgbApIDRnz6hLR0LFS3bVqEdYM4EnmdevfV26pLAwgS?=
 =?iso-8859-1?Q?0kpwfjMAKvPA6r7qrM8YDmzifODlTcyzHl8KFp1k3YZ02KjUr5MCIITShl?=
 =?iso-8859-1?Q?qasTvJAvBzQJ4EBvVK0SDldpQaFPqaw9/5jGVWIp9ErIsNu5rh83mgR2kh?=
 =?iso-8859-1?Q?jazIDgjbUQs23v678ko27c/PBsz3S53IbxGx2PonyMZKb6/F1RbwG0YCYN?=
 =?iso-8859-1?Q?8LtKvDFANR6dUVyIIqfBwrORn7k/50NJ5mc1uHmdjjRzyD67jpXrHtTPWq?=
 =?iso-8859-1?Q?aXqisMMDbZvi+8Ri1VCAy7dxzQRgrBnubPmXMRMe5fkd1MuUsmMqbSxR7l?=
 =?iso-8859-1?Q?j8KDXqn6FKNPeIO9jC79DOCAE5H8e88mQphuqZh/89xTcFwlFoN0YaEdSi?=
 =?iso-8859-1?Q?ZNLjE0XXp51jAcWKn7fsd6SO+viF1OwnZx3kjlaikvdYTsmdwXlOdJIFZB?=
 =?iso-8859-1?Q?0g5MU9eXouccQ1cKVVEaNg96dwEOyd9ZUXNJZgLsZbh11CyziYg//oPcYh?=
 =?iso-8859-1?Q?rtUBictivZEdyzS2ihdUyl16eJ6K7i8j1Q/YUhj7pFHOiY8CfIvZi0atEd?=
 =?iso-8859-1?Q?K3OamgSOLqd6sabvQQs066faITGG6gC3JbJEiiVGm8ExJGtI/4dwrRbPfF?=
 =?iso-8859-1?Q?vXK4cSsBDwxqz+/rr/1Qng1Hk+kyXmGGSxn1N4QihngJ1edcBIwHGtnXLU?=
 =?iso-8859-1?Q?3WDCfZFwhsaAOJn7V4pcffgz3XhBPZ5KcadPjy0VS8C8LK0iRciIYmg7X0?=
 =?iso-8859-1?Q?iSbQ+f9Xo72zRLNuxCTr8wK0jl0ulhiEJr77M5YbTyKn3/yEyFAsx2MEXh?=
 =?iso-8859-1?Q?+t9Ctcv6RzRrcx3km9gZEtOJSL24vOXcg91rUmhNa+YwDcQaEhQUtaxSwI?=
 =?iso-8859-1?Q?aE8ybxKPUJTsVCClFyLq2962HdMoeSkH9WlP/vfkyI+ZkbwFMn/yncjlKa?=
 =?iso-8859-1?Q?z8QreIUmEbiFtse/81TFnEKoeva5hfMZZDjMOl/wdLURk+bgwHiCgHIcHo?=
 =?iso-8859-1?Q?0ksURCTyvzSiX4UuhN5LeL/VY9q9UJ5NdwK4meQXLQy50femZ1Usvo2SCF?=
 =?iso-8859-1?Q?TzFAAGfp0Zgg8z8OuABKMYDN2pIwULm8IsVwmiOrJqfVauV+UiHvsXTHN2?=
 =?iso-8859-1?Q?pN6lwvqPAzzLD0EKnSwZIDyiR8nZKGnoSoNYM+uGfXVCONmXz/e0XKj22s?=
 =?iso-8859-1?Q?EZTAmCxd1x?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edd9777-2481-4e6a-9122-08d90a5b8258
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:18.6928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wdf+fiD5iUq8nPHIPx8w+9zu60FKoPHAQkyOgRxAfHunf33nhgIBFqCxTIYvjqFSr8RqDDVmBkd1FXFmmRJiPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: 6gIjB2648r_K41nJej83k_nKF_tzGrp9
X-Proofpoint-GUID: 6gIjB2648r_K41nJej83k_nKF_tzGrp9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/tee/optee/call.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 6132cc8d014c..cfe55b9e92b6 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -550,11 +550,18 @@ static bool is_normal_memory(pgprot_t p)
=20
 static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >=3D end)
-			return 0;
-		vma =3D vma->vm_next;
+	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_start, vma->vm_start);
+
+
+	rcu_read_lock();
+	mas_for_each(&mas, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+		    break;
 	}
+	rcu_read_unlock();
+
+	if (!vma)
+		return 0;
=20
 	return -EINVAL;
 }
--=20
2.30.2
