Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7286D38146D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 02:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhEOADt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 20:03:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43788 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229882AbhEOADq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 20:03:46 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14F02GTf021303;
        Sat, 15 May 2021 00:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FMliLM+DuA4ovFnGVfSSSrgMSAn4U5SJBU1+PjxvF+Y=;
 b=cq3nHsARc6YDCsi26+slyMApv0JuJzeVPLB3wAzsjDE+RGWylFOLvHdC8yefA3JYMAa1
 OjEHq7Uv4Xc3qG2TVrxmciwBgByX6o+fnHcqx06aJnlzcwts9BhgCukSasn9Kcla1q4+
 QuJrW4hYYFrpJ+90gQUs9p8kPOqctjhHg5qCnCZ9OlVOmYmC1GCIRjZuAIWmWSOr4xDb
 +5T5WBtDZBHf4DW3kuQGmnnTaVZWQUma8q4c0XHIHlqbWKY14i/qK1FQ3qLy3A72Iseh
 dzw1Kp6SlG5ZxMgz3746+bV1FlOVWLiSzOnzXn7uaJ+wP5LOaQ8X/cjRLFolbZq2oXRT bg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gpphrw2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 00:02:16 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14F02F8J150468;
        Sat, 15 May 2021 00:02:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by aserp3030.oracle.com with ESMTP id 38gppqhmtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 00:02:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnp5aJXiDleL2Q71+Wur2oCIEV6bBpxixJv6pv5JCANhKfsCXiqbzF/UGsR4RR3TWMIVD6yOWH+/5FZ3iDxnxPf3T13r8evXLHfdY0Ht57JbaWDAyQ6gGQ87Rdz60FidljND5jzyL6guxZGo9vesop2daD6nT2KLsNPtQ7OlMr5A3NnFqVDSqxfj32QDtdO/PrFYNZT6yEjbRmLBrTZuU3sUs7yPq6ibvLeTpRkPGUMjtlIjL2Gc3rHkFcO+5UH9uRxY7hiQxgX1dAXIkJ/P48HOFAq9Yl5SJNphRybOEhKZZki7+VCbJcsAyFhvY1QuI4Nf/ZBbjn4eKBZfzVAJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMliLM+DuA4ovFnGVfSSSrgMSAn4U5SJBU1+PjxvF+Y=;
 b=eeX6+RG2iT5jIlUBADGPzQxVXx2wnEqsXaKkdCVZbenpQ4dVD9/Z3dpGS4SKnjQ/S55FIT3uLt/4eT+6OEgX8YpV4BrmMxuZnuJczEUI4LMskZdO0hQkKdaBCXn3RWc8NpKok9sT3kdzXPLzUsyARelLiKH6HJr07G+G0xoene8GdoimTLRAiMA3xkc32RDbDbJwBAFleYVhzQ6dtF5v2dRfzc1Li5VAkgObJW1OwEDj7LMljtHB+mo7M1lsjYplK32+13c5JrtQ4RaVEYFNYm112Ad4Xl8W5wC+DSBxYN4ycUNn+jrvL+FAzjGUTpAcn2sIHbharPBYqnK6I1Z60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMliLM+DuA4ovFnGVfSSSrgMSAn4U5SJBU1+PjxvF+Y=;
 b=ZsFWgu91CASrwSFkimkhlzcLsTA/T+bie9w0Imfche1gWyBuy/pPVTBrM4LGDPwy4mnBB0YNXpIwT0DuisCffDuXpdk6FLb6+F36ET49RkqoBjarV1qgKU1IVC+b+v8Jcdx2cwtYtHeXy0LTCNO7/I3vlxDvLPORBLCanRgQH50=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1982.namprd10.prod.outlook.com (2603:10b6:300:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Sat, 15 May
 2021 00:02:13 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Sat, 15 May 2021
 00:02:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 26/94] Maple Tree: Add new data structure
Thread-Topic: [PATCH 26/94] Maple Tree: Add new data structure
Thread-Index: AQHXPEQyRs1g/Qku7UiibZzqyyuzcarjNkWAgACMRwA=
Date:   Sat, 15 May 2021 00:02:12 +0000
Message-ID: <20210515000206.u5l44sgr6xzmpe5d@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
 <YJ6Z0X91NpuPTEre@hirez.programming.kicks-ass.net>
In-Reply-To: <YJ6Z0X91NpuPTEre@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69ced268-6e24-4ec6-f724-08d91734b154
x-ms-traffictypediagnostic: MWHPR10MB1982:
x-microsoft-antispam-prvs: <MWHPR10MB1982D7EDA11E48020ED86D51FD2F9@MWHPR10MB1982.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +YX/UB3BFHsQ4l9v4w2F+QNksOM+QsOtY/0hU6xi4pCh9/AVm+R72O10bMPY2JYEy3wvCyn8tHIFOsXZ9PlCYWkxR/12Y8AdSxBPJddhDt+XPdjGJLbaRnW1a5qcr4Tz8a2eZaGAapqjpLc7kZhNBaz172bIRb1OEhy3rL8UbOxHC8Cmwgd+ygaJBoYWAMWnOixLlVLiwWirFSP4mZE1KBgs/vwWjEiZVFkCTzjR/Pv+8mcnt0RYmFObR38/fPPQVOkPsqrdfVy1bdlGwvDpDTxABmwUGj8HGHCw7/qbM1snhjQGukdYtzo8zZl404Xl+9e++m/pQoXT/WRR/OtbArR7VxHfFaZQas7mjJHIhWEPSfsW6EbX5D3gf8v7ialdUBujGeHEAtwzybV6h0KpeFI4Q1iZP4LhtziTwpXlsqrjXySoem7caUO51gNEQxe+KXQuaq7IeSymWD2ASn5tLoEnPMHKB54YyPlMWe2eei/s3QJch50pMfBBc57ed/t4iHerEdSb5L2RnCtLsaKvR+OelTDr/iwomxML3+UuxE19QtKqFFeZXO779bKV0Lku3WptUVPuVapOC5021FzVZa6KYkCfZFy/Ji0/6H+7/mM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(366004)(39860400002)(346002)(376002)(136003)(26005)(71200400001)(54906003)(122000001)(6512007)(66556008)(6506007)(86362001)(9686003)(33716001)(8676002)(6916009)(6486002)(64756008)(478600001)(8936002)(76116006)(66946007)(5660300002)(7416002)(91956017)(38100700002)(66446008)(186003)(316002)(1076003)(2906002)(83380400001)(44832011)(66476007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EFeDps3XdaDTAIe7KJzilxrlZa5RZbUjjOiqND3odCMKAby+WFhTqahsT3GZ?=
 =?us-ascii?Q?IVWaC9qHBwM/A2zCE2IhSTj9k+FpwUnJls536JF90cOdls+vNOL7/oEl9RBS?=
 =?us-ascii?Q?pHu6U707ispiyePwrHK7ILJMqpwM9pS1oqX0EeTscp0ka5nHVNUxg4dCLu3c?=
 =?us-ascii?Q?9lt2C//UufhjjnLG+ZJYQagrS25V5gBeLLJP+/7rjeUra+EOxJ5UZPieSOLG?=
 =?us-ascii?Q?xlR91GbKyprLR6CTYIHU09OC3u8nZ1+VIJAfQ/ZxRtOM4Pb1HZ4lfDUKwGZ/?=
 =?us-ascii?Q?Utr6VzTICqpa/6Yc6+izrDEaYuvInHizqnvsX4TqDqOkATk/DjbeMyJgyEK+?=
 =?us-ascii?Q?2d38zJRTNBcifYKGtnA/bv0iNEgDt7Hc+TYaYnePqfj6YESr3BJ8mAbIrKpy?=
 =?us-ascii?Q?D3M00lcKjT4+LT3VlxYXibzyJsm7JBhrcPDqeXF85Fj9IoIzX+9mMW74ackm?=
 =?us-ascii?Q?bq2qmBJOV3+jY26m9WUYnFhv9y/x6bnPZlBeItwm4U+Rd+QZO2zZu7rVwOQ2?=
 =?us-ascii?Q?DkWNjJflVcZYi6XlkmtywfYVTrHa853N8pJGhIF068zm1/1y0IeaZqlEAGNI?=
 =?us-ascii?Q?OXZ0TwSI4ynNZTamgjCnTBPwo1qfDQKG3+5QMq4L2kMvEAKgbL+u2S4AGe0F?=
 =?us-ascii?Q?sIil/t2qebAcTKn9miym6f01i9NGVPEb3zaI6XE5baVS8213gUVZFjAJhf24?=
 =?us-ascii?Q?rd29/Pyup52FwaBAmN594WSEc8txZEBaUFW3uyriIYsM1jDYEaAFrG/0ApQP?=
 =?us-ascii?Q?Kw4Si7HEgTNZuUo7IcnqxPy2FkbQmLmhQv7Ii3WEgXUmWJBdK51SH8uaOHVY?=
 =?us-ascii?Q?z/wD+Qc/IOEg7vpRPoANe5R5sNTOGB/uLuYc1gTwG0vr3iDqgW0fer9Sd0v7?=
 =?us-ascii?Q?bmAYp32lZRDmJaCcNTSbKrkgdcgZiqy924EfI6v6Yf3jV08aTzJLMrhFH4X4?=
 =?us-ascii?Q?hVG54AiFKKqA+Bndv88U/GvpS7zUMy/PiQg8KocV4GVCKDyg6jME+5nYc8IR?=
 =?us-ascii?Q?i4SxlnzLRTnKEiAZkCTKNfL5kpspjB7Mhb6bI493sxr5bPmMlN2OeLam23Dm?=
 =?us-ascii?Q?ig7HG7J0Kj6n0bdRlx2MUXdcMetEYUeJAlD3Q9jNvzVVpSlejf+zrQvdcPkr?=
 =?us-ascii?Q?Sbla3jHbAhVQsKqRxCuYt0O9+6viYOaFTp6kE4IViRUr+/LkWWLsVXlgDE8v?=
 =?us-ascii?Q?Zfa8BXN50NQP71HsNS2xfcV/v12O+l6CMwFWUMLxtB7uknvSJZSyVBEaeqDS?=
 =?us-ascii?Q?mm/sVCGjKI2o/tNM1/cVKFfXoKtLsiLIPGVbwrK3P2Rk6sUq3JleNZnFw37e?=
 =?us-ascii?Q?VOeo2dyzRBDhL8nkFvtCpQl3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC43FBD695A7504A9130F892E1DA5632@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ced268-6e24-4ec6-f724-08d91734b154
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2021 00:02:12.9560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ye/bhlv8Wa3UA4EZqzhqHhRJhZAm7eHDnKcx2+w6mfN0A0eob6yV5BaidFQCD1v3RafM23C+ZsMUc4ahnoNtLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1982
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=963 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140190
X-Proofpoint-ORIG-GUID: GacQmszwOybxIVbCw_CXJSm6edlW2Z3D
X-Proofpoint-GUID: GacQmszwOybxIVbCw_CXJSm6edlW2Z3D
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [210514 11:40]:
> On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
> > +/*
> > + * mas_set_alloc_req() - Set the requested number of allocations.
> > + * @mas: the maple state
> > + * @count: the number of allocations.
> > + *
> > + * If @mas->alloc has bit 1 set (0x1) or @mas->alloc is %NULL, then th=
ere are no
> > + * nodes allocated and @mas->alloc should be set to count << 1 | 1.  I=
f there is
> > + * already nodes allocated, then @mas->alloc->request_count stores the=
 request.
> > + */
> > +static inline void mas_set_alloc_req(struct ma_state *mas, unsigned lo=
ng count)
> > +{
> > +	if (!mas->alloc || ((unsigned long)mas->alloc & 0x1)) {
> > +		if (!count)
> > +			mas->alloc =3D NULL;
> > +		else
> > +			mas->alloc =3D (struct maple_alloc *)(((count) << 1U) | 1U);
> > +		return;
> > +	}
> > +
> > +	mas->alloc->request_count =3D count;
> > +}
> > +
> > +/*
> > + * mas_alloc_req() - get the requested number of allocations.
> > + * @mas: The maple state
> > + *
> > + * The alloc count is either stored directly in @mas, or in
> > + * @mas->alloc->request_count if there is at least one node allocated.
> > + *
> > + * Return: The allocation request count.
> > + */
> > +static inline unsigned int mas_alloc_req(const struct ma_state *mas)
> > +{
> > +	if ((unsigned long)mas->alloc & 0x1)
> > +		return (unsigned long)(mas->alloc) >> 1;
> > +	else if (mas->alloc)
> > +		return mas->alloc->request_count;
> > +	return 0;
> > +}
>=20
>=20
> I'm confuse.. and the comments fail to eludicate *why* the code is the
> way it is, they simply explain exactly what the code does, which I can
> already tell from reading the code.
>=20
> Why can't we have ->request_count unconditionally be the requested
> count, and have ->alloc be NULL or not. Why do we play games with low
> pointer bits here? AFAICT there's no actual benefit to doing so.
>=20
>=20


That comment was written by me before I coded the function.  I meant to
replace it.

The maple state stores the first node into alloc.  The alloc stores the
request_count if more nodes are needed than already allocated.  If there
is no nodes allocated, then the request count is stored directly into
alloc.  We do the low pointer bit game to reduce the maple state size.

In other words, the mas->alloc is overloaded to either hold an
allocation or the number of requested allocations.  Bit 1 indicates that
mas->alloc holds a request to alloc (mas->alloc >> 1) nodes.
