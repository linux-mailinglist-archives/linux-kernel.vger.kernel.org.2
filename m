Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3B941F7C7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356078AbhJAWwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:52:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:21327 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhJAWwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:52:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205091611"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="205091611"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 15:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="619457986"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga001.fm.intel.com with ESMTP; 01 Oct 2021 15:50:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 1 Oct 2021 15:50:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 1 Oct 2021 15:50:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 1 Oct 2021 15:50:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frDjWsDM+dCW7VGTw0QjvQydy8wERmfHcYxCiZ489TC6edFdIJMca0bciJasiGQhFhRhVVaIKMH+thXNEL1CU0WSDs/0auEXwV08ADppF0FaLyv1WdD/LQAidqjMBxO5U9Xo8f70CuR018tIkWIeXYCOOCP1jhh+junRdk0Rs/gPR8yk1Ott9rlHVoXCAg9L7r/0Tyg8M+h3pAQQ32rX/numCJCmxoRyuNxtY2RzN09qnMgdQlRDVKp3Q3jAOW+c3j/r3NuO4dFJX2PshOUCJvFtlEc2a8lvVqj1GTRSMBgAwPq05B7WgwdIiRNcdnoyD+bGoGmnUINziZND9T4VDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YizzuhGXPPNKmr8wS0aZp7Z2ZcOKDsF77s6GsRqFs6U=;
 b=dO3TE/Z73L9KdpN3at3h3JeaPQmoTjBgcsAqJnUWEvYVfVKJhZWDbcapQEQz4iY6W2Nr5VxCKEitI+g5tMRn1tb/+3NaWsjZYLGK90l2NlHxw1XBD2k+2InlYgHlfZSJ4QAJ28wijCB+URo34v+e0EjPsXFXz0TwxEInZS1b/RMVVrgZyk12lcNmzmSBaNUUbspTdHn8vorgGERvP0AonFLhPrlw6GIPYJq2m/KJkZ2k2OKezRGHm7xh1OtNTHa82dNfxIC/tnp31kk/mQlq0JptrvtfgrYYzm+5eIpFNmnh0WZ1RJbEpT0JO3HqOG1eI8j3xeYYE0iv+vyUQDFd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YizzuhGXPPNKmr8wS0aZp7Z2ZcOKDsF77s6GsRqFs6U=;
 b=QAHXijtK6+XPlJWDKfgV2Mc9g9kvvmGWYAlN4Tqxl2p2lP2+nVp4DDavbJ2gnMPnqQoCU31puARNhNPa+LYcHTN1SNv2qdjjI0nb6RrcPbGmAe2xmOU/+4QXdluOPTSYBjFQAS4WzlC9IILaWBEgav2MfCheTty6NlL7mFfFVrY=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 1 Oct
 2021 22:50:32 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 22:50:32 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 00/29] x86: Support Intel Advanced Matrix Extensions
Thread-Topic: [PATCH v11 00/29] x86: Support Intel Advanced Matrix Extensions
Thread-Index: AQHXtxXjpXjC3Qk5Sky+qg9KSaDYk6u+v02A
Date:   Fri, 1 Oct 2021 22:50:32 +0000
Message-ID: <89BFDA7D-C27F-4527-B494-1397876CA6F2@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
In-Reply-To: <20211001223728.9309-1-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3068baf-2613-4038-118d-08d9852ddfb2
x-ms-traffictypediagnostic: PH0PR11MB5079:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5079757701D0E239D113706DD8AB9@PH0PR11MB5079.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Y1TiWuNVF/LU6adjdXEcgc2xaYC6vfzNQ5T8rtBHzrNBRH/vBeo97TyfzOjMOIX9SGsrQFcNbtgP5xkk+XCfE/IdO8EJ8lx6VXd5D4NjFVnfHv4CNErjqvevOgBlPIqfQT/K6Zsvipc0c+HXvAql3osEC53eIjMT+flQBnNTG9I4VTQSbi017/8Xmc7p5CvFkLSkoKfvwULj285J6G+aHnTJEZokLdLSUGZvCpm76oKWnAmW/tWI5VfKtW1zFIzdBUUZZ1c+8tAhDaL8eqzA1SDwJYac77L2LHXAz+LWJ9cOTmMWngzMMC/g+ZFvgAVmi8zjIYlo7GWiYiS6P7oPTXIUyF1ax0fx/Muo/P9M6BNmpcfVUuH1/E7BjbJnaF4BPSCU+V86eN6EVXJk8VOQFKlb/QsMr0DAdSbO2UJQ3eaMaEKihnk7RjMdT5V4yD0fjHKwDXb+WYcM63g82+iMAi28UA7tXWkWIDs3U5j6jfIvkoQ3VqMOVpirbNCq9auG4Z/Z12D1zOb7G0GHUedUfwCKcirIyOjMLGrMvDZpXmhlKbzHTzN+mhS3ZAGtpc/RLKnmpiv/hRnUPdKxJ79F8ekuGJ1oE90EOZk0sGXJcp4kdRCrIeQxrlWN5EL8Dxm9I3Hv4IV7ly61gBKBBeZHB6gy5g02+vqSSEKcVYd9jDsE/k92yCrxSeP0z9p7YlZsT9HtjQhsDkdRjFXDAKJlm9+evG2/yqBy5HlXYx1qTacquJo/dmVm7hl7hi1VjOg4fnmsljBG1pouKFm7gOsheD24/qqRdZkkaGZ4TBOJyxaYGQRz4+IlYqD2x55O2E+8irBgG2q6BzBjmu91RjJJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(76116006)(122000001)(54906003)(86362001)(316002)(6916009)(38100700002)(508600001)(33656002)(8936002)(966005)(4326008)(6486002)(26005)(71200400001)(64756008)(8676002)(38070700005)(186003)(66446008)(6512007)(2616005)(36756003)(5660300002)(6506007)(66946007)(2906002)(66556008)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G/NagheF0seBVUczgjycErCOLublUZ0oYKol5xF8C4iwib7Xk3/Q1j52Fb8J?=
 =?us-ascii?Q?YeShWamySNmbdC3XuJ3eJ5En+X6X6u1BFA7SNM9RXR32Dc3Ns8CiTzcIVD5k?=
 =?us-ascii?Q?ilxdVX31q4IT+PIYAvHzziVBbbGOge9jVDVkUu8bfNUO8P0MD1HwzOaAoxUE?=
 =?us-ascii?Q?ArV1Q0TmpbTvigju6vFtvkE1jSMJ86apjUaD8G2j2Prwv5zdoeZOQar4oL01?=
 =?us-ascii?Q?JuAa+ioIvMWL3QlK2HZ8fKPqhtWndwSuF/TRwsI7/l7vQQE92R2xjOm8wqBP?=
 =?us-ascii?Q?I2bK5M8LDuCDPBEnu+ynjRlidYWnZTcPQV5qx+wrd2pV95N2v/lN6/LYKFxp?=
 =?us-ascii?Q?onWvbVQu6nF9dJaZSihPmdkNWiuSg8DHI0hDpDHowSc/J+8nbq0PWojcMJeY?=
 =?us-ascii?Q?+BkMkj565TMrXSIEmQGr6BrAYpYnp1CCyfgLrjq6R8yg+UdzlUKN7kNRpKnc?=
 =?us-ascii?Q?blE42BRDJh+14QGWQhHu7gHu9xsHUdt9UjFZcXFKEt9MnuoWvVDLAy7B4ulQ?=
 =?us-ascii?Q?vRuEZWTebP0VPpV9S4VRo35tsr1NKOPGbK6TWhv1lt7PBKPognToU9EgDGoC?=
 =?us-ascii?Q?xZn6znKuhBJb0jevmBSyNsOIuLvO1q/eG1z6JclHVJr2TLpmxuJu2rO6khEs?=
 =?us-ascii?Q?rPVAT+rkhD9r7VZDRDSsarHLw3nxQH3iIwfQ7Ez/MjL8ZPVONJgt5Vejg4z7?=
 =?us-ascii?Q?zL/z5ceiaYFwrWy/sWfdSXbfCmcEtMw1IaFdsfnrKOY/5a7FaSCe98oyd7pc?=
 =?us-ascii?Q?zPLNAKJOCaovLtt5VDY4pWmlux00BGaI2M8bY4oMVRM06mY3Q5qSSq27QKj5?=
 =?us-ascii?Q?+ymYjZm0M7Qh1GcpuESfkJYpqhqq5fdZ3lJxnVXK5MfrFpwc2QTqE4Wm4HEV?=
 =?us-ascii?Q?UQBs4s9jslHX6+Ms3C47JoSLkBwAgF+sHUXgIUHzkZhAippdZVotiFr8dPU6?=
 =?us-ascii?Q?TAUb0jGdHc9EpVQaYKX0Xtl9bWx8MFF/XWbnU690fkT2BQzWy4aRaA+tfxaW?=
 =?us-ascii?Q?zweGhxj9NgSdf0oXBPTC1rHCrl488Y+fcgvIVfKAHqLO5wNyUOGchLPigP1b?=
 =?us-ascii?Q?yF3LS5G2t0Dsft7jHg2h0ELXQjqs/BJpdTSJd4VU+RBgyGL/xbwmwDnP33ra?=
 =?us-ascii?Q?mlmmkuLNwnv3SLoPXMEZrNNXLFTunbrQ0vlDe5yItLJLBJJegjnrFvr0MtpR?=
 =?us-ascii?Q?Vv/qM9phUu+NuFZbEp7D3Pyi711pZh7gKBZY2ow427iKuyYT7Ha+WRhC7vdU?=
 =?us-ascii?Q?0gPxttbcfZO23AYKl1MZr0K230fLU5PJ9FqrgaS7kHbxrAWFDDr4UsKnGFuX?=
 =?us-ascii?Q?COJA4ED72tIbOhW35K1NzxUO?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37D343E848E8254D9709E70FAE23703D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3068baf-2613-4038-118d-08d9852ddfb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 22:50:32.0934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOlWWZVgD8rYvQ23t5XKbpdzj5dFFyl/QCWbumE4q9e8FXHurphPxoj1VogYme5IaGCb5QEP9VvdfyXzncyGge8VYd7hfsDhylLlAER7P7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Sending this version as it follows up the discussion [1] with some code
changes from v10. This is not intended to ignore your comment on v10 at all=
.
Appreciate your points on my oversights that I will address in v12 soon.

[1] https://lore.kernel.org/lkml/CAJvTdKkK=3D_pp1PrWdh1_GN73VifuAkivnErgK+b=
o2h34Vd_55w@mail.gmail.com/#t

Thanks,
Chang=
