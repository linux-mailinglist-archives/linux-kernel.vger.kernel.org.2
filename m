Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B133B15F6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFWIfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:35:48 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:36760 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhFWIfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624437200; x=1655973200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5IO6FidgxEyXh3RtFTz5c4uJl9i2S1FEGG/eweBM2nw=;
  b=gYSaLLX3llUJIy/Ll4+LrlHgXHlY62ar/0Qj+N8++I9V647q/StL9Vcv
   tqXWXZR+b9gKkLq306rD9fEAZvXaTenU7aPKeXueAthQY0B3fNU5Y/XQw
   7h+76APQvf0e3mlkuL5n9CHb3kOZ+uScl7WcCcv5k63qCY1W+qG75pqe8
   fVl9RLNaSDrDwOsElGuJlqQ4Cx971lDQVBNTjE4mx2fJJqots5RGSE6Et
   S3TKQ0zFp+F1SXaymCbGE9hkhnXCIgzws1QQjrVIINyHCJdzlT1HdYYVu
   iQnRpJWGZt9tr/gC1rKY14jjJIolpuDa55l1VL52LmoNebj1CsLtVllYx
   A==;
IronPort-SDR: 0oWZPOdQrJLDT8ajgoGBabQafcnpp+OdXzvBLMOuBSEw2HKGM4jfm3A9dn4mNlEkHpAeibzvs7
 RyLgtqgeI90wXWE/0wJXM1f9vMe1BYQVXTXyJOEjhi5l2ML5THldwubWYiz6ye2XcedG3p7OsN
 wiVWFQR+ohSx0Qh+D7ON3ehUbdToKn0sPuCt3PV7qS5/TaJtsC2bMyIk8jlN9VfHlG9bxCnQ4q
 84oGFFS5/mrHq+iPeMF0obN9XlBCrCdNcK4BwOZeJ745MA5yBMInTfcGh7MATZI5v7BTNb6bTx
 pRI=
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="59915795"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2021 01:33:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 01:33:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Wed, 23 Jun 2021 01:33:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFpRyakLnAI8SkUAY/CQdJMVDvFMeh9l4Fdl/qoYy6GuPJNFfuTDYHLQ+3tDtdNHEzwejP5hbziOo7Bpi/2iVrSD3IYLfs6C8oGaMeZq6bhPBEW2XY6yDWm8oPSJwZTlj5pDuerOhryLBU8MJ5F3FyB9n+lshpybr4OzeQsPcmecX2r7zqKZTbD5FqqFAxQ1EVYpcrsDL7UaW0uoBJM3iFwqgdxXlUgAuPok7XcAI3SLhBv7MHC7SAoyVYtuBbHbO3Y3futp0pfofHy1lQZjA17SEn+zylj4tHgaT9rz06QdBUVrW5f6427lpXk1oU+MWIvZUIzv9+YL7GU+SPKeow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSRGA7P+CtA1Fn6ZGmaiH01dKNYr6niDV/+oPe7HhQQ=;
 b=MUdZQxN1indqoQsKzb/UunkXEsQaHVnQJCiT/+iJNUvjrXnP+cQIFDa5sr2vWvGi8F6kWqfssUXRjUti/qr3QfHl+SkIJJw/Y0pH/PQDHn58cI/yG7LFICfjcdT6hhQdjo/ilW0vvjH6/gUlxPO3CHmTtytYQN/Qw0P5cV6E4oapIHG/+rnRjkSXrjVljKQM2lGl3h3YeLmqTgR7To42B4Npgw3AZ8vwx+p/yoxCA6sccbyY7BHkhFU52XJq2pQYh+4Vpxh6av9uxzyxomKBlehKhMtYGJcezr1q+1QDLNv/3uKS0EAB8RH89zNE8Dset+LOwmPizNdwgJCLR8Po1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSRGA7P+CtA1Fn6ZGmaiH01dKNYr6niDV/+oPe7HhQQ=;
 b=XWUV7lthXmcBqocTFaEMkW2zScLMFvN1E/79YT3n5A2wTZBl4A19yuVqvBF+LcG6CH9kYn2p4uuKW/45uqhYAbJ9FjBKaWpUyENo3fWsykYu0kt7BpighWgr1TlBWarTZIKE3vEt3S6fmyEM1IFGzE2hTRy/iwJCUJA248l7evg=
Received: from PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8)
 by PH0PR11MB4950.namprd11.prod.outlook.com (2603:10b6:510:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 08:33:15 +0000
Received: from PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4]) by PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4%9]) with mapi id 15.20.4264.018; Wed, 23 Jun 2021
 08:33:15 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <jaimeliao@mxic.com.tw>, <michael@walle.cc>
CC:     <bbrezillon@kernel.org>, <esben@geanix.com>,
        <frieder.schrempf@kontron.de>, <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <masonccyang@mxic.com.tw>, <p.yadav@ti.com>, <ycllin@mxic.com.tw>,
        <zhengxunli@mxic.com.tw>
Subject: =?iso-2022-jp?B?UmU6IBskQjJzPy4bKEI6IFJlOiBbUkZDIDIvM10gbXRkOiBzcGktbm9y?=
 =?iso-2022-jp?B?OiBjb3JlOiBjb21wYXJlIEpFREVDIGJ5dGVzIHRvIGFscmVhZHkgZm91?=
 =?iso-2022-jp?B?bmQgZmxhc2hfaW5mbw==?=
Thread-Topic: =?iso-2022-jp?B?GyRCMnM/LhsoQjogUmU6IFtSRkMgMi8zXSBtdGQ6IHNwaS1ub3I6IGNv?=
 =?iso-2022-jp?B?cmU6IGNvbXBhcmUgSkVERUMgYnl0ZXMgdG8gYWxyZWFkeSBmb3VuZCBm?=
 =?iso-2022-jp?B?bGFzaF9pbmZv?=
Thread-Index: AQHXaApoB34k0r+j/EGzCRMbPuTJeg==
Date:   Wed, 23 Jun 2021 08:33:15 +0000
Message-ID: <dcd4e64f-348c-fadd-1044-61c7b6fa93c8@microchip.com>
References: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
 <20210621152320.3811194-3-linux@rasmusvillemoes.dk>
 <223232ecd0865e819477f17cd464ab08@walle.cc>
 <OF7CD5328D.D33B2BE2-ON482586FD.0027BCF2-482586FD.00280249@mxic.com.tw>
In-Reply-To: <OF7CD5328D.D33B2BE2-ON482586FD.0027BCF2-482586FD.00280249@mxic.com.tw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: mxic.com.tw; dkim=none (message not signed)
 header.d=none;mxic.com.tw; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf277419-52e5-47c5-bea0-08d936218ba7
x-ms-traffictypediagnostic: PH0PR11MB4950:
x-microsoft-antispam-prvs: <PH0PR11MB4950853C1FDA3436F32DC40AF0089@PH0PR11MB4950.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQBFmJsI65IuwnzFE/RODIOAZQdrtXkULSAZncvse4xOAr0hOq0B9QhR/f2oOoLnSWXJFLA2g85l4oDRKc4tzHQG24zt+5SplFd0gKxVuKS0kA9wCwyFJgE1BRAV/SczF9rSERKMNNEhQ/O8NneMejeOrDKmUESS9y0hxALjmM8kPW0wPwP60zACEGkPXyillTxRg0sGI6b+ZXZ928xYu9jblzS4/FJjrO29rmREUc6a+6CsHt6xSvBCIgIcQKmj4e3E1KbgSsRu2ZVn+6G6dNkU617/HP548pPE6QSUscOLhV+wY+VNwD6ze9uXFon6aQycaPSLV3C1Dmi6GuX6JAr1bDlY0kvqo5AjkE4CcPe5aFzjJnHpZknMSvhmS+9pLZe/c0Xkd2qmejwoQY06NFZahCY2rtcxpy9iYBH8M8mmX9pt8SRaa5T3Zl0xHYnAMk3LE6Oudbmf9sVNI9dqp6iblxZNlFvEv5FAe+MHsksHg0SwYXtIv8OQHLV7d//ZxQIbLN2t/PhSMO5sbnHrhXMO3fIy2L4G5OT5T0Un9cOZ3Z2P0TLojhwWljWlFHbpT3FQJ93nPIMDBwHLHzN7eow+AC4jCVHVCdYgQmEwKWFWmSMy0Z1BScULh9nQSTDmmK1fRv0Z3i9tpBSCegu+kejTKkPyMmoMkaLw7TZ/iGNIm6dsRnU1KLqT4EBerxP0lgbaVEHnmyXO6JOlAWS4XcSv8mObyMkjG84PDxZbSCGciopNWbtdyOVIx5OaUu2zdWOgUAunjZqkKd5ChwXaVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(136003)(396003)(376002)(110136005)(7416002)(53546011)(2616005)(36756003)(8936002)(54906003)(2906002)(122000001)(224303003)(6506007)(4326008)(31686004)(38100700002)(66476007)(6512007)(86362001)(5660300002)(76116006)(66946007)(31696002)(6486002)(316002)(478600001)(71200400001)(186003)(91956017)(64756008)(83380400001)(66446008)(66556008)(26005)(43740500002)(45980500001)(10090945008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?alNWUlgzQWpGSWsybUFKRnpLM1dyMVZRRzIzaWdZWGNsTWpQZDVJem5F?=
 =?iso-2022-jp?B?eVJIdVRRbzhPYlVIVWJINnIwLzhHMk05M0xocU9ha0x2TlFBblhHQWVP?=
 =?iso-2022-jp?B?aURQcmVyVzdsNGFRQzBuVjN5eXBPTTN2VUNDcmRudXQvbnYzcFVuZXFN?=
 =?iso-2022-jp?B?SUNuY2t3UGdUV0pNNkNDWlQ3amlMSHVaWk5pR0FKdWhxekNwSUMwQ3J1?=
 =?iso-2022-jp?B?Unk5SWpmbnZNZkNMNXFjWWlxS21TN3ZScFdZL2JuWGk3Y0ZVcXhTR0g4?=
 =?iso-2022-jp?B?RGRDK2tOU3QzZmFUR1A2RjRUVEVCQjkxSVdsdWl2Y2pacUNXNU5GaW9Z?=
 =?iso-2022-jp?B?QjBiS2tpcU9LZlAybFJwVTkrYmJRWHpXV2FrSVM4Ykx4algzMVIxNXBM?=
 =?iso-2022-jp?B?NS8xMzkzeFFLVFhjRWlzL1lFTGNvZVFlM3ZLY2JhNGkzSEM3R1ZObVNn?=
 =?iso-2022-jp?B?Z3M2bWhhTi9JNEpSRi9WZ2NHaU12RmxxcThYTGFRNWlSVHBlbWdCVERF?=
 =?iso-2022-jp?B?eSsrd2tqcmJlRzNBUVRaOExBam04SytMbWFWN3lhcnNXMHZyM1F2UDVM?=
 =?iso-2022-jp?B?NjY1VWJJR213dFlVWks1RnU3WE4vMVM2Vm1rZ0p1Ymg3SGFvRGptVmEy?=
 =?iso-2022-jp?B?eVR2aFY5ZjZNN0xzZjl1RXJuNTNpK20zM2tab1NkZTlJandPNU9mdGps?=
 =?iso-2022-jp?B?akdCeUNGTmVibVBtMFJwN0tuVFRrNWp3MW9XQkdkSDgvd2F4eHJDNFU5?=
 =?iso-2022-jp?B?SGpkUmo3ZGZibDRpbjYyTGcrOEFpKzNPZkYxc3U4cVNZcFQxaWtvUlZN?=
 =?iso-2022-jp?B?NG5OWVpES2Urb1JybDN2d2tKeFFRVjllMENPZnhkaEVIQzFBVUlBdFdm?=
 =?iso-2022-jp?B?NUhZVEpnV2VWbnhsL085aGh0T01PQkxlYS8xS0xmY2ZxTm9KVTczMCtm?=
 =?iso-2022-jp?B?VnlzVWdBdS81enlDaUlaY0QvVERVQnRQdlNUSEdOdkx0NHNTODBJQnRQ?=
 =?iso-2022-jp?B?TE53SVlSM255bkI0a2pZTTFPT3pFOXlaRisvbDk3b1ZORCtvUU9wR2tM?=
 =?iso-2022-jp?B?d3hla0RmSXdQNWQ3SmdPUWtkeWduNXFrdW5LUmVoQ0tsdUhuQ20xMWgz?=
 =?iso-2022-jp?B?Qzh3cjVHT1pRZ2FWWVA3Q1dUaFIwSkZFSEZ6VUtnTGdnaXA4dHN5dURL?=
 =?iso-2022-jp?B?QTdtWjVabTNzaTQ2U2Q2N0pWR0lpL1Mwbk05RDR5SFlFeGM3cmpCTEFS?=
 =?iso-2022-jp?B?MG9lVkRDemJqaTFJb2xGZXh3Qk1FRnBUUStKcW5rUHpjS2xsYTdlRVg0?=
 =?iso-2022-jp?B?M2RWMmdPWnlwNXljUmk5cHpxY0d5MXU3TlArOHBxTmtoQ2Y3WGgxSnZL?=
 =?iso-2022-jp?B?OEtlVkZFUzJQMVpRalRFS2xVRGp4cXQrL3Zmc2ZIMDlNVWpCZ2tNSGFK?=
 =?iso-2022-jp?B?WjV0T0FiT1FFZy95ckJiU2FJVjhLM3NZazRCL2ZwVk1ubFZjeXREbFJ0?=
 =?iso-2022-jp?B?YVhua1hKeVdjRjU0VHlZMFg1RFBUUGNWSi9aOGpGZm16YWJvem5LOVBK?=
 =?iso-2022-jp?B?YUoxQTZDS2FGNkMxV3Z5Uit1LzFRMzNVUldMN0RSbFpjcmZidktQRnpq?=
 =?iso-2022-jp?B?NkdOWGZPY2NwaGRYRG81cnVhSFloRW5FQ3hFblJpWVBIdUlLYTRFdUo3?=
 =?iso-2022-jp?B?NG41dm16SXZHTStmWStBZHZjMFRKdXk2clBDOXA1M0ZuNWg4SWcwSmF0?=
 =?iso-2022-jp?B?RmVSNEZ3NG1VTGsvOERRam9SUUVwMGhwbCt0LzBqMjhlNzREaVNtVmhv?=
 =?iso-2022-jp?B?cFpKRG5JZk1LK1JvUG4xSi96d1JVSkR3cW50RWg3T3NWQ2lNNkhsblc2?=
 =?iso-2022-jp?B?elozUVdtU2lPZGNnakdtODhndGlVPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <1DDE4C6DC114F9469DEF87538381692F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf277419-52e5-47c5-bea0-08d936218ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 08:33:15.3676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwdyLcvv8McRz4lMr/cmTV1piEWOCm/NhrAeiI1oldUCm86yuF45YIKmlgLRQUil4bsr0KfrMUDL42bpL3fMKLrMnVetcX5xG86TGerCIWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4950
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/21 10:17 AM, jaimeliao@mxic.com.tw wrote:
> You don't often get email from jaimeliao@mxic.com.tw. Learn why this is i=
mportant<http://aka.ms/LearnAboutSenderIdentification>
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
> Hi Michael and Rasmus
>=20
>=20
>>
>> Re: [RFC 2/3] mtd: spi-nor: core: compare JEDEC bytes to already
>> found flash_info
>>
>> [+ some people from MXIC as they are ones who posted to the ML
>> lately. Feel free to forward this mail to the corresponding people.]
>>
>> Am 2021-06-21 17:23, schrieb Rasmus Villemoes:
>>> Macronix engineers, in their infinite wisdom, have a habit of reusing
>>> JEDEC ids for different chips. There's already one
>>> workaround (MX25L25635F v MX25L25635E), but the same problem exists
>>> for MX25L3205D v MX25L3233F, the latter of which is not currently
>>> supported by linux.
>>>
>>> AFAICT, that case cannot really be handled with any of the ->fixup
>>> machinery: The correct entry for the MX25L3233F would read
>>>
>>>         { "mx25l3233f",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K |
>>> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ ) },
>>>
>>> while the existing one is
>>>
>>>    { "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
>>>
>>> So in spi_nor_init_params(), we won't even try reading the sfdp
>>> info (i.e. call spi_nor_sfdp_init_params), and hence
>>> spi_nor_post_sfdp_fixups() has no way of distinguishing the
>>> chips.
>>>
>>> Replacing the existing entry with the mx25l3233f one to coerce the
>>> core into issuing the SPINOR_OP_RDSFDP is also not really an option,
>>> because the data sheet for the mx25l3205d explicitly says not to issue
>>> any commands not listed ("It is not recommended to adopt any other
>>> code not in the command definition table, which will potentially enter
>>> the hidden mode.", whatever that means).
>>
>> Maybe we should ask Macronix if it is safe to send the RDSFDP command.
>> Can anyone from MXIC comment this?
>=20
> For this part, we have validate RDSFDP command on some different chips wh=
ich
> are not support SFDP mode. The conclusion is that Flash didn't reply anyt=
hing.
> But we still not suggest to using commands which are not supported on the=
 Flash.
>=20
>> This is also interesting because we are discussing reading the SFDP
>> without reading the ID first.
>=20
> I think this idea is good but I am not sure how other vendor chips will r=
eact
> after getting the commands which are not supported on the flash.

Do any of these flashed define an extended ID, i.e. more that 3 bytes of ID=
?
Rasmus, would you please try to read more bytes of ID?
