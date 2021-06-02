Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFD6397DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhFBBMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 21:12:53 -0400
Received: from mail-eopbgr1410054.outbound.protection.outlook.com ([40.107.141.54]:4933
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229687AbhFBBMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 21:12:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFexZHw/FIlYLALEFWXumdMevUO4dvoCPAUKhyLX7TVUVakDHtSOy/62YqPsV4h2aUT//OinQBMs+3UHd/IuMiACximfN/+ZZkmGBD+o0ey9bM8ohICgK0yPhwSulwnF5Jr1TqqjbzV2EZt0dezUR5C05a2bCrYsUWmC5gxyLt4AkyPNgBoZqugtNJwcr2s4RqoUD0Z33HNFqXbd7puk4YICr9rlXUoSu2QKly/lB68+cFwZKEvOs35eaETPEGgqtuTy4e3bnrIYGuLgb+ywQ6gq8fU5BOjMvQkeveySsaEyRp9F+gur72ixSSqe31rl+Q1zW0QmRypfXP8AvDJUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWJgLzHKxhNJUE+Tw9f1cC14jGXMNbPdd/Az72Z2AQ0=;
 b=UBhWe6E28R5OTnObG+jb8rIFui8SecK22FAkbyZOmJHddbzvI4V7ENd0Vn//oBj513AZ1nJVB6CUMfegAAlPOxn226TggIuUoD+x6NFMm4KL9uS1cIXuwUeDsCxiULRDreleN7HG/ZTpXaFKB8N8G1gKVxYKQp+e10CiFVuyACBJQCnq2hCViOrY7Dtr6t4t7DuNV1t4keMD/RE7J4RGK5x2Zxkivt76VYGj/pOLKVox1USaf4KsXuzJ8BOeLpGZTG+LfxaQ3vHRa4y4OwrsU0BDlLW1Zt5NDvwKo0AAn/urFmBi2i/IYbD+l+ndRS49B86HW80VAiut7g7T1BD6LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWJgLzHKxhNJUE+Tw9f1cC14jGXMNbPdd/Az72Z2AQ0=;
 b=e4QmoXFtziHCVgwxPYuREXtK/DJYg5NqP75d9WKzBY1PX0StnpeR5exy0z/0bDXcWElPDPS3L4Bs3xzXr8an+HHmApy7BEt00TZEWU/jEtlu4G7RwTr+4ToRP8vRiZloq4izT22ecLPHmNcxp42IpOflkfwPbEjY2tdrjEx1d5I=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYAPR01MB5882.jpnprd01.prod.outlook.com (2603:1096:404:8054::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 01:11:09 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::6c0c:4121:b48b:7f91]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::6c0c:4121:b48b:7f91%5]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 01:11:07 +0000
From:   =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?= 
        <k-hagio-ab@nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
CC:     Dong Aisheng <dongas86@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: RE: [PATCH V2 4/6] mm: rename the global section array to
 mem_sections
Thread-Topic: [PATCH V2 4/6] mm: rename the global section array to
 mem_sections
Thread-Index: AQHXVf5It4/cv5fnAkyoOipmGTT39ar+0qiAgAAD+ACAAADYgIAA/vwAgAAHHqA=
Date:   Wed, 2 Jun 2021 01:11:07 +0000
Message-ID: <TYYPR01MB67775E2EC60DEE1195A49577DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-5-aisheng.dong@nxp.com>
 <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
 <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
 <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
 <20210601165246.99d7374d07661b7e91e49cb6@linux-foundation.org>
In-Reply-To: <20210601165246.99d7374d07661b7e91e49cb6@linux-foundation.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nec.com;
x-originating-ip: [165.225.110.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81740d90-37cb-4d64-fc1f-08d925634d44
x-ms-traffictypediagnostic: TYAPR01MB5882:
x-microsoft-antispam-prvs: <TYAPR01MB5882E857E317593299C1E50ADD3D9@TYAPR01MB5882.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gD31i1uil5uVgixpsx8KJT2sCBvLlN486llOQA5BrK5MckomQUHIgaztVsFRdpqhbhcC73DkLAByltB6f4GfTmVMr6qSaDvxW9K5/WJJL3JQiSh64Jg7kGeGSNlD3ZdTqvfp9FloDAQdBN7nHUbLCA5P3B9GhqpZzUQtfEzypEE9Zr2VFxGCZmzH03GaxfSHgccIeUTJKmi2T0SDHqsJVQ0Or+3jH0zLZZeEZJUt+Wlj52BoUmkKxFg8E2UsUhy2j1WVtGuD0s9o9vCkmMZlYuiWpG44mETm/H/yzkigf2Kjm98M45DwIWl6JAS+kL0j1L9blSidd40WL6m319VpFyfg0MQeA5/yaspQm5a/d9OFWzcLGQjBvduqe0lZKIoUoVwnUVoQAfr0gK6Q43wngXZZx4p0nKCbThOkjOSdgtYTktEHqZkMJYXcSgOitVC50FhXSg22MDubCFRKYRS0PecKtWWeUqbCeLe8FE8r29K8Ke+iQfU+QLyI0HUGg7wgEFl3XS64b3yuniblUo7FlQrfhkj1OnRyKwhOnU1BbrZEFniuXrTk18Brt8UYb565nO5x0v9wq2HXpbBaRFpvtvKsyEB1jxaY8x5scY/oL7Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(8936002)(6506007)(7416002)(5660300002)(33656002)(85182001)(2906002)(478600001)(9686003)(7696005)(38100700002)(55236004)(83380400001)(122000001)(54906003)(316002)(86362001)(110136005)(66556008)(52536014)(66476007)(66446008)(64756008)(8676002)(76116006)(186003)(66946007)(4326008)(55016002)(26005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?K3VuY1BNZ3ZNM3N1ZzB1Si9EaEFzS1JRL2lNVy91VWFjYWdlYnY5RWg3?=
 =?iso-2022-jp?B?ZVFrVmhuRjlWS1lCeGd2c1MrREV1S3lydnp1VHdVWU02OUV6MlVXcnRP?=
 =?iso-2022-jp?B?UVBVQzVPZmNDMEpYTEVoSjdXWWtJTkVNa011dFY0RWNlUlFLblNVNmtY?=
 =?iso-2022-jp?B?YzVPejg5WTRWcnNocTNJV2Jyb08vVEM5Y05vRDVzaHc0SlAwSlZ3NVNI?=
 =?iso-2022-jp?B?dUlrSVp3ZjFBT0dMZ3VRMWpNZjFHUHlJV1N0NGdFajFQdi9SVW5ZWDJ2?=
 =?iso-2022-jp?B?TnpHMHBzcndmWHpQNTdmYnFQWlhsN1h6T3dkYTRuN1lyWUVpbUdnS3pO?=
 =?iso-2022-jp?B?d3Fwd3NPaXBsaVNRU3R4MTRVdUpDNTBQdkU5TUV3eGVKTkJFRmZHblZ4?=
 =?iso-2022-jp?B?RGQwUVpvR25uQWJWTyt2OU8zZWgwU2ZaUTQ5M1BabVpoRVM0Z3dhYmFP?=
 =?iso-2022-jp?B?QkxYdXh5eEVGNnZuUGF1enhiMXg2dk9LRzZoV0h3alk2czI0NUFaMTZu?=
 =?iso-2022-jp?B?Z2FSWDhXaXVKWGcrUUhwdEUxWDdTYkNSM3RyL1hPMTA3N0ZmakkxdnNm?=
 =?iso-2022-jp?B?dXlLbjJZRTZSQ0p0QWtscENkbU1OaXpwQ3VBRml2N3A2YVdaNzQwQXNU?=
 =?iso-2022-jp?B?Z24zcHNieHpCd3UvcWhWQTM4ZlRDZHBvQUdRTVVlSFpRdTBpVW56RG1z?=
 =?iso-2022-jp?B?c3hjRE5UN1NFQ3FDVDFSZjhYempOdFV6b1M5TUlKUlZuK1JHVWM4Y09P?=
 =?iso-2022-jp?B?aDd5Z0VweThkZEdpdjl3c1lNeWdLdTd5bzRUWHpqWUU0R1ROVzN3cU00?=
 =?iso-2022-jp?B?ZFNvVzFMWDd1c091UEdERUlCVmg0MlBXK1JJTjVjRWdUWjJSUjNLVDVJ?=
 =?iso-2022-jp?B?M3MxMC9reDNFZUhYMlNtVXM3bEJsQjhpWUo0bHhVSFd3S0dXd1ZQT3Z6?=
 =?iso-2022-jp?B?dm4xaDBZcW10UmF6K0ZlM0VMbHdYaUZPemtDQ1Q5MnIzQjFiYXNGU0Iv?=
 =?iso-2022-jp?B?eEd2Q3U4YVdnNFBKenNCdnhsNmcwTXF4N095akN3dFFCcU1wY3dpV2R1?=
 =?iso-2022-jp?B?K1Vnb0tSWWw1eDg2eVBaN1E5VDE0YVZQalZvWXhQYVAzN3kveFBaSEU1?=
 =?iso-2022-jp?B?Z3VzQ0htbXdDYzJGUENIOUFBQ2VFREN6S3U5ak1NdXQ4QlpuM3ZTWEIr?=
 =?iso-2022-jp?B?MWFEdHFmVldNRzE5ZHJ0azE2U0NkRUJVSmJzUkorWnMrKzdEbUQ0T3B6?=
 =?iso-2022-jp?B?OFRsaDhLVFF2L1VQSFlCRTlUcWZNY1pzUVByeFZHdnZpMkNOdm91RGlq?=
 =?iso-2022-jp?B?L3hRSjlES2tteVoyQ2srbHJFYnl1N3RSczBLRVk2WjY4Wlc2blZGdHZx?=
 =?iso-2022-jp?B?b2pDU3M4L2RuSnVXSTF0aEFqSmdabzFnMXZRbG56V0JXNmd6VFZlWmpj?=
 =?iso-2022-jp?B?MGI2MFNDUkpJWXIzUVZSWTArWWF4MWlDU1Q0eU56Z3cvL2xMalhEcE4y?=
 =?iso-2022-jp?B?OFhhcm9VeWMrU0dYWUc4K1oyNlpIUlJTUUkvcG1kWXhwajVCUytXN1lZ?=
 =?iso-2022-jp?B?QmZ5ZllkZ3RRNHJiNjRnK2tqS3ZiTUJqd1pybEM5RjZMeE5zSDRBR0JF?=
 =?iso-2022-jp?B?Y1Jid2NNNjRwQ0VZOHZZTTEzL0RMWktQeHpFM0g2WFR1N1pobGdrcUNn?=
 =?iso-2022-jp?B?TFVDMWdyQWo2cUNPNzdKRnVaZm53STFGdEFGUDlOeS9iSitqcjFWcWo1?=
 =?iso-2022-jp?B?ZzhzbHkzUGxESTlIclB4SXlpam1YVXFaaVZFOGZGcEltcEVhSUM5NFZO?=
 =?iso-2022-jp?B?WTJIK2RPdXhRb1pPYlpkVzl2RERQRzRpTFh2WHAyblptRlk4cXNxNEpR?=
 =?iso-2022-jp?B?ZEcvbmFXM1lKYU5HZkI2UGF0WFFLYTJ5OTZwVzFqTm0waFF3OUg3YWQ5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81740d90-37cb-4d64-fc1f-08d925634d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 01:11:07.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/DBDwDFJWwP0bOU+sr0qIx/v1pRyfXd5DXxJRubW3/8Uw2WUgSuuUjV9Na55v3qw6L5ST6aQjScflSs1YZ47g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5882
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
> On Tue, 1 Jun 2021 10:40:09 +0200 David Hildenbrand <david@redhat.com> wr=
ote:
>=20
> > > Thanks, i explained the reason during my last reply.
> > > Andrew has already picked this patch to -mm tree.
> >
> > Just because it's in Andrews tree doesn't mean it will end up upstream.=
 ;)
> >
> > Anyhow, no really strong opinion, it's simply unnecessary code churn
> > that makes bisecting harder without real value IMHO.
>=20
> I think it's a good change - mem_sections refers to multiple instances
> of a mem_section.  Churn is a pain, but that's the price we pay for more
> readable code.  And for having screwed it up originally ;)

From a makedumpfile/crash-utility viewpoint, I don't deny kernel improvemen=
t
and probably the change will not be hard for them to support, but I'd like
you to remember that the tool users will need to update them for the change=
.

The situation where we need to update the tools for new kernels is usual, b=
ut
there are not many cases that they cannot even start session, and this chan=
ge
will cause it.  Personally I wonder the change is worth forcing users to up=
date
them.

Thanks,
Kazu
