Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5233718EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 18:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhECQKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 12:10:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51406 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhECQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:10:06 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143FxTlQ002334;
        Mon, 3 May 2021 16:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xCXJJ2NQYghVX2ubzM81cH5DczKalPS93sEYJMTqFvI=;
 b=Q61E+Q59GviyYO+xawldIOP3EVCbkpaOfHOdB5HXeCQ3hmlTDW/BnY6f78Cuw8LK9VtP
 rjfdOWsbZmkQ8eTQayjPbkMWxM26WXVdT0ku/ZZfZhl9fvFl9Fyfp7InB+I3NRtzSoIP
 czpAGSKA6iKV5YxqIqemT/D2+lsdHTClHXSLvSDLnG9SUKozmGzPzwgKG38gGlpPjbA2
 3HLyvTa1G+3q7jzGDy5ebmEoVOa9r8z/O7bvBmMUEvQeTiiETyMmjpzcv1K7VTKc0Y4h
 OC8JJB9K74DbkTgdt0uuAyDYqnqnlgjzAydp32jNtc92WooXpaTqbLXjscKmW3IQrsC/ oA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 388vgbm7y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 16:08:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143G0G8Z145496;
        Mon, 3 May 2021 16:08:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 388xt2mckb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 16:08:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkE/zlzTyNCTGjyprsfahznbCEcEGpo68evb583cOBplWn5d9s3Hx9DTOPt4x6Gn/mm6dm0tmtwaGKQPrT53SdTRy0i8dk4g922OWNj5yEqOJDYY2EwGiHJ99hwvboEn1qXb7YQ9DQOJeg68+QoLw0nsGJEjBsLBmJx6myb2pgAYwAp4kglR6B7BM1iT+R6t539UVSTCPmHQJ1dLZrbrsM7Yo5HryZi7H7zlsYeboOo8Gp9MZokHQo7XYqyPaRV5jjiHqgGaXsUnewSvsBLvRIyy2mMKoxQiG4t6qO3S94PCda0aXd1CACxU0LcagZtr3e75VNrgiD7KQIF8sHg/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCXJJ2NQYghVX2ubzM81cH5DczKalPS93sEYJMTqFvI=;
 b=X4FmfWFyF7aJy3VyN8MP6C8jP1zwKMkelZzf4W8rwSdKlGvhqbVNOrLeVai29bJ8nIJn2KZOjTqYTQjPIl1h7PNjyvsBrIhRSmNdN08ZxfSbWTzPpRRqJzs8zgB8VoFFEV3riHaP9A/VfEhKLKw7ecLxbOe4wSRLiGaEvOsDO+pN4V34ZtvYneSa6tOrMMIqgFnOcoPRiYvh2dtAvW8QfYFVtYmIRwDOyPUFV8GS/oztJlvZ6LDt8frFeFT4lx1WZWzbnPKlVuR3BhqrtLeq0iwSYeArtPkCUkwdhH7uNVtwR8Sxyg7Uuu2yGi6arhGvVgx/M51t/sz1kkkWLvAgUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCXJJ2NQYghVX2ubzM81cH5DczKalPS93sEYJMTqFvI=;
 b=VVxIqPg9b/YXJd3+6QxEo+LpUpHnxHEe4ZL87m8rovTZIui3qkAhMijMysrRPIj8cwGKf5P9kIc78yCvE9xaMXzFZfcdP51lgbKdPdlZj4WweBWXni0K0guSqUvtWwLz3+ZqmC1TyhlhvZSfEq78SnJ1rR4ogPSxEUKp5i59o3o=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4481.namprd10.prod.outlook.com (2603:10b6:303:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Mon, 3 May
 2021 16:08:48 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 16:08:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Michel Lespinasse <michel@lespinasse.org>
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
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 01/94] mm: Add vma_lookup()
Thread-Topic: [PATCH 01/94] mm: Add vma_lookup()
Thread-Index: AQHXPEQmA9/hNjlhF0O1j8k1xuPy8qrOFnOAgAPeL4A=
Date:   Mon, 3 May 2021 16:08:47 +0000
Message-ID: <20210503160841.2juynuimujnaajad@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-2-Liam.Howlett@Oracle.com>
 <20210501050441.GB5188@lespinasse.org>
In-Reply-To: <20210501050441.GB5188@lespinasse.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lespinasse.org; dkim=none (message not signed)
 header.d=none;lespinasse.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 927b1c9d-a469-4b78-b9e9-08d90e4dbbc5
x-ms-traffictypediagnostic: CO1PR10MB4481:
x-microsoft-antispam-prvs: <CO1PR10MB4481449D3968EE2190DD3010FD5B9@CO1PR10MB4481.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjFRthH9MbMuqmZFtss49ZtCWJhBls0CevSIeXQRNIlfMeB5ZgmEMJdAEqHadi1XJpeDWJfq7+/EajAgvJa10rJkGkZ9oMbwezuNBZXYQoLyVRIdjs0aiXp+3/TS3krqQGbpcKj35YrqQIR0+vyrLXpF035gq02WmcczK6ou9JDKYDeLKk3xDEAdNKhO1gGgHXegnOY/QjoHrSz2gxCoOD02zi07gxGNPZYt6BCGtm2RFS7SJKddC46zeGyn11NTkQb7Tf6UegyTNjs8yyk8H63PxyC4kwiVR3w3J9a+8fGrsvk1P9w1hdskI+sqVS4Njhj17d8OS0TQ2TtyqEl3hOiTa9ctV/vCJApfpgAHym/x8jqtyuwjWmVFL4aoRTjeDe4p3sxQgq1wJgyhkmkLc5IVupV6HjZawEACrRl4M+0h7oPi4XDkCoGGzGrVd6dLn9AZWp39w2GY1hK7Yxp++uk1Qk4nZGhBeBBtTu+eGBCuuVEQCoCJLMdHKfSta5z60qODeGoURrFjwhlanbwDpL4LRmF0uyak3O1/sbZazdxsHji4bc0pK+WSEVVYbuiHzvRgjf0PGYU2Y3nqeiFK7HDLGKgAx8yLWoA7YcwTC9Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(396003)(366004)(39860400002)(346002)(136003)(1076003)(44832011)(83380400001)(9686003)(33716001)(2906002)(6512007)(6486002)(8936002)(6916009)(8676002)(64756008)(66446008)(66476007)(66556008)(4326008)(66946007)(91956017)(76116006)(7416002)(38100700002)(5660300002)(6506007)(186003)(122000001)(71200400001)(86362001)(54906003)(478600001)(26005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sV8kud5iVKcVV4K7eDCE0UIVFErcCu+EOg1QhUZhHOpE6i5R9u5pqVCo1lT2?=
 =?us-ascii?Q?Th/LB7ApDr6q5SZJAXo6yoZNIicnzbwer5kKW0iyqD3fg79KHD/bVerXVAFa?=
 =?us-ascii?Q?rtkTMnvSoFhJIqypVQpHb00kMKA7rRymkEgOqCDPx0CmKTIcKEKIX8dx/ceY?=
 =?us-ascii?Q?Tj6xtQGU0l3BFZ0lDw3swPIGyB9iWJHslePFBIUduqA7hNMR2t7AaPkc3r22?=
 =?us-ascii?Q?Xg9u02KxF4VhufKHzDUNC0Anz0wNXe6Z1fDb5vYJTFhhkktIYgYNbEM+uakG?=
 =?us-ascii?Q?1ZsBArtenOD8aK4GmmKc4cs+0saK1TIbOLx+0ocNGBz2stITjMOislFH3Yau?=
 =?us-ascii?Q?8blYADol67B6aobEdvre4hwBvhndC4lnviggMtqJfkuVceHTjzuIG2tm9GDt?=
 =?us-ascii?Q?xct+FGVbdN7D4AtwsnBE9Tx5cjKd/gxyKpWvPtOTCApLrJROF0NXgFInIXU7?=
 =?us-ascii?Q?b6/JY5K3cub/sQDzZep4d4DIP7niWPNgt6SF2a8H7x56n7CRpxL2lVz4JC5c?=
 =?us-ascii?Q?0ELQ/8lUNLW9TWCWvvHgrEN66dSCBQov1eWQ6l8ZA005l1BZa5zk/6yUOE99?=
 =?us-ascii?Q?yLZYSke1HLXxOTHLl+FEsJOMy2a8mU1EfGapHVjfzt/4Xhx2k3nw4NYmPjLl?=
 =?us-ascii?Q?uBkMUSCgu4h3Xk/M+RlaMRdT9xR5Hiv+3fvunKGHf4tFeHqABhId5RGKYjJ/?=
 =?us-ascii?Q?bAcEWCxeFaaQ5cljana3BxlhYu3xSw4G5c2+zwlu/oh+2hxSac4UPdQLRvnN?=
 =?us-ascii?Q?LIQjCLEDybpP/7CthHKAe/phme+aWnORahnAu+3qyoMO7oSeh8Eu4esTud6H?=
 =?us-ascii?Q?GwqVzhOzrwcBpfwFFN4ehVGTjn/mn2vybulTZj3wQ22PMGS+q/ki6y3cmvwZ?=
 =?us-ascii?Q?+tYdMMj5/4WSeIIMmJZo21eaBkME1WasHnXGdWLGKl/P+INnTT6SrHvizqTy?=
 =?us-ascii?Q?STZLryBBEXC/LdhQTJ7Fv1ZbpoH3S/UxXBLSCXyDERSZlu1Xy0nPmpcZOQT/?=
 =?us-ascii?Q?Qe3kVMcD2MzGSoeZOgV59uESMjKKB7i7D6ptQz0OqV3YFN3N1ssen6aVmmxd?=
 =?us-ascii?Q?G9Kr7iNCQnIxmeB4bsJavlO5SZ5H+IjZXj58AY5BZm9zCPNRRexaBs3BN5mV?=
 =?us-ascii?Q?aE326QtEQ1m60H52ihd/b8mX6hFWtR/YQhVT+32dv5d+mq3SB0A9r5DLtte9?=
 =?us-ascii?Q?1vNCbGNKpUqWZN5iUZEUS8sGfoft4hF87MbuERZod7Fr7XsEVOn7RCMQnr0E?=
 =?us-ascii?Q?uJLUbEMoBFlVabKy31p4XuRl997ANx1PyuY8lZ4nIP54gdNaFT7MrqBMS7YE?=
 =?us-ascii?Q?F5+shyHXk+Wst7YitCuCTYk5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C31D3A8CAA64674685EA987E3E09C4B7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927b1c9d-a469-4b78-b9e9-08d90e4dbbc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 16:08:47.3824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rH6BcUNTTgzZHXwcZvOqOcCkxAYg9akR/LO9GgtzwJ87Xjds4nrwm+RlY7a7wzORypctefxM2k4JoTgSFaW5Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4481
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030107
X-Proofpoint-GUID: _q0Afz_laPpgdnUgt6wikDrE3Oznmd45
X-Proofpoint-ORIG-GUID: _q0Afz_laPpgdnUgt6wikDrE3Oznmd45
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michel Lespinasse <michel@lespinasse.org> [210501 01:04]:
> On Wed, Apr 28, 2021 at 03:35:43PM +0000, Liam Howlett wrote:
> > Many places in the kernel use find_vma() to get a vma and then check th=
e
> > start address of the vma to ensure the next vma was not returned.
> >=20
> > Other places use the find_vma_intersection() call with add, addr + 1 as
> > the range; looking for just the vma at a specific address.
> >=20
> > The third use of find_vma() is by developers who do not know that the
> > function starts searching at the provided address upwards for the next
> > vma.  This results in a bug that is often overlooked for a long time.
> >=20
> > Adding the new vma_lookup() function will allow for cleaner code by
> > removing the find_vma() calls which check limits, making
> > find_vma_intersection() calls of a single address to be shorter, and
> > potentially reduce the incorrect uses of find_vma().
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> This seems like a good API to have, and I agree it's less error prone tha=
n
> having every caller check the vma->vm_start address.
>=20
> Minor nitpick, I would prefer if the implementation used find_vma()
> and then checked the vma->vm_start address - I don't like using [i, i+1)
> intervals to implement stabbing queries.

Okay, I will make that change.

>=20
> But other than that, I think this (and the other patches adding
> corresponding call sites) is safe for merging.
>=20

Thanks,
Liam=
