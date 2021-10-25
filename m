Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965D8439129
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhJYI3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:29:23 -0400
Received: from mail-dm6nam11on2074.outbound.protection.outlook.com ([40.107.223.74]:45409
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230019AbhJYI3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:29:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beCjuwVepD5BxQWJH1ZXXqliuPcWYiqST9cVDEvFUL9yXIGMR807XGC7u3Ru2hOFSlrPrt3ndnLQleDTR5sN5/R2wG5oglvYGJaHLgBQqNqneAmjdTkJxRUEOHXVB1dzfwWzzNNC5cBPm2HABihy2HqEuV4DYsJJqH80lW14IZKMmqiC0Wr1KczbrkPmYYpNaN6jOd3dEH2SDnzcHLYJLWTCc63j1dY81gD2G9tsjvq0foJNOpiLphwWL5uonVUaRkhGzwL2BrW4ydFMDb0OGrXHI6e8kd50DrrRkDcn8jqKOvriMBcEdHCr4jR6S3a7GG2tuQLpCtkAEzT0JoqWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgVKUc6zVpcYLJOB0TrAL/Y+Mx8fGWoPE6oVPWErV6Y=;
 b=CpIJwXSA2aJ0MLNP7nb+Old1zuiRHQ781/MrJiyxdVGBfUO7wSIkkYLgobvE+/QIRX9Swtc8+1Vc0MdU1xpe4o1M00+DV+c5cQiSX0Swu9mtJDGaRRCT1tLQVs74Sbr9EBsv+bw+cer3aU9uGQ2G89LLOemtiW7F+paCoSSltSFeTOTc3NEoh6gn2ZJeXPs1NYZK679BieRfOuSSNNv2mZeuMu+lKuQ90LerzcqW+jue0g/vZmNSuwYk9agRFZaXx2l7ue1HVD/zJhLz/UHpMEiCm3KSmDGc6qPVJiyCUb7SGAFF6i6MqSKLsit/wZZyAkMw+oB2Oow2x8mHqvMxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgVKUc6zVpcYLJOB0TrAL/Y+Mx8fGWoPE6oVPWErV6Y=;
 b=dN6i6wRHVRueh9bP52GcxpVgUCsNW+P00nmoMIuDLR3XUQ07Vf6KWpGahg91RSJl2ZGCJun9EpZp8seE8iHrRh07rQeHNxDZgTIiFomhjFhErpCrYJwTr2c0E/FE86nAxljxZBpgU2QfV1NJeEelwkENYr88LpaVEDxJHWid/wM=
Received: from SA1PR02MB8592.namprd02.prod.outlook.com (2603:10b6:806:1ff::18)
 by SN6PR02MB4144.namprd02.prod.outlook.com (2603:10b6:805:33::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:26:59 +0000
Received: from SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23]) by SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 08:26:59 +0000
From:   Abhyuday Godhasara <agodhasa@xilinx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc:char-misc-testing 49/54]
 include/linux/firmware/xlnx-zynqmp.h:634:71: error: expected ';' after top
 level declarator
Thread-Topic: [char-misc:char-misc-testing 49/54]
 include/linux/firmware/xlnx-zynqmp.h:634:71: error: expected ';' after top
 level declarator
Thread-Index: AQHXxsU/Vlbz1f97Rke203LeX6yMqqveovwAgAAKL6CAAAOWgIAEtVtA
Date:   Mon, 25 Oct 2021 08:26:58 +0000
Message-ID: <SA1PR02MB85924A6DCCFFD8E71F03D348A1839@SA1PR02MB8592.namprd02.prod.outlook.com>
References: <202110220531.JFx7N8X4-lkp@intel.com> <YXJrOiVJmsn5hkGg@kroah.com>
 <SA1PR02MB859220A53FF48190EDD60A8CA1809@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YXJ2x0OgmLEU1hmU@kroah.com>
In-Reply-To: <YXJ2x0OgmLEU1hmU@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1e4d464-e196-4fe0-e816-08d997913686
x-ms-traffictypediagnostic: SN6PR02MB4144:
x-microsoft-antispam-prvs: <SN6PR02MB414414D7258CCCC9916BD62EA1839@SN6PR02MB4144.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vfJoXO4oKZeLPa5ezs0JXtHkD0sp/+o4kknC2o456AK9mBFrOOTZCTzPuq9Ky1uVFavKzL8/ekwoel2P/LTFMjZdfLCeTunqrGWrifNFtH2eYE2w+8wyrErRcIGvb96FU1+ST/AGK8wo/pf6KIrauoKKCQLXH6/6lsnFZ3mxg8WNsdPKHBnFGkKv6z5sVd5YcOuLgUBmaS1aHuf3AXUo9RZivwyl2pL4/hjD9ROpUAUPz5ZfuAQVgS8x/Jpn4QpuadN8vyTUm1a8kxq5ZameZ9usk7BJyzIzDrzBFzj4Zu0IIU32BykVZIScba2oO0g4gG1GyPv952aJckSQf/hDL/RmoI6LkRyfIUYsao2jhUaRDTilHmotQ2cNL3nqA4ItlmAy9NyfgyADS3CW1qg5QHpdJOf9Ra4ZOrNrLM+osXcpWlw/bgZ5v+eq2W79SzKD4RAfjSCgjZCf0CdRTgSCSs1FBJbUpmHPBI1RZJ62eucg+k6NMpYqiwt/ouvK0pC/UrHtTQ/P1/xi/f/KNtKjQQdR10qQsf2lC7CsturaT/W0h0uGzydRyhzkkpRcxjrX+3zbUrB6oW6mxYAipaWX8+Ni2XR54Ysowl4fycmgHZt8OTkKRiSWuIh5RuhB8J4JkA6bChTpmE/R2FxhVb4ychvlPxFIyTyWCQdx0l9kiYSZhyUP+cjaHRgYwFdB+jBGlcb3Emytr6O95B1F3cg90h/J4yUfrLDneHO43td10Y6eKQ3jrKalzD79ZG/FEkhbQtCsFzNLjG7FUWrRAi0j+9Oia5q9oBwoqTnXH/hRvg+DqvrFDe25rC6O4dS57NmtHqafx0/TVoucP6HTTj4ZLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8592.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(66946007)(66556008)(66476007)(38070700005)(66446008)(64756008)(966005)(186003)(9686003)(4326008)(26005)(6916009)(8676002)(38100700002)(76116006)(7696005)(86362001)(53546011)(6506007)(8936002)(5660300002)(55016002)(33656002)(122000001)(316002)(71200400001)(83380400001)(54906003)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fPBfvqgd2j7meKldoAd/5SEElphZ26UD4QyQ+oi18SUJIQLbCnIEH9SV34EC?=
 =?us-ascii?Q?Ls1k2pPrko1gdTRsCpjUM2DHxaq6TrzQq0OYBGncmQrxFGHUarPTqw6tkYOw?=
 =?us-ascii?Q?V4WSZmtiLHspFcQro0mgxVgWdIww+ddYc9FL9VTWwGeWTa8MOWvRab2Srv7r?=
 =?us-ascii?Q?CTqBUaLuJ+9UaFGTdYuJinipWq8rF4zcKz3G5gV/s44zKYZEQAbYQmnp4upX?=
 =?us-ascii?Q?dfDO7jYczHmxZ6YmrnNu8RyNfu4If3wCPTUZ0ehc7V7llMMnvTALP3vcyzzZ?=
 =?us-ascii?Q?bGY7GkJhNLTAYMHwDYX2buolGyp5MFZjlWBCNlN++XyDgPJjYgIAi6Y3JbiI?=
 =?us-ascii?Q?tFDF0l/FUzhcVdU0qTjJlkPM0zibB11QOdmrVlrQ+9i9PNEiqDx4XwcD9/nS?=
 =?us-ascii?Q?4Fg1SrpIlw1hDAbEflOCiCuKgL14obzJ0PYzgVT60hvM70QQKVRWnTdLRsCu?=
 =?us-ascii?Q?3Wa3RAZn6ggaPjlAr/I4jPekjFYw4B+LupVAl10doYdLEjuU5eIYztJYssAh?=
 =?us-ascii?Q?/eNSg3GLtsuHxlX1D2NvJrnl2NTUgQLsA3hLM/56UP+qi0k/Tn5B79qf1nrQ?=
 =?us-ascii?Q?Fmb0GlMyczA0p7ck79Z6IrPVwwi6KGv75tF0w7+R/LjfHgS0I1NSk24P4MNU?=
 =?us-ascii?Q?eKQmrFTXxMD9HSHQVRv3fzJQxKzBIcIC3I0ujQngPWZWRA0gXr+oTga+4B2x?=
 =?us-ascii?Q?Ax9WlerbavU+UTrxNJu7cWAJVz/kbyBT4u2ZvBCkure9eUE+b/uS58xPU6op?=
 =?us-ascii?Q?9mvYf4Xr+A+ynOkpqwy3O2Wjvg0VcIRWiVxKX2s2jYLXG1yRAIfhKuTcTY4T?=
 =?us-ascii?Q?mBR+uhwzrrJ4qMNAazdacu9txeBkyGCFhitfC+ZpjgzHumeDkZgP8YgDK6QK?=
 =?us-ascii?Q?A8CBSWqfpXxw67obBaXbVyypwCPckPwUzPr8F7In+DyxgWTQ84tWPW3KwrUK?=
 =?us-ascii?Q?Y4joKYwuYTX34uMBEsPUTQO9rMOcFP4BaU5s/ovJNd8+6E5IU4Gr8jPT+doL?=
 =?us-ascii?Q?hYP3bLobK6ySTqzpdTAGjA3wqTOXVszInlIbJepoh8ekKd1TaeW51ufHKq5L?=
 =?us-ascii?Q?QG9D1LlHLaAeaBSCcnoLeuPGM+BeiX/TolaXq0tMviOgTLN0+uam1vP7zGcp?=
 =?us-ascii?Q?/gRi2i5gXAjZxZu7aBibo8LTMUz7Qds2YigrvZ66q1T/q0LtdKVpIc7UH12X?=
 =?us-ascii?Q?dzmDpWEOsQ11I82dYEA2uQeezalQvenOInxjrd7ew9ndriCQ7GeBagg2baSY?=
 =?us-ascii?Q?DSwtbdbOSg8EMFxrt3zxQrChpQPLiz3P9ouafFVrw5U8wuH+fSjmfNGXe9FL?=
 =?us-ascii?Q?bEe2XeHOj2uzZt5HNYjrMUxx8pPj92Ul9UqCQ8q4wS0k/PxnkoKy68BkN3wW?=
 =?us-ascii?Q?p1cZsyLLJtlIpf5oi2zgndyzDIr9cY87Ii2PdqqcxdkFIbWVc3jWD4k3/0Wu?=
 =?us-ascii?Q?LthijomlelOYZieOCzmbBSMn+aYYaV2KU9XMzD7l2z3HK51i2WuVtIrOUp85?=
 =?us-ascii?Q?sMSQZ5JCjGaNwxv7nKwCw/S0lPa5WtQT5j+pLloTf7OJnnbfJE23XRnwKrUE?=
 =?us-ascii?Q?JHAOrm7jL9Ai9J22B8ECW6gqCnSmunYAkbcWL33lPWLJeQybpGsAHYH/YfdJ?=
 =?us-ascii?Q?y7bBH84aa3Zetzc6PfyXjvI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8592.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e4d464-e196-4fe0-e816-08d997913686
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 08:26:58.8915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pBz8B/7zLfF3UkmL02+w9XC2jO8wPnkgSq2HpkEeO++bQlG2H3SzSQvYiYHwBdQVQ2XvSrmjckdzH2fl+wbpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Friday, October 22, 2021 2:01 PM
> To: Abhyuday Godhasara <agodhasa@xilinx.com>
> Cc: kernel test robot <lkp@intel.com>; llvm@lists.linux.dev; kbuild-
> all@lists.01.org; linux-kernel@vger.kernel.org
> Subject: Re: [char-misc:char-misc-testing 49/54] include/linux/firmware/x=
lnx-
> zynqmp.h:634:71: error: expected ';' after top level declarator
>=20
> On Fri, Oct 22, 2021 at 08:20:18AM +0000, Abhyuday Godhasara wrote:
> > Hi Greg,
> >
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Friday, October 22, 2021 1:12 PM
> > > To: kernel test robot <lkp@intel.com>; Abhyuday Godhasara
> > > <agodhasa@xilinx.com>; llvm@lists.linux.dev;
> > > kbuild-all@lists.01.org; linux- kernel@vger.kernel.org; Tejas Patel
> > > <TEJASP@xilinx.com>
> > > Subject: Re: [char-misc:char-misc-testing 49/54]
> > > include/linux/firmware/xlnx-
> > > zynqmp.h:634:71: error: expected ';' after top level declarator
> > >
> > > On Fri, Oct 22, 2021 at 05:42:37AM +0800, kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char=
-
> misc.git
> > > char-misc-testing
> > > > head:   0a6af10747d4dc25e9c85c7daf156459f28e0e55
> > > > commit: 1a8eae64b30f126c0786f3807982d49ca3be8f7c [49/54] firmware:
> > > > xilinx: add register notifier in zynqmp firmware
> > > > config: hexagon-randconfig-r045-20211021 (attached as .config)
> > > > compiler: clang version 14.0.0
> > > > (https://github.com/llvm/llvm-project
> > > > 3cea2505fd8d99a9ba0cb625aecfe28a47c4e3f8)
> > > > reproduce (this is a W=3D1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-
> > > tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         #
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> > > misc.git/commit/?id=3D1a8eae64b30f126c0786f3807982d49ca3be8f7c
> > > >         git remote add char-misc
> > > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> > > >         git fetch --no-tags char-misc char-misc-testing
> > > >         git checkout 1a8eae64b30f126c0786f3807982d49ca3be8f7c
> > > >         # save the attached .config to linux build tree
> > > >         mkdir build_dir
> > > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang
> make.cross
> > > W=3D1
> > > > O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash drivers/
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > >    In file included from drivers/spi/spi-zynqmp-gqspi.c:13:
> > > > >> include/linux/firmware/xlnx-zynqmp.h:634:71: error: expected ';'
> > > > >> after top level declarator
> > > >    static inline int zynqmp_pm_load_pdi(const u32 src, const u64 ad=
dress)
> > > >                                                                    =
      ^
> > > >                                                                    =
      ;
> > > >    1 error generated.
> > [Abhyuday] Place where this error generated are not part of my patch se=
ries
> or changes. Please let me know if there is an any action require from my =
side.
>=20
> Your patch is incorrect, and causes this build error.
[Abhyuday] submitted the v6.

Thanks,
Abhyuday

>=20
> thanks,
>=20
> greg k-h
