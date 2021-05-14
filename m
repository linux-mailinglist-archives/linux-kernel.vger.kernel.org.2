Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1193812D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhENVbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:31:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56838 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhENVbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:31:11 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ELMXg1017740;
        Fri, 14 May 2021 21:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Ysag85iuKuZ6c7yujhy+FvAgb29Bs+c6KOrhtnHMLk0=;
 b=ZQf6cEdVPAe1xRD4j+lTHaY8hwWtK4bWb0SG0C25011H0ZGNjHXkD4bStWWnRX628Hi1
 vFFpKmp44Sk3WAvLBsPc2Dn7s7kguuRtLY4p0dyPZMNqGna3rHRMDVTPTI0NQYS7BlsW
 6WW8OF1VJExoxvEeZBknT4vTEW/bYtsgAhN5SdwCg+ZB2CdFne0ocF2nRx2UGnSO4NmJ
 bmb8PkKUm+PndXVk1dP0GqSqdHLB+FnU12WiV8CKpa1lk2wcM9WSOT2fbGQhHxNCww97
 qUwrA82PAM48PQIgAOaoU3pPj2V0pit0WYhwzH5cOf20aJZ20NCwIoHw+IK0kw8S9Y7t 2A== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gppfrunx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 21:29:43 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14ELPY4S040241;
        Fri, 14 May 2021 21:29:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by userp3020.oracle.com with ESMTP id 38gpphjrkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 21:29:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFUlu65WaR6tzfadY40ck42jcFU1qOy0WAIpfCWl1ampwDLNcXZpkTqR9eBM3WIy8XWauzg6xBZQvxgonEXmteZq7r91+th8R+stZGGKhsjr/lbs63PWjIwfiY1MDG62ZtWGl0PCJqptVTZ8ZPEmaqXkKOEUk5LL1ZlahjTt7HYlKDAcHuVZUd5CoYwQguLUhpo9fEBnFrrO74bbFvNDAw/fDHhcLBXEKShjCPET80nsGw1y68eStgc8aaDy3ihkpmi+ddUO+J9FCbqYy7Yd61YxeIxptiSHtMEWj24aqBmADCb1ys6zqnGqkuzYYrApgBHgOlF0ZRye4+mV63eFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ysag85iuKuZ6c7yujhy+FvAgb29Bs+c6KOrhtnHMLk0=;
 b=TeK1SnT609+AVBb8MxhrcG5Ht7RQieij+IPCt+/EosZDRga2JOZyczHOjcOkBB4WzqfChwUcO3M+TjqlQVgKNqnk9frvUM0QKU5LQ7pNSgBEd0Ng3kyjsOMuPE1wUwiFAbd09ElTVnKN2yUe9Z3ZjP+y3kMD5TBA+86B46Jp30XQuDXMIeB8pvfJpQCMrfJj1w8vnaDCur3Ov6Pif6hlkgbmPrIFPSzVZNcYKDndAztGFrs9GsCUPeqkGzP0lp4uWy14gjEqd/bCgQ6VoxUJE+pkAwZSfR2XD5SOBkoP3o3FjslL0fy5nORw1WPf32u87uFNP5DNP3OBdyrRuaqLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ysag85iuKuZ6c7yujhy+FvAgb29Bs+c6KOrhtnHMLk0=;
 b=oL9KHG83avEFfT80MhdLc4kGb4/dZxE227ScPOEhK5hrAj1ZlAcz0lXcw2M+VAfB9yTgVPp+UqU+7kXeMMk5CdMXBny9S82923qaJvO8L6AH5mmMH15NKkCOufdQChXEFnBH0LmHRgEh2dQc6vypIEUk83NIlrFn62VUWW1XdWY=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1984.namprd10.prod.outlook.com (2603:10b6:300:10f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 21:29:40 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 21:29:40 +0000
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
Thread-Index: AQHXPEQyRs1g/Qku7UiibZzqyyuzcari/caAgACaJAA=
Date:   Fri, 14 May 2021 21:29:40 +0000
Message-ID: <20210514212930.3vprzwvuyhh4sdml@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
 <YJ5qbS2KJcVp+ocY@hirez.programming.kicks-ass.net>
In-Reply-To: <YJ5qbS2KJcVp+ocY@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f61707da-207a-4393-0ee1-08d9171f6201
x-ms-traffictypediagnostic: MWHPR10MB1984:
x-microsoft-antispam-prvs: <MWHPR10MB1984FFADE30D7DD34C8D16FFFD509@MWHPR10MB1984.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XfFUfh0ZLxqeCB4bEGXgIqKNiQdzrGZm0e5O6JLH6BNZ82jr+Hjl/IzfdmvFi7hfh6EBKJfS6L2+Px1qKo4+j2tMVquDtlNRYVsojFVGGu1JmNdYobFrQadvxXlIVLo+7BL3eXXuaYRFeRu+TqTZpA3bmSIhm701rnU0LNkWjZkE/Q5bw9L8+lZJixNis2h3kD6vLgQ9VzVOwrsDPRytsvuvo31/h4wgbjn9lGHIwtzpvgxP2m80s5Cl4zXarDFYmxJsPuaY9OoM+cz8eZKixu+d7DZLXvihW3lUCi7e3Orv5Jq+IwjzUHQC85PKxRcyacgD8jHBIpzy/8y3XNb6ER8gh5cNxzbQihQgs5wS2d+4KoeYRBzZgTtHkR+IQvTp1U2HpPOBXE0TqruZ1IU6wFDiMxh3nrF2Tvv6b7g0gz+dbYep4iGwUJIUZMQgHABZC1w9ciRk4pn1mD2VoAHs6+78FwugLUeoGgsdA9ro4UPnKSIr9vEcA4Uw6M40j1wj5e5eDyT/c07OzPx170rXNlmxltlbuvE0b3bnwPgKmCtxWyq5m3Uxlirh8wuQwmt76Khs4p63SyLClc8JjH+N2h8jqNq0ujFF0R7OGm7Ca3A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(66446008)(186003)(6916009)(44832011)(122000001)(5660300002)(8936002)(6506007)(38100700002)(478600001)(86362001)(1076003)(8676002)(4744005)(316002)(7416002)(9686003)(2906002)(71200400001)(4326008)(33716001)(6512007)(64756008)(66476007)(6486002)(66556008)(66946007)(76116006)(91956017)(54906003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?y4Y+azx3PvH547N7RLPwEA8Xqh6CdCu9YhLilccP0xycnCCzSgOXPPjcRsiX?=
 =?us-ascii?Q?use6d20lnFBchH9Rk3fDsgXn1nwL31tQC8tVO/J0vj24VaAXwqBVjBaAG9sK?=
 =?us-ascii?Q?gxAC8T2cCnLEvLAzOuVQj1UWNCKDtT5jchew2tIOws8bBZe71ZiX/sx86me6?=
 =?us-ascii?Q?OB6MqCnhqiXGyauO4VSy+k0YoFpWN+FnwIBNHqSJHGWbhthNnimY4jDyJiDJ?=
 =?us-ascii?Q?OLDejtnRtVQXWY8UTu9oi886bVuZQmqZ30KJMHGE/Taouy+pKbKAUc9oQJTc?=
 =?us-ascii?Q?mCY+qsz2LbLK7Yqbssw1byOYBWkAWcb0ga0ZW0Qb+IKuZaTK1mPIkGO4XwSb?=
 =?us-ascii?Q?kS89J+ZTtcO6hFjUtEL2kt3oj8omOqmFMXDGCgb4OnKxvdvHP/j4W4B0DNj6?=
 =?us-ascii?Q?hRsJfwOp14d4Q+8xTtCQRQhwyqqOGT1uS/sIfqLcUkPBFkHU7DC6bBngsSop?=
 =?us-ascii?Q?FlopkSn5IonQIrnki/AIpIVw7VQFo/BpVTgwcIH9Y1qYq8wJTssC9pMUIFgS?=
 =?us-ascii?Q?29oM9SUJjlxvfrb9i/4RxqBHNppTZv0JFYebpqfGX5Rw8wi1bupAUHcxf/Uo?=
 =?us-ascii?Q?uuetp5nbqiB2ibhCsYqlnZsFICig0LwfdEbAH7MrZE+fFoOtEZzW96y/v1WS?=
 =?us-ascii?Q?7ilfOVHvOv2n25vK7MWlhwIgGgs/T9sNzD9C10tCB1g3FUkEnLlKA1kbE9x8?=
 =?us-ascii?Q?wMDKmNEFXnvGMli0gQmlKNhIKgua8TV92PDmy9jk4MoZcUuWuE9zi4/JKHIm?=
 =?us-ascii?Q?rMmJ/p5HCbSntajX/j1VcJV+jLKQOc2DVll20VKbV1QTt9dlYoQkQ20a93ai?=
 =?us-ascii?Q?qCgZimIdr+TOgh3XahtTLa+c8QHA7a4Zz7iGFu9lZ4TcZnfL0Nowad0GRGzu?=
 =?us-ascii?Q?odccf14D0ib9Ze/43tn61VsCq/mOHk6yam1y98LxwkjFqlIHmdzTtzgrsWtl?=
 =?us-ascii?Q?zBnrBWnlMVvW057Cv5Px0RWsT83pJDto3U2gpVi2yjeEA9aNJACj0YuAPEcP?=
 =?us-ascii?Q?OgA84z4PXhvE8iPZbaGcABz/PN0/z1AJdUsNgxMhsHD0xe+yUswaHMiku3vU?=
 =?us-ascii?Q?7Nk5NctbFkzJ0t5J1y1F8yg2HQU5ET5Fd/ePfQyprDdeZwxC2tUUvhB5hA1V?=
 =?us-ascii?Q?nN/9z+/mZ3j4KiCXzswcJksXMoKWrB/HkfLIerAbO6Un2DwivkGTF5+roxMq?=
 =?us-ascii?Q?Wr3HSzJij6GJHA3o2kRAyi/QSVidQypnnWVUjKomEY3PAPipMmWzyGO7gzVd?=
 =?us-ascii?Q?hGeAIfemduSnckmQP5BsjBI4OloA0NRMZbL9pHuq581YLF0rmsulaccO7ZUu?=
 =?us-ascii?Q?hXFt1nmsVsR91m/ezmMHx+Rq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DDFE655A092885458FF4EEC420A2AE52@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61707da-207a-4393-0ee1-08d9171f6201
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 21:29:40.4037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSdNcayZDmNvbQBLJNzFoN4fdTDQChyqOpeCRqkUEJt6hch+L6EZzel+rrCOhj3R+vs/RBY+Cwexhj2c64q4ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1984
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140169
X-Proofpoint-GUID: KtUPG4lX-8Q4AddNupVxKIiKXa09PTEV
X-Proofpoint-ORIG-GUID: KtUPG4lX-8Q4AddNupVxKIiKXa09PTEV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [210514 08:18]:
> On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
> > +static void mas_set_height(struct ma_state *mas)
> > +{
> > +	unsigned int new_flags =3D mas->tree->ma_flags;
> > +
> > +	new_flags &=3D ~MAPLE_HEIGHT_MASK;
> > +	new_flags |=3D mas->depth << MAPLE_HEIGHT_OFFSET;
> > +	mas->tree->ma_flags =3D new_flags;
> > +}
>=20
> This goes sideways when mas->depth is too large; I didn't quickly see an
> assertion / range checks for mas->depth anywhere.
>=20

I will add an assert here.  Thank you.=
