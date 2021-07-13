Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8806F3C72BE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhGMPEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:04:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17500 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236842AbhGMPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:04:34 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16DF19ME018446;
        Tue, 13 Jul 2021 15:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZlpSL5NgbwGe0AUdkYoNj7CqX2JAZS7GykMsl5Rv8FU=;
 b=p6rsldmq2rPj1YZsORJg4jJP+XWN2AxsRHjImHr2CZynvtslcK9+dclh4EHQI7xByOsE
 XQ80MRclSlO6x/bcuO63JOXvYHyi9lSD19I5FYdl6WovJMsSjeL68xDZ1EhO8NXopbeU
 Vl1XXJZkQ+c9quUmgZ4eZH7lAlyIVEBe+9V4hjboJCL6WEjc4iHb1uk4FhVvSyr8Ptgh
 ccJqiNR6LGlO7i8ecf6/IvyzmcV77wy9LRz6o33biqVbdgW4qJGGvpvFfXRx4b0U4SJC
 YygIYbREuyVS70pZAxB/qVcTP5DiEyoOZRKtpyTQtV6AmvxJ9wWS7YUE1O79/SPDYUf3 MQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rqkb2k6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 15:01:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16DF118f183138;
        Tue, 13 Jul 2021 15:01:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by userp3020.oracle.com with ESMTP id 39qnaye07c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 15:01:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2yL0YVDzqB9kzrzA9DAliv1vV6ZQZk49Y+BTVtZPwTsAD672AHrNIno5aUcobtWNClKAvvnqSO76KITd4ExBsR8ZBWP7oq60At9eh2CJ4jN0lw6HSjbLB/RzfLdZGEKoN9JU47OQb5ZAhblYhPFkfqcKd9sgahqvMkASEAgPOxBxl7kb50GL02K3ytMsuLRBHA90ecCkWpfRsXu1td7BEiTcls4zf85kXHIUkkQZq+enICBA1Iak20D8indjSIAx+YHHxkTzAbPwRm4j/dafbB6RiFmsx2R/HAHJ1TS2WuReRuhCd+zYMmbdLDU9eKtHFWBFgJHsr0tQQZ3D9q4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlpSL5NgbwGe0AUdkYoNj7CqX2JAZS7GykMsl5Rv8FU=;
 b=ky6Mew3lTIe9JPCtDFhH8cEaiet1vnyDoc1WQUsrTKn5ptavKl5rOrTqr4Qnr8unpuR/KRICC7Oe8vB5vNq6XxdYqGd3t3i3o/RLUrcEAkM1jp8LWuVw/CvDeRRAM0lh6/x7bGe//KcbC5cMLXkqCe2n0xQ5u0UW8zwSGGp8JXY0Nju/5KRH7lIi5h0G3NiQ0AfWkEjZETTwrNXzHeFBtDK4vSzw9Rkt/bneTNITcZQKBJQXgpo2mrYfyt+jnEqmm2SrXI8Zxq1YEOeXiABBxg87cE+xP0Rn5ITY3zUWs2LUN59h6nyWXIo15HWQDXAs7n0G+/isiepZ5FujdjcebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlpSL5NgbwGe0AUdkYoNj7CqX2JAZS7GykMsl5Rv8FU=;
 b=d58BI1Em+EQKkNjyeW3DVTfOEgZjfSBn71bYTXO/anZF49Wo4LIwq2c3+QfRLr86OUvLkjUb2LUbG+xcrZfX+PArG3nR7Qg3VXiudp+fux6RTrVeRxcuZ4gGImHcQ/4avQ4FUbcJOoPhzXi60zqHtXc5VLfg/S/uz9bty9eh88I=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2968.namprd10.prod.outlook.com (2603:10b6:a03:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 15:01:24 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 15:01:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Zhang Qiang <Qiang.Zhang@windriver.com>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] mm/page_alloc: correct return value when failing at
 preparing
Thread-Topic: [PATCH 2/4] mm/page_alloc: correct return value when failing at
 preparing
Thread-Index: AQHXd+7xOOwL13NwHEq2099ClUljlKtA9QGAgAAJn4CAAAFlgA==
Date:   Tue, 13 Jul 2021 15:01:24 +0000
Message-ID: <38D7DF36-4425-4D8B-9091-CE49CE046D6A@oracle.com>
References: <20210713135625.7615-1-mgorman@techsingularity.net>
 <20210713135625.7615-3-mgorman@techsingularity.net>
 <E7C50307-24D8-4D75-B65E-0D7CA7C08048@oracle.com>
 <20210713145623.GE3809@techsingularity.net>
In-Reply-To: <20210713145623.GE3809@techsingularity.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: techsingularity.net; dkim=none (message not signed)
 header.d=none;techsingularity.net; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cba6e9d-ce3e-4a74-b1d4-08d9460f1521
x-ms-traffictypediagnostic: BYAPR10MB2968:
x-microsoft-antispam-prvs: <BYAPR10MB29685DEB111B839CF3356D3693149@BYAPR10MB2968.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f4P2ejTYUCUFa2R3TNX1VBjRdknIAHbL+cXZXqEckfZvSMjKKa3HewNh0O5lQjlFKTDB1IYClQRVxiWPlvBWH3ftfyNOQLkn1Bf8ythEodM8tquoKET7yXcXCrmo53YzqGXnFST30pdYHgUBq13sqSohLf5csdHUzSEKchyhnviMvRvn1C/m9onGqy3GJmh+pPWlYMyJgL/u9CVmJt/X4nUcsGzY1uOGet7+LvYrxuYHvmrsNApGAPqjtO38wGGYEF8SUHGNgmgSmtIPGK7RFucREZP35YeI2MFIg1NJ1gvJ6R+42peU5NE3Akio/2xhJrfThsqH/f8J1RYSDfM04OoUKjhObkX8haFjfXF4f5pXhmHFxWnmd1yUl2Y98YbYuUYswwTx/vGUXT8vCWlPjOp83d/r5Vow39OtiRkUG6Uuw0Ypefa5DDigNgUIJ9GcZ3jXsdkgSN6Y7JdpJwOY0Xx5FYBAM6zs1V/psP5WjFdpZNlGulXuBAAkKILIrAdcXxnKOIemBGCwswib5HzDUAexytiri4/Czj4aAZaSnovEX9MSUqPIiK79y2ehcPGJoaAGsDHKM6slGu5+MuP4e6FqXZZxb36aF8i9vfof4sW1VOaLsgLVpGjfd22I4BrTB3pSgaBY/zG/p0MlO+HQwj3Yt0xL22DDna4nXg5LSCz7BG+JfB3Nd0z+mmn/6d88nycOEP6A7Eil1ZgxNntDzQPxWjvyV7NPGLl/oBbvnDNz5Z77UzDVE9mBMAzz46DqDzMT89nKU5C2wqywKMZWyoli0v9F4wYnMpj2ZbpboqA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(346002)(136003)(366004)(33656002)(5660300002)(966005)(26005)(6486002)(53546011)(316002)(6512007)(86362001)(186003)(8676002)(2906002)(122000001)(91956017)(8936002)(71200400001)(54906003)(4326008)(2616005)(478600001)(66556008)(38100700002)(66476007)(6506007)(83380400001)(36756003)(76116006)(64756008)(6916009)(66946007)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KhJnkzvgeBiHZS7M8rjIvCP07kyCEKyQWkjhGb1X3CzgnJUHj3wWgmBwCUhq?=
 =?us-ascii?Q?JXuA8GnhJMb+FEGKhLyuSL8UJUQXScWn281RHZ5ty2V3d6ZziY5hwTriIu+n?=
 =?us-ascii?Q?kLZ8Tm+UTl5ua7/RLrEWdJJS38BJRN6KTyCtu1YvS6k8PO8EyoXclXnOfmQK?=
 =?us-ascii?Q?mDmN9yGWG++6GfTXhsVQvWfEMtidHcma6yJIBettyi5dT/bAOPNP8J1WO8X1?=
 =?us-ascii?Q?dmO7VOpaGR/rT3NL1jYzetSpIdZddZegsQkYa+ICFXOiNah/WXlaoFCe8TPk?=
 =?us-ascii?Q?5FUCybGVxuuAIMc5vH5E6c08OZZJEGJN8CJU6Guauo+tHrbwUbxEz9NjQ/4H?=
 =?us-ascii?Q?eIqpl6ONoNZTY3HiTDAvDgSP+Szal188pM9TA1eDpD8c6puhZrCa+VhUc+hv?=
 =?us-ascii?Q?NWzTmPWQVOvZ/GT5xr5nevO20xw+i9LQw1x/JOfivd46KqrexUg3rO955adN?=
 =?us-ascii?Q?1d7qop/q9ZLZwI/93s0GG31ZE5hlpYoaimEIvPO1n5kJvmd96BQCh02pKYPu?=
 =?us-ascii?Q?waoy0gnaJzO/VHeC6TJGIk3DYKmNJs76+qsiIxJ1u/iLsvjQf1ML8Yw7crRX?=
 =?us-ascii?Q?QB47o5tpln+J05tQY8XUDITiU9ioGXTpGc4DUhxINghfg+inwjSHgNl+reLj?=
 =?us-ascii?Q?EdX823/JJfCp6bFtS7vOfpA12MHLL6BDiJ7B+moxWrUPgbst+vU5OnkSxANp?=
 =?us-ascii?Q?oXZnRluL8oJGF82/GsBTu0YaDnoQ/gpGyFv0lXE/7DsI9WxIpNE8KuxeenfX?=
 =?us-ascii?Q?1RjlCGL3gsZ5CoL7uPuQLiSIJowkKuuSS+oUCz6XavtVAeGzl/NDbYpXgBJv?=
 =?us-ascii?Q?h/vBlV6x/cxE3C6JDTMzSBRUeZfi8ZkxwxiklOhO0XfGycjw+eju7BOlzFZe?=
 =?us-ascii?Q?eLOoVUVXweMilT4Zrko09u6GmPK83L0Bzdi5PZHg09KJsp+bPJcBd6c338kp?=
 =?us-ascii?Q?Or/DMvwwof1HagvuE6eUESBHGMcCnrfYNEMqPcYHiL+k9yfsp2PwOSyhbYAt?=
 =?us-ascii?Q?Hu/dQ0K1nTaSBnhgWS1ZbV//+imZVekCzvGPYWORcP8zB9m1wwqpuooBRhKw?=
 =?us-ascii?Q?vvUB8sz6bLNaigFf9Q6OdKxNTLVbaOAMwn2lcfvHnCna46y/VxFIUWCFIOB2?=
 =?us-ascii?Q?SMNQPjJfPY5yT26tvFx1H1B82IlGt6WH7dtcRBSlM0XsF+KL0mftLld6mB0D?=
 =?us-ascii?Q?Zx2F6zShpvvZxBzLXkZvpS0d7c0ES0+9PvgIR6lcVfiNey1O4PiDPwYLBN87?=
 =?us-ascii?Q?KtN7HLAYLJN5C8Nt1pct4VlXXrZQQ9NNBp6SvLKJYZtJ53S+elSL01TOF3Mu?=
 =?us-ascii?Q?9hispajXCdkThKd4EEpKLVTi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B7F6EEC9EE51D64E900FCC0F2747DCC9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cba6e9d-ce3e-4a74-b1d4-08d9460f1521
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 15:01:24.1434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1F74ae8Bpfg0f/tAEyAaWgyI00SbCvtOEWvkJLiS/aVJi8Xg0abIzl9t9JMSe8BHhgoBhUC5xzVYv8rpYIxyaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2968
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10044 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=978 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107130096
X-Proofpoint-ORIG-GUID: vmlvwYzqOGKvW5jx92ZJAFSkEDJo_mac
X-Proofpoint-GUID: vmlvwYzqOGKvW5jx92ZJAFSkEDJo_mac
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 13, 2021, at 10:56 AM, Mel Gorman <mgorman@techsingularity.net> wr=
ote:
>=20
> On Tue, Jul 13, 2021 at 02:21:58PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jul 13, 2021, at 9:56 AM, Mel Gorman <mgorman@techsingularity.net> w=
rote:
>>>=20
>>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>>=20
>>> If the array passed in is already partially populated, we should
>>> return "nr_populated" even failing at preparing arguments stage.
>>>=20
>>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>>> Link: https://lore.kernel.org/r/20210709102855.55058-1-yanfei.xu@windri=
ver.com
>>> ---
>>> mm/page_alloc.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 6ef86f338151..803414ce9264 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -5255,7 +5255,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int p=
referred_nid,
>>> 	gfp &=3D gfp_allowed_mask;
>>> 	alloc_gfp =3D gfp;
>>> 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_=
gfp, &alloc_flags))
>>> -		return 0;
>>> +		return nr_populated;
>>=20
>> Can you restore the hunk in patch 3/4 that changes this "return nr_popul=
ated;"
>> to "goto out;" ?
>>=20
>=20
> I fixed that up in the series I sent out. I applied this patch first
> then reconciled the collision with your patch.

3/4 still needs to change this "return nr_populated;" to "goto out;"
as part of the clean up.


--
Chuck Lever



