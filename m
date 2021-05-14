Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7343812D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhENV0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:26:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14888 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhENV0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:26:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ELMlq0031734;
        Fri, 14 May 2021 21:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4aRSFvCGYib2RPBBkLTXqIdDAf1wSEiL822VcIcU1G8=;
 b=hYNa1FeM6a+Uzs2uYPY7mcEN+rnpD7YCgSdQ/He59sH+M+LPIxpv5fOHxXOkuTFbVyeI
 j5MTIl/zJ2sy7k1F2RCqanl8ulFDGxgMQi3HHotuPpVc61MOdP/ozkZVOtvRK5SjbdmM
 SPZegJW5VkeL9enDNfWHNMVVDBCNBLPA3evb3lTTyZGQekJkgHxSH8x7qpdBMdxASwm3
 qpCny+Tg7ma1dBvMtE/J/jvDf3JMh57OGr0hKdE4kRNuTQOKjVW3doTn9wr/CaVtr42/
 RG+zzr31WRcRhzuCm9EpaONN49nDGVvss7m4FRoS4FDxN7FGoa2IUcVTooOeUFe5f0L7 bA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gpqmgurb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 21:25:09 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14ELOMTk139772;
        Fri, 14 May 2021 21:25:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 38gppfcpw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 21:25:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdKPOcXU7ViURodyMnrpYk2K2l54xE63qBrxvQZFfutCty7s3DgvmWqaMm0HegQT82x6wn3t/xRqBfKvZ44rgsZNDEjcGIRRXZ9D4Yzs5D7YPerPTRxzdVppTipbrjRrUcAGvrSL/zY+TqtOP2x65Q1M/CUi4VpVr1fKRIwWG6rD5JVSVlXg+2PJW7wsdz/ycsW96HkEHgWDDgl+VOlb5UO0yiRjVIWoXUhos65a0ICkiO6UWKlffTpMiCmM26NqH0CVPlNJzJTsgo4iTbVSDDyTvVlowZUh9vsjdmUrp3q3/RfxoZgiv4fwisDYOkdPsl1iygr6NFK0ExJ/Cvn5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aRSFvCGYib2RPBBkLTXqIdDAf1wSEiL822VcIcU1G8=;
 b=FfiRFuijAhmjZXdQI5Qnm0LJanUca8xXDSp+0wGk1BBAQ3PT70Cjyr1L6wxlG3LiBpEsiEXH9iXwQ7hnB5jwdKBkQJjpCS/HfECw4SuK9FJ52ZBPBodkCU9IFWJhwMlsmpcgjSkLg5WlsCaRtEmNL5+ua+/gJ7yEA7IMiidYWtEbYMKFpzKPQZCvgovlzWqtvXRDWxEcqx2jPJ4awKsjcLgNllxQMID6gA2vSlxjcNToAxowf8Rn3ulQOanRw74WCc10svBOel5l4r3q/cD9Hpqk5ZcdfDsLR+FQnLPfbKlhUmeI1wOkzdfz9/c2DX9j+DQRjgkl2Xed8SmbEG0Vuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aRSFvCGYib2RPBBkLTXqIdDAf1wSEiL822VcIcU1G8=;
 b=l6A5VBjvVu5kTb1GPqiR3Ps4DNbaysihNcGF9r0AQ03AzGD9kwL9v7nbt0wb1HL6MBvforK7ou9uehp3kcaazTtynUzfS6/FGxVnD6gMEWHxg5aPa7rOfj42XhWVP3Inquf5sTMnmNpYzJ4DTVr8i8AhRD58qvvGU4KKZ+pSUFI=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1839.namprd10.prod.outlook.com (2603:10b6:300:10c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 14 May
 2021 21:25:07 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 21:25:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
Thread-Index: AQHXPEQyRs1g/Qku7UiibZzqyyuzcari910AgACfUYA=
Date:   Fri, 14 May 2021 21:25:06 +0000
Message-ID: <20210514212455.a4edseometr5lqbr@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
 <YJ5lDF4qGy8OaOJ/@hirez.programming.kicks-ass.net>
In-Reply-To: <YJ5lDF4qGy8OaOJ/@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71b0a0dc-47f3-474a-853a-08d9171ebf0b
x-ms-traffictypediagnostic: MWHPR10MB1839:
x-microsoft-antispam-prvs: <MWHPR10MB183930DF8593925685A4240AFD509@MWHPR10MB1839.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1RpQsZRPHDXn5jTlzo3WGLdGgd2FFkRNjy7mAOOufFdO8XdxBYZsva5xXuAs4+QJ4vGGef58twYXZuzTKiG2tALtMrUwUssiL35ZN/jv/TexNNpZopNBn8PsVgrOG+cJ8ek/NjOVNOAjHRtvsQDrQ3mqce0BLXAmVj4Ikr0a+h8/tz+jGXnr6t2s3PIgAOJPDkqTt4pFhb0wpMTHl3npP6TVshfhstoHmiHWEiqx5NDHrkxKRP3IQ3SD+tiDCUUHVhYrO1NF8GjcOQMUX4gmNHi75vKqBf0/RiwtGODbK6esETVwdrZRIMWJwDnyWK5k3WaAPlJQt91mm+jAQotvjND+LBZDyURiash9f1YriiQDlRYE5y+NHtrIsrdkU2THqPZiHB8FEAJxm8FglJKRYc4zs8ircVdjbnJR6aOtuqjlDQd0PE07v/Eh9qep5RSthH8sL+Cni7ulvI1uwDeD+BLh/Xe1S5XdQtgjV40+fwSKSMOcPk3MncycZLZTvYc4FdMGSiCLLx1CVfh/bS4akq2yMLCdnfu4gGR8S59vw+c7nBfqWmUjYQGSPforzV/JUzAMs8Vf+j7gc2GvgxDEqCEo9ha63qNAGVeS9CriTs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(346002)(396003)(376002)(366004)(39860400002)(2906002)(6506007)(71200400001)(4326008)(66476007)(66556008)(33716001)(38100700002)(8676002)(54906003)(5660300002)(66946007)(91956017)(76116006)(26005)(9686003)(478600001)(86362001)(6512007)(64756008)(66446008)(7416002)(316002)(122000001)(8936002)(1076003)(6486002)(4744005)(6916009)(186003)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ksBtv31tFxs3goDMGKjJrpU3DnSsTUmGx91bbiOSr/7B7uheyng193NKWNNf?=
 =?us-ascii?Q?VuhjVlw0pTMiH+PeKjFNH5nlQTIZkqb7x7G9RMzN0Km383FQ2YdZUtDCcPWG?=
 =?us-ascii?Q?xMyxN5ZLdfAqgazZdWBYi9Wi2TYBesK58ijg7yNtvRcKp8Qcj3zBCmmDjsvV?=
 =?us-ascii?Q?Zekh6RgMAKnanmpiedbnsStc3AW8hDFoynIdPJoM0BsN+wOkvkpJWmQluZ/u?=
 =?us-ascii?Q?WF+QNQqrXS3Syy2xAbiO75ZrS93x9OaycjMZbXf+6XnaaWhbVtkIcFdRI0vf?=
 =?us-ascii?Q?Fv9GHV+CuFOgwWadiAt7ieja/1ygHXGyWhlRpNLNHHXd6dFRHU3iaHIRbJWL?=
 =?us-ascii?Q?dDaDsdOD4K+K+XXiJeYxyue+Oh8GxL9feQlk+A3sR+Se43xqAPTpxfQu52vA?=
 =?us-ascii?Q?dSbKskVDueKzBJuZQDkvfjjEslCErZEgt6QcbTe6Oi6Pcr1Pea4/D8ortMf8?=
 =?us-ascii?Q?ZgQ2BRRMTjLiDKz7CEYYneiU4pTKhemyWNJ7FcqLnP03lre2yZ5jLXD0P8kJ?=
 =?us-ascii?Q?vAlbDqUGZjy/8BqOKesqrg2ilyM7k/mwCwfLW7w1piXmG+dqTtue9+xpf2GL?=
 =?us-ascii?Q?QMNxNWn1HujU7t220Z6V7vJVVQVHknJBsVKMMcjTPVv32pYRh/maHpzHTg22?=
 =?us-ascii?Q?yUtaJ3/8QIlvW8sUM9A0XOz819DXgbdBeWDDWJfcIY4jApbMx8yJjTueq2d5?=
 =?us-ascii?Q?hhJqpvSldceU7IxrsIoDb+APiOuy2zbd9DxN8iwhFyu9v3dvhCBs5QCEkLOh?=
 =?us-ascii?Q?GRwNNJmg7jVZhD19YViddT4RNiFM+gOWNRjAL5Z21jj1zOJAEg+lY3+g37Vz?=
 =?us-ascii?Q?fXfS2XaZFCXt2/gRHZKDSVOXaCOWHiPKVN7Z9AH4ca2eWaPVk6l20DdyGZ1W?=
 =?us-ascii?Q?G90/ioVdSz4SbCGsig/fIVoNyMt2OsBEbtAcFAhY4fBeOrCzQjcDcqJLEKu1?=
 =?us-ascii?Q?4neprSxvYMunIzZkwk8MtCWEzSf7PLODKmYzrCmosedVA65UcTF+881fIR1g?=
 =?us-ascii?Q?aOWr2vYpdXsGFqMYgdU8HU8JzBk1rpEL7Cq2y/a4rHtd8+BdyZc8Q1Fq4JL5?=
 =?us-ascii?Q?LrmAMkIYdkBjARnarfJLt7Ud5t1+7ve1dbHUcT/KkxG08MG/BsfbhVBxMSUg?=
 =?us-ascii?Q?2JvhACN99OcmZcKN+OKSpja0oHa7IALd0ixk8bVLAJgNzSGf5ufQQ3/TXrH3?=
 =?us-ascii?Q?ooc/dpn5QCgr+FzZU/LxXNPHd5AJrsWrig75Mg/JBIMwua53kac1mTyOFoMi?=
 =?us-ascii?Q?n/B7jigkLE6fcl3JDUhVnz4GgNANYXKU8VrKYuMiiZn0PoMHEYKSm9mVte7A?=
 =?us-ascii?Q?2FIPFGygcSqUnCQU2Uvs7jJT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5E4C403DC49FD4F965820F78A95F320@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b0a0dc-47f3-474a-853a-08d9171ebf0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 21:25:06.8628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6215RnImkR6ZTpR2eXeDTtQBuq0jt7iSZOroAtU2Ub9O/W3M0gUHaQT7Oh6rWuA95vBo87YUpMx8tI8Jx/I3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1839
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140169
X-Proofpoint-GUID: jXuNcamTS4pT9D6_8d2YX20LZresLWlQ
X-Proofpoint-ORIG-GUID: jXuNcamTS4pT9D6_8d2YX20LZresLWlQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [210514 07:55]:
> On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
> > +static inline void mas_set_range(struct ma_state *mas, unsigned long s=
tart,
> > +		unsigned long last)
> > +{
> > +	       mas->index =3D start;
> > +	       mas->last =3D last;
> > +	       mas->node =3D MAS_START;
> > +}
>=20
> Your indenting went wobbly :-)
>=20
> Also, I personally prefer this style:
>=20
> static inline void
> mas_set_range(struct ma_state *mas, unsigned long start, unsigned long la=
st)
> {
> 	mas->index =3D start;
> 	mas->last =3D last;
> 	mas->node =3D MAS_START;
> }
>=20
> And I'm a big proponent of at the very least keeping line-breaks aligned
> to '(', like:
>=20
> static inline void mas_set_range(struct ma_state *mas, unsigned long star=
t,
> 				 unsigned long last)
> {
> 	mas->index =3D start;
> 	mas->last =3D last;
> 	mas->node =3D MAS_START;
> }
>=20
> Which you can get vim to do by using: set cino=3D(0:0
>=20
>=20
>=20


Thanks, I will fix this.=
