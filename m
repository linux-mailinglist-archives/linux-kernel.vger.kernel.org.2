Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F415D3CC010
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 02:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhGQA0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 20:26:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31426 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229462AbhGQA0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 20:26:20 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16H0C97I017344;
        Sat, 17 Jul 2021 00:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=T+Odcxaqb1NP4Gi4PYyEfsFwd9Oebn9CvrlIOgayHkQ=;
 b=CHiUTFgafwIskIVT3+Jw2k2a+64albZU8SSm9egkPaD6MJfaHoAC9fmeO7rVDSZCHA+L
 Zpw5ARwJWOs1YycVocYzI2x8cY8hcX27Rs+eSv2UB72OO/HmhhK6VN+WMuheCXIkt38O
 4fx09WD7Q+x2ec3Hu3sg3++0003J/NGlQpNXjm0GT3f83KDGKMDSiYHVWZhmPar+Irff
 8fUA2T5LCj5HSIJnaXLqf+Btr4mmc3oRo3Io140DqtXK2hhZH0Jsl0lJ0iO39gQ2DM/m
 io2uPZ9KijrPrwrAjGyd2+Ir8/YiL0UeHg1pUFB+LGe0ggtifdC4uBrsXXmQCLQaF3Ii YA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=T+Odcxaqb1NP4Gi4PYyEfsFwd9Oebn9CvrlIOgayHkQ=;
 b=hQtk1tZszyh84FKykcz6vrVPUnEYF41uO9vWhEaDZui+xSX7fvrLYAXHM6dg7H8YXbYK
 xL2IxM+juNOstjVOD5uHUFjgXJ56je/Zo2X7UQ+UMaTUjC2FQAYJNl1w5w6Zki3tIqot
 ON6Gpp1DqMfO1k6arBWtUAW5V2+2wdUGf95peVm71iv6FCRFU7gGZ38wUI4aWjITJdFU
 0wfjx1Q89tzm9pXTShJCi5ZEYaot9ZfCY3tS6hwqriy/Ua3nKF3BBITcZ+r9cLzxoRA3
 +luigjeMdCUGW31rbwezW+8bsvxRhg++mtvrlZ3ZxdyuT+SwtfAi65o79AxZEyEQf6dp Dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39tw3ptdhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Jul 2021 00:22:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16H0ADjQ098613;
        Sat, 17 Jul 2021 00:22:55 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by userp3030.oracle.com with ESMTP id 39umarrv9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Jul 2021 00:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNSNt/qkUAXnAFuDZT7mbEbopuUUBdGFGSgPDsq+ji2t8VZ5dAcilMkq4x70IVvcmNBAvpfZfN6Z/JYv22erBEdIrkFKAkNKl+NSovhhdecZ6VTkFwO+lNUvHEo2MFo/iwSp+yOvrx7F2gmEIXgHO8/W61U8v9rAwwsWE4GK8Dxszb9JfdQgxQwiCPRboeMYC8Sm8gJd1hPRegKv6fyfHgQjYdiBejckdL7UYFxRyFqE76m+chXeiY/krTKMANLmRhzMOXHd44y5B17ltTIxWjpWOd6P2Git+k/m2Yx/MaO4PdnneGhltioQCEa7DXTNNDmoYnL0fhKViwvjzTN86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+Odcxaqb1NP4Gi4PYyEfsFwd9Oebn9CvrlIOgayHkQ=;
 b=kT0jMwM5rVWdQQullJcjgQnDLd8HTypkikBH1Q/aaT2KjC2kosXM5kIM86KMPgfPi7bL8trXl9F6R0hAK1An1iQF/CpBnIxhXR+NdmU2uERZtvUIneGjgcEnmHMIimvGj6m8Yw1AmJy7Mb7WVcesVRTP6DbWzWhfD3q08Mt3zbX8A1EfzYYEe5CODvP1fi2vQkutuESjK9pSY3YBJXG5b1BlqEnDejAKV6kFlHSuswD0ciVYllVYZEYV+XxrPpES8Io2UtuP85HL9E/XhMlZKMqpMEeqfLoXQocmta970vYqpjpQknuWE82JIFV6lUDHvXtos4svnRV9rkyQUJc36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+Odcxaqb1NP4Gi4PYyEfsFwd9Oebn9CvrlIOgayHkQ=;
 b=hXdte4z7LdsHOYwbYftb8/aobgU/VqyXWT4BfnMLhVRfu7ER3E7Q+oq5GqY+0H+q3do9YMmu5TgO+qlAraC+TdXIbVc1i+Bmr4PxSoyuD5Ew33JrHqGwYrmiP6RMgerCQZ5xOx54YGGL4erbUyp2vs+qNS6H+YgXCnUj1Iq9XOM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (20.182.114.216) by
 SJ0PR10MB5470.namprd10.prod.outlook.com (20.183.93.198) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Sat, 17 Jul 2021 00:22:52 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4331.029; Sat, 17 Jul 2021
 00:22:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] tracing: histogram fix and take 2 on the
 __string_len() marcros
Thread-Topic: [GIT PULL] tracing: histogram fix and take 2 on the
 __string_len() marcros
Thread-Index: AQHXeeYCjeFzOpspFUa2lky1xLSwtatF6D4AgAAHHICAAAJ6gIAAKoGAgAAzoIA=
Date:   Sat, 17 Jul 2021 00:22:52 +0000
Message-ID: <26A9CF5A-0724-4D4B-BC59-09849EC33326@oracle.com>
References: <20210715215753.4a314e97@rorschach.local.home>
 <CAHk-=wiWdG6jqKhdU62b06-DtESVxHVK8MA23iV+6fB5hnGEAw@mail.gmail.com>
 <20210716143705.56001390@oasis.local.home>
 <CAHk-=wjWosrcv2=6m-=YgXRKev=5cnCg-1EhqDpbRXT5z6eQmg@mail.gmail.com>
 <20210716171805.55aed9de@oasis.local.home>
In-Reply-To: <20210716171805.55aed9de@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc742efd-86d1-4c1a-9529-08d948b903eb
x-ms-traffictypediagnostic: SJ0PR10MB5470:
x-microsoft-antispam-prvs: <SJ0PR10MB547014DBEAFA2D838DC304EC93109@SJ0PR10MB5470.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZukRKG/N88KdWZr7IzaTDJDzwXuOBrGUeQgPPLsIBLzESUm/QSO/r3i86e7Ei8lsxSZga1j0AU25dX5hUO8vIqzTts7UizDp9qNay1iFXf0J0TTCb7aFnasDPg3jZY8SWIry6gc83w1qMZYtz0x2ErkxQqS3S2WSgshWymPJjChwGbYXZVKFyLXDNhu+ViJruTuTPgL2WHf3G2R9p5IUFZp2v40iDWez+Osb4kNeBHjhsUqp9P9s7MevAC0dpy844RhKz5gGU74EfnbED8loFtrr9GlR9oqO6ZZkml7RiqShpQTvMPVRgYBRvemlb6jJB5X5Z8nMFg/w6UkwvQRdzFJ74wwIqr4tzJO5sX/ZQ30CYv6lP/Bb+WuP2djwwUp12TW006CntgoYPyleBzMjuyaUoo+CiFKteda/QUejz56Q6aVkXN4bgN5sLAp7f5uxgRg5bxOwBkN6Xmp7iafXpnOFSaB/PcF3kZBg43d473yGmpgAZfjYKGd9coa/2AK8v/tayE5IuoqqchIcdwLc6OBdnEaJ/Fz1QEEDbCvHRQrPAczlB5phvaoGTN5dt9h9c1wX/zSdUWhZ86+kYYD1CRAmtyA6aaaBgK1dC8E0kXeYrvjbDFpeb6rmLWFf/DrOG9GPDi85odb9NTmrVdDpNEPRVG00imWna3y7xnooBamNQUIYgqlahDk+2ZbNiEPYjSpFl94PtHpNM89B066uZFy4131dB8CHskcOE7j8UWT+7KFUAzV0N6aVPIsu6Yhc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(39860400002)(396003)(346002)(38100700002)(186003)(86362001)(33656002)(122000001)(6506007)(53546011)(54906003)(26005)(83380400001)(2616005)(8936002)(4326008)(66476007)(66946007)(66556008)(91956017)(6486002)(64756008)(66446008)(478600001)(76116006)(6916009)(316002)(71200400001)(36756003)(8676002)(6512007)(5660300002)(2906002)(45980500001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dtFUBjIf4Fpnis49qt4XZs68iWuL/7ufqGxxo4tuka+mxf/4bH4XKuLpy1HI?=
 =?us-ascii?Q?qnAZjPY6/h6omN8SuwrkIiaKOpq+dVhOUKzxccbUrpSDFhK7hcB0ytFPXlT2?=
 =?us-ascii?Q?eCAAgFpBua3fmrJfkxk0tVePkUDMspzYPvWeGUxkCJ7OZ7HBWA+Mql1THzYs?=
 =?us-ascii?Q?PqpUvekUZl5Oz1lMc9HuWnaJFKdlaj+q5pEN78HFu24BwwBZp8WF13E7Fstv?=
 =?us-ascii?Q?RulXCP1/7rm41TQo9veAyTSPqUdqoOhA8s3GeZwR3H7QcEUNPXumWG92N97A?=
 =?us-ascii?Q?DpFLrAKDKauz+Y5/DLwnxYovyyd9bxbQ9CkJraSLkGb7L7KsotJ5LeiMAde7?=
 =?us-ascii?Q?pBnKpAouu59/7rIV46Z0BiktsUBcdMvp3DHJgDFwxUBqO2Bl7G77nrFzGw37?=
 =?us-ascii?Q?VMXW0nMJjvvhGnWnBZ8ofp7Zqgd0pXGNeVdFB9L/zZeA5SnGpProZsQ/tAr6?=
 =?us-ascii?Q?4RrW7jjrT9EKSPgfkpCSX7H2NuaEhZ9SaP0VaPXcXjevBBhA2y03RnAmmfre?=
 =?us-ascii?Q?ls64ZukZQmZrOSmE0saUU1w4KWpnk4clJUP8JD2wQWyhBGOx5Mmujb17cKRu?=
 =?us-ascii?Q?61/swOkKPSfGbjvIC3RDgt26LeBoZByVrn1YppqZF3hO/PUPhU/vaKPzpjVK?=
 =?us-ascii?Q?nBk1auu7W+HJll9z+06+piopFYj1GQQPb5fUW7cKFwg7zDGNsDDR971E9AeF?=
 =?us-ascii?Q?Ry8hpe4A997G0wWBmXhgEpZMIgWq323aOWsPp9SGsnnSEiBEVqPh1m0qPZxN?=
 =?us-ascii?Q?tf5M760un3bC2ored9JB9U9dU09qTDF/GmyzMy/zPgsqEWb5oXVmUrLolZNY?=
 =?us-ascii?Q?fhy3TLDte/tHB10UDofWsMbGsRu3XURgurCK3OP0D7FIcOwPyuLQ9h1c3Bh9?=
 =?us-ascii?Q?Mn4Kgc0FHJvlGfko80OjLOsmzSx6GKNNG5lWJzdRgMIGDNDC+7m7bPBjXpo5?=
 =?us-ascii?Q?FJfCYFnKqxELXuttAASBNF02JxLqLLqgpas6oPy9Mgp8eGqUcR7G/RChxuNA?=
 =?us-ascii?Q?g+8XS4QykMWM4AC3+FFeXrAIFrVe1TNriB7RJlveSABvURcU4XOlwAyu7j4+?=
 =?us-ascii?Q?WncIeMWYnhO/9dw+bNmSNFSL0f4RI/l8/JKgQDc5fRkRiZ7/ImT14VrY6ySu?=
 =?us-ascii?Q?qDX/dfCSVvVqIB7yjMDNhOHVFwWqv8yBOZZ5czywJKJIXk0ZtVfgE7pUnG23?=
 =?us-ascii?Q?I+EUU1NcLwyJFggRTSmuRJDVDgIXqqLuFu/NFbr2Y8uxxzL0qGtxijabRPTB?=
 =?us-ascii?Q?1dkcW3LmIFqwJY3Xxyt7zxHJuC4jDFEXRbKuwjhprGcsHiAusLr+1GGUg8Xn?=
 =?us-ascii?Q?7ggiKQeGlMpAb39NGrsj3Lgk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CFAD4E887295974B838D60FA128C286A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc742efd-86d1-4c1a-9529-08d948b903eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2021 00:22:52.0919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQNrv1V4dck0WOpzcmJRWT05FPFbJYibPrrB4fy0joib38LjEhNczK/Xm3tZTr3UCeCfQMfpe1nG7YHPvS6jcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5470
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10047 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107160155
X-Proofpoint-GUID: VEms9R6CBNBQybq3HLDPwNRaVohXoedW
X-Proofpoint-ORIG-GUID: VEms9R6CBNBQybq3HLDPwNRaVohXoedW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 16, 2021, at 5:18 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Fri, 16 Jul 2021 11:45:57 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>=20
>> On Fri, Jul 16, 2021 at 11:37 AM Steven Rostedt <rostedt@goodmis.org> wr=
ote:
>>>=20
>>>=20
>>> So how do you want this implemented?
>>>=20
>>> #define __assign_str_len(dst, src, len)                                =
 \
>>>        do {                                                            =
\
>>>                strscpy(__get_str(dst), (src) ? (const char *)(src) : "(=
null)", len); \
>>>                __get_str(dst)[len] =3D '\0';
>>=20
>> What? That "__get_str(dst)[len] =3D '\0';" is pointless and wrong.
>=20
> I wrote up explanations to all this, and when I finally went to show an
> example of where this would be used, I found a major bug, that
> questions whether this is needed or not.
>=20
> Chuck, WTH!
>=20
> This feature was going to be used by Chuck, because he said he had string=
s
> that had to be saved that did not have terminating nul bytes.
>=20
> For example, he has:
>=20
> fs/nfsd/trace.h:
>=20
>> DECLARE_EVENT_CLASS(nfsd_clid_class,
>> 	TP_PROTO(const struct nfsd_net *nn,
>> 		 unsigned int namelen,
>> 		 const unsigned char *namedata),
>> 	TP_ARGS(nn, namelen, namedata),
>=20
> Above, namedata supposedly has no terminating '\0' byte,
> and namelen is the number of characters in namedata.
>=20
>> 	TP_STRUCT__entry(
>> 		__field(unsigned long long, boot_time)
>> 		__field(unsigned int, namelen)
>> 		__dynamic_array(unsigned char,  name, namelen)
>=20
> __dynamic_array() allocates __entry->name on the ring buffer of namelen
> bytes.
>=20
> Where my patch would add instead:
>=20
> 		__string(name, namelen)

You mean

                 __string_len(name, namelen)


> Which would allocate __entry->name on the ring buffer with "namelen" + 1
> bytes.
>=20
>=20
>> 	),
>> 	TP_fast_assign(
>> 		__entry->boot_time =3D nn->boot_time;
>> 		__entry->namelen =3D namelen;
>> 		memcpy(__get_dynamic_array(name), namedata, namelen);
>=20
> The above is basically the open coded version of my __assign_str_len(),
> where we could use.
>=20
> 		__assign_str_len(name, namedata, namelen);
>=20
> instead.
>=20
>> 	),
>> 	TP_printk("boot_time=3D%16llx nfs4_clientid=3D%.*s",
>> 		__entry->boot_time, __entry->namelen, __get_str(name))
>> )
>=20
>=20
> With my helpers, Chuck would no longer need this "%.*s", and pass in
> __entry->namelen, because, the __assign_str_len() would have added the
> '\0' terminating byte,  and "%s" would be sufficient.

Exactly, I would still like to do this. I've been waiting
for two months for the __string_len() macros to land.


> But this isn't the example I original used. The example I was going to
> use questions Chuck's use case, and was this:
>=20
>> TRACE_EVENT(nfsd_dirent,
>> 	TP_PROTO(struct svc_fh *fhp,
>> 		 u64 ino,
>> 		 const char *name,
>> 		 int namlen),
>> 	TP_ARGS(fhp, ino, name, namlen),
>> 	TP_STRUCT__entry(
>> 		__field(u32, fh_hash)
>> 		__field(u64, ino)
>> 		__field(int, len)
>> 		__dynamic_array(unsigned char, name, namlen)
>> 	),
>> 	TP_fast_assign(
>> 		__entry->fh_hash =3D fhp ? knfsd_fh_hash(&fhp->fh_handle) : 0;
>> 		__entry->ino =3D ino;
>> 		__entry->len =3D namlen;
>> 		memcpy(__get_str(name), name, namlen);
>=20
> Everything up to here is the same as above, but then there's ...
>=20
>> 		__assign_str(name, name);
>=20
> WTH! Chuck, do you know the above expands to:
>=20
> 	strcpy(__get_str(name), (name) ? (const char *)(name) : "(null)");
>=20
> If "name" does not have a terminating '\0' byte, this would crash hard.

Yes, it does crash hard. That's why I sent this fix:

7b08cf62b123 ("NFSD: Prevent a possible oops in the nfs_dirent() tracepoint=
")

Which is now in v5.14-rc1 (and should be picked soon up by
automation for backport). I intended to fix nfs_dirent to use
__string_len() and friends, but you decided to delay adding
these new macros, and I had to send the above fix instead.


> Even if it did have that byte, the __dynamic_array() above only
> allocated "namelen" bytes, and that did not include the terminating
> byte, which means you are guaranteed to overflow.
>=20
> It may not have crashed for you if name is nul terminated, because the
> ring buffer rounds up to 4 byte alignment,  and you may have had some
> extra bytes to use at the end of the event allocation.
>=20
> But this makes me question if name is really not terminated, and is
> this patch actually necessary.

Yes, it is necessary to finish this work.


>> 	),
>> 	TP_printk("fh_hash=3D0x%08x ino=3D%llu name=3D%.*s",
>> 		__entry->fh_hash, __entry->ino,
>> 		__entry->len, __get_str(name))
>> )
>=20
> I'm dropping this patch for now,

Please don't drop it. I'm sure these two are not the only uses
for a proper __string_len(). The point of this exercise is to
provide helpers that do all of this manipulation correctly so
that others don't have to take the chance of getting it wrong.


> and will send another pull request with just the histogram bug fix.
>=20
> Thanks,
>=20
> -- Steve

--
Chuck Lever



