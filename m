Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBE13F3269
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhHTRrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:47:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15566 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229940AbhHTRq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:46:58 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KHg9Dj023998;
        Fri, 20 Aug 2021 17:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mPg+J6YWOWo1dgTuGcA+lT+ikiI2OIlMAUOhaC5V3FM=;
 b=K0SQ2uwRIizKL+A2QKVzvWKw8sb3p0Tp4Mn8+FBjwK3fRV5ClIzZYQGdjbZCKqSIiVoo
 ItFi8WsP/rNHnUHClSyt2IeBI3UWuastdriOdA4ilQeestIjs9TOMD7P79dVGKKarOvf
 JtbnSZ36b4d+YnzywqA0sQ6kwW6snDvlOb9TPhF8tvyvof6JxLn8T36V+pimOEPmIjCg
 ThoBi8cr3TatCXhf+Y4Lp3Aw69wJP8cpZkplBF0jiYsZFWgfJx5vFNDcBiDL2GeCkpE2
 1Q4FbgEd7lF1GesI0vtDKvLGX+OB04N0RsAeWqJ4fd1nDxrZS1eyQz88j6kHS5TtOCdR AQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mPg+J6YWOWo1dgTuGcA+lT+ikiI2OIlMAUOhaC5V3FM=;
 b=O6ehJu3H22p7I8dGAio5ljzXHubUFhYARtF3+wKrWvAja1BGDL5dSzm/dR1dcuUP1wyu
 AFz7yA0hjKZ0zlQSKuMw1zXj0guuxHsD8jtDYpgP6uj5XpQMLz8UF4CnL1sUN33Cus30
 WESnhx1efza3SGuCb7xX8Otzh4HYCp3nN1hoZKE5Usg6TMxIga5TCzRRgzYfnFkRu1ot
 dJDnvEB1km3/SVZTWkxZAvk+QxbQiSxij0Y+vJHysBJD0L7MvxZZgGrnTN2TTUTtcCS2
 xmGzdl1McRfeC6oyd5q7zhF5GdQLZC6s3UPl+XvdxTnjrt2W1h7otMn0ZBQEhByf/KFm 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ajeaq0dnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 17:46:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17KHf6xC136020;
        Fri, 20 Aug 2021 17:45:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by aserp3030.oracle.com with ESMTP id 3ae3vny3sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 17:45:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWf/xiXnrv2BlbQPG/wPmkrLiwrml7xWOmQI98y2HJCEDmEtr/sHwS0A3taNt/JnnVNPC47MoPbBcom/aT32PULgPwDp1S5+mYoRL0ZMVx4Fq9z7hGMkQkkfAjtwd+rBUvDMtzT0CwncjP3mgkG5YmiNBwpZVPnQvaeoLYTuuvPgWGGcX6vhMzDUzj0CmtlBFsVcX5CosTmkfi92amiFzWgASRm3AlVvd51Hsm1yk67hDThty00/VMJLCX5nTMD6uBCIfm0MN8dkt8UFad7rpG12entjAkPvG0tEkKYFDiaNAHwJzH0okSK9wV/SLmrMBqRbMyczIbwqQSqpwCVyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPg+J6YWOWo1dgTuGcA+lT+ikiI2OIlMAUOhaC5V3FM=;
 b=bfscbwwWr4aGv/bMlMQkA4I7juzLbSlOdCafS16d2VUOzliN1onaf1cjQS20k1pkoV+hTpF47jZj1s4t0NFIqJu+Bvou6h7hA6QqdEsTkIBGkYPt+kimgFqN0+hhRPMYqr/jBt4+iVbwHCxSmtnqwyu3p236s5uTUBN9aVispdRLrZYEpvwPy8EBbyOWJgKbMFMj5ilGfULfvUgNtIVSpLmDk7XhX7xARSZmgW6Pk72IJr8l71tJ1ptxpEhAABEWCLtgdsx0uUNqeB+3pbOQiX30KUauixG0XG/EXJvAXT+RgSaJ2tvvam6/Rn2fxpw/UDUmCUYJ1VtEbMOJHsG+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPg+J6YWOWo1dgTuGcA+lT+ikiI2OIlMAUOhaC5V3FM=;
 b=Ie3akCPX7Jxl/ZAPkaJfjtJQrw+XEAAC4AvAR9VB5fLrVQypA7pq0FF08xIq7ww2fe+ZWdV1+DVNTsfSzVLo+GhLfXgoAfvo10cdCffNRaHG+Ft8XG+XGYlQMx0AC7E31lqTP0mlcM/pZN+tUltIA4RB4DH6CP0mvC9a2sZPQuM=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM8PR10MB5431.namprd10.prod.outlook.com (2603:10b6:8:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Fri, 20 Aug
 2021 17:45:57 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 17:45:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 10/61] kernel/fork: Use maple tree for dup_mmap()
 during forking
Thread-Topic: [PATCH v2 10/61] kernel/fork: Use maple tree for dup_mmap()
 during forking
Thread-Index: AQHXk38k0JUHaKd/aEyW/GzwRyUQFat48TIAgABpqQCAALpJgIACmkQA
Date:   Fri, 20 Aug 2021 17:45:57 +0000
Message-ID: <20210820174544.cvbdwpp6cfebos2m@revolver>
References: <20210819020105.3756-1-hdanton@sina.com>
In-Reply-To: <20210819020105.3756-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 111dd1ed-2e73-4793-f42e-08d964025da2
x-ms-traffictypediagnostic: DM8PR10MB5431:
x-microsoft-antispam-prvs: <DM8PR10MB543178DEB0FA8BDD6CDDB0E6FDC19@DM8PR10MB5431.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9TcNBkHcIvXl9mpXitzZD2pKFL5doxM5NVuYeFCHdpJP4G4CDq+kb43kDBhKoOtwVX4a6okYmWheGgvuofu4G0KuHfWkwzZgvwnbONTjYVY7oQPk0cw8xcCBCvC0dzf1yxtgNLEVbDuHdxTbUyBaFBCZK8t6VohX8TeYwtjBs9Ne+4O7/coXU78144CiIgzgv6eNfsonaxrXSCs/icD/UwkCti0TMVx2ZwMMkgN+KlLHmdHAs+RaKhUNlbaK1PNxpNL5XRtHRRJbELZLIhGTEHD8TEIYUJXCzURtZG8FammTR5xCZeQFwyA0WYo/ymH/B9sF99HCEVy2VEmfh8OGBB8y1Oc9D7tFnLW2OaNJXwQPu6jOBPe/WR9y/87/D4gTs1cJYDBCz8V9fUmt6Rc1sHu7NZZWkooJR8TNiaLTDrlZM5p7C0OIRr4tQU9e5k0swfg3VUe3yX8hkwz+h85znsDVAmAK+9ZIgA5ScJzPRFHpiWYoFVJ9MRhkLVS+rMkl7pPdhqZF624dwIw8SPmZtO6oICW9vatweMkcSNzXRMFvddxQMBIkeHnS+7riaAZ1CB+Jd2KQpVLNeUF84tMTYJuB0klKMW9jHToRvoXtWVGH6QkTC+oRFlg8Ol3sxnr9jADzou9IICC7+LVo1D3aUWIKi00eZK0vkzw6i7o8hr4yw7/S9sAPEV/M/aNdNBUMeljTGE4ve0kIfEcMDZ1ehg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6512007)(71200400001)(9686003)(6486002)(76116006)(91956017)(66946007)(508600001)(64756008)(66476007)(66446008)(66556008)(54906003)(316002)(38070700005)(38100700002)(122000001)(6916009)(4326008)(44832011)(5660300002)(1076003)(8936002)(8676002)(83380400001)(26005)(6506007)(33716001)(186003)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q3u0juklflJ2Z2r5c+3o5Zy8HVJ17xsi+8fcOF9A06p6pcTQUCH0zYxYVM7W?=
 =?us-ascii?Q?cgim3o54gY4rD6qK6sD9cOsT/0blcoF00RDptXgcFEW3RsFLpamGPBZ7qTaZ?=
 =?us-ascii?Q?KErzLK9xyygxaUzShheBZIxSVJFpaNo2q72TwScMK7VByGSxQxBKP9fKKN5z?=
 =?us-ascii?Q?0f51K2AqpN6zSY2IafLx0l7R/pUyB7QwtIhrxebd2qoCOSkAQ9sSdLk8myqs?=
 =?us-ascii?Q?EHG+fNv9IXh9p01RNrC7N5yug/Imur4+Xhz3pTwJL0mdbJBlgCp+TWh+bcNq?=
 =?us-ascii?Q?KMmijNCeCDK0uvSJt5ftjLc0K81Wn1v0Nl2v6F7+5f5q8RNP47U0T+h7fDNJ?=
 =?us-ascii?Q?SBXuMQLDvoxjaYfabHVXfJNTxmgvJ3NWwD9H/e0buRFSKHgdCVBnF+OI6Rfe?=
 =?us-ascii?Q?Iib/1kFIos5X96pNiLkGsZu+HAUCe6LfeeGT1gHW4JUGAEl5c+UQu18Do3S1?=
 =?us-ascii?Q?NqbupYuP4ymIDjeeke1lJzth0gEmiJXT8VXLrmI8tQ4U63T82GZHlbjG9Zkw?=
 =?us-ascii?Q?WkqRMG5Jt2C00LWQP78bKSGVVEYKPti7/G5caVbOSb3pWo120iRKOKx5U6gg?=
 =?us-ascii?Q?Sszexg2JYXSjFjztnar7dtXuXxiCm3Ghe002fdpQpKk9PX58GSFPf3Gg1g3P?=
 =?us-ascii?Q?IGkokbe0TLYaWYRPAeSV9Z7xM9UILAdUIVqiSN6PsfC50u8FBbf8yHLt715c?=
 =?us-ascii?Q?HNypCX/8Shk2/1BKklMPom5Ol9KHa1xQcenBw3UDMDcek/jZPceF49ESddA6?=
 =?us-ascii?Q?HSnYmTsxsH3gwvVY7JYYjBpUcepLrA0Se+kJpAhk5hP8iDUQ90fjt1bC0xE6?=
 =?us-ascii?Q?ertVe7+EsbuKnG2G9HzqLlk6M8asVgTklUxqpb5T7/HBjuVO+34nzpde8oEA?=
 =?us-ascii?Q?4XzzXbpo5py6t77kZTiu4Jx05lUclT+mnV+gX8tB1EsuINdVUAB8W0i4htko?=
 =?us-ascii?Q?lVVy59l9WoeWrDpf5Y0rZAhunnGCLGd0YFRa0osBtDsQCNAVLpC26GkIWRP3?=
 =?us-ascii?Q?pJiapan5bAZHn+318KOznsfoYgT5MfmDQxj4owYTrngMqum/AO3TexYQ1cnV?=
 =?us-ascii?Q?c/Ur/cLHyFdCWet7M1pKKsAFJdl9B2H1Cgv/KY971xomqvqfDf0+E87XRGzt?=
 =?us-ascii?Q?MyHQ04EUuZ1xpXVV8MEznotSB41tMzfCWu8kay6wklVSGMZrxjAzh1501Ylf?=
 =?us-ascii?Q?c9lqEJ7eZWjE3Hh/GvX/erREtYCxvz5E4PP1sgVUTsTY229PecRAWsathBNE?=
 =?us-ascii?Q?T7LkxAQ/I38WGdjhtYIzAth2fAe5qF3DkO5hSYWndFyASOMXgriRK/51OWVR?=
 =?us-ascii?Q?2vXF9ETtuuvgo+Zbl+LLnURk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F715EDF595DF4B4B843366D81C373369@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111dd1ed-2e73-4793-f42e-08d964025da2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 17:45:57.2004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mUPiEBfo/8oMx0NkV60wpbRx/2Qy22LG8Ar78bgbfGajkOmlk1YosdEkOg/I1xpq8fK6ZbIYC0xhsUPZX/lFDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5431
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10082 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=913 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200099
X-Proofpoint-GUID: eu9HewWIt9CMJiulsAbeixELX0755zog
X-Proofpoint-ORIG-GUID: eu9HewWIt9CMJiulsAbeixELX0755zog
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hillf Danton <hdanton@sina.com> [210820 00:05]:
> On Thu, 19 Aug 2021 13:32:58 +0000 Liam R. Howlett wrote:
> >* Hillf Danton <hdanton@sina.com> [210818 22:01]:
> >> On Wed, 18 Aug 2021 14:54:29 +0000 Liam R. Howlett wrote:
> >> >* Hillf Danton <hdanton@sina.com> [210818 04:36]:
> >> >> On Tue, 17 Aug 2021 15:47:11 +0000 Liam R. Howlett wrote:
> >> >> >
> >> >> >  static inline void mmget(struct mm_struct *mm)
> >> >> >  {
> >> >> > +	mt_set_in_rcu(&mm->mm_mt);
> >> >> >  	atomic_inc(&mm->mm_users);
> >> >> >  }
> >> >> >
> >> >> >  static inline bool mmget_not_zero(struct mm_struct *mm)
> >> >> >  {
> >> >> > +	/*
> >> >> > +	 * There is a race below during task tear down that can cause t=
he =3D
> >maple
> >> >> > +	 * tree to enter rcu mode with only a single user.  If this rac=
e
> >> >> > +	 * happens, the result would be that the maple tree nodes would=
 re=3D
> >main
> >> >> > +	 * active for an extra RCU read cycle.
> >> >> > +	 */
> >> >> > +	mt_set_in_rcu(&mm->mm_mt);
> >> >> >  	return atomic_inc_not_zero(&mm->mm_users);
> >> >> >  }
> >> >>
> >> >> Nit, leave the mm with zero refcount intact.
> >> >>
> >> >>  	if (atomic_inc_not_zero(&mm->mm_users)) {
> >> >> 		mt_set_in_rcu(&mm->mm_mt);
> >> >> 		return true;
> >> >> 	}
> >> >> 	return false;
> >> >
> >> >Thanks for looking at this.
> >> >
> >> >I thought about that, but came up with the following scenario:
> >> >
> >> >thread 1	thread 2
> >> >mmget(mm)
> >> >		mmget_not_zero() enter..
> >> >		atomic_inc_not_zero(&mm->mm_users)
> >> >mmput(mm)
> >> >		mt_set_in_rcu(&mm->mm_mt);
> >> >		return true;
> >> >
> >>=3D20
> >> At first glance, given the above mmget, mmput will not hurt anyone.
> >
> >In the case above, the maple tree enters RCU mode with a single user.
> >This will have the result of nodes being freed in RCU mode which is the
> >same result as what happens as it is written, except the racing thread
> >wins (in this case).  I thought this was what you were trying to fix?
> >
> >>=3D20
> >> >
> >> >So I think the above does not remove the race, but does add instructi=
ons
> >>=3D20
> >> If the mm refcount drops to one after mmput then it is one before
> >> atomic_inc_not_zero() which only ensures the mm is stable afterwards
> >> until mmput again.
> >
> >Right.  The race we are worried about is the zero referenced mm.  If
> >mm->mm_users is safe, then mm->mm_mt is also safe.
> >
> >>=3D20
> >> >to each call to mmget_not_zero().  I thought the race of having nodes
> >> >sitting around for an rcu read cycle was worth the trade off.
> >>=3D20
> >> Is one ounce of the mm stability worth two pounds? Or three?
> >
> >I don't see a stability problem with the way it is written.
>=20
> On the maple tree side, I see in
>  [PATCH v2 05/61] Maple Tree: Add new data structure
>=20
> + * MAPLE_USE_RCU	Operate in read/copy/update mode for multi-readers
>=20
> <...>
>=20
> +/**
> + * mt_set_in_rcu() - Switch the tree to RCU safe mode.
> + */
> +static inline void mt_set_in_rcu(struct maple_tree *mt)
> +{
> +	if (mt_in_rcu(mt))
> +		return;
> +
> +	mtree_lock(mt);
> +	mt->ma_flags |=3D MAPLE_USE_RCU;
> +	mtree_unlock(mt);
> +}
>=20
> and on the mm side, however, if atomic_inc_not_zero(&mm->mm_users) fails
> then who can be the "RCU multi-readers"?

There wouldn't be one.  But the consequence is that the maple tree nodes
will remain active for one extra RCU cycle.  This is why there is a big
comment above mmget_not_zero() explaining how this race exists but will
cause no issue.

>=20
> >Your change does not remove the race.
>=20
> If atomic_inc_not_zero() fails then there is no pre-condition in any form
> for race; if it succeeds then the race window is slammed.

My example shows how we can still end up with the tree being in RCU mode
with a single thread.  atomic_inc_not_zero() succeeds, then the other
thread drops the reference counter before the maple tree enters RCU
mode.

>=20
> >Can you explain how the stability is affected negatively by the way it
> >is written?
>=20
> Hard to find the correct answer without knowing why you prefer to update
> the flags for mm->mm_mt with mm->mm_users dropping down to ground.

I prefer to update the flags for mm->mm_mt first because the fallout is
minimal, however the alternative is to increase the execution time for
the vast majority of calls.  The trade off just isn't worth it,
especially since the tree may be left in RCU mode with a single user
anyways.  There is no stability issue here.

Thank you,
Liam=
