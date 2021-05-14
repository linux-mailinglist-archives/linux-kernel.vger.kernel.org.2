Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A26B3811F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhENUqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:46:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12076 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhENUqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:46:31 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EKiAZf010935;
        Fri, 14 May 2021 20:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=x9cisE4H+/8hJMX3DqYtftDvvUg/4LnUXaz1vn29n3I=;
 b=HcNqJl2a+f0ACnWQILdIlhCnLHkAygw61LavpcoM22p+du3/ZATlcsh/KO2sTkdfhijr
 QYQquaGrTIaQv7FvLs+tTAqovWyOjb9mRfCe/v+q+yzAtigqK0CoJM3tQeaqGkrkRjHu
 OxQCpAyQF3jwlpOrlMl1gfmfownWAhD70alr7f278fkZAgSU0+B7Jh7IDiWDR7Z1WwpU
 hiDO1104fHoNmlS6M02JvYBDCX4W8Lk/qGjCyxMpciYg6fptyI6JloT3VkPfNGSN3L/m
 v3BIOllVGW3VY27B6PDPT1O1lW9tGeiKfOVIzTyXUqyNpQ76XcPIHOGemfTug/H6fW/+ gg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gppjgubb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:45:05 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14EKj4Yj167110;
        Fri, 14 May 2021 20:45:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3020.oracle.com with ESMTP id 38gpphhqsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:45:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxkR71YVvrZgZ/Nf+X2zjZtHV7xcKflEgVI6++yC1TxEn38okjmeNTPuC1crb//b1jvjvAwpAyK9bdLOaOcSVWTZXUC95DQBul6JDDXewmgTgAkb40K+w9n2fJ9nVnpgFzW91iJU/GTqzRY0RCYBn8aQz1oh9yu9DkR8mRehh4kdgx4COq1wxkbYhbPuZb+CASpwyhnTdyAlUXMmJY2GIWGdPC9sYYsLFx2UDkJzSNlgxBG+eMiVVlq7MsQ1a5Cj5uI+qQnGSUo8BjFSiMNqEE8Vj6apjxLJLIF81UjK+W3lB9ncqKVQmrPI+1CG/0rliBp1mFx7147PWPyXx5cvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9cisE4H+/8hJMX3DqYtftDvvUg/4LnUXaz1vn29n3I=;
 b=IbizMa8/t6HdTf3lT8Na08YgHQ16TaSGyNdGLFwjpxjN6Io5lm9MBCZDW3bk9iIQFCpR7A8WTxllQU5J9b8mhk3ZGyY61tkg/1v5VG+ajwPhn6W9mR+/O3Y5RJweAyKgDOytTvA655Eb7IIFLW/itQfKOk6ek+SEaDKwEV7J47XzZFFml9WJAtGbd1zzGxa1EQ2Mft5OZ+pih0b7FfU8wfM9E2NIz0mwi2UEcl1Pce+hq6GusS2cufPRbgXPKZwtPchlb3XcUCxBgQBiOrF+d5eHci5WN4/86eIWYmsW05wr/upsmuHymJAucywxQzrSdmUkMv79rrROSyR+7eyE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9cisE4H+/8hJMX3DqYtftDvvUg/4LnUXaz1vn29n3I=;
 b=jE34V9j6JzU5ByXzFx7suRTCj5GzeqErsuHZyv/6769jYi5Y3bzhY29WeNETBXe8KKDRf5bKy4kFQK4tYaFW7+qd7mi5hjSYTSHoKbK0GrY6r/Bnq5tISoMbiQa7FEACUuPjQR074v7lsT65ztVvu2GLyN4tIYt+C7LXo6rLhic=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR1001MB2192.namprd10.prod.outlook.com (2603:10b6:301:35::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 20:45:00 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 20:45:00 +0000
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
Thread-Index: AQHXPEQyRs1g/Qku7UiibZzqyyuzcari5x2AgACkWwA=
Date:   Fri, 14 May 2021 20:45:00 +0000
Message-ID: <20210514204440.ofwxmcdm6nrmur6m@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
 <YJ5Xa/4ZFEgfdsOY@hirez.programming.kicks-ass.net>
In-Reply-To: <YJ5Xa/4ZFEgfdsOY@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d6c4dfe-92d9-441f-e29e-08d917192486
x-ms-traffictypediagnostic: MWHPR1001MB2192:
x-microsoft-antispam-prvs: <MWHPR1001MB2192D4FC0432892EB9E5E279FD509@MWHPR1001MB2192.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qA/Lh3wNfg3OZrMREpj1zhGFD6b7nOJESmdI2mreHBJ7cjtaJoK3Y8TLeRpf5HGYDP0qNdSkhK52wk3ok2ZSDvoUpRBUDKuepzAjWCFClKoS65lGJa75SXW4oXwfGj3oBldTILWggTR5E5IsNyILrztUgNFWvFHvthxIbvJF+SLMkcmPRGxqe7gnBoRYQqGL2oRACh6ZC+vePQmBgVVgyWxoHCtpDnazwzdkalXjiJhPXreYMrPc/MtFw6U3XQZ7ZvBBcYEZUunvg5Y0OBCLDBzY8TqYTmhsKk1h/r+H1Ui0wEFPsFUGpD22utYx4tOYoCBNbu2z7w1qxHWI3PKbud3qxM7RbGl/xak61/H0XlG6GogeyKvXTkd3dGtkyuF/GW3QZ0/2T9PsaikVjV85CfpfFCx+USALB3Y/hlmYn7Ocr3MXEc2WuphElssl9sfAEAuJieQA42wRvnPxpRHheBfSM303ELujsrF3lP+hv2WhS5SYOGh4Vd8eutsKG+i2UM6PMLJIXTk/47+QN+BSXiRcSsApQ0Rsv8ZfbUuo/zbCHTk684daT9BskxL8Rx4gwF6p97qVxT64mToGLiWjGET5LtKboi8wmLitZCxrfac=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(366004)(39860400002)(136003)(346002)(376002)(316002)(38100700002)(122000001)(6916009)(1076003)(6512007)(9686003)(83380400001)(66556008)(44832011)(64756008)(66476007)(54906003)(2906002)(478600001)(33716001)(8936002)(71200400001)(76116006)(5660300002)(86362001)(8676002)(7416002)(4326008)(6486002)(66446008)(186003)(66946007)(6506007)(26005)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ONLD6YCzhaLLWcYuCbpOzMiaO8qpk02z39lN5kob48XpDoKGoFAuFJ4OPKx3?=
 =?us-ascii?Q?c86X09YbF1WtlBB60Rcxte9UCkEt3fnP0Pi1EzvSq8nxpX5/DGARb2WCOavQ?=
 =?us-ascii?Q?rkLUQzg8FDkyzWSDXyZiY4ei+E/x00SFWSTcAuRmEjlyoKuPbTPQEHCUPsC2?=
 =?us-ascii?Q?tg/N1mMp/L91KzmNfS3us1WrmKeCPMaCeSbDOOg4yt657RwY8kPkJicsIwpl?=
 =?us-ascii?Q?qfJ8FV0uOxhUFqVF3buhioiY+QX5agWHNcIensyWY+qcqekYDjg2xcoTAI96?=
 =?us-ascii?Q?knpLQQhHHlVrQrylMOHrIZUAyCUKBFuxpRMcIG8Nvg5TtyEIaQWCt921ZwbS?=
 =?us-ascii?Q?LYiX4/X2b9P4eZjMxwZ+Z1bsbeQoyTk11u77c1mpRSfokKsVuOW8Gz32Uc+u?=
 =?us-ascii?Q?Bfb9zLo36MIN/4HRApqIsAAaaLfm1wz8wGaxYJLhpPfvRlQFTuotNNx3vk2D?=
 =?us-ascii?Q?lIOaagT40H5aw36FZVuuQscn4ynr3AcLYXNJmim+u+KSBESNL8PrjzxTFB+k?=
 =?us-ascii?Q?Y9yftu9rxdRoCzut/hDkRbo1OxO3B02oJtaPR7+CXoAzQ6/NDczlXKL118Rq?=
 =?us-ascii?Q?L9Qui77cWEv6UVTmC7ijaN1wwQFSD3PCbP1KSoJXbTSg52wMEdYH0Md+a4j/?=
 =?us-ascii?Q?wGIbeBUeX1cOHUdTUHUrVxi7SzWi6J8cAMyxv156p1yb2i2ssX8TErv25bwo?=
 =?us-ascii?Q?WR4Y+ngKjSsoZVDvzal9d7ftUu9QvBUBqrl+nQAt71wX6i5WKyrUcWEIaCmp?=
 =?us-ascii?Q?w0gjs5Hj0wB+6juBF0KsnCA5Fktqq64DfWeYuAWt+qf/OovQoH7aM24l6yPc?=
 =?us-ascii?Q?Knfh4OtfVMr1NVouFCPOJwyblUzoPo13p9JyC1nrhUQEoMt3RyL/Ria1eeOD?=
 =?us-ascii?Q?2aICtnZMUpl3Nm+CniPdrEa5NuYId3DO2bI2BjdI154TCQ9/IK7AHtSG97gI?=
 =?us-ascii?Q?0i2Yz+OfQ8VAFKlBhQ/zhCLxqTcisfpbFd4KufjF1vS0QllwW3MWWl7+2aHl?=
 =?us-ascii?Q?5NiiComDJ0SGxJ3gRPmRedAxXQMWRE6nQSUIDHZg5TYLjRu+zUVREtYR48bX?=
 =?us-ascii?Q?J4ay274LswyGYmnvNSoPLrcGYiy/zZL8JsufGrB3JADEWSWVB+D/nhKU0hnY?=
 =?us-ascii?Q?izD4jBwQxYojLvl7UTPPEEkR05GYtvnzdezjZaxfRHDHpwdIx1lKuwGU7ttq?=
 =?us-ascii?Q?I+KAMq1kl2vMp0h59s3pZ79aG6O5aWKhII5S/mKLcqlGaxkjyedg743jllON?=
 =?us-ascii?Q?rAaJY49Wm9IH5mct3uSfzL2s9QM3hdQeg/h40Sw/cy+7EKmRx6H8+l2NOTaB?=
 =?us-ascii?Q?CypIDONUCgN53waMXkdiRr1E?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8BD7FD048DD3E144A3A430CCA6FB9D97@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6c4dfe-92d9-441f-e29e-08d917192486
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 20:45:00.2837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jo96As3ApZlA66w6uzVfT1rAKkiJ2ugSXF75yL3kIdYreZ/6CiESyxInMBflr2wz5DcXOZoRIGxr2UIhZVTvlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2192
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140164
X-Proofpoint-ORIG-GUID: xji3eOJveyaGcgdmlFiT2KA_mko078b0
X-Proofpoint-GUID: xji3eOJveyaGcgdmlFiT2KA_mko078b0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [210514 06:58]:
>=20
> Cc'ing a moderated list is sodding annoying, dropped it.
>=20
> On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
>=20
> > +struct maple_range_64 {
> > +	struct maple_pnode *parent;
> > +	unsigned long pivot[MAPLE_RANGE64_SLOTS - 1];
> > +	void __rcu *slot[MAPLE_RANGE64_SLOTS];
> > +};
> > +
> > +struct maple_arange_64 {
> > +	struct maple_pnode *parent;
> > +	unsigned long pivot[MAPLE_ARANGE64_SLOTS - 1];
> > +	void __rcu *slot[MAPLE_ARANGE64_SLOTS];
> > +	unsigned long gap[MAPLE_ARANGE64_SLOTS];
> > +	unsigned char meta;
> > +};
> > +
> > +struct maple_alloc {
> > +	unsigned long total;
> > +	unsigned char node_count;
> > +	unsigned int request_count;
> > +	struct maple_alloc *slot[MAPLE_ALLOC_SLOTS];
> > +};
> > +
> > +struct maple_topiary {
> > +	struct maple_pnode *parent;
> > +	struct maple_enode *next; /* Overlaps the pivot */
> > +};
> > +
> > +enum maple_type {
> > +	maple_dense,
> > +	maple_leaf_64,
> > +	maple_range_64,
> > +	maple_arange_64,
> > +};
>=20
> > +struct maple_node {
> > +	union {
> > +		struct {
> > +			struct maple_pnode *parent;
> > +			void __rcu *slot[MAPLE_NODE_SLOTS];
> > +		};
> > +		struct {
> > +			void *pad;
> > +			struct rcu_head rcu;
> > +			unsigned int ma_flags;
> > +			enum maple_type type;
> > +		};
> > +		struct maple_range_64 mr64;
> > +		struct maple_arange_64 ma64;
> > +		struct maple_alloc alloc;
> > +	};
> > +};
>=20
> This is somewhat inconsistent; would it make sense to have struct
> maple_dense and struct maple_leaf_64, and maybe even struct maple_free,
> such that one can write:
>=20
> struct maple_node {
> 	union {
> 		/* maple_type: */
> 		struct maple_dense	md;
> 		struct maple_leaf_64	ml64;
> 		struct maple_range_64	mr64;
> 		struct maple_arange_64	ma64;
>=20
> 		/* internal, life-time: */
> 		struct maple_alloc	alloc;
> 		struct maple_free	free;
> 	};
> };
>=20
> Or something along those lines.
>=20

The problem I am solving with the anon structs is the resulting C code
looks much cleaner with the anon structs.  I could make #defines or
small inline helpers to make the other side pretty, but at the expense
of readability imo.  What do you think?

