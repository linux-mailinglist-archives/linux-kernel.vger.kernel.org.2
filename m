Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617293811E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhENUio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:38:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36010 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229780AbhENUin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:38:43 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EKYiwf021267;
        Fri, 14 May 2021 20:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RllRGCrzSTaVQ5K1x8MJF/9DfcQrN5rIaGD9wgIGG2o=;
 b=lR9Qt+f+aeFI6g6u/HXxhE4EMKa8cDqieUIhKt0Y1h832SKdQgH4OUuKPSiJjXOWNsN8
 rRZgWtybfYqbfKq5TbcFYnAlpLuz7DD3B2RWkRdfqT+rpSH8roHTWMYzFCET1wgkhhk0
 2LhWre53vRK+j5IBXC1DFC8yis4dHVbLCU3wKBKcumUR4hZMBrj7nW8VdtmyiTDBpqqS
 xI+fz0kO7YxcBmLBc6DvObrPQ1oPGeucKVRGglk+WOJpTYgUMVo3fh6BEeLseg32T6/B
 y31kJbtoFQATvHGBActCmEnGb5J35F0tEPgJWk3yP8teoeiI+NfZ/k/A2Dtj14QENT43 iA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38h79drg4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:36:41 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14EKaebw074947;
        Fri, 14 May 2021 20:36:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 38gppfa0tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:36:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHnJQ2K1kYIjrwMI41Ty7mfRuROVXVFEsdRpXoMP9FBQAO21pH6+BoTsqRbN+pxLjtEiBWDwJHEHeuYZ+8/YDFLXoIUJA4Qe1pgxA9VC03vxaUDe7zzYAvSsB8ndG1e2D691QxEealhMF+JKA9rUSZoi+1aLc2y9KYPuTZpd9dFGgcOeWp/YfTo1RJZvrIpYC9mqEc4StS+Yyh7ExDaG3zYGo57BmsENpjWuS0Ef+O8zTETvmG2mR6chwpETJvOTEe8n8T7292/6Hx97mW4fec2aKIgJ1g2ITGwyCWg/m8HmQh0ZKHBto/ZnW/8qrRjFkDv/VkOlmcE+sd2WYSpLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RllRGCrzSTaVQ5K1x8MJF/9DfcQrN5rIaGD9wgIGG2o=;
 b=Pyhxq7KEoHELyk21VvdMr/eqxL+xiDaKBd9VZTiWSwCikkvu6lY21nxjWJ1VH2uhEcPPd1aK/CxUOyPiwvYexqto2LjMSVAErcwhUV7P2mxnHuNZM51pnehNsQbytF6cnjFwnCFI6Ts7t2JUzqF72VUc5kMFh+eSJ7TpT7JUE0auHmaMOfJCsL1kOCSkpNBYsv+CgNc4+TaqCWcB+xh6psQ5UAzcPq7SyGruGWY462848l16e6UHNPRHJmVXFub4lpu/17FWRjFuuGOkm7Qdge/dVO/Jn+YXcqYUk7PrFe4yzJleAPcxtcR8hT2Eomd4FDzh0chcBj6ih+Bn6QZAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RllRGCrzSTaVQ5K1x8MJF/9DfcQrN5rIaGD9wgIGG2o=;
 b=g6736iCtNhGM+6M3hTww+mXp8sU16OOFn69SMf6Y4OmecGIREwiGQLpUIaQmY9ntI8LoIwn0PdW6d+d/jpGkp3XCcq+UvmW/ZSr85DsUnnD72Eil6ak8iHHEvWrgvfZEtCJcoFklpv+ZxyWydvU5CY/g2O1bXTOsUxsZ5J/l95c=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 20:36:37 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 20:36:37 +0000
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
Thread-Index: AQHXPEQyRs1g/Qku7UiibZzqyyuzcari4qeAgACmaAA=
Date:   Fri, 14 May 2021 20:36:37 +0000
Message-ID: <20210514203620.ktklltqpco7ul5vi@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
 <YJ5TrReBMXwCqJFE@hirez.programming.kicks-ass.net>
In-Reply-To: <YJ5TrReBMXwCqJFE@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0026cb5c-d8df-4f26-31f5-08d91717f8b4
x-ms-traffictypediagnostic: CO1PR10MB4563:
x-microsoft-antispam-prvs: <CO1PR10MB45635BE30454088BFD3CCC3CFD509@CO1PR10MB4563.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e5mDEvqHyxql1UqcVL85B9mrsykE01/91XarOaHM5wk3WkXCLhrAMAWemNI4hGSsYsYs/On3x/mS/kxCE+Lic+aNeb4SHAK/YP5bhe7z2p8o6ps334BRQn7t/MboeYj4IBNwSMVEoCFdrMstg6WVFejCvSMCR+MbMaQpcDbnB5XDZAiYXyrnXEFzyndKgBWz3UinSdQgyQwxxo0x9ldRbd012sTs4r4FS/shl9ioXzeULZ9aoRxRbEr9vZymNNYyWnTB/1IrCIFJHchbODvRDHy0FrDPqbyZQclXXghrkd6z/QHbFbFiVMIGvYfX4hsIOj35yUQ7ZgtG20joWmm8lAe3XtbdnptdlN2U75PZTrCo5uFJ2ItJxNwTUKMou/FLvma9NxcfOFSyw2nxjIbWOrfdPMiDnOqmw37OAwt9m6h8m2gleflwSYRMRQ6EMe5LQENww5eWUhk/Z0UOHKX17mD1ARkSR+HmqVikFkCxFPf+PA+jOd/0f7XgkcXE3w+/fZW965MpxZxCWbRgJQ8e3m6mZw/J7qCG/GGzznhlJHI4u58WZqZvjDiP4VwRJQCNV5W1qdO707FnF/Wo2KzOBH00Q3mIKrrO5wFPBZn0BGU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(366004)(346002)(136003)(376002)(39860400002)(316002)(6916009)(4744005)(66946007)(91956017)(26005)(6512007)(186003)(1076003)(9686003)(54906003)(76116006)(5660300002)(8676002)(86362001)(33716001)(64756008)(7416002)(8936002)(478600001)(4326008)(2906002)(6486002)(66446008)(6506007)(83380400001)(44832011)(71200400001)(66476007)(66556008)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oceNxxryBuqWspccUJbK8m5nDpbWtu2sjXSv2UEtIHXCbJZe++yth141cSdQ?=
 =?us-ascii?Q?dTSeUERFqNny+AauIwvE+XdrpGU8Ifj1D7Q+VAPuyvdQsPS7W8LaU3h3mFRP?=
 =?us-ascii?Q?nAWnbKIsp0+FhtSfayI3GSEmaGpOARIIDqGQyuF+lhjsQ7S9anMVWgkYb+g1?=
 =?us-ascii?Q?p0J7ECOOyI/8OfzF4PClXpXlbQ9poh+8L4coUm+qGgANT0zu9PAUtBVd0lFd?=
 =?us-ascii?Q?fRTkYzuw9dgJ9WLyy+RayRo3MWC3QKzxqA/R+PFh1zGGDn5CkUrGN/CCCoJ1?=
 =?us-ascii?Q?7hs5wmr98WG3wHkB6ku3zwUZy82HVuMukuJHo0eetM+PN75A/BfVAvPrs77R?=
 =?us-ascii?Q?+VAcoziQVBvCmI5Lxrgb3Rb64uegVFVvpDVdui5z1LrN3rNKZ4MjAS++laq2?=
 =?us-ascii?Q?PyaS22uRkWIdjn+UtcShIhIbYX0FePzukPPbj/WH9Leg3GxizldWB4cKXjeU?=
 =?us-ascii?Q?jTl7yUxqhEroRtaJBs++07xuWONf1UZNwhlZKQPoDAVuSbm7BWlQplV3DBvy?=
 =?us-ascii?Q?vQCMdTMj2VRKyQOcFPzaf50qS6JfTw7CdJqoeo1h3QMMfjkkBhL2PZdsejZR?=
 =?us-ascii?Q?BtiPxiuqmcqZacyIUxSSS13MRizuSlyZZwP4Lrm712AThJTEJPDUU/paV3gM?=
 =?us-ascii?Q?wZ3Vs09ov+ZO3w1L6MHRDLr4VW0hgbFgTTzUg0ZabB3bF1h+aW/ZL+7Q03Nj?=
 =?us-ascii?Q?8V5kHkPawgr8N2oc1ToLC2tiWJBx0dtppY+/SldN5rR9pVX5KkDsfe1wfWJO?=
 =?us-ascii?Q?tge12npIeIc6912BiNGEXM//px7kfFcoKvYXR9I5uvAohq2NlVoRFkeSHzXe?=
 =?us-ascii?Q?3Vf+dslXrTCEzPdoBVuNocqdURt9tthw0MJQatzbrpmJGGomtsnvb8avQMWW?=
 =?us-ascii?Q?NCgHJu/gdnhyfRqFB7q4mMKoXmY9Yo0KhewpSCAHYoIabosz7y6Q+p75cqzx?=
 =?us-ascii?Q?E5f6INNbArh1H0sFkhnuY5n0FeTPO7sy2Ht+q00aGK3J2TaqCmCMVKdhJBVn?=
 =?us-ascii?Q?C7E9vUqCHWyAYvpKvOl1WAA7y7mJUt6XeYSQfxWUDUz24tDpxKV4alQmecyY?=
 =?us-ascii?Q?4r+aWau4d+JD8+ABmZaw+qbcxmIetk/fhYv4hi6gayz0Rg5YCZ2WT7rJgcL+?=
 =?us-ascii?Q?ZKx8WybCarVaP1TysXfTTV9GQzxZrNM5XOSdsUxXelBlhYfcJUH0nvWKH98h?=
 =?us-ascii?Q?FoUcrJk/CGylJiV8mOW1L3Uj93GAVDM1rLAIS+CMp/+hGKlEjn5C0GbhJzzf?=
 =?us-ascii?Q?joiwYB7m0ua4hpGByIR42hG8fs8P0Dkh7EpKG/3QiJbGzn5ovRFnFNSWYv9y?=
 =?us-ascii?Q?mR6dNrHDMTlBb+nx2YYS2pJL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3FBFC44BA94BB46B9EC27E8663CED1A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0026cb5c-d8df-4f26-31f5-08d91717f8b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 20:36:37.2382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nr1wwUtA5b4gjUmiB0Jx9aQuwUbZlOJv2xQxWF4x2luZ27UWg/xo5eHExgBsBdWs6elWauKisjnhzicH7vDbxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4563
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140164
X-Proofpoint-GUID: WyMuprariDwRiQQ1hm8sNSva5liTucbY
X-Proofpoint-ORIG-GUID: WyMuprariDwRiQQ1hm8sNSva5liTucbY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Peter,

Thank you for looking at this patch set!

* Peter Zijlstra <peterz@infradead.org> [210514 06:41]:
> On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
>=20
> > +/* Flags:
> > + * MAPLE_ALLOC_RANGE	Use allocation ranges (tracks gaps) in this tree
> > + * MAPLE_USE_RCU	Operate in read/copy/update mode for multi-readers.
> > + * MAPLE_HEIGHT_OFFSET	The position of the tree height in the flags
> > + * MAPLE_HEIGHT_MASK	The mask for the maple tree height value.
> > + */
>=20
> Regular comment style would be:
>=20
> /*
>  * Flags:
>  ...
>  */

I will fix this.

>=20
> > +#define MAPLE_ALLOC_RANGE	1	// Bit 0
> > +#define MAPLE_USE_RCU		2	// Bit 1
> > +#define	MAPLE_HEIGHT_OFFSET	2	// Bit 2
> > +#define	MAPLE_HEIGHT_MASK	60	// Bits 2-5
>=20
> Can we pretty please keep masks in hex, like:
>=20
> #define MAPLE_HEIGHT_MASK	0x3c
>=20
> Because then it's instantly obvious is it bits 2-5.
>=20

Sure, I will change them all to two digit hex so they align.  I should
probably check that whitespace too.=
