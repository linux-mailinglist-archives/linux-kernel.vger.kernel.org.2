Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F2B315333
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhBIPvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:51:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:32244 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231995AbhBIPvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:51:20 -0500
IronPort-SDR: yFyD4Z4F6eAN40Ti9+Pbt0oZhK50sd/1FZGVlMEilEc9IyqAz9YgaR62Idna6Tw97DGbNcYUKd
 1+eJFLiiU2Fw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="161650073"
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="161650073"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 07:50:38 -0800
IronPort-SDR: rPuz7sITDK+GD8vFGlhFUuc6XYREPEL6q330peyuiKhg2vEREQXjC3241BXU4ji4S2o/Z+Xlbb
 WFkfkRrhQFFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="398820006"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 09 Feb 2021 07:50:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 07:50:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 9 Feb 2021 07:50:38 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 9 Feb 2021 07:50:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki+11DC0RNvHOS6prjQecdSmn7ZPq4Mcz6+wZCMJLCkt1mRTDiJPpuOnuHXRXnayBI25yjuswnv9NHdfcpZ1+Ux0GIMkmByQzLRcNyv6Vb0bmUc41mbpqq8P/qTgXPNUNfqHLWA7Uuu6vs0UPStXqu1qJ4sZKDq84hAKddajt9KsIhhfW60QhcbG443iZ0Bb5+zfmN9C5POk0mxBvbsPLXCoBJj5d/mJadKHj1PHkFbMJI/PUpmJzeIg5SeUf8drkptMF3ctq30No5GynCnW27n/fUlrBubsHOzrUVGFiuLsQ7lmRhosxorzUh+ZsHgiGHBaj8og1scab6KKEfxtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZdB/KsvWuhgoVqHC9s7oaOH3q2iWbVQhrF83UHwBV8=;
 b=KSMghyxbX/wNSmMeTalqMKj09CpODaXOTTSk+TVnW6guDeBCBylEY67iROCKuh5rkLXT4nj6sCFNI4H2/j7HH7bQNzH8Bv9KGhKdayoG7YmAo5swdZbC/9ZA3kRJBl0AzHBaQuHTFlgRnuzwi+VJ6KLKRpnzSL+KoQjmrzZSddFm+UAVQ0IdGPXtPJoefj5OGClVQq7lKW7K4pPp3R5r2CmC1w6RMnxNXG99TEPp0O+KEMPgRJFTu3HUIW32FBXqZgfn8zGw9I3vH3/6u/35cndCqRdALpgvfHhDbZWiS4O0NTRti/1hd1H32E91SeirD2Kf1R9AiBzPAvLEDaLnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZdB/KsvWuhgoVqHC9s7oaOH3q2iWbVQhrF83UHwBV8=;
 b=k3B/djrrWNB9qch3DBsZZNDEtGxRvhHDJbIJE3eR4jJ5bsWiMoQgRCVOh59+zrTJOerP118ukXflB5EneJxXNlkgfYIZeqDXN1S0YA4iZfggNZI5RbMFxqmv+fbmgXFok1TH3U5MzeOy3KfbhWMf8FZhyeqD9e+Q0+iuF0jnpJc=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5031.namprd11.prod.outlook.com (2603:10b6:510:33::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 15:50:34 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 15:50:32 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Andy Lutomirski <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/21] x86/fpu/xstate: Introduce wrapper functions to
 organize xstate buffer access
Thread-Topic: [PATCH v3 09/21] x86/fpu/xstate: Introduce wrapper functions to
 organize xstate buffer access
Thread-Index: AQHW2UTtw/cbNEx2QkCl3RUE3XcpbqpOer8AgAHJTwA=
Date:   Tue, 9 Feb 2021 15:50:32 +0000
Message-ID: <3B2E4B77-3180-4E3A-90FE-6BD08FA47A72@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-10-chang.seok.bae@intel.com>
 <20210208123346.GF17908@zn.tnic>
In-Reply-To: <20210208123346.GF17908@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 962f722a-23dc-4278-fba1-08d8cd126ef0
x-ms-traffictypediagnostic: PH0PR11MB5031:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5031677541BD50381B4C5FC6D88E9@PH0PR11MB5031.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O7rVvI2zitnQdQMly1O3g+vA6FhZxK6h2UXs+m22DefRznWGFhsK9qla9H+uTufSpYszOQdJo9QtMMXthhR77OACpq9WhwY5op3DNQVQ7cl2zhrbIJ+jqsjyRZwbxU8fX79MH3SN2aJQrhAwkfiZ4nDJFjh3rlkdwfjnMvljPCg+pcrnUa8uAqUC7zdGdMrXAFda+Ee9viF9tqNRRsMkjplehTl+yZ7Z7xRl8Fk4hJhtqtYzLiANrtLnvZTd88now+oGqC/r/lQ/M5JtNI70cRUsM5x1Uw3K2tW7DB0rK9qKUck0+Lo5fqu9gmZwwNAzck3Uf6VPHFCEg/MeZO3SdFDa7KF7xxm2vqSfBpyhHxfSzE/jXpbTKqvY1YG55RHpuk2LZ632P+9Wu3Dz/eqIobeZiGfPLyBVgnT0AvIjpEN+32JVBkAqu5nMTWD1x6x2d6jPTRkF1LW388VCB7EtBb4zGyjXdOy16U0LQLFVaU+osCIXdWVDVSB8CTuzlBzMyqhS61Y7h8XOZIy+RifiL+QJQATpbEP50OVFtfXlQqyUFN0v3+WbqcBJ3Cafpb2yxsFrQaSvfRNR1oyzmZZuNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(366004)(39860400002)(66556008)(478600001)(6506007)(2616005)(66476007)(5660300002)(4744005)(6486002)(66946007)(76116006)(66446008)(64756008)(4326008)(316002)(71200400001)(54906003)(2906002)(86362001)(26005)(186003)(53546011)(8676002)(6512007)(33656002)(8936002)(6916009)(36756003)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DvXuWGOlC3CfN045hVl9tezaKK5SXK3NsfcC5VFK0TgaANVAhXo34WQBG43b?=
 =?us-ascii?Q?qXVakzqJN5TazFyZOYEAh9KCXhqfvoHG8S+nURR5KMO70Xww0vlH6tP7Jloe?=
 =?us-ascii?Q?xR7ZeC8aFoYUsOEJ2e5K5aHAV3yCIfkGFN2ZClllb92XVxJadem5JQVoxtYq?=
 =?us-ascii?Q?ZJRsqH4yiw3vkxHHHZoxug2+fEab0TWlZ2Ns5XJ8rx2IC4v/I9kCs+kUGLC8?=
 =?us-ascii?Q?FkC0g/jPT/7a+lpnXwWncACbJKymrca1rnXh+1z+4gMVTt3FAElkn7/0q4k0?=
 =?us-ascii?Q?EKUNXIHwdVSovFct/gRYV8o0vYh+KdWONX8MchGmb7yJuA+QS6w4hGVjfz1M?=
 =?us-ascii?Q?j0eCE4/g721EMxkR4AbCFPqRrut8m5tLcH61wbb1wDDTwLgntsR1Ow9fvyG7?=
 =?us-ascii?Q?KBNJ5QgeUC7OduMFhWNvJtZ+QnEqwVw0DFp6C6GtRH5xS1+5yYH9k0Niu97B?=
 =?us-ascii?Q?J33OOYS5kpVkuylSRFXbCCdKr6kh6Qe4Hu+K9Cfzwqev0F2nUCOHZAtpXJfq?=
 =?us-ascii?Q?qcWZszzsUAdTv1L9QF0MEZHXFe5uP92UE5Kz2El4hZ51CrNDUty7Q5r2b7Qm?=
 =?us-ascii?Q?lVTELjotDVd2ujlodkiDW/8zbJmFFSS015DSQE7qV2ji+cUQ/mICNufeu2DE?=
 =?us-ascii?Q?iWRiQW7rJ0dxRRIW9B+4hDhviqOafv6b3QGE+uDr4IADdoJ5dcqJI6Qgg1C5?=
 =?us-ascii?Q?EEO2e70yu8267qeWMGdo/1Vp5izwpVU5HIPhYy1rdbBc5tSTgW13kT1XGzoC?=
 =?us-ascii?Q?qkZh+qfNbfz0cmQQjUU8UeYNDlMJVsctgiiiMb2NUgroL/HbepGf9roHCiB9?=
 =?us-ascii?Q?APfqzqrZNfG3M37Wt5+epXy+mqXgI+Pe52dkvIunfzqcda3Q+CkBFBGcST5r?=
 =?us-ascii?Q?LUIjcWQpPe7pG9rAgZzHfVwMU0ch9jASsp9UjYiAqROxIhSxNnLnlecaaKye?=
 =?us-ascii?Q?SOpeTurMvFA0fKO+oRd68YSbBcVcmcpmUyBHlCYTUscL4j210LXHTRe7jsBj?=
 =?us-ascii?Q?88Hl5OfJgrH2Rz3+J/bn1AblTRqUU+OdF2aZSeHPcPZzjLW/Qo1XOp1MqEBL?=
 =?us-ascii?Q?ZAiOaFqFKlq2NFcrqnJ7AqhIwyAPEeywNlfzN56bdUFZ7HIhm+uMbP7Qwzo8?=
 =?us-ascii?Q?XH221owiBRmjG5B5jnVnIUE+TqJHS77tHd2n07s8o2d8sTLNG3z9GrIv+m5T?=
 =?us-ascii?Q?VosWx20wp54Hmk7fo1w3JUUjCjAbZobz1bXXyAvhEe/TiYgScfSIUFgSxmTm?=
 =?us-ascii?Q?LjF4XMJGOjAIvLXZxdd2BeIrU2JLRN6rH2OerdHfiG/G6t0Xy8sCmVnQDxKz?=
 =?us-ascii?Q?hyDv1GTCYRNhqJ7C4QjV7n1gNk6hEnhGxKyG2htIU2kBUA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <685FFE35E8D012468F9523B7E0AC489F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962f722a-23dc-4278-fba1-08d8cd126ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 15:50:32.5923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmKgJBGRx0THqOgq2tT9grHP/MNkonnYaNegI6EaDpITWW9V6t2QffFfsuDbdBZd8XXq8ENA0Xjl6fCSK+L6q71jGAplKh9o46RQ4RccXMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5031
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 8, 2021, at 04:33, Borislav Petkov <bp@suse.de> wrote:
> On Wed, Dec 23, 2020 at 07:57:05AM -0800, Chang S. Bae wrote:
>> The struct fpu includes two (possible) xstate buffers -- fpu->state and
>> fpu->state_ptr. Instead of open code for accessing one of them, provide =
a
>> wrapper that covers both cases.
>=20
> Right, if you do the thing I suggested - have a single ->xstate pointer
> - then that below is not needed.

Yes. I dropped this patch.

Thanks,
Chang
