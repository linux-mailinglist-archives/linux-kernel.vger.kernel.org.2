Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CE8403A80
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349243AbhIHNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:22:27 -0400
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com ([40.107.236.55]:51040
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234910AbhIHNW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:22:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvHFTFQAFaGqMCNWSIcWS+lOxu9cOwU9LEBrCsvQAiSo8h+cpfMwfkY4gr2VUttJi6v8FsQDCkE9Y6BSE8NXggeO2sUg14kz3USUTArLM/aMqDx7eLP+IVShSUzAm1rMJUrTnc4xCNMciokdGOAX0yZryYfMoCEILaa6D3QP4FMijHlp2HFntTvVwL3Njj7pPMSaxO4CFVF1sWZZBaZzHiSm7jxRy0lbAnhZw42YdtKJG5Up9xZL2+ITiK8Nr6R0o3b3jB6ROBZ5u6gDyYPd/W1o+XVxAwMnMLQs6dGRVFjgfDJ9ypDiL1J2wKX966tmYuxO1xa71x0D4EYCyWBG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=65HaEeOpeEJTf1OxHTkdE6Fj7F4NWBEyJwIZ0Rajv30=;
 b=d+M+jeLcC9DNzTxzyrkUH8Okki1uVndOZFjNLW5Nklw+AD6+9y4JcW/vrg+djpAie8c+MGLzcfeaHE4eTYT7rumqpFnu9On+cfJwXlvWYztkVyZ66OSESLB1s42zLuJJ5lTHrVIu2O7mqLtDg317BVRKcLyR3Lw2P3ukeSrRufdChG+yFbqwXYlRqbTFjpSgwRBtBh4aCouRLljm+TAox4IwF3pvfjd2A2IFtNQutur6JseqfEYLZS9RbSMv4shzKeHlEJGti2kpYMthzwpJpHgQhLxHFDtBphOhEN1V4w7Cb88tB5mhWpcWQib8wq6R6yirSnZd1jSebk9sVyQH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65HaEeOpeEJTf1OxHTkdE6Fj7F4NWBEyJwIZ0Rajv30=;
 b=121dkmY7fk3V7SGwGEYl6apZPyC7qKlEch1/3ODHI5cWvOTz9veKcgPnKqJKve5LSgLoJ+bGgchsCaZApSvHWqfZri1J/UpeeN8mL4h2diU9UlWGyKXMaYnlEcwEibMaG/rSvL+N2aMuv8iaA9wapBFTUivdIw6QcRk8FLYug7k=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.20; Wed, 8 Sep 2021 13:21:16 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 13:21:16 +0000
From:   "Yu, Lang" <Lang.Yu@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Topic: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Index: AQHXpKowoLymFk5Tf0idLKRe5rRrP6uaEbwAgAAAhDCAAAhtAIAAAPuA
Date:   Wed, 8 Sep 2021 13:21:16 +0000
Message-ID: <DM6PR12MB4250080A69BD3E2DB0050273FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <YTitRjOZtWPTyRHd@kroah.com>
 <DM6PR12MB4250302F4EB80233D5807CB6FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTi0xkTVYqUpKXSt@kroah.com>
In-Reply-To: <YTi0xkTVYqUpKXSt@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-08T13:21:12Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=524dcd94-2027-4d9f-bcb4-8200de421ff8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7e612b2-c044-44cd-38aa-08d972cb89f4
x-ms-traffictypediagnostic: DM6PR12MB2859:
x-microsoft-antispam-prvs: <DM6PR12MB285961E701A6171C79F30D63FBD49@DM6PR12MB2859.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bQZcG8+Hl+/pxZ/cPyB+luS2/8EEE889hlY2ESW3BwsMinrnVUnINWK+yuLDk3RLWnynLmI4Hj46NfkTKPWuLZUQwFwdVf8b584lyGskrRUb6UcNJdjddPKZT3EyQtsm5zCoK1rTyGXSrsvyU4U3ZFWiBd+gteicBgDxNL8buz3hEA72nIOoDZsFXvm16NT50gb9Hwi0A18k3E5yXPT0cz/tNh61L/QgTFIR+tQngTSco/T5+EzN8eQ5q7CZqOViw9Lg0lvfM39v8F1CkvNtz+t05gk3GiYxvVFbEixXNb3xM6CnN1pPh9zA4zGKR+i6fQGUMr8l8p9DVmSGZigJDP/t7sKN2KtRKIWZozL5UYJGE3DsgFFUBveiCvtdFHkyGfze7iwYzFRJtx4ULGpV3hIV8tBitrcqG4z2wmRPOxvUpXhxDMebd23h+RmrmUbv3Gywk4GH/0zdis1H6ZXHSa8ABzu1QqnWx/n/HmkJmGDPaAS0AzTiKxjeJKcGMcVNsLUdSH/LfbFlz0lh399fJqJlXB14SThaqk8xCgriAgq2jdZ+VZvwvZZplSSpoShCYDFwcl+6sNvvvWxgICgbn/vUD5rSfrzSNi+sdYaNkriECFhTcSZjchxvn0AcB8phLXaKjCmTPA7zLXmk3G5nX6LBiRaC/IBjlQYJ4x3+pOl7L1HWbSpq+xHNRIMfQPCHDY9SwsVsRuZF6Y7m++TsFjSypkjWqRESifZEVdb0Jb6oCr+3K6r2HoSaaJaPq6JRqtYYPv/KWiipxE/yjp0tbLuG4cQIRziIVNaCPq9JKpw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(8936002)(83380400001)(45080400002)(55016002)(38100700002)(6916009)(86362001)(316002)(122000001)(9686003)(8676002)(478600001)(38070700005)(5660300002)(66476007)(66446008)(76116006)(66556008)(52536014)(33656002)(6506007)(7696005)(66946007)(64756008)(4326008)(71200400001)(54906003)(186003)(2906002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h6Pekz1ec5rSIlU9ngKYk5kS9CVR3bV/S3ElAOfwmZbFiUi+kEuZSs1NOOrd?=
 =?us-ascii?Q?1Qhshi7OPiMapTtBxps3Jdr+NlaDbkImeMg6MHyNaVvHXFekQJYNqO44YuSk?=
 =?us-ascii?Q?isH6lc7jrAskr8MrbhFVwQ3oUxbXIEAFeGz0DC+ZKZmbBL4fDxOlrrKhUPXc?=
 =?us-ascii?Q?w1/KzJ8Z9r5wmF17+uZThBUd3rGOq+jSIYVd230MKoVqsBh0AMDRBDZgYGTM?=
 =?us-ascii?Q?dAjTmFaXuWMsl97qywvVABOQRT8kAl7OklKmln0arHfpRPuFQvsrenhMSRmm?=
 =?us-ascii?Q?1xjU4l1k7vVueq7IB0tBdZFkv/cIw9y450NeXkwqnGmj1O6ceMfbeyBThpPy?=
 =?us-ascii?Q?Dv0ag4ZSXB3v/U6x88XpJPZWjVY12z3o+bq/TTdd5lQvBrKHeyfl2Ssv2Dw/?=
 =?us-ascii?Q?gK72xZ+4y7rVp5dYte1O2D0ZD8H9AmIbI3t6803YEmC+hq+qvfBjpgeVm0KT?=
 =?us-ascii?Q?3mvkKaz/XOSCaTzwshjwVgAKp/xFzyMz8aSSJBN1y4mChhSLxhCUDuw2vbmZ?=
 =?us-ascii?Q?mvedYH20Lh6wFKHYUvkojkC+drfG53A9SeCm+CVSDn+8j8Luw4i51ICOySiE?=
 =?us-ascii?Q?GlyXokfGd1EPf0g9M9z/QIN2L1Be4ZpM2JVxuBJUZiPNmdFdttuGpZ4L26sN?=
 =?us-ascii?Q?P1Rfmx7PYXBSs55EebHtr+IGHNfsxKl+DXTp2oPg6RFV5c8z/m/g0svB2xaX?=
 =?us-ascii?Q?XSQS7JD1H1lCggzN64f4wC3OYIMnrbVj7fcxIFrvXX1Jq7hqYfzGuM3ZdBTV?=
 =?us-ascii?Q?ZDAgX/V7RqTHUVciUimRTxHm0VQgR04CP2pN0q22p5/XEVYW6VjEnuduL+Qp?=
 =?us-ascii?Q?w3wWPAwJ6qhTyNnG0TqC9uab3T7gBeBgijxFtaTi9kDWtTiNvaJeGOmIA9aa?=
 =?us-ascii?Q?6eUUndboGVr72NcVZQ3EjhzCkYgWEhcS9GUpsaOX8TP0IDP59GqQ0Q/0elcY?=
 =?us-ascii?Q?9QthGvt/z77vPwHhLbY3DzKufRuiNMMUwI7CY2kOTfV3vIO3dpubDGUuM/ij?=
 =?us-ascii?Q?pyNQPDYaXBrroD4JCADC9wvAP1SEJmH3anGcppgEQ1oip6Ev0Bxe2KQg2C5I?=
 =?us-ascii?Q?RCmGkH3gMNZIpayQHa+No7i0feSlH8memqdXtLgI61NPfg8lCpay/QpMPcSW?=
 =?us-ascii?Q?EvKZP3PEYg9y8m0LPNXcxraWrA0WwBjCejyryGmEH1K6QjR/xTMk5MHK8mnC?=
 =?us-ascii?Q?KtA9i5LmosKv9fhVW5RfjIRWJMBGsKnBzgu0KViwBRuXjDEPnrDplaM4Kja0?=
 =?us-ascii?Q?A4hkgM0uHZ/458pubv5rsDzll/K+vW9Uy4dBQBRDX+Twco81x6Ika04X+41b?=
 =?us-ascii?Q?uy5qAcWBDDMbRXlkhafSghuG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e612b2-c044-44cd-38aa-08d972cb89f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 13:21:16.7350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSwdsHNmF21vNYUeY8mz5wTV8okh9BrFR0QYAo6fhBOB2eYWLVkkVV6SA+CLpQfzHmM2/hI1cN6j8dOLkXUjTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2859
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]



>-----Original Message-----
>From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Sent: Wednesday, September 8, 2021 9:04 PM
>To: Yu, Lang <Lang.Yu@amd.com>
>Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki <rafael@kernel.org>;
>linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs=
_emit
>and sysfs_emit_at
>
>A:
>https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fen.wiki=
pe
>dia.org%2Fwiki%2FTop_post&amp;data=3D04%7C01%7CLang.Yu%40amd.com%7C
>fed047de547541548fcc08d972c92627%7C3dd8961fe4884e608e11a82d994e183d
>%7C0%7C0%7C637667030534349355%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
>MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&
>amp;sdata=3DLHujj041jxZjvoYxVYUKtNr7us%2FX4pl%2FdOkFSOP1W8U%3D&amp;r
>eserved=3D0
>Q: Were do I find info about this thing called top-posting?
>A: Because it messes up the order in which people normally read text.
>Q: Why is top-posting such a bad thing?
>A: Top-posting.
>Q: What is the most annoying thing in e-mail?
>
>A: No.
>Q: Should I include quotations after my reply?
>
>https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdaringf=
ire
>ball.net%2F2007%2F07%2Fon_top&amp;data=3D04%7C01%7CLang.Yu%40amd.co
>m%7Cfed047de547541548fcc08d972c92627%7C3dd8961fe4884e608e11a82d99
>4e183d%7C0%7C0%7C637667030534349355%7CUnknown%7CTWFpbGZsb3d8ey
>JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
>1000&amp;sdata=3DAOLGBdj01XiEjhmsBSGTNuqejgU%2B6jg416Paz5XdM1A%3D&a
>mp;reserved=3D0
>
>
>On Wed, Sep 08, 2021 at 12:52:43PM +0000, Yu, Lang wrote:
>> [AMD Official Use Only]
>>
>> Thanks for your reply.
>> Just curious if we don't put such a limitation, what are the consequence=
s?
>> If we remove the limitation, sys_emit/sys_emit_at api will be more flexi=
ble.
>> Since the comments of  sysfs_emit/ sys_emit_at api are " sysfs_emit -
>> scnprintf equivalent, aware of PAGE_SIZE buffer. ", Why not make them
>> more equivalent with scnprintf?
>
>Because this is not a general replacement for scnprintf(), it is only to b=
e used with
>sysfs files.
>
>Where else are you wanting to use these functions that this patch woulud b=
e
>required that does not haver to deal with sysfs?
>
>thanks,
>
>greg k-h

But some guys think it is a general replacement for scnprintf(),
and  recommend that use sysfs_emit() instead of scnprintf(),
and send many patches that replace  scnprintf() with sysfs_emit(),
and finally cause some invalid sysfs_emit_at: buf:00000000f19bdfde warnings=
.
=20
I think we better not put " scnprintf equivalent, aware of PAGE_SIZE buffer=
 " words in comments.
It is obviously not. Some  guys are misled by that. Thanks!=20

Regards,
Lang
