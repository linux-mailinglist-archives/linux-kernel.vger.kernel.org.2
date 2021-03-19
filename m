Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718FC34253F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhCSSsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:48:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:10234 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230273AbhCSSsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:48:18 -0400
IronPort-SDR: 4OAbceVRPwGD1YYJ6HMP63t2GJrrYBbbyziu25LJri/OfP2B1NupLDPnQS8cB9lszfKwipbBP+
 SyQIMI7Jxaew==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="253949892"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="253949892"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:48:16 -0700
IronPort-SDR: QtpQVEZfxH/4cIUlXfitGmAr+IbFQiOmIKSHrIrhIO+5e7eS1ioQpZI58kunDALdrqZPKFzFGJ
 7ydrQZAnPYkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="413618584"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2021 11:48:16 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 11:48:16 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 11:48:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 19 Mar 2021 11:48:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 19 Mar 2021 11:48:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOrbdF0T5ML4/ERYDLL1ilFerwuDxO7xvTcjfpaZnOlPwvVvpButlRB7NhyCjEj4edzA4fNwCsnxv9/f9ePoj1Xy3aKfNmYd6ubE4q9gT0bs5gZimlM4hEkh0PHCEtbbgAy3BhlioWd/QRFXIAJ2/jqDNAv/sZ8pTL36yF7DQUE8jL+zszbbR5IsHMTuc9/mNXE6apT92mE3VquC/22toNJmO4DBYelhQPymRdDBz7htGvMypZMF/B26SJhcfdq6MZp2DQ2HDS98mg1K3PmvN9on8iRxSj8XWVJaNn/8aGseesag1bMaLwAATOY1Cwxx/rzMgBlWwhJIkvIeVubJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXwUXaDXcJwhU0SFqZZCiGkWOJ3kvGmuFzw1wDnSRP4=;
 b=TalJOT2Wej1NFhcOFSRpeFzpSvPZLoTDK4KPN0UcMlwPMJt6ywavlGBcg5hVwyl6TdVuGRuU1PhocejfKnc7StRXhNqKyLiw3Z5BkN+AyGA5vUGCCYWBbsIhsWinrJzu0zZVZp/RxRopcTvHnXh6kofTVsE3Tvt+lCZMc9k+J3H7DzUMg0o6KqlsX58zC5azDccpwjEdHST4Y3kWv3hSOCB6Zc5ZVL7rEAYMan301ZEW6QTI4oFJ1C4834FnVqkQbsdz5LyowbwwAMz2rTTqAXLl4RQik29OnL5P7ulTGFmmw8CZpL9funf/WCNZessYudlJhNfl/FSJy+wTrQ34QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXwUXaDXcJwhU0SFqZZCiGkWOJ3kvGmuFzw1wDnSRP4=;
 b=ZpU9I04nvO1KAUROt8zeVtH7VOxgHBTwIM0Qfpj/a1j29ZCsCXOJ7p5DdOTvOM3iee/6b8kBlgUkSbaVVIAhK74G6mhPPqfMTikkrWJ/UbOk5lgwR+fvESaoIT4Xx6Lqx3uVduK5wQdmTJPkUroAZebvsojl+QlJNKAmUDfOvRc=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 18:48:14 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::ad99:f489:b817:d3f8]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::ad99:f489:b817:d3f8%5]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 18:48:14 +0000
From:   "Pontes, Otavio" <otavio.pontes@intel.com>
To:     "x86@kernel.org" <x86@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86/microcode: Check for offline CPUs before checking
 for microcode update
Thread-Topic: [PATCH 1/1] x86/microcode: Check for offline CPUs before
 checking for microcode update
Thread-Index: AQHXHOC2+9ex29HREEKdxaZKAOhdu6qLptO4
Date:   Fri, 19 Mar 2021 18:48:14 +0000
Message-ID: <MW3PR11MB45559DAC0B495A4262C9121BF8689@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <20210319165515.9240-1-otavio.pontes@intel.com>,<20210319165515.9240-2-otavio.pontes@intel.com>
In-Reply-To: <20210319165515.9240-2-otavio.pontes@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2601:1c0:5402:89c0::7d9b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 534874b4-4693-4793-7b3c-08d8eb078d73
x-ms-traffictypediagnostic: CO1PR11MB4961:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4961B30B3B94E2AD7E843D12F8689@CO1PR11MB4961.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4HrDhE+HpsfQ6w1plIHXfMGEX2w77lZAw42SZ3UppGCwt4WahWhr/+TRevV1io5U+Zi46q0t7W0XymAUwzphhoLxb2VDZvdnVUoAePpAt/Cvj9WpDyjYDqOG481HoyQedVhrrCntktEa4n4pgzW6uheCQpqDjf982PlFuFOgQlt7SXDadYQJb40VNKPlsfIkl8VY/6MEhbQs5vO/2w6I4WDYBFdIus760EvIz9PiznkhvIgqoItvYI4QXJDERVuf/VmaUEnVcVBiuCXBQc7jjuKOKORYPfPq2aVaWgFJIAopDLOUfD2fxXqNX3PW0yu5dguVMnH0p+om5dhEg43YsUgO9X9jlSFYHLo0FEwoWyEgOLDEeAE5A7Lhv4GDlVVgMV8eFshWFQuHyo+9oNjdQnf2fPFcchvKNfilFntdr/aR2ENF7xSbPruV/fAtoVpDmXk+EdNIyJ3SMkIBX8b5bkR/SKXIpOcNQdM7mdGCvqML7oeEYCdz/8G8wxhGbmBPPvrccrY+Ydb0vxsUhWHr9NuBYnMvHB0JFpTvz3UBtXSio7ULwQqmNLfeOlzAbvl0b/7nysMQTF8gvY1K80JJA/V7Mnq/1P6jgFV3I/9xOuNl7if0MPxYeDk+zVmOKphgRvKePPtDXBZQr6j/0FXBh0h6UNpxi3ccoWCn5HGTQX8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(366004)(376002)(346002)(76116006)(6506007)(54906003)(66946007)(66446008)(186003)(64756008)(66476007)(38100700001)(83380400001)(33656002)(9686003)(4326008)(6916009)(15650500001)(52536014)(71200400001)(478600001)(53546011)(2906002)(55016002)(8936002)(5660300002)(86362001)(7696005)(8676002)(316002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?lVAX+Qr+ODZmuGJ/eMNlydbgK/TO6NMQjbc9KB92ViaxgKoCRKiu4kcsN0?=
 =?iso-8859-1?Q?W2sEQUOtRAsjNdZXpNxt7/n5jqCc6TWPi2mzdBQS/RFAH6i3uOTupv1egg?=
 =?iso-8859-1?Q?5rr5gSfo16HJYlWbDwLHaGmNDGIdMt106KSgZReN3/in0eKnMBJWMYWdzf?=
 =?iso-8859-1?Q?X72v5ZyuSjjTGhls2qs+hJZqZ++UGpwsVk9BA2x7BOxaZq3lkNRvnr3GsJ?=
 =?iso-8859-1?Q?EOxpfw5noFiJVUOrITZlcieotTSE2xvcQQgZeodb3K6l1gvvvwyCpHql6V?=
 =?iso-8859-1?Q?3d+BaSfJ816nqRCFRfC4036OTWF3wzSylc/328wQCOP5e9/iVc1tzVwCY+?=
 =?iso-8859-1?Q?5C52bW0FoFT790ERA+e/MDPLmLG/BT4rN/Xz7s/8ldVwUNx1fZxVjEMQyr?=
 =?iso-8859-1?Q?LPVvjGbwKwFGSrpFbNddex84fissO6GNlBmhnyKOqTUUZTrfDKckYT7T2w?=
 =?iso-8859-1?Q?gyWEUh+4XjhAtpo1e7MJN6Tdta7xZGgkZwPJtWMpolD9OC0fOwmsKz5rmj?=
 =?iso-8859-1?Q?Lh7vuNHOnt+lCmQjK+KtOA0L9tsW7uMyGx8lVuOYxi2RMrlXrRgn+ZCy6b?=
 =?iso-8859-1?Q?Yba7aLp6hs8P+9W13Ca8BqMSDpbQaMuWzcPIFa8B8OD34jT8mVTrsL/a6c?=
 =?iso-8859-1?Q?1A7UrdBwfGT/vWMmNBgb+Ixbu2xnrvfCc5vAzDVgmYP3Ad+AaqBzRNtQYv?=
 =?iso-8859-1?Q?kVh4JYDzoocOnNIG0XJukO3EymfNGz1lPE8N3u/A70ieS/PvesmdHEmE2R?=
 =?iso-8859-1?Q?Oi2lYulwO+4lTG+X59XvZGJkGjJCG5iSFPrCenloxwoHPRbnX+dmlyYo7T?=
 =?iso-8859-1?Q?mFuDldqqVGpdjOtKjRn+hmnybjn/jngEBV4ZE/Z9UsTfd/1Rw0UULAf16Q?=
 =?iso-8859-1?Q?nseR8xKdEAYT/7nnhgTmnSpqxk7dWcpVWW7wa7BgFFvUMaoKvXQtMwX+M/?=
 =?iso-8859-1?Q?CUzcdRVqzUsaXA8XGCsaz4WgCmN2AgSFqM/Qlo2jg5RG6+pxFm9JXGRMBI?=
 =?iso-8859-1?Q?QaWAfL6XHeC83sK0EtrohWLe3XVA+OIE+WZeUlL5r8beItO+RMcVang2ab?=
 =?iso-8859-1?Q?rcGVHpjQ0GkS2zIJ5m1MVzGYlK7T/Gt1L53e7/dPTxCrugwD4uuKU59w91?=
 =?iso-8859-1?Q?zCE0WgwXgYjMO7bY/8OIfntm8BHo2o9pq9BrIT52HckoP3Uiv9ns9UAN/G?=
 =?iso-8859-1?Q?etTWthwJ77IaXWl+DOi9mPMDdXIFuSQWuOmLNdsXDkM+Hp2cm/rdphYsyC?=
 =?iso-8859-1?Q?LCBdzAI4N60lu00zV7rtGJjPnAZRiiu1f4DKektolzhIziFMLqjl+P8xbc?=
 =?iso-8859-1?Q?BZK1KY7n+Zb3/Thw0xooxHXErE0Vk8/GGH+VQcMdv8kAtQjCD9F+Xw3v+L?=
 =?iso-8859-1?Q?rvuJRowo+p4ZDt74Vxs9DJg1SHUhzXXg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534874b4-4693-4793-7b3c-08d8eb078d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 18:48:14.1895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDyeZy50GCnK8i503dZFkMmWarpq5DFnKYIs3jrUvDRIXj6hG8aN9QKg6pH7d7WhjqAxrQE50yU2tIHgeI9J9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot to copy LKML=0A=
=0A=
________________________________________=0A=
From: Pontes, Otavio <otavio.pontes@intel.com>=0A=
Sent: Friday, March 19, 2021 9:55 AM=0A=
To: x86@kernel.org=0A=
Cc: Borislav Petkov; Thomas Gleixner; Pontes, Otavio; Raj, Ashok; Luck, Ton=
y=0A=
Subject: [PATCH 1/1] x86/microcode: Check for offline CPUs before checking =
for microcode update=0A=
=0A=
Checking for any offline CPUs to abort microcode update must be done before=
=0A=
kernel caching a new microcode from the filesystem. Otherwise when offlined=
=0A=
CPUs are onlined later, those cores are going to be updated with the new=0A=
microcode while CPUs previously onine will continue to run with the older=
=0A=
microcode. If update is aborted before checking for the microcode file,=0A=
offline CPUs that are onlined later will get the same microcode as online=
=0A=
CPUs.=0A=
=0A=
Turn off one core (2 threads)=0A=
$ echo 0 > /sys/devices/system/cpu/cpu3/online=0A=
$ echo 0 > /sys/devices/system/cpu/cpu1/online=0A=
=0A=
Install the ucode fails because there's one core off=0A=
$ cp intel-ucode/06-8e-09 /lib/firmware/intel-ucode/=0A=
$ echo 1 > /sys/devices/system/cpu/microcode/reload=0A=
bash: echo: write error: Invalid argument=0A=
=0A=
Turn the core back on=0A=
$ echo 1 > /sys/devices/system/cpu/cpu3/online=0A=
$ echo 1 > /sys/devices/system/cpu/cpu1/online=0A=
$ cat /proc/cpuinfo |grep microcode=0A=
microcode : 0x30=0A=
microcode : 0xde=0A=
microcode : 0x30=0A=
microcode : 0xde=0A=
=0A=
Fixes: 30ec26da9967 ("x86/microcode: Do not upload microcode if CPUs are of=
fline")=0A=
Signed-off-by: Otavio Pontes <otavio.pontes@intel.com>=0A=
Acked-by: Ashok Raj <ashok.raj@intel.com>=0A=
Reviewed-by: Tony Luck <tony.luck@intel.com>=0A=
---=0A=
 arch/x86/kernel/cpu/microcode/core.c | 8 ++++----=0A=
 1 file changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/mic=
rocode/core.c=0A=
index b935e1b5f115..6a6318e9590c 100644=0A=
--- a/arch/x86/kernel/cpu/microcode/core.c=0A=
+++ b/arch/x86/kernel/cpu/microcode/core.c=0A=
@@ -629,16 +629,16 @@ static ssize_t reload_store(struct device *dev,=0A=
        if (val !=3D 1)=0A=
                return size;=0A=
=0A=
-       tmp_ret =3D microcode_ops->request_microcode_fw(bsp, &microcode_pde=
v->dev, true);=0A=
-       if (tmp_ret !=3D UCODE_NEW)=0A=
-               return size;=0A=
-=0A=
        get_online_cpus();=0A=
=0A=
        ret =3D check_online_cpus();=0A=
        if (ret)=0A=
                goto put;=0A=
=0A=
+       tmp_ret =3D microcode_ops->request_microcode_fw(bsp, &microcode_pde=
v->dev, true);=0A=
+       if (tmp_ret !=3D UCODE_NEW)=0A=
+               goto put;=0A=
+=0A=
        mutex_lock(&microcode_mutex);=0A=
        ret =3D microcode_reload_late();=0A=
        mutex_unlock(&microcode_mutex);=0A=
--=0A=
2.30.2=0A=
=0A=
