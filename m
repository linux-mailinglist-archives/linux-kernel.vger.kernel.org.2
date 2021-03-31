Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87043350207
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhCaOSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:18:21 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3170 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbhCaOR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617200278; x=1648736278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XnvPxbBXboMXThG51DhkKacds/bACMwNyqUuT36GveY=;
  b=MTbN/gQ19wHq/IAV259l8yoOY3vKrrkORtNqKcajr9eUNeUsUtaNGYUS
   LgL6qNAf66mQ5WHDiOxVE68rMCXy6ElVN1+KWFguIR1rAmc2mwcJrhT9o
   XngwZj2r7JtUkPsWDJsuVNP5ZLwhsZ07cesyxPcxpAREzjq2d7GhXxAzK
   MQoVoCg+W2vNPYiAiMEFlNlLhEW+rMY27s5K4+E6713JffwQdGq/3P+6E
   +0dRr98siEkaTmKDnXFVi7AGilPOVOg+NiiyeWGN1wWeUEdmzq5S70zW9
   BqSZ7StFfesmOWKlCju8inIUEW3NQtLQU2H9gkbKAZkuzi9m2Pm/F+YPI
   g==;
IronPort-SDR: 35OTDcTHH1U0xAEAd8gWMXVOdFUs0uY1MpVK7upZjKtEKKPiSvPj94Gw3qwKXY23FN2efp4BqJ
 2/8hkzM+wK2nEkW4vJ/naVIzut/GnjB/Nl1tWUyTNFMUx0akSSTXrDM46Im8P5x3d2ZD+Ec51t
 WFsP21J8sAKQVPS1Zr4ILsrJKwjGQhInwtvNr4VVX9BGs0Oag4Z6S8ZyPpTw833NqdJJ1ivzbY
 EqiTAXJrhYcZ/3d1sHSP1J/U1Yf+cMgud4VVcsSwb08Ll+bXmdknaZMoFCAIkZTcbthvsFMhgc
 MTs=
X-IronPort-AV: E=Sophos;i="5.81,293,1610380800"; 
   d="scan'208";a="167930898"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 22:17:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNT0Fke524gZlhiKqN9EO2+ClHyF2gA+V9GwXNbN0Y87NW4SkOUom0pxRBTqOtA5BfxDqptBnVejOETwYbaqL7kNLTJAQ8harFTjzWLkz0OtoNKybDVKc9Z4ctFpAZY040rKopb51f3ACHCEFeAVYGe1pvQEljIyOXX9DmESBgSmDVOMZs17ljf9h79tqmoslGHgnT8Os26Xc791AgkLWX0uAV6zSli/ql2iGXoxs9JQxBjEz/Dv10LJIN8xP2ZbOUVdfIbkRPlqc7rqyZIRXwFmT7bHcWGpKmdv2QqL9WYdWl7oDiLn/ZIobKvzLjNExrykYEhATqSO9mGEjT93Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0+2zV+mqkLXlcM2yr9VSGPjWJmAYaT+wp2gs17Pz/U=;
 b=fZ03FJUz5YI8LBSNOs0JdnTR5ndfVTl03CDRDM5egfvNtRIe0fQuDygWE8+NI3WB87FiSU6hv1eMhUdtvGBhPIYXXtoPYvk1s+RtUVs73XFcF8+aRtwVShJzjQ6nsil3hhv83FidnbAboK+fZPfPeof1h5WOIcG6gSoY7xGvN74Hti3H8KvC5VwTqKWxuCHiiVMtadX4bgV8JHQ4/sOfP1ohFHo0Ruk2JnBA0LwCgcbeBdkf8+8UvTiKSFoq8sR8c5rGLqtwhgjhiNOk9WWl1z1vs/M0AQl4S1uJSt6h0qYjmnDh0KGv/WVx0kgICVPA+9FOiQdWjptWaV5c09TsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0+2zV+mqkLXlcM2yr9VSGPjWJmAYaT+wp2gs17Pz/U=;
 b=fjwNVTz6yazGjgnNtqEjqkcZRDEQcWyD/ddEOO3Qr3eUiVufXfy3rRe6HRCVxs23KhELyNnLZTHatl2qbcuLWnz1QlCCiAxYZwzu2324gr69wVG+LyOhAQ9gGQYzaQWP6WIOMbAcrcNRzt5Tc4tL5/frto4XY8zSGq4Os90Gtwc=
Received: from CY4PR04MB0678.namprd04.prod.outlook.com (2603:10b6:903:e2::7)
 by CY4PR04MB0870.namprd04.prod.outlook.com (2603:10b6:910:53::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Wed, 31 Mar
 2021 14:17:56 +0000
Received: from CY4PR04MB0678.namprd04.prod.outlook.com
 ([fe80::642f:22c6:66fc:24f2]) by CY4PR04MB0678.namprd04.prod.outlook.com
 ([fe80::642f:22c6:66fc:24f2%7]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 14:17:55 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "javier@javigon.com" <javier@javigon.com>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] nvme: allow NVME_IOCTL_IO_CMD on controller char dev
 even when multiple ns
Thread-Topic: [RFC PATCH] nvme: allow NVME_IOCTL_IO_CMD on controller char dev
 even when multiple ns
Thread-Index: AQHXIoL7j11tDXmjqEi1+b31xtgfo6qc4HYAgAFLyQA=
Date:   Wed, 31 Mar 2021 14:17:55 +0000
Message-ID: <YGR/9X2y1ci/m/1v@x1-carbon.lan>
References: <20210326205943.431185-1-Niklas.Cassel@wdc.com>
 <20210330183022.arjiqiufiuqkrvwc@mpHalley.local>
In-Reply-To: <20210330183022.arjiqiufiuqkrvwc@mpHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8fd705f-58b6-41dd-b089-08d8f44fc781
x-ms-traffictypediagnostic: CY4PR04MB0870:
x-microsoft-antispam-prvs: <CY4PR04MB087046081B194FE8EFE02E39F27C9@CY4PR04MB0870.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /O0MKq+q3IzW4M3EWS0k5qE6whK8a+5N1teT2Id8iGVZsjhWGW1IjXzMeYdxAu9pV9mLLc5b9o5s1+GG5aC4Vx5dNRGyiwOQceHg9picQJZ9mu7kPgQ2AFA+GCY1fZ6VwxW10bihtsrJ20ElSjoHuPjc8nsqfMurIgg3LCOixOjoPLyKaBQwir33UYbtn0MDdHyvyZhMpmratnO3vXShDHkkMOYER5OiATUNgIaVlloDknVFAqmKIexhSzNJ+1MrBm1xXBhZolYAJGH9RQ2uUPkmW7GUm1jPXKLrOxE2UYGeRRmmFBCFdQ/zrKD9RMSBewljim4h/XgRKxPNwv+FSUMAJF6KGJjnbBEKZs7P/BZKrwbJNiwwEOwssoTTEjHtYixH8ffKUdAB4mB6quoEcmie9I4KcfGGqWW7QkdTulB53iZ6p/aN/C/GdVKixEc/yUkSHEms/T8bjY1Jk7CDfEavvadniUviwHlAfAqmEUjFofcRXh+JOUqCCVBk0SubhZ9m3q0IS6x3cFaGfC65u8s5C6kurF7lLgKLlB1D5yQpOPeIWoJMoyAhFgAiFfGYhc7L3SRaKBhZAl/aYg5v9Dlv6MRsyd76G3CKVJBV9yiu2et7BZ4EsyGlppRFtUGitOfNRu1WUqVp99C8Jbhd6X6ggY6b8oSWnhmn66U734o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB0678.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(478600001)(186003)(36756003)(71200400001)(66946007)(66476007)(9686003)(6506007)(8936002)(66446008)(66556008)(2906002)(76116006)(316002)(6512007)(64756008)(54906003)(5660300002)(6486002)(53546011)(38100700001)(91956017)(4326008)(86362001)(26005)(8676002)(6916009)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BYNJj+f1UbIf1og7AmlAiA+qb+vh0v7S9+bdNqRpCh/mQu/8EIjHOEBr7Qh9?=
 =?us-ascii?Q?wCatMVSyGLhd0tXiU4qkhszZgubwQ0tcLtlJ3KHwlka/3yPds6Hgqu2gML92?=
 =?us-ascii?Q?yT1PiLqKU5ac5GE/3pCWDinEle/rP8ReZ+5t8Wkn0zizZMqqGj5y4q4kBxoI?=
 =?us-ascii?Q?uMYDqDKZnzsy4W9s0y/qFvx6BqR/QQjZsBCB/Czo4KISuz3KTsZhBK2lzp6Q?=
 =?us-ascii?Q?sl9y0icWIPzwMBjrYY+Yh4rFsye5PP7TEFFhPOUXbT0ojJDkDy46OGumERD5?=
 =?us-ascii?Q?FDbMTLEw6ZK3lPQ6NH1qQQgMbB8T9xFpyI/0QgpIOLQNZeAdiT9ld7/VDo6Y?=
 =?us-ascii?Q?C+TjiDSp7dWQ4MLgAGyp/UDBqJpAN0as6J9EvFY6j1YGySKy82MTl/6h4era?=
 =?us-ascii?Q?S+CA97/NGB9HmWIQcWH27WgCIL+smBNZt03w0x2G7oqkmaLLpHUc+x7WK9Ht?=
 =?us-ascii?Q?T1LgWp+jLgBVxq5GH40mavvI1gUuEodioGSzEKJtbSYfkgjE0A+zJ2m7cOHl?=
 =?us-ascii?Q?BRy4NsAgsgT6bNaxhcfPfqh5+8AJECnRPa6sTFd7p+zEXkzb7ZcPsveuFclF?=
 =?us-ascii?Q?UnHtrQyN3xwumz1aeoqCNTd0860kv4qqgS6k4SKcs57e2eiH2EVA2WsA6mIC?=
 =?us-ascii?Q?g0CmozThnnvAkoDxCibCDHi37CPIDWVlmfrjHnpN4Q0XsAOXajBUAYm2g/34?=
 =?us-ascii?Q?Jwr4hyMeW98q2HiWwHhkfiB9LqZ3eS3WRIgr4NMFlfXXht2SljZPtV/hevBu?=
 =?us-ascii?Q?2jmIHGEcrf0+gK1GGNTLkimQP86TSNAmMAj2ww5OUIVQulsTSpKZtqC0BsxK?=
 =?us-ascii?Q?CwO3TbDzr0FNeeVh2RXSIJAWAEhjCqdE0w1BpEM5ydF5+wt8rfrXWc6sq5vq?=
 =?us-ascii?Q?qfIjJ3M39qfCGBDggEWLgIubTrq/ubgR3C8kTnG70vMXGYap4pl/qTD3f9gZ?=
 =?us-ascii?Q?DwdMO3Z2Ey20VbzhH7IuCvyXCOnQg84ZtwX0xXMhCwx23heFABNMMWGo5/z7?=
 =?us-ascii?Q?vJE0Yh9U1me+2bPtc9ht6X7MRrvVhJ3o3Oue6GThS9wsMARuVxYlW4lhduyp?=
 =?us-ascii?Q?FdkccvbZ7lSHw7vNPUrKkyS5P9BahP8aOsZzdoa5V7xEoiraMV4CYJiNrRB6?=
 =?us-ascii?Q?ujNCIdy2uVmXc9IfQS8/StssfZ99fsZvXtc8Cy7u0YHfGWJ9KGB+f/bFudyR?=
 =?us-ascii?Q?uHUHG2xZmXG/Bsh+1SrZYinzabflAeEUrEf4qwZj1noMBfAVgr9+sYjhywHf?=
 =?us-ascii?Q?FU6lLV9GnmhF2HBdJRvKjjtenWnuQCjyGkIzhxiZHp4gm3BKy/8deHuOvC8p?=
 =?us-ascii?Q?zXZzBuJU4bBZKWJfPvFJjIZT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B8B4E1667CA264B927CD9022EEB1585@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0678.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fd705f-58b6-41dd-b089-08d8f44fc781
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 14:17:55.8404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJ8lNa6D68pVRrtnLWk5nq46nd7Jrh4CRekwnEmk86sGyXMdXSGnI6I+q65cqCKbqM+LmauQwtHaFgiLVrl3Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0870
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 08:30:22PM +0200, javier@javigon.com wrote:
> On 26.03.2021 20:59, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > Currently when doing NVME_IOCTL_IO_CMD on the controller character devi=
ce,
> > the command is rejected if there is more than one namespace in the
> > ctrl->namespaces list.
> >=20
> > There is not really any reason for this restriction.
> > Instead, check the nsid value specified in the passthru command, and tr=
y
> > to find the matching namespace in ctrl->namespaces list.
> > If found, call nvme_user_cmd() on the namespace.
> > If not found, reject the command.
> >=20
> > While at it, remove the warning that says that NVME_IOCTL_IO_CMD is
> > deprecated on the controller character device.
> > There is no comment saying why it is deprecated.
> > It might be very unsafe to send a passthru command, but if that is
> > the issue with this IOCTL, then we should add a warning about that
> > instead.
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> I think the idea is OK, but I have 3 questions:
>=20
>   1. Wouldn't this break user-space when nsid is not specified?

Since this is an ioctl, the kernel will always read some value
from cmd.nsid, so I assume you mean when specifying cmd.nsid =3D=3D 0.

I don't think we have anything to worry about because:

a)
Like Keith said in the other thread:
"There are no IO commands accepting a 0 NSID, so rejecting those from the
driver should be okay."

Currently, when sending a NVME_IOCTL_IO_CMD on the ctrl char dev with
cmd.nsid =3D=3D 0, we will take the first namespace in the list, use the
request_queue of that namespace, and then send the command there.

Since there are no I/O commands that accept a NSID =3D=3D 0, whatever you
specified in cmd.opcode, you should get an "Invalid Namespace or Format"
error back from the controller.

I don't think that there is any harm in adding a check (which is essentiall=
y
what this RFC does), that will reject the command before sending it down to
the controller.

(A potential improvement in the future, on top of this patch, is to allow
nsid.cmd =3D=3D broadcast address, but that is out of scope for this patch.
And no, since the current behavior on master does reject any cmd when there
is more than one namespace attached to the controller (more than one ns in
ctrl->namespaces list), I wouldn't say that master handles this case.)


b)
If you use nvme-cli then all commands that calls nvme_submit_io_passthru()
already does:

        if (!cfg.namespace_id) {
                err =3D cfg.namespace_id =3D nvme_get_nsid(fd);
                if (err < 0) {
                        perror("get-namespace-id");
                        goto close_fd;
                }
        }

So either if you do a:
nvme write-zeroes -s 0 -c 0 --namespace-id=3D0 /dev/nvme0
or if you completely omit --namespace-id:
nvme write-zeroes -s 0 -c 0  /dev/nvme0

nvme-cli will already reject it (since the controller char device does not
(and can not) implement NVME_IOCTL_ID).

Sure, nvme-cli is just a single user of this ioctl (there might be other
users), but it is probably the most common one.

If nvme-cli already rejects it in user space, and we concluded that the
controller will reject it, I think it should be safe to reject it also
at the kernel side.

Without this patch, we are already rejecting any command, to any nsid,
if the controller has more than one namespace attached, which I think
makes less sense.

>   2. What is the use case for this? As I understand it, this char device
>   is primarily for admin commands sent to the controller. Do you see a
>   use case for sending commands to the namespace using the controller
>   char device?

I don't have any use case for this, more than allowing to specify whatever
nsid you want in the --namespace-id parameter for nvme, when opening
/dev/nvme0, even when the controller has more than one namespace.

Why allow NVME_IOCTL_IO_CMD on /dev/nvme0 when the controller has one
namespace attached, but not when it has more than one namespace attached?

Doesn't make sense to me.

>   3. Following up on the above, if the use-case is I/O, don't you think
>   it is cleaner to use the ongoing per-namespace char device effort? We
>   would very much like to get your input there and eventually send a
>   series together. When this is merged, we could wire that logic to the
>   controller char device if there is an use-case for it.

While I'm not against your per-namespace char device effort, I'm not sure
if clean is the word I would use to decribe creating a bunch of extra
character devices, that almost no one will use, in the root of /dev/ even
(which is what the current proposal suggests.)

Perhaps it would be better if you had to do a
echo $nsid > /sys/class/nvme/nvme0/export_unsupported_namespace
to actually create one of these suggested additional per namespace
character devices. But I do realize that things such as udev rules might
be harder to do, since not all devices would be there automatically.

However, I do agree about using the existing per namespace block devices:
e.g.:
nvme write-zeroes -s 0 -c 0  /dev/nvme0n1
is cleaner than
nvme write-zeroes -s 0 -c 0 --namespace-id=3D1 /dev/nvme0

And I also agree that if we manage to support IOCTLs on rejected
namespaces, then it would be nice if we could do something like:
nvme write-zeroes -s 0 -c 0 --namespace-id=3D4 /dev/nvme0
if NSID was a namespace that was rejected/unsupported by the kernel.


Kind regards,
Niklas=
