Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE7C40453E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 07:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350949AbhIIGAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:00:13 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:30144
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244990AbhIIGAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:00:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igKzvlcWWiwV0fcB+VRCzXQTAVpIsiIyxc5UgC1O/IC3N25eEAP1Nk9oUTVjcRXiHolNSb8RVguOlgQm6ZUwzh/xLr6PEyMoVN9liR6iI2y5jmMTIcfgKH60q1omV0tZtgRYt49FwiHedmlotyVY9M2wkqBMZ0wTcjWUfZzU0swSLEhW5mfqQVhr45yye8PD1Y+X8AsdpmFNC9cMlRrX1IegKHiQbXuqVjyJNSCGi8kVOUbfAhYVwiKq7uI1EewaWuaT5PUbUvol9iQKyrQJ41OGO7ECYaVynq/1IrJavchBFKJHp9kqOBOe7/S33N0hqUsUi0FtNqPiAj4gU3ATKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=w7mWQJEDUQVrBC6t0BsFZ4uty4MC4lRuhGae0srjQw4=;
 b=nTMeqZCxLMbraBB/xXvo+wfs84LzB7nT09Yiq3Vi2P+Kk8OqSz24SJmLW1Qb5+E6Gao2O6kWUiu+aTZPuo//Tpwg2Omm5mfqqML1O6u0ejOY82jy4mN8vc0uoGzvQyiVb5zYv/a87HkVO6kt+C2dDHmq2QP+NXOdm85UAl50ACDL0WzoXB3UYNHG+z4HNKsSE37fR8+gF8CvCyR0AssV2qWrpmBpIYAxSt91ErRCijNYQw2YaYpdBZJ9SaiCbFtJfBKDteqlGQODXgei8ENyM5FXfnkjdo7E3bhQIOs9+pJHaFrC1kxecbiNvnCy40pEoD6NpnhiGA/Wo5tdzFhRBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7mWQJEDUQVrBC6t0BsFZ4uty4MC4lRuhGae0srjQw4=;
 b=BUMGdHsJeEGrsrvIH4r18ed0Z8BgDJZwaewVevvIySWtmJ8l7G+i1ee7W0c/5HeGMOYWQ+YzUqZfCVQmKnqCd+U7azIro6XCV1lSu96buBvliU1sJ6KDCRF4BkwfwA/dtrYDtFMLTeGheH1Aq4qFfsqh0acZf/jUjF6qk3Ia8nI=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1436.namprd12.prod.outlook.com (2603:10b6:3:78::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16; Thu, 9 Sep 2021 05:59:01 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4478.027; Thu, 9 Sep 2021
 05:59:01 +0000
From:   "Yu, Lang" <Lang.Yu@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Topic: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Index: AQHXpKowoLymFk5Tf0idLKRe5rRrP6ubJ2WAgAAA8aCAAAcPgIAAAZlg
Date:   Thu, 9 Sep 2021 05:59:01 +0000
Message-ID: <DM6PR12MB4250436AA392855E4C901A3CFBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <04b52ef5b63abf25e6d50fd5bdfa90727e100a09.camel@perches.com>
 <DM6PR12MB425005AE652C12F04E66B5B8FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTmc53ZPdDfC4+lz@kroah.com>
In-Reply-To: <YTmc53ZPdDfC4+lz@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-09T05:58:58Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a63dd264-8f77-4306-8b31-34f5fbc55476;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23e5b6fb-854e-475e-0061-08d97356ec09
x-ms-traffictypediagnostic: DM5PR12MB1436:
x-microsoft-antispam-prvs: <DM5PR12MB1436E2D27194C90CAAD0EFA0FBD59@DM5PR12MB1436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2fsgXKEYF/5Y9IzsRsnT+k0eNu2M1JSQduTNgDFtlXUyvfwyiubaQtwPCgyBDatXRMaYhjYeKkWTlOA+Vj6+9lI6TarGEGtEb1h8M9p/TCnxPmnMf6GrzdPD35qX2gUQD2C4Wh2IS52w5rdFMQCoBBlxrS4EsOc2y2pSo27dFZ4NdoYnjeQ47Q67qhEpWFRR0FbTM4uEz9fdRuhIHNdQRM9ToL2UdvWuuNoHnoOxPhLijinL+ofDc+lBYENzTU0LdBb70bCJm4g9aQVim9LAIyH8ImsIqseNqTQzsSvZZpJrnJoIewzlwbVyhmteQrly2HNUuFqlkcV7jQ/hWU2RPAL4tPPgBHiYC6ACG1phAzbZcbV3gABoCH3SkmDaAMxuRKtS2gOtW6C5xzGDcGihGIefoAcFR42jjvJ7rkHy1YEd9TMzB2g6gUwA9rgBqE5p1qhInUe+w7ZQjfndctTtdo3rsEE/EjQczi8wNRk79GASu6g+h3+oWIrZmkJFs8RBBiSkePunGMjxA7NUCN0sZRGcWCkASs8UZM6/2bTYzl2jS93XeI4B/xuv6BJ32sOWrGocufKH2pAVpNgmMPKa7AFGH7TkXjCSoygOE12JSTuVs/0poYwglnjbSkoFEFHeX1MIiYizJV8ecG9A9Fet01Y3PvE7FRE8GX9xiIbGxSCShIg4jXz2+9Y5EtnG60/xAx09kPgbNq5lqeGrFLJq2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(5660300002)(83380400001)(86362001)(55016002)(66946007)(52536014)(8936002)(33656002)(478600001)(76116006)(9686003)(66556008)(71200400001)(8676002)(316002)(66476007)(186003)(64756008)(6506007)(66446008)(2906002)(26005)(4326008)(6916009)(38070700005)(122000001)(7696005)(54906003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xeFBMFo+eoYtHNbBMhdjj6Ecjslf/UEaRpxS8VW9t/8tgzSWoUmUAJKN7Cyu?=
 =?us-ascii?Q?iRh4hfi+JYIM/2kh19qHM+QL7ksG1CkOONLZ1MWPSfl7DZKCzrVKgJpsc22w?=
 =?us-ascii?Q?uY0813bDzhMB56yTBR+5xNRyc99yU/eu90iCiipgNuRwFwKJ38IHsq0MqJsc?=
 =?us-ascii?Q?bIgMc8tpNwqTVdLbMRMp5cn7pXbkmfYm227Xe4YuIUfCxfZBYNC38UaFS0U/?=
 =?us-ascii?Q?qZoOH272rPFhyyvYWiWsvUIngYIW/mCsWoOgs2ABxSYju5iki5zqsqhZPjYK?=
 =?us-ascii?Q?E+PbUUpLLGOrJ0ALyaZm5zUDkyGFwmEPoHbWLhIMK7g6sH/Oh5x+q98c12XV?=
 =?us-ascii?Q?j+FcHlo1vuJYEGVysUBI7CZg8jclhqeHGrOI8v84qJZx2JI6sXVNeJCxuW4B?=
 =?us-ascii?Q?5ij4CKHbFfu1KhHe99KO3kVGuww+939gxUXyLrodfmCBTuKTDTcYX7anQ5TC?=
 =?us-ascii?Q?kLitq+xAocRpvk+Izx+ELBVRBn2Uz5Hb7rj1uZ1wtSklqVCKb2R1zASH6ZEB?=
 =?us-ascii?Q?WYzZm0k71p5Q1je5OYdkJvqeHz0wqRPI1L752BNNijNJQCmNCSXkeKdPvbEn?=
 =?us-ascii?Q?Yzjc8B4hYvPGoUT0UxJbWpOLYnxEgeGYQEibISRv3y2cmnqWyl3eKzSKUw+e?=
 =?us-ascii?Q?5TWD455aI5HvtkKzNPUL+K62zOfhIenZ71WOYdKjqYfTKS+LzC0Z3qwDVWBd?=
 =?us-ascii?Q?lHpEXP8D4hoLhCWNZHRiVr/7hBVGpXUZ4/ZR+VpK6zb3g6ioPONSb61ADK7E?=
 =?us-ascii?Q?yyHBcAes8EC8O4ONrKVWzARfFg6Tddgj3bCb0+/ieyMhEDlRmlVZUsVLBQZE?=
 =?us-ascii?Q?UsieXMslGrH/FEj5Pi2KGC3PRbLgl9+GuqsCKjrKRUDZRIVueSE1zqTQBtRp?=
 =?us-ascii?Q?CnvhDX5QTw8RU9wsH0b0M864u6S7R01CAuUX81uKO6bvtuFoHJSVigb9ZYz8?=
 =?us-ascii?Q?S+QFPj/upaitlG8/hA86GSjPjGwGqRZd79Ira5tkqvBtXCpHwGAhjNCDErCo?=
 =?us-ascii?Q?fXJVFVTohfbdgtlAPamkPbcpc/jiVdFM3QZieswooWorjpQ49i/SDwnIX0Ih?=
 =?us-ascii?Q?k7CvLkUp9oU+aY7KMKzCplaLZ5newc/ROkCEx5Y/8Jibon+Pt20DqCi+3fRo?=
 =?us-ascii?Q?EC8Av2q/fUa+tgEGZm5BCBM7DCXZDQxaEl/bbrpzuu13OBn+HVDvTILr6ABC?=
 =?us-ascii?Q?Xz+Q93WOG9SEEHLaApXN617mz746/fOp6ljQ0Y2Vb0LcU77neDFbCn3xilW6?=
 =?us-ascii?Q?TlEY7LUGWhftGWiOT/MI8welhV+R5SZI2XVKh0kWtVI/j7mT2aKaCTLnHt34?=
 =?us-ascii?Q?kApZ75Gbu0pA1ghq3D7+asZT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e5b6fb-854e-475e-0061-08d97356ec09
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 05:59:01.3263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GL0VILvzPA1sGXFQIP+cIHvZaMZr4xuAAo2PBywCDHqmMm2uv4Z7xerasBL/LmmajC3e8v9cjHkXy2gCHD6xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1436
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]



>-----Original Message-----
>From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Sent: Thursday, September 9, 2021 1:35 PM
>To: Yu, Lang <Lang.Yu@amd.com>
>Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki <rafael@kernel.org>;
>linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs=
_emit
>and sysfs_emit_at
>
>On Thu, Sep 09, 2021 at 05:27:49AM +0000, Yu, Lang wrote:
>>
>>
>>
>> >-----Original Message-----
>> >From: Joe Perches <joe@perches.com>
>> >Sent: Thursday, September 9, 2021 1:06 PM
>> >To: Yu, Lang <Lang.Yu@amd.com>; Greg Kroah-Hartman
>> ><gregkh@linuxfoundation.org>; Rafael J . Wysocki <rafael@kernel.org>;
>> >linux- kernel@vger.kernel.org
>> >Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
>> >sysfs_emit and sysfs_emit_at
>> >
>> >On Wed, 2021-09-08 at 20:07 +0800, Lang Yu wrote:
>> >> The key purpose of sysfs_emit and sysfs_emit_at is to ensure that
>> >> no overrun is done. Make them more equivalent with scnprintf.
>> >
>> >I can't think of a single reason to do this.
>> >sysfs_emit and sysfs_emit_at are specific to sysfs.
>> >
>> >Use of these functions outside of sysfs is not desired or supported.
>> >
>> >
>> Thanks for your reply. But I'm still curious why you put such a limitati=
on.
>> As "Documentation/filesystems/sysfs.rst" described, we can just  use
>> scnprintf(buf, PAGE_SIZE, "%s\n", dev->name) in show functions without
>> such a limitation.
>>
>> But you said that " - show() should only use sysfs_emit() or
>> sysfs_emit_at() when formatting the value to be returned to user space. =
" in
>Documentation/filesystems/sysfs.rst.
>>
>> Some guys just try to replace scnprintf with sysfs_emit() or sysfs_emit_=
at() per
>above documents.
>
>That is just fine in sysfs show() functions.
>
>> But sprintf and sysfs_emit/sysfs_emit_at are not totally equivalent(e.g.=
, page
>boundary align).
>
>Which is good, it checks for more error conditions.
>
>I fail to understand what problem you have had with this.  What sysfs file=
 was
>converted and had issues?
>
>> In my opinion, we add a new api and try to replace an old api. Does we
>> need to make it more compatible with old api? Thanks.
>
>There is no "old api" here.  People used a wide variety of different thing=
s in sysfs
>file show() functions, now you can just use a single one.

Yes, replace these things in sysfs show functions to avoid sprintf defects =
makes life better.=20
But assume users will put a page boundary align buffer address in its' firs=
t argument makes life so hard.

Regards,
Lang

>thanks,
>
>greg k-h=
