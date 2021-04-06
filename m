Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57B4354FC4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhDFJZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:25:29 -0400
Received: from mail-dm3nam07on2080.outbound.protection.outlook.com ([40.107.95.80]:29792
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230167AbhDFJZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:25:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3CuqYAfi9H/4DoGu4J/oNGo7I7ZRevGi0AOfsKUYsfIuIM67s9u9qWVxY6czsGgcHXHPQp4oLOsvqYJrwSjwuxiiKMDJhpBbXjfeQnC8tRouzbiPdYOcTJJaRrVrLmGcwO/Zvx5u11EMK2pQhDH31Uo/0KnDVKTDvTILT7vRrQ1nYcJHag1PB4Ks4BC3fJZI6u52ZDsJGzVApoQmZHQYDncmp8ypfShLIU/xUhGgUfvtjLafgZwOAuttixQMOq3Go+CA2a09jGEE8CAMYS1HlToJP9+xLkAFImGu+YgMsD0lD/MhOdgCuloXYmUyE2r3fLdqaNe5oolmBOLyh2uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsXtZGMWqQurXGKtiiXmZTcGrJ2/2QcZGxY6l6rgpbU=;
 b=kLUzH7JL3zQpB3cya64c8ZMPOBoEbfhbGzIdT5CqgdV+2BJZkmOd/zLzQ5LgReESmY/P6g/DRyu4yVJqv8fMesBrc3TguOa/u7zQtDxy8Vy64yQPZKHExfXgdI6jDGF0a6s4UmrvEOXVipVhH19p4p8I5C2psZoL2ROBEVQ6B3IMCnQTAozaTyLVxO/+ESXpvIf8NOnG6vaGINeb0Q9qojpGvEJG1ja/Pkzxd4YXBba8S8Fi29FsUA3NaaIuwUBiARxS8KmVCPlsYoTg+CP0Fwioxyqmv4tz0ifxr+CNvLc1v1/dzoBTrfN4qCufv2zXuYkdQEN1B+RbylQOLTabWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsXtZGMWqQurXGKtiiXmZTcGrJ2/2QcZGxY6l6rgpbU=;
 b=ia9YJfzNnlQUHoAfvQp10Jb1g1Yu/6EZ3HS5nbqXOuKJ9iTGdzfSj2XHyLsZRsvGEGi0+X6RPkFo6otfhAYC3BtGvWNWnGbqTXePf3nEhqffQkiUoZjpsD6tBetVuUgY7mHxtunR68xCE4GUu4hgSR62CICDjCf497ve+9OMzHw=
Received: from DM6PR11MB4441.namprd11.prod.outlook.com (2603:10b6:5:200::11)
 by DM6PR11MB3145.namprd11.prod.outlook.com (2603:10b6:5:6e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 09:25:18 +0000
Received: from DM6PR11MB4441.namprd11.prod.outlook.com
 ([fe80::9400:9b03:a7b3:446b]) by DM6PR11MB4441.namprd11.prod.outlook.com
 ([fe80::9400:9b03:a7b3:446b%7]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 09:25:18 +0000
From:   Pho Tran <Pho.Tran@silabs.com>
To:     'Greg KH' <gregkh@linuxfoundation.org>
CC:     'Pho Tran' <photranvan0712@gmail.com>,
        "'johan@kernel.org'" <johan@kernel.org>,
        "'linux-usb@vger.kernel.org'" <linux-usb@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Tung Pham <Tung.Pham@silabs.com>,
        'Kernel test robot' <lkp@intel.com>
Subject: RE: [PATCH v7] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Topic: [PATCH v7] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Index: AQHXKpm+rbC2wNO7d0GjPcy5lZODOqqm8kwAgABCJjWAAAJr4A==
Date:   Tue, 6 Apr 2021 09:25:18 +0000
Message-ID: <DM6PR11MB4441660856AC72EA5764BD43E3769@DM6PR11MB4441.namprd11.prod.outlook.com>
References: <20210406040238.1850-1-photranvan0712@gmail.com>
 <YGvuQlxyorJt+ErG@kroah.com>
 <DM6PR11MB44414602F10C6C991A65D48CE3769@DM6PR11MB4441.namprd11.prod.outlook.com>
 <YGwltSD+iEPmRblS@kroah.com>
In-Reply-To: <YGwltSD+iEPmRblS@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=silabs.com;
x-originating-ip: [210.245.53.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23d879d9-ff45-42ca-07d4-08d8f8dde50e
x-ms-traffictypediagnostic: DM6PR11MB3145:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB31459E8EBB9FFEF3E0FFA278E3769@DM6PR11MB3145.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XOazVuDg/2cDZ91Dt02tSQOO8RlsT/XmW2e+Cl5NxjVWIV+08TRxPzDFRBMLchYXcJKOgqlNwzOeHUXs3aCWRNeIU4c8GJqLmDOmjMGZ/c9SdTtD5gsjft3tXJoCS74Q+rDFItmTktlQwaYFvE8sGnCcjOPLWSok+4RZkVIzCDMUlxTsDUVFZz2ZHjzqDprVJT67Lvce6CdAB28b31wqaTuyZa3Yf5TyQIUvodWXsz9lygybHhusF8ZgXB+jRbcBI3iuhI7dPVFOx9U5W+rLF6wiY8pZGkNcnUT5uYZ8wnArDdlETcFDTNqn6DR9LRwtAkuVBD/DatbuVlXbzk67TADK5YNEcRAdkgrg8g4JHmJHTene5XPEIVR3cM2xBSuZfIrycVAt0ELkqiePH83ffLRIG7XdgiztKgdzceJFqiCdaB+XJsAhT9Wm2jYcHDHwZolIpXVcqSB1JDBskwb/KJIDJqTiDuuOr4dUCEGTGVtHiWHa02My/kobpfbNMX2wRFCwxb70P4aLZEKyPoEkIity3+UdR/bGvbGYr/V7efvkcEc4FC01ZzylxExxrHVc7lnauALGdQn1uGXkaIMEEifBn7VrEy6HnKvQeRf3G4nvqcT+QyPpWPgNAsE8eJvkBuHpmpoAEf17sPi5EbMFaW4ZR5vO24O4f5+AOx0MImqaMIml7UT+DQ49eZcjgRXXmWrlz/k85zfsmSm3iUmURgAcyL2EzeG1cKr5lNJWVCs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4441.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(2906002)(8936002)(6916009)(83380400001)(19625735003)(8676002)(38100700001)(186003)(26005)(4326008)(9686003)(6506007)(71200400001)(966005)(66476007)(54906003)(316002)(55016002)(53546011)(478600001)(7696005)(66446008)(66556008)(76116006)(52536014)(5660300002)(64756008)(33656002)(66946007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?V/AJURpJq+vKP0pwX8rgKVlUiSEZdO054aTLaFR8YtAZcZbJHCPUVe7BEUmj?=
 =?us-ascii?Q?7taEYzymbbmev1YBJ/On6gY9p0Gf82rAOm/uYq45gFnOVLG5c0FZKUXTtKyP?=
 =?us-ascii?Q?OrPhtwK4IMXtltfk4kpx4cgNZFcisjIe3NYdUSFvPaJf2YK+nRnU5WtuwG/s?=
 =?us-ascii?Q?qDIQkdXWIvNOVq6S4F0T40Dwh1s6mUnWI65Mjq28P/O13hVtcSNSvsJRF/CB?=
 =?us-ascii?Q?hcMclg9p9w5wAsfxTF1JrIKJh4zyE2CLb21C3tJvCr+WGNsuFifOtCx7edm4?=
 =?us-ascii?Q?FDxQj/e9P0sOx9qnOj9IvIXR6t/pqP2Kotb3cPrh/5HvBqq/UH5wPNA56wwq?=
 =?us-ascii?Q?F+7v0H5IS+gMJyMc1UxNowkaVqNxlSAfA+Lkxvp8K+eVtGj9YMHCiPl8Em8v?=
 =?us-ascii?Q?5NVXPz7IYrDfjRbDNZF9/KKaVxTf3f77q5kBrqTH52hgQ4o/GrDDp7ebp4Yb?=
 =?us-ascii?Q?yF/ODa5AjqJ3Z9ORTLc+UuG3osy2p9V2Mkvri102hk+eHj7KUlaOJ96F+ZuM?=
 =?us-ascii?Q?lhCcBElgUZ7m3GaKtRp+Ez1W1SDi05jSnuCbOeKWIlla/DnFtPwxYZnS6bZB?=
 =?us-ascii?Q?GwbTLEhLYz2tFFfu5BFoRAUy/3I5OVyW2+sqtzT5TThVHjKZTvCMgnBWyqhN?=
 =?us-ascii?Q?3de1jKufTEeaIUHpe4TutrerDUxOLlljUjlcEt5k9K/X7Do/HdM8NhqPUSbn?=
 =?us-ascii?Q?PjqI9B2zHFz+9rNESrBycBAllhOCIzk/Cb9smdNIM3nR7g/bEX6IRw18xnxY?=
 =?us-ascii?Q?jBt+qeWX2RBsl/yT1u88NSQrEQvuDFgEk306hr6XNmm6Wg/Lj9th4CAP2xzY?=
 =?us-ascii?Q?HzMce+Ofkny1TCE4JQK8nCIBSfGjEMQuCg8ZRlAmiU14XMtQ6g3TSw84UOM6?=
 =?us-ascii?Q?jjuGILk4PLvb1NLvSUipYYEGGkMYfLYH8CLQ6HdaFL7d+ngSt6nRABCRRLD/?=
 =?us-ascii?Q?a5ufatiwxj5ZYiSwHdpl8FKn63fJGLda0hMx5ndGys0xU2IupWWfF3oOLydg?=
 =?us-ascii?Q?8a7IEa/rDh99ESHH8oG7nhnjbg0DIMkDnksAv+gxtk0tQQAgyRp7XfYy4+qa?=
 =?us-ascii?Q?HyPxZUDhXyGaWk068CAif3OX/qai4YkHLHWBmbC7sq4xEZfLOZ3JVgNl1Zss?=
 =?us-ascii?Q?3LvuQQthy3EtgRw+F7z0z3paS4QuzwZrylb1j8Xi5yoy4d23foM9cVFMMxEE?=
 =?us-ascii?Q?OZim7KTto7tKVqybanxFNmZFDGdg7MTDCAu3M0ggW/7JsbGq2na8rJK0pVhH?=
 =?us-ascii?Q?QdQ23JcLmlyIvLX1LH8ZBdz0C7ijHaFwQHQbpCK2zbC97BiF1mMx2pbui2UE?=
 =?us-ascii?Q?6TU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4441.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d879d9-ff45-42ca-07d4-08d8f8dde50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 09:25:18.5928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kj9hcHMFTlvFINIx3fZe1/eQFgkKipAfMPXh9pafuhOt5mDtQNP9Ky46qttS7yPtMHECzE6zAQHy8Fme/SXg8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg!
Should I send the Patch with new version (PATCH v8) or keep version of the =
Patch is v7?

-----Original Message-----
From: 'Greg KH' <gregkh@linuxfoundation.org>=20
Sent: Tuesday, April 6, 2021 4:11 PM
To: Pho Tran <Pho.Tran@silabs.com>
Cc: 'Pho Tran' <photranvan0712@gmail.com>; 'johan@kernel.org' <johan@kernel=
.org>; 'linux-usb@vger.kernel.org' <linux-usb@vger.kernel.org>; 'linux-kern=
el@vger.kernel.org' <linux-kernel@vger.kernel.org>; Hung Nguyen <Hung.Nguye=
n@silabs.com>; Tung Pham <Tung.Pham@silabs.com>; 'Kernel test robot' <lkp@i=
ntel.com>
Subject: Re: [PATCH v7] USB: serial: cp210x: Add support for GPIOs on CP210=
8

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Tue, Apr 06, 2021 at 08:17:42AM +0000, Pho Tran wrote:
> Hi Greg!
> I am grateful for your promptly reply!
>  Yesterday, I got the response from the kernel test robot with this messa=
ge:
> " If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>".
> It's a reason why I added "Reported-by: kernel test robot <lkp@intel.com>=
"
> to my new Patch.
> Could you tell me what I need to do in the next step to submit this patch=
 to the kernel mainline?
> Once again, Thank you a lot!

If you fixed this as an add-on patch, yes it would belong in the
reported-by:  But as you are just fixing this up to a patch that has not be=
en accepted yet, all you need to do is write it in the "what changed from t=
he previous version" section of the changelog, below the --- line.

thanks,

greg k-h
