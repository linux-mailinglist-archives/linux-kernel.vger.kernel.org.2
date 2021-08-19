Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30BF3F1A69
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbhHSNeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:34:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63880 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239472AbhHSNeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:34:04 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JDPqAi002953;
        Thu, 19 Aug 2021 13:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XJdkNIyl9o5WPsE2w370QxYm4ff6L0bgMfkWHvbxMZk=;
 b=IgIe+OcpJCnN1ZxdENsipJmixCHwxtdQvCuPJ82uzGnpGBnPrILgzMA3Ak1CzlGE+C/V
 OXNsJhZwKY2uabJ+NeJFouOXLnjGczOF1DHsZeB01K1r60mBTVw7CHmCLuqAtXKVrp4R
 uRXSTYqk/R3plI/TvvUILlAklg7x8pY72ATQgFwRPkjcbW2qbn5609mX/Wyk2q/qOSmY
 /LnTrhKZrp+qYgBWeC6yPQZidUuDIXy5CTsVG9zfMY6tJbc4HP7djAzTp99NNoFWRqdY
 6+ILZyUAsTyhetkJKuCUDy8fA+6w0qNc8xY4NtBS+g2qOwpdQPFghaKUgA8DrdFay1La GQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XJdkNIyl9o5WPsE2w370QxYm4ff6L0bgMfkWHvbxMZk=;
 b=IZVIzHOOol1pevx7m29Aj9OepEjs39yp0zmKFa6C/AhxSr8r0xkFuCMnpXu1mOdoza8C
 uDU1PHm52V+PPPHTPmkay/m/y3npj5/raYLNfAtV30wjciWEF+jaHnduY7vbsCg1g4wH
 3PSf+eVg+tSQpGZJJWfz7spXHJLkd2f8Luc5nFZjxbrUA53FK2j+77khFwd1hZAw+F4N
 CIxeEn+xvTTx1lRHEHTYD0nTKFFPxVt2+qs+PXa2zX/4eJuxlhsTrd5u1M7SubDBGwEj
 k75AGEZHfhwKJjxqwlsYHqzb3Y1ZQegwNjJsP7F70Hgj3TBx5fq2jon6PzFssEXnwHcw uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmk9er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 13:33:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JDP7Cp047505;
        Thu, 19 Aug 2021 13:33:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3020.oracle.com with ESMTP id 3aeqkyfprx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 13:33:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI86517fc8RcITAb317YkvmU9EZC+LmKfwQLrQeAE5UvWtvPQXJgKp8Fd/BN4wTZzG901MEzJDsO6tfrPbiVkawr5Ot/hqfVrhToTUIl9LAI7GejrdYhkAZrytUxuYTOmE9lRkHBjY/sev7TH2gQbI82mknT9H3Kpr/ECoVQyq1gmGemO65PxAojmNCgHty2MsBmkxxPfwaEQMf3SU+ThgLYLSMoJtjd4cJVtllFsHzfZ0dsdd1lbgx/A4nxj37VV161iNBdgptqCaIxgIDtQJalIx2kiHAbakMXU6Nicv/XUojUi0C2aE0C8yz55ZeAQ0IbtN6NpyblRf3YuNWkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJdkNIyl9o5WPsE2w370QxYm4ff6L0bgMfkWHvbxMZk=;
 b=gf5qSxhn1D1HklfdSokpYYqcxcjwaFSYBfz8t4R/jN8R4xqDR+ZHAY7Had310dZ2xE7XUMrrTJaUSNpKhRvRmOM6CM1TuoLakiY6O8hWJA1QqRHHESpGV2qA05tfzxqFyuz2u3zKKOHmpctFu4buQBiCoKeGhOdevxamKXN1BcZ0fpi9lAnfFedd8lLdcvUWdJY/swqeHfNQwcBTkRx0kWdiMmU3IZ+TjgDjb/A6OJZpmqh/L07r51qprKmouthRZHO7lfGWiUknBsoD7WsWIyF77fykK8HzVF9DswRvvG7VT3MxXHast5G+r/75JvvRf0SDbT5BfO9szxTvMTNeQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJdkNIyl9o5WPsE2w370QxYm4ff6L0bgMfkWHvbxMZk=;
 b=yuQ2U0xJ4gaSgym1Xjz6qkkqUQtY84howDGv7FY3TPRRRxF9afgp2lXtoVd936L9HrF0s5F1rnkydgkgpTSgVROeYYvPn8ydnsIkCZrMfvb/PAo+KxpUmHHZqgHDYWGYvon8PK6GZ4WfzGmkeMEDIPq6JjWZDKTjAn4U/vY9VE0=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM5PR10MB1353.namprd10.prod.outlook.com (2603:10b6:3:9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.17; Thu, 19 Aug 2021 13:32:58 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 13:32:58 +0000
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
Thread-Index: AQHXk38k0JUHaKd/aEyW/GzwRyUQFat48TIAgABpqQCAALpJgIAAwUWA
Date:   Thu, 19 Aug 2021 13:32:58 +0000
Message-ID: <20210819133249.sdkhsgg2wkur6yjq@revolver>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
 <20210818083610.3698-1-hdanton@sina.com>
 <20210819020105.3756-1-hdanton@sina.com>
In-Reply-To: <20210819020105.3756-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd985ae3-a1cb-477e-14e2-08d96315dbee
x-ms-traffictypediagnostic: DM5PR10MB1353:
x-microsoft-antispam-prvs: <DM5PR10MB1353F39EB946D7AC60A405E4FDC09@DM5PR10MB1353.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p754Cij/MQ1V4017wKaJTz0O6dRXmW8d/+jIGT/Q62b/Xb5BOXe/tk+CxwX48d94lWAMAvp3HlIvxNmjnK4obGD4Xapo2+UwwPfyxlhvo57Nh4jUfoBTOw2q9iDH33y9W9fLhqUZzIEDxRKr2w5eC8gCc29auaSSAGPf06aJtzOiJg1MZyxkEwD2GNq9Jx8BdK5H9m2GWCLytMIAoQlr6TC/wGkTTeal1wH8+gsxCTGx50M1CMcNGUtcqV4pXVwF59ynnqbyo8EpyBa/Sezf6JrX9zoeOj0kNDGKskhd+AiJx8/jElNDZEsR7b9yEzWByiZusYc4RHqwYPk+DB0O5LrFRdoxpS1rwjt3tsLKuTJPBg4Bcx/i5oEpd1w7ZHnMu7oWXxyxr5VdfXVmr92MmpPG6wZWWFuAak8O8CX9P9hC10vjUraz+8PDkcbs9c8X/v07yqtlSTF5kBRfgjLzONq+wg0A9WEXfDIDFKCBGBL29w+wiItH7+PLbYvUXYMlwhgAevbpoE6tKcJi8jkAE72Wn2imtjgsdLSe5sgMCjugtRNrUfjU0pVmGXFNEOG1DCTkK1AQD9VvHXVXAF2NhmwdqIARdNJPWkalNDCTTXzuRh7wTxlakeDjFfE615gFC8bbvouAW8VUbEFP03yTtIrSluEVTAAduIZhA+yBR7mSgYnyNVqFjqMaJb176iFCzIUtpvokEQTfmK/+9vIFrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39860400002)(396003)(136003)(376002)(366004)(346002)(26005)(6512007)(9686003)(38070700005)(66446008)(54906003)(122000001)(2906002)(5660300002)(38100700002)(44832011)(4326008)(478600001)(1076003)(86362001)(71200400001)(8676002)(316002)(76116006)(66556008)(64756008)(66946007)(33716001)(66476007)(8936002)(186003)(91956017)(6506007)(6916009)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YpNNkS8Ol8g9J8o40O21Vxe2CO29gtpfh4KxCj1yjgMggGMYa1Uv4aYC17Ym?=
 =?us-ascii?Q?sCVIr/tlZee8+2VonM9C0hzaE3g9BulAzbdLgXGzDcH27IA32/+b8ekWOyTa?=
 =?us-ascii?Q?6V4y4fsSR+OCkFh6pkiYnMwHImylm5b+QG3Fk+gnJ6zi5E6MUMLWIoN2AABN?=
 =?us-ascii?Q?5aO6GEOozrrimaWYnR7wSBzR7+x+JnBO/iFwVnrT37WiWAsTQvPUOo44JXBt?=
 =?us-ascii?Q?fDE9i6unJCgj58lZTtQ9inJ2aA+g7QOFyL8SXGRM++5OMLA8en79jbANUogm?=
 =?us-ascii?Q?uRU8XDD7VvUoIsu41B4v347zzzW8Zmvrr8CT8uMFdT/4UHc+cTxn3tKqwZpa?=
 =?us-ascii?Q?9MxghG/eEEbU5Di69ckNq1jdiGcMvhzqDavCXN6psXyfooQYRdbDK2BEn6nG?=
 =?us-ascii?Q?kT0V5m1kEQM1GjZJlTPaBU/JNUde3CQV41yb2PgMuWuHx/ILGei83eOifRnI?=
 =?us-ascii?Q?Ea3VrEqEjL//k7jP/wBEZ1RGkU6595+c7QGHsRjLg7bzXhc1GOqOyqHHOqHS?=
 =?us-ascii?Q?AWII+dxiwiq+8r6F9VIOd4scVTjOpi0oPiQ4Z39ws63SlsF/jnuCB9Q+Jy9v?=
 =?us-ascii?Q?WjxFscvxtnD4F0GgCyPDSI1MFUgYEq9J6kP/qo5Ii/gReqXAYcz3MaB2oMpL?=
 =?us-ascii?Q?gdweFU+2c6R4mvWm1vPpNEpaBfMATGz7akAAUyMwwnDGcGc2rLHQsBzAgv0B?=
 =?us-ascii?Q?M9QQUIS4bOw5gsbBiodvwv/kE/aftM0rn0ZSODIlIjf3nuOOiOLfZXYVN0Wi?=
 =?us-ascii?Q?m9jD7j37m+Bjy3xETURQFxtagq+3ZzE9ZQhWWqIIRFDMSW1mhZTXlbkrw45T?=
 =?us-ascii?Q?BUJ/RZt1zQsX/cKxGRjmtzzXXNu3DaExTR34f7XkctpMQZ9CrDJy9F0fqQWR?=
 =?us-ascii?Q?0olbJLnd1+8xrGvosZXCOtqD946epG9eZIQYGhxRGOzl0mmvMswc7fu4WJwI?=
 =?us-ascii?Q?bZn2revdPBm0I0XOWrhfpQt2dBXFHGD38r29S3Vl/6HVwl3U6VyUKNnkXnsE?=
 =?us-ascii?Q?E/6n1QB0cMkah1z1iVPQ4pW4VlImvUN6mw9noZyahFi9FGK6c6Llpd5JsMaf?=
 =?us-ascii?Q?rqmUsGrZJ4l2qC6ZRkOvwGgN/NtTg3d9Mo97jfCR2pc5OJXMIv0MmlEhD7iK?=
 =?us-ascii?Q?juVx5xhrEN/SKCZ3wb+tectbOoaXpGVrPXh4ox+l+tepIZC4gNEZMUtpnrVM?=
 =?us-ascii?Q?9vAqlra4tab7s2ngKnTHi7PWEbmJVZwcHY+PVfKOODdrmofNzdj6yO35EDd0?=
 =?us-ascii?Q?6jNuA9P5rg9HD5swdkzUqzkPa7cxDB285VgfuV1yBqBjX2Wk2WVLnRmMeviv?=
 =?us-ascii?Q?vqeFgrumPoKncbSbI7RfgRNx?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32A373C85A6028478FBA680BD582F5AA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd985ae3-a1cb-477e-14e2-08d96315dbee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 13:32:58.3448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EueXIf9p6ahsLnf32f844hph/f8WkJ9e2OVnYwAN/yPl3QcSbGaAyuDym0qTveHi/Jh2LR7Wg5SkxYhAaS30AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1353
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190078
X-Proofpoint-ORIG-GUID: nBi5YKxJFKpV4UJs4--5o1p6rcYsISC6
X-Proofpoint-GUID: nBi5YKxJFKpV4UJs4--5o1p6rcYsISC6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hillf Danton <hdanton@sina.com> [210818 22:01]:
> On Wed, 18 Aug 2021 14:54:29 +0000 Liam R. Howlett wrote:
> >* Hillf Danton <hdanton@sina.com> [210818 04:36]:
> >> On Tue, 17 Aug 2021 15:47:11 +0000 Liam R. Howlett wrote:
> >> >
> >> >  static inline void mmget(struct mm_struct *mm)
> >> >  {
> >> > +	mt_set_in_rcu(&mm->mm_mt);
> >> >  	atomic_inc(&mm->mm_users);
> >> >  }
> >> >
> >> >  static inline bool mmget_not_zero(struct mm_struct *mm)
> >> >  {
> >> > +	/*
> >> > +	 * There is a race below during task tear down that can cause the =
maple
> >> > +	 * tree to enter rcu mode with only a single user.  If this race
> >> > +	 * happens, the result would be that the maple tree nodes would re=
main
> >> > +	 * active for an extra RCU read cycle.
> >> > +	 */
> >> > +	mt_set_in_rcu(&mm->mm_mt);
> >> >  	return atomic_inc_not_zero(&mm->mm_users);
> >> >  }
> >>
> >> Nit, leave the mm with zero refcount intact.
> >>
> >>  	if (atomic_inc_not_zero(&mm->mm_users)) {
> >> 		mt_set_in_rcu(&mm->mm_mt);
> >> 		return true;
> >> 	}
> >> 	return false;
> >
> >Thanks for looking at this.
> >
> >I thought about that, but came up with the following scenario:
> >
> >thread 1	thread 2
> >mmget(mm)
> >		mmget_not_zero() enter..
> >		atomic_inc_not_zero(&mm->mm_users)
> >mmput(mm)
> >		mt_set_in_rcu(&mm->mm_mt);
> >		return true;
> >
>=20
> At first glance, given the above mmget, mmput will not hurt anyone.

In the case above, the maple tree enters RCU mode with a single user.
This will have the result of nodes being freed in RCU mode which is the
same result as what happens as it is written, except the racing thread
wins (in this case).  I thought this was what you were trying to fix?

>=20
> >
> >So I think the above does not remove the race, but does add instructions
>=20
> If the mm refcount drops to one after mmput then it is one before
> atomic_inc_not_zero() which only ensures the mm is stable afterwards
> until mmput again.

Right.  The race we are worried about is the zero referenced mm.  If
mm->mm_users is safe, then mm->mm_mt is also safe.

>=20
> >to each call to mmget_not_zero().  I thought the race of having nodes
> >sitting around for an rcu read cycle was worth the trade off.
>=20
> Is one ounce of the mm stability worth two pounds? Or three?

I don't see a stability problem with the way it is written.  Your change
does not remove the race.  Can you explain how the stability is affected
negatively by the way it is written?

Thanks,
Liam=
