Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8B338134A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhENVoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:44:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10866 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231741AbhENVoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:44:04 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ELgH9K016170;
        Fri, 14 May 2021 21:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=sSuEVJp365CHwB9FNNM/8x07fEs/41ypg5vTDVckKNE=;
 b=M/w6LYnpyn8r5xSZGWUAVL/TOa1e2hRPzNdo36oFtLCuV0WENgMbTCGztWi6vrvU6gWg
 rwjx1EaTF+Dems8X+ou5KppgiijRmEGY39nHhMm7VY/SUNsOlLzyMeoa+6ptqK/03kwQ
 bTSRzpU/QWqoV3vzyQ9c1BMyL27lO0Ca3KHvs+kCkr1llLudT1sQVdFBaOfJN33IEl4i
 54CDASM/wT+O2hb0CksFk3drj79U96W/4fFnEdPOLY0Islx8eDTF3q7z1jUzIwamaS0u
 a+9wVGq8TfOHFEyFhB2oL3EzuLQB24SQah25T4oBX5s0o9CvYWTsmVMg6YG3cXE2saPv Ww== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gpphrux7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 21:42:36 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14ELgZpt071272;
        Fri, 14 May 2021 21:42:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3020.oracle.com with ESMTP id 38gpphjy6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 21:42:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3lYGB2VfsetJqLp6l+m5iIgoeP9T4VaqnZxE9MN0sj+51j2YgbthDzxpb9UhGwRVksgnA0PeZk9ORaMUWXyCUedcr+CN8lMeQPSV8mHRSRTxG5E8syDFnYDHVvAjHg4Hs6oNy3b38SLujxgMVmRjuGXBcjOdK2yb7kaco8n21YMYaCjLcD+3WGOudTnR/AUvpf/YNF6E4ICRPZXKjX7KG8t+diADQlt9F6z/tvRCZ3X1G90z7BLCqKiromywtw1RPZOrXqXbr+GHOZ+eJUZAbBUzUW9q3Nv5ilXMWHxJHg0c44W+KvcpS4BqAqw8CeDf9WERduyJ7S7yfb3vFeiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSuEVJp365CHwB9FNNM/8x07fEs/41ypg5vTDVckKNE=;
 b=fcgFXpNMY5ods1MxQcUYVS7cXq8ySZwrVjuD/0EhmLtbokPYYJa56XZrI+458CnMUrhI9Ny1TWFud495YX+kwXKliw3vWlHxMEsPcEOOYY/L6u7hsQLeUgcWm3BU+RcTZq6/v7Am7DG/iHTXXNVQncSAs2xLd33qXzBe9/cziUjL3ugTjiBH2rcHYcXJbDRGut9+RhQuY0X6QOZT2qQvw1T8ajjoZjZN7CzFMgUGMnoXKBo4nNmKIbiIfUbwGMQak0FR2h4WmDaYN2xAqLxp46qFGxhH6l7cJQdQbKxF4cfggYWoRrSCSSm2JqxUwIGnx+XZfkrGFZghBkbJr5arkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSuEVJp365CHwB9FNNM/8x07fEs/41ypg5vTDVckKNE=;
 b=VB17wFaZM7SKCu9B+8ZwtDiuATBJqxsNZMRFftcZ3SBzmY2727sijA9sC13JgEFewEJQpSswaHseLB/dc9dunZXYS+hawa+7QAA1e9O6k787LD49Zp7AzI1UbOGaNJFqS+47EGu4YsWwmjeujPoFGwopapx4HsSzWxEDKGMEblc=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4785.namprd10.prod.outlook.com (2603:10b6:303:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 21:42:33 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 21:42:32 +0000
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
Thread-Index: AQHXPEQyRs1g/Qku7UiibZzqyyuzcarjFVAAgACGOwA=
Date:   Fri, 14 May 2021 21:42:32 +0000
Message-ID: <20210514214230.wpsim46hpnyyzoe7@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
 <YJ5+LN7FlNjAXQi0@hirez.programming.kicks-ass.net>
In-Reply-To: <YJ5+LN7FlNjAXQi0@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee4f8adf-e574-467b-9b35-08d917212e6d
x-ms-traffictypediagnostic: CO1PR10MB4785:
x-microsoft-antispam-prvs: <CO1PR10MB4785C0DCD2CBC06D0A20C677FD509@CO1PR10MB4785.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iwoO3UtwMwp9RflPW03XDWkOXUG7xafDidyfcTmjMvLjJArzp8XNlHqpNCYsN0xUMCQhU0FJ1toM1YgCtyHjOT6mrxUZNRrXuFXFVyfe6NLDXdFsrXNZzPFWuM0pz24kcaWWeQuXg4w8Lcf7ogA7FuQnq3D9Q/n2hGahRM5XxtxT4nBGNXiPRBo7aoJ0lS6wZYR6n7ZqZ3g/8RtR4u919B86QLJt8PgDXTKLrRmzjA8X+imp7uNJ5Z4CWm9iKHz9rPzEVl5FcT+4YExV1AIDC4I5jswuKL5XF0CeWmgxooBYgol9izTaLXi0OZrufxzReqVThZA9zaGQC2cgZrUHGgFF+rNVpJhZVQDvQKbfRCggrTTlvE4/QFAzmQI53jvvvTayzbyplXsEJNnKrtwTJOOWH177xaZifd01n/pds20HrFxpsF4Dwjq0dYN8xn0HysDrD4++5ntVqSbxjcLzKDTZNGYU9NuPw7aCbdN7yszdnhuk9Y4GGLo9LlWiN4RP7TKLyeotAOrwCLn5tWx5ycCwdXuXw4k7cAeddr3iHHtksok7wrxEUSCSG/Da6chAnlacp9dRel4j+XKkzJPbbp5nv2P0XT32tIOIwU9dHZk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39860400002)(376002)(136003)(366004)(346002)(396003)(71200400001)(1076003)(2906002)(26005)(9686003)(91956017)(478600001)(64756008)(66446008)(8936002)(54906003)(86362001)(316002)(76116006)(6512007)(6486002)(66946007)(66476007)(66556008)(6916009)(122000001)(44832011)(186003)(38100700002)(33716001)(5660300002)(8676002)(6506007)(4326008)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?J8HK61+UNihlCw3He9ELusRzK6PliO6kq5NiAPF4owoWYb0VmEhLm7+qHTuC?=
 =?us-ascii?Q?Hf8Ooys5jgf+PzH55uR7mQZ92g0iXrrn+CDiJD0SRUKQ0aBOt6rF90L/37cN?=
 =?us-ascii?Q?gSgfszicK/ty7t+zyXw4jDDcURlPen8kZq3E/pNRfepVwAkS5N8U3CxviklM?=
 =?us-ascii?Q?rSA+e/2TBzNJXrWbd1omhoZnIPO1PGMfIkqUqZCo787TV0jjJdbV6Q0AaHGw?=
 =?us-ascii?Q?cTShoBoTi15je+g4PXYPu0MZE0tuwC0szf0Y+Dgwtlbd5b8RGdjjoFka7knf?=
 =?us-ascii?Q?zjs7eBEEakV9RHDWmf5k/f44eJS5/RyBzOF3/gePfXNUkTmJdPorjKLjblhn?=
 =?us-ascii?Q?rYux30dL5inOtoUeP5FfAVIy8Bz3RVbMWpWCxWYz+tf2sCV2LQLC6deb+hsX?=
 =?us-ascii?Q?EMY6bJdAHpsicv/xHhpCUuZFIj1GEuW+1QyqXKNP9r5KcaYsnGs6QgLa8ikg?=
 =?us-ascii?Q?nM7zE3MJT0EbmL6ctfCrFlyx18ixEeVSEdAm/zCON+fBaWBKYQfhOn51qHus?=
 =?us-ascii?Q?ylp1zErRKA/6c3juZJoi+3HOX6LGBv7zJE1mcNUx4yd6AKqnu5d+N1Ul5vdl?=
 =?us-ascii?Q?eHNMkVgg5Fnx9MErogJpOFSxIpD4EZYF7Z8nAUCDirEB33ceGuyIOECKicEh?=
 =?us-ascii?Q?zZkVLh5mFFrYXYIpIDpra9kvViHw6W//dR2LBdCR54Rt9qQwSV1Oq2hQAFQx?=
 =?us-ascii?Q?zKyFMBXGO/89nPYjztCNgwimERk1+zsyfBLyzpK6I9ogoqmuw+3HsMFKSqX3?=
 =?us-ascii?Q?aYcmHa/Rk9kxeZdLqnCTGqN+7g44VID5n/VFXSGSnpHx4cOQRLsF/4dKShQk?=
 =?us-ascii?Q?7ZHz1gGQK83aoX61a+qmrt0hAipyZB3BY17t8OwZbRk2qtHWylLgdYbPaiRJ?=
 =?us-ascii?Q?xSmfnZqnnaM9mbP3D1pD1CDqVUzuwEoooqSKyKlNZVKVeGgKuXW7nQb1iioR?=
 =?us-ascii?Q?vJADIbBKxXMQ6ZxXyXnWS0yWUhg146yjIGVjQGRQifvTZv7tN0nJrdVYeiS2?=
 =?us-ascii?Q?jVscThMSRUlfUJapRL8MZvkaPRaH30i/3H0qEmCE4QwcDEv0zTAJxyMtz4mI?=
 =?us-ascii?Q?CNqs0l+bnulFX+nYo/vE/yUXsYNxgG9FQ6V6XnedPzDoVr+cVjaaKs44Akut?=
 =?us-ascii?Q?WsxpeEhJ8MFs3SNIPofbn0taoVrhzXu3hKw9TpHAUd1wE9UNH7H3nM0WCfOj?=
 =?us-ascii?Q?Og1Q3IdKnzQfuh2ypwj9ywZlCHrxGJwF1956dYOo8xnIz/g/VbUbDuyISCpO?=
 =?us-ascii?Q?P8kd93K/bpw3Kg6PCe6QduHEW4YC2VBZAcBoRiMp4eDnhDHPH9DnFr40MvEL?=
 =?us-ascii?Q?xKiTMrhwNloPl0yWbIwZnpyH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3194DC18646F94F874110A96300B050@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4f8adf-e574-467b-9b35-08d917212e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 21:42:32.8731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOIN9qB8BTfDYAaP5zlED2fgxa9PJKLDyTi7IsUOKJT+jePSo4+G3PDE0SoOVSGvKHa3ssrD4JoB860QVWv8Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4785
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140170
X-Proofpoint-ORIG-GUID: YcOom5CHo7k67c-qRDf9xmv92hg5Uz5y
X-Proofpoint-GUID: YcOom5CHo7k67c-qRDf9xmv92hg5Uz5y
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [210514 09:42]:
> On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
> > +/*
> > + * mte_set_parent() - Set the parent node and encode the slot.
> > + * @enode: The encoded maple node.
> > + * @parent: The encoded maple node that is the parent of @enode.
> > + * @slot: The slot that @enode resides in @parent.
> > + *
> > + * Type is encoded in the enode->parent
> > + * bit 0: 1 =3D root, 0 otherwise
> > + * bit 1: Reserved.
> > + * bit 2: 0 =3D range 32, 1 =3D [a]range 64
> > + *
> > + * Slot number is encoded in the enode->parent
> > + * range_32, slot number is encoded in bits 3-6
> > + * [a]range_64, slot number is encoded in bits 3-6
> > + */
> > +static inline void mte_set_parent(struct maple_enode *enode,
> > +				 const struct maple_enode *parent,
> > +				 unsigned char slot)
> > +{
> > +	unsigned long bitmask =3D 0x78;
> > +	unsigned long val =3D (unsigned long) parent;
> > +	unsigned long type =3D 0;
> > +
> > +	switch (mte_node_type(parent)) {
> > +	case maple_range_64:
> > +	case maple_arange_64:
> > +		type =3D 6;
>=20
> 6 =3D 4 + 2, which has bit1 set, but the above sayeth bit1 is reserved.

Yeah, that's not good.

>=20
> It is also mighty confusing to have two different type fields, is there
> no way we can merge the types into a single (shared) space?
>=20
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	val &=3D ~bitmask; // Remove any old slot number.
> > +	val |=3D (slot << MAPLE_PARENT_SHIFT); // Set the slot.
> > +	val |=3D type;
> > +	mte_to_node(enode)->parent =3D ma_parent_ptr(val);
> > +}
>=20


Sorry, this is more fallout from removing types for the initial merge..
I will re-examine the mte_set_paret/mte_parent_slot stuff and fix the
comments (note range 32 above is not even in this code base either).

The type space maple_range_64/maple_arange_64 cannot be merged into a
single type as they have different slot and pivot counts.  The type of
node it is depends on the immutable tree flag for alloc on creation
time.  Since both node types cannot exist in the same type of tree,
reusing the same value here allows for more node types to exist..
Merging them would cause multiple checks of the tree flag during a walk
and function pointers are not as fast as they used to be.

I can just set type to range/arange right now as it's the only option.

Thanks for highlighting this as confusing.  I'll rework this to be
easier to understand.=
