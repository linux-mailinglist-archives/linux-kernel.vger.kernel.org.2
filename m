Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B522C3F9013
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 23:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbhHZVQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 17:16:38 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12]:42775 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243651AbhHZVQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 17:16:35 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20210826211546usoutp023ffc8fda93a663ea6147828ec62a845c~e98Z6zonl2040920409usoutp02R;
        Thu, 26 Aug 2021 21:15:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20210826211546usoutp023ffc8fda93a663ea6147828ec62a845c~e98Z6zonl2040920409usoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1630012547;
        bh=r9IjyKb9NwYbgZQaqkfxsWQc9c2WZ3PG6KCBtXowDG8=;
        h=From:To:CC:Subject:Date:References:From;
        b=eocjVWUNELGFttxX7F6BjbuK3nbdjnkCd7hgKnL8J3ktGSuBhdd/IHzqJXzbu9F2M
         O5CMjVq1hphS6uswg9bAHYf0xdyLbTM7d9kzfg9xGdvIhA8YqHAWiSTTxP9zvc7gTp
         hfyh4VQ0iGR8oXRV2Qg00VfAjthrm0GHrx730acc=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210826211546uscas1p1efeaf1687f309a20b7c1c4a3dadf3068~e98ZvCrh42657926579uscas1p1G;
        Thu, 26 Aug 2021 21:15:46 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 8F.C4.03480.28408216; Thu,
        26 Aug 2021 17:15:46 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210826211546uscas1p1fc876392e5aaf990eeb480cc74508852~e98ZV3HRl0263002630uscas1p1G;
        Thu, 26 Aug 2021 21:15:46 +0000 (GMT)
X-AuditID: cbfec36f-edfff70000010d98-86-61280482aaf0
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 53.DD.47905.28408216; Thu,
        26 Aug 2021 17:15:46 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Thu, 26 Aug 2021 14:15:45 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::4df0:41c8:8343:b407]) by
        SSI-EX1.ssi.samsung.com ([fe80::4df0:41c8:8343:b407%7]) with mapi id
        15.01.2242.008; Thu, 26 Aug 2021 14:15:45 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Adam Manzanares" <a.manzanares@samsung.com>
Subject: [PATCH 0/2] Make nvmet_init_cap dependent on passthru controller
Thread-Topic: [PATCH 0/2] Make nvmet_init_cap dependent on passthru
        controller
Thread-Index: AQHXmr+Icw4LjsGPkE629HHiiLhFoQ==
Date:   Thu, 26 Aug 2021 21:15:45 +0000
Message-ID: <20210826211522.308649-1-a.manzanares@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRiH+845nh2Hq+MSfZvSZaGU1bxQNCikKGIFpUFBraCOdVDLOduy
        0oqki2lXKzWbonZbbk1L05JlmDYta2ZZbtNilmlkkrIsZqWZ21ngf8/7/X7fy/PBR+FCvZeI
        Skjay6qSmEQxySfuN/18ueAoMYcJNxeFSMdqm0ip5l0/IdXdbsSkFxssSPrGWEhKi7W9PGl5
        /yCxjCe7cGyAJ2u1VxCySn0WKbt344jsYUc6KRuqnC47+fg0FsOT85fuZBMT9rGqsKjt/Pjy
        M8NE8g3ywMXGGiwdZXudQt4U0AthqNs8znxKSOsQmEzXSG44gcH7T3bsfyvfMYZxQRkC/fcs
        ghscCDo6TDxueIygovyB+wpJh8OfpxW4K/CjszF4VWUiXQFO74FHZUOEi6fSq+F4Y7ub/egY
        MLeYxk2ocZbAaKf7mKCD4WuFE3exgI6Cs+k6NyPaH5zPDRi3MgA6e4o9qr5wraAW59gf/ho/
        khzPgi5nH4/rS8CWm+PRmQfaq/2e/b7QfKWH4PrToL7U5n4l0LUU1GUYkcsN6JVQeM+X6wRC
        uzUX5zoWBLe6C724oQvBiTOjiGstgasjdzymk2H0d7dnkQAyM4TZSKyZ8AbNBD/NBD/NBL8S
        ROhRQIparYhj1ZFJ7H6JmlGoU5LiJDuUiko0/p1e/H2irEHWToekAWEUakBA4WI/QYkzhBEK
        djKpaaxKuU2VksiqG1AgRYgDBNimC9uEdByzl93Nssms6n+KUd6idGzNbh/DfvNMXnVru7/P
        wKRqZ8+WPkvk3SbFcp+fvgp750Jb4EwqdP2r86W7jmus8SJj12WRcfHBAmnQ2+s3D+ItwbFZ
        JfH2vMHr8ne/knXr2uqHXhriHrWJDGvacteHfIuo1xxLfR30warP2fSjrM7QDFstWJ3805dF
        X5xFor5QrW1+qXY7O7z53Crlg+C1OxLmbswzjx1iLkkSfj9L69twS3RnoKkgIv/zd5WjalrG
        kg5l9hZ7sVbOVwTM/eCITp0RG11zMy0oMlM3aFkxaaTXYYsZDpsS2LvscFC+fBY9ktla1UzO
        /iqeLDfcbbce0b2d0qxARcIo4+bDAlqOzh4QE+p4JiIUV6mZf8zW1Iq9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWS2cA0SbeJRSPRoHE9n8X/PcfYLGbdfs1i
        sXL1USaLSYeuMVpc3jWHzWL+sqfsFutev2dxYPeY2PyO3eP8vY0sHptWdbJ5bF5S77H7ZgOb
        x+dNch7tB7qZAtijuGxSUnMyy1KL9O0SuDLW9fxgKVjCVjHp6A6mBsYJrF2MnBwSAiYSMz7+
        Z+pi5OIQEljNKLH8wBI2COcjo8SUNYeZIZwDjBK3728Ba2ETMJD4fXwjWEJEYAKTxIUtR9hA
        EswChRJ7135mAbGFBTwlWo5eBbNFBPwkdv85AmRzANl6En9vgYVZBFQlXm38zgxi8wrYSfQ2
        rASzGQXEJL6fWsMEMVJc4taT+UwQpwpILNlznhnCFpV4+fgf1AuKEve/v2SHqNeTuDF1CtQ5
        2hLLFr6Gmi8ocXLmExaIekmJgytusExgFJ2FZMUsJO2zkLTPQtK+gJFlFaN4aXFxbnpFsWFe
        arlecWJucWleul5yfu4mRmA8nv53OHIH49FbH/UOMTJxMB5ilOBgVhLhXfBdLVGINyWxsiq1
        KD++qDQntfgQozQHi5I4r5DrxHghgfTEktTs1NSC1CKYLBMHp1QDU5wzR3Dp50V/1v5IXr1k
        x8TP2XFXTO7qC5gfEU+6uJ19+6zgW0lHElsT9K1vFwgvebRNzv/B4eMd9eKb8hY51Kr+OeFR
        ob0uL7N44esdPb+ZEuIuNGf4V+/42ZPTf2115Qyb+gjzG7/cF6x7a50Vm+BocMP10GO/iZ/D
        jmZdYdqb/mLKvj+cU1qZf1zSCmDfML3ux/9J/KckO81XrvPZYT3B//89dlb+2e3rSuYkxqWU
        5565F+dSMm+zTXWDnVupwINwje7JZ7MjRL//ZVi6ynQB691Zse8/cEhz14cdna6309nOXeO7
        2YM9d+fevbZNxp67ecrtKWGZy+4v/RjhpP0jedMJg0j1qXxR+5ZL7VdiKc5INNRiLipOBACY
        fpQONgMAAA==
X-CMS-MailID: 20210826211546uscas1p1fc876392e5aaf990eeb480cc74508852
CMS-TYPE: 301P
X-CMS-RootMailID: 20210826211546uscas1p1fc876392e5aaf990eeb480cc74508852
References: <CGME20210826211546uscas1p1fc876392e5aaf990eeb480cc74508852@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvme_init_cap unconditionally sets support for one or more command sets. Wh=
en
using a passthru controller this may cause a conventional namespace to be
ignored when checking the namespace identification descriptors which must
include the command set identifier when the cap is set to support one or mo=
re
command sets. Since the namespace identification descriptors come from the
passthru controller they may not include the command set identifier causing=
 the
namespace to be ignored.

Adam Manzanares (2):
  nvme: move nvme_multi_css into nvme.h
  nvmet: use passthru cntrl in nvmet_init_cap

 drivers/nvme/host/core.c   | 5 -----
 drivers/nvme/host/nvme.h   | 5 +++++
 drivers/nvme/target/core.c | 9 ++++++---
 3 files changed, 11 insertions(+), 8 deletions(-)

--=20
2.25.1
