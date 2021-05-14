Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC9C381375
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhENV7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:59:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48344 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229942AbhENV7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:59:03 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ELj9hQ006463;
        Fri, 14 May 2021 21:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9p+wt908FYRwirrreTzLog2jUn+T2Cl5O9Nd0M8adFE=;
 b=BFOb27e8jIFYcleYB25gKf9gY6g1VAUYAl+tICK2+0EPXdy+jrvDQvBx8VdmL7yglejH
 H9cIZg/WHq3S87/+4rU1t3R6Kv/jDfj4S3pMOwuXUO96vtf7uVcfiV6P//Glx4aq7rOe
 1wi0X3YgzutI1/X9pm/SqlmfamnclGgcl4IScSnsBwHscPc47uZ3h7koMq4WoJrsNxkQ
 LCfNdYa3L6lOvJtQkmA+6e0QjrH1p0it+Nx2O5ye4U253DBIMCKGs8qcO+zOyPiCPOF3
 hVmknm7qxTGht9+EzcYyPAxuXZ+NePqfUu8CpQBGnHLOVF3gFjHL+ViqJiEd26RLnqeY oQ== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gppfruwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 21:57:36 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14ELvZgt158475;
        Fri, 14 May 2021 21:57:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3030.oracle.com with ESMTP id 38gppqfact-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 21:57:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUXJMnEsf2oRblfHtUZXRae+tvSst86ovlrbzpbEJuC9jHgqFRZF9dxX8/cqANm9eO3sN9PS4a/2oU3i+bbs4cDbr4MELl/XMiCA4phzBdKU49Q0JogpmSAEZYVaS51OrUVohSMPFfL3cukPmwpVes8E6lwrRFULHy+0Ifn1zyCgIGqE99xuIT4GpcwtSUw8x6uHN+CA4Ei/m25WkKU+XA9H0zhc3+OAPSHOJDvr/tW/f9t45j2LsNQwxwK89tp3FYHhO5iHW4Xvz9VMsGVTu77zeN3UmjN6s0cwCdXyAn5klYMXyy2R6sFGwynyd1h2oXCGISME1k35aX5TeFMdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p+wt908FYRwirrreTzLog2jUn+T2Cl5O9Nd0M8adFE=;
 b=ku5jb2l4Pf0agEhEf/8z5MtUuiWp90bq3AUIC8LBZx+AGw5QIZunomN+HTnu39egojtXpBFj4BwMU3E/O+Eno4BW3sr6HbhdOW4bd9uDmc9ZKpyR0WGOfUGEfagl7rUBjTyOMuJnfqdG3MBsvHc+6l56txvu852K6WWPyzodCQrJY+EW3LyksmVi4YTnGUx6CxRu7KF21fz275q5oyK8X/kwtmZKi2EQs6TUxSWeHiGausFWolj/BtP1jsXgqEhWUEfhSSkGgoPz1Mdup/JkcgfZ1F5a6gbRVWitP8lPfr5E6x7Y4RAAPtlle0iTyVgeh4MXyCJ0l3/2FFe3+mR1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p+wt908FYRwirrreTzLog2jUn+T2Cl5O9Nd0M8adFE=;
 b=zNE9XpETKOJS2yfS/fQM/k09HAX/XPzP3xB1mbhfnFdKAAT+mbKL3jCC0VCrAY2OhF71GCIFiva/9nO/pynf6jDZG6YEg58wp4dnwk/eSLD0uFWjzV5J0iuPSAS3F506Gmop446JbAb8LIexd+mBt5IKxgAOmzjejzBIaoM9I0Q=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1838.namprd10.prod.outlook.com (2603:10b6:300:10a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 14 May
 2021 21:57:33 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 21:57:33 +0000
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
Thread-Index: AQHXPEQyRs1g/Qku7UiibZzqyyuzcarjNBmAgAAAuwCAAGrYAA==
Date:   Fri, 14 May 2021 21:57:33 +0000
Message-ID: <20210514215716.k7lxgcnwuyk2isn4@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
 <YJ6X/wrP/El8KLdh@hirez.programming.kicks-ass.net>
 <YJ6YnJv99AEdu0it@hirez.programming.kicks-ass.net>
In-Reply-To: <YJ6YnJv99AEdu0it@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 382de6f4-03f7-48ad-50c9-08d917234735
x-ms-traffictypediagnostic: MWHPR10MB1838:
x-microsoft-antispam-prvs: <MWHPR10MB183853D0827DA473BC6A8D1AFD509@MWHPR10MB1838.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ot6L+Nd1mmCr0pA1DQLE4UN9E3KkDNpkxlZhU1biCY+HMP0foq15J0QAk/h+avA3M8Mw8f7elqFmNsQ+3EGpjwNmAxg0ubkRNUrHvuJcRqAJBbvGCImXBkTCZaN786TE3I3gqkyMK4ZQHw3YxpGvkp2OLGfc2E55z4nCKMHlE7Ig504pWGQzHXHGeXffgvVf1fj2ZM59GWLd9htiEmq4dsQw79QImENLCpiAhTHrPyR4TcN3gAGWJNGj1R6I34W6npVd4DCpyqoYZ5wYSn98DNTCWrz1OsTZ7H9eXq94yGpKX5jP/SjHXcWKZvtaSrZIji/3QMISuKx2qbmgGzRJi5AE/bAhp4HJfq9bN0SIw4DqQw/z3MsE/K0sRnwVvnHy5QEUAzLfSKtyQPTx8b3V2283BXOZEp66yVI0WkTNvkZTFi5X2AvTj1XXBDuRtay3LFaGPJrvbOg8FE4r7x2pd0nAK36czbdSrr39mITPq5+XYE2RC2dRyYSkcEKhXEtkre9z4FH5aFagxIxnkbL2o12OIuwObBDgFzmAK5XoR+NzZBu8M1TlREtMV3nnbbuAqLMnHmVEkOdiOGENiXgSw2zOFmUZydKmKOM4Ggw8Hk0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(366004)(376002)(346002)(396003)(39860400002)(9686003)(91956017)(76116006)(186003)(6512007)(66476007)(66946007)(2906002)(71200400001)(6916009)(66556008)(64756008)(66446008)(1076003)(5660300002)(86362001)(44832011)(54906003)(26005)(122000001)(8936002)(33716001)(38100700002)(4326008)(6506007)(4744005)(316002)(478600001)(6486002)(7416002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yHXX7pIThjIhBGCh87Gnn2d93KBIY4+8UxobY7qiFEu16y9A8Fe9EEGdjaxp?=
 =?us-ascii?Q?BDnjCy0QAJjkSpfikmaIud10d911ih2fMUwGGzc+SQ5ljper1rghC/6Mao3a?=
 =?us-ascii?Q?1vgqoQ49HfNnhJ7SJ5l8w1KWpRMEzMINphGMS7V8pVD3MdSwmpFgOEqTIrMM?=
 =?us-ascii?Q?KRHihpmOHKDqBPBUteg8ck1d8t6QtcmzH9yEDoaiHs1O/YXOUMp4jOI5c389?=
 =?us-ascii?Q?RuMTinua21qKh8G8La2RIoobWkBBckNPPTn6bz+JdC2994PbGIYwBV1m+Ci+?=
 =?us-ascii?Q?OJ7/PTVAqbY1vhOtudrqZTZIgawId7rbfgFbclUu2FAwEeLMonFIeqiZfl0l?=
 =?us-ascii?Q?lAVc1Af8JuNGQoTXv7soTsYZwfcrzksZ0keIs6jjVHXk09je2lR6e2PVzxZg?=
 =?us-ascii?Q?9yBIPxI/E5+7bEOmmNWwb9a0lJJymyKBUcy/w2uPeoh0LI8br3W7M/NNJVSf?=
 =?us-ascii?Q?203gH9heFHpsnonqVIOMg2tVGPZDBupZaH/vKcpwqe+VbJYzC5KDXzJ3iLh8?=
 =?us-ascii?Q?f43gzMRUhB1rUaQDvGnTmY3ZzBmzUN8ts7YI6I/r2zSX1EHObDIILuqyvOHz?=
 =?us-ascii?Q?cW7n6aVgKE3Y9UFoxCl3K3xRSA8BGutvV2JGdr0aziaXHbx0FiqQ8oDkjdRa?=
 =?us-ascii?Q?XlLW8W9xsmmbPal+VKJDVHHfF/ETdv7XxQryB2HGGArNdtyb9HYEuZCHgNlB?=
 =?us-ascii?Q?ifuz1rzLCDPyKohavl75BzOZTqQB/sihWvZdJJPdsF7e49IROerMcq+9Nb5O?=
 =?us-ascii?Q?thy/95lxSDUwhKNlaX9zddTyTz2Dqc+I+gv9vQJr9llouWkQxb0yzwJeSCN9?=
 =?us-ascii?Q?w0jPw4Y2zzKBMlPsysiYguqHn3TN+iqg1seRQaUIKUMLJkM4vKqfYEmaFWeB?=
 =?us-ascii?Q?A1cuSv2kx0h/yMHzM65gmM8L9yVXloQ8Ep6T1bGUsOBoqET3XA431DaSLfkL?=
 =?us-ascii?Q?I9tZCsBcKwSC62HjdphOtMIViHXapW4tzMatqK1gIBIrwyQefBJz57+gEQQm?=
 =?us-ascii?Q?9qCF2slTEfxHzKRfcjz9E8+sj9pm0AXWK9JuWXMNZmj6JIqwKesdc7SMquzU?=
 =?us-ascii?Q?pmgb/FOyFSCelZ89ZskPvBQP8DSFXYat3aovyd+0Uksx5pFyikKQNeXtOI+w?=
 =?us-ascii?Q?4TjP194pAPmuUq9SLHv3jWprx2gcMeDptk/N7zAlUuSV7it89A3sFn9NOE89?=
 =?us-ascii?Q?/LEHF6S0Khyvi8DTXnr7JA61IA3x7gQnWs5JZvmroFhKg6BPza8LHBjxPFAB?=
 =?us-ascii?Q?F6iYntakW6UR7U+Qzia1+W0KGy9r81OLccHwO14Cj9hEDG8nzv9OuD2Ve8Cy?=
 =?us-ascii?Q?DAqOLZlkvr/Dx78yj3zB4X39?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <434C2B51F511AA42A45C59B0040789C2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382de6f4-03f7-48ad-50c9-08d917234735
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 21:57:33.3947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixDYQj/1Nxc1XDR34V6oAvhvY3WEdB+kqWwBvPeQsk+ZU0PzSLXgCc1uBOSItP/0BLmUyOvgwRfa9DmZkzoxHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1838
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140170
X-Proofpoint-GUID: WxcRwN3bSK_Mxz23YA5iCgU_FFvoJHmc
X-Proofpoint-ORIG-GUID: WxcRwN3bSK_Mxz23YA5iCgU_FFvoJHmc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [210514 11:37]:
> On Fri, May 14, 2021 at 05:32:15PM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
> > > +static inline unsigned long mte_pivot(const struct maple_enode *mn,
> > > +				 unsigned char piv)
> > > +{
> > > +	struct maple_node *node =3D mte_to_node(mn);
> > > +
> > > +	switch (mte_node_type(mn)) {
> > > +	case maple_arange_64:
> > > +		return node->ma64.pivot[piv];
> > > +	case maple_range_64:
> > > +	case maple_leaf_64:
> > > +		return node->mr64.pivot[piv];
> > > +	case maple_dense:
> > > +	default:
> > > +		return 0;
> > > +	}
> > > +}
>=20
> Why is @piv 'unsigned char' ? Does that actually generate better code on
> any architecture?

unsigned char is to match ma_state struct offset which is kept small
for cache efficiency.

>=20
> At the same time; there's no bounds check.
>=20

I will add an assert.  Thanks.
