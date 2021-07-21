Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D63D0B23
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 11:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbhGUITf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:19:35 -0400
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:60289
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236664AbhGUIGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:06:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0uBQoRUM7ufeQ7LtU/WxppJMjAbBdkTCmvOPu+lx3TO4Y5R9EcnUrr0XlIwjFhJEltKdzxOFtSpu1AldYftBFxlQaXkFBro11e7/jJOohHHPfhlRPz8fCEIZvg3qBsqaiLNowEmajv2F7K7fDbbponnFYU0i0YW2nptp2NSOp0Dc8DI8mrPJQMQEBbaDjp4QdybAXlmCE1UaG0iIS3T/uXy0BY8YzfPKsZz1PTLpyWXpnOnjMov4XqeMTDaTyv1gBGVi95yEF2nawn/+Jeyb5cmujhMAAd2oNiVeXtg9C8/wLa+1fRHaLRif675JHtRUagtP0DGKxVto2VRM8dS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ4LQTcJeRH43yVu80Zggug97tAGav3VLKLpniGSejk=;
 b=C0liy3N2+hsUFXu3dBo+TlVAUH0KvCLPRFhflH9r96/2bbWTs4VkqKX21FlZ/TH16fWbGxeyp+leJL9u/JwDO21h73U2ReQdCdAluvrnsKtz+2+wb/J/BZzF7WdlfkDnyOy2Wpa1ZRncCPJMTcb4GHVhLzyImMDClW+/sSPqtRdF+ep86rin1lutq2y+eklpRR/feFOGxPpkCzgMK0OCQIQJ/cuFOwGKTuTe5aS0fg0+WFp21ryjMgCb+uOSnlkaXmMqyLEomqVKHcL3zr81Mttlgq8TBXY00XTvup5IHZ+BL1Sn+FQ+GPPFWxbN+zoNn0OqlbbgLeK5vqyhVb8POA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ4LQTcJeRH43yVu80Zggug97tAGav3VLKLpniGSejk=;
 b=U9u/QAw0t623F+o6Mqqj8IzQVWAw5x8jx2+dU63Aj5g6lKGePggk8wrEJiT0o9NRkYNzBj9URpseHQ4Y41bvWEuy0Cm9FI1HCOLO7Ho3SbbF4WIXjBZpaHg4USF6J60KRZnqG3jU82E8mQmzSViT8Pj9PD53N9ZCm4NeHV8y6yo=
Received: from DM5PR05MB3452.namprd05.prod.outlook.com (2603:10b6:4:41::11) by
 DM5PR05MB3609.namprd05.prod.outlook.com (2603:10b6:4:45::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.8; Wed, 21 Jul 2021 08:46:15 +0000
Received: from DM5PR05MB3452.namprd05.prod.outlook.com
 ([fe80::94c0:39f7:9695:56ea]) by DM5PR05MB3452.namprd05.prod.outlook.com
 ([fe80::94c0:39f7:9695:56ea%3]) with mapi id 15.20.4352.024; Wed, 21 Jul 2021
 08:46:15 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH] MAINTAINERS: Update for VMCI driver
Thread-Topic: [PATCH] MAINTAINERS: Update for VMCI driver
Thread-Index: AQHXfVIP+6abVM7c7EmQXyuZ/FLCiatLrFmAgAFyvYA=
Date:   Wed, 21 Jul 2021 08:46:15 +0000
Message-ID: <0C3493F7-AF29-417B-94EA-26871283E65A@vmware.com>
References: <1626776941-9163-1-git-send-email-jhansen@vmware.com>
 <YPan14jucU9/u6JL@kroah.com>
In-Reply-To: <YPan14jucU9/u6JL@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcd9405f-b740-4396-a79a-08d94c24005d
x-ms-traffictypediagnostic: DM5PR05MB3609:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR05MB3609F6C878F2818360024AA2DAE39@DM5PR05MB3609.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9M9DHdQbtaydeNBNZW34vxy/liGEc8YQe3oP3Mymw+bRor9hhyJRaDgUxME3FSUD1PDHHZOK/zGVFs1AbA13xbPdtpSnOsErae0hiA0dG5wZ2lH9s43qjvUtm6xEDYbG1JDerbd982VC0ezHu/IkiSXc9QvbOzqQ8nvt8Fybt5r034KMlXgoF0210Kn8PncCCo71oRJWCvifX7WOq8DbSTb6DxVWN6tyR/ebzEkvpymbGXfSW7QKeQPWgzVpYZqGjE64mlzISs2z8opRyTLqFoNk/znuvAUe50zOK3mXErsfpT4Ge9yNXhfeiUzIbyBK42R5zxK3dP04je3m0hdHm1tV9RiZCgGJfu+av+pI6Sgl0SQoBsqdV7DIPxJcX/t6yQYqstgkzkiO/QK7QZlDdd2UuF+DtPX+8pJBQ+tgpvHClpS6F8Yl0VXRtG32euMPxZUkZIfgckVcsUcGZTuDqgt42N1xQYtyOJuRLpHe2qTw39o4HKxYfgGrAKV1TN6auOa2V45JkJruPZCbAmUdkQ2JnZJvDGfSC5kYNl1606Yfy0CRhtD7FJlozHx9l8XP3XMq5fSe9MjDeVH0lE6Z3dtxveqf41TtzZxaUT+eguYs/9NX9dHN6lugg0Ylai5l6yvgZ4pEB53nDMaF3GAhBWiMzL+iUeT2Bs8Dt0tvITOHqtxCLZTlZbGkf2LqP338VEMOC5N0hITcqoMZPU3OgoBDTxz8F3aOZglb9vy7okU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR05MB3452.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(4744005)(33656002)(6486002)(6916009)(38100700002)(54906003)(71200400001)(66946007)(478600001)(186003)(36756003)(8676002)(316002)(64756008)(2616005)(66476007)(53546011)(4326008)(6506007)(6512007)(8936002)(107886003)(91956017)(66556008)(76116006)(2906002)(122000001)(5660300002)(86362001)(26005)(66446008)(45980500001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HbvMekzgtZDhWDNbcqpyE7hiiFjUqlcGBefSfzzKkduWJMsWQ7dUsiLDLYgJ?=
 =?us-ascii?Q?rzZDkiSt2RL+EYWH1LH5sZZmd4Ju51xbYe0xIXq6ZzZh61Wbv1GLLoPB7mUe?=
 =?us-ascii?Q?MoBR7pVK6XefrTCl6BcKrBDxFCT5M3uYqqlxyxWllIElZz19t5ulfsGmxNEA?=
 =?us-ascii?Q?DrvNMUp1BnTRXxk5j7C0hWaKwELYgk/5T/OquKNdovrthB7U2czvNE6FcyQ6?=
 =?us-ascii?Q?mqNGdCvBk4AWPijcgKP5K3Jx+qWIawGHiq39TcM0QOPsd/fD4xV4evLoUa+i?=
 =?us-ascii?Q?5JrWnv8Up5fV0eyK0eYCjMXi0qU8Dyi1G+7x+FDvGXrxziDc3kOAuJL6wgpf?=
 =?us-ascii?Q?9KC3AwcpzrvMDjaFikA6qDTM73m0H1UYt3GgxNJ53d45QwdPLMnMC2o5uahL?=
 =?us-ascii?Q?OivlDjYpKye/MUJIWABQGT7WlqpKguNNjdF0J5pkZEBMiChbjSTQeqs8rwPa?=
 =?us-ascii?Q?ubM+7nE2hlAUb7cPiCAOjkGxpVoB7VGTVHRNMOs9sK43oh4amIqSke9q28BT?=
 =?us-ascii?Q?h0rU8rANWmfWEWsBqPz9C4Fupfz4fFsBKV89f4cRcclGJCHNXFkF15MulStu?=
 =?us-ascii?Q?V/Rx4qzciEC3EXb6vJS5IPd3z5RPvxK+269n+PVTYkEp0gw7/lboC17z+pca?=
 =?us-ascii?Q?NmJL3bgrLhKbdOn84Nzfx1rJTcydqVXH6F3LxTAbn/Aq2fKdZZZwA4SmZrhE?=
 =?us-ascii?Q?HCVM1qclybvTNSCvvyiWYuja2Xr+0SOysVcPOI+ZwrI2poOonKaTLB5X5s5a?=
 =?us-ascii?Q?2dr04AttgqRB02NFMvGP1piQuhfMQFfB0+HuwfooRN+vIEOylu3tV/D/yGbG?=
 =?us-ascii?Q?QNlbrjtAEPMS7pTPboW9Araijliyz46tHVByp59T8+Og3PIjTdXtCe06O3Ep?=
 =?us-ascii?Q?1z2+VMxfL6KwzjbyBmAmoJVZQRazrmi9mUcuogD9VFx/7e5p4pl/WI3uf5eq?=
 =?us-ascii?Q?hGbDQBdIEG/X0Ea2jVja6bY1VWZcScnbxj/+pi+rW5Cg1fsaAu7X6Ddmpoq6?=
 =?us-ascii?Q?nfkD4nMzDPFLw/hvJhqqwWzAKlHfZ9tDatPrzJ0hnO1EIKFlO2dBvXUMsx/Q?=
 =?us-ascii?Q?QLcQpwR2MBDaq+ZWfxc6PXnCExvUxiW1afKwweRHCmAFcI8WYBXnMgZ3eNfq?=
 =?us-ascii?Q?VkowZ88pQXhq2a9ej3MS5vv64xMUNUDnLGJ8lc3E+0Be8+Lu4RNGzqE5CrL1?=
 =?us-ascii?Q?pQEXAapNQexPBgYU8nmAZCMQYvO0bd3HRHe1JE102q1MBNUJq8ctLtpxXQCn?=
 =?us-ascii?Q?b/B+fnHTwWDhUeiBc0zXjaL5cHw+LoCJdSwPIhit7TsgCrvIgv/HnW8/445R?=
 =?us-ascii?Q?8mkdvN1t7ArYjMrjcr4F14ZT?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F343B171B275C4C9D190AA1A4DF02B0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR05MB3452.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd9405f-b740-4396-a79a-08d94c24005d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 08:46:15.7517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4AUOZhxseDfKECp/ngG5S/sSE1wcfwn0A8U1I2gj2JBgEZzHuGt4vBut+bAhOI40jzMMTnkYkMmBvmgbfdibg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB3609
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 20 Jul 2021, at 12:39, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
> On Tue, Jul 20, 2021 at 03:29:01AM -0700, Jorgen Hansen wrote:
>> Add maintainer info for the VMware VMCI driver.
>>=20
>> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
>> ---
>> MAINTAINERS | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a61f4f3..7e7c6fa 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19792,6 +19792,14 @@ L:	netdev@vger.kernel.org
>> S:	Supported
>> F:	drivers/ptp/ptp_vmw.c
>>=20
>> +VMWARE VMCI DRIVER
>> +M:	Jorgen Hansen <jhansen@vmware.com>
>> +M:	Vishnu Dasa <vdasa@vmware.com>
>> +M:	"VMware, Inc." <pv-drivers@vmware.com>
>=20
> Please do not use generic aliases as they provide no personal
> responsibility.  Just stick with real people.

That makes sense. However, the pv-drivers list is used for keeping managers
and people helping with testing in the loop. So would adding pv-drivers as =
a
second L: entry be OK?

Thanks,
Jorgen
