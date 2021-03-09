Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD7433304E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 21:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhCIUxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 15:53:15 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45802 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhCIUxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615323188; x=1646859188;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=b5Vml/wJUYJtLl3eJrkv4qbilOP32h9snnqa2oHlGKM=;
  b=K4BNQQ+Fn4RClanMIlTG32VElw19TZucrFNxpeGI/CVy5FFYBxjdXx8u
   cX5Hw13mLQImU/d0OmZ5kVZNRv11xb4qfmqmeLwtCCDLsYJbUF3vysoyO
   MK7FSiNA7s3/NQb8a3r+bFLpSJNkBI/FJxvNBHYHJ/Utscz3+0QQ/NKab
   Mf11HtAERYz0nh6ZqsxuIvoqu9owKKukUhwZzlv8HRzebikszNTYe+SAu
   UN07P/kz8xo26XRJVr4xdMs4tyhqdf6I1XnNc3ZgAj4yrc48LkwSyB7ng
   6BU3or80tb4Lp7LHGJeNL1vJsuSj71JILC4Xb0IA8ih67RqNBh6YTwahf
   A==;
IronPort-SDR: v1ohDlzuckikFGKLuaGfmbaoXb81ywFZ6ukF4ty6lK+2Bg4KPJZMQtOMahrXUFxpui1hwmwc+M
 Iqd/923lHkcEQYe2H7arJD6EGAIcrnSTmc1IudIf9NqsDz5fBgbzsaX6IUi7FCHHgLry/SJouz
 SaExd6TJhn27u45kBOWSBp667WgvE/SyxjkBPjveexWILOl2FzMnNIpmd//dVpxnwH6p55Jx1q
 y9Pblt2c8KoS1TiSA35rd9OkxtdVq2/UkeoMosajq42XuB6iD0HihY5zfUX+ZVkPXlwXMmPMVo
 vnU=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; 
   d="scan'208";a="166253177"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 04:53:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1Hs7QrxzJj7jzgiMPSganqzb5WAFCyLAwS9sI82qZ2HmNwFQx5OKf4OfqgZZkq6vUoE1BUCkMRvpPxPPzJ6JMduE7d387J5jxWDUwxDJWxOxWqTh58zhcYWFT26BWALV0R1080qM2ByohWEgnXvULfE8oApXKnZpXh/u8SATJEOPXNoMkwRRNKbp1YSjXGgem5pTmNqag6UUP42iLTB0QLkYqv9G86owx1MM9PKwcpJp+lUdwZIBa2BkqqsHsmlORJ6m9rgSm0e0yWh6Mf++wrENYz8RlBXHRafQR33TpeN+Ka6DZFodd+fHSq120Fg2THmFtaPeglAJtR1IxT15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0RYqcm3bxtl9MqBgD4GoMZKQcIQBEDADKePeHqo6k4=;
 b=ZK1ynsRuUPtwu2mNjqRaxxiDkrET2QaIp52KMKpDKP9RDh+XrXXkdNWvB74BP0BM8F8U5WViK152xtorvgC20C9eRUAPM9/v3RDLzZLl9BV14uWGnYAsd8LgPDVaYhLT+vBjL97jJac7kMIPjsc35ZBLbfWdcgPh0uGqQ+FwW0DCjgAAU6287BUZeBtzoPeNpkQmiKmzPOAwqWxfyh/KR7r3OU3GakuVNGQGD+BsSuFF5J47uKnhqUKg3eAJ9cOl2Sq2KNk94GsaoBPZRqj05HB9hGzillcX3kO36UaBc7JhOzzoAbbMdJ6yF2jTgBiIxXB16mbl55+X/21Is5kOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0RYqcm3bxtl9MqBgD4GoMZKQcIQBEDADKePeHqo6k4=;
 b=iqgyiI0cEEkOx72pU6JEyGjeCkR8iK3Od7hNnvglwosWRP7ObsM89veS5PBvDA5zvygxH0BwIkIpj+9XgA6TDFvdoEg2e+j7wGCgFAczXzNV+Tt3cv9RarZMaL80LEeukDS06orrRUFGaYf86i/tXQoClc4tzu+Gd74vTOGTF3s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6246.namprd04.prod.outlook.com (2603:10b6:a03:e6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Tue, 9 Mar
 2021 20:53:04 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 20:53:04 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        David Sterba <dsterba@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>
Subject: Re: [mm/highmem] 61b205f579:
 WARNING:at_mm/highmem.c:#__kmap_local_sched_out
Thread-Topic: [mm/highmem] 61b205f579:
 WARNING:at_mm/highmem.c:#__kmap_local_sched_out
Thread-Index: AQHXFSYzFuXtH3VipUunsYPiONIoZQ==
Date:   Tue, 9 Mar 2021 20:53:04 +0000
Message-ID: <BYAPR04MB496507720FEEF2B77FB639E186929@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210304083825.GB17830@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7c13836-ae81-4bde-f954-08d8e33d55f8
x-ms-traffictypediagnostic: BYAPR04MB6246:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BYAPR04MB6246382876A13DD2BFF5492C86929@BYAPR04MB6246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xqtY5WxnrSa2D5mvzt0h0IJfqUhK0yEEdFTOnIdVYzFDq3cPqSHI0EMa+PXIzHB26wud2H0+BXMy+U+Gr51pyRLe5pKBrXWaAL22BtGPY4gw+sUhxDyTB1niAOd1H8GUZbpgRFSRFSysNJ2dqM73vC6JmaSKJe0Kvvn/KMLfIVVAeiajF+MGMAAkI5EC2c5FgDSE1IgdwA/RJJFIipx8jPo0gPtT+GCHNpNREV1M3RGN+PmgsUUunbo+j3tAoDE7TGVoMHcLL5ohpsSx4TD+Umg/98Af/XMKbAG6E1POkl8K4PhYwQWdS/RtRzjIt8BGGm7yqfoJPn/GKWP4QaOFf4oPI3P0fYWUSgXO9liqi/34TEFNoWS6vJO0YSxe1WguiAm/iAuzbrSMcf3t40MnNBfQ+89BKmGqGm9dHCCYs9I/jbiQB9KD6Ivl7LjV/mpGILUWMgnrl9MYiUsepHbcviuDneHmacOcT10Uyonrj6CyKdsR+8D5u2ji1/kcNitf25/oJIal7zSNghxbwTv58wZ2SFDf+GWzjAgR5sd88fK0akJ/XprydvEic03zRoiRroYtydHJOHKe1EpZiVaSsqWHc+iRfPYpW/qPuGiJPo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39850400004)(66556008)(66476007)(83380400001)(316002)(478600001)(64756008)(7696005)(55016002)(186003)(8676002)(52536014)(6506007)(966005)(26005)(54906003)(91956017)(76116006)(66946007)(66446008)(33656002)(9686003)(4326008)(6916009)(53546011)(2906002)(71200400001)(86362001)(8936002)(4744005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AdvwBh5ZddT1SmHIYSK8CGUQWP8Vyuq/QLpaM/NClFJXJPHyRsxsiEhUmJzY?=
 =?us-ascii?Q?M7UxP6KHuXrluHT3Kc40TO1Ns45vEL0pXTy5sR7efbUiloV5NJHEwKmvjlhJ?=
 =?us-ascii?Q?HiGnTSaYCM4b56LLsMJG92HblUBEBJy/njrwSYLkeUjMMccfC/ORVZaVRB/Q?=
 =?us-ascii?Q?3b4h98RxS6SWuTUlssK1e3ME4Iu7qLH9aGu9PaPMt0wvXtPjs17gjdrCYdML?=
 =?us-ascii?Q?izuEHcXirLUgP+S4Gqj3VEy6gC8xWE2cZzbgLFq0Fh6pzdNOUW5orvL/YnKx?=
 =?us-ascii?Q?VKSHWHc/UW0uxW7Cnb11+I+hEt6Axmn/odg9EOk7UwVmFQiuDOpMWHkHpFlA?=
 =?us-ascii?Q?ivrP+NjJL8f1gbsp9l6GE0UHq4C37OY8Gp0c9eucLH+Z2IlQBRB8jFXfPLSe?=
 =?us-ascii?Q?wr6Nx7DjSivz083y/rwPdd6UXs/yLy1ifKrx2ZUUCg8AQPpOEQ9ITOyFlzq0?=
 =?us-ascii?Q?woyGIDY/OnQv3KBP9H2NYHZxOVebQc6A69GIPcep5KrCyNo3okje3AxX/AtL?=
 =?us-ascii?Q?YxTIbf8XUEccpg5gg/pSb0EwxBoRTiCZHQ+zwt4dZp2ET46hD7tmIaxhXty2?=
 =?us-ascii?Q?KpCbDSzn1uRg/HTKiInpSoyFGVZCCkSAr1FAOq23c//aZSiQPojGRqxDuMEw?=
 =?us-ascii?Q?qRceheyIHCVLmBkSMf9wVMEM0GL7EOU/3M+bCSidJuyuo0qyTPRQfGREdQcr?=
 =?us-ascii?Q?0DdU+OPfZyr/K56kifRl6NpsqFs/VU2QV4w1xKmsFTovWeiW+3DS0hkZwDVE?=
 =?us-ascii?Q?tZddWhuaEhL6to4UySoA/z3wfTjDMPVjskYZWV/arAs43fCO4uBq7CJzC43K?=
 =?us-ascii?Q?o/1/1x1OnP3N/B9ucVyZyfFa15dw2ut/UPow9FMQRspUOlNfFUz/vaQu6JkS?=
 =?us-ascii?Q?0vs0h4wGSVfUXNlrZCln8U7RF2H+jlvN6C4ecbzpmKz1v6Nb7xaDCwIs79Hx?=
 =?us-ascii?Q?0RI3uN9mDF8L9ONJap5x2o5n929EWXv9mzgwUILoAw+OykZGleUniwVqVgLy?=
 =?us-ascii?Q?iiSnJewDfZJEowYw6XhCwN3WEeOtvOL2UY5booB8vRcgZrhOiotG/w+m4yS5?=
 =?us-ascii?Q?LqrTwT+BSRGK/5AES1lepIzHT5m5XXfvR0mw9FiNSHT9AKDRDi/5CoquACjU?=
 =?us-ascii?Q?wAdntNbh5189Bab/AzL7vT+74HuU3gQFXDkl68d1A1kUUDOj1pCdBRQkNv+N?=
 =?us-ascii?Q?0pL1lMLnnLb0nP9EwVDh28dQoQeh1EIQNmGcWPnuzHus2IVQ1AnUdVYpj2qI?=
 =?us-ascii?Q?2VDGpkcfb9AxayG5QQl24f7A657jnLP2M798dlaIkbAssjGI3KyfEQr0wwSI?=
 =?us-ascii?Q?Su1srtw1vwCYDfSyQQPuOJ8E?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c13836-ae81-4bde-f954-08d8e33d55f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 20:53:04.6796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9n3362ORFM/tF6qge8H6MT1xSLbBDbLI2gF2ppeHmVoeP2Og1QTsTgituXsRfNWq8I+/vPxnmgCUAdXUTxB2BVHrDm336pXMW+K8aJrjf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6246
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira,=0A=
=0A=
On 3/4/21 00:23, kernel test robot wrote:=0A=
> Greeting,=0A=
>=0A=
> FYI, we noticed the following commit (built with gcc-9):=0A=
>=0A=
> commit: 61b205f579911a11f0b576f73275eca2aed0d108 ("mm/highmem: Convert me=
mcpy_[to|from]_page() to kmap_local_page()")=0A=
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master=0A=
>=0A=
>=0A=
> in testcase: trinity=0A=
> version: trinity-static-i386-x86_64-f93256fb_2019-08-28=0A=
> with following parameters:=0A=
>=0A=
> 	runtime: 300s=0A=
>=0A=
> test-description: Trinity is a linux system call fuzz tester.=0A=
> test-url: http://codemonkey.org.uk/projects/trinity/=0A=
>=0A=
>=0A=
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m =
8G=0A=
>=0A=
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):=0A=
=0A=
Is the fix for this been posted yet ?=0A=
=0A=
(asking since I didn't see the fix and my mailer is dropping emails from=0A=
 lkml).=0A=
