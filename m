Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDC238815F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbhERU3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:29:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6530 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242143AbhERU3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621369668; x=1652905668;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nmFMsbVk9P61H3MHRAknfITSSv7ogOYIcOG/Rt7dsME=;
  b=GJuXxtAyYORkEXz7+xoie4Pc5nnW9VzxccuvUa7Tn686GQZYyAcxR7RF
   V7PJa0L/gopY3EYr97QOtEg8tKf0Lfwm4VTMIIq8vQbg6ldrQJBojLjhU
   bDQOC+x2rvlJfcveo3ik7oAJLBHwadvIdqM/ujzYf79sLdtj4tseQ9X5A
   32lB7kLBRffppxq+CG6/IdF4OeVg6j5KuzC31ZMMcZj1YwNlHk6FfhcKc
   OvnaCf1iXRjFepdJSdv7Fjn3DlAiwzsfeGhCH0zFL5/pjFDBH9Sak4aks
   hATSvcV70jaeV4cI9Fsnel1Ncx+2uDDFPsLZmDeSQVcbI2Bk7SsP6zPOB
   Q==;
IronPort-SDR: ETTd9l75Yq7Mbo0EZGPL9AxJ5wcEcuNG6B87Y+PGCAAlY+fhUh6CsKCZrdMKbnz6hABZnhD3ab
 u7dg5mMTnpQ/XOzBhiMs+S7wspSF0VGBCEfF824OR6bNY8qi7e2o3Cm5l16CQhIjciqlU+aDaD
 6rnZkMnwpst85jgPbCIhPQqdqtHx3qmKDo91d5/OkGx8pYHY1xy6AkysLObExk3Jbw0wrnO3Rz
 5G8Y966TK/tWrkooR4A4UtUZa6EmlX5A4b//SnQHy1AotNAgxWYH7BTKZRKNIXqUfhZk7eEJ5M
 CMo=
X-IronPort-AV: E=Sophos;i="5.82,310,1613404800"; 
   d="scan'208";a="169153602"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 04:27:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+sTGbbgL70ikpf/7N6LIgREScX5F3hN9ikOmwqdrlKiV+virRWzp8E3NG9QGNLo+tbsn3goeOEuw+a0UIt4Lg1ILrWErtWu6QJe2VhGfmH2w5ZlaXCQYbPxArY3LGSxrG02ybPzr4a1jmW3FX0uD0RQdOUMaCotGF9RbZYr/93KCJTN25cG+i858rgQzoNxK9MgpBXEHMJ3d3+Fo6EU2NQJJzbW3SzBFd/+5PrtBSxc2wlQkA44aD+71cWlrJa+i+e3k1oRacZSFzLjV/szh3feMBwaugdXGo7i06g9jKuUf2UO4mp05iBqLSmg7xNYzLniwOcrhZcNL9Pl20AXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmFMsbVk9P61H3MHRAknfITSSv7ogOYIcOG/Rt7dsME=;
 b=B/K6xSeCOXyusU59ILdGHAfveMAAzd1QIcSsKdwrhgc5Xs7JflWnfgRHUSB1PmMdOKJqcuFxgQkJQ0p9hsv6p6+urv8iYqlzHO8PA9U+8TlND4uGXgy/GfIvYIkepjcoxNN/AKRGu86j9VzqTDbn137KLb/OIZqD/MRTF8wkl6pKsf6DJM9lICiM/FMYAmC0F8ASrrRWgZGOiE9stBaEUdC/7RkNALJgK9lDEWHUOYWYjJqJvsPyNdpDoe1P4iC8C+6mc7TKPRn5oy/gEyoPDk6r3F+sctmmT+SFR0imnFsMIE61hVGsSfd0ljh9CKYo+kzsBcRBPkGPObgLrdofzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmFMsbVk9P61H3MHRAknfITSSv7ogOYIcOG/Rt7dsME=;
 b=aAQiDcpAVZmCAN65+PTQ25U9Nydka/ylbSceAc5rK4lle5bU6x9FJYXudc9wS4H8w4BYTUNxO59+BqJBy1Tw0klaq388XRfxCPGauB4r761VNClt+g6q83OKb/pTbtLYNSuE2HUDRWjOxjrUFJ3cPBz3h1yWulBfeviqhWGa+2M=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5029.namprd04.prod.outlook.com (2603:10b6:a03:48::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 20:27:43 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 20:27:43 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Wu Bo <wubo40@huawei.com>, "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "amit.engel@dell.com" <amit.engel@dell.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH] nvmet: fix memory leak on nvmet_alloc_ctrl()
Thread-Topic: [PATCH] nvmet: fix memory leak on nvmet_alloc_ctrl()
Thread-Index: AQHXS77BXPlsENBRfkCDAiaeiYCKqg==
Date:   Tue, 18 May 2021 20:27:43 +0000
Message-ID: <BYAPR04MB4965E8D55C4349EC01EF61FB862C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1621327598-542045-1-git-send-email-wubo40@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27d7066c-26b9-4ed8-6c5e-08d91a3b6452
x-ms-traffictypediagnostic: BYAPR04MB5029:
x-microsoft-antispam-prvs: <BYAPR04MB50295E7506F213A28C534B29862C9@BYAPR04MB5029.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:212;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FBb40Ok9bmhD6x0TgP7rsxCsSvGv+KgP9lATRc9oO6+6fdtXEFt+1FE1MRgsh8dsaV6FzceH8dCpW/mlWTEk7ame2fw9vJFC888W8tsvaleEpV6XwcPPhUIUMPfm8pTO4tUvHmEHmeqVS7qkDW+OF+oUyl9PLPTkFd4nR2aezp/1WRs8AJ7iqT9QdA/NyEqwON2cBbmMd0Biy4rQGreSgnpEoDKHLjZKi3MCgV21+bWK6XgjPJpV7AM19ODtUvLfuRAhY6ARPQBLhdtNQ/zDFXVnG1fy8O3hqgnzkE9EBBrE58pp8wpYuIKR2fSvpuKixy6tmrxQ2+2qtzHmENA+JAP7XfB7I1eBLJuusUm8YcCoGSCNKNMKkPVTk6BVFO6OmMp5EpbYACrNiEgOIgMvAV9Ey5TEpJ02zPPBYQ8jOlzF+pQktTb01g27eHreoK6c4RsLB55L+MdpckwZBr+XTQpC5T/nKGyLzhdvPmOT6itX9l9ZwAgKns4M9MTa/eoU79HeM7xQQbxFEv1mvCJQokXIS7YxRoCvwhpGklsyDc3cUFv5sf6f94qZphkkL4VNzs0QYNqKwPyppV5T824evtMuk0wmGgb0yIs/SX/uY88=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(52536014)(478600001)(5660300002)(122000001)(316002)(66476007)(2906002)(54906003)(4744005)(76116006)(66556008)(64756008)(66446008)(71200400001)(110136005)(66946007)(33656002)(86362001)(26005)(53546011)(6506007)(8936002)(7696005)(38100700002)(9686003)(186003)(4326008)(55016002)(83380400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QuK8AcPyQP7ud6IY0LBp05i3ubyHnxj1oBlmKzM52nikWrBN659Hakr3xhY9?=
 =?us-ascii?Q?MUEAp3FioPMCfOtXjV0ekJjbMhAOCElaenlvC8LHAdlC/7yEui7mRCq3VdrR?=
 =?us-ascii?Q?P9PrEqnz7cQP8Oq9+nBEafCaZj7PJC0TeNnEfqZfqjTvJAYQnIdh1qywBQFW?=
 =?us-ascii?Q?x76X2Vf7uhhDk+TkyJTZ7LEWj4QFEY4MKfbBthZuNJdxcrEMK5G1NVIRWhsh?=
 =?us-ascii?Q?+oD70XoRuXomk6bkUh2uOd78czUIvGwrEkM0rNuxiPU9mBlOloBo5BQBays2?=
 =?us-ascii?Q?rF5QMpw95TIYEppKJBcePunN2eJGa+KrGv+lmCoAoB0JT2cNn98oSwOuNRar?=
 =?us-ascii?Q?CJTYeH4pWailJHhZzby2+wS/EGcKLQpraLdsmkCuB+ZJDIJNkETjH4ey4nkS?=
 =?us-ascii?Q?nDctwlyOssDv9nDuR1lfWHuEXRNwdmRtSyrpW8gBZp6h+uplFZv6XvX00CgC?=
 =?us-ascii?Q?XTshMRWW9E3V0VqnJN3q8cH4wqlIUdRhLyELTZdkts/ikUsrFs9ZH2DpFd0/?=
 =?us-ascii?Q?PLi9f8CjhVwprhU3wZX1uxwxky4M3agk9ZH8KEsxiBR1w79sZ18nHuzKQ6hZ?=
 =?us-ascii?Q?glhIqqT6UyXKnaIpc8A35Hs7NyTBcp25vDZtYoAJbtPcksKgB4YtwYbNcn4Z?=
 =?us-ascii?Q?zd80ev0m6WjKHYuyQqLJ/scWYt6SKwpOMduS1v4hhnM/iGiTDEtGLOWetaDK?=
 =?us-ascii?Q?Y+90HTdHh1DqdCeQx0W4xzF1kTXRZGs7kh9X6CAK+kxoLI7livQEyrmM6S2H?=
 =?us-ascii?Q?rDWW6m/YgFebFUg4ngTIOmT5tqqahqKk377QfcHbApIW+HWNEeNu4KLCzYwM?=
 =?us-ascii?Q?Q9b8jHHnuAh+KTgxdfehHMQgYxHiXCteh/0/AOC2aaEnT46a+awJ97OVM2F3?=
 =?us-ascii?Q?fjbs9mVfEvW1eyOmeWRzJjPPGu4QvQZ3CQ1q1XllKKYATkDXIG3fsQaBz/Qr?=
 =?us-ascii?Q?JuNdl2ht/uKji6EbMc8E0e0OdnuTEvkNHftzJbx47+LFT3MikBtTZVbcIsyP?=
 =?us-ascii?Q?oZKtbm7YtzVNpmjPeGQDlZIlvZeOV7JLYq+VAMJFHhUqeDUFTDJ/nAVCRpZD?=
 =?us-ascii?Q?NEE8coBFAJ8gRF+1cPm7AhQEgfSr4PdhSxdl+hzxutx9Sx3IPJ3POWh6iXI+?=
 =?us-ascii?Q?ZDQv6iPWVi2nfNrr5klKoFyd0tcd4PNjbJ/GdW97j2PlobsqFhfkQuhIodyR?=
 =?us-ascii?Q?3qRcCfGfL8R4qOwjZR+kSGkmfS26I1BZP9OBOYth2ZLJNHGNWVEBRUoxsT8l?=
 =?us-ascii?Q?96I5mA1diRasSrivPU74jS2sitodV+YhA7O9ViKB2E6wl4tAEGg6vBlKkbMt?=
 =?us-ascii?Q?f2Me9Qdrc2DgMxpiyCdgErdp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d7066c-26b9-4ed8-6c5e-08d91a3b6452
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 20:27:43.7092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULyJbF6vH9EYXN0ByH7qOawqw94yru0HOGJKkbpkzfq52PdpznWm15lFWZIyijsb9w9MmuRMIzN12Q6PLTz3PwULitS+4ngXp1MdvNRZpSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 01:21, Wu Bo wrote:=0A=
> From: Wu Bo <wubo40@huawei.com>=0A=
>=0A=
> When cntlid_min is greater than cntlid_max,=0A=
> goto wrong label, should be goto out_free_sqs=0A=
> label. Otherwise there is a memory leak problem=0A=
> on the nvmet_alloc_ctrl function().=0A=
>=0A=
> Fixes: 94a39d61f80f ("nvmet: make ctrl-id configurable")=0A=
> Fixes: 6d65aeab7bf6e ("nvmet: remove unused ctrl->cqs")=0A=
> Signed-off-by: Wu Bo <wubo40@huawei.com>=0A=
> ---=0A=
=0A=
Looks good, except commit message could be better :-=0A=
=0A=
When cntlid_min is greater than cntlid_max, goto wrong label, should be=0A=
goto out_free_sqs label. Otherwise there is a memory leak problem on the=0A=
nvmet_alloc_ctrl function(). =0A=
=0A=
Fixes: 94a39d61f80f ("nvmet: make ctrl-id configurable")=0A=
Fixes: 6d65aeab7bf6 ("nvmet: remove unused ctrl->cqs")=0A=
Signed-off-by: Wu Bo <wubo40@huawei.com>=0A=
=0A=
=0A=
with above :-=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
