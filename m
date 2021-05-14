Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C9F381350
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhENVpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:45:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29408 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230247AbhENVpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:45:18 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ELPG32015822;
        Fri, 14 May 2021 21:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MX7Jg+YRoqjZtHVe2r2BYVT/pIC4DwWayopjKVLay7Y=;
 b=RxT9n72v+/OMNTOu+ZdhLND8si9xeRPj9dukWuw/6SvHVhUzD7wZpIXnvIJ+Lw7l60aP
 oGMK7G32MBFTpyykW3/zrR6tU/njW8nW2vIrw/GSTkOYZw6Hf/AWFy4MNubIpUpiqrCO
 cGnCmm576iFGNYGTH9U58+DKWPyxO9sGAqcea9Si0x68ul+pWc23BQtAf5upCXWTZnGH
 mnA/xxqLCtiSIe3xEPLIB/jtoebTztlCZ4S0ae5xC36dNHzAtUDtK7MVN0S7weq8R3ex
 te6CzAy9waM/R5X7/N2m9aRUjeO6gb4YoO02jq0xM8t7wEVy3TzkHL14WR3QCxT/gNVu DA== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gpqsruue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 21:43:49 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14ELhlwQ171146;
        Fri, 14 May 2021 21:43:47 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by userp3030.oracle.com with ESMTP id 38gpq3f6rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 21:43:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jP2cYr3q9lieefd4e2He2pMWJLVEMTqEBgB1oZ7eqge7gDElNWMTNRQq7bJIrY7gSuLUm4f9dejE1bGlJDDKsrTmuQss2lyikOS/QjAyi+sviKwKkT9AZLLqw7cquHaZPk7b8WgYnZBgmpoYiTRQc2orRLtwxYKQFx4xih53RRN4qXmJwPSUnqe+CcrfTvh+l+xXuoR6Nlm9HwTwauposxnfg8kDJOScYX4rihZ6VWrG4rFUAQhTEPoy8+7TshAh/UWmujBvI7Cm6IqYRJqupZKEseNyBKQ3L+C/kcSjjs/RRpTm7MoEapy0ucShCjRQeThH4R8HJvhErXLMU0IM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX7Jg+YRoqjZtHVe2r2BYVT/pIC4DwWayopjKVLay7Y=;
 b=OmNnaV2B9ibqvDnt+NKO1m0s8CvlsYSNXJcX8gHBc1x07V5yHf7QIBz74Oi/Y+V3sleLGBDVrUUJluYgjuieck4FfgZ7PuORKDcoYRE5JJY5Aor6TEBssUri3gJ4tBgTJDnzlbZQKecO0izoQpzzCwpsoCnqyi5zmivjhPxDtzuKp1KO+lzgYKemjhB++PVHgLYZUWNiDny+enmZjpx3i60rD2suS27WbWfdhgGnOJqMjyN0Hv+AioSofYHrpNJL4cdiwVWk31cO52Dll6nyAOVkbn6pDq+C2Yvc6cjsaGfCz27Q0E23Fvnf1bq1CzYQWBV1OZhjVbm8eszEw1fWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX7Jg+YRoqjZtHVe2r2BYVT/pIC4DwWayopjKVLay7Y=;
 b=fwpUtYdCYUfA9xBKpH8q7O/xvNOomc3Qlr9tCYKUA7ToyD9iyVObzrfRxSVO8Mw1FZaHwb7RdeHQ4minq8mN4YZj01+yoG5JofNfAIe0czEqAMZOvv0B4kWY1TUJ0QHm7b4lVtyzl11hGZ7ibe/AEqTQkiQFbawrisYFp1MKpu0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1743.namprd10.prod.outlook.com (2603:10b6:301:7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 21:43:45 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 21:43:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 26/94] Maple Tree: Add new data structure
Thread-Topic: [PATCH 26/94] Maple Tree: Add new data structure
Thread-Index: AQHXPEQyRs1g/Qku7UiibZzqyyuzcarjNBmAgABnx4A=
Date:   Fri, 14 May 2021 21:43:44 +0000
Message-ID: <20210514214341.53bwviwoze2rzowj@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
 <YJ6X/wrP/El8KLdh@hirez.programming.kicks-ass.net>
In-Reply-To: <YJ6X/wrP/El8KLdh@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 232d6743-5918-4cfd-954c-08d91721595f
x-ms-traffictypediagnostic: MWHPR10MB1743:
x-microsoft-antispam-prvs: <MWHPR10MB1743DBA4545F63551826F944FD509@MWHPR10MB1743.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HMTVGBsHAHpt95W2jdVbhevUlk1Zjb2hIcj60gwjN58aX6pPBq+kMwmDLsvMsVBnKXDeoGyyS5GLTm+PeY05b5dybZO9V1QCEfsHruNE34FP4GMD5RPBvv2I/Uvm4/FSHHMoH8gXUrj+Wb7gdtehgzqdML15lU2PeFAs6IVMZ1sncjRatQBTC2ctkPMDr4BH729Prz3r6WZJhV9SCrWO8GZpEZYWWoSUvu2gN3RxmE4UhKlV7xVMSxYPugPTdJHm4fNLIHhoxcdjTEODbNbXAnC/Kt6oqNT3gBRpuyt3C4HfYcxT1es/Lh97iS1xb/YCFKq9rMW13uWTpUENr2pXWxrUh7z1Rh07+eCVUJhHpnnd60RPHmHKlHqyojnwrL+MkQKW4THJYL8ugu28Kvn5ApdK8IOaMAzO1DOPh2lMpq31H6DzEwXtxpjRNFzikUJKsFE+Ng0Jq+WAimAagu0GPLGkXLZEtNJFfNagG6xZXfJXptals6xwILrvLaAkbA5YixUPU1NtFpB8YAI/SX3HqRBgDahuoPdFXrvvJck6P4ptB0LeVDrN46sSYSt7rX6pPkCrOWbpLt5a/n7bsaoW1e6rpW2h1MUivFDSZRZq5Iw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(376002)(136003)(346002)(396003)(39860400002)(8936002)(6512007)(9686003)(8676002)(54906003)(5660300002)(316002)(66556008)(186003)(44832011)(6916009)(26005)(122000001)(6486002)(6506007)(1076003)(71200400001)(7416002)(478600001)(4326008)(33716001)(83380400001)(2906002)(66476007)(66946007)(64756008)(76116006)(91956017)(86362001)(38100700002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zZ1FHBRjPjJi5qQczu4nN6oXW9weXlcCOYwjNp/JK3v/XR/wZmi3rjSon5ZY?=
 =?us-ascii?Q?P8KL0gwmYDCAlFAMonQi5ZwCr/VQNP5R1c7rc0YIazr4RsBsX60S1hUuAJiP?=
 =?us-ascii?Q?9z+qCED82fBEVhZgwdol+MIIT8Nl1ovwc8wko0yZyJsaAD/QEKHjyxY3s/es?=
 =?us-ascii?Q?mJmKzYVaV+A/4CbSntSjkG+WJ5ebn7FHyGwgKJ6HEf2xNyzUZe4auZq0xvmD?=
 =?us-ascii?Q?UV+44l1XV3pFdzmbGM6UO862tD7nLB480JwBgN9uXsF+qixNq1EfvZYRDGlg?=
 =?us-ascii?Q?YW0DaO1ZyR+/ccImOXEpIZAAZhFSEt0NfFb0JP4nBVDAW9NMwjB6yBmCLU7c?=
 =?us-ascii?Q?cYBYoTaoXJIBgx/i7u7f6KvtggUXwEsf3nQkfMKk0dkYvpi0HXmWfZPbM7sD?=
 =?us-ascii?Q?ojuApuAKCMijkwvQy70LQXodYCA4G4YC7oeoH2HWpB5zsVwrzPJI4yd8tuit?=
 =?us-ascii?Q?FCeF7CxVlawYJ9z5MFeCJseCz7qA3fQNtFYda6CKQk/VCD9/BK0rZrHJkF/w?=
 =?us-ascii?Q?8lm3kgB7IYQAF+QqNd5xxlgo5ne1Uum+YPRn9uGUpUo7qAS8b50aIZ7U40EF?=
 =?us-ascii?Q?Z0TxH6qfhVn0/h+g9omaZFn/EChwMn65ppWK/Xl13TEAAqDTU0NQz8wjk0ZZ?=
 =?us-ascii?Q?PUz8uHcjyn0g+d7nGZ3MVGUBVsoJkw04D2gwO14kWgPQdLIL6EZyXmeWhGRM?=
 =?us-ascii?Q?dpde3Y1/ed+tOIgeTq1bs6UMIL9FSYnBvvK52d/yEytB3finMeUGo/GgUbOn?=
 =?us-ascii?Q?AeiJ8ham/bVrYreD5huxwjqZLI5LY6rLr/hRU2U46PVJ+sr6DcEsDe0y1hw4?=
 =?us-ascii?Q?fzNwGneWWpAM1paSD7E4YxITrcagIyIEOMnKZBNZ6KEK4t9IAiSxOj0hMhcc?=
 =?us-ascii?Q?9gqc7ggChBS1JoM9UF6qWLBdunHcsjFEUccJhKFDtqoYhCdK6KY7rg6B7E9u?=
 =?us-ascii?Q?FDSaYGcQwe5eIdSLM6JW56Xt2N8sVyN6PzGDN6IC3+v8olCCaWjEhi+hzXb4?=
 =?us-ascii?Q?J9is8nsU5pXljoEIFQf5B4WE9d6Q3t9Jkc/xwQ5hFQoSnfR7iY2wNzmkfjbO?=
 =?us-ascii?Q?OuCkvFYl78XNgfHBkb1SBbjveLDm27DTW7MmRXJm4Cpwg5KKMAycq885pkuk?=
 =?us-ascii?Q?J0lSB9u5Kd861qIIgtHGHohskh1+LIgu9M4myIonGVbdPat/VrrVY9DVrqYA?=
 =?us-ascii?Q?HyRa6CfNMj2EmMuTRAY3Fu2HXhS/2257RSMgEGO9HXD6Ch3vd3F4j2inrF1a?=
 =?us-ascii?Q?Abtmj0urCfTjHJ6LYXKPBQhyqV0lT4X+igPWvEtJOMcjnUvB49kb3piADfWn?=
 =?us-ascii?Q?PariwQAzlLE339fcSw9YPQGl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68FB6003CC8A514EA928BF5D53090BF0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232d6743-5918-4cfd-954c-08d91721595f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 21:43:44.8762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+IcVey7pqmodb5kJRna4uL6S7yyuRraiwkdnK3FQlDZ399mVzv9EltbeYFb8yv2qD+5ActVKtCczAYK3rdo2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140170
X-Proofpoint-GUID: X5bX8DFj0ya4BSLFBHc8muHUW69b_lM4
X-Proofpoint-ORIG-GUID: X5bX8DFj0ya4BSLFBHc8muHUW69b_lM4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [210514 11:32]:
> On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
> > +enum maple_type {
> > +	maple_dense,
> > +	maple_leaf_64,
> > +	maple_range_64,
> > +	maple_arange_64,
> > +};
>=20
> > +static inline unsigned long *ma_pivots(struct maple_node *node,
> > +					   enum maple_type type)
> > +{
> > +	switch (type) {
> > +	case maple_arange_64:
> > +		return node->ma64.pivot;
> > +	case maple_range_64:
> > +	case maple_leaf_64:
> > +		return node->mr64.pivot;
> > +	case maple_dense:
> > +	default:
> > +		return NULL;
> > +	}
> > +}
>=20
> > +static inline unsigned long *ma_gaps(struct maple_node *node,
> > +				     enum maple_type type)
> > +{
> > +	switch (type) {
> > +	case maple_arange_64:
> > +		return node->ma64.gap;
> > +	case maple_range_64:
> > +	case maple_leaf_64:
> > +	case maple_dense:
> > +	default:
> > +		return NULL;
> > +	}
> > +}
>=20
> > +static inline unsigned long mte_pivot(const struct maple_enode *mn,
> > +				 unsigned char piv)
> > +{
> > +	struct maple_node *node =3D mte_to_node(mn);
> > +
> > +	switch (mte_node_type(mn)) {
> > +	case maple_arange_64:
> > +		return node->ma64.pivot[piv];
> > +	case maple_range_64:
> > +	case maple_leaf_64:
> > +		return node->mr64.pivot[piv];
> > +	case maple_dense:
> > +	default:
> > +		return 0;
> > +	}
> > +}
>=20
> I would suggest removing the default: case. Without it the cases are
> complete and the compiler should not complain. Then if you extend the
> enum and forget to add a case, the switch is no longer complete and will
> trigger a warning, forcing you to update it (hopefully correct).
>=20
> If you have the default, you'll not get a warning and it'll do whatever.


Thanks, I will do this.=
