Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919F73A8441
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhFOPqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:46:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27957 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhFOPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623771891; x=1655307891;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AClQn1+/nzU96VMG3j+9fIBrbdXFitkgoUZ6cokMN2U=;
  b=Df/ABEiwUocYlkEZ5oN5AhunDi6zbB3TqDbhkBVdUOxaVjedFOG9o58o
   9ehriXQ4Ddk9DmP0xfxqFm5CJeXBMDAnEZMJngKAxzaoiR8LIs24/DPRg
   MZrOzwPn6kfGhHvdWimn55zXcAzQZkQBkJiDXVWTSxhuEyOfd7Ej723yN
   VfT2oneJKotwo/dAxmgS0RtdJMxOCqj30tsM2aGkEO+z05+ziYvzYyIx7
   LeJzvQWRKwSW9xMAsUt1tC7KU21RAT+hf0erQCZ1j0Hqvj/jOdOyfvz7O
   EBlq4md1boH299UPGpIcFF6k6nZaJONI92nsOXm9ok0B82sHGOdUsanBj
   A==;
IronPort-SDR: xhVGdxN8sNz6knWtPMDTaBLMcs/0vi7Ejb5HdZGyhkUPfW2sU65fCJ6W3Uxu8MhvAvY9Jkqkv2
 oDuhrH2FL1WWwYf0z251fTAWNwqMHffjEfqB6twUMPuhD/UCLO58k1TrZEMCnFGaxG3XVMmLwE
 hZjaBnftFIojeujiJ1+o8HyWCeQ8ZqxTDv9iuqfd/fWGuhchO1nWKErh86eiVviR6GIVenDHa3
 aB1q/dy5EMzr4000QPn/P6TvEFLB961UC9PGk7ETrCcTQ1OUcv69X5Ltbtx93DzibibTGsJRIA
 RUU=
X-IronPort-AV: E=Sophos;i="5.83,275,1616428800"; 
   d="scan'208";a="275763489"
Received: from mail-bn8nam08lp2047.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 23:44:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODPBTOgmVKNasAn9wbysfU4Y1CxO8D8qDyGoUa/DmK9dxdp1qpuY5dOHLK+vpaSKEPqu80bSaRqBofNxSNhK8z0YJq0G8OET9AcjzDQ+gqa+YpUyRmrKJZ/W2hcZQf6hUom2t99tT8rjiI+V5WkJpC7nksVCLuM5IXe/CfN/N8UpGP960nNWppJ7sLyMkEwuQxlLs4BcAZTaw7ihV+3p9T77lUJC+tEyDqgZnmceCqV2iAl5jm0XOtQyf8J82YIzUhKlS/mGgQMbrLxuyQ6LHSxLt3ZzTYuL3UY8tPc/rhwN18ngoJzgqCeRraL0QbpZcefoWrsvXsHSebBwmNLSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdVZA8sSdo3Mig0SenpuiNl1+aBhC99134KAeyh3/6M=;
 b=iAFx61syPdlbw/xAdNxnQ1e6uMgETzT/3H8uu9l/QXHrR7TskXk7Y9mXvKq8hfeLYqNuqsaE+PDM0SfB+pbkNLzJ+7eU5uXyEh+Mw2jpWad7yHbhunuaq6KyUb22lZZP/9mEA0OStryQIc3xL8Z01Y3dSbc5qEWPhqlveXGKcv/PQaz36lBja4Y1BMiKJR5eOQssa6HB6ZJblpb+Woq4zxjejkzimF3UZ+/Dp40bK0zCVp79l92tFrv9VIsID2sT38mAGBrljZ8oPR5ZeQyRUFi32zZkFV9D9VHuBMh9q+u5cOkSkPWSdjucleyrKhIRlRLQm/e2J1oEFRTmMKBQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdVZA8sSdo3Mig0SenpuiNl1+aBhC99134KAeyh3/6M=;
 b=fuILO3b3zKK3slTSfd+IGl0J/MYonuMtuhx505EBIPlA9LNmGmm9lE27c9T4qneJabPx9EMy6GkFun31AE2XdltztIO0kAkNzC/JZU0o2eDxOxK5vnsxiTHZ8Y2NODGNgDSsnNr70QsXKD2bOCpvow8seRf1bVbQ2mH8IFadEOk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7653.namprd04.prod.outlook.com (2603:10b6:510:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 15:44:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 15:44:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH 2/3] mcb: fix error handling in mcb_alloc_bus()
Thread-Topic: [PATCH 2/3] mcb: fix error handling in mcb_alloc_bus()
Thread-Index: AQHXYfaEdGCqdt0dgEaIHDEdjRKGeg==
Date:   Tue, 15 Jun 2021 15:44:10 +0000
Message-ID: <PH0PR04MB7416D67511F5DE1C78D6838A9B309@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1623768541.git.johannes.thumshirn@wdc.com>
 <b2fa90594069aa3f61d4658603d922f097ce2bde.1623768541.git.johannes.thumshirn@wdc.com>
 <YMjKQnFRi0feSYiI@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:b8f6:a609:8f3f:1503]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a69144d-326f-41d2-c371-08d930146b6e
x-ms-traffictypediagnostic: PH0PR04MB7653:
x-microsoft-antispam-prvs: <PH0PR04MB765335073526B0071780E36D9B309@PH0PR04MB7653.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rP0iqydUuHF6IfYvKNSVCzPPcIUumTPdt97AKejh3PvOqqhHFtllLy/7XIV3Zk+gxjzfOodRZqRRrlnaoZtZGe+ZHNq9tXYgG05qfuZbg0FwoPVMyZtbW+tQ8rny1my+vGygPBEdWr39/pINDZdF8LNUhqbX/0Y6E3nKPfP2J3e5DK9s+HMpCcS/jY5/Esd4woVMtXR7lOcYpgsGQbVpjrDl3ejNMnrtOJObPfDRzRWI64YfS77UcBRlxVTaxcWD+HJhKSPb53WwDxeNcErRKr7zHSgtvRU8CjrPxVLHhWaHvCN/0j17jihrL7yHNWzfPKtdAxEX/HhDqQUN2BbZNrHrxBBT8SeV9ekYv07FIhvS8pLFN8bRk4nY4sh+fRyU7bpxhjYXV6nFxzt72857y2z/aHHPzE2UIRJK7EEDLnLrey46D75TVY/XUeBb8fzwhf/No9ju7D05ZENokwYtsKLmHVzISi4TqNixZDVswRMB0ZfnjY9ZjBY47okbNJuXuC2S4q5c3etJqoX/dM+MtIu6MMdVcANRhuum+IAJd5v0iSshkMxCbcju4+n3GD4Ze/iNMABMmkbV9gILBsodTqSctCosSfoKTD5d/zN8aNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(376002)(346002)(136003)(55016002)(86362001)(9686003)(66556008)(76116006)(66446008)(64756008)(66946007)(66476007)(83380400001)(4326008)(8936002)(8676002)(33656002)(5660300002)(4744005)(54906003)(38100700002)(478600001)(52536014)(6916009)(186003)(71200400001)(316002)(2906002)(6506007)(53546011)(7696005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0AfGCsnHTNmtVTuvxOle46G5pDEomW0Pc+7Y5RdIxPmMg/Sgka/1vAjJqHjf?=
 =?us-ascii?Q?AuWOIdTVf+++cbYMZQQ9HvMONFGcXNFwCxU5oAd7MbgaaeugazcNTY1HF1V1?=
 =?us-ascii?Q?tg11hPhkC88dAzXyjMoDZb53dFm9MTdSBx5pqfqjUbo7iqCoNy3sjS0oM0Wc?=
 =?us-ascii?Q?lNqcn/NoB02NMksgVXyKqNUlCCHwvgqtUokWF8EJT4sdWW5/KIzhPAADLqfL?=
 =?us-ascii?Q?Jcm2xbaBfd8ZTfu6/I5ANPEAP5xPL016KkjCx5HChFR4rBi90ns5xVyKnGN4?=
 =?us-ascii?Q?jGv3R/a7p0nZoNXTlCtnaSHwtRKGqXpQhWNDqWLJa2ysE0pbhtYeJtP0roMb?=
 =?us-ascii?Q?3ulyZj+RopdmTj+EipLV0Chyzp4uQvMSphN7iPxdvPycl11vPLG+0lmKyyLk?=
 =?us-ascii?Q?wkMxYZiuqCdvfo8vnmHvcHQ83sLArqSaW4DETVp87KYmkVsMN5+WNi6UZakW?=
 =?us-ascii?Q?elT2/Mp0RnkpjdImD6gBlEWRKbVqgYNG+Q9njeoPatrRHoOiq1qfKcF22e4M?=
 =?us-ascii?Q?hkhNDB1ZVXuMZr7hvneqhI7eTmoDPZaG7VOJkssD/lyXF8Oov3a/AYqKVYkV?=
 =?us-ascii?Q?EmEl0F+35UZFRTP9V+MGyWx4vruC07N5gOQVLNrqjkDtZtplbJHxVt3i6t9q?=
 =?us-ascii?Q?TC20xCfPs71Y+erbeZ+xL6MGf7A/6wtyzBcTfBAnEVyUNudAphJoV4k3xuud?=
 =?us-ascii?Q?mAk9hPcBwZywhgSNjzGOjnI07pq8dHvX0F5pD1ucXhZYnTvU+uWpKoADZj5H?=
 =?us-ascii?Q?d/DtM3sU/UAVeeyc2eohfVzEv3ut6Z2hFCb/1+lzyOiZgTOQS5zMKKBLPX2T?=
 =?us-ascii?Q?8fhJb/kJTzIIUj2Vp8c7QVlPo9dV9bbXLP5LWef4jGlptuMC/e7oxOFHtPUO?=
 =?us-ascii?Q?U3H+rhieSpa6JiERK1G6cUjkQSlpnWzKcSiHlTGREzujpNG6uk08v16caInZ?=
 =?us-ascii?Q?goNRl9cGcKDCg5N3D2/j5xloffZKmT3+b9if9nNk2ku1CVgrGJxkw6snKK41?=
 =?us-ascii?Q?A7xS2QNw4srJQHjwjzRlnxjg4BIQdOpo5lIZcGXK+M612HrQH8F1hPJ5ZSWl?=
 =?us-ascii?Q?0gylYAA+IHnAYYl0yqST6T+qk0HZaQMJLgwyBuiVkePdYqUhsLL549EgFEIx?=
 =?us-ascii?Q?oOY71w++PAOMIq08nCNx9GAYN1ITAuuWzrTwABej7bv3x21UsKV2MxJunAbZ?=
 =?us-ascii?Q?MXgE1GK+S8QxBeAIJyZ0ZzLCpy0uqwMnLvqag9Admu0W+FoyUolZWW0/X+mX?=
 =?us-ascii?Q?609eonA2wEf7U4to4v9cogwZ7S0dh+zwlVwZtKwLiSX0/yi5E+hZaJODdkpL?=
 =?us-ascii?Q?ytaCHgILHYAZ+0CPPHTgW3/Yz/00aCbuo9PIy0ZxYQJ5P/vXX47guPa7IdYh?=
 =?us-ascii?Q?6+IQLi65dzIBzC3+rHVYIWeEd3hzdXDmumWrFdkm/EY9BL8yvQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a69144d-326f-41d2-c371-08d930146b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 15:44:10.8590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/dDPFCZY85WSx27wAZ7pVlijiJxwWdHZEQuctlG+7zX4Z2TcU+3K9eotoY3ZPD1H/FOZXy8SzQIyJQwPfShoM5TNV889HaNjaC7D06FBV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7653
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2021 17:42, Greg Kroah-Hartman wrote:=0A=
> On Tue, Jun 15, 2021 at 11:55:29PM +0900, Johannes Thumshirn wrote:=0A=
>> From: Dan Carpenter <dan.carpenter@oracle.com>=0A=
>>=0A=
>> There are two bugs:=0A=
>> 1) If ida_simple_get() fails then this code calls put_device(carrier)=0A=
>>    but we haven't yet called get_device(carrier) and probably that=0A=
>>    leads to a use after free.=0A=
>> 2) After device_initialize() then we need to use put_device() to=0A=
>>    release the bus.  This will free the internal resources tied to the=
=0A=
>>    device and call mcb_free_bus() which will free the rest.=0A=
>>=0A=
>> Fixes: 5d9e2ab9fea4 ("mcb: Implement bus->dev.release callback")=0A=
>> Fixes: 18d288198099 ("mcb: Correctly initialize the bus's device")=0A=
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>=0A=
>> Signed-off-by: Johannes Thumshirn <jth@kernel.org>=0A=
>> ---=0A=
>>  drivers/mcb/mcb-core.c | 12 ++++++------=0A=
>>  1 file changed, 6 insertions(+), 6 deletions(-)=0A=
> =0A=
> Shouldn't this go to the stable kernels?  Why not cc: stable in the=0A=
> signed-off-by lines?=0A=
=0A=
Right, I'll add a cc stable=0A=
