Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715013812CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhENVYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:24:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33636 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhENVYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:24:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ELLBAr030234;
        Fri, 14 May 2021 21:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jm/Q3082xyibCaJG4n82mi150MwD1xxoGg9FwvW6y2M=;
 b=A23z9wbISMEuu+ravKB5p8Dy+JknIxXIrqwO636iwEBbWmHt4y4MB/L5wQgrK/iMdVxS
 YLuSJ49+1wvVpHa7ppcFPRm3dyu/4KTlaqAPqlA8sWBmF+01oMhYt8043xAAM3YJkF+W
 OTKEWQ1V78RParzK4mqLZkj/W8Dho6BCV/Wg4pi9k8IhUKnctrfBR2f218hLPVzFE6ly
 BnegcmUDvWVc590zmN+8lx5OPnhifY9OW7QdGIyhpTXUFk2Ybnm4TJtG2uW5Wwvh1+22
 oVwCVOKIJVcRIiPl8FjIA3IJGNYatjdURBllERSFK4Ouf79g5vxkjYhSTTZ0V5eXICFy BA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gpqmguqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 21:23:09 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14ELN8ca100350;
        Fri, 14 May 2021 21:23:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3030.oracle.com with ESMTP id 38gppqekc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 21:23:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMGMTvRveL7+gprmnmtgYajmpoD473l9g8O/NmDZOzMx1E3A9t6CC+34jYxP51cJw3WeFJjAVZnjMfIGw2GnwkSn4kKZjtBMCBdXP3iXlDTbYwnZo2qfYHecpX4o01daociGTx7k+vhmebEMPaRiJiL6fqJedGHfU1AzveGVIKg2npGy8j0AKh2JS89PJ92jENbN/v7gJ7OOTV8birOOuWE/BjsxgzS3eiyddAErEtZXcp6rK7OHg4BZcYtEtFVVupcLKPh7HnxFDglOjVRUOSlElJSBItHAts5CBufWngm/1p/g36XHNC2gM34xN8kYOpmotRLQkPDoWvYC6nlmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm/Q3082xyibCaJG4n82mi150MwD1xxoGg9FwvW6y2M=;
 b=CtXmUVkpzE3XzaeB/g4IVfZhYtHrOQW/N1eThqgAz46jG0D9mhq9ya2hIqqViC2Ri1NwiASIksZuf2j+SrUl01qocuWH/O8RdWQ9rSuHKZ9XgWtXxw9LQcJ8Lydfe4Tyy3+6GxW2hleP4CL143ruJZEuZ3nAmSJJf9OzMba9I0la5ZB3/uLBa7wLq7FFZNSv8r7reUUkenE8AUQkdH1KJgle0JgsmB5dY1PQvmaXsZ41NF7DU+HeZmeF3iZQFBjkw1Azvx79X1glrInOCvRs0cA3jDraQINQQI1AOge2nh5yGUaBzK5uHNZGm0gUnTPO+WiWlrbydCVHJ0SbFAJgcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm/Q3082xyibCaJG4n82mi150MwD1xxoGg9FwvW6y2M=;
 b=YJcPsBI/zIDq37n0uSLVCpVpwJj1uWcNWrvPFpE7uFcAVviZ+emqUmO4Wj4/PpPYhezMPT5LBeI6dZiQ/C0CKq1IBzBtw8x2niOh3M4v175pjbO4SUR/tgyLunrHuOinBYtxxB0vWsqIFd9hJjA2LiNobU6WLEDBzJ6NUAcjY1E=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1984.namprd10.prod.outlook.com (2603:10b6:300:10f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 21:23:04 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 21:23:04 +0000
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
Thread-Index: AQHXPEQyRs1g/Qku7UiibZzqyyuzcari6+eAgAADvICAAKZzAA==
Date:   Fri, 14 May 2021 21:23:04 +0000
Message-ID: <20210514212218.nbkak2a3ozi7iv3o@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
 <YJ5bbw70JLfNi8Q7@hirez.programming.kicks-ass.net>
 <YJ5ekZAddvWI3Hzk@hirez.programming.kicks-ass.net>
In-Reply-To: <YJ5ekZAddvWI3Hzk@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30f72875-3834-4fc2-0fa4-08d9171e75ee
x-ms-traffictypediagnostic: MWHPR10MB1984:
x-microsoft-antispam-prvs: <MWHPR10MB19841AEB9F5F1993ABCCD17AFD509@MWHPR10MB1984.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JLNCGxN3v5l/9iOJz3EAjSDpdTqfIQe6prO9eyXE2AzjtDBJmjbZqxsHazLIqQAq/RLxLUEaQhtVfEYZ66af6KFLmfclTT1QrHmg85OfU3E74mgAQlK1AVFr68AuicHe19KWPaTCYuKajmr1ycf3QKpTbpYSrYSwgHKVtzSQMPCpJRmFeMolbJwpONBLjswxgByZ06fwtpbGG53m4JV08mgm4rLYNVe2J1sDPncRoT6F0PZT/+Lz9rOG+ZNcmLq4xrBeT5QtSAes3Tlk4N0ddzdVirOHeOeCXGgyjzH2EisRLxWURqqz7dfxSPHF44sOeoVFOTtQBjYWkLQveq1mxoUsRElds7uzGDcdz/f2HKp3WEmDH3AVwl8BcMDLs3P8/YhXZVtZbrMG7b0Bby5/MXP6DpgOXYtFATe1PQPF1OIu/3COoV79rrtXwyZEPV9zaiRQXVcg/oGpTgeITopE4oyR1zEOBsfXH+iSueWJI1GSKLi8u10s+AfsOxvAZm+FMiQTe0sgYJ9EI7mNO7YFvTg9vA28F0iRGZtz+cqqM4NYILnBLlv5HekQe/WMtWU5KjT5zQDVMZ0glry91kZlXJ6g8qRu9e3NN7gyhhBGrJE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(366004)(39860400002)(346002)(376002)(396003)(33716001)(2906002)(71200400001)(4326008)(6512007)(7416002)(316002)(9686003)(76116006)(66946007)(54906003)(26005)(91956017)(64756008)(66476007)(6486002)(66556008)(8676002)(66446008)(186003)(6916009)(38100700002)(478600001)(86362001)(1076003)(122000001)(44832011)(6506007)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5HJZS6QXDYZcd5h2wHesfURAxWPBSwI80SeXEEE4wMDIU6dDBsRe65EWOcdC?=
 =?us-ascii?Q?jV7IoLig3w6590Eeo/1PZB8EKQGA5l1xvSQfidgsjvISzvZEd+LfYLlV2hg2?=
 =?us-ascii?Q?VCRboNfRU9T1MEf+DZGfK/93vxSLmF2shlmr0Ud5Fyy4sqHHOllJstlsPg2a?=
 =?us-ascii?Q?jG2dPE/Ujho3SFSwO27G+QRkzT8ss471AtzFupyVnYQ96FizsxHqN6gD6BQW?=
 =?us-ascii?Q?h2XZrNdLdm9TrvUvF/+xsjg2kHUDeKl2A6HwmYiRtyo/eJ6wwecP8hkyhc4a?=
 =?us-ascii?Q?ZVq/KIW15JD/jvuH1wYpICFAj9/mFkMHnsmxZJUgkoUspwfw7e7dZiI1Zl8f?=
 =?us-ascii?Q?LvjCpEWP7Mgits07ptmrFrpl6VqMy9fFRSmnr0l4HF1LQMgDmKt80x/vLtoE?=
 =?us-ascii?Q?WPbMbYuBghpWe5kQODf6EB33VCl1NwI0drK8PO9dTmY7J/jt9f5M7glLdaRO?=
 =?us-ascii?Q?OWCvRqKbqlwN/10qSv0kLsIOvoa/aC1Tt0ox2/ynSRAkAWLlPKy2qIwCv87V?=
 =?us-ascii?Q?dqBgMeHfmHrzFf12l78k7isjn4Z641Pq/wMFpMYhaWzTup8oOryiecs+9SDA?=
 =?us-ascii?Q?B7GFClKH7VjlP8VZTW82mCySc8reYs8G2MT/W5fW7tDxeMMO1eyOAJfGFZ2W?=
 =?us-ascii?Q?vXjEmu70Zqion98PYt7yaH6csK4toGyR8Ev+mzyH6Qhb7snApFcwziBoNPeN?=
 =?us-ascii?Q?oafP7wWRFQ4wqUaGx6yec0bLI/Wgya5o7b4eZDXHXfPZMB1+GFjz4v/5wb0A?=
 =?us-ascii?Q?kx+uswEjK2v9yiKnNx8z9E5kuVgyk03EQIVO0dtzToBxiSG7D+Xm8fScd20O?=
 =?us-ascii?Q?Dc6boGeLH7jgxtSr5KGzxbEqsdQ62UGkRiQHPCvi0lLlrpFjsjT1sstBuX/M?=
 =?us-ascii?Q?oWAgis+MdZC5pqTJFFrYksKuuT1AqfufPgLZce8Jw0joM4O9bR5KCytGUD4Q?=
 =?us-ascii?Q?SzXhbebascSHXK0OTsxeNE3+w57zR68Mgn7J/cEJILVj8crL/lZnc5UQYBx7?=
 =?us-ascii?Q?ZDqshMOpBGxZvOLyIZ7R35PoX8KA4i/G5ofDARKxAng0O6QKiLeFLYt37CGE?=
 =?us-ascii?Q?iMt2zK2TJXFiwXcZEl370SbhMgO3Hs0DQ7Y9ymOgGm7HQwM42GoI4y0p1bJ/?=
 =?us-ascii?Q?TBlhTlklufXSRVYYFDmgMtLs8KIdjU+uorNoeqqGqM9jkE9vY8k05pbWky3k?=
 =?us-ascii?Q?Rtq7ih4UYtLdAAIMaqwuiHpy9RMzn/T6KBXqwmlsZdMOcIAX9lablk1hqCaP?=
 =?us-ascii?Q?QNG6vryEUR/NoABWvNJUsxfe/Lzhl5PWReFYXknRpLrSLHhV+loHttybQ/uP?=
 =?us-ascii?Q?Wzg3FETn/e7TVIdc1XCPps/M?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D75DBE504D30984E88055D00F8CF6ADB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f72875-3834-4fc2-0fa4-08d9171e75ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 21:23:04.3250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uFC5zDk4VQT8aJbADbKm75vocTBmTgHvaBlC7NbipA3qetxyM0Z9ESYe7kgjOWn8YkX7ATVgGZ0Ea099NPEQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1984
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140169
X-Proofpoint-GUID: ARABsjlAH6vwnPnefhRTSltfcJ020qV4
X-Proofpoint-ORIG-GUID: ARABsjlAH6vwnPnefhRTSltfcJ020qV4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [210514 07:27]:
> On Fri, May 14, 2021 at 01:13:51PM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
>=20
> > > +static inline struct maple_node *mte_to_node(const struct maple_enod=
e *entry)
> > > +{
> > > +	return (struct maple_node *)((unsigned long)entry & ~127);
> > > +}
> >=20
> > > +static inline struct maple_topiary *mte_to_mat(const struct maple_en=
ode *entry)
> > > +{
> > > +	return (struct maple_topiary *)((unsigned long)entry & ~127);
> > > +}
> >=20
> > Can we please write masks as hex, also do they want a pretty name?
> >=20
> >=20
> > This has more magic mask values, proper names might be good:
> >=20
> > > +static inline void mte_set_parent(struct maple_enode *enode,
> > > +				 const struct maple_enode *parent,
> > > +				 unsigned char slot)
> > > +{
> > > +	unsigned long bitmask =3D 0x78;
> > > +	unsigned long val =3D (unsigned long) parent;
> > > +	unsigned long type =3D 0;
> > > +
> > > +	switch (mte_node_type(parent)) {
> > > +	case maple_range_64:
> > > +	case maple_arange_64:
> > > +		type =3D 6;
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > > +
> > > +	val &=3D ~bitmask; // Remove any old slot number.
> > > +	val |=3D (slot << MAPLE_PARENT_SHIFT); // Set the slot.
> > > +	val |=3D type;
> > > +	mte_to_node(enode)->parent =3D ma_parent_ptr(val);
> > > +}
> >=20
> > > +static inline unsigned int mte_parent_slot(const struct maple_enode =
*enode)
> > > +{
> > > +	unsigned long bitmask =3D 0x7C;
> > > +	unsigned long val =3D (unsigned long) mte_to_node(enode)->parent;
> > > +
> > > +	if (val & 1)
> > > +		return 0; // Root.
> > > +
> > > +	return (val & bitmask) >> MAPLE_PARENT_SHIFT;
> >=20
> > 7c is 1111100, but then you're shifting out the one bit that makes the
> > difference from the above magic 0x78. What gives?
>=20
> IMO the more obvious way is something like:
>=20
> 	(val >> MAPLE_PARENT_SHIFT) & ((1 << MAPLE_SLOT_BITS)-1);
>=20
> And then we also see that 3+4 gives 7, which is that magical 127 above,
> are them the same? Related names would be good in that case.
>=20


This is a residual of having changed the mte_parent_slot() calculation
from supporting more node types which had different shifts.

Thank you for pointing this out.  I will clean this up.=
