Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7500B3BA149
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhGBNhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:37:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:2003 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhGBNhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625232900; x=1656768900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T/0omtitDSPnaK10qmXlktRJ0LJHb+kq5GXT27KmxAc=;
  b=Lev//n0HNc+ceKeZqb/vtlzbgXpftmo3ZP32gXco3SHgOAFPQBwBk31M
   sSq48JUCE8DFrXxhRFLFteWseEJU7csttCZSrR8rAHjtdHtkDc24oOdKx
   NWnIwOsMagT8NXGl59+PfDtD6QBgWxnbS8y6FVB/JYl00G6ufinVwQTgI
   oTAe/h1XPJZAW2+bAEhovvrcXIz03ek6FN0oEGQ6Eozfa/5vSdXJfYeeZ
   61MYw2ddwdfFbnxz8Em7zJLugOCib9kK02gN4WM6GPQAqbsiTcwDxEyIH
   qPf+OeFtiqcDXvaMShOVpFleEmb65DMRfZf3wIfEmDO8XnePnXAsTyd6f
   Q==;
IronPort-SDR: 6zIUMXGwlYaeutrirFQzE0FXp+J/w410tWtepZACcYX7hr/dmmkcAv7srNjMNkqE69ihu+8t+X
 9W5MFN4NlxvOtVvMBxwSUvsrNxAj6Jdu/OReb6MXPLXRHlYJFbBFILQ9lw0aYS09FrHyf2t6FZ
 iiTxOaKQL6+UPMiJ+YXh8TS8cZc1LQRqcXUEzJK2DS3baoGOxK4osn348THbe/U1PalHtCaIBk
 U/nnrGyAMAqNmACLsN447+GndKktj6HaSTla+q2W79RsneyZ3bNDQa6weW/xVnojTtN+j8ZL8I
 ZkE=
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="126902254"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2021 06:34:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Jul 2021 06:34:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Fri, 2 Jul 2021 06:34:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZjBFcS/XveHLrLalAjqY0TpLI3UAuPD1Q3a52ZoZSQhTTjFy6nxIajyA9SXDkdqyjiFCpdsApJDGPWnkaphcJUBp/PzLcmgFRyrDozWKXAwM4e6i2jiC28t8I5Yf/aMjjr/6fuG44Enmt7/Ci+yMuAUbCq0dIm/uonyTX5BjuQVS90GePl+KrL/M+Y1XgcFjlp6VkZl7VJOtU95yYqQOrhszpvbJGLa1H38K8vh3KUfDdcheGV8C1W2EWMo8YcyCUecUy6IrJ8iVbAsBLBVqB6GbMDyD1T558HdGCXCD3ljfZm2om1/TpgTrJvp49HwAnY91UEz6NPuhYOc6cJJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjA04319YYt7rgxXmh76qOTfOll2flBXsELVaK6Zt2Y=;
 b=hZp0D3FiEJctQaIw8fwlQ0Lx2P/78mfwwXijWETh5A5ShJdN8SzIUhzIfxcQSO9RUG/4edzWOvV2SIs7c2AWXF74XraOeRcJPmVyq3CppsIGzl/Pvs6W/p3/JU7wvldBe4N/FwLRktEkoZOvhyFOqsUaXwxXh4WwWN6ConZTgQ38Z6j0pHQwZbip9CxMrUAS1oKBfG/6E2mr73CPRHFosiDSyFPpotrkt3ASQqCH4Q+nS1dQKOOqkkCrR//BQUemeu4ACe3zkbHrrSFqOQmSwm9Rgq/ArOseu13IwUC7erDjGPUGy/JRCTxfIVUdTHCVKXiCuDiImKfYesDn2YWo1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjA04319YYt7rgxXmh76qOTfOll2flBXsELVaK6Zt2Y=;
 b=gFDejwP7bcsaWQOhTL/u7gOtzNenX2gUAx4NwYFsmYkZ9JySPc3IjJ9pmAzfh2eoeLmO7jzkVQ3zkB7Ek644HpXeZNX+ASHKlvuxPS03oMqbtJRqAS049GEpWldy0HD/esodlMgZ3NMn7p4aGNmtMrUbg0Qu/fgj7ecB9RCyTHg=
Received: from PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8)
 by PH0PR11MB5141.namprd11.prod.outlook.com (2603:10b6:510:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Fri, 2 Jul
 2021 13:34:41 +0000
Received: from PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4]) by PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4%8]) with mapi id 15.20.4287.024; Fri, 2 Jul 2021
 13:34:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <linux@rasmusvillemoes.dk>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <frieder.schrempf@kontron.de>,
        <bbrezillon@kernel.org>, <p.yadav@ti.com>,
        <linux-kernel@vger.kernel.org>, <esben@geanix.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>,
        <masonccyang@mxic.com.tw>, <ycllin@mxic.com.tw>
Subject: Re: [RFC 2/3] mtd: spi-nor: core: compare JEDEC bytes to already
 found flash_info
Thread-Topic: [RFC 2/3] mtd: spi-nor: core: compare JEDEC bytes to already
 found flash_info
Thread-Index: AQHXZ/txAD1daNN5FEGbvnbgvaM45A==
Date:   Fri, 2 Jul 2021 13:34:41 +0000
Message-ID: <964153d0-87cd-7735-3c74-f89bc901065e@microchip.com>
References: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
 <20210621152320.3811194-3-linux@rasmusvillemoes.dk>
 <223232ecd0865e819477f17cd464ab08@walle.cc>
 <d43f021d-8f95-7857-b70b-91e22b0a8e2a@rasmusvillemoes.dk>
 <d1473b12-daea-e5e8-b8d5-64084bfbe11c@microchip.com>
 <63c61200-2387-6f92-32a0-38baf7317cdf@rasmusvillemoes.dk>
In-Reply-To: <63c61200-2387-6f92-32a0-38baf7317cdf@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [79.115.63.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cbffc79-2403-46b2-10f7-08d93d5e2560
x-ms-traffictypediagnostic: PH0PR11MB5141:
x-microsoft-antispam-prvs: <PH0PR11MB5141702BFFAC0AB389D686D1F01F9@PH0PR11MB5141.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vDY3iXhDEVUlJdMMWI2Zt/p73X6+uxouH3zQ/sQHyxAtSCXlkhPJiGwio362TZQLLYBoUdp7AuT0KRWxBlb9R1C2J+t5TfT3LZGNakfgB482EanjZ9togXUna2Mza2DkZlk/2gw2WzAeW/s+N3+E8t2+TooAbyGSa5WOP3ywlt2BlhQuQajD/P2NvLUa2U3KWGcjAgYWTCiZN/7whHe0JJ3ikSGoGGJsUkIrsz9wNboE42t1FBkej5zlpq+LDRq28D7PFkkzuc8qmhklNonQtTREEK/znE6us25Mbk/785TayvO+8/weS3hKqnt41IwRfrfXAlw65o+gJV5avHU7ENBXqlVwlb9D9uu4kU0Bz9exvIffgiguXz55EzS7VPFDtriEcu+SMYAtco26JX7us4hLKtr+pdh0f6UNEtKkbjmFcZvBhdiDFo2H5sDBUCtUlYO6zOLaMYX/AlIjWbvDpyPHEXrUJ6df6/boeUCLUd6xTpaPGnwVQKM3Lk7tV2VTIynWqj4ptA4rrJNXheJgQUju7h+gRk/MKm78g4FYNkeewtVjH/XuGx0y78bOEB+h/bCx6/mZuHLlu95fOg6s/bouVJp/p2h+UneHFYVstz199Z/Dlu7KCD/RxBA3gW36cC71n++K0PN6uMlk8URCkoj4iMz8gzTwizcTKJ0eBLi5o2CMaznEdq6Bw/4kb2Gn0ZLRLtg5Sm5Dl92v0syfr96x8/tzkfz8fCppHu3t0aGhgJmLMXwEVTx3mMrXZ0uRYhZh8Ji5Z8ThZvJeekj4pT+rUDl38oLmVwtG42mIaj4PqTjoxF/3wKhWh0L2z7mrGpjWsT+zjtheTAy09JJiLZ2LiGFUslrQ5kmc6ARlVuk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(136003)(396003)(366004)(66946007)(2616005)(91956017)(83380400001)(66476007)(66556008)(64756008)(66446008)(31686004)(8936002)(6506007)(7416002)(5660300002)(53546011)(26005)(76116006)(8676002)(4326008)(186003)(966005)(86362001)(316002)(2906002)(6486002)(6512007)(478600001)(36756003)(71200400001)(31696002)(110136005)(38100700002)(54906003)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?jx+vRWcTdo8xy2vheBYRB3Xt/8CPT2YTG7d40yizeEBooK2P6smKS6mF?=
 =?Windows-1252?Q?rRFNcZp5O7ZKkmjvOUHUQEvuCKgXl+5RRCKuhqYZm/8GIq65pMFIzwGc?=
 =?Windows-1252?Q?LvHil0CMrpp/ZKcYtQyVeP0GWCny6uXih/8KkmCv3QH1bo/YF6qdfUE/?=
 =?Windows-1252?Q?huEtnTMs4UKXeLc2UDIR1p94MpgBEicjQLh35vjAr85+9QkfCsEpYoMF?=
 =?Windows-1252?Q?d+Scn42KQsYvJ/LrWeGmDZ7bj7bwQCyL5EF0r2T8jaMDOo1Ltd9HnoWW?=
 =?Windows-1252?Q?E7wwIbLN3rkEZO8pWQyPGVcYyGmuDzn8SKF2aiY902M8ZVago6PjuJ4F?=
 =?Windows-1252?Q?Llef3ZAVT+PbZ/RibGA2NQmf0LIQ0svwdflHyou7bqb1C1ykss7sucWI?=
 =?Windows-1252?Q?Iu6Di8xrl+jdVnITGwk0wwbqdb9LrUXkhrFwjX/zREHQstCdgPvx6x09?=
 =?Windows-1252?Q?A3CSZ5NNoz7oqykybOEkk0XUOccDJbBGwdrgXNqEyPPqzOwUwM+/VNGn?=
 =?Windows-1252?Q?yBOCq/1sFx9kFuyZKymYaGfdPsM8FfB9U4Zgvp18tH90FZDn+gf597C6?=
 =?Windows-1252?Q?egQByk5Pet8cXoGd/7hXF3ag7hHnAdV2skoXMGRSMyUca5HueZ08/cZV?=
 =?Windows-1252?Q?2Pb/U1or9+hEEy5OqUaq/usM50ceeyx5X14N+J4pYVSm892UNsdUqC/5?=
 =?Windows-1252?Q?p/2eWKg5blYOfY1ksBXFt6gex5IpD4y9Y6R3lZ5R01SzPYKuB4zQgt6d?=
 =?Windows-1252?Q?2kDzOdutpl7whQJWtEN3Oi7pH36DbjcnddZsYoPEDYT05t+2DtOak8ZW?=
 =?Windows-1252?Q?4JMJ/j6kbJbhrZIQjeeldEeDSH7Mev76IersuCorjbPXZpfQgVtV2gvA?=
 =?Windows-1252?Q?J8O4U1GSATQfxXvGAvsW2toappF9F/0544Ri2OsKYECRRw6KF6ao7eoC?=
 =?Windows-1252?Q?cWKyxEmjfKBWQzBnhCqQgUUUYMxFcikQmXIfm/+wBM1E+CnDNy/xrO4N?=
 =?Windows-1252?Q?XRv0OBHc0Cnu1+4mbxz+Xb+vsz5r5vUnjzDeoSgXOliIlpiQRbiVj4d5?=
 =?Windows-1252?Q?jjyS2SjuZ69Erv7WpTIS54GuVEd2kMC/YVyHE2s31q2jdBifDMhuhMgz?=
 =?Windows-1252?Q?mrwwOR8knWrjYzSMS0ksOQknZZTKx7x1ui1fIHsevACaaWD9oG+BU5Ww?=
 =?Windows-1252?Q?RUPoDuJo7qW/9Ht2yIi0Xah8IK+fVLgeCKDpnbJqLgT1XczGpX5G9wPs?=
 =?Windows-1252?Q?qPtXTtoKDKnuEoX+7W7jmNnQlzcZIxb7wy2P5HEB/PKRuUmqGp9rPhVh?=
 =?Windows-1252?Q?cHRl/Z6Yh9Ns+ja3nZAgM1K7rNcT7VnxNvXN3Ny1XfyhT6pREj7lhKUG?=
 =?Windows-1252?Q?T0iHQjiKX+YjkwWcX7GsT/JsbyWQVzBW8go=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <8F3A11E52E5DE24D83099B58AA3B4593@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbffc79-2403-46b2-10f7-08d93d5e2560
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 13:34:41.2172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQgH3VhgFo4esRtmjiFgr4eAr0AaKhi4a3YMtxrUOsPheGZFzQrFuILcq0umd8yMEezUHZT68UDDWAWGugOF2h9h0SSM+FgTFWW9NQ455GA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/21 4:17 PM, Rasmus Villemoes wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On 23/06/2021 08.46, Tudor.Ambarus@microchip.com wrote:
>> Hi,
>>
>> On 6/22/21 11:58 PM, Rasmus Villemoes wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
>>>
>>> On 22/06/2021 13.57, Michael Walle wrote:
>>>> [+ some people from MXIC as they are ones who posted to the ML
>>>> lately. Feel free to forward this mail to the corresponding people.]
>>>>
>>>> Am 2021-06-21 17:23, schrieb Rasmus Villemoes:
>>>>> Macronix engineers, in their infinite wisdom, have a habit of reusing
>>>>> JEDEC ids for different chips. There's already one
>>>>> workaround (MX25L25635F v MX25L25635E), but the same problem exists
>>>>> for MX25L3205D v MX25L3233F, the latter of which is not currently
>>>>> supported by linux.
>>>>>
>>>>> AFAICT, that case cannot really be handled with any of the ->fixup
>>>>> machinery: The correct entry for the MX25L3233F would read
>>>>>
>>>>>         { "mx25l3233f",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K |
>>>>> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ ) },
>>>>>
>>>>> while the existing one is
>>>>>
>>>>>     { "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
>>>>>
>>>>> So in spi_nor_init_params(), we won't even try reading the sfdp
>>>>> info (i.e. call spi_nor_sfdp_init_params), and hence
>>>>> spi_nor_post_sfdp_fixups() has no way of distinguishing the
>>>>> chips.
>>>>>
>>>>> Replacing the existing entry with the mx25l3233f one to coerce the
>>>>> core into issuing the SPINOR_OP_RDSFDP is also not really an option,
>>>>> because the data sheet for the mx25l3205d explicitly says not to issu=
e
>>>>> any commands not listed ("It is not recommended to adopt any other
>>>>> code not in the command definition table, which will potentially ente=
r
>>>>> the hidden mode.", whatever that means).
>>>>
>>>> Maybe we should ask Macronix if it is safe to send the RDSFDP command.
>>>> Can anyone from MXIC comment this?
>>>
>>> Yeah, that would be useful to know, but I don't have any hopes
>>> whatsoever of Macronix engineers being able to help sort out the mess
>>> they've created by reusing IDs in the first place. They don't seem to
>>> understand how that can possibly be a problem.
>>>
>>> I, and my client, have contacted them on several occasions to ask how
>>> we're supposed to deal with that. At one point, the answer was
>>> "MX25L3233F support Serial Flash Discoverable Parameters (SFDP) mode,
>>> MX25L3205D does not support.", but when I asked the obvious follow-up
>>> ("but the MX25L3205D datasheet warns against doing RDSFDP or any other
>>> not explicitly allowed command"), I got no response.
>>>
>>> Another response was
>>>
>>> "I can only comment on Linux 4.4, as that is the only version that I
>>> have supporting material for. Basically we have a patch for MTD/SPI-NOR
>>> (see attached). This is to allow allow the MTD subsystem to cope with
>>> devices that have the same ID (see below first paragraph of application
>>> note attached). Please note that the MX25L3205D had an EOL notification
>>> on 14th May 2010."
>>>
>>> and that attached patch is a 173KB .patch file that made me taste my
>>> breakfast again.
>>>
>>> And they keep repeating the argument that when a chip is EOL, it's OK t=
o
>>> reuse its ID (because obviously nobody have used that chip in a product
>>> that would receive OS updates, so any OS released later than that EOL
>>> date can just include support for the newer chip and drop the old one..=
.).
>>>
>>>>> In order to support such cases, extend the logic in spi_nor_read_id()
>>>>> a little so that if we already have a struct flash_info* from the nam=
e
>>>>> in device tree, check the JEDEC bytes against that, and if it is a
>>>>> match, accept that (device tree compatible + matching JEDEC bytes) is
>>>>> stronger than merely matching JEDEC bytes.
>>>>
>>>> This won't help much without a proper dt schema. No in-tree devicetree
>>>> could use is because the DT validation would complain.
>>>
>>> I can certainly extend the regexp in jedec,spi-nor.yaml to match this
>>> new one. DT is supposed to describe the hardware, so I can't see how
>>> that could possibly be controversial.
>>
>> No, please don't go that path yet.
>>
>>>
>>>  So if this will
>>>> go in (and the maintainers are rather hesitant to add it, I tried
>>>> it myself [1]), you'd also need to add it to jedec,spi-nor.yaml and
>>>> get an ack from Rob.
>>
>> I'm not hesitant, I'm keeping my NACK until we're sure there isn't any o=
ther way
>> to differentiate at run-time.
>=20
> It seems that we have established that by now, right?
>=20

It is unlikely that RDSFDP will cause any problems for the old MX25L3205D,
I would like to differentiate between the two flashes by parsing SFDP.

I'm preparing a patch set to address the all the ID collision thingy.
https://github.com/ambarus/linux-0day/commit/b760260efecb4f3678de3b78250f99=
338ecbad1b

