Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC8A3F0730
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbhHROza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:55:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64580 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239608AbhHROzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:55:25 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IEoj9h005370;
        Wed, 18 Aug 2021 14:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FemieEzH80bjFLwotT9LRSGaA6/iTyYCtgXolM5485o=;
 b=K+7gPFdfLF+mTCAqvRADC6Wgu6X33rCdMPtpxQ5UK8GdcKA0nuhyvU4uRk+bqvbjRm/y
 /kYY33vQh5gvFVFm7ptuQtAE4p50yfSR00vCg9SBZTVNE8YJvkglV9klM3T2Kk6uk+7L
 1BM9zqe+jqhd1C2ZI/LNSCkyAh/SPei0Spe8VAaE4NR0xdNDcAeq/AckkTuYBJ41/4/u
 wTkZLij5PgBYajN4O37tDXBsILTqpuQDKPjOL86F3JSMQXFe5h06M03Kfmiq+UNN5/2V
 aNZMwUSyxNTyLw5eONNvx6ztVyxPV6qBUJFqFmjqFt8OpSdQLcXAqSmyQv1aRyF6OcAC 5g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FemieEzH80bjFLwotT9LRSGaA6/iTyYCtgXolM5485o=;
 b=dXOQPwFtY2/IG6NlHX9ot5lOTysRzxwEIRlIAPbAnexETmPwoUT1fOT1kcaVoQmEcmPA
 +zjC8jWSVxeqPRHDtxRLN0zZwgkfq4i4IqZBXr/71KZVVEBNjB6UoHxeMnUn6UsyIsa7
 +v8Schkx+ToVtrjJfoeaNM5D57AZhfK05Na164Sh1h0IeNoXHEy6T/KTKBmhtOd3VELj
 jUFDYlJz6ESdoieNHOI+ubUdGJFH2bQl8g/84kpIUyoWttaxG/H9B7uuJAS5tdIdr8wJ
 7bvnaCzdqAN/213gEW2oix6jkj4MwJ7ub+JjVcQ8Jt+i+9SSqWkImtx4N3PYvCN7mXBF Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmgr9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 14:54:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17IEp02b092592;
        Wed, 18 Aug 2021 14:54:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3030.oracle.com with ESMTP id 3ae3vhm3p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 14:54:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZtiDlIlh3BUpowfT5nlcQfcFzmjjepB0wXVYOX3hS/K27YDgZe+lx9p4ljOCNQx8TnBMdWooJ/knjUiVEoeMmFEhs/Zlmns7mig0ksYyHB3zG/tQc0IxYyKDLZHXMGUX1lS2E7ZPLyP1c93wjH3vAxtLVAK5Nc1n6Iav0nDKTw+Q69hhXMwXUp83KcIYpsD70dfuF32eTzReqibUIxvQ3kRNVsYVYIbtQJclVBOKXMDhJgrIoEc7RXBm7/BUxtRqprqFDW2F/8ze8SEeIIlX2nVEtPr8IsfC7MO9rYcFhGBDVElauNCDb1x7i++08fZMwlKyhmZ2CWcURtNOg9LhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FemieEzH80bjFLwotT9LRSGaA6/iTyYCtgXolM5485o=;
 b=mEu99qytx5SaMFcNSy3f1xU08hsxazZwzXDMLdBDmXlgLjpycK/TzfmhV8vTEMsspQPJ6LOLB7TEhRqhad6DgYTxZAe4pHQPW9W509bnG1T5eFepnbH6EVKkM4w6LIrAwT74AcjBjEsv1edX90yprJJFbGf/VMFEjjepgXBcrYH/TgRoJVHRW1Vha7m0WuzQXPHu5F2PxIOwQX8HxI9xCIKnnLoNYyqTLRdFWHq7024FcII2VwIG50PXa0Sn1aAM2NGKh7nC1+nqFxS6FQvrcIjEM0glKxRpDdvnNOJdicfDpXzKoCs+Pmyq9NQ9gbNZ+DU+9RsRz4srN2LHzbLMvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FemieEzH80bjFLwotT9LRSGaA6/iTyYCtgXolM5485o=;
 b=PyvDNm1DLXUB/TxGUKk8As7ps+XSFmPAEleAGGDWF/7VG2WPlC3S0dGWmAda3Dh0gpwRX0Vnoo8r9JX/a5+8gFFd9debL/QWTc3qNFJeiL75YbekbCFhLjQcmXJw2+IiVCWuixy+ly5PZyerDeNxUjo9nUZwK/P1PULjpk3o9bU=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DS7PR10MB5325.namprd10.prod.outlook.com (2603:10b6:5:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 14:54:30 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4436.019; Wed, 18 Aug 2021
 14:54:29 +0000
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
Thread-Index: AQHXk38k0JUHaKd/aEyW/GzwRyUQFat48TIAgABpqQA=
Date:   Wed, 18 Aug 2021 14:54:29 +0000
Message-ID: <20210818145420.hoieffhzxnxc64qr@revolver>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
 <20210818083610.3698-1-hdanton@sina.com>
In-Reply-To: <20210818083610.3698-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de5e0740-536c-42f0-4ff2-08d962581510
x-ms-traffictypediagnostic: DS7PR10MB5325:
x-microsoft-antispam-prvs: <DS7PR10MB53253C112DEDF1058C54FB2EFDFF9@DS7PR10MB5325.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+ILZrjZczvz8FMrxWZ3RMK8sThU71RaTn1OxwEpPNAllrUtIAipKq8cDKgJE3UYioYzyMHBBsdMw+xiQ5J/6jHclchWop/DUwpfyKj5Tb56G7ma629Z0krOUSUtjIDOWdFceNSy/Z7JR4vdnnis/Gqc3menEgChproui9+PQzOmhd/c8pJaSOfU/SCW6Mh0AoM9FDXSG95pqVDm9GZBYrYdJOHH32MO4UBkgJ5Fujzzn8BTJUh9i4cMLOSmn/Eiqc3dnkYOKxbhn86HuSrRG/2VjyQatdbul2Ce+wrS8Ssz6XUuDTa0exgzj4/D8CeCLcnitqK2zb7F9vj4dAlMsqF6he49mp4BTAPJKsca7dS5ADmm71H/ImjDxkXbKOnkb9j7fKtA8gzu5hTy0neuZaK8VOABsEKMb0YDk8FgmSZfINDWzrVGAROVp8Qhnyq13Tczfc4/RKTIA0RKS4Yx8pstYd7ZQHLJGvTGcBPj8Y7XUtzyZK3BXtTYwp76v1aMg0oaJYaZg0T/83G2uLGahgDA4axryjSD4EQTtSiXprDN/1KuPR0eA3kJA1Qjc/8pimpQW/67cmM8YT5YJgcM1VFHNi0L7nA1j1be7jMAftdVHNv2MdnWkV6BBdG/akypMhUN5qx1EgB/8cCCEw06ErCABK6m1BJxoGiPzPtRww3SdqLiHaj7ySMlB3kOny/eTiUypEMcGIGsm/Lua6/kgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(346002)(136003)(366004)(39860400002)(396003)(66476007)(91956017)(66446008)(26005)(64756008)(66946007)(76116006)(6512007)(71200400001)(33716001)(66556008)(9686003)(6486002)(2906002)(86362001)(8676002)(186003)(6506007)(38070700005)(122000001)(6916009)(38100700002)(54906003)(1076003)(316002)(5660300002)(4326008)(44832011)(8936002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+zZKAgtDr/66wRXAfUReFV4tAyl7kGAMTx2z6Mm/ahPj9fGp1FJOkp/082MR?=
 =?us-ascii?Q?ov2K8DOKf7mdv5UxUNuIAGLqS0dbbKttR/7r/y6Irby/1S9HjIpZcNZiyQaI?=
 =?us-ascii?Q?UkKE4s1AXUGJmg2E1MaoGzWbyZenYWX40u7CPt56vkdRRlHCVdmzp/CK+J/N?=
 =?us-ascii?Q?qpcsPfwPP3tqe19wPMWMKFCLs8wNp3lZKcBCGA6diq392Niouyimlz7enpkd?=
 =?us-ascii?Q?ntFhVVLx81Lirsvl5zBnc5pnRiC3Qog0VH5UPS9XsyI40ajN3F6IuI0r1p5b?=
 =?us-ascii?Q?zH1IuL218+MU+UqCGWKJY7Sa2Tpwy/SR4t/w1+tTOpan0tkzfzcUGEE82S2A?=
 =?us-ascii?Q?6z3EICHZ4ouyKr7ZENnQwf/s41UCVRjTBd2cxEyHN5/25rfXKRM/5/0p9+7Y?=
 =?us-ascii?Q?S/CwfjCMu7ZZOQk20Sulc3nWhB3pIX5mb8eEZOH2FZYuLECx+EhvN/41WkBv?=
 =?us-ascii?Q?rFtY8UFtzbkwDK6V8uAW4zoDo2UPtV18OXvG9a8gQ9fwdDMMpvHRSs/HyEB7?=
 =?us-ascii?Q?VhbFaa3hAlSsPzOCfn2hIbpc1OIgitbFb4+/0Ur7aUWvwoCa7h9WyRGibtTg?=
 =?us-ascii?Q?EzUPBbBaOuqcXzJkeH3bsyu4PeQJGezpmGGTlCcUMiEHE8DVM/MhP+K/f4A9?=
 =?us-ascii?Q?AlWy3ENJfCMxjfkhlfOTg5OWrnoDb3xjBXdejwqqzGXF6EoAZOmKwnzPx4mK?=
 =?us-ascii?Q?mVw+ZR8M0FPw9oF7VMMx4ND4C5twnzFq28tEkhyHnEJxJRS6IKZzQhQZfvd8?=
 =?us-ascii?Q?hM947sW/PWnLoJGOEZ+FdU8oxkMs//JAgbhW4P2ZnCkdh55OLWPp1G/rLt50?=
 =?us-ascii?Q?B3ss62rUmCb95w6EV83N/A97jrRVw7zjt1E5Grfg37nfJjXKUCBrcI+ayi3E?=
 =?us-ascii?Q?y/tLzn4dcdK1xwESobaWN5K4015O83AKbikYMXiE9cZR4lMw7yQZFfcif3hB?=
 =?us-ascii?Q?a3BUCwCHKBqoJIsa/1YocYMmxFHlKSJBFQITEC4EF9XNoYFxpSIL6QxTnQ7p?=
 =?us-ascii?Q?iSoZpDy1/TK9RRkrUs228HjbHypUskh5CoyNPe9vVLqEmT6v8onwz76maaGS?=
 =?us-ascii?Q?jd0gYC/rpI7qSlWpJxMQ7PhEYmvvUyaLk650RRKdVfmP8+GAxKH6NU0pnte4?=
 =?us-ascii?Q?U9Vei0LNg/5MZBIKYnKH5ouB+FGAA4STUbCEyajBEgS4+RiGBykrHTy+6ywp?=
 =?us-ascii?Q?LxiE6TmDqZ0rHHlygabfI+yPEJLtoHninOudC+UiuIYtxRuEsPnq6RLvCdCU?=
 =?us-ascii?Q?gQiW13shaaiQbkNA6bkMJA5uuz9DQjp9o1G8kOWFy+7+mYD3DWQSJmCayEzq?=
 =?us-ascii?Q?8eVeuHWJMPxSawCRX10OkwFz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9337B047A52BAA439B57C41E5A2E1E40@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5e0740-536c-42f0-4ff2-08d962581510
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 14:54:29.8864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kl6a9/jgkSjJT+AGxaqgL3vUoqNgom9mlfXG8fcsTI1MCquotTAqKy3NMsPMJrK5KvNzf7di+gTSmlV8tGN5HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5325
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=974 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180093
X-Proofpoint-ORIG-GUID: f-Rw2x993WQJYTGTDRBz0trgU8Cj0st5
X-Proofpoint-GUID: f-Rw2x993WQJYTGTDRBz0trgU8Cj0st5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hillf Danton <hdanton@sina.com> [210818 04:36]:
> On Tue, 17 Aug 2021 15:47:11 +0000 Liam R. Howlett wrote:
> >=20
> >  static inline void mmget(struct mm_struct *mm)
> >  {
> > +	mt_set_in_rcu(&mm->mm_mt);
> >  	atomic_inc(&mm->mm_users);
> >  }
> >=20
> >  static inline bool mmget_not_zero(struct mm_struct *mm)
> >  {
> > +	/*
> > +	 * There is a race below during task tear down that can cause the map=
le
> > +	 * tree to enter rcu mode with only a single user.  If this race
> > +	 * happens, the result would be that the maple tree nodes would remai=
n
> > +	 * active for an extra RCU read cycle.
> > +	 */
> > +	mt_set_in_rcu(&mm->mm_mt);
> >  	return atomic_inc_not_zero(&mm->mm_users);
> >  }
>=20
> Nit, leave the mm with zero refcount intact.
>=20
>  	if (atomic_inc_not_zero(&mm->mm_users)) {
> 		mt_set_in_rcu(&mm->mm_mt);
> 		return true;
> 	}
> 	return false;

Thanks for looking at this.

I thought about that, but came up with the following scenario:

thread 1	thread 2
mmget(mm)
		mmget_not_zero() enter..
		atomic_inc_not_zero(&mm->mm_users)
mmput(mm)
		mt_set_in_rcu(&mm->mm_mt);
		return true;


So I think the above does not remove the race, but does add instructions
to each call to mmget_not_zero().  I thought the race of having nodes
sitting around for an rcu read cycle was worth the trade off.

Cheers,
Liam=
