Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C5E4225CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhJEMBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:01:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9532 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhJEMBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633435152; x=1664971152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Sv9L1cKiwTI0DF4EUZSsUqLTe2F6YlzzuDcul4PuqpY=;
  b=FdXX38xVy14TKk/kdy2YK6vdtyHYh9dOyPSZvNof7eomSBVBfGW1tQZN
   DIOul1xyOG6T8Sz6eMmy6d7cFy58mgDymzjC0W7t8LFCKa1qx4DJdwxdK
   nIYcEhq+LoQRkPWufI14P6IeAvaigzm1FHt/UumHV8tOJvtM4oWD+y/Si
   +UjFMVgelcItlkS6nNBgCXsIpqX1fV+jX5N2BA6jhFaLjDuZW8lDUltHV
   eUMSHEtxCqcus8JGLw+FpfFdceGpPUBB+STJQQLacFgeO3FjOMcYy2aLI
   2gxwTKNIPsc3n7p/mC+SvCyz67lAYzrN7OPTqbyREhtt5BxuisV8nZBkI
   g==;
IronPort-SDR: /r9YpnEVbgWrv6BTxGGCNHRQ+Ou7aVC0Gc4FX7Hg72RamsnDm2kwJdOV4Ae1G/z4QFfJh4WVdt
 yNGMJ3AUnzNFSzfoIb1jBGRMi10gE7K1uQzpnf2SB1Vcjk+xI15pBwWBcX9VMUgNtEWc8nGAz5
 PTeIlVd+yIZpvqR4v5eDpfDHu6TrJJc8PG+OmtM/XauxOD57WTdPiX27FfRX4fdCiXI3s2tA1J
 a8yNiBQfluXr0HJVFra1K55hr+Z1g/EstbkXWzvnC+XYHZ8DwvK5epWfJ3q5EeOothyPOtE11B
 A1hWCi5o5G9UPeCKDrksohcw
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="131774613"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2021 04:59:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Oct 2021 04:59:09 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 5 Oct 2021 04:59:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWONGIB1HFxJDZO17Jl0MpDyIaiM+U6SexZrehfMJ3DYHmwAmK4qMYCCBaF2Q6+9IhjWIGYrx4K719VKqYCIM65QSxVUX9iiOXztQ0E9SPPGatQKU4jr+6x9vfnCULxjHt5EalX3sC8XPM5hEGrUS4v9UDH3y0KhsVicuqMLCen9rEfexLChdlIykoS+vthYX3JVKAgKhb6/f521mFLPn6731jOLGOoraQawFxTft2komB8/MjOFUCo1o9MNoR+a1QJo4F2gJfDVTA68k1jmmkSc6aJzzUIEcBPIWNq7et+ZeZAtdrs0K+lb7k+vxDuaVVADvMObhgym+FSLR+KFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv9L1cKiwTI0DF4EUZSsUqLTe2F6YlzzuDcul4PuqpY=;
 b=fNS7SSK/ezog74xStHQaQnNHOkZO721QfNch4RAG8V78+HhC3hkK60G1a0PfGZXnqNrjhJZQ+JdHMwtBgKrhnX43dUwqCQWtRB9FQIBoTqbNVXDdNefTitJLElghRIFTzXyqR9siTt1eJ62dPmwksBmQinroGcr3/TdcEQMaM/DxmdxyHe/9rwTkidgqjQk05+0N4yol7CXa4w/E7FfDRRGUAwSSIfMiazr9jIPzeFT+Qr5odsot1KreGDgds3Xe2aOo/GuVzk0TwHmXb7zwL38pG0HqOyV1NPm7+DGq1QlEcybAKQgfGueswj2eJEhSntcP0tYqn7wsreNQaNwJbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv9L1cKiwTI0DF4EUZSsUqLTe2F6YlzzuDcul4PuqpY=;
 b=BTC+WKUszgSUSxpwk3wmNXM+xpQG5KkT7BOJcA6lX/IpyG3m+R2bWUEVP4iGT33tIFFB9qeIEzeS8sBM7hrsI5rYeAWnLHWdFR4hfgyx384Kjj/yaEOdZFJWT+2D/rvZ0DrmvyVhXsS6sOjL0KHtIXfMsXyJw3XL50lRarEUNDI=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Tue, 5 Oct
 2021 11:59:06 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213%9]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 11:59:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <pan@semihalf.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <dinguyen@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <tn@semihalf.com>,
        <ka@semihalf.com>, <jam@semihalf.com>
Subject: Re: [PATCH 1/3] dt-bindings: mtd: spi-nor: add n25q00 schema
Thread-Topic: [PATCH 1/3] dt-bindings: mtd: spi-nor: add n25q00 schema
Thread-Index: AQHXueBlWAsH9XInxEKPAzzwFW/4og==
Date:   Tue, 5 Oct 2021 11:59:06 +0000
Message-ID: <0b9b656d-df4d-6062-2b0d-70aea02f378f@microchip.com>
References: <20210920124141.1166544-1-pan@semihalf.com>
 <20210920124141.1166544-2-pan@semihalf.com>
 <20210923185902.6wgkuz4jcelcawrq@ti.com>
In-Reply-To: <20210923185902.6wgkuz4jcelcawrq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6ea917b-4685-46d5-6b37-08d987f7888c
x-ms-traffictypediagnostic: SA2PR11MB4891:
x-microsoft-antispam-prvs: <SA2PR11MB4891AB5D40D05E8C48FE4447F0AF9@SA2PR11MB4891.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6SIaaNS3VEEgIg4ZYd9eS2WkM270lQ3QGX0wx3E8+BKXZWoIbPSqgy8wHzxGeMRR92ytu5qpy5HuNifU5A5cU+VG9+xBySztyaFQ+JwmATurw/n7ULZHNz/NQ2bDK9hYq7UuYo1cQpTxE/8YSzXG3RdtUhK4+SJuS4gnVvn5GhnsMDhwHF61PD5pLQsu/UEmsh7NrlpuQFe8CnLc0Y1dRVPpxpXL7Dsucvjf0lmEXvcOCAeh1IXPCVq3h9ln6Fmfv2aj/KwP/WBXfPMf6XmG2sv5ZolMV/ZV3b17EieI70jCCYgypcELaJtdqk2mHrrvXQUf0kfInd63vpv2VeKohVPpYbLZNzlkXlhppLGcxqEQBq2LdGw5GSXwmYkuwULrZ6hd1RCvN2ogknIVVuE3U/Ze+mWlQEIQ5s8IG7pQzHt3ytqwlnW94RbAz62KLPDv7qRb1eazb8PhdALcnB/U6OseNtrhmjrvn8GoBRvfRy93WjjY9jMLlLk1bBmtbRlCwbjQ8PfzHYYQ18qc5DtEZpxglEX+quWSCggu+oyj8N2ylzpM+DKsSYjm5066/qQjq+6j2cdanc6ytx1bAzeXx/Mq35nUDmyMzVcZSquiXeG8xVf5t5+lD2+NohwxBELPFTT5QGhnV5XtwH4XCjoKDkDI3bB6HMLJoHhPuwWSji9X8M7Wysy4SHVICNlrnvcRtErtwge/x5nG7s27lUtJjCUq3gfwXwZtqxFTJ88KFHHcccSHDJjW9yCka1UkNCOjM+tRpv8vGdbgB2pn248ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(31686004)(71200400001)(2906002)(4326008)(86362001)(8676002)(8936002)(66446008)(54906003)(110136005)(508600001)(31696002)(91956017)(64756008)(83380400001)(6486002)(36756003)(38100700002)(38070700005)(316002)(76116006)(2616005)(7416002)(5660300002)(26005)(6506007)(66946007)(122000001)(66476007)(6512007)(53546011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alpKdThjMXlSdDdxYThEK2VEMi9MQnFreEhDNFdaeHF0YURqMGY4WTVVRmhR?=
 =?utf-8?B?QkVmdHJBYW0rRE4vUUVVV2RnVzNWVzRVeVdaRHArREpvMU44NnZTalVjdE8r?=
 =?utf-8?B?KzNWZytQeDhzS2EyNkpGb2czN293YUZYRElWYXJ3NUtmd3JBaGlzcWVsbDdE?=
 =?utf-8?B?eFpiMUpWZEIwekNNRjc4RzhwQ2RmSmNtS3k5SThtamt4YXVpS2F0ZDlnMDdh?=
 =?utf-8?B?NDJZakd6Yk1UQ2NTQitMbUtPL0FoQWlJNXV3MUN6M1JIYU03WGJzbGdNSzZH?=
 =?utf-8?B?MVhycmZwTDJJRjhlU0lpaFpzTmY2WnNhbUJVekpTTm50UFJSU2Z5K3NLZC8y?=
 =?utf-8?B?ZWNjN29XOUpseCtzb0xRa3Z4SklQMEI4dVZqUy9scHlIaDBvUXhjWUo0QXM2?=
 =?utf-8?B?cU9vOG05NFBiNVdkSUdoWXYydVU0N2RTZHJxaU9xQXFZeGc3R3lwQjZLdmZE?=
 =?utf-8?B?bWgxci9KcVFhdWFnYTZYVENhd0xDZE12ZTVRSTNvYUFCS0tBU3JNeXVWd3BI?=
 =?utf-8?B?Wk8rVlNzWlNUd1VzdEl2OFpMeWtsa3ZvdzBLa0lyMTJ3ck5OSWdZTm16NFVt?=
 =?utf-8?B?cHFTWXJWTW1FeG5vSm0vY2ZIUWZVSXlzY3lVSzZKUDh4TkNLVTZOUTdQbWNY?=
 =?utf-8?B?T3NEM0RTK0JCTUxwTWtxblBXYlNCbjBhd0JmOUV3T3VGM045eVpPODdGMUtC?=
 =?utf-8?B?WW9ZL0VNMCt4L1g3VVJzMW1wQUt2Z3R1V1hzZllPY0pjOXdqSlRuQWF0bnRq?=
 =?utf-8?B?STc5VHdjaGx6UXBuMzVCeDFyQy9iVTFGdngxaURSKzhqWUpRK0FQV1VidVZU?=
 =?utf-8?B?NEwyeFhyR0hJZEdvT2xYSHpiOXdZRG90UFZQdmc4WlYxelc4c3RKSmlMbm5E?=
 =?utf-8?B?ZTJxbXJaV2JtRURMM2VZV2hUVnNsSC9RTkN0anV2UytzdlhZWnlQcEhZWGdS?=
 =?utf-8?B?UlBVL2RkVVZHRWVCNE9vVERLK2RTLytncmRoVkZUQkFNc2NRNGdNVWlkbWFS?=
 =?utf-8?B?Z3lRR3FVVWdhbC9VelhaNnZ2STlEaU50dDJSQ0lqRWlZcmN6Z1lSaElrclZi?=
 =?utf-8?B?bm9TYzdDK09IZTU4Nkd0QzlRZVluVWYyREprc0N5Y05aRkd4ZUI1WGFhUWo1?=
 =?utf-8?B?NWFlbis1VFZRU0FQM0dqY0J3dGc3RGp0VnZqVlN6YmlvbVc2RDZ4M3R4UU9P?=
 =?utf-8?B?N1E4bkJydzVyUmVSbFB3QVVuY3NzWGhIU3BzWkZjOXNHWENFSEhZMEdUVEs0?=
 =?utf-8?B?dktKUEQ0R1NLTVh5OWkrQ2dkTTlVeGl6cXpzK0ZDbzlLWk11M0R2NlZtbDNT?=
 =?utf-8?B?VTRhcHVEY3VoS1lYeXhxWVBrM2UrNFVPU1lubm5EMExIK3V0V1ozSDI5bDhn?=
 =?utf-8?B?QlNJUm43aDZLdys1bDFndE52QUZlYS9Qay9CZkVWMjFSOS9PZTBXelpuM2sx?=
 =?utf-8?B?dStkN1g0ZXZTMzY4Q1dFMTZLOXU5MHh4Z2ZvNEo4V01qNVRpYU1uenc5dzJP?=
 =?utf-8?B?a1hmRVBkOU5NWkk1L2F0b3RNTjhvQkhCZVBwNjdUcU1RckhVeE54TTgvTGhz?=
 =?utf-8?B?MEh6NktSSjE3YXlnU3NPRWp5NHpjMFJIcmlEWW56a3pBL3A5dHhDaE5DS1FQ?=
 =?utf-8?B?ek1seEhUeW9RTjhEVlpQWExscnZqUzJXcFpQeVR3a2J2WGIwb1ErcGVzUjc2?=
 =?utf-8?B?azZGcElDUHNaSUdzN0Z6b29EcGE3WXhsUU5reEtHWjRtUW1QTkxyQ3FRTCta?=
 =?utf-8?Q?9evUQ3VhiRh/7P51QA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <65FBC323F6F7DC4B9825042572F2E3CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ea917b-4685-46d5-6b37-08d987f7888c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 11:59:06.6444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KV3aFXsRTw9knZgyYF9UpOQLO+j9sb5yeQp92pHu3nIF5irLvxCHCApw7FRQYQlnoyvtGPbtKLSIRo//HjQlxCiRvR2+FvsjdfYOuI/YrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4891
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yMy8yMSA5OjU5IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiArVHVkb3INCj4gDQo+IE9uIDIwLzA5LzIxIDAy
OjQxUE0sIFBhd2XFgiBBbmlraWVsIHdyb3RlOg0KPj4gQWRkIHNjaGVtYSBmb3IgdGhlIG4yNXEw
MCBOT1IgZmxhc2ggbWVtb3J5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBhd2XFgiBBbmlraWVs
IDxwYW5Ac2VtaWhhbGYuY29tPg0KPj4gLS0tDQo+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL210ZC9qZWRlYyxzcGktbm9yLnlhbWwgfCAyICstDQo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvamVkZWMsc3BpLW5vci55YW1sIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9qZWRlYyxzcGktbm9yLnlhbWwN
Cj4+IGluZGV4IGVkNTkwZDdjNmUzNy4uZWZiM2M1ZTA1YzVhIDEwMDY0NA0KPj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9qZWRlYyxzcGktbm9yLnlhbWwNCj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvamVkZWMsc3BpLW5v
ci55YW1sDQo+PiBAQCAtMTgsNyArMTgsNyBAQCBwcm9wZXJ0aWVzOg0KPj4gICAgICAgIC0gaXRl
bXM6DQo+PiAgICAgICAgICAgIC0gcGF0dGVybjogIl4oKCgobWljcm9ufHNwYW5zaW9ufHN0KSwp
P1wNCj4+ICAgICAgICAgICAgICAgIChtMjVwKDQwfDgwfDE2fDMyfDY0fDEyOCl8XA0KPj4gLSAg
ICAgICAgICAgICAgbjI1cSgzMmJ8MDY0fDEyOGExMXwxMjhhMTN8MjU2YXw1MTJhfDE2NGspKSl8
XA0KPj4gKyAgICAgICAgICAgICAgbjI1cSgwMHwzMmJ8MDY0fDEyOGExMXwxMjhhMTN8MjU2YXw1
MTJhfDE2NGspKSl8XA0KPiANCj4gSUlVQyB0aGlzIGlzIHN1cHBvc2VkIHRvIG9ubHkgYmUgZm9y
IGxlZ2FjeS9vbGQgZmxhc2hlcyB0aGF0IHN0YXJ0ZWQgb3V0DQo+IHVzaW5nIGZsYXNoLXNwZWNp
ZmljIGNvbXBhdGlibGVzLiBBbnkgbmV3IGZsYXNoZXMgc2hvdWxkIHNpbXBseSB1c2UNCj4gamVk
ZWMsc3BpLW5vciB1bmxlc3MgdGhlcmUgaXMgYSBsZWdpdGltYXRlIHJlYXNvbiB0byBkbyBzby4N
Cg0KdGhhdCdzIGNvcnJlY3QsIHRoZSBnZW5lcmljIGNvbXBhdGlibGUgc2hvdWxkIHN1ZmZpY2Ug
Zm9yIHRoZXNlIGZsYXNoZXMuDQoNCj4gDQo+IFVudGlsIHlvdSBqdXN0aWZ5IHRoYXQgcmVhc29u
LA0KPiANCj4gTmFja2VkLWJ5OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQoNCkkg
YWdyZWUuDQoNCkNoZWVycywNCnRhDQo=
