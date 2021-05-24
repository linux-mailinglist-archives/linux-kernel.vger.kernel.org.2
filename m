Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1255438E4B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhEXLCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:02:15 -0400
Received: from mail-mw2nam12on2124.outbound.protection.outlook.com ([40.107.244.124]:63553
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232548AbhEXLCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:02:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuT0uKsU8bYVa7vNBYOldcrwQkFFjizw3MphOWPcH5DqbgjHTJeZjxPMIHm0hSt7xzoSM1LXYVJNMwtRtZHBi9OJvSJKn7aVRaiW5kit21uH/ZCF6owK6VlUTK61kyJ8p22hslAGLVpXi+K6q60NDPtI9IkRI8AfnJtaoEwf21VNm+3clFOx6wYBfTxPPgjE1RpI34uAdFzf6EwAokcKTjrK6riMwqm/ikSiLLTet3BOTYzPfoz8s/WpVpsicXeNFoiPqV9pz1/7B83kw4mrkWexvdo2a+grNBxxUCw9S6vRBwDv/lIfOg8p7eEdxVV+LFpr6rQTVsWGFiXdNVfdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnVlcU9zM25biMznX+8cYjdaclvwgWgfkcuQF/5G10w=;
 b=B73Zgkq02DGEQ5Bvw7Niqp+/v30nNnHEat8v5Kr5LorJQjrOrjdbGgO6xc+fjouZEQLzjYAspnSDjVWOU0U7Da6bzAbt9NDVMMfjmqfPSzGTp4TORaP3SoBtP4IQUfheobvNeEBWdhOGbvVcrVc71iiyTrPhS2shf2jp++zwxwn3izNhm/y7JQESWLXmxUYccYhOwib/FqiAA0xFIiN+2TV0TpFZ5S9u9KKBQCzEwI8Pw0xCf8jMT9BWDNzcXrSwQsU6+a9jQvWfeczdu28jikvP9kpyyMmadCZUsApJxVjpveKgtqkOg3qP6lymHW9HtIHJG1CbEuCVsSV4u5ydeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector2-chelsious-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnVlcU9zM25biMznX+8cYjdaclvwgWgfkcuQF/5G10w=;
 b=Hdpd1vRkkaxldf93r2ARi+WH2MQZP8FuO5IymJoIzXH6xy4YQP7U93BZm2hCNAf/f4U+DYnrYhl/lHdhREv9Y0Zlj42LbuANWHJkXqJmQ19iqln8QYntjPnkztLkbnaMHg8xABy3zO+gJBYV8bxf0N/q+XKRyCY2U6O2Oj4LfB0=
Received: from BN9PR12MB5321.namprd12.prod.outlook.com (2603:10b6:408:102::20)
 by BN9PR12MB5323.namprd12.prod.outlook.com (2603:10b6:408:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 11:00:42 +0000
Received: from BN9PR12MB5321.namprd12.prod.outlook.com
 ([fe80::24b4:3771:b03b:980b]) by BN9PR12MB5321.namprd12.prod.outlook.com
 ([fe80::24b4:3771:b03b:980b%7]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 11:00:42 +0000
From:   "Raju  Rangoju" <rajur@chelsio.com>
To:     Josh Boyer <jwboyer@kernel.org>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ramaraju Yelavarthy <ramaraju@chelsio.com>,
        "Raju Rangoju" <rajur@chelsio.com>
Subject: pull request: linux-firmware: update cxgb4 firmware to 1.25.6.0
Thread-Topic: pull request: linux-firmware: update cxgb4 firmware to 1.25.6.0
Thread-Index: AddQi/jxg8aJf9XJS5OKMl+ZpgS8xA==
Date:   Mon, 24 May 2021 11:00:42 +0000
Message-ID: <BN9PR12MB53218D9345EF839962E1E4C9BC269@BN9PR12MB5321.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=chelsio.com;
x-originating-ip: [175.101.22.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fbcb782-57ea-413f-6d27-08d91ea32cb0
x-ms-traffictypediagnostic: BN9PR12MB5323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB53236A0898B1248EC309760EBC269@BN9PR12MB5323.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9QMLyVshpABlJKLLqECEOHMdYv3iVu3Nrp2GgXbI0UqreysOV2NnheWNNRmdYhqlXaHTHuYyPCtF6EkIcNKMLByXgGN69hn5fZ9w0uwjW5xyz6S/M8edYiIEwr1Oiu13OMkxn9UuTHLENKmjmY6y40uikyWHDsjsYhUoN1pqG7n6anVdXpvGf2ZHo7QECNLQ2V0zPSomuRjDbCsYu/InQUgKgfxcnr9A1+SkIIYkijA0RCl/YUzBL5XJOzaAyKTZKG5G6shN/leBjHR9RpI2QtMRpjYrABTO8HRvGmIg68TTAAP4qhS5IVPi+t+F7X2BjK/JJxEMP+wBA0HnzbYDx1tNEsu3rfZ8vPlQ1zhyRRSOVmEcIAqXCPJJVF903hp8TIEcR5NqRfiXIoAJ4VOwG0D1n0v6qhvfXQgSersnGCZWK6xPs5A0R+FqMD+o9UBkGPttWbBaXt8mOxuhqzvKh/yIp4NAcNbJOYFEfvNKVHB5WYAI5u15f7RMMnRa7wAHDHkdqlbrfiAktSZ5vTNBJ2MfsLoA/PnUDdQs6MyjFfjCnkkmBghrC7V5PsrnieiR/vA/HaekNs0xGvZLNh74FdzIYpwC086w3t3wNgrZ/i4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5321.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(39830400003)(396003)(54906003)(4326008)(26005)(6506007)(71200400001)(7696005)(38100700002)(55016002)(107886003)(186003)(8936002)(122000001)(52536014)(15650500001)(2906002)(86362001)(66946007)(64756008)(66476007)(478600001)(83380400001)(316002)(110136005)(76116006)(5660300002)(8676002)(66446008)(66556008)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MtlYFmiCMahWv+14klGqWz8n4yHGD/V6bVp7aL4m92sSdAMeo48tTL27sIyY?=
 =?us-ascii?Q?6Hm485Y64iVKMDfqK2l+G3lb2CmMnWc4yE4KckMDQ8ap/ggrPHMtlQ+de7sP?=
 =?us-ascii?Q?MOd9NCsznsNSKRtLAAd+OclpnPRcr3KtDoXHVMEHic4Tvk7v0EUFWDHUpkLB?=
 =?us-ascii?Q?OEXjbI30DeVnBXxWQNOdaqLt6vLIY4jd0fp5wzXK5QVXJBWHySDVFgr9/gxt?=
 =?us-ascii?Q?pEFryXnWOor57xppVbhm/i0MlcADN+C3lCkNIFsYx8hZrN1E6kYYJBfp6ORv?=
 =?us-ascii?Q?7RZCv/Yi/P7UcSFMRW9DPIwsopOXA4IiwBL0c+Y0Q5+NRZK04koRqXOUXLb4?=
 =?us-ascii?Q?KzB/wfnN01JxqxHMI6j/ycmKb6i9TQocOTg7SDwyP07UQL/h/jORaffKVQoN?=
 =?us-ascii?Q?vLCcm/lLH7xkruay3B+PTi1ARY73jDtM7Y90ghPApBAggLyvEXdrP2xESjIk?=
 =?us-ascii?Q?NQxen6/3HDaimdUL4Ok3+/Z0l7WZCmLHJyz3SOmUlcHnYa3dZ46AvNugPhPJ?=
 =?us-ascii?Q?KtybxLYLyM8ykb313Hp7p9sJEwAiz/wdorugUPvTdJrXRw/rLnZ04522JeoH?=
 =?us-ascii?Q?jz7EY5fSHzCVHxEAXi3hW3M7b/GNuvzVXn2B9dzh7prCJWhYE1jxKvJJtdZD?=
 =?us-ascii?Q?9rbbkI/VdEQeTWkIbRwJZtf8if70NNbjYm/kE/Boarq2v8Ah39A/1LYROJZK?=
 =?us-ascii?Q?jZRK5fyMQVhJBk26YD2LUviuKfZ6uqOWeyiXTnU5oSOvypPuubmyrh/c2mA1?=
 =?us-ascii?Q?RUXCINnEBOmEY6JDXucjoZimXkIaXms+QR2EEIRcjZI3ilXEM2/wcudb80Zc?=
 =?us-ascii?Q?nUcrvM/8h0uzXZMD4a+/ETqqy6InEeqJ/NOE2gKgirVk57w3hGDwdO+5JgOW?=
 =?us-ascii?Q?BU50cw097DYztiG3lwdMuVi5LAZXV6j++5plgAlwIVo00OrxwOiABSb0mPtc?=
 =?us-ascii?Q?YnpjBUPE5wQmSdIxqP5YJd5JvX9KFqPH1IO/rASiwcscGOGkzoNXq/b+fk8p?=
 =?us-ascii?Q?nyIQgypbxeIeu7aiSbOmd7HbzhZ8A7ySOD6wyJ0ocr6k99sf2EMFImWDMCG/?=
 =?us-ascii?Q?ogbBJLuo1lsgVX/OelcOmbqQIZ6qwz+9ZVjLxiiXN5yT/xH/zBNkJZrdcERQ?=
 =?us-ascii?Q?gD0+Sk6WCS3gyvN+TQMZO2gfMvisotfgsOvd6JKj0VA1nIdcHvqO1YqSw0Pw?=
 =?us-ascii?Q?RJGxUHVWqmG8aZUMHJ61JA13AY9wENQ1rCjJmLbM7oo4ZGwokgH2NfXHYWf+?=
 =?us-ascii?Q?KlkvI5LyipBPe2ym/r3KrYXCNK9E/8bJDAMfxAephMdLdZVVzxLghUIKya2u?=
 =?us-ascii?Q?pRSNlZcUIHcDlMN74XYMROP/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5321.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbcb782-57ea-413f-6d27-08d91ea32cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 11:00:42.6663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88mWQifKqzMsUeGuuCZMmfF/N5l5TucXhSwdKQdutNRu1AQJ1jnXXO9p4gRQ3TnqaaUXVWm+IpFjo83Jcn3nDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5323
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can you please pull the new firmware from the following URL?
git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Thanks,
Raju

The following changes since commit f8462923ed8fc874f770b8c6dfad49d39b381f14=
:

  nvidia: fix symlinks for tu104/tu106 acr unload firmware (2021-05-18 11:0=
3:08 -0400)

are available in the git repository at:

  git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to 0c8946d82f059f90199f4926ab55033d8aa9c920:

  cxgb4: Update firmware to revision 1.25.6.0 (2021-05-24 00:51:20 -0700)

----------------------------------------------------------------
Raju Rangoju (1):
      cxgb4: Update firmware to revision 1.25.6.0

 WHENCE                                         |  12 ++++++------
 cxgb4/{t4fw-1.25.4.0.bin =3D> t4fw-1.25.6.0.bin} | Bin 569856 -> 570368 by=
tes
 cxgb4/{t5fw-1.25.4.0.bin =3D> t5fw-1.25.6.0.bin} | Bin 675328 -> 675840 by=
tes
 cxgb4/t6fw-1.25.4.0.bin                        | Bin 728064 -> 0 bytes
 cxgb4/t6fw-1.25.6.0.bin                        | Bin 0 -> 730112 bytes
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename cxgb4/{t4fw-1.25.4.0.bin =3D> t4fw-1.25.6.0.bin} (75%)
 rename cxgb4/{t5fw-1.25.4.0.bin =3D> t5fw-1.25.6.0.bin} (78%)
 delete mode 100644 cxgb4/t6fw-1.25.4.0.bin
 create mode 100644 cxgb4/t6fw-1.25.6.0.bin=
