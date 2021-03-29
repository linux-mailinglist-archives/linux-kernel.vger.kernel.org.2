Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1834D5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhC2REN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 13:04:13 -0400
Received: from mail-eopbgr1410104.outbound.protection.outlook.com ([40.107.141.104]:47664
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229502AbhC2RD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:03:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNRKp8nvRjZaxU0Zc6XEjcm6YXsV+301rfLomkehLlTN01+zYUMIU0veojYh5jUh+p27IN1/k7+pvPy19L6S7hHFZvnFlUvp4nHvno2egsKcr4v8VTtd5YxifxeTUlZ3uPxAPQxTjWkwBjcCgkFCGX9sQmV7Mm32oXHktK0xp5K1o1bxxXjihtCCDsAJU4bV3QcT0agtOj1aQQYjG6wpPf05pQKFodhzcSw3FtwwrlR5ZySXejOIc6gRgI7lkYDloiuErry8Xp1qvomLGRPAYORSuLLnCGoOBI0R9Fq8EDlKW6PCyaGQkXj9tndWiopA5oeOEkMeaTfh+P5j1Pkz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/iIiG6rsEMvLcBVCQFyrk0UHp+zuiicLWMiMUDqMsQ=;
 b=Ng/Df67kxudKcaAKMtn42nGU4thaYWXeQxvuDErMteNHXpggCARwM+DlgVFNUGHpiizHgl8+UqR80/9j8/wkbK0dri2CUlI+HD6qE+xbkkSezZbdHSV0xypzO+2JFRXbpFL3KGgSPGjtXZaB2I+mIaECkTBYEA3UbGiAJIawrmDnueezUk/Bp8LtZOCHGBl6XEclcly8fo2Rp/EhezzSsYHV19MhguXFUZ8QlruILWpU98bZUDEttQSQ/MIl73T3Vuz4LdQMKkTqqEP0l6DpSbkxfoEDesWNF0hXTz8+3lQ7Fo22ylI2UGxbhrVj5cqkom6UpMzlKaZS3sBuKX6Sww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/iIiG6rsEMvLcBVCQFyrk0UHp+zuiicLWMiMUDqMsQ=;
 b=dvN/L78WUPra2v+qIuDYxIXivoZPWsdThvsrN3kY60oViLwzBbKxb9XGwImPfIHQM/3xhKeu4hi3P0rl8NsuqsB16FyDwkcHVN7D2rIVBOejBeRdy1jEQ5Lxeom7Yi1Wsvo3Exb06/Au9NaRPsnXiM1eMzdHn5PggV52oRCAzYc=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OS3PR01MB6450.jpnprd01.prod.outlook.com (2603:1096:604:f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 17:03:54 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 17:03:54 +0000
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
Thread-Index: AQHXIldpsgrgRGdFvEWwVoG1azV+EqqZUrkAgAHjPBA=
Date:   Mon, 29 Mar 2021 17:03:53 +0000
Message-ID: <OSBPR01MB4773E0C511E724307E7A2C0DBA7E9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1616772851-29774-1-git-send-email-min.li.xe@renesas.com>
 <YGBy0LfM5z+8GCpU@kroah.com>
In-Reply-To: <YGBy0LfM5z+8GCpU@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1721b46-7689-4c58-68be-08d8f2d4a241
x-ms-traffictypediagnostic: OS3PR01MB6450:
x-microsoft-antispam-prvs: <OS3PR01MB6450FFBBA906E24385CFA158BA7E9@OS3PR01MB6450.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c8jJsmjZ59kNQwO9IypcUL7LruJ1LMHp21Sc6cki7vI+cJWggTJvQ1OrSjhv7fWnduFaTUf6zlr/ALzVFDKl2rCiSc5gp8V4hg+H5vS6NhEL99WwqGcCFodoCm5GSpRNFOD/tpY397vvupIVP0/P97ejHQnBnJGC2A4L7+ce7OZwNZ1mmtqBq4rEP8zdAcho4OOOTlpffIDbR/RW/rswNIHqalweR1WXCDqSZkeEPL6GvaJtXs2TjJPB2XM5agtvNjaxLwlompJiANNDt48BI/V57YBnd9syeGMPIdvQk481QsGn/QpF0Rcq5SvAQsL8G4XgpJgL3hHAlGGhuRjTxJxYw5ZxOR8JJ2laGTQEAX/SUVE/1fA0K957Zep3GcTfR2H/1s2dXlTyxgOjapu8tBozTrzdmTKnuNXDvmZUmeEF9onw3UF8jE9gm+Oc5XsTZiwsmrMSsqvm3FxhwVngwQfrsLtSl9wuiNETqYYA6V8FfPKeVVrMSSmOyk0gpWEopPjAaCjgbHWizLhmzwyq44ybaZNws5J9AkrD6YAy0qILkzcWlg+AKZeWSl+TEQEazTAzkyA0B8FaWb3b5tNLjKhu1PeO0f+fz1yOX3uhfb3HDURvbuf09/+EIprf1y5en23pSEkji63CI0X+NPzDgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39850400004)(316002)(26005)(66946007)(6916009)(76116006)(66556008)(66476007)(64756008)(66446008)(2906002)(55016002)(186003)(86362001)(54906003)(478600001)(9686003)(52536014)(4744005)(5660300002)(4326008)(8676002)(6506007)(38100700001)(8936002)(71200400001)(33656002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TNpd4H5vHm02Ye6q/NFOdC0DXGuLS+xbJRIv52ADnc+Zl1Ys/f5Vq8TXQ43X?=
 =?us-ascii?Q?ejhJlfhpmO9HwlS6KXrJu2oFouduOJ/0M0ekHb8OzPVc7AdKUjDntZ15Prvc?=
 =?us-ascii?Q?Ao+4plNthxGtQE7s8gBXVZiKHzX/xl35W1U/K9nthY41YodF7cRrtXsJnvxw?=
 =?us-ascii?Q?Pt7rg8/0XGx/Gz7Kx7PtFApVfP1YyATnK9otaM2FfKs0iuMBBZBR86RXUqSZ?=
 =?us-ascii?Q?Q1/duzXJfVvJFKR4i73Tu5TMfpcU41JfoRbh5nj09OtHNcmQ6jeyTiVs9zfh?=
 =?us-ascii?Q?89a0jRIvEteeHeUfsjZEV8rrt/ESrr6j27AVjp7xJE5e64fiRWeLEQV5J2ed?=
 =?us-ascii?Q?It2cCa4Ht9SYqCq8g2tNDbYsogdt4E5psEA775HqbgY9JVLrL7vtbAQ3EZVp?=
 =?us-ascii?Q?7xLtrsXSl7+SUuTZir+7pQZwHmwyiF/+mLw010u87114K4rE3zBw30Lj16V3?=
 =?us-ascii?Q?r0oBMLn/c1v1WZxMzomDg2tFYgSpv6u+kQ3RWNjnHtb6fLqRiNZqEtSoakPc?=
 =?us-ascii?Q?w2dzZk2Uc3QVqeoee1lOvBsWlac645FBaRRFlIEY0NPhTzVa6fSpEh6YCC1X?=
 =?us-ascii?Q?0pqm89VPQaQB3D69/33Nh+zVAkWiFrkIMYvJQqIxVUUsXYzLLMhU/KuAFHXY?=
 =?us-ascii?Q?sg1oLT2JyQ3xIyEsjNxnW6IaJiD96u2WJw8UupHcgXEPaQvY/idO16HLGSBU?=
 =?us-ascii?Q?AcjTkAAZcb5pgzlshSG3xdBOI9ZOvNd+6zOuu8+sLYFb4HXep2tOKzJ772Cx?=
 =?us-ascii?Q?vdCw5Ns9OStPISIFE+ijcyLVRu/MTzAEz17Kpp+LaQcRaXbNrHhObmOb8sX0?=
 =?us-ascii?Q?0Kf8MNilPK7w7Wbb2jor2VvrepyWaizCoIfr6x7Uj4zw+wJslkdopTnFZJtd?=
 =?us-ascii?Q?cAbJZ8Ree0NwT7Ld5rJsY+WA7+4tg3+xANHXLGB7mfL0uV0VkXLftU+RaKxt?=
 =?us-ascii?Q?BZawehPtxhBFOKgakeq7puQLD+cfN6jpndZJo9KoyKBHv5kHEPMt3Xnm6Qsh?=
 =?us-ascii?Q?eTpYR4ZudRSfhAkemGZ/F/mJuD03EKoVry1yb6zH8yJj5X7iCcbBB+gPjNvi?=
 =?us-ascii?Q?Bf460zylt+uX/BilcVP6Y37HGy1yzlNPFykOTITb5c7Cp7exRwPPodavis/T?=
 =?us-ascii?Q?RxsyN7rdVzLuQR+6bVOYK5E0kNl7SQbkYNxiDxiJbk5ybPQn4oKb8CDTsdz4?=
 =?us-ascii?Q?0scJYZzr50jRctS5MoUeLviUYFfDsyUYR/LIUsM8lTjcyyQOR1cRNWVsZUC4?=
 =?us-ascii?Q?EqnSANgYJwQeDWlu/S4yKQ8ZTmBKlc4l0eTOEYYfXS0jPFWde9n4OJJWGhnA?=
 =?us-ascii?Q?EcTN8/Hi1M0f64YWEMu+fqQm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1721b46-7689-4c58-68be-08d8f2d4a241
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 17:03:54.0520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cL3tomWLnJwWf43zaVpBpdfO4yzPuB3N8eVXSRUl3CvOOeJ9HNuD3d+rLcAYywt4PGrFmDKMgsyR39rPkabP1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6450
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Where is patch 1/2 of this series?
>=20
> Also, please fix up the errors that the testing bot found, and properly v=
ersion
> your patch submission so I know which one is the "latest" one to look at.
>=20

Hi Greg

The first patch is mfd so I was not sure if I should send that to you guys =
in the first place.=20

Anyways, I just sent it over.

Min
