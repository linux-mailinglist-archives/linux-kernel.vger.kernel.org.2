Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5495E3F1225
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhHSD5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:57:44 -0400
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:45515
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236523AbhHSD5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:57:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHwdlLXSR5GIdHdVgOkMnbZyMH2W6+3ScJIJv6R2kFc+dXjNfTcwf3Tr02yFNA2/MPYSSfKbJbnN7uYjgnGGAoSwJJeAfJH2QQwMIgC59sXC4Ot84NwVZAvc3+kgcLYnhnSxHT9QXEu1rFgUrYiwLoVR+qp9Hv/vE8eHVWDHrDFhlrQRbHn/x1soYRpx6QlV5CYQwkD6k0lC/wQhkE5YQvVgI0MH0Tyzi0QA/l+TxJS+m6wkx3gUTv5UrMwWhm1gCwa0F3ZOs9iV/PULDEZiYVOUVF4DwRUBDUonGO0pVGTKSGrgLsns5XZ6gmBVAovuXxK0dD0p2V8YUEmyk6mGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKxJ5I8e1GOWzdi3MvrtUHVkXu50nqZ252Iz2uNFsY8=;
 b=Sx3ed5UWE358aJ/ZKJkODjTpfP/rtEfr7WJZLVXUy7GTxBW0RIvp15NzTYagDTsBJp/7uce1hOCHdRfF04svuvkFUW+toSW5kfLz4YtINjYpEbHMY4OJaWc8uRkd2M+yN38QrdHbZ3/ag10hOBiJ591FUh1+t6ORo7WBzSV4Lsbcr/oTErX7j9bB+TUf1bGfBnVkWps9GKLpwjz7CYZ9Zy+TkOIq7i1h9aftGHMKcUUu1Eb5kr9h2Nj9A2/eKhYjyYpoWi471MHdSYKKQ+7ka3IT+jVlPH3yS8/A+X0/XyFS7ryhtJHFmlgPf80dy08AYY+dTSlCTgq0NyR6d2vzSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKxJ5I8e1GOWzdi3MvrtUHVkXu50nqZ252Iz2uNFsY8=;
 b=Mj/xauUGJfOEC2E83Hh8ojzqu3ErMGzPMePLYetMDPqGg7k/1rFamacG2fyBrodUGzRPe/wpdo/IXPAnASH7DyD91kiA3nGGJsfaMdFo2CbK5XZip74i9pnvdEAz659OLKs9bBcRG+nCBLwFiOgKNnzWJTRn1Hv8FRrvu0NfDDc=
Received: from BYAPR02MB4488.namprd02.prod.outlook.com (2603:10b6:a03:57::28)
 by BY5PR02MB6487.namprd02.prod.outlook.com (2603:10b6:a03:1c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 03:57:00 +0000
Received: from BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::99ea:4428:526e:4a82]) by BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::99ea:4428:526e:4a82%7]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 03:57:00 +0000
From:   Ronak Jain <ronakj@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>
Subject: RE: [PATCH 0/3] Add support for runtime features
Thread-Topic: [PATCH 0/3] Add support for runtime features
Thread-Index: AQHXk2ixXi8uESa72Ueifep+sQai56t46Z6AgAFLglA=
Date:   Thu, 19 Aug 2021 03:57:00 +0000
Message-ID: <BYAPR02MB4488B0685113564403A17158A4C09@BYAPR02MB4488.namprd02.prod.outlook.com>
References: <20210817130553.20219-1-ronak.jain@xilinx.com>
 <YRy/+epfpiRq2fLr@kroah.com>
In-Reply-To: <YRy/+epfpiRq2fLr@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c3d04f2-d02e-4449-f1fa-08d962c565cc
x-ms-traffictypediagnostic: BY5PR02MB6487:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB64876466619FB1B5F460207DA4C09@BY5PR02MB6487.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m8chqghQ506W69yxwjQz2CgHcQbf+TG516onKaRdJj+gyKW/cxQkGH2+AEMNwRgUEB05GSaDiFZfTo1NeXEW0LhskTqO07Vn/xA0h4zZz3HVfBsww0Ko5g+17sNu+1+a0g+VKjEBK4PXdcVcLX8EokxeWWxszyriy9QZqqgP9d2GFcwQM+bovvPZ9WIxXIsc017xS5RDHiCjZQk/eHZ28AdNnwvGFdE+eQdnPLGitkDifw46crc9bwP1mbhGuE0cOJ4vFGpJdJ20WxCVFRppsNxoju9RLUYnrlb5ZPTQTh/TIsOm5I8OCHYY58RvvEFTQ1aIhmoy9V+wvC+EVet2XwD8vCQPa3zKIaaCEvmkjVaCylgvMElPKtqDxrwweY4Ei0FQUR7OwPdsCdH5ExaEY4KRpXCpIyALgWtcL3c93kkyBYe/v6dOboEFPWrRRBpli9w8vLS6w8Gq6O7nZbl6eqgnt0ys9bkGzdfZFo6xJYZoe0t6PwcFPNZHgEP+y3b6bKwu6i1RBFHgS0tAEN4d1tVanH+24Q/6TfEAMbgDzbkjdf5BaMpIy7WDhm+KUnGE+BEQLxRseFRLGh6Xakw4fLq4JRHAAGUog/UU3n64UonOS+ZopWY/9rKhgEZgSnjcHwPvltCUBsTeFImt/LTOT3GGkUxJUJ6nxa1LdFbvBPiMur+BOs6SgJuZjgo/W8UricaGRzCxIpcFOtKYBYybgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4488.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(107886003)(316002)(6916009)(8936002)(2906002)(86362001)(33656002)(122000001)(38100700002)(53546011)(6506007)(83380400001)(71200400001)(5660300002)(4326008)(55016002)(52536014)(4744005)(54906003)(7696005)(66946007)(508600001)(64756008)(66476007)(66446008)(38070700005)(66556008)(9686003)(76116006)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DbcH6iHutJp5XkOeRouIlgRfCZfYj+p/cqPrNdlJMPlieyhftsuDGFRVcBhn?=
 =?us-ascii?Q?xaQAaiXjyoSNkw+qJ6zYIfCZyxXtxdFHH1FOeJg7KaDajn91y305zrCkp2zH?=
 =?us-ascii?Q?6OkyyFstaBEKYVeI3OI9nBuQTdjRW6oW/GjBgvhn//NCYFEdaPv2m+BaqGyA?=
 =?us-ascii?Q?yw5QZHrsuuZt4ecvjh31dAbZ8iq6Gv6Nt6dahRdwiUPzgChEq1UQ1ff6ogod?=
 =?us-ascii?Q?56BG/qfGLlmol4Jg9/MGxga8WvRDCjS4VGVBGsqeACgU5IPzbr7tpeBEtR3r?=
 =?us-ascii?Q?0SmHudEAmFrr+TIOGbuONnTbVJh/F1i5+iXBXfld3noI6Pr7Iax+cg7UXPBm?=
 =?us-ascii?Q?n91NIgObyGiNQK1pMmnW39AgFnkIzdbiMbvZAF8D8IxvRZh458opB0dpoxVV?=
 =?us-ascii?Q?10quoMiGDkqpuOu3NLh4HDDMZ7dJzlJOqjb8wRBurZP/krxTVmupKV/6zcB7?=
 =?us-ascii?Q?XyaPZM6h6fpKbfkO0t3pztZ1OJgK/6vNYbc4tEMTnHEzysZTKgVefJDINlI7?=
 =?us-ascii?Q?eQ+amvuj+dXvWqWPV0QXGQwkQ1qthshOUypjCXYZmcMTQqx5u7f1ocyPsYp5?=
 =?us-ascii?Q?hbimEceMg19OoChr8PCIT9RsTr8158OFIgWvUYHcetxM3JNiSl18CXnGNs56?=
 =?us-ascii?Q?0DS7JdPePx3OY3opKpMP5B35HPRiY90j8MmXIZr4hiMAe7+dR/zDThgH/75p?=
 =?us-ascii?Q?+W51Q3l+VV2sXD35grLE/95i2oQ2Sl/HJV9fMUF2r6XqO/RLMO5xbsqL8DMP?=
 =?us-ascii?Q?liMEGakQM/C22/uiNmZ4fxUHfeQ1bFyefF/7frYgWUn/tXqNOAmJg1S3Thcv?=
 =?us-ascii?Q?6jLXJNQACLBezyoStni9xAh1IPuXVjfc4+c2Cra9ycMaE5BCyOkeO+zGOzsG?=
 =?us-ascii?Q?DVrDJBfsVwfIjLmmJHiou5Ei5tWKG9CEIH43s7wPGqeR/jleoyEjSUeP3fWG?=
 =?us-ascii?Q?MbVHIMJekocFW4xmfAZRlr0amO6h+Cvj1WNmOkgfBcekLqlqJ/cfJz2BAqGl?=
 =?us-ascii?Q?nI6ibTaClOLbnAZVaObZXj7WpVNQAdt4N+r/HjAFWZZi0xK8W9vn+R/nVAZi?=
 =?us-ascii?Q?teFqpO6ErCG4OkbfEuVXU8oKYak9fQMZmii40dPqPKAqKMZ3GxeqT8pnT4Zu?=
 =?us-ascii?Q?YoBx9a3alGJ7VC4rIEXBitbhfSIYMv4cvQYr+TmGTBtJJhYpXGic+odtCeHR?=
 =?us-ascii?Q?FrGEQrvALvuUdZr972+aAGCkVuA3xczV4a41sbNSHzwN7lRLFz7Mxim/7MeV?=
 =?us-ascii?Q?cjKc60uKp75q6iygU/VHpccP+Zrlh7jPOA6fGeXEETGY8fSecxX8vgn0nCX+?=
 =?us-ascii?Q?9hdVEkXY9bXCB4dG5Kjkaa7y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4488.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3d04f2-d02e-4449-f1fa-08d962c565cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 03:57:00.4695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /TjAs2rDH2wsIM+SWHIaeSvsJWE8geAq/n9N7KU0ROFBvFua7EX2UImt8Oy+hfRE4bZFv3YoA2acrsEYo4Ts2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6487
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg KH,

Thanks for reviewing.

I will fix footer and submit new version.

Thanks,
Ronak

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, August 18, 2021 1:38 PM
> To: Ronak Jain <ronakj@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; linux-kernel@vger.kernel.org; Raja=
n
> Vaja <RAJANV@xilinx.com>; corbet@lwn.net; linux-arm-
> kernel@lists.infradead.org; arnd@arndb.de; Sai Krishna Potthuri
> <lakshmis@xilinx.com>
> Subject: Re: [PATCH 0/3] Add support for runtime features
>=20
> On Tue, Aug 17, 2021 at 06:05:50AM -0700, Ronak Jain wrote:
> > This email and any attachments are intended for the sole use of the nam=
ed
> recipient(s) and contain(s) confidential information that may be propriet=
ary,
> privileged or copyrighted under applicable law. If you are not the intend=
ed
> recipient, do not read, copy, or forward this email message or any attach=
ments.
> Delete this email message and any attachments immediately.
>=20
> This footer means that this has to be ignored and can not be used for ker=
nel
> development at all.
