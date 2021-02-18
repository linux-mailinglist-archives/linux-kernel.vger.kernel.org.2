Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517C531EB1C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhBROtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:49:05 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:24034 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233253AbhBRMuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:50:17 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ICjNYI029272;
        Thu, 18 Feb 2021 04:49:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=3nupu+JQ/TrWQnaeDEN2cDtmC8SkkRzXOFLXdn0FUxI=;
 b=VW2zzWDNAmO80iG53LLFhuno7d9pNpzXUHZtkP1YZBXJ3bgO5bZAzMqfLfFWphSm4tiu
 NZxQ5BLP04JYtxkYwBUWKWOEwYbmac2/hap2+U5WWpOvpOBGtNdbCOZzmqayWuiRxowg
 Wlc/yr07zUw6ttRqReKhi6aBNlQDG0GYdlxjNktTrXiKXmZ38JI5R6QzSNut+QyVodQ9
 Ixykehi2RvTzw5O9MYfkIhVzfYcrVuYHqaL9pmd5Dq56NM8wpRvAI1X8OsxxQ5T+CSt7
 TfEum5pPu+Yw5fOja1589QUBCAqFKmUULY4h8H6X5Mq8hTUXrdqqFImnoEALCCmJp8Km AA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36sesvsk2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 04:49:09 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Feb
 2021 04:49:07 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Feb
 2021 04:49:06 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.51) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 18 Feb 2021 04:49:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdKqjilHHOMYPxudHSUvauh8hyruKv9pvkyZm+HhT4ljUOMirkXHEqOOeDhNXtfpjDepePhSG2gjyzJzOMlL6jqN1rhDt1Di2pbS9mkzZ1wBNfjQLbqu6B904wd0cMzeboZBYSklvzI9lfyQC4+W6LVk8yBVYQRWpu5Vq8y2PBa/JFQR7YbFtgjy8swxYTq0T0UdIXVI/DdjftfLf6vk6SPdt6ZmWnx+F9QmWc0A/Xnac14zI/Hz3SmQ5Nam6T2e+ER3JBDQ3PFIERHlhWjMjfzT6hGSB8ah8fHCbvtVdoRyOp3lmTVLegCbgeliXZ08QuP281dDAoEGTxfNLF8+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nupu+JQ/TrWQnaeDEN2cDtmC8SkkRzXOFLXdn0FUxI=;
 b=XeALDx6z/37nmTv8SKlx+sotTcBH8q37sC+5HzVCSbPBs6RhuQA87YkCQyXyBA+C2UKx/KBTP44rAP79TA18fyDAN0AU/Mjse/tdZ120tWdgKfhzmIJYLDyB0gbFSqaLDmqhdC8dmWJ3ZuLcq1GXtBDteejj+Qeh66P5YDe8WZ0ftmLwZSRjGl0NysH+RJAjqOhvtTVopfxdGa/Jc3on7yY3nQ6KrFQhYU8SjBwvgEFhMdsTp+g97/vWQI+HnDNe22cHXFX3OCJ2x+kTwKj5mvc8vcBmwclMK1YGL5dALWwZCz2TzcQeGD4Su3T5XQvT6xLWvdywAOw8pYDUJ24lAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nupu+JQ/TrWQnaeDEN2cDtmC8SkkRzXOFLXdn0FUxI=;
 b=G9FNY3yRRAGTXU7WrwRtPBx73R8cpHmp6kOgcQrRJWCIFWvhpxHq015DjO4Xeu1+Ynl3b0DjHLakllY65lS2Sww+3MmY5eWz5jceUZZNVD6I3Iky0OCzplHN2RVAnlwyXuDjpK86Cm9J+4ppWRuZVYepzc44eiwhTNawVC5oHss=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by BL0PR18MB2115.namprd18.prod.outlook.com (2603:10b6:207:42::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Thu, 18 Feb
 2021 12:49:05 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::e1a5:c2b3:1ec2:deac]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::e1a5:c2b3:1ec2:deac%3]) with mapi id 15.20.3846.043; Thu, 18 Feb 2021
 12:49:05 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        Yuval Basson <ybason@marvell.com>,
        "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: drivers/infiniband/hw/qedr/verbs.c:1925
 qedr_create_user_qp() error: we previously assumed 'ctx' could be null (see
 line 1900)
Thread-Topic: [EXT] Re: drivers/infiniband/hw/qedr/verbs.c:1925
 qedr_create_user_qp() error: we previously assumed 'ctx' could be null (see
 line 1900)
Thread-Index: AQHXBJaF1+RJv1eoAE60RkquBn8Gjqpd35Ew
Date:   Thu, 18 Feb 2021 12:49:05 +0000
Message-ID: <MN2PR18MB3182C091976ACAE07FF33329A1859@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20210215133125.GP2087@kadam> <20210216190321.GG4247@nvidia.com>
In-Reply-To: <20210216190321.GG4247@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.59.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8ae6ffa-7e9e-4db5-acd1-08d8d40b9331
x-ms-traffictypediagnostic: BL0PR18MB2115:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR18MB21151CA6D5D4C4B075251D34A1859@BL0PR18MB2115.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rLs2reytC6q2R4p2o6voZs5Cl+MLy32yCw+3SVo61YH/brGmtE6w4bN8Tm6jhbwea3vmdpKbwgg5ETqdMcQqB1i66WWE51IzZrI/XDPtNd5kQriueI1DiICIwOxhhrXhVC0/VR3Q0ZBA0r1TIxBg/3EI0D2jaZFTBntT3Tw7qpGZlcioc7HjqQbmtFmRO2nmKMzDIdn90wY4xJRloE0FaqIPibajiuJ73xtgHORouq6l1H21ZLk/68oQEGaO1Q2+ZtcxcnqywlHA6WWb3QRBRPwu+8BWo6hWuYezpu51ugp+A33SpbtCR5s3SYhyEcxi/laFugKEBfeMNGryfEag1YNlvCDbPvMUf3Upj1sI0fR/mypKl7+a85x+v3wNfqet8YRWtoHz7p9zESQcF6T2Cq3jayMlYWkr5+6m3jfuH7aFXgUS9qFnz0E7WtoBMrjf7VaReAwsR0WEz1vs5qrsiN3bG80cpvzXjxuR/ACnuWZcZbl46ZaUmlXHr3nbD0vwOdMrsXsGM5RH4PwwtwezuJpl+NE1vk9BdVt5yFN7sJuYAVC5PRpAK7guQ2Nd/n9wqZ3KyKhA9tWITiqf+9WkpnjoTXEXk6rXfPadE5pBYSA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(366004)(346002)(396003)(136003)(966005)(33656002)(76116006)(7696005)(83380400001)(478600001)(8676002)(54906003)(110136005)(8936002)(86362001)(5660300002)(186003)(66556008)(19627235002)(316002)(55016002)(2906002)(9686003)(52536014)(66446008)(66476007)(6506007)(4001150100001)(71200400001)(4326008)(64756008)(26005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+y3uKPz+4AwkC0+qxsuK6ost46ockOBrPS8aHsOreaBWQkcTUglExPu8NQzm?=
 =?us-ascii?Q?a19MZI0LoIOM2VYhqdMDxVqhsjOZpKPlODhzEG338iCZUX0jF1t9wsMpi0Kd?=
 =?us-ascii?Q?41XoAsDQlZTzqvykxq9EZifGDtmGRcunifXzH+FF9DTf1xPNMKG2stjlAv4Y?=
 =?us-ascii?Q?usj4PFN5kBDCuqfnQhebH2MVLVckcWf5Zqq/+sO0WEQs1JGgb0TE6zHmhzg/?=
 =?us-ascii?Q?xyNTOMPDB1cszkKotorT8uM+yaSXcC42Qj5YnyyhtbOGvlMge04RkwkddOl2?=
 =?us-ascii?Q?4jGy5fvHEXE8lWivEDprtuklB99ILUNu/jm1eDhkpETYg2wRZM2zEcdpHA9j?=
 =?us-ascii?Q?1/yMiTM7n6mCp9YdgM90vewEdU8bVX/oFD42JmJRLpXGFpKkQBMboUXDKi0C?=
 =?us-ascii?Q?XHDpLXh6FWAHfOKzxjIcLGgn6rgNYhrf8iZ4nYdZQEQZDACHzoHZ26uvv9he?=
 =?us-ascii?Q?2PCfifvpv5JKEVzgbRxKzemyBCwsbPh8Rnvb9K15aqYx/tQiXL9cz9fFoOOs?=
 =?us-ascii?Q?jDhmPoGCjtjReoKn8SRZM83XdBWPSYTAbMrMLHjLbzUi09GayE37FKcfEVOG?=
 =?us-ascii?Q?jJ0r/f1ezUsqf4zs+Tz441+bvBJxqwtMdLMKQeAKB5Ik/mY4/dUdiSXfOfbN?=
 =?us-ascii?Q?CBK8PgaW3YXClyreARnTTZ1MnbXq5O0CBeJNVHY1EoU6M9i9ywhgxvw0p3A1?=
 =?us-ascii?Q?ITQ8J+jl5xFSUXXvOWJEoU3EIz7RyugLhNDRKZRkSbkg15B0dZjP42wiSWXm?=
 =?us-ascii?Q?uLE7H03ROLEo0AtZuM1E4exHlkNBZ4WyJfEITOis48//J4ByBIWgq037DtPk?=
 =?us-ascii?Q?3QRJ0FpvSHAzmEhDeAlkbQoQeQork9gnO1zJnksE2epGZgr9R6cVLtF2c51P?=
 =?us-ascii?Q?0wDizBvZJCnfMCOP1qqfGYfp2IhnjwONX/qNyg2vCq+KM6OB06PWh9jHQ4uZ?=
 =?us-ascii?Q?ZL7ZwlXGZDoEziv7b2cYdhFADz07Jac3ffpU5ddRtf6yQA1aQlviCJOxD1MW?=
 =?us-ascii?Q?kzwJr4UyBIu/cVyT/t72S555EAAkF4qQcgmPb/EqwH+36gQ+HysITpqeUl6z?=
 =?us-ascii?Q?EYY2FRYvT8kKQjZY0JRjwQqARJQJIkWFnH+yXQU5e9gPhd9W1f0AA9S7dKhr?=
 =?us-ascii?Q?7LIaOa6QvBGGjAZsxO9TxBwa9EmX+yx1JJFD6qtDb2gVQ6H2FZ3CwO4Dsyu5?=
 =?us-ascii?Q?PlCnL55CxCyvRO8N0YZciKieYmjsqHys+o6+5O9pvYcW110z0oEVVCZYYpm1?=
 =?us-ascii?Q?njAo9f1NWti/+3w8X5D36ua5gzYNEyEOyuopSx3vejQ3IiHwYu/0SvYQBqZp?=
 =?us-ascii?Q?ZqigHHBSuDsO+oduVrTazQKR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ae6ffa-7e9e-4db5-acd1-08d8d40b9331
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 12:49:05.1350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmH5CqFAds/+/dqKaciA/yqJ9X8XevgihO0tbkNK1y8koPP4rVC3y42LA4g8cjdoYENJSMyMzxRAb1ANzr4KfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2115
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_05:2021-02-18,2021-02-18 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, February 16, 2021 9:03 PM
>=20
> ----------------------------------------------------------------------
> On Mon, Feb 15, 2021 at 04:31:25PM +0300, Dan Carpenter wrote:
> > tree:   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__git.kernel.org_pub_scm_linux_kernel_git_torvalds_linux.git&d=3DDwIBA
> g&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D5_8rRZTDuAS-6X-
> cGRU9Fo4yjCnkS1t7T3-gjL4FQng&m=3DYhK42aIA63YEc6ZxxEMSWb1_-
> N4zC52vzPRN82lyUa8&s=3DZwYelPnxs3xwj988Lf0pr8AJK-
> oWmLXMQyGqlv74dtI&e=3D  master
> > head:   dcc0b49040c70ad827a7f3d58a21b01fdb14e749
> > commit: 06e8d1df46ed52eca6915a2a76341ca65cc428b9 RDMA/qedr: Add
> > support for user mode XRC-SRQ's
> > config: x86_64-randconfig-m001-20210213 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > smatch warnings:
> > drivers/infiniband/hw/qedr/verbs.c:1925 qedr_create_user_qp() error:
> > we previously assumed 'ctx' could be null (see line 1900)
> >
> > vim +/ctx +1925 drivers/infiniband/hw/qedr/verbs.c
> >
> > df15856132bc83 Amrani, Ram       2016-12-22  1830  static int
> qedr_create_user_qp(struct qedr_dev *dev,
> > cecbcddf6461a1 Ram Amrani        2016-10-10  1831
> struct qedr_qp *qp,
> > df15856132bc83 Amrani, Ram       2016-12-22  1832
> struct ib_pd *ibpd,
> > df15856132bc83 Amrani, Ram       2016-12-22  1833
> struct ib_udata *udata,
> > df15856132bc83 Amrani, Ram       2016-12-22  1834
> struct ib_qp_init_attr *attrs)
> > cecbcddf6461a1 Ram Amrani        2016-10-10  1835  {
> > df15856132bc83 Amrani, Ram       2016-12-22  1836  	struct
> qed_rdma_create_qp_in_params in_params;
> > df15856132bc83 Amrani, Ram       2016-12-22  1837  	struct
> qed_rdma_create_qp_out_params out_params;
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1838  	struct
> qedr_create_qp_uresp uresp =3D {};
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1839  	struct
> qedr_create_qp_ureq ureq =3D {};
> > 69ad0e7fe8452a Kalderon, Michal  2017-07-26  1840  	int alloc_and_init =
=3D
> rdma_protocol_roce(&dev->ibdev, 1);
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1841  	struct qedr_ucontex=
t
> *ctx =3D NULL;
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1842  	struct qedr_pd *pd =
=3D
> NULL;
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1843  	int rc =3D 0;
> > cecbcddf6461a1 Ram Amrani        2016-10-10  1844
> > 82af6d19d8d922 Michal Kalderon   2019-10-27  1845  	qp->create_type =3D
> QEDR_QP_CREATE_USER;
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1846
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1847  	if (ibpd) {
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1848  		pd =3D
> get_qedr_pd(ibpd);
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1849  		ctx =3D pd-
> >uctx;
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1850  	}
> >
> > "ctx" is NULL on the else path.
>=20
> Looks like ibpd can never be NULL, so this is dead code
>=20
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1851
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1852  	if (udata) {
>=20
> udata also can never be null because this is called 'qedr_create_user_qp'=
 ?
>=20
> It is confusingly called with a xrcd test too, but xrcd's are only curren=
tly
> possible if udata is set.
>=20
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1853  		rc =3D
> ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1854
> 		udata->inlen));
> > df15856132bc83 Amrani, Ram       2016-12-22  1855  		if (rc) {
> > df15856132bc83 Amrani, Ram       2016-12-22  1856
> 	DP_ERR(dev, "Problem copying data from user space\n");
> > df15856132bc83 Amrani, Ram       2016-12-22  1857
> 	return rc;
> > df15856132bc83 Amrani, Ram       2016-12-22  1858  		}
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1859  	}
> > cecbcddf6461a1 Ram Amrani        2016-10-10  1860
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1861  	if
> (qedr_qp_has_sq(qp)) {
> > 72b894b09a96b7 Christoph Hellwig 2019-11-13  1862  		/* SQ - read
> access only (0) */
> > b0ea0fa5435f9d Jason Gunthorpe   2019-01-09  1863  		rc =3D
> qedr_init_user_queue(udata, dev, &qp->usq, ureq.sq_addr,
> > 72b894b09a96b7 Christoph Hellwig 2019-11-13  1864
> 		  ureq.sq_len, true, 0, alloc_and_init);
> > df15856132bc83 Amrani, Ram       2016-12-22  1865  		if (rc)
> > df15856132bc83 Amrani, Ram       2016-12-22  1866
> 	return rc;
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1867  	}
> > cecbcddf6461a1 Ram Amrani        2016-10-10  1868
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1869  	if
> (qedr_qp_has_rq(qp)) {
> > 72b894b09a96b7 Christoph Hellwig 2019-11-13  1870  		/* RQ - read
> access only (0) */
> > b0ea0fa5435f9d Jason Gunthorpe   2019-01-09  1871  		rc =3D
> qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
> > 72b894b09a96b7 Christoph Hellwig 2019-11-13  1872
> 		  ureq.rq_len, true, 0, alloc_and_init);
> > df15856132bc83 Amrani, Ram       2016-12-22  1873  		if (rc)
> > df15856132bc83 Amrani, Ram       2016-12-22  1874
> 	return rc;
> > 40b173ddce0fc6 Yuval Bason       2018-08-09  1875  	}
> > df15856132bc83 Amrani, Ram       2016-12-22  1876
> > df15856132bc83 Amrani, Ram       2016-12-22  1877  	memset(&in_params,
> 0, sizeof(in_params));
> > df15856132bc83 Amrani, Ram       2016-12-22  1878
> 	qedr_init_common_qp_in_params(dev, pd, qp, attrs, false,
> &in_params);
> > df15856132bc83 Amrani, Ram       2016-12-22  1879
> 	in_params.qp_handle_lo =3D ureq.qp_handle_lo;
> > df15856132bc83 Amrani, Ram       2016-12-22  1880
> 	in_params.qp_handle_hi =3D ureq.qp_handle_hi;
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1881
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1882  	if (qp->qp_type =3D=
=3D
> IB_QPT_XRC_TGT) {
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1883  		struct
> qedr_xrcd *xrcd =3D get_qedr_xrcd(attrs->xrcd);
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1884
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1885
> 	in_params.xrcd_id =3D xrcd->xrcd_id;
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1886
> 	in_params.qp_handle_lo =3D qp->qp_id;
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1887
> 	in_params.use_srq =3D 1;
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1888  	}
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1889
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1890  	if
> (qedr_qp_has_sq(qp)) {
> > df15856132bc83 Amrani, Ram       2016-12-22  1891
> 	in_params.sq_num_pages =3D qp->usq.pbl_info.num_pbes;
> > df15856132bc83 Amrani, Ram       2016-12-22  1892
> 	in_params.sq_pbl_ptr =3D qp->usq.pbl_tbl->pa;
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1893  	}
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1894
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1895  	if
> (qedr_qp_has_rq(qp)) {
> > df15856132bc83 Amrani, Ram       2016-12-22  1896
> 	in_params.rq_num_pages =3D qp->urq.pbl_info.num_pbes;
> > df15856132bc83 Amrani, Ram       2016-12-22  1897
> 	in_params.rq_pbl_ptr =3D qp->urq.pbl_tbl->pa;
> > 40b173ddce0fc6 Yuval Bason       2018-08-09  1898  	}
> > df15856132bc83 Amrani, Ram       2016-12-22  1899
> > bbe4f4245271bd Michal Kalderon   2020-07-07 @1900  	if (ctx)
> >                                                             ^^^ Check
> > for NULL
> >
> > bbe4f4245271bd Michal Kalderon   2020-07-07  1901
> 	SET_FIELD(in_params.flags, QED_ROCE_EDPM_MODE, ctx-
> >edpm_mode);
> > bbe4f4245271bd Michal Kalderon   2020-07-07  1902
> > df15856132bc83 Amrani, Ram       2016-12-22  1903  	qp->qed_qp =3D dev-
> >ops->rdma_create_qp(dev->rdma_ctx,
> > df15856132bc83 Amrani, Ram       2016-12-22  1904
> 		      &in_params, &out_params);
> > df15856132bc83 Amrani, Ram       2016-12-22  1905
> > df15856132bc83 Amrani, Ram       2016-12-22  1906  	if (!qp->qed_qp) {
> > df15856132bc83 Amrani, Ram       2016-12-22  1907  		rc =3D -
> ENOMEM;
> > df15856132bc83 Amrani, Ram       2016-12-22  1908  		goto err1;
> > df15856132bc83 Amrani, Ram       2016-12-22  1909  	}
> > df15856132bc83 Amrani, Ram       2016-12-22  1910
> > 69ad0e7fe8452a Kalderon, Michal  2017-07-26  1911  	if
> (rdma_protocol_iwarp(&dev->ibdev, 1))
> > 69ad0e7fe8452a Kalderon, Michal  2017-07-26  1912
> 	qedr_iwarp_populate_user_qp(dev, qp, &out_params);
> > 69ad0e7fe8452a Kalderon, Michal  2017-07-26  1913
> > df15856132bc83 Amrani, Ram       2016-12-22  1914  	qp->qp_id =3D
> out_params.qp_id;
> > df15856132bc83 Amrani, Ram       2016-12-22  1915  	qp->icid =3D
> out_params.icid;
> > df15856132bc83 Amrani, Ram       2016-12-22  1916
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1917  	if (udata) {
> > 97f612509294aa Michal Kalderon   2019-10-30  1918  		rc =3D
> qedr_copy_qp_uresp(dev, qp, udata, &uresp);
> > 97f612509294aa Michal Kalderon   2019-10-30  1919  		if (rc)
> > 97f612509294aa Michal Kalderon   2019-10-30  1920  			goto
> err;
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1921  	}
> > 97f612509294aa Michal Kalderon   2019-10-30  1922
> > 97f612509294aa Michal Kalderon   2019-10-30  1923  	/* db offset was
> calculated in copy_qp_uresp, now set in the user q */
> > 06e8d1df46ed52 Yuval Basson      2020-07-22  1924  	if
> (qedr_qp_has_sq(qp)) {
> > 97f612509294aa Michal Kalderon   2019-10-30 @1925  		qp-
> >usq.db_addr =3D ctx->dpi_addr + uresp.sq_db_offset;
> >
> > ^^^^^^^^^^^^^ Can "ctx" be NULL here?
>=20
> This would also not work right if udata =3D=3D NULL
>=20
> Whole function needs cleaning, but doesn't look buggy
>=20
Thanks, agreed, and will take care of the function re-write.

> Jason
