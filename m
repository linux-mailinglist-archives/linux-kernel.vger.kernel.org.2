Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C9335427F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 15:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbhDENxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 09:53:20 -0400
Received: from mail-eopbgr1400119.outbound.protection.outlook.com ([40.107.140.119]:7451
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233724AbhDENxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 09:53:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrpXW0lo9lR9fMsg74sXSyt/3Ppj6fDu3PAZjb/yVa5ZSIyfuzsLjsNqzJ4rYBpo+L/lpaCtNA5cjvdY5yhtnNgNmqe3t1uXekdRRHoYfdNSKcTmFZMrzQFV67QTqji8HlaqNEn8KuMF0jOmcTMrwmIS7EhvtbMuzFfnAxTrLVXxx5JQi0tNHfQw8nGzh+Qw4qxOIA5ItE5YLK0IbUKwwrgBXE90Z2EmGwEE0FWbOjuV7CmKsmy9fpQiWNnsrVzCCdKhdE04oDRBODJFjJfwuzpLukQeRU1E/YKeHHDNfImz0cF97OuhrclsKv6x/vztZwtbEOJ/Aup9Dj1WR+Unbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajG8Ikrw1qq+VfploINxUlEbD66cfdOqbVC0igGw7Rk=;
 b=Hqvy1ynF6zJavk5d4SAmEuMl1rwxTv1z0INirH1eGaysx6lSZf+e33kUILOyx8yhwsD92NmHelPxe51eHKR29edhN4a/m7sPm1exzqq8EZHPnMQTBAQgTkolJmVMVtSv6JxtLziBFwah8IRZgvluqnMJWrbHD8ccolUkqJtGLyHKpt3TjICqD+1e5RZWA0xPZs6lO5iaEylB/mBg9gdyKDgU/mUT4Q6p/j5LznKkiALDBkqBzRD+ewNXbF5xfzhNpxr8nOJWSC2Qe5BAckemuaVKbIQvkLGtoLctIREEGJZbSatcoWelNs9koIuyQoVLJpjYVDUXskb2MtzFZ7a0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajG8Ikrw1qq+VfploINxUlEbD66cfdOqbVC0igGw7Rk=;
 b=PEGhyH34D+rN5YLWvev5MExHlwGgWgTnfjV2rq3R6koMy/k82j7lENiS+g7X2aAAI46S2M88n1TjBJxrUiqYaqZNTjOky4jJA7u3g+R9NRWbNwIdLldoRpJYJwb2lHPsAXdR29rqVTgPJ5rizhVgHoPkNXTJWLN/wRFt7Zeh8tA=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSAPR01MB4707.jpnprd01.prod.outlook.com (2603:1096:604:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Mon, 5 Apr
 2021 13:53:10 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 13:53:10 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH next 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Topic: [PATCH next 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Index: AQHXKNYoPNBeg4xORkG1GcxDTKZKeKqkI0+AgAEGM5CAAFEKgIAAeY4Q
Date:   Mon, 5 Apr 2021 13:53:10 +0000
Message-ID: <OSBPR01MB47735215095EF20C0B0AA793BA779@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617487714-8312-1-git-send-email-min.li.xe@renesas.com>
 <1617487714-8312-2-git-send-email-min.li.xe@renesas.com>
 <YGmQKyweNi3lWoGM@kroah.com>
 <OSBPR01MB477323303D45865B0B2AD96CBA779@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YGqwGeSCdJwH33od@kroah.com>
In-Reply-To: <YGqwGeSCdJwH33od@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21192dfb-4de7-4a41-8086-08d8f83a263a
x-ms-traffictypediagnostic: OSAPR01MB4707:
x-microsoft-antispam-prvs: <OSAPR01MB470790DF2820047918C5A6FCBA779@OSAPR01MB4707.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ejOzefU2rbepidvTUDd4LUnYst6q1I2eGZbNbU00T/bkDckjzaiSr1SmbCbusd/DDgSL7sX0NcUHmsi+GgbakQsT6oKxTn95med5LEE4V2618ePyT8ppST/D8S1/Hvr8cp4RCw2HZo8O2IvYLypryw5qMHL4mPXw1aRYSGpMYrDwxNhx9uPr6BCwGg0YesbbX2/nsNMmysax2goWd/1lQcwNn2+5oLc3addXGH+m9Owj7SQngEmaVY41Q6tR6S6qmiviqb7CgYAQ+Q636Ut0QBI8rrSm4BE4LUWKez+3Su4OqP4NRLbH2OgpzgZ3bGySau13ZhHRA0PuISs3MEDCBPNE7EVg1+FcF2DA6Vzrj5EzM/weO4zbgrK+BuNlW1zFDoLA7/lCxz53f5My2sT+cUR9d5/SVYJoiIzm9ExJUZopGbDoyqYw0dL7D4AamvKqcot69t3M2tmudLromupCzki5pKvZrslYTvsrLrzlsqDx3vNWVjZfQqjLQ0MjWJzZHIoeRMlt02zqPyMlndIzXRCphnRorwjAO3Fb9dX2pk/5jH5A02r4gnJvjV+YQXRPVqCxo4dS/TWFcPh+gMiguXRgV9BmSKrmVEDU9M0is6Qd9wOu0wUuCpsNLURlRLKExs7h7Yn1OETL0n7bg53/d1PxIsKeVGbh2Q939QEK18g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(33656002)(71200400001)(54906003)(8676002)(7696005)(38100700001)(55016002)(5660300002)(4744005)(66446008)(64756008)(66556008)(316002)(66476007)(9686003)(66946007)(4326008)(76116006)(52536014)(478600001)(86362001)(8936002)(2906002)(26005)(186003)(6506007)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U8ezAa4Jce5LtfijWiOrAYUaz0uBKoNwCXp51iwtJydEXFes29x2e62DogIt?=
 =?us-ascii?Q?V4Pvg52IOIucvErHwXxMqkmu3eLJt7/K6lZmSmo631zWMjVfiNQqbeGc6YOZ?=
 =?us-ascii?Q?1zwFRmnXiFfG/tYmSNwie7YTS9mE2X6TgN4qTnWqbIopSBGH+wSoQ7x6Mgez?=
 =?us-ascii?Q?cl0jJuj1K3kG0IBz1EtC0Ji9ciVT0ovqAAJy7NppLUL9gMaxs1ENiB9fh0JK?=
 =?us-ascii?Q?SoddHVCGXu4kJWbH++higtKbkwWffRxXKZWibjXjVD5334KkEo1ofN18xfM9?=
 =?us-ascii?Q?mXBIQTBBR1Zf1seZTVcHSmmbCEIenF1bioGJ9y18YtYkPsAoSukXIYmV8X+g?=
 =?us-ascii?Q?L/UEqgmyYVdlrrVW2pJua41oP7Ui7O+xdPcOBN1rGIsZb3fWH8ec+AdC7bY0?=
 =?us-ascii?Q?N1s5z1S7aKNyDeUlEfAphqbIdPMhU58NvXoPZLXX8/ShGdZauhn8miM062Ka?=
 =?us-ascii?Q?2aoCTswYPayz+nUjq+1koI95UZgLfDoNrvdvfilAB98422DW/L6xr7/WnWnv?=
 =?us-ascii?Q?GwQYt31FMWHtRtNDuWIYDGEunxmv+HHLA8ZcVVoUfM4F/cvy53dke4qZBSWo?=
 =?us-ascii?Q?fb2CjBz1QyMLKGP3DlzZwlNj5sgNUyn+lF9J0EZ5QBmHoWQ1jGD0M57HRl3C?=
 =?us-ascii?Q?5KFE2Wo4nKuCtX6F81awIfiacu5RPazT95WOCR4ws2MHjt/JA5CiXduE/ECN?=
 =?us-ascii?Q?pfR/fkfzywwMtqW29HkUFKkTJASo6TkXDbTPSNAcPx1BdykXkU9TjPoiZWLD?=
 =?us-ascii?Q?0zXMP/REgsrqtTG5YtUvYrok+GogJQUditKkUUPsWKtu0UEmduy684Zk37cd?=
 =?us-ascii?Q?79VlSxjIj8Y4QGL9Lrkq0NApgKuW2oOYiWyRoNW4h2MBQtzwcqaWyB6pzb7k?=
 =?us-ascii?Q?P+Vsyu7iS49vKb/Xzm/Wtks0QDMbbY4zPiBzJH1LDkRH5r0brquMPmXZLqPi?=
 =?us-ascii?Q?mQrJ0HwjtbX+Me/iIqQxTW3mTJcPF3WM+hcjy7QO3+18NlEg2SF69eZV1k+p?=
 =?us-ascii?Q?ijimKco02gUBGN1utGwzwPcpEVqpxzr48PN188oiRoJaNB5JDER6+foe5Rou?=
 =?us-ascii?Q?kmKMpSXiT7LCK9EbUTmjajzGP3PmDwrJibrndYah+gXaTG04JL8HlEAB/meM?=
 =?us-ascii?Q?aJRZg5XnWqNmxApHmvmd9MUpy2oNMRNZ8n9g/o1RJRKEHJM1Hs924w9ssQmX?=
 =?us-ascii?Q?nd40y3L1vdUs45Zw2gn4JbuJfoUZrFarFziMtdbx4+Eqm5zhg2dHytTvype/?=
 =?us-ascii?Q?OfD3yUK9mvyzJ1AvoN4xBL8gijR/59ZEYn0qojXGbpAOpwsm0QRhJrwqNkNw?=
 =?us-ascii?Q?WZ89HMI8yCYuZTs/FHWJfRsu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21192dfb-4de7-4a41-8086-08d8f83a263a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 13:53:10.3076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TbWcRV4UBNMrU6G2GxPH6IeLz3rSzlgHjn3HVHzSINaR6VsIHMR375t7FWOlu5fcUQEK+eqjGUF74n7Tn4kJRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4707
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> > > Any specific reason you are not using the misc_device api?  That
> > > would clean up this driver a lot, there's no need to create a whole
> > > class just for a single driver.
> > >
> >
> > Hi Greg
> >
> > No specific reason. I just didn't know the existence of misc_register A=
PI.
>=20
> Your file is in drivers/misc/ :)
>=20
> > Do you recommend using this API to create the device?
>=20
> Yes.
>=20
> > If yes, can you tell me how to obtain a appropriate MINOR number from
> > miscdevice.h?
>=20
> No need to reserve one, we don't do that anymore, just ask for a dynamic
> value and the next availble one will be given to your driver automaticall=
y.
>=20
> thanks,
>=20
> greg k-h

Thanks, I will change to use misc_register and get back to you.

Thanks

Min
