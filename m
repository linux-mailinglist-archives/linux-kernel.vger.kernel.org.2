Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F95305DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhA0OC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:02:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:1894 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231185AbhA0OAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:00:51 -0500
IronPort-SDR: i2oUlm6zzEGby/Yt3sPoVvn5B//dBOeCe+Y5x45F+hmFcr5tguaIiP/LuIOYm3ZbxexFRC1Qjd
 NL1vbpDYv7SQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="179287889"
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="179287889"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 05:59:52 -0800
IronPort-SDR: kcvSi8thilgm1IYfXJ9967tt40H0Gmwc0qjTNHGYPa8+QKQmnA1nDxLQt/gorE2TYYN4whOcO3
 2l8Gb+hpxdlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="410542087"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jan 2021 05:59:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 27 Jan 2021 05:59:52 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 27 Jan 2021 05:59:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 27 Jan 2021 05:59:52 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 27 Jan 2021 05:59:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYGN7GncEIoU7s86jcFKTqFu1TC4a6K8+uSyOWxGhRCJkwONRuroBu1/KqJtsBdSgz8TjR1RB1F8n8dVqenHjReNmFD6yt1EAKhv8VNMRSp727YErUfkMOlqSOv7ZuVdTyZSy9AM7twtFZ35C7ZcP2MwGVFQ5JR4QPIEW37V2TvnEZh2y4hRelKfw5ZAnX/McC3w8V2SLSSHqVLRkwVQecozfLCtOE1JyD7mVhxCsrfd4446gxESHE2ND0NHs2ppBHhM/fHpWVqIbBTVwmmrSlKqkLaz7B2O+V50tlRGBce6W4bTOSXH+8M20MXoF3sfslznBFdZdV5R3rSa9AKqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/a4PyDRz32zTL23oKX3K1EVU90+bETrpd3I6xlOr5E=;
 b=LJx2yl3P2NVjQ5x8REIc6x3+YNmDRYkcya1Kmu+kr6ljlgaI0DECO6Igu4xAHH+dy3vpwLkdJ+uA6YU98kAhh4+iNi0gsKy0dnb2foOl/GT2FH79glcdKc6gPLN287eAHwFXn79rrW5BndSZpcpDp5QXBZfFXUyt1rW0i1oCwetL8Z/H2j52cAxnYWtq+klQT6b33KT2Mg3hb745MqW4TrMzxyUm21pG6IiZjKoTfVo47HijYT4606FRcQoYB3PGcuoJTQpuNtZyQLa5FqC0T9cfpiTnJ5/0auca0cqFBYxqFucywXDFh33jkzWM82pBf2zI9oQDyjbdrdwWqtXsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/a4PyDRz32zTL23oKX3K1EVU90+bETrpd3I6xlOr5E=;
 b=E2pkMG/RpmIYYzK1/b43ymPYSGhbx25duUhqsM9YhC2oZ+vi4UAe21HgpaFF6hCXpEdwMjifLu0CacfKMGLDgWPPwIG8BgyYxdeTaMBPR9Q1A8YD80sXVFLEc68gSKF/OpPHOtf/O+AAf03ilGOpN8jqrMoIAPh2DFMyniaxcyw=
Received: from BYAPR11MB3095.namprd11.prod.outlook.com (2603:10b6:a03:91::26)
 by BYAPR11MB3799.namprd11.prod.outlook.com (2603:10b6:a03:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 13:59:50 +0000
Received: from BYAPR11MB3095.namprd11.prod.outlook.com
 ([fe80::2839:b0d:ae50:7342]) by BYAPR11MB3095.namprd11.prod.outlook.com
 ([fe80::2839:b0d:ae50:7342%5]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 13:59:50 +0000
From:   "Chen, Mike Ximing" <mike.ximing.chen@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: RE: [PATCH v9 04/20] dlb: add device ioctl layer and first three
 ioctls
Thread-Topic: [PATCH v9 04/20] dlb: add device ioctl layer and first three
 ioctls
Thread-Index: AQHW8PD5TAmGwDLZxE+DNb4sUF8XFao7bh0AgAAWa2A=
Date:   Wed, 27 Jan 2021 13:59:50 +0000
Message-ID: <BYAPR11MB30958F6A70E6B7C005F7B8FCD9BB9@BYAPR11MB3095.namprd11.prod.outlook.com>
References: <20210122190138.7414-1-mike.ximing.chen@intel.com>
 <20210122190138.7414-5-mike.ximing.chen@intel.com>
 <YBFckMGGRKZBYXRd@kroah.com>
In-Reply-To: <YBFckMGGRKZBYXRd@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [69.141.163.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a0bb332-e064-4e64-0f2e-08d8c2cbd0aa
x-ms-traffictypediagnostic: BYAPR11MB3799:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3799F7B4B70608CB174CA9D4D9BB9@BYAPR11MB3799.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7alJ6cQziJA3LrHz9fW7JD7YMMal+T/IVzgPXqK+llDXemk5Yh8yvb2d2YcBcyUYR2IgU0OKK7MVw2FOqoWVtvKvSkMJDWP4wbRNrMl2FPjz89ENDzL7aqMRcchq29Ar/muq0LxfsR5s8iuTSynssiB8oBDMw5ApWs6W5noeOHWn36a37EXCf2X8AEQnQXKqbRMmQ+Kdz/0ff8qM5Gi+zjZwdGVOsyBkBbfLTM3hrlHtG+YDifTeU+F4+Hfj7+/SYEO5nv0IMuzl88NCWa6UEghfsQnWS2kWWRtYkEQDY1B+/UMs3e3Sg2rkC80Pa0nUWIPwz4YukqDKQ+A39FyxIgd+vhaZWPnlaHSwl1ZSUFXHHjLfja7dEmLi9o0xqheGtoNo9FfdrXTc7SRFRQkA/ZNwkfN7bgE8Fiuwbdc5HgYixIBjJhlAdUfEs4OyuSwP/51iJKS9TmtBiLJ0mtC67lvlZmZnQlpYF/B0QMIVwUpxXcvhyRMEsO1l1+I7rJ10eh3b24tfjLziNtqSccSXfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(2906002)(86362001)(83380400001)(54906003)(478600001)(5660300002)(4744005)(71200400001)(33656002)(7696005)(53546011)(8676002)(66446008)(4326008)(66946007)(6916009)(55016002)(76116006)(8936002)(186003)(9686003)(64756008)(26005)(66556008)(316002)(52536014)(66476007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?h342QRdd3dBmWYyhz65UNTiv0MNSDuK3OFQlhjIOXpfkY8YItin6Lvegocga?=
 =?us-ascii?Q?pFLheqMdrld0xJgEqmuNWaTMW516RjbNk3bG3Q48QNM1oSfezh4HRMuzyT3u?=
 =?us-ascii?Q?QZCYVOiiJkMwHRo09mrzu+sxwUY9tdJxzHBByFidIIVi06uf30MAR6PbsOwq?=
 =?us-ascii?Q?ck8BVNtq8VUaHT1EIjUmBmRN7qqliVxUJSxDcCiSZYWbBwmXhsOf5jzT4Tkx?=
 =?us-ascii?Q?Z3yR18TxR4nbKUc7CEW+OxMSYXW76DHgFk+9c/hqgfHdA/ElHZGesx0bT4+9?=
 =?us-ascii?Q?ox58HJJ2I8UFRMqhpNWO71mYkgBaRTls+sT0PSAzAdcf2M7FaRHRhERyBWg0?=
 =?us-ascii?Q?MZ39RYuO9Dg/VW+w45nJXwPLJfKMxzy+g10DFz+39m2rTIC2NZQ+tVcS26Er?=
 =?us-ascii?Q?nXoXAlykJpHr5jfAioLWkf0mKswet4DDVaiEbiGqbvsEVDiQrtAURiYqFAVx?=
 =?us-ascii?Q?yiYNpaM0Ycg5YAaRV1TtB+yqC+617YyhawQpNaV6RmxZgBLZuvyNPwuWXSiX?=
 =?us-ascii?Q?5cEldXWdFMkbLFhbkpXH22FZzBC1ly/sNYQLDheSFWy1bzGx4g3KeQdOvLXL?=
 =?us-ascii?Q?DOHQjoMSO1wLONYom7q5Z0Dl0CKLvf5uo6M7vnUkAbKHYHwiJrTPLsfwbDpg?=
 =?us-ascii?Q?cz/HqC7QlNsNgDGoH4Rxs1+u0BGFDTQBlrV1doo14dAhagqSJs7uTXK/IvMf?=
 =?us-ascii?Q?n8vpBbEZmRso38f0lrKv2b6I9nOUW11N392XMsI4JeppUWAEDEcDiBeDiloG?=
 =?us-ascii?Q?7XWwYXPYT46mh0PfK5i8cGm0QwVaTla3+UhxGqjsKPwrDJlhJtBs8li1CCE7?=
 =?us-ascii?Q?1tdfrDFiA9agsBJJ7NKFBEwsFDAqm6AZDnj8/GP7WkMj4Zqmep7izsMq0kMC?=
 =?us-ascii?Q?WeYIYRWaEWpUqrGAe017S6NPeUi74xYJO1NUXOFl1KWIVSk9S/0jFVw/s2c+?=
 =?us-ascii?Q?l1b24ZfItX1y336JOf9BmauXZVl9TGIOI29/yCxVHBCs8/WDp4QFDr0oR4jT?=
 =?us-ascii?Q?jumMFJ8t/ESD9mtTM6Fvq226KiTfLMsAVvsQ4knEsB4CN5AS6+a1chWDDGTn?=
 =?us-ascii?Q?2VWavjHn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0bb332-e064-4e64-0f2e-08d8c2cbd0aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 13:59:50.6171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7fR2W3St5DC0IEPFPARNsTxr7W87DfIolHzrDnt1F99xpK931XLw2sCpsSVzzncKCS0riZI8Pe8vaKAqQzZkG4idp5t0eMl/6wHTDHQk8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3799
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, January 27, 2021 7:29 AM
> To: Chen, Mike Ximing <mike.ximing.chen@intel.com>
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Williams, Dan J
> <dan.j.williams@intel.com>; pierre-louis.bossart@linux.intel.com; Gage Ea=
ds
> <gage.eads@intel.com>
> Subject: Re: [PATCH v9 04/20] dlb: add device ioctl layer and first three=
 ioctls
>=20
> On Fri, Jan 22, 2021 at 01:01:22PM -0600, Mike Ximing Chen wrote:
> > --- /dev/null
> > +++ b/include/uapi/linux/dlb.h
> > @@ -0,0 +1,167 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
>=20
> As the bot points out, this is an "odd" license for a uapi .h file, are
> you SURE about this?
>=20
> If so, I need an Intel lawyer's signed-off-by on it as well, so we know
> to talk to in the future about it.
>=20
> thanks,
>=20
> greg k-h

Sorry, it should be "GPL-2.0-only WITH Linux-syscall-note".
Should I correct it and submit a new patch set (v10) now, or wait for more =
feedback on the current patch set?

Thanks
Mike
