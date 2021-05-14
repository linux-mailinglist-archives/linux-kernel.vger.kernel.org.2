Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1883A3811F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhENUsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:48:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45726 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhENUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:48:07 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EKgPm0011168;
        Fri, 14 May 2021 20:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=59MGyL37zxRn4SRPzs0MzTXyJcO2SDDOmGS3uMJkors=;
 b=QokMLVtR+xcvHGsndZ/fficxSmj69k8c/r2YHjtG0UloVzzXMPGH6UDfnVejvjggvi8r
 cInEqFMnItpoxLxGqVCYxZRqavYHf9u3t+ALavBUsJm6bx4ccgl3CDkBRCF8X2CMN/0M
 4MgQ+VQPgTEMBTETYcwxgp17f3/Hj3mVMwVYzI3VQjzc85U27xhm1fURg0oZ6n2foWtt
 M7K1iWPX6h57wNeGu12/VpqaffV79Uu4UEaxU5WrdMvpANxELXaxvpSp4Ppgd2EFsQ74
 EuwJxQQ38FIgBwQWn5FlECFZ2Eo2KazY/jSn5eQuo2NvALfGKk9bg0BD9PvdcC/vVfao 3g== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gppfrubn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:46:40 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14EKkdjo169449;
        Fri, 14 May 2021 20:46:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3020.oracle.com with ESMTP id 38gpphhsbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtgbB/r3YW3i0dt6+STbBqiT7y3FvABytDlU4sszdZugveRi6IUCfA7FTQTsTvEJiZlZYW2oLz1GcylpUBIYt2e5uFoH1w6JcwzkPuPPVmPbCdNz8ftFPQup7XpKNcL6Wb3rT6DvNeJNsMKUWbtpLoJLyN5j1aJJJsMFN8DurSYr7rMo1CdNwDbTsLcDUkZht4wbMQhNGNx4av06byK/jwpYZUEy3wCJQRPOCHb2TxaybJpIfh0y/aY/lV6KQ65kkVTMcdWFoOJXu6l8orUSXI8Sfff8oeGFCj0Jv7oIa2ZabNCLvA5qsVPYPpTqCcTeqPSdIzTtgKCJW5On7m+dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59MGyL37zxRn4SRPzs0MzTXyJcO2SDDOmGS3uMJkors=;
 b=NehZ90UFgEtHnHr+vLlJW4DKm7zxE1m2jTMUZx8NmwUdHr3TGxIDreMOtA0XLLqHI2jO74ZuaVaT9DvoSArZuNkHtJPS5s1ycNTpNljSk2JO0e2+Nn1kYdCIH3Bjs5TvqEqRglyQte4Iqp7KLtrxOcltcwslCd9klImnBB6+AvNesAFqSQJ4t1+0Me8TpTp6UAfGcOougGCTsVqgCSBSyIVyx+gU/o4yHegcplAp9wpnxtcB9WPqUGlob8o4rdvgXvX3tjrVdunvfv7HRME0hJWtadl3/DZDw9UjJndVAl9+sP8pE+qrjMNe4o1SLut8cPDzBiYCsIfiSLGxAT/DsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59MGyL37zxRn4SRPzs0MzTXyJcO2SDDOmGS3uMJkors=;
 b=VbqWJ/JX99q5xfH/AzYDUrP0/y+SllxT1rNE7mbOrpChUaPU0qNORtVolAGwkvqZF4M+/Vo7Z3M5+pNx22wKKi77j2i1iPtJgUll2HFjUgTnUfylr538B/QyXfRRC1tw/NGplGNarBm/vx5TFL9ahOYL8XFH+tnfwIpT/Uo9nyQ=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1678.namprd10.prod.outlook.com (2603:10b6:301:11::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 20:46:34 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 20:46:34 +0000
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
Thread-Index: AQHXPEQyRs1g/Qku7UiibZzqyyuzcari7bQAgACeM4A=
Date:   Fri, 14 May 2021 20:46:34 +0000
Message-ID: <20210514204631.3zpaxba6mnf75eqi@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
 <YJ5c8vcvLyWRhs2d@hirez.programming.kicks-ass.net>
In-Reply-To: <YJ5c8vcvLyWRhs2d@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b399cdfb-31b5-4881-3641-08d917195c85
x-ms-traffictypediagnostic: MWHPR10MB1678:
x-microsoft-antispam-prvs: <MWHPR10MB16788294E1132CFD42F9F4DBFD509@MWHPR10MB1678.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /szDIS2L0xs7dubektxVfjVvjDlaSvEKaRW+qGtC9oB0UJbwjmQKAmW3Zkpk3tccxG4NSYaV/h8R6igw3XhB7uqa1G/ERAsDot6qCVrQd5L1QUpR33d9u6r4/IaoxRuCF2BpaIWD9pz3MgfCoAkmIfwq+Lk2MOupbqjpFLMXnEwRFjXNcyom3XRzokFrmyehqyy809A9pgC52lmSvUD6yhUJo7YCKlW2qqNmmL1Toi5IWU7+jfJpBcm2OZatmiHgdaty8DHu46oDiXwMqrlhb7odvMpw7MsTNrIaqzKbXNt5GxLYG8IfH+O922/58YaSfVM+7Insu/hor9bC2lcQK3J5esZ/nWbCSIc/0q7iqQdHCKxbH9QCa1Ebrm9L/eW/NiJ02YSwW6euiJ3HVrI6i7P/YSXMw18j38Pldvtn5L8PeNUhSirSSGG+rfMHQx74DcbC0gWXPxQjK4HwGwFDV4dp4rU1DLlDz74U/wLQmhYGu3TAQkI7PAM5YOP35MwLGPrGnUXGcISdHy5G46QQ71cLMBnXCCdV2dG+AjdSqy7+t+mTHNMNnEYhdQSR4VvtjWWSUIPMUwcPtGEM5RYDmFv5UiA+B9e3yXWTd3Wq0Qg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(396003)(346002)(136003)(366004)(39860400002)(2906002)(186003)(6506007)(33716001)(44832011)(76116006)(54906003)(71200400001)(6916009)(86362001)(8936002)(7416002)(83380400001)(316002)(66446008)(66556008)(91956017)(38100700002)(6512007)(9686003)(122000001)(478600001)(64756008)(4326008)(66476007)(8676002)(6486002)(5660300002)(66946007)(1076003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YomUrsrH9pPdIY2k+8RjMnZa6fggugEwvRW9KT7dLyNrth5QHChMh7i1C5On?=
 =?us-ascii?Q?A3gYyFccAJeQCiwpN+IbZPmKoUqVm4/u6eVlG0LmbXV7uLIXH+L7lS5hQ9C6?=
 =?us-ascii?Q?7riWcjYuYgiqOWxqhPFMkX/ueIIsQT51sjDCwxoA2v2YbSog/SOslt0tqSww?=
 =?us-ascii?Q?MtWAjUTWuSC6oKEChYcLfnsf8EJgSj/MB78t84t+mcSfg2dCUYJN2zXNCFe9?=
 =?us-ascii?Q?Xwxij+pcz3/f75vKlXtyTTDTgJclpL2VpFW16YCkRDpomSEaExyhmSTKTt++?=
 =?us-ascii?Q?SsxvgyOOYvKlyhBm6BjpZ2iyjAskX0bqszQoh9Fg0cm9ZIKSGNyTMwsXFXkP?=
 =?us-ascii?Q?VIl71thv8fT8VH5xFrvLl1eiuUZtqJlzqZfQh/Yvy5w5yblCXWIlnrSrp2iv?=
 =?us-ascii?Q?wgcIclW9bzY9y2U48Y3GiwPyOHjKW4FrasybJsA3/GmNKeV55avjgb6ZRCQx?=
 =?us-ascii?Q?u+QYxq0ZDdtFuWMe6YDz8KfIA2LnAaqg7acrSpoSoUy2spIjcWx/EoKh4L2e?=
 =?us-ascii?Q?Cug5wlJYhozwCBtEoEBbiefu6GVcKHtV213B62fmHVu742LHk8wpSg5lVBkp?=
 =?us-ascii?Q?fwnNFYGLoKljMaQUy0Uy6c274vGeTlNrA0vjqlJcUSrHHHIBN8bRj9Ekh100?=
 =?us-ascii?Q?Q5dU40q7xz6bE9gkRJs1Dd1W+hdQrrmwarAXD0eOKNQqB6RV1PVWsYvOFBhl?=
 =?us-ascii?Q?yxOKWqkSWy8lZ0iGXJLP1Pl3HBcaVZb89g7O9eNRDFTPIRoBt4LWfhbqrW17?=
 =?us-ascii?Q?1YOBuASjWOlejwpqYG4UhE41JM+xtQCXXaHmuYYzCOlV4t75I+KJM3Okaaia?=
 =?us-ascii?Q?TNOCCH1kMj5Yem5pGi62teSCe9dGPLZBwN1pnELcdk5EIFGkSlRGk4rLaPhP?=
 =?us-ascii?Q?vHJeTUO1v2zemhRkzzCxD4UoK2ctF4WpDsFDFXm8SuBsqObknjUZ/CQm3b3M?=
 =?us-ascii?Q?yGtxC1z+jBgYoyWAaqnbSW/hNjNKh5nTDOKe8tZCvjmB8qwpfJ61+Ozu1Ajk?=
 =?us-ascii?Q?MZp6C2uh2miTjz9YizN6hDMpZQqOjKxXYzfCH0OwrEXJatUXaroQN3JycoyN?=
 =?us-ascii?Q?Kf3Jc6KD1l+x+bslMG2y8845QGbSYyfkugBJVavLZeWmHbkKlkSAlLGr8dDa?=
 =?us-ascii?Q?lRSoBrPIlpng5ZmkQ0FbQ0aH7OaneYIvekCrPFFAblpS2I0sAY7cEWvsgqlS?=
 =?us-ascii?Q?ZENVoe6Ay9SDk/Er37l/15wLUjokX6k+e/WobI+2+BuP+j81vKoiQHX//OFE?=
 =?us-ascii?Q?fe1bm+QsCrgYrYybM1eqhwGA9y+tj4e6vgUX4YW7W6vflbBeSWGFpMC1VBfg?=
 =?us-ascii?Q?A8o/3nByITfvGw2Fsm+PBjGo?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7A9D379EE961F448C12767AB3FFB1DB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b399cdfb-31b5-4881-3641-08d917195c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 20:46:34.2271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +SPlYH8oAgKteNMtK8dJts6hsv4tD1gV8gLdEjmWGFN9cIkq+mLsWZDcGkjR0p+xZ0VqdlE/N4hMbXDy7nC3wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1678
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=966 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140165
X-Proofpoint-GUID: FEQI2pYrDygea6poe33WeKw8-WGVP_tI
X-Proofpoint-ORIG-GUID: FEQI2pYrDygea6poe33WeKw8-WGVP_tI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [210514 07:21]:
>=20
> On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
> > +/* ma_free_rcu() - Use rcu callback to free a maple node
> > + * @node: The node to free
> > + *
> > + * The maple tree uses the parent pointer to indicate this node is no =
longer in
> > + * use and will be freed.
> > + */
>=20
> If this was supposed to be a kernel doc, then it would need to start
> with /**, if it was not then it's an inconsistent comment style; by far
> the majority of comments in this file have the regular:
>=20
>  /*
>   * multiline-
>   *   comment
>   */
>=20
> style.
>=20
> Like
>=20
> > +/*
> > + * We also reserve values with the bottom two bits set to '10' which a=
re
> > + * below 4096
> > + */
>=20
> > +/*
> > + * mte_to_mat() - Convert a maple encoded node to a maple topiary node=
.
> > + * @entry: The maple encoded node
> > + *
> > + * Return: a maple topiary pointer
> > + */
>=20
> And:
>=20
> > +/*
> > + * mas_mn() - Get the maple state node.
> > + * @mas: The maple state
> > + *
> > + * Return: the maple node (not encoded - bare pointer).
> > + */
>=20
> But then you also have:
>=20
> > +	// Removing the pivot overflow optimizes the loop below.
> > +	// Check the first implied pivot.
>=20
> > +	// Check end implied pivot which can only be a gap on the right most
> > +	// node.
>=20
> And:
>=20
> > +		/* If the split is less than the max slot && the right side will
> > +		 * still be sufficient, then increment the split on NULL.
> > +		 */
>=20
> > +		/* Avoid having a range less than the slot count unless it
> > +		 * causes one node to be deficient.
> > +		 * NOTE: mt_min_slots is 1 based, b_end and split are zero.
> > +		 */
>=20
>=20
> Single line comments are also an inconsistent mess:
>=20
> > +	/* Avoid ending a node on a NULL entry */
>=20
> > +	// Possible underflow of piv will wrap back to 0 before use.
>=20
> > +	// Copy start data up to insert.
>=20
> Even in a single function, you can't be consistent:
>=20
> > +static inline void mast_topiary(struct maple_subtree_state *mast)
> > +{
> > +	unsigned char l_off, r_off, offset;
> > +	unsigned long l_index,  range_min, range_max;
> > +	struct maple_enode *child;
> > +	void __rcu **slots;
> > +	enum maple_type mt;
> > +
> > +	// The left node is consumed, so add to the free list.
> > +	l_index =3D mast->orig_l->index;
> > +	mast->orig_l->index =3D mast->orig_l->last;
> > +	mt =3D mte_node_type(mast->orig_l->node);
> > +	mas_node_walk(mast->orig_l, mt, &range_min, &range_max);
> > +	mast->orig_l->index =3D l_index;
> > +	l_off =3D mast->orig_l->offset;
> > +	r_off =3D mast->orig_r->offset;
> > +	if (mast->orig_l->node =3D=3D mast->orig_r->node) {
> > +		slots =3D ma_slots(mte_to_node(mast->orig_l->node), mt);
> > +		for (offset =3D l_off + 1; offset < r_off; offset++)
> > +			mat_add(mast->destroy, mas_slot_locked(mast->orig_l,
> > +							slots, offset));
> > +
> > +		return;
> > +	}
> > +	/* mast->orig_r is different and consumed. */
> > +	if (mte_is_leaf(mast->orig_r->node))
> > +		return;
> > +
> > +	/* Now destroy l_off + 1 -> end and 0 -> r_off - 1 */
> > +	offset =3D l_off + 1;
> > +	slots =3D ma_slots(mte_to_node(mast->orig_l->node), mt);
> > +	while (offset < mt_slots[mt]) {
> > +		child =3D mas_slot_locked(mast->orig_l, slots, offset++);
> > +		if (!child)
> > +			break;
> > +
> > +		mat_add(mast->destroy, child);
> > +	}
> > +
> > +	slots =3D ma_slots(mte_to_node(mast->orig_r->node),
> > +			     mte_node_type(mast->orig_r->node));
> > +	for (offset =3D 0; offset < r_off; offset++)
> > +		mat_add(mast->destroy,
> > +				mas_slot_locked(mast->orig_l, slots, offset));
> > +}
>=20
> This mixing of C and C++ style comments is a mess.
>=20


You are correct, this is a mess..  I will re-examine all comments and
convert to C style and ensure a blank line start.=
