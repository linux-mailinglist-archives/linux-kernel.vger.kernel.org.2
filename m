Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886F93EA34A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhHLLHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:07:54 -0400
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:2113
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236478AbhHLLHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:07:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RznfdkZVPKuNZwXLf4B8ZVl+i6jZ2DNeffQ84CLXHIdF8AYQylcXlH1ITJKF4LUrJYzGT1vdIAjxjBL/1T1tpoE0fc2kQPaTPbxy8f23wGeKxHJ/v4XpgToxD+8yllOujyD7myK8n1r7HY3K4+8K2NolOcfE1u6oqAt/etQp0V9bBu8GMtRV66wCOp7bZsm0jO5DR4AzLHSUeGFGJhsGw+Dca1PTdqjpZhM5qrlQsIHmi1Nh7AOpRzIMfKZqLAdycrGyxMh4vc8iiAnTYRmpWWIMhLsQUWZgoER0mG9w37kvAKPJbJ+l9cOKAJWvIPFEaglwSBVqCEt9nfJu2nVzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1x6rKgWjoyileUQ0YQeLBsvrQRYEIyEtw/lW3xoxzI=;
 b=USEu/1VMmMx36p1vUToU7exk1+lLCSrNF7ZtRkK4XVFTlgTBe5bWAbjQnQUho/f+Vwy5tfY57whKk3OkSNYdyzDbTNQrS5kM2q0kFxlOFhEV1Z3hMWuxvPIC65KdM8f9UMX2goy6jCV55vYzRudSr4M/4DjGdJxvcaqhv0LOj6wU/WUycB1oOkjIwVzD29Dd4+Eo5H2v1xZjhfYRndX3XISZK/ERxj3elaKIfnroSevQRC0Lb3kZ4DdvOaJgTOlcq6wlFEceTxaPO8KxAqE7k+h0auzF/0rkZgkRcFL7YCum5HYhXF3PcpZqPI4OVhHuOVUpomaNXffvKL0YOPvqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1x6rKgWjoyileUQ0YQeLBsvrQRYEIyEtw/lW3xoxzI=;
 b=NgmtoAqNIlBBDYrgFmw6BH5lfBn8S5kWrjLOl1IfLpZ+TpddkMwwC0rJIkezbEKPf+TWZ+ZQ5LYSGkDbKDum+hhWxMF+sVoDZeOSRVi4X7jWvMNisLoq2qI7ZPdKgwz+gcC4gb4lHn//Lllb4f2UlQPJf++P2USaPPNVzu5u4bM=
Received: from BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 11:07:26 +0000
Received: from BN9PR12MB5384.namprd12.prod.outlook.com
 ([fe80::8027:d882:45e9:7a19]) by BN9PR12MB5384.namprd12.prod.outlook.com
 ([fe80::8027:d882:45e9:7a19%7]) with mapi id 15.20.4394.022; Thu, 12 Aug 2021
 11:07:25 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sched/debug: print column titles of
 show_state_filter()[V2]
Thread-Topic: [PATCH] sched/debug: print column titles of
 show_state_filter()[V2]
Thread-Index: AQHXeGApwcMMUKvQ2UeYt2AcIPdlB6tueyqAgAFoJAA=
Date:   Thu, 12 Aug 2021 11:07:25 +0000
Message-ID: <BN9PR12MB5384798085CF59B9D6F92113F2F99@BN9PR12MB5384.namprd12.prod.outlook.com>
References: <20210714032705.79726-1-shirish.s@amd.com>
 <20210811093659.4177e890@oasis.local.home>
In-Reply-To: <20210811093659.4177e890@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-12T11:07:23Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6c68f7c4-c275-4845-a05e-1ccdbf514684;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82de7167-5120-4380-0819-08d95d815e0d
x-ms-traffictypediagnostic: BN9PR12MB5177:
x-microsoft-antispam-prvs: <BN9PR12MB5177693FD554E2FAD321C454F2F99@BN9PR12MB5177.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: coiGnQCJ6x+sSq7CqyuYh5wGXf/VrOrtE1/AHhM7sBoupnW1WdS7JcZyFssyD7BZ1tWNItpPe7IuxX29qc2LlumutF2SBVvdbAD4oqUgBELMD6JXD/LE2Q5oyq2kZ6ODJc31YayNdE7gAqPq3cF54PnEdtfcx7mxYAgDMpxqZSd2Ni2sf5bPpkk9ok8Wzqt+z/r1SkwcKj67WLRBKqkZIFqSdD9R4GXbxF9++jLK0F9liKhc54Ef6afil2CmWFZcIe0F7SMM5Fiwt7cAxOh64D2fpFs8lms+KfzFFElr4Dc4Ly7jVBvB0VNkCQpUMul1CWWVxYuNMVo493I0wH1+6s+2n8VVE69oni11ncUnBdNjSbTDKgst/I7CHUNycpRH7SafWGRsmZfJ0WQiidwDDIAg4aqmIOIZ3to+Jc8to41IhYHwduwmNt3304fprktphFdgS5lKIRzxSAEmPRTRRC2Xaz2dKnEJyQb4D+3YmZ2Qm2phjRbRF98iK4CoAWgH+8eABWvNayjw36pHwozQTXa2bM8WnEWw/9z8yaq0oyKBDjSuYcHerhWzyQ7lYIX/MgvAoLBQYrQUvHcpycrdM0wl+nXGUZOTofezy7fqCi8zFPuOWtrO3UOL+EDWxK8IFxO/2KDI5OYv1CG5W1OYqicIO+cDKnRS5Ow7IUOtuzTclTGtgR2hjoN8Krkd9Wfwh/4vBJLsdSRM7dhqwTDPng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5384.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(53546011)(478600001)(26005)(6506007)(52536014)(7696005)(55236004)(8936002)(9686003)(33656002)(8676002)(5660300002)(38070700005)(55016002)(66946007)(86362001)(66446008)(64756008)(66556008)(66476007)(54906003)(316002)(6916009)(186003)(38100700002)(71200400001)(76116006)(122000001)(4326008)(7416002)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YLan03loO1mks9z4zeOJeXQuGKxpboCqMEKF/Xbc1q/08qHrlk/EcFmwsf0G?=
 =?us-ascii?Q?olVShhk4vZoMtAVt/IWZhGB+5feaqhC7pgtpbOstb+EOo+m6XqVbdh9VAjou?=
 =?us-ascii?Q?LAXiex6DrP9WkY7/ddBm7vMPfjbIWxwhLYN//7L3fjH51ow/cBX9Vhc43kcw?=
 =?us-ascii?Q?BlWbvzT8yWa9uy4VY592pi+LU7oLP7+i3lAnpTeS2RplgpvoTTgRKWaIrvuB?=
 =?us-ascii?Q?WZinxe6rhjhkkaICXeaC/mH5t9ljlSD4vs1lOViLsq3vTvTFV0l5rE46Hl2q?=
 =?us-ascii?Q?51+GofR4aktk7xDedymh+mvThJX/haAmEw0mBVP0yeWnYtLyBVYN81JXQY1Y?=
 =?us-ascii?Q?QIbQRJCnOEwTsL49u61dS1u2DTIM1NCGRLtG/Di5nbngAlEcL5MMMm/riaar?=
 =?us-ascii?Q?m5wwPfsFIbV9cUELW1EvMMUysdCz34+jMQUsaZKEiZcfn/KYLV3Za6egEdVT?=
 =?us-ascii?Q?dWTn2tj5beWLL0f6Z1mrQBl4dxWq6Fa6wBNo+ZqODCV92RZLtlx/oZXECKJA?=
 =?us-ascii?Q?CHv2mQfPonXd7xZW3WYsLwCqaBOqiCrL4D/I93iDxjvotuw6DvioR+m1fQYv?=
 =?us-ascii?Q?HLLRx9X2dNNA6YD4jvlgQLJgzMPbgb0wvjYw3d/hw4Yu/Xvt79bNt0Glld0M?=
 =?us-ascii?Q?qTjfxoWyQoUfv9EN0AJcLmWo+ia+tFGOIDGIYRe9moYBQ1y+e2hUDeoDaEBY?=
 =?us-ascii?Q?C8/qEu7V6UwSzvlRLDZEpqI4ftIfFrA3KVUAtz+7DsDhcCA5HTbU/A7R++OE?=
 =?us-ascii?Q?xukDcGOSCEVFmZnb3pfWNGKd4ZTcvWTfIVH+Ari0DSc5pkyXUIDwlTqxiyXL?=
 =?us-ascii?Q?UkBjU3r+C8tOStI61oiuc0yswEm3JYvns9JBPN0wJAyL2kBdo6N1gss+ZepK?=
 =?us-ascii?Q?5I8wNQXxvke+F+p9wmrKCmiqQTEWCzUiXPPPdnGngMD1yU1pAWpqOhYlT7Ib?=
 =?us-ascii?Q?HChGTQFNf7+gUrhESSg9i2S505fdaldsa8rCJkW9New0TtcOgKi0HAePDoRi?=
 =?us-ascii?Q?5QVONYgnpHjuqS6pUIW5xdEnVj5MyjerngWz2AbUG2ZH0WsuPsqG/5XFIJ01?=
 =?us-ascii?Q?E2Tkm7p4Muoii1U1xFMHnlcP9CF/P76n5C51d5zCzaAxPS5aw67TgVL55xBm?=
 =?us-ascii?Q?FIyP1HsZnrV/BU4VUGOEIeS4TLKjeJuEr9i//vhUkTEfFUgkOyQcKeq3YdAN?=
 =?us-ascii?Q?tjFK6TqwwaqqA4Zw9ay6epoFTgVThhvTjp7BCXU/MfX6MdFul+lR0hWx2rWS?=
 =?us-ascii?Q?fK+IQIN6THht1ey1pWIxjDyuONlOtUWCbVGPSJtO6yDZLHc7rVuKf+zHUb6+?=
 =?us-ascii?Q?2aBfLQs4ePn5XUfkI79SpIbU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5384.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82de7167-5120-4380-0819-08d95d815e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 11:07:25.7283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOMUBXTYdoPTN5XLs1Kt+DTrq/noFjyKbLfGu5tkdaG3hVvIS6poDGzwtmc49Xd+VRcq3sRyS8yHJqRyD91zfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]

Done.

Thanks.


Regards,
Shirish S

-----Original Message-----
From: Steven Rostedt <rostedt@goodmis.org>=20
Sent: Wednesday, August 11, 2021 7:07 PM
To: S, Shirish <Shirish.S@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>; Peter Zijlstra <peterz@infradead.org>; =
Juri Lelli <juri.lelli@redhat.com>; Vincent Guittot <vincent.guittot@linaro=
.org>; Dietmar Eggemann <dietmar.eggemann@arm.com>; Ben Segall <bsegall@goo=
gle.com>; Mel Gorman <mgorman@suse.de>; Daniel Bristot de Oliveira <bristot=
@redhat.com>; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/debug: print column titles of show_state_filter(=
)[V2]

On Wed, 14 Jul 2021 08:57:05 +0530
Shirish S <shirish.s@amd.com> wrote:

> This addition in the debug output shall improve readablitly..
> Its not intuitive for users that the pid printed in last column is of=20
> parent process.

Hi Shirish,

perhaps add a before and after output to show people what you are trying to=
 improve, and that can help the maintainers see if it is a useful patch or =
not.

Note, I'm only a reviewer of scheduling code, I'm not one that can pull in =
the patch.

-- Steve


>=20
> v2: Dropped #ifdef logic
>=20
> Signed-off-by: Shirish S <shirish.s@amd.com>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c index=20
> 2d9ff40f4661..22cee4c0f4b1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8194,6 +8194,9 @@ void show_state_filter(unsigned int=20
> state_filter)  {
>  	struct task_struct *g, *p;
> =20
> +	pr_info("  task%*s", BITS_PER_LONG =3D=3D 32 ? 38 : 46,
> +		"PC stack   pid father\n");
> +
>  	rcu_read_lock();
>  	for_each_process_thread(g, p) {
>  		/*
