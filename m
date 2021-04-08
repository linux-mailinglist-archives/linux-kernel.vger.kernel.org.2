Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6653358D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhDHTk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:40:57 -0400
Received: from mail-eopbgr1400119.outbound.protection.outlook.com ([40.107.140.119]:2848
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231451AbhDHTky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:40:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcLijXxGl6Asa2mbxLLYqsub0yvyIDweJVxcIaaQp3y+xZ/aMOUi5Qn+AD/ipzotep8s/U+QvSXb8MzdScM3g4XGtrmOGfunX8425rzeLekFh7HESkgC5BrKqky0Ldp09tKZ0pXWZCYlUnRlzrVA3dJ+SNBdgmtOi74nNita9e8pdp9Cj96wMQieH+O8i0RP9+GV7HaxMF2YMXNJ4OO8j1A0mCaHzI/8iE2Cm14VsXvNzprMY5ET+OwT1tpAC/ifXyTqJtFSh9PcXqK+PS0kwccwUW2fwrFMZe4CEqIkBgfUN3qtYOOwPY6VSZZlN+w2HP2VjCYzfEZcbh+2ywPJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdZ9/q1IVgOhxeQ1wHjERbBsZ8ziE2Dsbk6v/bE3oBQ=;
 b=FDqfnGglIlDqtmlUewqVwIPscLAIJBt1Dxw9bFhYfYPxo/MmNHH6/bVGjXDxP2JiaKG1jJSLBhJWzmba3U0AarIf6J4qAdQ40Cnxm7Wt1jx6cviS3a6dMqmsnVtD/HnVy0X5w1QvcyoMsjwrTf9Si6Cdi/hdnFJSuf8JLULIeNXSI1HDvjukkmMvjQOO+CkGQVgSchD6rj034y1XmjYWGz7si1P4zQrG5oxRfrEf0yOMGJ9m1xg1ISU6CWmIhetKVTugiaLjTAZwaT75cv1u4ooG6+0AlCJSe6jRMSBEfTHG8OvpSgutzP4UDiZ5UCMdqdolvP1IUlPz7rBQ+5wdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdZ9/q1IVgOhxeQ1wHjERbBsZ8ziE2Dsbk6v/bE3oBQ=;
 b=ErQmCxZDZDyLJ7Diypm064PQOrrIQtSSv2+O5SNq4JAGXkamDA9MRuCVCUL+GB95hDrtHAU1rmFs89OgGByynFJgMeawQ+nWsby7vCT59TA9g0rgUsiwc8ZxSiWpAP5UMHX0GvLKL/lgJrBLqoo1ykI78FZ4P62Nvj0//dv/OiE=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSAPR01MB2194.jpnprd01.prod.outlook.com (2603:1096:603:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Thu, 8 Apr
 2021 19:40:39 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 19:40:39 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Topic: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Index: AQHXK9TmRDzfnJqVl0Sq9GK4xidseaqpU/GAgAAY4uCAALnLgIAA31gw
Date:   Thu, 8 Apr 2021 19:40:39 +0000
Message-ID: <OSBPR01MB4773506891BDB365B7A338C6BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617816815-3785-1-git-send-email-min.li.xe@renesas.com>
 <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
 <YG3vu9XQ94w5dlbp@kroah.com>
 <OSBPR01MB47733C009A6B6F2F697E12ACBA759@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YG6gdRiEkiYxKKm9@kroah.com>
In-Reply-To: <YG6gdRiEkiYxKKm9@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb842013-b6d4-4b1e-0885-08d8fac63078
x-ms-traffictypediagnostic: OSAPR01MB2194:
x-microsoft-antispam-prvs: <OSAPR01MB2194DAC3D98555BF7B127D3CBA749@OSAPR01MB2194.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jQT0WZuZOErVqjpiJE1RRI7m/aS8IMwOnh3X1y12XCgiyakiwbrjHDwsCVAH9OzrnWK5xosZ+evfUbuYfI6mbuk4LAZlCRz3OVEJ+K40CTBSmsdANd6qI2JBUfoz9+eBiI7369eld+RhmveU0O6rhgxVPIMxVqsk6MPYyDv5V/XfIFRipLRVJzVddN8YUU3iwaWjFwWLcss49rSsmrZO9rjmK+JF6nZj75zn5xonkt7yOiDA/uH2lhaz3j5KO9JUxwNQo9eglL4OGqOxDdqpxo65odBNxtqGYiA389sKC2RwHZ1ffLS/F/wE2eDuxM9BiTrlKTvlgP4iMsRV0XJH+N5kS7/NylW/mrsN2Cg2hZyxA5o6RccjSv83ZEa6+4pxj11oOENBq1jv2Eu4MF3kkU5hBDlYa+ujn30FKTeZ7bwOUiAWyzt9b/qaKYg2G0f7WYeTGDCt0FnDVs7We/RQFvyEvs4RalskdL6WnF+PDZnbUuQFr8rvUaJeajo2GCjykfZVhqBBGm0ntU/mMXqEm8suNyKfMiG0PxjM9jHx/Wl38mwQ9hVihbBD/F7/mOtGArRBDxsIjQMtg2BjFl1BRzmX++Nb4GJvnBRhoMmp23pjwvForlyTzdNkqnUqQV+T3+ElpB2o7/g7vpIYpdqkO2dNOjiutnTYgJRhR3R/t40=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(376002)(346002)(366004)(9686003)(54906003)(6916009)(316002)(6506007)(55016002)(478600001)(7696005)(4326008)(2906002)(66446008)(66556008)(66476007)(64756008)(66946007)(33656002)(76116006)(38100700001)(8676002)(186003)(52536014)(26005)(8936002)(86362001)(4744005)(71200400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Pj35IWtG54vhukKpr7JZExte+l07JtLR3sqZs7BXCUC3Bp/Dy1fRIGCQwGzw?=
 =?us-ascii?Q?6dBJULVY8uU8lbLzz6Dcvzhf4FrXWVaR8i+CXAULvAzdQ3fsu7qtjSzSLUvL?=
 =?us-ascii?Q?4yAmBSJ1GxtLH4HwI6EvzowLxDrqF3JmV8fN6SHh9IkMm1WICPcpZ04yPiEK?=
 =?us-ascii?Q?mOImD3qbCGa2ux3TXlgxJ+ys/AGDq+uuXtsc2p1cp/AeAT0vqxiKInrIph8e?=
 =?us-ascii?Q?iOS+oAWvIpGuXTMzxVXtS5fh0YT9nyzLdnWXSl/t8ihnocBFnH10Nm3Oj6fu?=
 =?us-ascii?Q?IexbVgzNg3EcFC7MzJt+rKEnylsJ/W/j/+YsenuCG5WZdTl1dky0yjfRflXx?=
 =?us-ascii?Q?3WjSV9+DA7zUECO7VHiQq1fK+IscD4nJYIoq95+rZx8Pw4ncaX1T0/xEMh50?=
 =?us-ascii?Q?5i4Kp4/vrkOh6K1Zy2kHIuLWfkMs8g7RNeDn67F6DckmD0W2jH2oZIsilGdT?=
 =?us-ascii?Q?gNmXeiibrUCON+GC4D+sR5aJKjC45FEmgnRKWpbsclz54F5jRwqbfbnZ0Dhi?=
 =?us-ascii?Q?jFNf568ZoJUCfwfkbTRfM7HKLORMr10P/7j+6kAO9vnvxHofAqkBKSgFZZB4?=
 =?us-ascii?Q?yBxrprWeZB+MNLstZrnvQms8q+KE+ZHlyGNZX3dRUhsFG1WsBoJh9Z5UaSfg?=
 =?us-ascii?Q?fUE8b5R6k1hCWn6BW8/qTzB6IYEmTplRBi/OnEeP9FJAakcDA7QcMni/RS+i?=
 =?us-ascii?Q?HJAmKUEMxyKPnv0CPSytzqwCFmeF9e7za5XX03XuZpRbYqgJSUsAYAUYxreW?=
 =?us-ascii?Q?0vFMiqF/ZYtDiuXwRO1WpnJyvP/V8eVUwtbT5LrMQCrXnIADtDIGL+m0pJyY?=
 =?us-ascii?Q?FQp7jrHOF+3yhw/XBF+EtYrLC5UPzug2BQqMB7KSi3AIDlREq158YZpcnr6u?=
 =?us-ascii?Q?MDaUMLdpanqxuQQ3680n79hm5H+uu9ACPuLT1RO2lFGBqqe2NUTRO6P+7mgZ?=
 =?us-ascii?Q?BhU3sEFdeX21iB626Vnd3aW/0YDEIk1fjKav3JSD4pXxrOw2ATjwcenYjU9w?=
 =?us-ascii?Q?lzIsSqO0n8oAJQj12g0HL3nQVT9UxhEYI/dcBFFFqFp2hMH5XPGatxYV124s?=
 =?us-ascii?Q?VRq9nFW++9p+ZEFX7HYwQ3ri4LRx4ELM/muyCkNYSI/qaARb5PeSBtJ4NC9o?=
 =?us-ascii?Q?YZbLI6it/RCgLpSO8fX/NeqIxS3uwuSAFFf2X1dYr05vBO8ENa3pJJHxl4DZ?=
 =?us-ascii?Q?pRdDfykQ/33yXwORjM04ApeTjGepNKMcZIu2WB42I6k5a5tpifEdqXuJPxIt?=
 =?us-ascii?Q?FiVLYIOYDkHPdNq2YVsPvdtGURMVLt3EiK7zyo8q2WBeoZtKkxNyQXCTiIF2?=
 =?us-ascii?Q?CYtB84GtaFJTW+zsYrDBO9Cl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb842013-b6d4-4b1e-0885-08d8fac63078
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 19:40:39.5287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NT36dchdxD2LCtXk4dseen0jrtqs/ia1/mFDT/+aEqBB1uI8VqjW3sniAUeyfM3AwqkPt44ZHNK1fiQPjwbQhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2194
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Please provide some sort of documentation and at the least, a pointer to =
the
> software that uses this so that we can see how it all ties together.
>=20
Hi Greg, I will withdraw this review for misc and focus on MFD part review =
for now. I will re-submit the misc review after mfd change is in.

Thanks

Min
