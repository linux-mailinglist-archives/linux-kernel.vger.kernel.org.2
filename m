Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FA63BA2B3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 17:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhGBPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 11:22:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:15880 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhGBPWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 11:22:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10033"; a="230419790"
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="230419790"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 08:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="477437688"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jul 2021 08:19:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 2 Jul 2021 08:19:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 2 Jul 2021 08:19:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 2 Jul 2021 08:19:45 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 2 Jul 2021 08:19:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JskafRkWYf5WNDzeyH+DnEyDHDSCAuAU99X47LS4p8EFunfXrtZqwt5ehUcXeb8GAjtECCcgzkJpgvnmC78NKkJ+3vYOOU37AOHwbFKpH+mFdbO4C1vAX/db6HIfeO2jULvV7MgCyZ3WjGU6N9nymQKrx+/r+/9tPM+fa8LewagPqJiUHNplO5YDcxDYjyvP6yrAkN/EeF6PArIjbpClxHmAoJ5UFzoZCn8osSLpgrpRfx4JT3SYnUB3GKLtQxV+ocd+IDGa7QGgKkGopfSrA69FHdfBBCd/VIhVKoT2ffc6t49+8HOZQqQ91hulGQfAi41yv7NItElr4yMo81dHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSTIPGCF+Mt9HtFsU9f4dNPdh7EqMj7m5Jkrk9ZVAP8=;
 b=KrHeXdd22sZpeJOab5Sl4hEmrgaBY63GadVl3RNxYy7hCxN9fYY106NToLwzP9SAJZGRI9yjzgz+/vItfJ2910uEUfCWVHDMjXUu6hqQsSbnKs4C2CNUnBUQ7EfePQYICD42468174yW6Z+fuEHC6cfzcCQd5YchGc+tswWQVSU/Q21Iv0HitLQbl27mY4Om0RI2pL97UbP9T794xAk72OmV12lfIh3hYAZxj0rok/KwWdVNPbkLDjHy5OU6KH5H3uKvLirSkx0JCAHHHyRqlKKSPgq7lIiBdBLit8TGmI86hDl9bnjzch0Z7QEUHgpCsFzoMkpeYfK40iyzTWwYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSTIPGCF+Mt9HtFsU9f4dNPdh7EqMj7m5Jkrk9ZVAP8=;
 b=khmfUEh42ODGi6LGE5PXTEkWK69foGrfvBHJWIFQEa2m94p6rTagL1FosVx2T9OFzliv7EgJSnRq6ELDIP7SkVDujFnTsuU2uEEs3KIqI6ITL2K/c02VI1+pizYhi+d/VOVmhbWKtAM0MwjocW3PC9HpLzWjWm2TRCsGi2XZzLM=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4967.namprd11.prod.outlook.com (2603:10b6:510:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 2 Jul
 2021 15:19:34 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194%6]) with mapi id 15.20.4264.026; Fri, 2 Jul 2021
 15:19:34 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 06/26] x86/fpu/xstate: Calculate and remember dynamic
 XSTATE buffer sizes
Thread-Topic: [PATCH v6 06/26] x86/fpu/xstate: Calculate and remember dynamic
 XSTATE buffer sizes
Thread-Index: AQHXbXZVKDDPCWyCTUWccN2Nu+7HBKsv0GWA
Date:   Fri, 2 Jul 2021 15:19:34 +0000
Message-ID: <7B6BF36A-E1C5-4D7C-96EC-2036AE27414B@intel.com>
References: <20210630060226.24652-1-chang.seok.bae@intel.com>
 <20210630060226.24652-7-chang.seok.bae@intel.com>
In-Reply-To: <20210630060226.24652-7-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 579ae9cc-9c58-4df5-31d3-08d93d6ccca9
x-ms-traffictypediagnostic: PH0PR11MB4967:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4967CFE6785B749B48998CFAD81F9@PH0PR11MB4967.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zTEpIMlQHej1rvAuBr2cO3+O6eawcadjD74X3YWko/qPnRXR1vK4wKvQH/Wm1PPyFBfooTmDCXnCqiw7cY69Z2iVZaxLz3O9GLcNmedD6w/qYB0IqQnd3JF/27GBkSM2psj6sy4f7iHRIDE/zr651N6tGsb/mdpyoA8BQ/2f3PxICES7plz8xAeMMc+EpKttb4Pw3NVOtxp7zFhwjWnXTbN0YJRXC8F9n7R90NlJ+oiQKRxp2BAATdNsvtjCsqOINfEJmnwth9pv3Dbvz9r6qf8ByHAqxXTeaH6xCntUVFePhQZorFlFvftWXfPRd/EDnKJuNPta0QZ/kkCN4OAAZhArQ7VMyklhfOEXaz94Xe9pbrDSM2iCzotvCyBpdIySJTSWTUUE2pC0Iq20VE3qm6ji+bB//LfI776P9gYLWcxoEdI2sR3xph+aegpgtBaO8xe36DGslM1UFiszC0o9rfF2dgM+AifwjX4AW9IBUdcqxyyNRcm6HHiwbFuHbT3Fi07wdIliySWSc+A8OId3Bs4vUSJm7uX4jMkazEMlqe+Of2CYyb70t2wWamMUWwiZ7+3DJmR2yMvZyNLjRp22QrXKWr1wvyuDUxC07/F123iKsuIoqmu9Jz4MDSNzbMPt2slxxIPxxuVOcvOQaBBTrmn85QUhDjJtM08q1Yllgg6ZDntylRqewYaAzPCEZqduIfGLUSXNMh8OmTxWubPB2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(366004)(376002)(346002)(2616005)(66556008)(478600001)(66446008)(8936002)(64756008)(36756003)(54906003)(122000001)(6486002)(4744005)(26005)(6512007)(110136005)(66476007)(53546011)(6506007)(2906002)(66946007)(76116006)(71200400001)(316002)(33656002)(4326008)(5660300002)(8676002)(86362001)(38100700002)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aQsH/HCHEmjbjSwRHxU5edeap5S3cMaOOSiix31Uc4NflRQUAn0vXb3oEXb9?=
 =?us-ascii?Q?k1iR4tN+qi7nLxziJTGb6FSCCgrU9hjm/HV2Hx7HZr/poM9bM/9EziJLC6Jq?=
 =?us-ascii?Q?OyHnmdCLnm0nIpnZ4UeRpI67R2i3sz/JpxsjjTQjiTXEw9OLfOLLhQ3mj+2/?=
 =?us-ascii?Q?ysHWwo7T1gBO5s2uKwW5t9P8lDTNjdFqtfqNPsWwJHivR8YyLJurZcyEft9S?=
 =?us-ascii?Q?t1PlcLO3nkYGsKdLnfrZ6hRluPNKW46sv1EiQznobc7Ga3RWOIMwDkPdkkUf?=
 =?us-ascii?Q?W2Go9ANBZhu+NEn79bkb6PZaxOgjxKtWJOAn1ko/JzNzikkyUdpZh8yIOQri?=
 =?us-ascii?Q?O03eCBbs7h4fsNESd8nW1//rmQyFB5KvtX1zef7XNA7JzI7u45CJImbxANuq?=
 =?us-ascii?Q?/O/E2cdaEnrqBQzXx46OcQmKZ8a4vJMDZUrRbyszvgQjr6vSTYd3i87LQF96?=
 =?us-ascii?Q?DBhHCLvpCWAadf1zuOUfI9Iqc+WCbiPT7ZmIGDZ65uxUxF5bn6FA9MYHhvGX?=
 =?us-ascii?Q?HpaHYhG3rXegKeKxx5q9f0NbOd37csQ0zkl5tUVZnTV2DedbmctZY93LUBlt?=
 =?us-ascii?Q?2c6DGsGNy8yxEHdaH98FRdZq4xG+fS6avzsUxoG49pjTFzKR6Mv1WeG9V12g?=
 =?us-ascii?Q?mSgUTVek5D/cbYOiiScF3n69ZYsJipyI/EXglxJmfzqYwxc42Jql1s0k+BWq?=
 =?us-ascii?Q?G56zz0cAYnNJR236RYxwasLQZ36fh0aBYXNxfwZFdJBhubHnV9xVik2V0Cgg?=
 =?us-ascii?Q?qDUcZDxzq+PketfGdfvkungxUaIY8Hvjwbf7sB4DnKNs/EQGQC+oag2yBkue?=
 =?us-ascii?Q?0ol7qqXqx175SNOyGSffsEaj0P5pMBm8+4FMTqwW0C5td6r5uhEh63WTF2X5?=
 =?us-ascii?Q?9fYBGDtZgP9uFyPDA8UV4QuqfMy+6UPZa5ev4JYTUXi/6QmIsLDvUgc1BMjb?=
 =?us-ascii?Q?es9Z0Gi+fabhHFBQ10ss+/N4u79y79QO0G6Zhl9SaTWpdtqYY2ZE9elvBJ6x?=
 =?us-ascii?Q?pFlg6YJrOfZv3HRFBEhrnXFUUVV1dcfPJEecKb5c24/M+dF7XwH+AMYoJoOM?=
 =?us-ascii?Q?rSHoZbySyybWbaQEOJZo/gX2uUO13YTA/6K7KFFqU2YpGorjleEjFjohDM90?=
 =?us-ascii?Q?c2VqX2FtMlgXQtYEHSy375yoGdz+v6x4YHGpF6wjaBOCaOw9ozGsnK0SMKPw?=
 =?us-ascii?Q?Eh6hV5fWtjgdeazsYJMhHcb1OhBJMHaYoyn22QEeCHLGcWfdJ7nFVsvRlgwc?=
 =?us-ascii?Q?ma7AX3mnlZSk+5nRi7sDxSVyNZHin4hckAhFhTgpgLWkFdjSWPoGp5ug8Yr3?=
 =?us-ascii?Q?fZ7vvyd1xPepgX4Anlw0AQo7?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E26E10174105C441A6A8114EDE5CE2EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579ae9cc-9c58-4df5-31d3-08d93d6ccca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 15:19:34.6997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCmdXNZvpswWqeHveB7TtdUtBqMVfoRkjCyqJalfAO6hhhFBOKEdjXwi/tmJ5PXcfollYinvvaUBiWfKJMg9n1IQ/vffrNIjW6UMrOTYISI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4967
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 29, 2021, at 23:02, Bae, Chang Seok <chang.seok.bae@intel.com> wrote=
:
> 		/*
> 		 * The compacted-format offset always depends on where
> 		 * the previous state ended.
> 		 */
> -		paranoid_xstate_size +=3D xfeature_size(i);
> +		xstate_size +=3D xfeature_size(i);
> +		if (!user_dynamic)
> +			xstate_size +=3D xfeature_size(i);

Sorry, an old patch was picked for the last line which should be:
	xstate_size_no_dynamic +=3D xfeture_size();

Thanks,
Chang
