Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAF9349181
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhCYMGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:06:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8826 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhCYMFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616673949; x=1648209949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yzkpsYePFnm26sc3naxIzygkVmhueg3a+PclWhAcGIE=;
  b=GheadI5EfY6nlX1VTRHi/USYU9/omZdatqbfMEtHmrHm1md+iLhZO8S0
   glBs9DX4ZpeiR7lEvRg/K7gjumfdKN+9750s/8Q9eIVkmX3MZDaNPksnG
   X5BEDyPUkc8icdCb/F1MhL/I0LGbmaDujubKBY6YnzkDALLHkelM48N0Q
   nQ8GDdL53Zt5qt3W9mk/N9pmjOkF3M2WSGAN3s4LvrPUT+pWy8go5yS78
   WAjF26oiKXugA1af9VnwZxqq0lFD6H2u+hahxBpMulFO56zoqhCc7ZIy6
   /MffhHbTgKieQcQdk1CnPtuNAfk14ABxPBJKOSnxfvA3QaMMl10DqTVUU
   g==;
IronPort-SDR: oxCyX+o4U5gTG4uEDYgKCxacBLB8n8o+niZSf/37juiAoFAsghTAHL8hGvJQ9a3NvSXlnNioSI
 5tYSuY/24MFfdaYpikF56S2w8dHS17ajqucdHuSwQUO8T83m5JRvqmxIJGNYkovDHbJ/YDQcOa
 KNU7fU7v3B5BUroUOX7Lse8H8RgorS9jU1mvYSrtp6LWH9IUzbprXJn0b//Hbsf+WYadOYX7jO
 8m8ZXUFZUplbkxP/o4yyv0avSwIARaoRMXAsmT32My9pwDzSsAs9Zteu6ooVRt4Y8CYb2djsgm
 2J8=
X-IronPort-AV: E=Sophos;i="5.81,277,1610380800"; 
   d="scan'208";a="164099165"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2021 20:05:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wg7QAxFq7xoajvE+F5owlW6ll09JcpURTPXyMmKNmTdPwI6/K4WKs36yYKHHny6DKx1HnuchM5NXLt0zviLxtpHvlCoNVKjM6McIAbz0CBt/5oQsIP0642crBtuunFHXw1lN0wtFdq9juQQbgNDqxabxd0Sy+FGmRCPSHvr311wrGHs/YmP8u0+NO6EGZI3O0ONu+I0m/KmVbphfexFvKIbqdMGW3tD6iQT3wzB3HJyWf7er1xUHKd3s+YrC46MzQDgyIf2B5fd0+7kEMy1Yzvt85MV9kQ0cwsg6tjpRmROW41zaWXhgzpJDXAp+7/c4a6iTxHb09b2L9JDuxg1K3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzkpsYePFnm26sc3naxIzygkVmhueg3a+PclWhAcGIE=;
 b=BqsrNJM9g5CI9hFwX7dDMOZ9XpJOQwThL5Wo84GaUz62WZYwHL1PGhVPpzan7Dvs7wQrZP80jPfjV/kNCfEaMwVv2qT4rmH3P09UCpNf3jx11EugGwExVe+GpHEmCWZlbAo4rImVuW6syE+JqGB9/6RyjYlgkpsRKhrKsumLv7c/pznQZi6bFXtgXA30uvVflhpONt/hfTEaKP7g1V02vWncSczU7DOeeGsavO4w+M0cYC5NIv0nuo28IYQFotclYbsDCbhPzxjsTrWeNGy78tWbipnVmlT/ELGKzEYFNYzvOSbzHOup+IRwbrAP+geL2CowBID24twGaJpYMt2/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzkpsYePFnm26sc3naxIzygkVmhueg3a+PclWhAcGIE=;
 b=vYAxr9MRuB3QpThMbe7TUUmNggq16ll0EiYiPvjKrA7QBTabfk37kRYGRBz98PdNwnwNRBjJYWMbiac/OEkdeJ917AEt2W3zPIh587h6AnCWC2klK7zcbsDQOu6knpRfRN3pBk193QpP6j2U4TqK5PCneMxR61iUD3QKvp2gH1U=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB6091.namprd04.prod.outlook.com (2603:10b6:5:130::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Thu, 25 Mar 2021 12:05:19 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046%12]) with mapi id 15.20.3955.027; Thu, 25 Mar
 2021 12:05:18 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: disallow passthru cmd from targeting a nsid != nsid
 of the block dev
Thread-Topic: [PATCH] nvme: disallow passthru cmd from targeting a nsid !=
 nsid of the block dev
Thread-Index: AQHXIVwH1ScTxDZzaECPp8Ru2XC2tKqUm4WA
Date:   Thu, 25 Mar 2021 12:05:18 +0000
Message-ID: <YFx8ffiOEcWsIivr@x1-carbon.lan>
References: <20210325094807.328126-1-Niklas.Cassel@wdc.com>
In-Reply-To: <20210325094807.328126-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1206524a-df1e-495a-7314-08d8ef86423e
x-ms-traffictypediagnostic: DM6PR04MB6091:
x-microsoft-antispam-prvs: <DM6PR04MB60913D6647AA52A3B804D3A2F2629@DM6PR04MB6091.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tej8enLgMLnz3JAHyyod3hPI0lT9Jbf6Yc0akuujYzjblEmaCb6YKktXQQeQQfqG+jbMAp0LoOpuqdtLnHjb9hdI7YR6RqETDxCj90LCayeVA8v36/ttlwNNznTZ/pODY3rnwQZi0Zzb0+3BD2ohVTApgmKuPSK13yV1pOJHgkIetIosLcXb7qM1gS/sPkBY2xHsFSbHqWg8MIxE/udIB3msLr5nFvXX7R4M03gJECFTh+wctFao9uDKyw07ILksnuNC9/3IaVUY5l7orXCYv0WervHGqe53AsV/hdf9ehhBoPCNACi7MCQk5IhupQqcL+j3hChPKPq45qPtPSoTuhqLIIbB8z+VnGtP56onoaAF5MMRqkDjUORPUVvnXk1VKsWgDjo0WXiXpuCrnPW0IcT3q1F6urbRdQ8RewQLjUA54Bwpt6CWvPJqFiFUuY9jyyXfg/QjS7JndGVSWLf+gvpVpMe9sl4kbY9x5avtxBPR9qGRLiOZCjRKtPnljncB5rrh6y0l0viSeGwmoddc4mCdp7Cymn/WyJJI3ug559fW1JTF/DAeOWApB82d9JFUh6WGssS2n982Uh59TIJ92/B6ulglLscDfHlh8XiJVUl3LwK+0nXrcTtBarrOrCq9C0MX4Eomg7NiC6m2QE/6J/nUyk7ADSNwZQSYYN+y2r4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR04MB0684.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(4326008)(110136005)(8676002)(38100700001)(83380400001)(6506007)(316002)(36756003)(71200400001)(54906003)(6486002)(2906002)(66446008)(86362001)(66946007)(9686003)(478600001)(91956017)(64756008)(186003)(76116006)(5660300002)(8936002)(26005)(66556008)(66476007)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UCVbn9ZsHp5xh/i9AH7ranIJDJ5AjbD4uXOs7zihMhrlo5SQHt3YT4PHEcpH?=
 =?us-ascii?Q?nYitTFCCrdScU77JkqpFn0h9IcImmmCW1KdcWLIA0VZM7DEOVB8y1j7qD0lL?=
 =?us-ascii?Q?GFI4+s9hnsjsD6IbA5d06Nz8CHTAoO+TQ9B/1b1sxB1fxXGMqxFcGBPJURfq?=
 =?us-ascii?Q?UqY0nKZEJNiysSCjcb3ys3XA7w+tVNXBcMNPrB1/jA/e9RJ/+2UcUNJWUXUy?=
 =?us-ascii?Q?8qA+ouTyBgJ9YLIoYaI0ggjYnzaTYN6mO6yBTH2Ws3RS/H69eAdWa2LP39lT?=
 =?us-ascii?Q?7Vj6oDmW5HBJ2bumE8Mh17WCrBia8OIMPEnz3H1QkzRbQ+Dr1WRDdeyXCQrX?=
 =?us-ascii?Q?QBfZ9FymenelumFv40ed4yKjoKgmYJLVwDOEwM+mBYkL33aa16WjI/cPRu8I?=
 =?us-ascii?Q?u/x25hQ4UPNrOYEAFZj88V1HseREO+f6c6/Xp/f815cl9uIlR495oRdU+8P/?=
 =?us-ascii?Q?JkmjDYDxO/jcR9I4Vl3vtUlZ54Wxe0SSbVqnM5u03A1C1KWuJDBcn2L7cNva?=
 =?us-ascii?Q?sijdOq55Kh0eUagr/WRu+3k/z4Pd+/UQRjDTlkYPMl1yDGCNZfZlGueThoIN?=
 =?us-ascii?Q?ZSG+1l5/ZVYTHfVUB2b7VWL91fJYYxioo0SsNnnUZjUuVDZgtQBLdaOTonUM?=
 =?us-ascii?Q?YRGR5E/6JSN9cnfzmZ6D68BPzghA0XQogGtqJF2I/4QTq75MeEOzFze+uyn3?=
 =?us-ascii?Q?vYf6LL39LZkdxnk8DO+542txrBCb4EWTFsY5L4h1lRhm2maKgKpnj9FTLEme?=
 =?us-ascii?Q?UyLHLKrvDc5H9DF/pjUzYOmA0n8yw205HmnfnJZLtXMdd5lAyFcjKUQhzMoL?=
 =?us-ascii?Q?9hSGgZ8o0Bu3Wc+FN9ohVGZhkzB/fWZQDH0opoRVZtj2SX05kLbq20tQMzmj?=
 =?us-ascii?Q?YNxObAg54Ys33UwKXLdQ4SUH8Yg9MOdHXeIMjfvk3AxLJHUFjTmDEtvkF1id?=
 =?us-ascii?Q?cl8wNIE4n/lSrYJoJdcCh7bKny3udINSPksa8O8ldq3se020eJXLPNSayWIz?=
 =?us-ascii?Q?F7bfw3Ac//ON5nHBBpbUEC6O1dRWH588oO8iZYPmLKg3bTgFJ6f/LZYJifVG?=
 =?us-ascii?Q?Xx6JBWjSA2PCwKeygO/8x0Xty9Xx8RH19BjpdOl7rYX9iXH4Rg2qR4YgK/m+?=
 =?us-ascii?Q?Gxl8Cg/TTRy2eMUnSunvAvScC3Neo8EXqQm2nud3LmELe4f+Kx06RJuEDhvp?=
 =?us-ascii?Q?UEEV3b4Vct3WkHDT1gz79jAaLUvCGVh1EF/djE+WnsNTVT7ZwzFvPE4smhAw?=
 =?us-ascii?Q?6VgrqyD6J92lHjxYNJH13XWsTkFnBUhqM87CYOZQzn4cT0dPAa30qav5pcGn?=
 =?us-ascii?Q?nRjJjrizM3UWYaakQNMx6oTO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <800FCA8859F8A5449DDA3B498E5BA7D8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1206524a-df1e-495a-7314-08d8ef86423e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 12:05:18.7780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJH/3juzk0zHqHgyl204yZfjtyYY6LV8NmHN1uk0e1oI68EqGmHan7E6WH/jncvqQEKyQNG2wSqbjBB0bK+Jkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 09:48:37AM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> When a passthru command targets a specific namespace, the ns parameter to
> nvme_user_cmd()/nvme_user_cmd64() is set. However, there is currently no
> validation that the nsid specified in the passthru command targets the
> namespace/nsid represented by the block device that the ioctl was
> performed on.
>=20
> Add a check that validates that the nsid in the passthru command matches
> that of the supplied namespace.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
> Currently, if doing NVME_IOCTL_IO_CMD on the controller char device,
> if and only if there is a single namespace in the ctrl->namespaces list,
> nvme_dev_user_cmd() will call nvme_user_cmd() with ns parameter set.
> While it might be good that we validate the nsid even in this case,
> perhaps we want to allow a nsid value in the passthru command to be
> 0x0 and/or the NSID broadcast value? (Only when NVME_IOCTL_IO_CMD was
> done on the controller char device though.)

TL;DR:
Since nvme_dev_user_cmd() only calls nvme_user_cmd() if and only if
there is a single namespace in the ctrl->namespaces list, I think that
this patch is good as is.


Long story:
If we merge Javier's patch series, then we will have all namespaces
(rejected or not) in ctrl->namespaces.
We could then decide to remove the weird restriction that you can
only use the contoller char device to do NVME_IOCTL_IO_CMD
when there is one and only one entry in the ctrl->namespaces list.
i.e. the user could specify any NSID, we just iterate the list and
get the struct nvme_ns that matches the cmd.nsid.

We could then also allow the broadcast value being specified as
an NSID, and in that case, use a disk less request_queue (like
Keith suggested in an earlier thread).

Being allowed to specify any NSID when using the controller char
device could be ok, as you probably wouldn't allow everyone access
to it.

So Javier's patch series still provides value, even if we allow any
NSID to be specified in the controller char device, since the per
namespace char devices can have more fine grained access control.


Kind regards,
Niklas=
