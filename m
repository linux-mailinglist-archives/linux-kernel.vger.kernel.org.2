Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3353F9C52
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245539AbhH0QUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:20:10 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11]:33966 "EHLO
        mailout1.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhH0QUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:20:08 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20210827161911usoutp01862498d1126a1c854892fa1e71ccd14a~fNivLXKY50563505635usoutp01D;
        Fri, 27 Aug 2021 16:19:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20210827161911usoutp01862498d1126a1c854892fa1e71ccd14a~fNivLXKY50563505635usoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1630081151;
        bh=7vfu5UFOm0549CIm3gJmcsEjbMf3Qx0zfaaS+GQWn6s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=FK2HzeClkMjuujwX+IkEUcoSlxMfKWMkv5ZkCeeiaFHZusvVHieMu4YY1O9e52vrG
         e1iaM5o8poyDM/8/At7UVQoKAQY64rk5VFXFcNxxuXMm52wZk5ub6+gX7yi65vPexl
         jLfCA1ucHgeSJVohteBXdsgVA8u11+mXVsRQU0mM=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210827161911uscas1p2b120f4ecc1c7ad0131e5ba73e2900fbf~fNiu-jGLm2831528315uscas1p2r;
        Fri, 27 Aug 2021 16:19:11 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id E0.07.03480.F7019216; Fri,
        27 Aug 2021 12:19:11 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210827161911uscas1p10b0a5bf79fd2d8a03b6f4cb13b8bf302~fNiuo9VyL1151511515uscas1p1b;
        Fri, 27 Aug 2021 16:19:11 +0000 (GMT)
X-AuditID: cbfec36f-edfff70000010d98-ae-6129107f2198
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 03.A6.47905.E7019216; Fri,
        27 Aug 2021 12:19:11 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 27 Aug 2021 09:19:10 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::4df0:41c8:8343:b407]) by
        SSI-EX1.ssi.samsung.com ([fe80::4df0:41c8:8343:b407%7]) with mapi id
        15.01.2242.008; Fri, 27 Aug 2021 09:19:10 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvmet: use passthru cntrl in nvmet_init_cap
Thread-Topic: [PATCH 2/2] nvmet: use passthru cntrl in nvmet_init_cap
Thread-Index: AQHXmr+I7P+Y0y9860Sip666Pz8m2quHVk+AgACoEwA=
Date:   Fri, 27 Aug 2021 16:19:10 +0000
Message-ID: <20210827161910.GA424766@bgt-140510-bm01>
In-Reply-To: <20210827061737.GA22583@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CFE9934767FAB54A901D892315AE667C@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djXc7r1ApqJBptnKFn833OMzWLW7dcs
        FitXH2WymHToGqPF5V1z2CzmL3vKbrHu9XsWB3aPic3v2D3O39vI4rFpVSebx+Yl9R67bzaw
        eXzeJOfRfqCbKYA9issmJTUnsyy1SN8ugSvjxK/DTAUL5Sp+tLUyNjDOlexi5OSQEDCRODf9
        FlsXIxeHkMBKRomnLbOZQBJCAq1MEleXC8EUHbvbB1W0llFiT0c7K4TzkVHi/uZmqMwBRolv
        z3exgLSwCRhI/D6+kbmLkYNDREBW4sqKepAaZoH5TBIvF85lA6kRFnCRuHdyHdg6EQFXiQOL
        djBC2FYSv7dsBpvDIqAqce7OIbB6XgFTiY9LFoHFOQV0JP6uOscMYjMKiEl8P7UGbA6zgLjE
        rSfzmSDOFpRYNHsPM4QtJvFv10M2CFtR4v73l+wQ9ToSC3Z/YoOw7SQW/LgDZWtLLFv4mhli
        r6DEyZlPWCB6JSUOrrgBZb/hkGjcXAphu0hs75/DDmFLS1y9PpUZ5GEJgWuMEssfzWGFcO4z
        SrT2/GWEqLKWWPhnPdMERpVZSA6fheSoWUiOmoXkqFlIjlrAyLqKUby0uDg3PbXYKC+1XK84
        Mbe4NC9dLzk/dxMjMGmd/nc4fwfj9Vsf9Q4xMnEwHmKU4GBWEuFd8F0tUYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjgvU8TEeCGB9MSS1OzU1ILUIpgsEwenVAPTRtP83uPL3/hcr22XfV+7KLKl
        4PbyUnFd/SfaZ+ZnvN+64dE9o8WnJ71dsMTzqfs6pfkqAYknrrYu/XM9kaPhiq9CvdTaHSbR
        2Tt8ry41TJ/+1ytnenuypt222cdrXzIkFMQwTIkvvJJz5+u1E/M/ZG6a+9PpxpOLd/7KlhUF
        /pmtrugrcajitVixiljy53Nh2xOUJZ2Dg71F/bLX+h2rv7qba4PnnBktxzwnNhsyrP8mOm+K
        M9NEq0k/9G/t75lr0qkw5WRugbbg3P/a8/lWiOvmPWi7o3q1g499W2asi/PZB5f/vqwUSDa/
        qLzG+16lbsCf5+mty5gmtmnKld09EZkVtyBY5eeX6bOKblk1KrEUZyQaajEXFScCAMzGhozJ
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWS2cA0SbdeQDPRYPphDov/e46xWcy6/ZrF
        YuXqo0wWkw5dY7S4vGsOm8X8ZU/ZLda9fs/iwO4xsfkdu8f5extZPDat6mTz2Lyk3mP3zQY2
        j8+b5DzaD3QzBbBHcdmkpOZklqUW6dslcGWc+HWYqWChXMWPtlbGBsa5kl2MnBwSAiYSx+72
        sXUxcnEICaxmlNh8ZTeU85FRYvKRLawgVUICBxglzl9zBbHZBAwkfh/fyNzFyMEhIiArcWVF
        PUg9s8B8JomXC+eygdQIC7hI3Du5jgnEFhFwlTiwaAcjhG0l8XvLZhYQm0VAVeLcnUNg9bwC
        phIflyxigVj8klHiwtM3zCAJTgEdib+rzoHZjAJiEt9PrQEbyiwgLnHryXwmiBcEJJbsOc8M
        YYtKvHz8jxXCVpS4//0lO0S9jsSC3Z/YIGw7iQU/7kDZ2hLLFr5mhjhCUOLkzCcsEL2SEgdX
        3GCZwCgxC8m6WUhGzUIyahaSUbOQjFrAyLqKUby0uDg3vaLYMC+1XK84Mbe4NC9dLzk/dxMj
        MN5P/zscuYPx6K2PeocYmTgYDzFKcDArifAu+K6WKMSbklhZlVqUH19UmpNafIhRmoNFSZxX
        yHVivJBAemJJanZqakFqEUyWiYNTqoFpT1+F4XT/ab8vB+oycehGHc8IYNv9SEyB+c57/hID
        aW1WPtsvZvP4TVvi/siVVi6Mefsm78VuPZ27jwImMZx75CeTbcb+/mKeQGuqyS55p5M216eW
        ba6Z9z+3a/XN5P6WhC1rj228mW+YZ/yreLb01kj3xHL5gp13V3/h2dBatyDlfqGmbVLudMsp
        +XfmflDqnDJRK/VxU2IEs1bKlPLbq4TWLjZxivuQeG26fe0Bo6ofDszFfKc09nkxi9avUYyL
        3nBB5IzBDOf761JFhTa7RzevTBXPlpcSmP1sRhHX7OBXiwN+J9xtFBRKOc/6akLV3+VMpbE7
        +XRn/I+cIX4+tV9xLtdk+d6DiRfO1SixFGckGmoxFxUnAgDd3/Z9ZgMAAA==
X-CMS-MailID: 20210827161911uscas1p10b0a5bf79fd2d8a03b6f4cb13b8bf302
CMS-TYPE: 301P
X-CMS-RootMailID: 20210826211546uscas1p1e181ca820e506c7c195b933168301dd0
References: <20210826211522.308649-1-a.manzanares@samsung.com>
        <CGME20210826211546uscas1p1e181ca820e506c7c195b933168301dd0@uscas1p1.samsung.com>
        <20210826211522.308649-3-a.manzanares@samsung.com>
        <20210827061737.GA22583@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 08:17:37AM +0200, hch@lst.de wrote:
> Technically this looks good, but the core target code should not have
> to poke into the host side data structures.  Does this version still look
> good to you?

Yup looks good, thanks for the help cleaning it up.

>=20
> ---
> From c5777caf1562df35150a71e5c91c5b272956beee Mon Sep 17 00:00:00 2001
> From: Adam Manzanares <a.manzanares@samsung.com>
> Date: Thu, 26 Aug 2021 21:15:45 +0000
> Subject: nvmet: looks at the passthrough controller when initializing CAP
>=20
> For a passthru controller make cap initialization dependent on the cap of
> the passthru controller, given that multiple Command Set support needs
> to be supported by the underlying controller.  For that move the
> initialization of CAP later so that it can use the fully initialized
> nvmet_ctrl structure.
>=20
> Fixes: ab5d0b38c047 (nvmet: add Command Set Identifier support)
> Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> [hch: refactored the code a bit to keep it more contained in passthru.c]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/target/core.c     |  6 ++++--
>  drivers/nvme/target/nvmet.h    |  2 ++
>  drivers/nvme/target/passthru.c | 10 ++++++++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 66d05eecc2a9..11c44706dc2d 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1206,6 +1206,9 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
>  	ctrl->cap |=3D (15ULL << 24);
>  	/* maximum queue entries supported: */
>  	ctrl->cap |=3D NVMET_QUEUE_SIZE - 1;
> +
> +	if (nvmet_passthru_ctrl(ctrl->subsys))
> +		nvmet_passthrough_override_cap(ctrl);
>  }
> =20
>  struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
> @@ -1363,8 +1366,6 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const c=
har *hostnqn,
>  		goto out_put_subsystem;
>  	mutex_init(&ctrl->lock);
> =20
> -	nvmet_init_cap(ctrl);
> -
>  	ctrl->port =3D req->port;
> =20
>  	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
> @@ -1378,6 +1379,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const c=
har *hostnqn,
> =20
>  	kref_init(&ctrl->ref);
>  	ctrl->subsys =3D subsys;
> +	nvmet_init_cap(ctrl);
>  	WRITE_ONCE(ctrl->aen_enabled, NVMET_AEN_CFG_OPTIONAL);
> =20
>  	ctrl->changed_ns_list =3D kmalloc_array(NVME_MAX_CHANGED_NAMESPACES,
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 06dd3d537f07..183119607968 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -613,6 +613,8 @@ nvmet_req_passthru_ctrl(struct nvmet_req *req)
>  	return nvmet_passthru_ctrl(nvmet_req_subsys(req));
>  }
> =20
> +void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl);
> +
>  u16 errno_to_nvme_status(struct nvmet_req *req, int errno);
>  u16 nvmet_report_invalid_opcode(struct nvmet_req *req);
> =20
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthr=
u.c
> index 225cd1ffbe45..8784c487e462 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -20,6 +20,16 @@ MODULE_IMPORT_NS(NVME_TARGET_PASSTHRU);
>   */
>  static DEFINE_XARRAY(passthru_subsystems);
> =20
> +void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl)
> +{
> +	/*
> +	 * Multiple command set support can only be declared if the underlying
> +	 * controller actually supports it.
> +	 */
> +	if (!nvme_multi_css(ctrl->subsys->passthru_ctrl))
> +		ctrl->cap &=3D ~(1ULL << 43);
> +}
> +
>  static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>  {
>  	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
> --=20
> 2.30.2
> =
