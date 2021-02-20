Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64063206B8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 19:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhBTSrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 13:47:43 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52923 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhBTSrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 13:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613847793; x=1645383793;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lhPlcd9djYeCSwrwCsrxgFb5VjloY5McthpdB6kOQeY=;
  b=COhl6f4Yvcov0ZLmFh31TqE+Wkz4fUwL5j/wfpB/z/MopBZjD2NMsOVt
   yWjG89dMXsCYUQCCaEQvS/GAprQq9qlWzZhzwidj9QfB3DIiu200Vux+b
   U07oO63j38uTYlC1DB8mpYNv06DTMbHRO0SVENGx3UQEM9j/GCMvJTseL
   rUyhzFjshv2F/LwlJ7chan73m9H4oznzcX9N2ILS3DGqdjXFr26VLrpH7
   QgHQdDGrne43h40/8Qe07pZVCOjvY9LoIZQOFGE7PkuMCpZp5Suqbk3J5
   1Xat+zozLF51FNjXcdor2LoFhSRJpy857PfyQFmWAOBpM3BniT0inGcgQ
   Q==;
IronPort-SDR: xgZu/cpze/YWkz1hR0mPow/EMiee1JqWKNf3leNApZdPMnJQNNVPReQBK7MEnEdJpuNET0jxo/
 M4JmmxMfM3OChZokmR+/mvi8hu2ABxuAasixNeK8miZAX1fUuM2CEnvXYnOqEGnmQXjP45ppBL
 +IpVtW0I0jqgY3RqYtp8zfXQ8eVkEhoDUm9J2w+fK8RE0elbcdOevHOM6LImK1bawFnI/SWywb
 kcuDTUW1evDdCNUMRhYFtA7u5LNBswNxOdFLJBEnTsVwbEEvqpTx5NsdG+8SLZbH73DBeI1bjk
 xJY=
X-IronPort-AV: E=Sophos;i="5.81,193,1610380800"; 
   d="scan'208";a="264601077"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2021 03:01:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=an/KuSqicKH0GaIpGIbIkwMAHhKi/v6ynkeKCMIn40u8izErR1Jg0O2p037MVi/7yICoFUQUTnQ+/D1K+mUNrt5qGP4z5paKS2lgZiB3O4YWH9v04tBxA/WHcxdrl3d9af6twKbdY0E1jQ+Opgqo4lNx0SiOTOhyoe/JF8r5V7sTjGNPGTKDgDNNqJFKLp6EY0NJA4Ds7pwi4zSaYxr6ge32xwg8Exp+qrXsYNQjCb4naPu3PqlvvnxEElQXEUbX3eOnPj+fAWTg4LMMyqxLZQ+XEI/LG4EioBQ6c90oUMESYg0q4W+zhewthE1hIin7FkRsKuyA4eNX2r24q6raKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhPlcd9djYeCSwrwCsrxgFb5VjloY5McthpdB6kOQeY=;
 b=hW/sqkjQ6eThoqNDjMmjPq3dhw6cXfDQw3pdZCRCc5Iilx8VJxWO5UHeUkbBpSDPLAoPIpigTt7Wu7JwlTPNuCSoCpoarnkQiupRlFx4xodW4Ar0ezXBwPYxg4l22vHcLOfV7pe7l0OniXHxnyrlxdFCUdHc5djrz2qasbxbtCPgQMUtLqmjRwiX8rSO3qDWUvLjAZ83XfDNlj3tkw3vbYhvtiUiyWm6/3MDaYC3+rgWPQ1fXEHE0jLLCEwDMGUHDTQwbm40Ff0y0cJy6QuX8bmiqqAPeRslufTY+yDV4yKv70ZZfZClcZvXF6tGOQmaTIuO2LvR5ZmoHKhcK8W12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhPlcd9djYeCSwrwCsrxgFb5VjloY5McthpdB6kOQeY=;
 b=eHQjEb6V8PlxFaXHXRgVUF6ZKTnEp0YMKMrdE1BQK+/cq7hJ2q/8yzHky40ID1RYfzU08xTBk4NUZ/6Sos7KmdkcgE2c+g/EuRX9pDwMnYHqX2ERZh027BbfWgcX/6Bysa/7E2Ft00B9X0sxUfwA0TeuVbmrhUSnN9yc9NU/5UM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5528.namprd04.prod.outlook.com (2603:10b6:a03:ed::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.34; Sat, 20 Feb
 2021 18:46:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3846.041; Sat, 20 Feb 2021
 18:46:33 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Yang Li <yang.lee@linux.alibaba.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme-core: Switch to using the new API kobj_to_dev()
Thread-Topic: [PATCH] nvme-core: Switch to using the new API kobj_to_dev()
Thread-Index: AQHXB2j2CKRuoDiKGEetuOUjot2NZA==
Date:   Sat, 20 Feb 2021 18:46:33 +0000
Message-ID: <BYAPR04MB49653FCDC174CF7BCB4840BD86839@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1613812218-17601-1-git-send-email-yang.lee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd4b5f3e-4a17-4dd0-fb59-08d8d5cfd805
x-ms-traffictypediagnostic: BYAPR04MB5528:
x-microsoft-antispam-prvs: <BYAPR04MB552845A201CD2D20142EF51186839@BYAPR04MB5528.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nty17/7pzaq75oH5L6/QPfU07u2VwR/GiSEeAhQa4tQWehNXWtE7+uUj3ZO24c6GbYfYnYXNaUQgSgH9OdmQQ+uilZ7GlbCtFCtSZNrQrEw3Vmk9h/UrxErw9i1oaQsJFzM+H9hEZcXpWoquo2/IIRo778i2D73AvgO9QE7jajpIbCQvSgBBYmrMmj1Ed2tJL0ZChHS5BljP/4lheVSt0M2pDpg7JwkhK5n53nkWIFStSdKbPjcG93g9tT5HTG3G9HTsWL0XriaRjh+vHmfr6k+/DNML4/UKO/VEZTf15WSy19jcpbYTF7H1T+uRrbB9d3d/0os/G1mMTXIlcHAdvO9BZRIM1KD4EJp5jHM5EHQaOHAwtBfxppCb6zEcZjwgOgGeu6P9Y64vOIhP6NGogU+TGEUsYmeO8gGmFOdgLziUsJSfoD0vrAXgZKW7eiAFlsSpEYlKxNlCKh24I6KwQLui9pTWCTNAwK2i0ucvhPAQHSLhyi67VNFupf08lVLfFlKstSpow6Y9+Cbj5oZW/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(4326008)(52536014)(83380400001)(5660300002)(316002)(33656002)(4744005)(7696005)(71200400001)(26005)(86362001)(2906002)(8936002)(64756008)(66476007)(9686003)(186003)(55016002)(110136005)(53546011)(8676002)(6506007)(76116006)(478600001)(66946007)(66556008)(66446008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cPYVex49ANadLWsaEvaHVs+2y+bEM5zR6f5oTnBKKtnsqHblT8MAO/uQNLo5?=
 =?us-ascii?Q?hS0O3I5QVlQ3aP43UeclVSGki7oIa7XNLJlG+za+evNZiE8RKJF38kScQRcF?=
 =?us-ascii?Q?3bkK/gjyAi3FziATw3hKIW3S/bqYihUlIScjS+Idc1MHMIe1gzcE1RrdGv9j?=
 =?us-ascii?Q?MHC3xV9QHH5aYlAF+dAWWhP8vMzGXC9ufLjOqrHRfaZIwFg3qJFOX2wG/668?=
 =?us-ascii?Q?4UyNK5GlYtiM71+KAJhBUy2WuupV+AtssVyWjixcJkame+Di+Fk5HGXs1eZY?=
 =?us-ascii?Q?4cmO29a0VyKpLVwmwnqbvorAM6JeJQEqUG8RAntskOg0IARuE84Man2OWlQi?=
 =?us-ascii?Q?8dLzEwEFFruSEw4s9IKRo0KROjhYcVPtpIXUyypMkSgzpdG/eQCIm9Pm2WpT?=
 =?us-ascii?Q?qz3GOiI60MIs9a3OWIxtRUMhT/j42QnhkNfpqqmzSlAeq5GsR3ASTfCjrUtg?=
 =?us-ascii?Q?4J+2V9QqfGvMn98pjfA9FwqcbrQAtKv+3Cb28rs9fZyeTvFrw6VMJDYOuRlr?=
 =?us-ascii?Q?0/O7WjI8MsY4S+0wbJphgaiObclTh19btWOp5rgLXYoRRklSLvgkP62+30hs?=
 =?us-ascii?Q?yc45yia+RXvZUCn+DYhUQlVxTeoHRdN5XeXW4z4KZRMymsMLkB2zOKJigeqN?=
 =?us-ascii?Q?auPe1hsZ+jRWu0LPXG2v7XC+h15gSJ6TIg0LkZbcg1Upm6GJWSn0pvPKYFu/?=
 =?us-ascii?Q?nc1ht3NbAWcZlxbQVq5G2PvnBUBU0qiwPc5EoWjBU6UKg+xRWHRT3j4Oh5VF?=
 =?us-ascii?Q?xMoU2BqwneHVmR56tgbWTHL8t08H1N/k24BXxYjesXlNmvITaT8UVK2QAEg0?=
 =?us-ascii?Q?R0n6IiCIRAGtdvJJKERyDyrK75aXDHAu9GdbmOnCKRDJYvTqWeW755I2GU5w?=
 =?us-ascii?Q?cs8u0N5FfkafzKhrPlQy+Kg38tED3HcNJ+0gbI62CXELykvZdYfpGq3ATEuu?=
 =?us-ascii?Q?SnxvpMu1I456F5xdW/F6TtFdoE5vQbb6ynPaKre+P2M46sn8apTvD8A2EnRo?=
 =?us-ascii?Q?huqxtnwXho7mIk/sojNU3fjzVaNGwNRr6UVRshSVIaIY0ygf8fczkMcqhJWG?=
 =?us-ascii?Q?K1b0gICiNpNV7tQtb5rTO5Psy2KgnAn3Zdzemxbjidbe4pvvXSTMD34nCQO8?=
 =?us-ascii?Q?sjBtrIACe+J1GbJWrnAw7BnuBtxIdfLJOo4MQ8InzKZ056eh8lKhkzWBIA8Q?=
 =?us-ascii?Q?6Kxc+Uo5UBMXuDjBGj+zHVeq8oTbQvLh/r+Sh6O3WRfLXbz7KSmxWph6duN/?=
 =?us-ascii?Q?xd2ldwHjsf/i/893P8dkkt29kS4JhkPrgR+9UxleRWYRWinLkUci5+fBbJ6l?=
 =?us-ascii?Q?8jcKCqVG+PIHvI2fvAb7v+Mt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4b5f3e-4a17-4dd0-fb59-08d8d5cfd805
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2021 18:46:33.1642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 567QTiGSxJx0kgA5DCdmw75FJajgI77VRpo03jXcimeq27APfnzsLpWXEYr+5x1yaGESIrMCz5XiMntkYCPh8zgl+PLNgn4hEt12XX/eaJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5528
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/21 01:15, Yang Li wrote:=0A=
> fixed the following coccicheck:=0A=
> ./drivers/nvme/host/core.c:3440:60-61: WARNING opportunity for=0A=
> kobj_to_dev()=0A=
> ./drivers/nvme/host/core.c:3679:60-61: WARNING opportunity for=0A=
> kobj_to_dev()=0A=
>=0A=
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>=0A=
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
