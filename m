Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B17A38CCAD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbhEURvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:51:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48600 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238550AbhEURto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHTBi0143041;
        Fri, 21 May 2021 17:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=m09LocX5eROSMWE59fjg6KL4G37cEzpcTqB/O0Ov7ZA=;
 b=CJaYZlr0k1lXVa7B+wRmy7kn7+RgO61xxzDaY3PG76yCXGqvfFYasKGDG5pJPtYs2WAI
 hEQAJtJGQUcz6rN/qCjXJHLB/48+3qBPmWljH+vn5BHIdxjPuHrp3vxU5LE+lBOcveez
 GZX/A4QcnOksJOv/eCwgk/s+MkmyIz7b0kw6lf4kLmIQqwGuCe5XiJBZ/2tBNkKlKo4O
 ieQiI0u4ptxwS7636ugT8MAlkYOmzPAY5enIepnEBy4FYtrOtcwjWuH9xbWhQcLNgIlW
 xWtcNBeAeGd7QvVroPXfuOu/I2HAf/w9t7R2A0rrmFEQqerGtsKj/peeuHCSB4gqz0ng AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38j68mratw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHkYWN095609;
        Fri, 21 May 2021 17:48:10 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by userp3030.oracle.com with ESMTP id 38megnskas-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+4t3+v+aOGNMS1g1l2BELLmHI6hzcVGXfSK/C30zUI0tDiSOIS24yQKvdLY1vSqqMRE7aFCyJwY4voq+vJ4uYWs4SKTFQ3Pdc+ur9f7utYZWkeliOOMshv/1u99qo1F+NfE/mYvNtVsoyL5AKD/YooG/hCO8Ac0c0xqc3rnhgHSsK5tbkVwkGBfNsA2xv79XxLn0W6vR787EjnjEvcBtFoyBlAeib6C61ABQZ+pAu/+MgDW9A10xvZyFAiUn4ldBQH+fQXJMXqsx6bYLUg6iuD4ZUoVN79X6Guz6itA6RWB1qd7Vc9o6CcFmo2EypRMOTw11WeQUZ+FBKTytjdrCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m09LocX5eROSMWE59fjg6KL4G37cEzpcTqB/O0Ov7ZA=;
 b=bZdD0fHzLmh7pWDDq048s6OD6nOXGsFo4Lww/FqenL9Oq3gDbxhXp1mTw9Bb80OjyzycSjSwKsqVlt4KEwEIecDEva8McoeXaDcnQo2BqtAYJpBDAHGFQkbrQ64mtkUMM209nAXGNUQAf5dLw8f+5hTOixoy8sqf4uHT2u4U7hGQZjVel9siDV0Mvflyz9PAldOxJ3me3IgbJZCFfbLE+GRP9AKe3P/HMioSRlFMGeEspJIIyNWtZJzNJPQ73l/QsM4gTPrKdhQIfL9x624hPYtqex+CfD+ARCbd72WHLc2txlZMqiw1lPwvPJxALdZx/0A0emPL0Q7UU3w41Oldng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m09LocX5eROSMWE59fjg6KL4G37cEzpcTqB/O0Ov7ZA=;
 b=WJMa9ALnSkpMpb/xCHYGcVmIWgl/M5/LPnnMf3MqfK3RsvOTkGpVv/tMwUnVx2ksrFAl3Uc3/HILk/+CJe6h1u4mu8tuZXF6uxiqdO/KROVNL1PRGUh34SMpWsm3R8CvxJBh2r1tCR50Zdg+r0kx5M6PVPTLICi/ButFdZmm6O0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:06 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 19/22] mm/migrate: Use vma_lookup() in
 do_pages_stat_array()
Thread-Topic: [PATCH v2 19/22] mm/migrate: Use vma_lookup() in
 do_pages_stat_array()
Thread-Index: AQHXTml0ybh4yJfewk60mVu1YxZe0g==
Date:   Fri, 21 May 2021 17:48:06 +0000
Message-ID: <20210521174745.2219620-20-Liam.Howlett@Oracle.com>
References: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4c361e5-4cba-40dd-74b9-08d91c809747
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB44673C9470A01E8D42D8B2BFFD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P65/YDasXhcn79t9zUgTC9FgnFQrZl0wf3efMUJXAKXXeld3cUktOE8zOFzMlr7tokG+7YkE6O3DDYnzJFwFODwej+vNG8K78BQs33loXHp/bceVY2B/FhKendFzMZlVESJHVGa99CpKzzuE/plf74F0+mv+AihE3VLMIZ4FhdlA2tEaBMa48uDyuQew1yCXbeN2mbvYYOtkLKcw43xdat0bvp+frxamOtvgI13qOZUaSS7kIagPetNzdzpuQOCpL9kL7EnHBcTVt+pOpvWtMYifJB1rqs97g5a1ngmjv8To8xRZGmSGr69r5g7/yyhu/CI8f3gQ3m7LtARunmspWp4ScSssTu/9t3VcathTqAwd1TT72Zifo15NJEoXgoOhdn9DJUhuMPqCm5wqz43loAz7oE39AC+x9mJDxwAl6nswYqNvK8YOycU/k/5SSCAAXxbqmq9BqrWRHiTjceOlX8SF72T1LbN1/BuHl8PccQvO7DOYJzE7PZ37WUZNLzrxbtQlfQ+PkEc4Q9JybH9/RneDJ45ScraC6s+HVf84UCnZNZMVDvvxUQrBWNxHTU1o9Gy+csE0LQY4QYSiARucxCqvWLi9tYp6A8fXcS+6hIY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?IBW3R7WH170yoEuSXb8ns8WhYnCOlxpwto9e22yDpZ2DKRNohJ3db7DjMP?=
 =?iso-8859-1?Q?/9/GAxJP+yET0ju2Rw64PF3+azCzwHpwRyOypqDyCtJKaTXPUcxkQWaBPT?=
 =?iso-8859-1?Q?f7tPeFIDKNX8cITbeFr/xiOnur6q1ed7Gl0hRn8luN0QRLvsfKcs/bwN3h?=
 =?iso-8859-1?Q?Mq643AMqAYDc+gA+mdy7sngN35LkSe+kAFggnvmKvsZWCRmMVnXV6NoNC5?=
 =?iso-8859-1?Q?JqFz1XAMttssnt7zluCd+iBKmpeOO3uGnvI/h7Uo4TjCW0uSaQy7CmE2z5?=
 =?iso-8859-1?Q?OEHRsS2t6oJXUBVu+BFfBLtaDAIsXSQjsgi395bXGMtp2tbPAaRyMNHqlO?=
 =?iso-8859-1?Q?aW5+l7PmnMyqR4byw4C2F2vauhocaZJbAFb2rU04INpq3qXkaANxfBZRbm?=
 =?iso-8859-1?Q?RdA+AJbtxo8/FzSl6/LF/W20lkd5bc2jqJFt+ykzFfpVRL2fjcePyUuJQD?=
 =?iso-8859-1?Q?h9+arPDk096K/iByqL8Fy4q/U8tg666uqEFINynLArAqplEUCOVThcNw2X?=
 =?iso-8859-1?Q?ZtyyB38wi4Zr9Sq2Cqel8kb2KevKVeHt12hna+lAGl51f5CMpjzyaHF1Ec?=
 =?iso-8859-1?Q?d0PimJs7oltooexwGg+kiYb2srNw74UMaFNaGIs/jbPRiY0Hayc7qfgww/?=
 =?iso-8859-1?Q?Q2YhJ8bvxB4ymM5ZQWRHo3rTvn9k1GRPln2Wx1Tfllub+5ft2YHYNL1Jq+?=
 =?iso-8859-1?Q?1miRqBH9D8q1ksp0G0c/3yBhCUYPBhNP0Y3PYf2SbHZHJT48+N8FnlZmy5?=
 =?iso-8859-1?Q?FwNyukNEfUBpnqcCutF2A44lS1tJ10IY3KINFtP53AMZ/WyhjVO5bO+FUI?=
 =?iso-8859-1?Q?tYu/SB7x6rZopoVm+e9Lo/hZJefRJCdPtEYbLk5a6pZac9xZJvz2jNnqFZ?=
 =?iso-8859-1?Q?uABDTqpULO4v3jZo1vi7etevW3ttsqgt8FH2xz9FtEMlpTLwvv8GJtSVKW?=
 =?iso-8859-1?Q?+xBTULCYOeCQnXbodiofpki5KxGn0FRTrvzsDRphzzcZf6ypawQzK1VM+p?=
 =?iso-8859-1?Q?gRGngwhT1uGrLIJWgLbAjHHtud8gz9UcaJgP3u7WSdSqCGnsWplDUywcuT?=
 =?iso-8859-1?Q?05cxAX3sLVkp1qLhOgsJQLY6hdsRcsqnLRLMkuD1GPbW8ggYKJftYrgcAj?=
 =?iso-8859-1?Q?ExeNk/I0PFNEZoXO8O3rEcmtO4AEI4AOfFTWHW6WrGg2op9zP64YTdCYKB?=
 =?iso-8859-1?Q?rkQPRq43LO4mxeTfVeN69XrPd9INcjRKpS/TqEcuLZ/6ABGSiOtarRB18F?=
 =?iso-8859-1?Q?qUObxf7E9Do2NKphPU45bRkIjpR5KPxgxVUkjy8TP3C4GkPbRR9asbOk7Z?=
 =?iso-8859-1?Q?cCittJVO3/zhOloG0JgNntAVtkCQ6txP9WqY0sFh/1UIjuNQCEDhEd6C5i?=
 =?iso-8859-1?Q?IhW20RrScC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c361e5-4cba-40dd-74b9-08d91c809747
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:06.7330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9boHlTBApGzzj8ib98qRC9WCu9PJZQVyZ2IxdjI6zSLSrM3f9eQRSKhp70/81grrSBmsRVdPfd0FdKbkPjx97Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: p5n5tgLK1L1xzhrp-v_iEkSQxKCLcVBH
X-Proofpoint-GUID: p5n5tgLK1L1xzhrp-v_iEkSQxKCLcVBH
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
will return NULL if the address is not within any VMA, the start address
no longer needs to be validated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 mm/migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b234c3f3acb7..611781c0f9b5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1833,8 +1833,8 @@ static void do_pages_stat_array(struct mm_struct *mm,=
 unsigned long nr_pages,
 		struct page *page;
 		int err =3D -EFAULT;
=20
-		vma =3D find_vma(mm, addr);
-		if (!vma || addr < vma->vm_start)
+		vma =3D vma_lookup(mm, addr);
+		if (!vma)
 			goto set_status;
=20
 		/* FOLL_DUMP to ignore special (like zero) pages */
--=20
2.30.2
