Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A49134C1E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 04:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhC2CQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 22:16:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:7109 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230220AbhC2CQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 22:16:00 -0400
IronPort-SDR: DvKzNilzaTIB+ccqlWNlAmF4QEK2zQTwH6s0bZs89QpFucHdQBKWWK2uR6w2bRRBdikk1ZpjlO
 sxBPXh4B6i3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="188194681"
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="188194681"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 19:16:00 -0700
IronPort-SDR: 7MoRzCu/OBLKiY9E3liAaKFRA5CXd2K1BolWKIZpIbzmn9RXdwa64BVQa+aker7H0n3bvnaBKw
 qBAArXrbm9zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="437668846"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 28 Mar 2021 19:16:00 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 28 Mar 2021 19:16:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sun, 28 Mar 2021 19:16:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sun, 28 Mar 2021 19:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h16typQE9jizm2Hud1qEzFQEPRxT72MJh+XoiHqQUnuTzh9QQFpG45y0+RttQmYyEpdON18tcZnKgwQtZpJB23FO+31+FCTRyIyVBynrc6He4/3jBDvDe85QEtYF1XEXP5jOHVVduS/1SCxbVQda5Ay3r9yvrAhxsnoOKXbTYn0EOlwEraZBBM3Y0kj3/KYyrT4JADURZOLE7e4TLc5cc/bD/zEhCxnL1nsAt7is2Zjyq0cefGL+1ZJJbegg4Ihh2dTK60L9JMT268SBnL+aF2L888Oxm+Q3AEn9pkrCNlWnjTtDhTybFoCJWpFMpSaiCMrVFcY+P7phyg/hFjTs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaVIhY+cNaQaMF6v95ig0kaDB3Ead/YYGbUYn6KGcj4=;
 b=GdREJuwqPcruVPNDakZMEqro3AQtpupaeI1zZJ0JPxWmqSIfznW0obr1IjeUKnb6pOmXUDiMviTaBjpha2rCSJYkuca/MIA4Vxd1GwxM3nzSaeWh8o2WJRQDlrXWDNBYhMyKETiYL1l5uNCC6Q6uCtOy5hz09BmW08449RBqM0h6m6ilzznI5subN+zvYaCysCeQk5y2j9r2WhKrKZW0yKt3oEeAYnFd5BBLtVEqPO65bjaEnAyv4OVr5ZeMlD+rARfCxzqf5AmZtLVGelzYgWUIjwFUy8C7mtYSSRw9yc6g+zXTegaCImENGg1AJrUh3XvMkJ0wkKuhrNTW2vJZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaVIhY+cNaQaMF6v95ig0kaDB3Ead/YYGbUYn6KGcj4=;
 b=MPfoWCxpOp3uBxkD6ycDZgpxrWj38c1Yjt1xbudxZc62QW6OI85XOFuEHFyY1qEgW20dQVxjt//Vx0OjOAn4dz7o8pqHac7c55EmO/HhzTy0TJW0FqjX3wDe+wWkSjAKsuQCWMGT1Lyab96RDAds48gKViSWIqqZCG410pClbH4=
Received: from BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26)
 by BYAPR11MB3624.namprd11.prod.outlook.com (2603:10b6:a03:b1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 29 Mar
 2021 02:15:59 +0000
Received: from BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::297b:a818:3bfb:f897]) by BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::297b:a818:3bfb:f897%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 02:15:59 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Julian Braha <julianbraha@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fazilyildiran@gmail.com" <fazilyildiran@gmail.com>
Subject: RE: [PATCH] arch: nios2: fix unmet dependency for SERIAL_CORE_CONSOLE
Thread-Topic: [PATCH] arch: nios2: fix unmet dependency for
 SERIAL_CORE_CONSOLE
Thread-Index: AQHXInG0NWtxj4SMIk+Mc5oWqeIr76qaPd5A
Date:   Mon, 29 Mar 2021 02:15:59 +0000
Message-ID: <BY5PR11MB3893D162A53941A3270A047FCC7E9@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <20210326185554.30993-1-julianbraha@gmail.com>
In-Reply-To: <20210326185554.30993-1-julianbraha@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.153.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd28e963-b394-498d-1480-08d8f25897d8
x-ms-traffictypediagnostic: BYAPR11MB3624:
x-microsoft-antispam-prvs: <BYAPR11MB3624A849CF6342346735DB2DCC7E9@BYAPR11MB3624.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6dzKH98RiI88GtJdLeDGxV8QvosrBLFy5NWsTIlU0TRF06eCPEW3zKNyR/4k4safJqgo7GuVXa3/hXC/Clco8DulDLD5clo2au0XbiH/S3bczhLWK//m0P51v0wAT9yjPw+Ha5IJNWl8kFdRdURmyZ1AY2dY4LstmHZqC6ifWBT9tOjk9QrZV/CBRpSBjldeYqsR1mYNs7gQ0Qw6jnXzq/j4ecr4N8DnZJKmo+mSFmKTrid+YQ1UI3g6R/PgAKD/zBch55OQSiuwB2uy36JYV0yel79IVRzflVMg3DX4ORC3izE1xiKnc39lHIipdqu1JgrhTsxItdN7Ao+aXJ4lExfVg4KFomAiuzrYJf5+NnuPr18yOQEQEoQvgr0vpAzdrqhveQhCXAzcSWnWU5ZtuPhAI5IAL/VzyMSCRQfv6wjpgX0Ri+PngjJgEnd2GPVY2u7mkWVN6lLqeHeXxN4m979+p4YqEUNDAc8omC4kHBkmvt+QBP4VaoEVO3yy9agFGxqs2kQnqhIwi/NSX9+X5iYGSg//qRDt/lymHjzqnFdo+N4x/4sNFJxD6+sd7924Ymki227+S/aqNPdqVN59Lz3kw03faoM94vbq48e0CwdQGVEMGjG2sRMk91/CDfl04lr70FRXDqyatUpJE5OIDJuy0AGTSHW0QmoYZyCTq4E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(376002)(136003)(396003)(33656002)(7696005)(8676002)(9686003)(6506007)(6916009)(5660300002)(64756008)(76116006)(66556008)(54906003)(38100700001)(66946007)(53546011)(26005)(186003)(83380400001)(478600001)(66476007)(55016002)(8936002)(316002)(71200400001)(4326008)(2906002)(52536014)(66446008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?phcAW5Y+qwD/rYCiUExeVMpDTMUYzsVzGHwWnYdqrEmHEyuPs3t4EAtU9CVr?=
 =?us-ascii?Q?ehcD8DeBMt8NFtfwv375IYwEdirPZoeiIUrV+j/F9bVkhdigF5+6/sEq+xGb?=
 =?us-ascii?Q?l54NJy1D6jTeuKFpR6KL6O4PdlNTxKGDqMbC4y1trzKntjhUdCYatzvz3uH4?=
 =?us-ascii?Q?zJm5XuaxAcyxbLhZ6zl05dMravAx/X6M9+Ru5LYD7adls1OIE90y1O5TOUXk?=
 =?us-ascii?Q?ry2dQIJKI2IWYw1I1fv2ZfgI1ipJAgYCr67HkE9YJfWWJqAO+xn9DIdOsBDx?=
 =?us-ascii?Q?1aubSsSFDj7bfua2Sbpzq8IqvCtUEtIkPxDmztyqXOWlx0nQyeDp8BDIv3yi?=
 =?us-ascii?Q?rtA1IXYQ3WlL0F6HWX3rfM6O1SUwsV6k/mHB8RLgxk8/Q83hWQcB0I/Q3n57?=
 =?us-ascii?Q?+SwFhYm+xKVdsDnH5Iv3Zh61SXq715LoKTCGMkIUxmBne2Dn/Cc6PDW5k7rb?=
 =?us-ascii?Q?V91rVOqMv6F9U8UmXDUBY6R5Mmw85rN/BJQovVF0OMnB17i/BlEjhqOluXXo?=
 =?us-ascii?Q?MKAMhR+buwhHbwp5fm00Ewqgjnerxxicpv4GnxJlUii5GkD6Mhoa9am81sQ1?=
 =?us-ascii?Q?O7wuT5ki3Fm/qbUg778kA58ifAd8wVQoZcm7kw6LDW7WEjEp8ebjxCnUS0o3?=
 =?us-ascii?Q?IXzEdmx64sQWw0LUP2oRemF0hZFegqBSrFI7drlQJFsP5Wmb3WAcfr4Hopi9?=
 =?us-ascii?Q?FpHeJ/F8q5cO3k7i1OSDiXJQoI8xMzveX9h1KerKauaZIQC/d7B28hDgr8bV?=
 =?us-ascii?Q?Q8Ntk5thoSY9Fah8VOZ9MJW3kH6ewE+0xtBDuqq5g9UwHBtRP1gFWbo5mGcQ?=
 =?us-ascii?Q?x/V5gS+prtvTJa+s7VOB7g5qUDtjSGHcTOa3+rB/0onyAE+hUowCDwwrv4SV?=
 =?us-ascii?Q?wgUAZz4sVDORApN52O7rK+jTj0QK8cAcuHPR+FOpm1Bo4fk83htIvNWRjzR6?=
 =?us-ascii?Q?qdK1hd4wSLtMgM67VV0J0KEhsI7XRDVTozNvta/OtONEIO1KeM7iCcrLSjbt?=
 =?us-ascii?Q?uMyEkGIOhYwfGRZiMQuxWUbU2UPKPUeLJGNVkEG5aTvQ4FYKm11mKDtYDbwV?=
 =?us-ascii?Q?tJzuIXvayagy8nzN/p82Ml7ZAHX3SNs4uczVApf9lKLS5ULxbk9C/HZD6D0n?=
 =?us-ascii?Q?ZcVvMNg/C3rSlGhbPlbwdRKS+bCAxNWSg/ONdswP15Zlo3ncvjvRF/KZemXt?=
 =?us-ascii?Q?maLxuChjIAoSFhyAwhJRoImqeSUC87u0oBey5D1RewVsDVsUayjGoVgf25/L?=
 =?us-ascii?Q?T/OqDfxDUOfxhFCQxoGLgBUVUuOSBPSiJ2O8Xl8AZ1f9HMYvZxO/fQFu43dA?=
 =?us-ascii?Q?+CSy/vgZoG1+cNR/bcMLRSxC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3893.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd28e963-b394-498d-1480-08d8f25897d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 02:15:59.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4SY9uF09vtUsjtgkN8zJeH2L/MlLvaJguzD1DDzyyX4q7O/hlwqKIoXdmyd9zevU1kmjcF9hlt5wNVaBX/SLXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3624
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Julian Braha <julian.braha@gmail.com> On Behalf Of Julian Braha
> Sent: Saturday, March 27, 2021 2:56 AM
> To: Tan, Ley Foon <ley.foon.tan@intel.com>
> Cc: linux-kernel@vger.kernel.org; fazilyildiran@gmail.com
> Subject: [PATCH] arch: nios2: fix unmet dependency for
> SERIAL_CORE_CONSOLE
>=20
> When EARLY_PRINTK is enabled and TTY is disabled, Kbuild gives the
> following warning:
>=20
> WARNING: unmet direct dependencies detected for
> SERIAL_CORE_CONSOLE
>   Depends on [n]: TTY [=3Dn] && HAS_IOMEM [=3Dy]
>   Selected by [y]:
>   - EARLY_PRINTK [=3Dy]
>=20
> This is because EARLY_PRINTK selects SERIAL_CORE_CONSOLE without
> selecting or depending on TTY, despite SERIAL_CORE_CONSOLE depending
> on TTY.
>=20
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  arch/nios2/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug index
> a8bc06e96ef5..f453d5c1fd38 100644
> --- a/arch/nios2/Kconfig.debug
> +++ b/arch/nios2/Kconfig.debug
> @@ -3,6 +3,7 @@
>  config EARLY_PRINTK
>  	bool "Activate early kernel debugging"
>  	default y
> +	depends on TTY
>  	select SERIAL_CORE_CONSOLE
>  	help
>  	  Enable early printk on console
> --
> 2.25.1

Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

