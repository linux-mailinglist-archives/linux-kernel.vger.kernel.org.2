Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1701D364711
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbhDSP0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:26:10 -0400
Received: from mail-bn7nam10on2113.outbound.protection.outlook.com ([40.107.92.113]:63712
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240257AbhDSP0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:26:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHfeU/mctEiQo29oAxHtUcN8LKJU1nUpWpmpW8+76aJLCMcg4nG5CLKJj0A6ttav+dIHNvSQPJryLcbFoea82lWr0zttR4AcLau++0P+2e4Wj/OWoimi+a50MB5RR2t+QeFPPmmKYzXUwl85jYCAEptqF1ByAkichps3e1EY6Z6rZ4vECRhC1X5akNDhCsDivVxWqO1XTKwUyIhUAVVEBH3gJE4kyKyjkDY7/ITVKBs07/K8lMaNVkhpdEyGclbHp42UfbKGSaxzU1CgENRugcnmK23aFlFxLK5pwxpeRkcJ7Ti54rGcm5KumUsqoU+szWVUz7Ya0TV/u/LWEGdvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbjl4kzISVsX8BIwdt+eJA3Cbn1LZXrf10kie6HuQp8=;
 b=l0G6XK/KZPp9MPcykWbZUpAw++eWswiCtUlM14aNRrdTutH+Wib7DaBaM9ythbwhKTusn3hN6Sy0BboW1PzJn141kZ0zuyN+Kg2GnQjyeG6iw1wFnMSTt2fHg9HnqFB+qxTYShnkegcCvmTOifwFtlbbIFZr3ekpG5Jf+4pD+KPW9T3THwyCq2Lw44bV/5fXBykDaaQ0KgfUGk6+/ocYTyJ0ID4ZmjPZrgpr7ewNlniNMyPGTJlXRr8+Os1aSkweCa/mrD/jfxmWGEgqyWH/y8VZ5aLR46g7/BLdyjqLRJge6DmZdpFD19LCIrlHp+JlLuxG7Dza/ZE3a7f3qBa7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector2-chelsious-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbjl4kzISVsX8BIwdt+eJA3Cbn1LZXrf10kie6HuQp8=;
 b=CiJka06SznpT7/kC/RyYo8z9ECufbtx02PSznp7Ce9Q9euGRQML0uutLJd2DtWOLDZckqQo+n4QHhjogLQHN1JS6n+MMaJBtuZpzoIHcjoomTTWUt0+Mr0+SS083k1V5HRU3N8TakdFFR/OO4ozgncTgaCKapYFf8H5HU18CFJc=
Received: from MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24)
 by MW2PR12MB2490.namprd12.prod.outlook.com (2603:10b6:907:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 19 Apr
 2021 15:25:28 +0000
Received: from MW3PR12MB4475.namprd12.prod.outlook.com
 ([fe80::f1fd:22ed:7fb5:983d]) by MW3PR12MB4475.namprd12.prod.outlook.com
 ([fe80::f1fd:22ed:7fb5:983d%9]) with mapi id 15.20.4042.018; Mon, 19 Apr 2021
 15:25:28 +0000
From:   "Raju  Rangoju" <rajur@chelsio.com>
To:     Josh Boyer <jwboyer@kernel.org>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ramaraju Yelavarthy <ramaraju@chelsio.com>,
        "Raju Rangoju" <rajur@chelsio.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: pull request: linux-firmware: update cxgb4 firmware to 1.25.4.0
Thread-Topic: pull request: linux-firmware: update cxgb4 firmware to 1.25.4.0
Thread-Index: Adc1MGGnWqtpVbc+RF26pl5D8XhgKQ==
Date:   Mon, 19 Apr 2021 15:25:27 +0000
Message-ID: <MW3PR12MB447503341F6A5ABA178CD2CBBC499@MW3PR12MB4475.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=chelsio.com;
x-originating-ip: [175.101.22.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ddfadc3-291c-4459-cb2e-08d903475c9d
x-ms-traffictypediagnostic: MW2PR12MB2490:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB249005BAF09E0D10C8CAE276BC499@MW2PR12MB2490.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JZjlmuzeimw/rTadyRbDdAubhm94Svxv7JPyHjaWGBcRrUDswjl/BDq4dpBvb2d6TuUmNSTD24cHTgnyzpusJCVYLQiKOXhmz9s2BwGB4SvSWkA45Hc/6cMKIzHlkaXmV6MIYuHFjWIZ+YuKjjEcY6TIgdlDnSMsiXo+WDmv9Fc76mQzPAR+8duPFKJLJssO4CSKYYyb45BfaDkfhw/Vn3dP8BBGH4GHmYY5YlYV8wblY7bTO8/mjJNVZei5pOO7AUvOEmlBOV5uWXxKOfwq+jErC9h39qaBpLp1gOdUofsly7Pd+jkXo8YhFY0Zl78JMP1gSWnx2cBM0n55N/diefbQS1dcphhIcssDW6eAcY8Gy3HWdU0hnZdhz9/Y9lfqhVl3RtvDGYR5K9w7eXXWFg1Lzv+r3N5ln9/WhhPHUPf3lcBUEDVc1s7zl7GYK/rVVL6D0MyIl09qlFzRZQ0TaS0Rez9L6TYiEy0TqoocXnIXpSVj8Ntj8028sIh/icAjbAPRfW2f6+uMCnB9uCiPt0nLaj/u4zhX1gYwaNmHsmDlsEgj8UQu08YTdhPMVKbEgcQPX/eOqwjvNC3bpKWsBr5FejBB2D/Jx4Rv6VjKV9c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4475.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(136003)(376002)(366004)(396003)(54906003)(316002)(5660300002)(6506007)(71200400001)(186003)(2906002)(26005)(4326008)(83380400001)(478600001)(110136005)(33656002)(8936002)(107886003)(122000001)(66556008)(38100700002)(15650500001)(52536014)(55016002)(8676002)(9686003)(7696005)(66476007)(66446008)(64756008)(86362001)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ocwn31MGnz6IhF/yPRydQQ0C20xaZjVhqVtT5PacDpQod8msZG9sfqf+9uKr?=
 =?us-ascii?Q?y8GiBl4SMS9jOpldAi9WH0nnutfmoZsszKCgPr4TPs96a4bhUm8LY5R/ELih?=
 =?us-ascii?Q?xRRCcDNRcKpm1tlVcxuxJ2zzbacCxOA0jOiJOY9446QC763hKnWOqkJb7paS?=
 =?us-ascii?Q?R84Orl3pdwj0P3KH6sLK1ahHfAX9uI5RUMPvbikuH3CWXFDpe2oYJH6rNbdI?=
 =?us-ascii?Q?idOYNmWgrZyjABBMzYUCsA/iNShqt+EAhePEt70Lo+inMw3vxXxn3XN3bHuq?=
 =?us-ascii?Q?2K4BULQeRfqs8BuOYSD5CtuEpgMFBJVV6sfwHSTw3ek4ah4IaMtDk5C60dro?=
 =?us-ascii?Q?olLp+FY8PaVQAQ/a1IVUmp5qyQhaZhVfRt2a44WDUnMp5lRTkgqMCmUVA7+c?=
 =?us-ascii?Q?rpZDXq4SgqJWIj1+L7lHWLoPuxal/Fxvn7ap2sSor1iu/sFFVGAs+V48mthW?=
 =?us-ascii?Q?+GzRGDkOjyOXmpOcdL2Fpr9tjtJJGhzzONeI8zK5o1VnpBneLHS1vp5H1223?=
 =?us-ascii?Q?2sDCGszS3Nt/QEehPysJG69283MaVbOBZ/1lYuesuBZrDZ2xJ+2n4S2Y1yfo?=
 =?us-ascii?Q?Dogxq6hF+BDbMl+v2V/bVXWm4qMyNG1TfXCwr9yDpbJXzr9Z1dklfL51HUSw?=
 =?us-ascii?Q?ViZloFc+d+sGJQIMgP7aEbbb4aNqzN5iDgwrdMO0KhVJA825TUeCZHbmsfaK?=
 =?us-ascii?Q?0W+rmdZutInISNJwb7l/8jXW+9yDTe/CfOdQp7CASm59/KctcODvpxTLjWS8?=
 =?us-ascii?Q?fG2P44mPa9D7N/ynJzUwrbsPNn3SPtlvkEBeqP/URJgI4CRKPI3Fodq6k4Y6?=
 =?us-ascii?Q?ccB9Jt2XD83Bn6ZUKRQE03zuun/sE0IESHZlq79nxV7u132Uqlo6L2C7T+Y+?=
 =?us-ascii?Q?rJKaH4LX9jYy4xgljHoQkibhEW5/BaL761CTy/uYk+JmVmGmg91akTa1BAY5?=
 =?us-ascii?Q?wHJGMZEB8O2lgReN1aiP6jaKI1oEJOMPORtBY2Zr9kVvr7W/gFoJZel2Ec0V?=
 =?us-ascii?Q?d7HJPRSgwP35Ggge5yBC995CkqyzR1UiRzrFHtY7YuvgFMVBc5gzlMlsMain?=
 =?us-ascii?Q?cnjSL2GjFnpu0Smm4ZGQ+YADVS+ZF7+eML/OsdqaSvr5rTkkYz0DV45JcUh2?=
 =?us-ascii?Q?DrqT7zqprOp3DPIfq/W8mQr321dtWJUUkEH384p9Brt1TGFF5dkBx78xViuw?=
 =?us-ascii?Q?cXPkG8CrCzZ7EDOZaDXxmC2YnHySxrgT9cbMIRvd5yWjQwv4WnKMAYAKrgg0?=
 =?us-ascii?Q?+SjDWHFedT8mW7U7DotTKewNK2H/CDVcm/9RAUGOfAWb8t8pXnabfsAtpwAH?=
 =?us-ascii?Q?GGEoewKsWdb8GWSVfzC0im9f?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4475.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddfadc3-291c-4459-cb2e-08d903475c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 15:25:27.9837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+i7ogCtNw6DUpciulX9KyIlIE25RZoHdo/oM4i9NTbzDSrxCbtuOBfqyKuc1xCfmFTa3CitW5I/31Hfg3y7cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2490
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

I've adjusted the actual file entries now. Can you please pull the new firm=
ware from the following URL?
git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Thanks,
Raju

The following changes since commit f66adc3cde7ee0607ea9198ca460031d3564fb33=
:

  Merge branch 'main' of gitolite.kernel.org:/pub/scm/linux/kernel/git/maks=
/linux-firmware into main (2021-04-19 10:07:57 -0400)

are available in the git repository at:


  git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to 940b7f42d45de247eb9a2c4874985a400cb936c4:

  cxgb4: Update firmware to revision 1.25.4.0 (2021-04-19 07:44:20 -0700)

----------------------------------------------------------------
Raju Rangoju (1):
      cxgb4: Update firmware to revision 1.25.4.0

 WHENCE                              |  12 ++++++------
 cxgb4/configs/t6-config-default.txt |   8 ++++++--
 cxgb4/t4fw-1.24.17.0.bin            | Bin 568832 -> 0 bytes
 cxgb4/t4fw-1.25.4.0.bin             | Bin 0 -> 569856 bytes
 cxgb4/t5fw-1.24.17.0.bin            | Bin 672768 -> 0 bytes
 cxgb4/t5fw-1.25.4.0.bin             | Bin 0 -> 675328 bytes
 cxgb4/t6fw-1.24.17.0.bin            | Bin 727040 -> 0 bytes
 cxgb4/t6fw-1.25.4.0.bin             | Bin 0 -> 728064 bytes
 8 files changed, 12 insertions(+), 8 deletions(-)
 delete mode 100644 cxgb4/t4fw-1.24.17.0.bin
 create mode 100644 cxgb4/t4fw-1.25.4.0.bin
 delete mode 100644 cxgb4/t5fw-1.24.17.0.bin
 create mode 100644 cxgb4/t5fw-1.25.4.0.bin
 delete mode 100644 cxgb4/t6fw-1.24.17.0.bin
 create mode 100644 cxgb4/t6fw-1.25.4.0.bin=
