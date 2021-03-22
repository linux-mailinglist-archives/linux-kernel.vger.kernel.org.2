Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D850344EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhCVShF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:37:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3525 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhCVSgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616438201; x=1647974201;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1EaA5oPXDXN+Y/LuVOH2Nq3RdjfrIxGKjyMRDx8lCDY=;
  b=LUc3i6sSOqsdrfXxfqjxVaN8Oh9hBa7r2FkuieBkplAqrqmukPYDlJiQ
   +G9yy4dAHkkSanS4TjJTroi3qxS1uEJ53uUl4mtBgnMyDP3X+ZUU2Riq2
   7GJp00gbvbh0YcnkFXtk0Y5pJu/MmOlZj4z9w64m0vEvg/OlkUz0lZQ5A
   zN+k1zS0E8dAPLwaeDGz8MdbdfCgjF8Z+LawONpfLenjuH6lqyYsyyjbH
   /fWVNSyMmCk8lzkdX+qFCL5874vGIU43kmKX7wdOqCPlHy3zWIkpdUvOa
   n7kt9PATzgeF561+0UDNh2kxrkx8u3pB+nCkptang2aY+rsKka0sM7RSU
   Q==;
IronPort-SDR: VAmtM8jAeur8cxrrc6Lwrda+hiW0nN4k1YZjT+K980wvVxwWiQQToqmrrr3ptC1u3rc1QW/Ffu
 eiBT+DQw+FOljFa8nGCDDwPeanubWIv2kjVen3k54ZJ9cArhLEe3p3tghuWXLcCt1cyMmlQ6JZ
 MzOLgl2wVSv82VRZn96nV3dxVVAas4+h0HVbN5y4oJRK2xDWs/pGSHnHPkh9rxBM7TUXEZO3al
 NteX5+jiwzjB0qx6o1Q8ByBvj+RRqFKisj1oaZhI4BOLAe740AQ1MRok+T6lTQGkUeYEp9eYh1
 29o=
X-IronPort-AV: E=Sophos;i="5.81,269,1610380800"; 
   d="scan'208";a="162682321"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2021 02:36:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqcYttPvWizz/zO7DWtfkwW2+FSi+/3fSY/LlsYtumfU1PUEtyFYCRCCGHbOgKKaIW2vnyKZYmfDm50Yv/GoXynyw0LTc4Ju5AH1h+dL16XkES0yXjKX5/8Of8IbERiziBFxhqi64o7EncgO6O27CbNNwlmIGDQMWq+0fTmfyQ3irunMkpLWPGGhsWgzGmQ/yBJZpg+k0kUk4fgI8yXuVUYuGCMZDTf1FvVUz8uA1S1gacATvJ0O0BIgPoFKzhuCX8SWMMMU8ktTGpHLUKiztPmdDqF0QEaezbhZt57IzzjlcYMJgMuAKkk1Cuc9xKwIukmhx1yKOYj0cPsj3bzhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EaA5oPXDXN+Y/LuVOH2Nq3RdjfrIxGKjyMRDx8lCDY=;
 b=gbj38JoHGSi8HXgNqWz5NaJVqlF7ps/TIdWBPElGttVy8PEF6Dy85FfE74qqo73y21g1V/Xz8IiDI+dDU2RbytOyAmbLw4zvVuLGl/yknz0iuFfvlPCcoT3coIwUW3/NkkZcicRJa2kpTKQA2H0aL9fAULGow8wlKq62aFldsGhvno/QzB0V+EiYT1oSa59D3YtWWj4NGjvLCohCH8s6FkCtlkn6KXTUYemN+txA34aAyxksVChT4uLOO5rOypGKZXOiiq6+OppnuTDQ1qNFshTuB6gRFyMLzuZj0/1BZr3IIT1qliVCaZ7628RBdOY9yTUGL4BVeKRax/9WvV+Akw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EaA5oPXDXN+Y/LuVOH2Nq3RdjfrIxGKjyMRDx8lCDY=;
 b=Q+bN8iBQTSofF8M1UVbGyCUgJeEi3rLBQzqfyeOCUaWdTdSrjLyJvsHr1qRrVg84oyV7FwGo4BGmjah6k4xECg5tvO+JJosDfLb/YfD4CJrNRFlFi17fVHwdJhWcJbOgRdb1yQX5dyh5mb9R1K/uldjPEnHDvWnmLGFtI265nQc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4664.namprd04.prod.outlook.com (2603:10b6:a03:11::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Mon, 22 Mar
 2021 18:36:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 18:36:38 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH] nvme-fc: Few trivial spelling fixes
Thread-Topic: [PATCH] nvme-fc: Few trivial spelling fixes
Thread-Index: AQHXHcoFr1kwOc58ekiO+1Ex1F2gVw==
Date:   Mon, 22 Mar 2021 18:36:38 +0000
Message-ID: <BYAPR04MB4965A5E081F84BA874957F3186659@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210320203002.13902-1-unixbhaskar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65640112-d319-443f-220f-08d8ed616def
x-ms-traffictypediagnostic: BYAPR04MB4664:
x-microsoft-antispam-prvs: <BYAPR04MB4664A181AC79194AEBCFA43386659@BYAPR04MB4664.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:33;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gl2y3ROpnlqwzmFuQDXs0QMCevbd7aS0ro8FK8oLdRX7eNGwOaDRS1SvHYnn3veoMHgRl/t+gcSlp/BuGWbS9oGfleSuSwsy+soFmSAtfIV0XFlWgMjXZ0clYMCiwx22q3gTZz4Dckrgal/QfM/ZpMdujs4og2MCsnh/I9FPEMTwTsmagSQx23ObsgsJrXrQJi514O/RThWCeIyD7s5vwyOD9ynOUGsJcBKVzgKgKnaKPlR3tZ3RGDlJAOifH2PiIKF5fm9RkWUCKdFtbnKWEr+aHaLHTO6kzelJKvzTdq4nB+pT5WvRQSWtiMQd34mSm2eRlwcNcF6tXygCTQIMFm2+p3nhfMUCjT/g1UvoYXS2PzI9wOU//Z2nnxvWstd+vfUAubS6bdbekGxK3MMbh0g8SuBTnbM0KiDcOKoenY7mwwsuTSIvhQUNsYa765NaWTSQQ2vMmphVumeG2GnCuJ7qhumcna87qRb7KESUOBrVqXPs65ILcmh8XK4Ud3lwCGtkkQElFGmKOZtSeR7mqD2pl1A5EPS04G6iJsWq907H8abEDCtz6E9qdIrYMJZcB/zUaXv9pQQQdHDU/9Btvn1eoMd1X8X9A8VuGQ1hsg48DG8xadLDc+FujRw8BP6+9TLte3XbQnqUOpAKt+ahaB0EBX2hUZU0HlYwhAHlNmE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(4326008)(55016002)(8936002)(53546011)(186003)(2906002)(66476007)(66446008)(76116006)(5660300002)(66946007)(9686003)(91956017)(316002)(6506007)(558084003)(38100700001)(64756008)(8676002)(26005)(7696005)(66556008)(52536014)(110136005)(71200400001)(86362001)(478600001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IFuEJTqZE8xOA+bXrKxPFJFqyEQMVHahooGzb6PnThbFTi9/LJi7GoZF/r5D?=
 =?us-ascii?Q?BWIN2vktgCBohY2rw7E/sMTRxjnI5F7bWnKIMXjulGxn8LIJ3wyJZILfqpJG?=
 =?us-ascii?Q?RXqqn9xg630MTuAmrB8XdU/ft7W6CawUk2BPBT8dMkKQo8F05zBxu2fjEn+e?=
 =?us-ascii?Q?eqaPnJ+zAdWR/APBd3cjE9873NeouopZX3g9anHWizPp0NVhfAIjO5CVitAS?=
 =?us-ascii?Q?XJP9nOlGEYRyVZbbazuaYrIdPUeBDzLSwvwBwLiEEYMMMVQ8fVG6GcLHvbuw?=
 =?us-ascii?Q?eWWs/TiUISrYy6pMS8uCA5Cfc67HstSkDwNjuyuz73kiGYcTkSetlNCKPWY6?=
 =?us-ascii?Q?t0rwRYC8gbLuE5fzIQ31Sxw975hrV30Fnqfj5niTWXCnLA9UJ6pkBoFfz1C6?=
 =?us-ascii?Q?cEusxpaEmZDpr7QQX784kRqSeiV49xpLtwUboXoI1wXDek43AgFa+fdWuGGO?=
 =?us-ascii?Q?RVHdsyTByRbEzKb6dgCi/rCdHpMC3uz+7s4cIscJQ6tpccMDEGjcOxu4oOnq?=
 =?us-ascii?Q?LdINRe+wv9JvcJNGzWJwd4n+9dggQMNV5uEYCvccc66FIeWFJA1dYpAtIkkN?=
 =?us-ascii?Q?zZzAxv3caWNVCFwM0lUXgEiX5rpANE1aJqO/XWJqfgXMnCouLD8nMX4BXasf?=
 =?us-ascii?Q?TXg/i2Mo0pY0FeY1FpgyxelYmin2ZbKyR2OiuJOWRLFQDWYRg+MuNe46jQ0w?=
 =?us-ascii?Q?UoR4DmObSg43TiZ/EmGY7YAM/XiGw02xHYK+z6IToDHCCzmAlOXFhgGTeq8O?=
 =?us-ascii?Q?3ocALmTYmDCyyDIj//7kTOnHvdzxlUvHH0H6eUQAZQ4LzzHI88tEzdwg/LnW?=
 =?us-ascii?Q?OBGCp0sUvxIF7Db3fGhnRfHyB0mtGHTxYVydwLGcY0jafnTAjxB8EUbvFrA4?=
 =?us-ascii?Q?hirKPVjjXeVECjL0audoKT1G7g05+EOUN2PIunJyLR5xhzscix5vv/rTQAr+?=
 =?us-ascii?Q?0qpoay+XX4F25GzmsUd6VD28iNBx6QJfwNWcJLEeSoDZsoItH9D7T/02ltNa?=
 =?us-ascii?Q?++fEBCbcgYCrtQeCMZ1t67/PqklYfqG1zohEviJt3pr7JB9CU+1bgqw1KO6a?=
 =?us-ascii?Q?NIvvaKI0/RUtCP+ZYfKvKFvnU3e7+PuB6OvG2upvBTGsH7gY41uG9kb+XPMC?=
 =?us-ascii?Q?YBnBKngWKREEsIryPY48Emwv7g7v47lvV0u1KOKxkp47auM2CIvFt7OauihA?=
 =?us-ascii?Q?LrWsln5Li1VYAdVKUUU6pLdOlN6UMtBiycOWmeQA5mloHIrJoPmex4pSMqby?=
 =?us-ascii?Q?vK2pVOkKjqbOZivtkgN9t+xrIEu+A3G2jSSsD+KNxIJ8pd2YOQElFq6kHo/d?=
 =?us-ascii?Q?+45+wAwI1D2pRCdxFotwr47u?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65640112-d319-443f-220f-08d8ed616def
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 18:36:38.2745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXZjfMwwxdyYukGciNyBKpSuhpKGVNCXu5GOJvFmDgpOdn7DJvZwwXNgVNs1STzdMK1bW3CcelCnF03ap3V5rBD4oyekW5C6DFxH0jXMFg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4664
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/21 13:45, Bhaskar Chowdhury wrote:=0A=
> s/boundarys/boundaries/ ..... two different places=0A=
> s/assocated/associated/=0A=
> s/compeletion/completion/=0A=
> s/tranferred/transferred/=0A=
> s/subsytem/subsystem/=0A=
>=0A=
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>=0A=
=0A=
Patch looks fine but commit log could be better.=0A=
=0A=
=0A=
=0A=
