Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAAA3FC9F2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhHaOlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:41:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9596 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232214AbhHaOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:41:37 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VDETQd013065;
        Tue, 31 Aug 2021 14:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PihoORGtlQLwnsLRmrIyPiHIdBeBaEsfUPS0CtG5C28=;
 b=Snh8+Hb5qbkr3GW52NsuI6Yq/Resik50j052viIvP1ZNLeugRwoX3V0/X08NGTlZRJ16
 hQdu7LSlD5vc+HHeYgHM01aaYVIKLl3q6CeBgHp0aUi3a+DrAjzeXd/m0WlU9jfF5JeZ
 Dx/PsGZcR3qVPUtBjnGBAAd/YX5AXbwBOaoBfnjcdYSXgVPOwB39f5QrbV1edJhHPVDf
 j9lLpwlgIfPNt6eBKngG/K65ga5LilRTVgZDo4c3E1dZ0achP6eFhrPnFIdNmRzSoOCg
 TQk3XT/PrT+iYPiDdk0Wo5x0deFpy4jG4ieiGrRJpKMk7sX6Gia9ZR7Hww6qSE86+qi2 ww== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PihoORGtlQLwnsLRmrIyPiHIdBeBaEsfUPS0CtG5C28=;
 b=myazFjA8aqRioi5l2Ok3p1dINFyGp29itv4Q+QmCBoBUYT5xaCEo7Y7fZDO9m09upkC2
 44IMt2vqQpFREpDtfEP/pyeYE5tpHi5B/4kwkO7V2LYa4RsLyhAieR61uyDJlwQGCJlh
 Cym8puAhHCF+AHo7z6VgCSE5yJqCjRXNyrV+PLTQyWd3WpUnEKb1P5k5DfZuiZzVvGjD
 C2elrJDxYMjLYjrZ1tOtm2Faz+vDo6KddqgElJmwRBhocYQDZDqmZYqglyxuYCNWgAgF
 9n6KCec084iorFmteluSGac8ARg1FJKumJ8CIRIDsMr7eyuV+6MHMhfgrU+DQfHf+Q69 eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ase029bkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 14:40:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VELdP5025285;
        Tue, 31 Aug 2021 14:40:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3aqcy4ujgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 14:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epurdjPKVRv/vLv6SV5jygkDtcDYdEGk3/xOQtX1xa7Tx90pFxAD5mwVz2sRNYQJTd7J7Qn1yZ7g7fNpp2sf5qFYVgor/VGq+k/b/dQTmvM0RSnym3ySF5R3gjrIZC7kaDaDeQIlX7Mgjr7c6ppPz5BMsJTB3wYWoZ0fxB+O5Vug1VllU4ryBPrbN0ZeEJyx6fjUOFSO6wGeA5grDKH9umaFQeC9lCLDYHzByJ/avv2NbeQjjQCeCMTkbKqVN6G/3Ild8HDQelJ4ce/zHPPOncPLrKMfqrNzw01S1hm6O8/equZIPPK72KStrLokhXOyaUkIc0BokR8/Z88hn4p3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PihoORGtlQLwnsLRmrIyPiHIdBeBaEsfUPS0CtG5C28=;
 b=fCMXurq713GRMDE4M+SvJfULO2Je+1xkhd2mE0FMt4M+WV062YkN9JaVeAvSLEAF4vR5UdtWICvMZc0iS0O2K3VU8Zh04s/j5auMSZ64b05D0ixVyR45PtlEetntkNDGqhRw6vR3OmHDyNW7GIJUjEeXNuRCo4rB7CjN55CyS/JtuNDKzv2YLbYj+yZE2HDvD6M7lt9aExM8M8c6HjlG7cYmH3E4BE6bBZUzngvYnni/pPPPiR3U68M47Wl164cYbVIE1gS9zhj5gBdlqrPbaNIErRbzWj7sSBd+AJ5qBFvIf5LFlyeRoAhNJE3wTNhq+pm2jfYT7zoArRluXdec0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PihoORGtlQLwnsLRmrIyPiHIdBeBaEsfUPS0CtG5C28=;
 b=h+XK8jpMQtMSSGfgpmtmcia0wfINGxrFADAVyffqsiM5mtV/rBgWZYZS3EUvp6PeqHiwUdsv2zqgTt1XXX+nyDp0V2Z8biITg6WjeW0HlhhGowCqnvnlJP5jt/MnRniAZqyaEPnJL7nt3hx3tE3Pxe4CMaANW6b6TkI9wE86aRk=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB2940.namprd10.prod.outlook.com (2603:10b6:5:65::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 14:40:04 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3%4]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 14:40:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     David Hildenbrand <david@redhat.com>
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
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH v2 11/61] mm: Remove rb tree.
Thread-Topic: [PATCH v2 11/61] mm: Remove rb tree.
Thread-Index: AQHXk38kuOi0fuhFmk2xO62p7QuQn6uA4U4AgAzjzYA=
Date:   Tue, 31 Aug 2021 14:40:03 +0000
Message-ID: <20210831143949.wr2aizw5qmpc4fsh@revolver>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
 <20210817154651.1570984-12-Liam.Howlett@oracle.com>
 <3104a9d0-b8b3-46ed-4f10-1c1f0e5eff92@redhat.com>
In-Reply-To: <3104a9d0-b8b3-46ed-4f10-1c1f0e5eff92@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60910ac5-fc44-4e7b-5291-08d96c8d386d
x-ms-traffictypediagnostic: DM6PR10MB2940:
x-microsoft-antispam-prvs: <DM6PR10MB2940B50C1D19CF74635ACC67FDCC9@DM6PR10MB2940.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVrUNPoGTtKpP3pzqJbMkP8K3IHZ+vTiqylW0+iFhDdASHVu3KaMm4Uz7QMqDrxRDH+k0wyEyTX27IOQ3r7qUWXi61F7fMPGJgIJb7s6nE+l9H9WPeiKaB3Uss3gUb/OORaniRcdg8PBp8SqdZXToJt/n0fMxc3Uoqw/OjNE6xkpoyfA9RLGaTrPdldGzog2nrZC0Y/XbGl9yQDSAF8j9B5Ps9wRMMjYGw44uI0tAauC3JC5nYyiUMcd3u5xXCuLGIHs84TAV84zcH2UOnLCe+PVPlFNyXxoUopZqIlbwToajIyN2fosk4OPGZdZgfa8nE4R0xHDfiN98wCEhBKbwe2iBH83gcvMY3jh35Jm5ZUR63xe5LE2Hur/UvhZWtHrSvT10WlYZSJvLRkViRPE9Z1X6+9d4Rv70GFaW/FOCAQuxXu6cFoSiDzsLTLrAxx1T1MDwEnQ5N2g7CDt2Ad5f4HXzM2sz3245+zsK8uiuBaYd6VQPbHWOTbd6AEFBTUd/psbgh1EfFH+4HpMNUhTfqFJ4sGduUT/h0016+KCHHr3dLx+SEylapvGZZ4x2qYCuGA/mB6KsJZYWUg2w+gAqu4777UmOoB026yUYISv84ru2xivUaKZdxqHS8n7Rr2QpynUTHmUOv87ZEh46OGe2qtHm8uSp1ytCRjQpTTzet+tw25zKmttZsN3GcL5deUCJHtJ6amTNPAvfObilxring==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(346002)(366004)(39860400002)(376002)(396003)(136003)(8936002)(2906002)(54906003)(38100700002)(8676002)(122000001)(478600001)(44832011)(6486002)(1076003)(4326008)(33716001)(26005)(53546011)(91956017)(7416002)(66476007)(38070700005)(66446008)(64756008)(6506007)(316002)(66946007)(86362001)(186003)(9686003)(6512007)(76116006)(83380400001)(66556008)(71200400001)(5660300002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1o7e7PHtKYmbhjA6ji7x15Y/BtDr5ku9gx7nY2Fb75YQov8UfCt1bL3BHf1X?=
 =?us-ascii?Q?n6hrhJ1ldGWCUdtz1VUwOpd8x44F63Std9S5N4qb0EcCcO7js4OBPOHhSGqC?=
 =?us-ascii?Q?/eF37ttiZ836wUb8NCq5qp6FHHKxAofWt3yOt3xC6sYXbUaTuRcyMPgNpm1r?=
 =?us-ascii?Q?qv4JnQJ9xQflEwOV51B1L5bJQn1HXTPir7+E3iwW7zveLJFrYIbXAqphzIk/?=
 =?us-ascii?Q?Zm/4tt+9509B4cwhXB4rUAW8zEUuLUJTWDaUwW+SiQDOXpCviErGfWMHOJVr?=
 =?us-ascii?Q?Z/0MMz8Aoq1IR2qHxP7RHzAlS8yG7AX61Jk0alZ6clu8mzAxBBx73/QYxKMa?=
 =?us-ascii?Q?7QkP+hd0tnkwWu1FdUhET2z1nG/13W2/X0zc3eWje0CT8xJj5pDk0S34gQqd?=
 =?us-ascii?Q?aDEMoNSJyzzZdrgixUN1/KqF+UZIy4yv6lUpaJLXZ+SlWLgBXYKZnvOx1HNi?=
 =?us-ascii?Q?Q4iXzdjDtmVfmSmeRZJ80cx+z05iMELyHpC7AFZ9s8OJg+T4CnY8EZ0eKArA?=
 =?us-ascii?Q?MdGDIn1JyBH027t+OyUZrcI1gzEsTgGixKcRgTTPBmmG0Wfn9q98Sd5JZL0+?=
 =?us-ascii?Q?2Ifn7Q6l+TtcFF3oQ8yLcQlgU66TiUoY56nmj9kmr8jHuUDHh1FzB/z2j/x0?=
 =?us-ascii?Q?nlixBUE5VFpeWwHSiPYNFR59ZJBOFShumYUctExTsvVqfrxSGJxBq4cSoAZ1?=
 =?us-ascii?Q?Gd47u1lcIAFDVp7YEIXFWNKfS/fzFd6r4Whz+2zj5daNZjfGw+3LxbBdedNt?=
 =?us-ascii?Q?najOwh+l9G3KhW/LDulX4sbQOyr3SvR68XJIDZV2sg4BdrRyTqgSSQcYkYZF?=
 =?us-ascii?Q?EfLfKTxHUQOIiyNPa/xgQZcTIvvsMTGUA2kMjVk41uB8B11euf95Z05gL607?=
 =?us-ascii?Q?fEddzji0Ne15tMTqDck9poCDGrTNWM36gVdo9DU0AJX7xUGICubM3/Xi/NhV?=
 =?us-ascii?Q?T+zBRtwXRbAl0eQVL5OoCslrEpQrSNOuIkauBDs6/s0pT4VNmCGSaP6M8TQK?=
 =?us-ascii?Q?fP+AD/bRnRw0d1Y3RYl5npIZ710QIfaTPjyhmX6NxCqwl9gGCneVWnD13ker?=
 =?us-ascii?Q?pgVkHCyIOnli5zFMX3urKpHnBMjFSfogklaaqyqzA+rMdSNB+GzQYX9nf2lV?=
 =?us-ascii?Q?l1tbWt5ZW5/6LodtBmLIcbG5ur/W9F21QCYYjKFey36pxdhZ4inQ6BW7X4K7?=
 =?us-ascii?Q?IL5eZwFFooZCLz3wD2vZp6aVh3yVwaRPo4cBs8EAGtbg94/U8AWrazV4BIVd?=
 =?us-ascii?Q?8yD698bXzGN6XwHY8TYn2Z3taFGNHVWMrmxx+ZQEWzTDqezrs6uAdOphhQRE?=
 =?us-ascii?Q?IoQozx5WaR2SA+WIvBrgu+My?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04982743AA186B47B1366DE1CEC85A1D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60910ac5-fc44-4e7b-5291-08d96c8d386d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 14:40:04.1168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+0Vl2aN15AScVuT5I1EI5YKDbRagL5xVXCb48v29LKzbr7xPFeaH3zA1gQUp5r/1K6SSslWPGgHQuJC9nDXkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2940
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310079
X-Proofpoint-GUID: 3W5JxWf3Pd3rxXaqYMMGUpkqMSJSmMDH
X-Proofpoint-ORIG-GUID: 3W5JxWf3Pd3rxXaqYMMGUpkqMSJSmMDH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Hildenbrand <david@redhat.com> [210823 05:49]:
> On 17.08.21 17:47, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Remove the RB tree and start using the maple tree for vm_area_struct
> > tracking.
> >=20
> > Drop validate_mm() calls in expand_upwards() and expand_downwards() as
> > the lock is not held.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
>=20
> [...]
>=20
>=20
> Why are we reshuffling the code below? This either needs a good
> justification or should just be dropped as it introduces noise. Maybe I a=
m
> missing something important.
>=20
> >   	/*
> > @@ -427,6 +414,11 @@ struct vm_area_struct {
> >   	pgprot_t vm_page_prot;
> >   	unsigned long vm_flags;		/* Flags, see mm.h. */
> > +	/* Information about our backing store: */
> > +	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
> > +					 * units
> > +					 */
> > +	struct file *vm_file;		/* File we map to (can be NULL). */
> >   	/*
> >   	 * For areas with an address space and backing store,
> >   	 * linkage into the address_space->i_mmap interval tree.
> > @@ -449,12 +441,9 @@ struct vm_area_struct {
> >   	/* Function pointers to deal with this struct. */
> >   	const struct vm_operations_struct *vm_ops;
> > -	/* Information about our backing store: */
> > -	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
> > -					   units */
> > -	struct file * vm_file;		/* File we map to (can be NULL). */
> >   	void * vm_private_data;		/* was vm_pte (shared mem) */
> > +

Thank you, I will drop this from the next revision.

>=20
> Another unrelated change (there seem to some more in this patch)

I'll have a look though it again.

Thanks,
Liam=
