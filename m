Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1F33C9973
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbhGOHQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:16:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:17370 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238314AbhGOHQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:16:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="190864527"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="190864527"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 00:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="630645050"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 15 Jul 2021 00:13:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 15 Jul 2021 00:13:12 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 15 Jul 2021 00:13:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 15 Jul 2021 00:13:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 15 Jul 2021 00:13:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl3kiIQCss/PW3GLpjnWcViuAwraL7ye9lP+gyGf3BDBYFViSA/ZnPDFgTeXIFr1aOmcGD88fUAbFueGCTy5R9mFwGM9nFwApFOPiFCWoFzil1denE3V0gpk36YPhKqEXDkpg2ldiONRjs7EjfhGS6MD/iMebcOa7veV2QlCYFntdV77nPtQ0Enx/5IIJVAK2DA8ka8Ct2uR48ysWnb/gBlntaLqyZq5FnDaLfE/A1o4urAep/N1gkmZEaS+AG8QXmst7unAOaFQ+ntVB6WyWYcqd/ovzoH0aiNdCHJTWm0+6wKVpRzmyK7WaZ5M0Mhxz6fWMoJzVJMiCavoZzISuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSYcAvWaowai6INkGSBGhfkiXYb+r5o8bnLHYWYfQQY=;
 b=eIFeCFA6Ge64z2qH91fz4OtKFluViG3DUXwSeKRtlmdXxdZ/JBgVOVZzgH4KZreh0uLncH5pZMcl4C3ze9dUDebBDg4M2hERTAsn6RAqGUlyuf8IqvNsjmKD+FteQ4js4fE2qJKEBSP++I+cV9XCQVmzrkpXHKDXr6Nvg03Q8d3fbSEsSgCWcjG4NSGFOBebcGZHQPWJYtYRCBvkKBVO9dv5oVKlMkCRgQoK+2EQ3Ie+iQHE6+gHdx3RpSSA1yDZ9xN2wwvgrZ0jdPSEkYuVRTqn9NjUrleVxqNZ6KQic90EA7Zph8XVqxEVX3CkMftcsegV5PB9x17JOIDHpu8ZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSYcAvWaowai6INkGSBGhfkiXYb+r5o8bnLHYWYfQQY=;
 b=VGe16SVb5ttm/0ClrrwmgzKiStgZplE7s5kSmzCwXSOii65oPb8KJG1i2Iq1bkXiFLZz+o/LU+xk4dpJcPgmgjSgi0mfASS883Xqv3eRr80PvLSpWCnSBF0lZsQVodxscGYwydZxZ50Ue1Kf1bQJBRyJi6TfLmWu4Dy4yPI6BZI=
Received: from BYAPR11MB3528.namprd11.prod.outlook.com (2603:10b6:a03:87::26)
 by BYAPR11MB3269.namprd11.prod.outlook.com (2603:10b6:a03:75::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 07:13:10 +0000
Received: from BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::b945:edd0:ebd5:12f2]) by BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::b945:edd0:ebd5:12f2%6]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 07:13:10 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH V5 1/1] misc: NOC Probe Counters
Thread-Topic: [PATCH V5 1/1] misc: NOC Probe Counters
Thread-Index: AQHXd7PdZivYur/1kEWpwYZUnXcrZ6tAeRaAgAMoePA=
Date:   Thu, 15 Jul 2021 07:13:10 +0000
Message-ID: <BYAPR11MB3528CFCCCD87C0C6F99F5413E1129@BYAPR11MB3528.namprd11.prod.outlook.com>
References: <20210713065347.21554-1-pandith.n@intel.com>
 <YO05L5t5iauazGYQ@kroah.com>
In-Reply-To: <YO05L5t5iauazGYQ@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba238bc7-f9d5-4538-1ec7-08d94760008b
x-ms-traffictypediagnostic: BYAPR11MB3269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB32695CA2DEE3A077A5560ACBE1129@BYAPR11MB3269.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: an/pMsjf/xJ1im6hRqDY8htx1RTu5E2uxIF0iLepkMmKofGBll8WtrqXdTRmc2HcFEBU2LOndsH78PxxTvJY6HQeyWFXNsksfFz53NyD/XnqlCJcI6oQ7ccJTx0kxYgz9V/t8gyK6uq4IPwHHmpxZf4gNU+5DBNJ1JnBVe1QADuYjMFOFNB5/N1cZZL8tHpA7Jatf/XKzLbsYJha98byky5s8VyYI/LDbVRnHzUxMPqb3uW6d14B9F2TstKvO5+FMpKY2Q5FCYdFLDgmXgMziGYbBIHOnRiK6pcinp+9XHjm1TlmZDI4s9cKSDuTNEeTq6MIsX43ioUjdTkl0ZOgLULflUeE/uMPCiptmHkM56xYOUTl/68U8fe3t+9/nTCrU+tOnkrP1YyxtZgSGfoGMsMaDXraC6SXoVwqlXUE2QdFBaasrfEtcetyKLJ3puwzhnQlwoLjO0MfBVVsh/cE11tV5i+E/Mvm04lJm+3S+MW+HsgHvL+/FMejQEVAW8kDm4oop2iUdo5RkRFcEW02+GCH9yFzrplqZli+BwEiiu54WYtyQh1dajhY+Ewr0fwBu6EmQdAu4en2Ai5QVzY+Q4P43Raqs4BRm5gAbpqJgD9vcjoR+gtyb3ETZuUlXwNwx4rfdRZKPnJD5kv69TxUa1OoYi32hWWN0p6CFEHE4y+2PxgQHKBsdADdAgvn7H3dGRIwY1sbplrskZENs+Kl9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3528.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(5660300002)(55236004)(33656002)(9686003)(6916009)(122000001)(38100700002)(53546011)(76116006)(66946007)(8676002)(4744005)(186003)(6506007)(52536014)(83380400001)(71200400001)(316002)(2906002)(64756008)(86362001)(8936002)(26005)(66446008)(478600001)(54906003)(7696005)(66476007)(4326008)(66556008)(55016002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cpKIIJ4besqdN7N6aoXZ6wWjefQOkOgLFeNEoA3vAE3djqbe/2EjvUIIaQ/k?=
 =?us-ascii?Q?FYRajfjHJN4YKWhlc/u44t6nAnqC1pMQ1SRvBdseI3qJMASStMsDG16FyoCr?=
 =?us-ascii?Q?wxT/GKksOfT0p2Uvmr5ys1dTv+d9ftAC8Jzz0OGsMer0zU44jMu5+Qv+h66x?=
 =?us-ascii?Q?r3ajQWmXl2BfKuSxQ4raWI1Sjga0M5vmd3OrF8cD4F4h0DtHwmxzNSQvG9eV?=
 =?us-ascii?Q?7DGz8Iw6E8HMz9KO+yQxkp86WRUYEHtM9K3iMojGbhw4EFIHHMf+KYLLYmZq?=
 =?us-ascii?Q?uz9fxhzVCs7UFogqJJymuC/ke5/DBCueilELNkFXqQR2Z1iAwNKrb3Ufxi2Y?=
 =?us-ascii?Q?99/sKmFSQhVUMyWbLL6eR++pluxm6ATPnNrtbcttUBKWrNJdYHqhyeIGLXe/?=
 =?us-ascii?Q?sjYHX49nMuDgTXO9QxCDiO1kzp7wRK0EGpO3N2z5RJ8o0XbgGmvW2Wzfl77t?=
 =?us-ascii?Q?tkXdL9VU5dOiB6VRqXh93w7QrnBu7jXf/X7Fx3dMaT2tSvkWKKEwdzcceBJN?=
 =?us-ascii?Q?/TmMcIChGTPbutOnhIQsouwPmLnDVc8wpR85n1a/BIOKmg/EaiCZ0xqEbYiZ?=
 =?us-ascii?Q?gR2DbxL/T1rz+OBZd8uO9wbW1IBSydFFWXm5KCOmmwtjzOrOPUa56zCqHzKS?=
 =?us-ascii?Q?AjfIapLsHwKfkfirv/3tZz3P4YsSgJl7r8eRIAIP76A1iq+kfb4JCJa9FHFi?=
 =?us-ascii?Q?ocxXZ+Oki+vxkIkvvaus+JRry//6hiFAORXoNlaahaAR/AY3cc9uGF3pq4+1?=
 =?us-ascii?Q?0DqgPnm9VQvaSikwlZxZW9ANlOlLa9emmABfXtpuux+kR3vdXmyWF1LjkUeB?=
 =?us-ascii?Q?713pqbWXYnTOdBDmr5uIw3b+H07R06BrfkqCXOqxBlEskBsCpfrM/Tv6OlLt?=
 =?us-ascii?Q?0AW5gCTnlkbWVlb62prOLFX6vdo6r0Q94Cj0LwMLMXZsryelhE4bB9HCeQu9?=
 =?us-ascii?Q?Ub7O8yi/UdaeDtcISDdMyUTctmNA/5WzSpupGiV9z2V0FE37/yyVvmMuqIwd?=
 =?us-ascii?Q?pYnWxz06dK3yTtu2vIiIhvta+A94xR5W+eBb4LBGo8sapt8u9BycWns/RmmW?=
 =?us-ascii?Q?njfgi7AQH531DDU2fizWquXEP0fMZNRlAVsIfP+fDYVN0UieG2XXrqL7Bper?=
 =?us-ascii?Q?za1VAawp6BywngdBfawTC5FA2f7SLwYBkuVNa6amDxPGzWJcMBnJUkGSl6F+?=
 =?us-ascii?Q?2j0fEgWtlbzFSADDDnidCLCOUvxdJcQMslLNKk0qnVD5vgxCqsanqx9POxtO?=
 =?us-ascii?Q?FL+ac0x6/QBnZ/H2NDuZlZHbJqwkmZ2HnPuKQC3CoX63MNSR2AAsVw7QudDs?=
 =?us-ascii?Q?DLA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3528.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba238bc7-f9d5-4538-1ec7-08d94760008b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 07:13:10.0376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2BXWs3DtEsVCn+WlR3Rm3AwxnbNJCz2WmYWqAZCwnmzverXCzD0/XmGYFm7tVHCvhsQbEDPS8LvZ/bgOaJXlHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3269
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, July 13, 2021 12:27 PM
> To: N, Pandith <pandith.n@intel.com>
> Cc: arnd@arndb.de; linux-kernel@vger.kernel.org; Zhou, Furong
> <furong.zhou@intel.com>; mgross@linux.intel.com; Sangannavar,
> Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>;
> andriy.shevchenko@linux.intel.com; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH V5 1/1] misc: NOC Probe Counters
>=20
> On Tue, Jul 13, 2021 at 12:23:47PM +0530, pandith.n@intel.com wrote:
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12589,6 +12589,12 @@ F:	include/linux/nitro_enclaves.h
> >  F:	include/uapi/linux/nitro_enclaves.h
> >  F:	samples/nitro_enclaves/
> >
> > +NOC, DSS NOC SUPPORT
>=20
> I have no idea what this means, please spell it out in the MAINTAINERS fi=
le for
> everyone to understand.
>=20
Have renamed as below:
INTEL KEEM BAY DDR SUBSYSTEM(DSS), NETWORK ON CHIP(NOC) DRIVER
> thanks,
>=20
> greg k-h
