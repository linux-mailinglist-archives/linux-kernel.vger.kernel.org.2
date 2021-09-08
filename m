Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A416E403A24
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351764AbhIHMx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:53:57 -0400
Received: from mail-dm6nam10on2067.outbound.protection.outlook.com ([40.107.93.67]:63840
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235448AbhIHMxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:53:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBYfUuqE5bYq7ZRWHLw/Q2QST+wdEFyjnmjNQ+R9vKTyT+hc4LIM0jsfg38lq4vQmG0BJdfwUXZ6qRYRK4ySbc4xEV7LR7XObUI4N3gmPQZkdN4lCrOvPOCch9NTRQd/aI9mpsRnY7T6JFdm+vCu/Wg7ZqTKSKFmbio3fshRBOb2ragc/18XHQZ8hv+x9cXcPyymP1SPrsEkifShqg/tj80C7M8IWGVf54d9cig6WZ51eyckYW0rIxnxvNjV5iIBI0fo9rojWCl7cy9Mybws+vuFSvF+BmEgJXqK1c0NDQmnj0W4ASzpPnNl9YON57Jlrwrk7riVfXfbjae+Frr7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HQE2gZ1tmLo9HCtlgal88W8FF1In9pMbmeVH4nO0alM=;
 b=Iu7TBjZfUft0+J725KflfN2IjpOFxumwYhmUafrZnlfZwG+B0rdmzhkCJ4vaLJUb1qqYX71QjDWoF1wsIGoGs9LMgNgcX9aRTeaAdZTaifnqOO7DQWm0iP9Up//2E28kthELnRNIZjX21mhTrNeaE6uibjnt4LBTPOBAEPywQapBYYvHvJbgI7MFmmet18Tcfpeng6AAqI4vEyZMXM2QYBA7ekmW3fHqjcccwrq3FONq4Sh/fyk/0AwKjaWRUyDat77YU8nwswRoR+4RSLcIDlQPdUlZ2YNNHyO+29b/P3Nyr7c0VrCe8NqLC/AicAXIsBlL0MuC5nZy37tgma2omQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQE2gZ1tmLo9HCtlgal88W8FF1In9pMbmeVH4nO0alM=;
 b=KHsRdmsgb772lgyk5XCBE9EUnFta8+TBe7KeizfMz1uk6bkqKkJSAP+EnJ2z83IhmTWyR/jClzqCA7/ys2B2cjIFW38EGVqtHK6Ls89wGxPpE2ZFp24upldv9UquhhRm5T/7Vod1Q4czYuzRd1utEVespuILFtBr7nRqdXdEzA4=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.22; Wed, 8 Sep 2021 12:52:43 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 12:52:43 +0000
From:   "Yu, Lang" <Lang.Yu@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Topic: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Index: AQHXpKowoLymFk5Tf0idLKRe5rRrP6uaEbwAgAAAhDA=
Date:   Wed, 8 Sep 2021 12:52:43 +0000
Message-ID: <DM6PR12MB4250302F4EB80233D5807CB6FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <YTitRjOZtWPTyRHd@kroah.com>
In-Reply-To: <YTitRjOZtWPTyRHd@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-08T12:52:28Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=147e342e-8e22-487b-8fa1-d14e4989afc4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02e064a5-6669-4850-1288-08d972c78ca0
x-ms-traffictypediagnostic: DM6PR12MB2938:
x-microsoft-antispam-prvs: <DM6PR12MB2938BFE2B695241E437B4ADEFBD49@DM6PR12MB2938.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z3rnDhE6HAFHWFZRMM20A9Q04SwqPLeg3liE26KgNfmlfrd4mkhKnYwQOOB5VZQ2p/ENmJggp445gyNDXi4dLOyTqO0SrjLCuPk6k59Pi4uRBrPC/dr1iwD8rFRRzSgAc5i/B07qML5vf+cucvJirZkLntZO3denPGuJAiGiSS3caLfoYjNNcqtzCxR0sFe/kNM6aOdfLns71ZqQAAGdhuQY2LBbcBY3V31ReaHrjm3HHmRvi7CuyFyjyucfrmS3kQsKdgFsI4hWSGmeyiNavoNmf0cCztvImdGHXVJ9IoT1nesaABWsQXcvDHyauISnzOoqgnq7Ye3prc29+tiQt5TU9HMlHyBlSBCjF8z0lAu2MWGx1liIU6yolkaQO+CWYieG6ymGudM6YJ9c8BlQI2BpUxgpcwNvUY9awxM/N+w+CkkU9VRn+Y17rEeRMV2Ni0SG5QWhWyTlwyyYGd9MSBScoF4h9XWttSJG+efWsq93SPT2sREjAsvFKUGQZhtSD+FUzf/OxSO37eFRL5kGZrZXr/rDcOsZ6EZeU9dOxYOjgKJIuWA5D/gnLVu19HazhbjnBCfsc/KH3Tvr4ZGq21+YeiqVp3bPMQdUZLQ3qJ6C17w7Ih7jGZgEkv8IRlH1DwpsWHU/QElR771dX80oycs44jMksMp1Zy7AB2W0jCMLj9Yxcjw1hHOvobFjIOcn0LPME7Z+Oj5RigJMm2BaWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(66946007)(26005)(33656002)(86362001)(71200400001)(76116006)(186003)(38100700002)(122000001)(4326008)(8676002)(478600001)(66446008)(55016002)(66556008)(64756008)(2906002)(9686003)(6506007)(66476007)(83380400001)(7696005)(54906003)(316002)(38070700005)(6916009)(5660300002)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VXf+QQ50hAwMpXA4zwXh7RHMItSwKECCKEhGZiw7eAgWm+l8al6dMN8n0iQM?=
 =?us-ascii?Q?qfiERtsd4e3UQQmBOAqNvupeI/Iwo7RvicHChQh4rWh9iLuJO9LK3kN4b6EJ?=
 =?us-ascii?Q?NPXXtiSn7pZepWIbvwdvwKvf0G1vF0F1F+Jo2M3dOVUAF6aAmAq/9AlBDa8x?=
 =?us-ascii?Q?vxPD6zJW++X45K6h573r9u8FN2R9UCAGRlv/7Ad1I8aFvv9+HfJelPWWXC53?=
 =?us-ascii?Q?q1GW4TunM8GTrm/yRBhb8AC+kTkAlEnH6Vzr/C2MvZnul7wm7EZ6NEn9YjNt?=
 =?us-ascii?Q?/s8BBnIHjRQfEhmdFwjzaq5/EEXTJIPEADFX5OK5hAcc5bytr9BJ0S6B0eQE?=
 =?us-ascii?Q?PsElYbxONKV7iKX78cnaAL/t3nOXqJyF/GHHRGxRHJQVmeAK2JBgG7+zYlSD?=
 =?us-ascii?Q?7CgQG96kbHUadh+EQZTuOKkGde+3A9fqdPpMXoRRrDGxEa9PI2e0ajt7cKcS?=
 =?us-ascii?Q?EJx5lDCnQFvtFPlu6MLmmX/0kamlmOyhSfY2YVZmwb4MYbqIIHJA/Ea/8hrB?=
 =?us-ascii?Q?Zo/vN9jJlovUILpFb6BIL+wtpZQ1wTMe1KiJSViu/BqD6HlbL/ZuaSLwWJd+?=
 =?us-ascii?Q?HNuuoPeIa22FGo1c73KNtRcXICvabFVELffrlz+d4Fo2BUhcHJPbsSWBJpAS?=
 =?us-ascii?Q?bt2j6cPTqNsjB//KUEvfIlCRo9hFOIAL3W1uCIRb4muWbaCtIFxbYpOt4jXl?=
 =?us-ascii?Q?la/D20Eu84HcSX2je8v7ayP5Y3kGHKm78RuHzxAPKP4Eko5MMLTq9VbCapjV?=
 =?us-ascii?Q?F4qNsP3nIv9kG9FXVpIBoD0pqgTCe0PwAMp4OLDMt/2kfPQHNaof8sr8x/AE?=
 =?us-ascii?Q?GLvi7hDs2ci5S25UUjavJ5K86V6UKwnT9y7esQcHCQsDDTxzFQNgwKWAAJsQ?=
 =?us-ascii?Q?iEsJO65271vsqsUzCjv3zYMozpbIUicTqtUqwvClqngRWZMGhChoAX0jPPkl?=
 =?us-ascii?Q?HX2hx0AAsOHb9vRlFFLjeD0Ajwmk0R+bp+5GissR1y825nanVTajzDdLQuPR?=
 =?us-ascii?Q?C00yFC49YJv2BVwO/TM/uEVAIxQHYWNuFpsZPcTJCHNxCNNYC/4QmGGjrS+l?=
 =?us-ascii?Q?F/KAeX7u3Kw7nc45Wa5V9L0YmBtmKJoIraDSOafz62a1xZyX0YHpmD20+Pgu?=
 =?us-ascii?Q?uQnz082665ny+SjgEZe1AFGYHJt3aUvGUXqAKXD3cJR4eyi1H1ZR6H3Lavk+?=
 =?us-ascii?Q?ORzMTTsz+7UviS0dqVjue5r588zRFFhxTwSleyntviBnauKETymmffLXjlGI?=
 =?us-ascii?Q?04xCrNAmFXeFtf02Oh2hMWXrhH54x6/JGMJirtP5DpzLwB5Fh0jMjZAHgJC4?=
 =?us-ascii?Q?JCTxjsLkSmp2VuhkTfzdyuG4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e064a5-6669-4850-1288-08d972c78ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 12:52:43.1630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjlbfnC+xfIJUjR3G+ljhfzxB+kk65gUvS30rK9GlwP2vCG9Q7jQWi5RfXUHodXt1GMQGpwxXUg+ars7zHJzOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2938
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]

Thanks for your reply.
Just curious if we don't put such a limitation, what are the consequences?
If we remove the limitation, sys_emit/sys_emit_at api will be more flexible=
.
Since the comments of  sysfs_emit/ sys_emit_at api are =20
" sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer. ",
Why not make them more equivalent with scnprintf?

Regards,
Lang =20

>-----Original Message-----
>From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Sent: Wednesday, September 8, 2021 8:32 PM
>To: Yu, Lang <Lang.Yu@amd.com>
>Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki <rafael@kernel.org>;
>linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs=
_emit
>and sysfs_emit_at
>
>On Wed, Sep 08, 2021 at 08:07:23PM +0800, Lang Yu wrote:
>> The key purpose of sysfs_emit and sysfs_emit_at is to ensure that no
>> overrun is done. Make them more equivalent with scnprintf.
>
>That's not the only purpose.
>
>So why are you changing this?
>
>What in-kernel users are being tripped up by this, shouldn't we fix them i=
nstead?
>
>Remember, sysfs files are "one value per file", so why are the boundries n=
ot
>properly set here?
>
>thanks,
>
>greg k-h
