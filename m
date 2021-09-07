Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A63402CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhIGQYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:24:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23240 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235555AbhIGQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:24:48 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187EgKc4008786;
        Tue, 7 Sep 2021 16:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ONQ9jJnQJ/IxHik/LzzCjXDrHhN3dW9SvSr13Jj1KAw=;
 b=zqx/E5pOHX4ajPKn0pTAXdknAjnDKEqNzhL9Qee6Pep0hcvfhp7IChfTascmx7WXB7gm
 dx5U3/wtySK3Hd3XMOPwD/2dh9JljIp3S1ecXT/xoH399u2MguEolt0YmiDMrui/OQsy
 0Xpd+zFxtIq74681V7dcrmWPoFMYihncQuI8kPDoa14uyzO2YXwL5ei0fITrmTy8IpYU
 AHDthMZBRmpLxjs1MapYsnjNNZVrnjHywqWFQKpv2RJqWgBZ5q2vES3fYaNezrtnJm/q
 yG6Nz6m/w4JK62h5jmn0qJtmpQUZDh/VPfG+678tmNOu0uwSVmTpeMOaNIMupiV++trN Cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ONQ9jJnQJ/IxHik/LzzCjXDrHhN3dW9SvSr13Jj1KAw=;
 b=hXpc/FqXv6zSLHlzQ3ITdXrrnyogZquh+hvxh3GEY/k0VuUKACCJ4IqntA/qM8JYQB1S
 ddjtUqbZK2LjVRarpfILBhDkU/ENHP/6si6u9AO+WEAxGcmcScRWR4tthhCiVJwSIlww
 q0LWFUUvNQL7kXIvjQGXar/zzGFrQwyMu2S2MWK4Sm3u5Nx1pq4FEai6efViEylK1i0H
 1+ZlVEAJ3Ah2eGhF1Vg4MrC/lkFGB1mfUDyvhKvv6J3d6nZYNHUdQFLpRawhpPBldCtc
 w6iHWhBimoP6q0NT21Vrx44ThItt0Jrv5Qwk51CyHhh4iE4iCuHHjy7yo5J+n+3HP7gz eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awpwktvys-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:23:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187Fu3gp163611;
        Tue, 7 Sep 2021 15:57:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by aserp3020.oracle.com with ESMTP id 3av0m4ssp6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 15:57:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guSXsccjddi0Eab0kELowO0fVCmzEcdSibLHtakyWQEqAMHnkBwcniYNO33Lw3R157JcK7ceuLcK9XDLEyd0UaxpRct2YUslseiSkcglvcMgoPlACOn3HOUzjeQWwn4kZxTBCxFMy8L2MM2r28eRdP1S4cu0Lo19f1ZxE+zDrgle+o2KlTTJ+hNZe3Uhe9O2FnocvmWAMOaT3RDhUxCj5JDQyrrX0ndMkZK8XGLImnLuXPtTkllS5M/TNtCVFNK1+KC5ubXW2AIxGf0wAwmVDFdU2JjJSya8HcxgElD4Wyo7GRS2qI/WTifo4e4gT9kJtPplbHd3Q0TJxd5lOtoscQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ONQ9jJnQJ/IxHik/LzzCjXDrHhN3dW9SvSr13Jj1KAw=;
 b=UBZEvzMvhU9OX+Y0FcMN8CBHS3560Nm0ECoBjG5v/xVJEOWoi0OTMDi39lEH/ENSmEeiu2EUL8JXPFHLAT6XjkdO8A8q3palpGPekmlXo//tAP1NYCa+HwZ0UXY8bqGsjnoT5BzRs/PfWiYykeASVk/s/MB/uYCphURXdBi983m2IYFaTTkn+CvMp5Sxs62jjRszvheA06OqD8X0F3PgrWwa/3GBnACBaaoYygYwqHKu/XW/V+ZNVJ0JIqaDb/goY2nUB8Kq8GASpP31xK6NMmg2vQGiLWHHIi1Fj22eCQ+UwDiQ3ECTC3WDD95y6sZJdBq6jJbwLqPBQtJW+7VRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONQ9jJnQJ/IxHik/LzzCjXDrHhN3dW9SvSr13Jj1KAw=;
 b=gy58dYE2W/YFBD654HR3UxS2OmlOneFo3/JGnK4LS9XgABEOQI5AkhE/ZGKaoICNmkQq0VKgoOA/vR+SxLMBiTRfI4q4HkDlXIfyPq5psgW+2/z0C+gCcdAV1KqpD5iINY0DlVQxaSy4k0Sm51fREs7kRLE+dz/QqaDJD0sY6cQ=
Received: from SN6PR10MB2701.namprd10.prod.outlook.com (2603:10b6:805:45::20)
 by SN4PR10MB5541.namprd10.prod.outlook.com (2603:10b6:806:1e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 15:57:06 +0000
Received: from SN6PR10MB2701.namprd10.prod.outlook.com
 ([fe80::64da:7ae6:af82:ebfe]) by SN6PR10MB2701.namprd10.prod.outlook.com
 ([fe80::64da:7ae6:af82:ebfe%5]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 15:57:06 +0000
From:   Wengang Wang <wen.gang.wang@oracle.com>
To:     Gang He <ghe@suse.com>
CC:     "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: avoid getting dlm lock of the target
 directory multiple times during reflink process
Thread-Topic: [Ocfs2-devel] [PATCH] ocfs2: avoid getting dlm lock of the
 target directory multiple times during reflink process
Thread-Index: AQHXnjEQ7mXexg5a5UWyHghQ8QAQ56uYxZ+A
Date:   Tue, 7 Sep 2021 15:57:06 +0000
Message-ID: <3FF09C2E-2855-457E-8533-50BBD8EECEF1@oracle.com>
References: <20210826075941.28480-1-ghe@suse.com>
 <744d756c-7640-d312-37ef-126755324e8a@suse.com>
In-Reply-To: <744d756c-7640-d312-37ef-126755324e8a@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3114647-82d1-4005-9b41-08d972182452
x-ms-traffictypediagnostic: SN4PR10MB5541:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR10MB5541CC27B13A85E3C9D70580CFD39@SN4PR10MB5541.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ebLGcb1EtVWOK/oSh68TrWKIt7L/7myGSJW4NlfZxbFZOkiORs8hhHa6ELOvzT955OmL+hsxHXhP9Qctl2RaLuEzkI+V7dpaxy5Tk4D1O+IWfUTxeiCDEZUxdOiQtFnEZtQfDHQMkdkFSeuc1AAb1jw4dmLaP7hlp8KIJs+3oY+xm1a3JwkpznPkL681HscHzcBH8fugvZ9DHyvfYfRFap8LdqrTSD9uqAguCPn8MF+GcmszQFopPpsY6YhCG7uMnS9YeXGB4aWYqQ3MpEbXg/KZy6mHEG31tkP5AhSW5yOHo37Dy+BiJO6LO6XyIZlONxSmF+yce7Atuc6GJE5GxRUD4zW7Lb4cAj2Soyk28zFC0N7pkp/FWcwzGJV8CfPyVf4OvDOM3HOqjgwez8TQKuxJ63e4RVXHTX9uhWr3rQyXhYFnqlI2QzqC0B+zLrGVikMI/RgnkLJAeX4+IwI8ggOUeFcRFb3N8JRj4hM6MdblLcASPFSTin4JYzLToVhDkgnpLW3WLAfsEYUkbapL7v3q4pUggjvCQyd/cxq79rsVJdUxCeOBYCQOdwt+wvhKuh/jZEsnpf1vXEIUNZZsdahiT5sLB7OTcKT71rGdO/lgKvxQd3P8lY+glpsDUaOKLBzKQDuJ3DUXQQ8Hy4Lmm8YquyKCQA1KcUa3UMs7O3GIKL/orIsOWlg2cY50OJijnVX/hUGv1/BHduawOY1RLYP/S5+thjPKHTgI0BEWjizzfz1nhnyK4w9ruIh45enydj8Yjeym3lgtAkpMgKHPclmzorT/tmVdYfzYpypIISaKW5cwtA9Wfz43ZmrI4eVhChmStyZgl54RQZON5CUdXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2701.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(6486002)(86362001)(66946007)(2906002)(33656002)(54906003)(316002)(66446008)(64756008)(66556008)(83380400001)(478600001)(186003)(6506007)(38100700002)(5660300002)(53546011)(107886003)(66476007)(966005)(122000001)(6916009)(71200400001)(8676002)(4326008)(38070700005)(6512007)(36756003)(8936002)(2616005)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mm/KX05O1qWx/owXpVY6TTalgavLyTx7RMwZFvpiv2GUXhUPXz1T/YOLLmt+?=
 =?us-ascii?Q?GgfElI7nGeiovmx3QQgtrZZWZFm+pQnW4+ueorsd7/U/1vAqJzph8OD+P29M?=
 =?us-ascii?Q?hT9vuJqsRio1h6JGDatSLXPNnm3bSP0LMIZky164GdM+aw0x/9TCtSLze0N0?=
 =?us-ascii?Q?cRPlIePUGva9zx7FmS7WN8WuDMKhvRiqTM309QFpl6+vakSSoPE9F0SWkSA5?=
 =?us-ascii?Q?G9YHnHKz+D9S13hSnHRjEa39eCtwydrkie+nQWHq3MLNKxXKn3xQZMT0AeKf?=
 =?us-ascii?Q?Plr+NS9ckx3xCbIVFbRwbEHyOs3GX9oOzRoZtjCK+8nZZnNuyXTSV4YvEyc7?=
 =?us-ascii?Q?kGDjPU1Al9N3ixn7FjGKl+aUSWF6cV4hY91cFXpn9PbAinhehAYkr8L9uTlc?=
 =?us-ascii?Q?7pTI73sRE0WiphEvdeKOQ3AIs9uVqtRl8DtLhdb5YrOFy2JkTco15ae65Drt?=
 =?us-ascii?Q?2uYyB3412gds1OejaMoO76t/ZNkdQ9HrY051nMG196czsa77GGx7ox9JiSul?=
 =?us-ascii?Q?YX1XkbZdEg0ssh37tT8+n8TAkJZzM++EN1cAX3UhXkZMMpCKlg4KpRG/ufy1?=
 =?us-ascii?Q?78l4BRCBo3bED/R8nsi6EHvWbUiCioafQa00osu7xlOa1evVwFPSvBra6XNG?=
 =?us-ascii?Q?udqEU+RiNnW9kCGyjAE42zXLfD2VdnHxtMLkgRbpypXmAa0RUDqcD6EaESXr?=
 =?us-ascii?Q?Ax1e5wpZFlUy1Tl86ckzjkOr69dUIVXxDnIbL1LjPJ/G2qxCDz15rJeFNdvN?=
 =?us-ascii?Q?t8N5oSV586mjkLK7wc19iS2ELrFMe7nPmenV8hxIBhss/O6lZqCIcgSO18FS?=
 =?us-ascii?Q?hTXxQOK2V+LNIJIVbcXwbpoXh5rQrkSsQeGmZV4tOQQsf8J5eYm1zKZ4LdWQ?=
 =?us-ascii?Q?AqQlBG6jhTg+wUUocj9mqnSkczE+RuZGvWhjejSUWt9VbZvNo4D++zYU3y9O?=
 =?us-ascii?Q?TtaBdrn1KTAXN5iwl0IKGGKsQGlelYHLHRBsWbfvRDdK+RyUwci+pQ2oV7+4?=
 =?us-ascii?Q?RVoThv8e2mRu1pQ/xBK2H6QcKqmluKWGgZL54nMVBL6NudVTecyIVPSytD4V?=
 =?us-ascii?Q?YdlkCrt7KysFDOcIsHnAL4+GFwbp9JxTHSsVVqHJn/qtCb4xvkLe+X44eNKD?=
 =?us-ascii?Q?/MhjfIJ3N1rdcx5U4L3PUtp+S2ie7KTWCVI1ySdE4XixfpbZNAt6nGs4zpSn?=
 =?us-ascii?Q?rHdE9/XqosYudu5IQZuhhxGGgVHHkduiOzhShRAvy5COxmMBQopMpWc/adVU?=
 =?us-ascii?Q?3dctj8EDVxoQufsUxQv+N6TfINfPtf5EsjL1BSBKFiYEZ/+msVs247Uf1nKE?=
 =?us-ascii?Q?o1/TwJx6ZosxHFauXgLiSL+0Hr35JJ7V3Zev933khE4jMYBGvTZ8z36m/YtR?=
 =?us-ascii?Q?8ld0rXM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8148C25A8015E74F863E82B93E436038@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2701.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3114647-82d1-4005-9b41-08d972182452
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 15:57:06.3411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqUepSkiqdXWjLk39HaSyOWbTU3+jlcrAyw4gj8U6bsooWmJlVnjN07bduUVV90QyvEoORIat3k0bnOtH7YDVxJWxDV5sP3TxtinnwZmHJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5541
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070104
X-Proofpoint-GUID: -dtT41YrtdE1nLQHVqHuyWWxmYv_JYSH
X-Proofpoint-ORIG-GUID: -dtT41YrtdE1nLQHVqHuyWWxmYv_JYSH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gang,

Sure, I will look into the problem you are trying to address. Any bug fix a=
nd performance improvement is welcomed!
Well, can you please provide the analysis on the tcpdumps between the (two)=
 nodes that covers the reflink operation with/without your patch to show ho=
w you saved dlm locking ping-pongs?

And what cases did you test to get better performance?

thanks,
wengang

> On Aug 30, 2021, at 11:25 PM, Gang He <ghe@suse.com> wrote:
>=20
> Hello Joseph and Wengang,
>=20
> When you have time, please help review this patch.
> About the deadlock problem which was caused by ocfs2_downconvert_lock=20
> failure, we have the fix patch, it is very key.
> But I feel this patch is still useful as a optimization patch, the user
> case is to reflink the files to the same directory concurrently, our=20
> users usually backup the files(via reflink) from the cluster nodes=20
> concurrently(via crontab) every day/hour.
> The current design, during the reflink process, the node will=20
> acquire/release dlm lock of the target directory multiple times,
> this is very inefficient in concurrently reflink.
>=20
>=20
> Thanks
> Gang
>=20
> On 2021/8/26 15:59, Gang He wrote:
>> During the reflink process, we should acquire the target directory
>> inode dlm lock at the beginning, and hold this dlm lock until end
>> of the function.
>> With this patch, we avoid dlm lock ping-pong effect when clone
>> files to the same directory simultaneously from multiple nodes.
>> There is a typical user scenario, users regularly back up files
>> to a specified directory through the reflink feature from the
>> multiple nodes.
>>=20
>> Signed-off-by: Gang He <ghe@suse.com>
>> ---
>>  fs/ocfs2/namei.c        | 32 +++++++++++++-------------------
>>  fs/ocfs2/namei.h        |  2 ++
>>  fs/ocfs2/refcounttree.c | 15 +++++++++++----
>>  fs/ocfs2/xattr.c        | 12 +-----------
>>  fs/ocfs2/xattr.h        |  1 +
>>  5 files changed, 28 insertions(+), 34 deletions(-)
>>=20
>> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
>> index 2c46ff6ba4ea..f8bbb22cc60b 100644
>> --- a/fs/ocfs2/namei.c
>> +++ b/fs/ocfs2/namei.c
>> @@ -2489,6 +2489,7 @@ static int ocfs2_prep_new_orphaned_file(struct ino=
de *dir,
>>  }
>>=20
>>  int ocfs2_create_inode_in_orphan(struct inode *dir,
>> +				 struct buffer_head **dir_bh,
>>  				 int mode,
>>  				 struct inode **new_inode)
>>  {
>> @@ -2597,13 +2598,16 @@ int ocfs2_create_inode_in_orphan(struct inode *d=
ir,
>>=20
>>  	brelse(new_di_bh);
>>=20
>> -	if (!status)
>> -		*new_inode =3D inode;
>> -
>>  	ocfs2_free_dir_lookup_result(&orphan_insert);
>>=20
>> -	ocfs2_inode_unlock(dir, 1);
>> -	brelse(parent_di_bh);
>> +	if (!status) {
>> +		*new_inode =3D inode;
>> +		*dir_bh =3D parent_di_bh;
>> +	} else {
>> +		ocfs2_inode_unlock(dir, 1);
>> +		brelse(parent_di_bh);
>> +	}
>> +
>>  	return status;
>>  }
>>=20
>> @@ -2760,11 +2764,11 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_sup=
er *osb,
>>  }
>>=20
>>  int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>> +				   struct buffer_head *dir_bh,
>>  				   struct inode *inode,
>>  				   struct dentry *dentry)
>>  {
>>  	int status =3D 0;
>> -	struct buffer_head *parent_di_bh =3D NULL;
>>  	handle_t *handle =3D NULL;
>>  	struct ocfs2_super *osb =3D OCFS2_SB(dir->i_sb);
>>  	struct ocfs2_dinode *dir_di, *di;
>> @@ -2778,14 +2782,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *=
dir,
>>  				(unsigned long long)OCFS2_I(dir)->ip_blkno,
>>  				(unsigned long long)OCFS2_I(inode)->ip_blkno);
>>=20
>> -	status =3D ocfs2_inode_lock(dir, &parent_di_bh, 1);
>> -	if (status < 0) {
>> -		if (status !=3D -ENOENT)
>> -			mlog_errno(status);
>> -		return status;
>> -	}
>> -
>> -	dir_di =3D (struct ocfs2_dinode *) parent_di_bh->b_data;
>> +	dir_di =3D (struct ocfs2_dinode *) dir_bh->b_data;
>>  	if (!dir_di->i_links_count) {
>>  		/* can't make a file in a deleted directory. */
>>  		status =3D -ENOENT;
>> @@ -2798,7 +2795,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *d=
ir,
>>  		goto leave;
>>=20
>>  	/* get a spot inside the dir. */
>> -	status =3D ocfs2_prepare_dir_for_insert(osb, dir, parent_di_bh,
>> +	status =3D ocfs2_prepare_dir_for_insert(osb, dir, dir_bh,
>>  					      dentry->d_name.name,
>>  					      dentry->d_name.len, &lookup);
>>  	if (status < 0) {
>> @@ -2862,7 +2859,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *d=
ir,
>>  	ocfs2_journal_dirty(handle, di_bh);
>>=20
>>  	status =3D ocfs2_add_entry(handle, dentry, inode,
>> -				 OCFS2_I(inode)->ip_blkno, parent_di_bh,
>> +				 OCFS2_I(inode)->ip_blkno, dir_bh,
>>  				 &lookup);
>>  	if (status < 0) {
>>  		mlog_errno(status);
>> @@ -2886,10 +2883,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *=
dir,
>>  	iput(orphan_dir_inode);
>>  leave:
>>=20
>> -	ocfs2_inode_unlock(dir, 1);
>> -
>>  	brelse(di_bh);
>> -	brelse(parent_di_bh);
>>  	brelse(orphan_dir_bh);
>>=20
>>  	ocfs2_free_dir_lookup_result(&lookup);
>> diff --git a/fs/ocfs2/namei.h b/fs/ocfs2/namei.h
>> index 9cc891eb874e..03a2c526e2c1 100644
>> --- a/fs/ocfs2/namei.h
>> +++ b/fs/ocfs2/namei.h
>> @@ -24,6 +24,7 @@ int ocfs2_orphan_del(struct ocfs2_super *osb,
>>  		     struct buffer_head *orphan_dir_bh,
>>  		     bool dio);
>>  int ocfs2_create_inode_in_orphan(struct inode *dir,
>> +				 struct buffer_head **dir_bh,
>>  				 int mode,
>>  				 struct inode **new_inode);
>>  int ocfs2_add_inode_to_orphan(struct ocfs2_super *osb,
>> @@ -32,6 +33,7 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_super *os=
b,
>>  		struct inode *inode, struct buffer_head *di_bh,
>>  		int update_isize, loff_t end);
>>  int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
>> +				   struct buffer_head *dir_bh,
>>  				   struct inode *new_inode,
>>  				   struct dentry *new_dentry);
>>=20
>> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
>> index 7f6355cbb587..a9a0c7c37e8e 100644
>> --- a/fs/ocfs2/refcounttree.c
>> +++ b/fs/ocfs2/refcounttree.c
>> @@ -4250,7 +4250,7 @@ static int ocfs2_reflink(struct dentry *old_dentry=
, struct inode *dir,
>>  {
>>  	int error, had_lock;
>>  	struct inode *inode =3D d_inode(old_dentry);
>> -	struct buffer_head *old_bh =3D NULL;
>> +	struct buffer_head *old_bh =3D NULL, *dir_bh =3D NULL;
>>  	struct inode *new_orphan_inode =3D NULL;
>>  	struct ocfs2_lock_holder oh;
>>=20
>> @@ -4258,7 +4258,7 @@ static int ocfs2_reflink(struct dentry *old_dentry=
, struct inode *dir,
>>  		return -EOPNOTSUPP;
>>=20
>>=20
>> -	error =3D ocfs2_create_inode_in_orphan(dir, inode->i_mode,
>> +	error =3D ocfs2_create_inode_in_orphan(dir, &dir_bh, inode->i_mode,
>>  					     &new_orphan_inode);
>>  	if (error) {
>>  		mlog_errno(error);
>> @@ -4304,13 +4304,15 @@ static int ocfs2_reflink(struct dentry *old_dent=
ry, struct inode *dir,
>>=20
>>  	/* If the security isn't preserved, we need to re-initialize them. */
>>  	if (!preserve) {
>> -		error =3D ocfs2_init_security_and_acl(dir, new_orphan_inode,
>> +		error =3D ocfs2_init_security_and_acl(dir, dir_bh,
>> +						    new_orphan_inode,
>>  						    &new_dentry->d_name);
>>  		if (error)
>>  			mlog_errno(error);
>>  	}
>>  	if (!error) {
>> -		error =3D ocfs2_mv_orphaned_inode_to_new(dir, new_orphan_inode,
>> +		error =3D ocfs2_mv_orphaned_inode_to_new(dir, dir_bh,
>> +						       new_orphan_inode,
>>  						       new_dentry);
>>  		if (error)
>>  			mlog_errno(error);
>> @@ -4328,6 +4330,11 @@ static int ocfs2_reflink(struct dentry *old_dentr=
y, struct inode *dir,
>>  			iput(new_orphan_inode);
>>  	}
>>=20
>> +	if (dir_bh) {
>> +		ocfs2_inode_unlock(dir, 1);
>> +		brelse(dir_bh);
>> +	}
>> +
>>  	return error;
>>  }
>>=20
>> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
>> index dd784eb0cd7c..3f23e3a5018c 100644
>> --- a/fs/ocfs2/xattr.c
>> +++ b/fs/ocfs2/xattr.c
>> @@ -7203,16 +7203,13 @@ int ocfs2_reflink_xattrs(struct inode *old_inode=
,
>>  /*
>>   * Initialize security and acl for a already created inode.
>>   * Used for reflink a non-preserve-security file.
>> - *
>> - * It uses common api like ocfs2_xattr_set, so the caller
>> - * must not hold any lock expect i_mutex.
>>   */
>>  int ocfs2_init_security_and_acl(struct inode *dir,
>> +				struct buffer_head *dir_bh,
>>  				struct inode *inode,
>>  				const struct qstr *qstr)
>>  {
>>  	int ret =3D 0;
>> -	struct buffer_head *dir_bh =3D NULL;
>>=20
>>  	ret =3D ocfs2_init_security_get(inode, dir, qstr, NULL);
>>  	if (ret) {
>> @@ -7220,17 +7217,10 @@ int ocfs2_init_security_and_acl(struct inode *di=
r,
>>  		goto leave;
>>  	}
>>=20
>> -	ret =3D ocfs2_inode_lock(dir, &dir_bh, 0);
>> -	if (ret) {
>> -		mlog_errno(ret);
>> -		goto leave;
>> -	}
>>  	ret =3D ocfs2_init_acl(NULL, inode, dir, NULL, dir_bh, NULL, NULL);
>>  	if (ret)
>>  		mlog_errno(ret);
>>=20
>> -	ocfs2_inode_unlock(dir, 0);
>> -	brelse(dir_bh);
>>  leave:
>>  	return ret;
>>  }
>> diff --git a/fs/ocfs2/xattr.h b/fs/ocfs2/xattr.h
>> index 00308b57f64f..b27fd8ba0019 100644
>> --- a/fs/ocfs2/xattr.h
>> +++ b/fs/ocfs2/xattr.h
>> @@ -83,6 +83,7 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
>>  			 struct buffer_head *new_bh,
>>  			 bool preserve_security);
>>  int ocfs2_init_security_and_acl(struct inode *dir,
>> +				struct buffer_head *dir_bh,
>>  				struct inode *inode,
>>  				const struct qstr *qstr);
>>  #endif /* OCFS2_XATTR_H */
>>=20
>=20
>=20
> _______________________________________________
> Ocfs2-devel mailing list
> Ocfs2-devel@oss.oracle.com
> https://oss.oracle.com/mailman/listinfo/ocfs2-devel

