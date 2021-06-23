Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A679C3B19C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhFWMWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:22:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60560 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230182AbhFWMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:22:36 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15NCCGUX024873;
        Wed, 23 Jun 2021 12:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Usc/1zZLijzzHtfR7QCKHX3m3SVYcnAeeSiAsqWQX5M=;
 b=Vq9z7vGryCopVn3Stav27k8zgrR4R8ooFid5qpLjfjmK1s+c3XpxZFC8GDJ8p83I2nEV
 dohXmYPTiQEurs0q6+HnOxxXTjI7FbY2PsFD+2DhyyuYb2jsRhdZk1CH0zJMOezWFq82
 j/7x2xJ/440Fbp+zCaGOsBHP9I+FzwiqS9JkFILvhXODEAChXM/Hmgzfk+i0cFrFWGoW
 zI8CrcvlEARysRY2FrH6Llyr/UGN2KxpEP7GncYuCcecJ8cOgCkcPG27PNeDrAldSiS4
 RlrGAHvwy1FNi5rKeetG5oqsSGj0GCp31EI89E57WcJ8aPfSausUD+uKZD3ZHrO4C763 Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39b98vbnc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 12:20:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15NCFUQI003456;
        Wed, 23 Jun 2021 12:20:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 3998d91juj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 12:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3HBYWvi3Z+U+Fnb/Hi9slpXXhvaDNiLAzp48E0VUrjeVX5Zvib/fwsFhoIKWbf5aiJUl1BLZzfRTai5m79mHpaFNTScrKjsoQ1n2buYPJz5iaC/jcmeTrU4W2J5AfhJ/yOOiSBO8vYZK1cW7HeZbIlPECrtCq7qlH6srJGboevax3Y+xB1sPTkc/JGTMzBWT5xVr2jkLfhIL5XgDseNOYTE7oAsc9K4iGJD0CWMS8joO3anGZ97/TvJFXdGot7W1DECqzw4zSp8i+9HB/zSLFJ2cx8EznKdetsJSZ7I25ORktK+wQfVDE7XwgVLpa94mNdj4xUdsrolFM53uNClkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usc/1zZLijzzHtfR7QCKHX3m3SVYcnAeeSiAsqWQX5M=;
 b=SaPH8Ynw8X93tP4AxsvmYa0Xjc8I1zU9V/nvVtt4TLsW3qsAM64LKAKNx97uLhw+Y1yHSazMH/YIRt9QdvCMHyCiuj2p/7XwzCKNcNOePj7pPiwwa7f5GM7+tsxTTazpxYrsmSpqOX6J1o8AkhPywSNeMDr+yd+4mqRIZNLKPirrJvmjWSu+VRV3JVnezJ9aLNyMw0PWf+thK7vsb35NAFDo14jzNsp5PvuyPC4MmgD4MdPgr6OEsaIxd44lj2hUFFsjvhfNkXVXkP6UMcA7apPIW9CJa8dP7KQWvUWrchrVljimXfidemnayuHOlXbcCadwh+jm6FCakFNxLD+HHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usc/1zZLijzzHtfR7QCKHX3m3SVYcnAeeSiAsqWQX5M=;
 b=hwKXnShrNLPwHX2v4wezNYbPp+dQ4zsB9MPRwp2w/zJGsF2a/Dp2b0hDPOiU5Y8/CeuHocxxb/AY1EJXRgF/g/9SzT7OH9+nwpJQeF2nrfVh84YFjHCEtgH7IOcTHoykTK3v6EkD4Aqr3Lt/rnsCtFliQ5xRWmeynsYE47DGlDM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 12:20:11 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%9]) with mapi id 15.20.4264.018; Wed, 23 Jun 2021
 12:20:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: net/sunrpc/xprtrdma/frwr_ops.c:647 frwr_unmap_async() error:
 potentially dereferencing uninitialized 'last'.
Thread-Topic: net/sunrpc/xprtrdma/frwr_ops.c:647 frwr_unmap_async() error:
 potentially dereferencing uninitialized 'last'.
Thread-Index: AQHXaBeWlhdE8uf3IEa+3BIwO2IPIashhAeA
Date:   Wed, 23 Jun 2021 12:20:10 +0000
Message-ID: <AAA93115-ABDD-44DA-9784-B8A001E9CEC5@oracle.com>
References: <202106231840.ECkPJRDx-lkp@intel.com>
In-Reply-To: <202106231840.ECkPJRDx-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1c3e46a-a9de-4dbf-22fb-08d936413f2c
x-ms-traffictypediagnostic: SJ0PR10MB4688:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB46881C8F2D2D03177122ACF693089@SJ0PR10MB4688.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ERiFZT2UEUQXsZYLcVBPMDOjdqsabzuBvoA2PJ9B0gYbEEqeyq69+wmsQJnlt+YG2Rf1+4T9kmxrKTKH4p9VvGnIVyo6ZlIKGRFIHPpByZoc1boGyUZK9/3IYJzA8BhadpXPGO6wHK8j/PhEkLZjKvXpK8AdsnVofb6Y9po/64HEi3/OjHTwUmQWQ+B+0oLYBw8h8PD/9NDRy8n3ncJD3yDGj+vz3gmeps/8Wc9Anbh6uCLmbmNttriAv5swPV3xX1RB3duR7KQubsAbfH9KEHrl2MYxQTwKlL6NnezZWW11GlcOJHNBgisGpPo3mg6jZeTyw+p8H7FpojHy81SkkT6DesfeLlX+tSHUz6Q0m9ELXaW45y0myk2Z+QDI7w4DxJ+dEN0l8PU45uWQNksvs1Ge3TqSa8opvzvMsluiY+gjPv7eIgC0F6pUSJMA7CIcFMNkk+5ysxMzWBB15g2Rlq+BUMks+7xgOxjPi/MM8aga4PDbh2UlDe/d/QdtLXKuOQPm5h3G97Lyj9ShSOEhE4fcLQNlBvfZK9S0ENyltfXsa+qtZJSR1YGCfgoP55JWauoVTjVoQi0Lrqm1PvwHBbjNW6kY2XDrv0SAh7SX4IH0/W1ARXaEtB3MV22VAz/yXK/8Blq16Hn2snko4oQWmZoAkTJ1rE3SFA1gMzZy1Lkt+LmFs7Au+4lX0VxSN/mSx64T+Y+j07UOt1sPTahng+3OauGka2Z9cw7xH5sVRd6DNIRAtrHdSUiKtG8YG5XxC3ElnKGJfRrT4nXcm2okj3tvvVbwWCVaCFvR/0QhNc57fdvvi51sTdBTtE6+kZjN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(396003)(346002)(86362001)(122000001)(6862004)(38100700002)(36756003)(186003)(53546011)(6506007)(71200400001)(37006003)(4326008)(54906003)(2906002)(6636002)(83380400001)(66476007)(64756008)(66556008)(6486002)(316002)(478600001)(966005)(2616005)(6512007)(66946007)(5660300002)(26005)(91956017)(8676002)(33656002)(76116006)(66446008)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9OUmr/pZhFfMZlq9w8PYpopBkWKyyHqyg5HqO9wfheJG4xrMxAVzWhka0cMH?=
 =?us-ascii?Q?zn3c0j1r5eWW7mVbzhnRfNwNvb8aA/x17Z+fljuKkdOX5KjE2k3tOWi1v6We?=
 =?us-ascii?Q?v74nV2gGrGOlKozKrX8InhUKALvJEIkPeRXHDFYyxRH/ZnEhBN27TdrDwwHL?=
 =?us-ascii?Q?0hD8s+i1h1bE10O7XbSD3coooM1XgLLGRjtkEJ0+ACuwdlFqF2Y15Oy98XV/?=
 =?us-ascii?Q?ngdPbduD3nl9MJbWYvTPYLzu2l4kGIiaagGS9QIHOK5X6L8g7EIPP90Ago/l?=
 =?us-ascii?Q?HiWBekWcdEiSnIZqZDgpZwfmPU4NDiQvPCnrrkpHof0haYKP57Jye3p5g2fE?=
 =?us-ascii?Q?udjagM/jg4+a4vG27J0lIGbyjwY2cW75Ao6S2xg0gklzrIqG9TPnrv9T7WaN?=
 =?us-ascii?Q?zZlwuAHswdzTIRC0Kpj2oY/1JK/kJdpmD6Y35kvT0s7nRMCP2W3Jf0lF+3nl?=
 =?us-ascii?Q?c5cfyjY2t0w3z2eut2E1stscGYfolCrN8e9cIML0MsmOZGf0ps7jaNS7P4kB?=
 =?us-ascii?Q?L6ChLrIox02AXLvQkE5Ez0FvJI6DRBSNTc3fhAFCOfdUX/8yzcv0hYRYlzBb?=
 =?us-ascii?Q?xJXfL19gI4wpYNEkST28AggUj9F7GVvx8Iate1cvda0INsrGQrshKZLPdTZo?=
 =?us-ascii?Q?J1zta/k7/e0RC22P9baOxYCTa6nlByLDrXUUVqPmnX7a/ajpYvc//Tz8lpFj?=
 =?us-ascii?Q?baPeKTW6qr5qhkJI0X1SOpZ2SMSoo8q+x3XaVlAyes2wUAFu7XYXuKxROk2S?=
 =?us-ascii?Q?yPIJ1OOrcwqwR+ltSiTHdy4gmONR6d88hUL4TtcTS6M4eSWHqnxCwSvo66Ca?=
 =?us-ascii?Q?QDyNqgvZkOlBqoO1/TovvH/Japp3qys5ojbODkDgIqx1cwrH7m17nqlBlz/r?=
 =?us-ascii?Q?WfSDKEEg77UhNMica+JH77clal4z+tx7yv1IcI3BYJqqFonAdhRAbf6SYJh5?=
 =?us-ascii?Q?9cLdEevF0smXV4XIdBpd82Gp9uLE9U2MSO6blRqOZ5qaNbFgStT7jybfRQbd?=
 =?us-ascii?Q?W0HhNZC9KUbLDJrF7FDQAKMYP4Fd3YDV8SidF9HygpRodIOg63yTKL3W8D7H?=
 =?us-ascii?Q?J0NfTbv/ZmBYj1j8xuITdiyfVISWGNxayhz4B/sSHVGKwicGeDz3isARxxac?=
 =?us-ascii?Q?dwWo9s2mNhikOgebS6dbM7LMsGsoOUThkqt1wN93w1v1tYRuwbjwpuV6stHw?=
 =?us-ascii?Q?h+R5JBnfug7t81S988tZlppJ5V5ZtlNh+X1RSs1DM3bMzBC6pXj7ywdGPSSO?=
 =?us-ascii?Q?F2S1oNSG0KVoxxF1aIwTFndhSRDu2X94CuvcVVEJzeEmLjkfwD9a/lCinaLR?=
 =?us-ascii?Q?ughQMqeo6yEa0wRz/s/Rlxjx?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0FBBB61E3DF7634DA3B4471BAC3C8FAC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c3e46a-a9de-4dbf-22fb-08d936413f2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 12:20:10.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzZb5QV1LM3Ugd4da95AVoSobwJS1Ihe4MM1gG2jukA8icSOVxucQkH28dWSKhfQG3io6mgOc9ivfrzCmCY6yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4688
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10023 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106230071
X-Proofpoint-ORIG-GUID: phbfov9UKrJeyBEoXbVLu5a4dJo1gPlA
X-Proofpoint-GUID: phbfov9UKrJeyBEoXbVLu5a4dJo1gPlA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy Dan!

> On Jun 23, 2021, at 6:07 AM, Dan Carpenter <dan.carpenter@oracle.com> wro=
te:
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   0c18f29aae7ce3dadd26d8ee3505d07cc982df75
> commit: e10fa96d347488d1fd278e84f52ba7b25067cc71 xprtrdma: Move cqe to st=
ruct rpcrdma_mr
> config: x86_64-randconfig-m001-20210622 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> New smatch warnings:
> net/sunrpc/xprtrdma/frwr_ops.c:647 frwr_unmap_async() error: potentially =
dereferencing uninitialized 'last'.
>=20
> Old smatch warnings:
> net/sunrpc/xprtrdma/frwr_ops.c:546 frwr_unmap_sync() error: potentially d=
ereferencing uninitialized 'last'.
>=20
> vim +/last +647 net/sunrpc/xprtrdma/frwr_ops.c
>=20
> d8099feda4833b Chuck Lever 2019-06-19  608  void frwr_unmap_async(struct =
rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
> d8099feda4833b Chuck Lever 2019-06-19  609  {
> d8099feda4833b Chuck Lever 2019-06-19  610  	struct ib_send_wr *first, *l=
ast, **prev;
> 5ecef9c8436695 Chuck Lever 2020-11-09  611  	struct rpcrdma_ep *ep =3D r_=
xprt->rx_ep;
> d8099feda4833b Chuck Lever 2019-06-19  612  	struct rpcrdma_frwr *frwr;
> d8099feda4833b Chuck Lever 2019-06-19  613  	struct rpcrdma_mr *mr;
> d8099feda4833b Chuck Lever 2019-06-19  614  	int rc;
> d8099feda4833b Chuck Lever 2019-06-19  615 =20
> d8099feda4833b Chuck Lever 2019-06-19  616  	/* Chain the LOCAL_INV Work =
Requests and post them with
> d8099feda4833b Chuck Lever 2019-06-19  617  	 * a single ib_post_send() c=
all.
> d8099feda4833b Chuck Lever 2019-06-19  618  	 */
> d8099feda4833b Chuck Lever 2019-06-19  619  	frwr =3D NULL;
> d8099feda4833b Chuck Lever 2019-06-19  620  	prev =3D &first;
> 265a38d4611360 Chuck Lever 2019-08-19  621  	while ((mr =3D rpcrdma_mr_po=
p(&req->rl_registered))) {
>=20
> Is it possible for the ->rl_registered list to be empty?

The one and only call site for frwr_unmap_async() in in rpcrdma_reply_handl=
er():

1483         if (!list_empty(&req->rl_registered))
1484                 frwr_unmap_async(r_xprt, req);
1485                 /* LocalInv completion will complete the RPC */
1486         else
1487                 kref_put(&req->rl_kref, rpcrdma_reply_done);


> If not, then just ignore this email.

I seem to recall smatch catching this problem before. Is there a way
to annotate frwr_unmap_async() to calm smatch's nerves?


> d8099feda4833b Chuck Lever 2019-06-19  622 =20
> d8099feda4833b Chuck Lever 2019-06-19  623  		trace_xprtrdma_mr_localinv(=
mr);
> d8099feda4833b Chuck Lever 2019-06-19  624  		r_xprt->rx_stats.local_inv_=
needed++;
> d8099feda4833b Chuck Lever 2019-06-19  625 =20
> d8099feda4833b Chuck Lever 2019-06-19  626  		frwr =3D &mr->frwr;
> d8099feda4833b Chuck Lever 2019-06-19  627  		last =3D &frwr->fr_invwr;
> d8099feda4833b Chuck Lever 2019-06-19  628  		last->next =3D NULL;
> e10fa96d347488 Chuck Lever 2021-04-19  629  		last->wr_cqe =3D &mr->mr_cq=
e;
> d8099feda4833b Chuck Lever 2019-06-19  630  		last->sg_list =3D NULL;
> d8099feda4833b Chuck Lever 2019-06-19  631  		last->num_sge =3D 0;
> d8099feda4833b Chuck Lever 2019-06-19  632  		last->opcode =3D IB_WR_LOCA=
L_INV;
> d8099feda4833b Chuck Lever 2019-06-19  633  		last->send_flags =3D IB_SEN=
D_SIGNALED;
> d8099feda4833b Chuck Lever 2019-06-19  634  		last->ex.invalidate_rkey =
=3D mr->mr_handle;
> d8099feda4833b Chuck Lever 2019-06-19  635 =20
> e10fa96d347488 Chuck Lever 2021-04-19  636  		last->wr_cqe->done =3D frwr=
_wc_localinv;
> e10fa96d347488 Chuck Lever 2021-04-19  637 =20
> d8099feda4833b Chuck Lever 2019-06-19  638  		*prev =3D last;
> d8099feda4833b Chuck Lever 2019-06-19  639  		prev =3D &last->next;
> d8099feda4833b Chuck Lever 2019-06-19  640  	}
> d8099feda4833b Chuck Lever 2019-06-19  641 =20
> d8099feda4833b Chuck Lever 2019-06-19  642  	/* Strong send queue orderin=
g guarantees that when the
> d8099feda4833b Chuck Lever 2019-06-19  643  	 * last WR in the chain comp=
letes, all WRs in the chain
> d8099feda4833b Chuck Lever 2019-06-19  644  	 * are complete. The last co=
mpletion will wake up the
> d8099feda4833b Chuck Lever 2019-06-19  645  	 * RPC waiter.
> d8099feda4833b Chuck Lever 2019-06-19  646  	 */
> e10fa96d347488 Chuck Lever 2021-04-19 @647  	last->wr_cqe->done =3D frwr_=
wc_localinv_done;
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>=20

--
Chuck Lever



