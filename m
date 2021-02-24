Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F153B323589
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 03:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhBXCAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 21:00:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:1794 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231787AbhBXCAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 21:00:05 -0500
IronPort-SDR: fkvV5ec1yD90IgBFCB93F0Md6FsVGAh7BKPjrngtiZYtCkUUsrRORoCC+paCdx80Lp9NJdAblx
 u1Y7hr/aS94Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="249075192"
X-IronPort-AV: E=Sophos;i="5.81,201,1610438400"; 
   d="scan'208";a="249075192"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 17:59:23 -0800
IronPort-SDR: /oybaOZqBvfeYvwdOleo+6QkCQZsdNL9BjqZ1iS/kdmZJDvJw8jAkwPGxOQLHHAGX2eqQ5ZS5I
 oT4QRelErOBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,201,1610438400"; 
   d="scan'208";a="391346915"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 23 Feb 2021 17:59:23 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Feb 2021 17:59:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Feb 2021 17:59:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Feb 2021 17:59:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flPnhfl9MVYC2zQqbP3uCF/Gqsy5BsrkbJmKHwSqjWctb8smIR8qZxZ7ljFYVz/Z+JsAaH/4zpGwOzcvHG9Ec/aJXJ2IBEHOCbHwxJ1Lko2lILXVLh6RqqtdjK0XTGq48+kpX+AKjyExrVx4yOHfeasdPqkrm1hqnwLbj9dvx+TgS3qjp1My3XAOLEESnuAJQNhApwjVgZbzrPhVuprlgVWB143dJTukiDV2ZPxoHvFyylyZoyuOKJo8pGIjif0XTcM1G29UENHUCI2ev+IbZIB5lPF3+jb2GWgOdFfsMswzYV2mR4DNPzUM7qOMeX7lQUHIGT9tU2Yh71CEhxUjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgsisC8v+6DQBgHUS+L1JR0Vv1Z6/ONYLP//TrcJUZM=;
 b=VCUifL1BC5sJqT3ExGCrkdQIGhjt6vSElX7ApG/P/5dTWvyCn3YbsGFHeMJu2fNyE24sZlKTrUuLSvCN8V3+TA57jSPmS01CeEVJw7tXFWA62xMNpflQ5EJrdJd3281eBqpUWnx0w8hlUPeJO5SFhc9Rdbm9rMep+Duaoj/uufcjwHAZydW193J+y5tOqDEQGSNCoUbP4aB+HXw5hewRf2uS+Z887Nx7gHM4jtiVp8Qbr6n8YNYlu22apnt+eOtN+FC92UL8g1t998moXALHMTZkgtB2eeFQVnIHQm7IBNKrlHGhrMi/+9iUrrnA9SomIvuoniic2sJhQzMgt5SVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgsisC8v+6DQBgHUS+L1JR0Vv1Z6/ONYLP//TrcJUZM=;
 b=OIEjsk/7tJy1a9snGdnWgcojS51FREUdrnZPrZYxauSNjasaxQND+Qc3O51IRMyy6uChn+kh36a9VekTKSXBADQxnmvgCmcWcNrK0DPPvBs2zkX3RqJrIEvc13ZatAWZE55tc/gXJKTTy9XWSm5yMAnsDW3DuS3EbFJpv+cmD14=
Received: from BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26)
 by BY5PR11MB3896.namprd11.prod.outlook.com (2603:10b6:a03:187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 01:59:21 +0000
Received: from BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::d058:b0e4:5ebb:a3fd]) by BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::d058:b0e4:5ebb:a3fd%7]) with mapi id 15.20.3846.041; Wed, 24 Feb 2021
 01:59:21 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ley Foon Tan" <lftan.linux@gmail.com>,
        Andreas Oetken <andreas.oetken@siemens.com>
Subject: [GIT PULL] arch/nios2 update for 5.12-rc1
Thread-Topic: [GIT PULL] arch/nios2 update for 5.12-rc1
Thread-Index: AdcKUD09Mbxnz/EmSJqZmkAtnsMmDA==
Date:   Wed, 24 Feb 2021 01:59:21 +0000
Message-ID: <BY5PR11MB3893BFDB87B74CC384B9224DCC9F9@BY5PR11MB3893.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [42.189.137.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 138e8fda-65e1-464f-430f-08d8d867cd77
x-ms-traffictypediagnostic: BY5PR11MB3896:
x-microsoft-antispam-prvs: <BY5PR11MB3896DAAEC928DD0248F3A01BCC9F9@BY5PR11MB3896.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +sOjvLx5ECXEHZPQJVpeufOmnlcxTIs6pn9TfzeiZUn0Rr9y+UkljtS4FcC2R+H+M9QYdq6vfB6wwFHjBIAV5BiA2u26Ld5jBH1naPKsPkuQVwl2PqA3j6bD7Ng9KyvZy22h/QbXoIHCTxKmXw4QjNOhPUZ8IdQREUKm7f4thSA6GcoZuLA7WC0i8uvE7A0WjZ1GwLTeIUiBwx3yRifv64kT5dCjWWbf3GBD6RrYZb1ejWGoOEHA89o+Qa1ILRK+/t3b3vRyiN2+kR+1DCwopPA9TVygpOixFy9Sk1z6u4ZA/sXg+70YfG0dPBCxjezLP5TzhA0N0S7MURvYp7ri1UE8t0OrbVsOjSkky9UsMwRQ5795gU19tc5mMNiErh9492X4Yu2QVOgR8oLqfscG2fbRuQ5UmpP1CdU1N/Hw7T7DTKiLwFOpcak0FwBvo5CBQVQFsk+UnBbsT1Hr4Mg1jze6C/DsBS4kKhIdy8gC4yZsOXzDdSfU1RxmAVdV7vsGj89G8biUPe+P57zJkfRqZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(376002)(396003)(346002)(8936002)(55016002)(5660300002)(9686003)(6506007)(76116006)(66946007)(26005)(64756008)(83380400001)(186003)(478600001)(54906003)(86362001)(66556008)(4326008)(33656002)(6916009)(66476007)(8676002)(52536014)(15650500001)(71200400001)(2906002)(7696005)(66446008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vi89Mv6Zxcj8/vba5C6YH1GULQY97b5RCW2LMbFRTJ+JdNQDNj+EgqrD2PCm?=
 =?us-ascii?Q?qn/wjj6aUCG3/wmulwsmRB86xJSTWogs+2o+zErL7wlVHTpICvH/azdjTx2C?=
 =?us-ascii?Q?6sogPu1XBFO4taDuQJu3vkLWCbb0EdfuyzNQn+hWzj6PkWqPDVnnJRhLCnjq?=
 =?us-ascii?Q?/d20E8YVd3vffOHJIHLMXfHG/AVJe3lJoGAzV2/OBjldczhy7qqwbVOBtiEK?=
 =?us-ascii?Q?mu8ASKTD8V4MEdv6gpSFqaY38iHJfCFXw5gpLn5KLtocr29a7TTNjJeK6CSo?=
 =?us-ascii?Q?L6hp05hEMiKQSTFGreXdClwJ55rIquLKSDJhkufXdppQTy2Mgaf8GPpyDpLT?=
 =?us-ascii?Q?U7FBdjoNN6l7BXCjIO3bRyGdj7XpygclfF08UWMIjtHkXkkvz+dBUEaLKWKr?=
 =?us-ascii?Q?xn6q6uO+buaVFuQXpcUgFjvubjSwgylumobAj4CkuaUYa+ELSPvxDJKgtZBj?=
 =?us-ascii?Q?ZmmbJ8HBn2+hEhl3MN3aVw1u8gL5DP9CB+/y9K1sXICByG6tqG0W5vtg1Z28?=
 =?us-ascii?Q?leNLlJsOIIZ3LW7HYamT019OrUWBcj+2A0/ZY5njG3AtoMP4vr2DpsIxmqLO?=
 =?us-ascii?Q?ye3flbzJbIzm2/dqkei6czD2kJPVjyV3+cD9SdGVJr1v3utfhK/NFmFRbO+L?=
 =?us-ascii?Q?QoxV24HNe6u78872UypuWxHz1gjJP3dZh8hD4L9byvK34hxlb11anu9Dgfi1?=
 =?us-ascii?Q?nUHV0zs+Enr1W24diEvcvu/tlKVaqd0po4vBmv2kA6ppM9dJoJgw/6DKN3hn?=
 =?us-ascii?Q?/0p28ilCYmabQiqHQ5eayXd2B5qfAsBCCB2dZuG9CxWbLxa4XVh8dsFBehrq?=
 =?us-ascii?Q?soUSglMtiwHBPg7OSJrjYSzORDxqPfl4XkeJqBNG7pArHrfvfrEaLWbEpZ0e?=
 =?us-ascii?Q?iLhV5Z541N2R8oEgXbZgkH0P7qUES803yKCrjOQpRukyzTsB9IvfJ5lStWlU?=
 =?us-ascii?Q?rWBcVlVCN9TtOzx7QEj89nHKwZXBU7hC04UHYLnO6uT7EAVR/FXwARWdCOwn?=
 =?us-ascii?Q?uZ9p6eKH6xhViKD+Aczb60IyPMMsq9Q+Z8yU51pqCa3B6MRqJaSdlEnTHpFo?=
 =?us-ascii?Q?I3pHBQLP3NpogRUxrN2XystSsrgJfBs4dRSPk2dkVC9N1OYgUJbtH2M0Aroi?=
 =?us-ascii?Q?3BRAcdJIfRcsDFdyl5UMRMxCw9lniJ2z0ISQpC6beo5CINSa2Y1hn8cdzdsA?=
 =?us-ascii?Q?X1l6nYjmB6L7ozjSI+ZgjjLNsiHjbmhTuzrCyOQ3/nvZxwwdvztB3ECjMKEb?=
 =?us-ascii?Q?MtuuaBdJvOzJhnO/JmLg3wGw1lipTYlCpjOivFxUXoIeHV/wBPKG7acOHu9p?=
 =?us-ascii?Q?5mJpyNF1mu3Q9dPhbrQhkO1V?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3893.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138e8fda-65e1-464f-430f-08d8d867cd77
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 01:59:21.1592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOWMM/No5NuCsCVdZYspoc8qIJ9xvDoh4kosm0CvLbNvtTbJlBZW0UpoHacuFhqlrOiqdDXXUtoQWKsvkMKgNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3896
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Please pull the arch/nios2 updates for v5.12-rc1.

Regards
Ley Foon


The following changes since commit f40ddce88593482919761f74910f42f4b84c004b=
:

  Linux 5.11 (2021-02-14 14:32:24 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-=
5.12-rc1

for you to fetch changes up to 7f7bc20bc41a4fbcd2db75b375ac95e5faf958ae:

  nios2: Don't use _end for calculating min_low_pfn (2021-02-19 15:02:09 +0=
800)

----------------------------------------------------------------
nios2 update for nios2-5.12-rc1

nios2: Don't use _end for calculating min_low_pfn
nios2: fixed broken sys_clone syscall
Take mmap lock in cacheflush syscall

----------------------------------------------------------------
Andreas Oetken (2):
      nios2: fixed broken sys_clone syscall
      nios2: Don't use _end for calculating min_low_pfn

Jann Horn (1):
      Take mmap lock in cacheflush syscall

 arch/nios2/kernel/entry.S     |  3 +++
 arch/nios2/kernel/setup.c     | 21 ++++++++++++---------
 arch/nios2/kernel/sys_nios2.c | 11 +++++++++--
 3 files changed, 24 insertions(+), 11 deletions(-)
