Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C9A3117E8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBFAoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:44:14 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:35925 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhBEKNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612520030; x=1644056030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RsgzIcNP22Db3FsegfoZ3+SKxgbIvmVAFr83eBDgFGI=;
  b=aQ3aqmd1+jMZ3pqH9rKLKrUh+Ozj8jol8hMJNVlaa7CUHkUu3IJ7vRlW
   D5x0eimmEqLRamC2X4PdeBjdAgO/DPjMUvhL9Eq7rX3pT38FFAf13cF4U
   nOBO63frXpLZgsazNp93sAe9SN4ZCrTTRN5x6UsOKZn6rXhw1ueSXJ2OM
   QhZ2rgrgaNnO2CBIVHF/391HHxhnLWyu1ryxiFCBpZlhBxaODyO8XOZ+Q
   9SUdsfDiIYWn4kk9hVzKspsc8myDMQkurCrj6z48wuoI+vBleSGeGtF6S
   Yqnr9nfQkcDZUd5Nihkez24WkYu/10VIhv6ZD6RNTF/U38uG8avmoVr+E
   w==;
IronPort-SDR: 8Pw6VaPYbch1HL7IDbnOYBYSsbhx7+USwzbCigWv6Jx4HMKjK9lbhdGLh5Lpb+pZ7WTLWxL8PJ
 SOvUaueA50vLnHh83DbXx8soT7hd7jwyigBB9eHhdCZWqQQa8Z4hyDPTLeOELHH5QfAOWxZZHj
 3d79G/EPzakemzjz9gmPfbx2GnjTRv8GRqG2FXd3KfXqr4nrWNwIf/DLmqh84r6ThyU+dEFmQo
 mkA5g852nz8GSxo2nLEYglJwC4OJINYgJYN5OyDg4WXMm/bXtSQIbr9G0RlC0dOcCLRug4pYtM
 aNA=
X-IronPort-AV: E=Sophos;i="5.81,154,1610434800"; 
   d="scan'208";a="108639801"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Feb 2021 03:12:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 03:12:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Fri, 5 Feb 2021 03:12:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS7MWOsck1e/5H4Qp91elek4FWXtnXWAoU1KZ7LzwVLym43XQVmWlMCbgbxHwF8myuZzyQMn2tDcI1cLMYf9yY8J/ba+FZuEkJksoXY4qVMz81LQlQ0hU1uj8VMW3rcRK1lEQ8ojHgomLqUYma8fCLu3o7vy17N+aVB1piZVyFjABcDcXzNDGCQycX2neVNPuy5DHABNdAfLtYJ79MDB+H/Kb7olSQGXvwzGMcr3n01qTFXU5m31Y6/cljNuO5WWBP/L1nVGhzg1y3SAMl1LnHvEDLDmByUyWtC0bRiTETNx/emgZBi6a/BovtL9DfigqGxRDr86xCP8EdkmeTnG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsgzIcNP22Db3FsegfoZ3+SKxgbIvmVAFr83eBDgFGI=;
 b=Wsfy4kC8TetSLdR5w2wd9b1+oipdrKNIxAFHXnP+AXfMZYF2TG6DkHrcBN+WNEOUjL6bDFAJhQPZgF+acmQtV38G5sfU6kMqamPNgV1FYquhqQ6GC3y2RmGcRYOZtRL/Rm/S96YwEmbmL1dTaC9vdlr+kzUUqvxWqr4pWFOspErES7wSwNf4JLrfhFtQcN6TQEIJiTkHp1B6otpV3SUZ7kkNGEYe9Wo33Wvbj/WAJCHm14DPYk43n5ma8+MX0taXN13wLUiSgo63xcq//wLipjwowpftXlfj81+ytYAv7uK7uMmiKvvi2TW9CMaab+u3aViDTi6Stpwd3I3TrB1FAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsgzIcNP22Db3FsegfoZ3+SKxgbIvmVAFr83eBDgFGI=;
 b=aut/UqA736j9H5uEUaolwNVFXyRQ6B24iccZ7tMPCdPG/yci2drrfei9QmZjRrGqNsK9LKYqJM+G0Kg+KAMGxRCzRLKLS0XxUObqxpDqAEZN8FW+tRNxLKrBuUUYT9CkIGwnPv9E1/QorwjQFORNo76It7ZSPGLQaLaNRN6T3IU=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR11MB1343.namprd11.prod.outlook.com (2603:10b6:300:20::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Fri, 5 Feb
 2021 10:12:30 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::d188:a2fe:7281:873c]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::d188:a2fe:7281:873c%6]) with mapi id 15.20.3825.020; Fri, 5 Feb 2021
 10:12:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <linux@armlinux.org.uk>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: configs: at91: enable drivers for sam9x60
Thread-Topic: [PATCH] ARM: configs: at91: enable drivers for sam9x60
Thread-Index: AQHW+6dpJBlA9WR+tkSqiBGswIFyFw==
Date:   Fri, 5 Feb 2021 10:12:30 +0000
Message-ID: <56ee9cda-7943-2f5e-c068-51eff7b021b3@microchip.com>
References: <1612518871-9311-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1612518871-9311-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [79.115.63.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48167a05-4786-40d8-c08b-08d8c9be8c14
x-ms-traffictypediagnostic: MWHPR11MB1343:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1343CE6F6DCA947963BD0A56F0B29@MWHPR11MB1343.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3VmpnaBtfE2quNcakkYRmLFKtux/ANO0AHs1s/7qSDBi2pVUvTi2MXPcYV/tHSKVumvzrIoB5SkEA0FaEe3bKuI6f7rU9X+JyVYjBBn8oyk0HZ29LOnvmSXNCeHgwnIF2vx3xl8ffQtAKoSG70Mw+mvIX+Wkqb9JktQhYSs0NOqXB2h9oT8DbeU5uOzD8QfyA9zPD8VLFiJ8A1XiqovZQWG1/k9F98LUQtLgV6rraLt4CCb8QiL0UZFfVBDppTWmt2NKGd4JuTZWgp8c6ig2C1Jn6WWAwJrw2LRuurITWb1310nK7NhC48Aw/7chjrlOynkeOG4U5GO55HUGIb8LRVaJKnnHoPKrw0rr2IIWFIS5aQTDmXgy1GAoA6ya3Szk7htweCwwpzdEpIgWw27dmLs1/1en6qwZyVLNPk8OnulYcLuNwIA/qDYrC1VeoFSd6lCArSUnh+t7aZ5dtOWqkHpMhcA/h5YMzFMWc8IMzeKwnQKeRb1LKXlKjt1+8nE+kDrMUTuHDxqUr58TkBZOxGgTP0E4bpFQqbI8aGIy8v8oTpZHQDBnxTZL+5HqhmId8nGFrQg6j/LZteJzGG6XZrA7TS5bgLiodsDt0Nyc1JZF4/ceEX458HP416b/gtUMmBwAeF/xdlu05ZEa97HLyk8Mi6eyHiY5uS8Z5rdyKCtMrM5C6vjl7Jb7+f2adM3UNZ5tXxE5XUugNGOn8h/HyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(346002)(136003)(396003)(5660300002)(66946007)(31696002)(186003)(2906002)(26005)(86362001)(66446008)(8936002)(6636002)(966005)(83380400001)(66556008)(8676002)(66476007)(64756008)(4326008)(71200400001)(2616005)(6486002)(91956017)(316002)(6506007)(53546011)(6512007)(31686004)(54906003)(76116006)(478600001)(110136005)(36756003)(138113003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2z7uFqwBzwBKEEye8KRk9L7hV+3UuZTDl8s2nZtDhZ3xexLzmMV5Dn1pRW73yve2ueVQAPMT6uZM+RfLppby3DNG1oqekVGq6IXAMrmeq/XnlDJtmijkNO+KhgXjTjmnQ0KAis//nTkn7BPpUUzIdQnC7axAnHQK8Wrt8Tu0o2Bm0Ndy2GzUvPNVDsMbx6FGmeh/guyKXJThlCsaswm/vVG/94IkT2Mjxy9GJixm8ZcPjkmIU8tOSAhy+sek1xzwbpBpuhxdG6skTv7j66zL5cO9tp+DN6d6ExTlNyk5gJpRUVOD/JSHiEd8SHA1yX4efXsfB4dHEKpjHXAUqDt6Bxz0e6v6IWgxTZOzJBPDkanhOrdVomEALVnKzmn+16Yrd3WIpGlERZRoL8wsLom8tVEd0sxtQcXKD31mWG/RLRdgPFi23XiurGhy2SMOAYeNkDLZ5tGIwgokUkKZttn0RSJgIU/w+BjtcpANWsS4CWBKH0vq4aZvwDNKqHrurxx1l3EwmpcMyna7zrcLSo/yBjHc3PIMnJZiNgwiluo2/+uI1aQFWmTThi9OMrEpfLsD9Buv9aKhMVlNDuwgnG6ogK2tsx70cB15APSuW+IWWka/Q0exVWXIs26/7Z05twdKSHgieSXzJ15QPu8NphQpmgZtxTNs1fMaNsY/dsO6C5A+3bDCTkGnDl9abMTHjypbRGgx+tKtRc+3k0zPEEiUnE+gZIe10/sBMPKUSLxm9kI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <554A869304C66149972994FECFDDE9E6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48167a05-4786-40d8-c08b-08d8c9be8c14
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 10:12:30.2849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6E8f6jI7rfL4DCKLAxFLFhOGuMSVL2Z5+b1NsLoNM1WdgEloMLw2EREDgPbRYKdnm8CiOyhVi3N7zJbVzgKR2fk5tdZBokV0TP6mhOylJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1343
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi81LzIxIDExOjU0IEFNLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBFbmFibGUgZHJpdmVycyBmb3Igc2FtOXg2MC9z
YW05eDYwLWVrOg0KPiAtIHNodXRkb3duIGNvbnRyb2xsZXINCj4gLSBDQU4NCj4gLSBBVDI0IEVF
UFJPTSAocHJlc2VudCBvbiBTQU05WDYwLUVLKQ0KPiAtIE1DUDIzUzA4IChwcmVzZW50IG9uIFNB
TTlYNjAtRUspDQo+IC0gQUVTLCBUREVTLCBTSEENCg0KQ3J5cHRvIElQcyBhcmUgcHJlc2VudCBv
bmx5IHNhbTl4NjAuIFNob3VsZCB3ZSBoYXZlIHRoZW0gYXMgbW9kdWxlcz8NCg0KPiANCj4gQW5k
IHVzZSAibWFrZSBzYXZlZGVmY29uZmlnIi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUg
QmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQpXaXRoIG9yIHdpdGhvdXQg
dGhlIENyeXB0byBJUHMgYXMgbW9kdWxlczoNCg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMg
PHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gIGFyY2gvYXJtL2NvbmZp
Z3MvYXQ5MV9kdF9kZWZjb25maWcgfCAxMiArKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vY29uZmlncy9hdDkxX2R0X2RlZmNvbmZpZyBiL2FyY2gvYXJtL2NvbmZpZ3MvYXQ5MV9k
dF9kZWZjb25maWcNCj4gaW5kZXggNWYzNDE1Yzc0M2VjLi5lMjc0ZjhjNDkyZDIgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJtL2NvbmZpZ3MvYXQ5MV9kdF9kZWZjb25maWcNCj4gKysrIGIvYXJjaC9h
cm0vY29uZmlncy9hdDkxX2R0X2RlZmNvbmZpZw0KPiBAQCAtMTcsOCArMTcsNiBAQCBDT05GSUdf
U09DX1NBTTlYNjA9eQ0KPiAgIyBDT05GSUdfQVRNRUxfQ0xPQ0tTT1VSQ0VfUElUIGlzIG5vdCBz
ZXQNCj4gIENPTkZJR19BRUFCST15DQo+ICBDT05GSUdfVUFDQ0VTU19XSVRIX01FTUNQWT15DQo+
IC1DT05GSUdfWkJPT1RfUk9NX1RFWFQ9MHgwDQo+IC1DT05GSUdfWkJPT1RfUk9NX0JTUz0weDAN
Cj4gIENPTkZJR19BUk1fQVBQRU5ERURfRFRCPXkNCj4gIENPTkZJR19BUk1fQVRBR19EVEJfQ09N
UEFUPXkNCj4gIENPTkZJR19DTURMSU5FPSJjb25zb2xlPXR0eVMwLDExNTIwMCBpbml0cmQ9MHgy
MTEwMDAwMCwyNTE2NTgyNCByb290PS9kZXYvcmFtMCBydyINCj4gQEAgLTM4LDYgKzM2LDggQEAg
Q09ORklHX0lQX1BOUF9CT09UUD15DQo+ICBDT05GSUdfSVBfUE5QX1JBUlA9eQ0KPiAgIyBDT05G
SUdfSU5FVF9ESUFHIGlzIG5vdCBzZXQNCj4gIENPTkZJR19JUFY2X1NJVF82UkQ9eQ0KPiArQ09O
RklHX0NBTj15DQo+ICtDT05GSUdfQ0FOX0FUOTE9eQ0KPiAgQ09ORklHX0NGRzgwMjExPXkNCj4g
IENPTkZJR19NQUM4MDIxMT15DQo+ICBDT05GSUdfREVWVE1QRlM9eQ0KPiBAQCAtNTgsNiArNTgs
NyBAQCBDT05GSUdfQkxLX0RFVl9SQU09eQ0KPiAgQ09ORklHX0JMS19ERVZfUkFNX0NPVU5UPTQN
Cj4gIENPTkZJR19CTEtfREVWX1JBTV9TSVpFPTgxOTINCj4gIENPTkZJR19BVE1FTF9TU0M9eQ0K
PiArQ09ORklHX0VFUFJPTV9BVDI0PW0NCj4gIENPTkZJR19TQ1NJPXkNCj4gIENPTkZJR19CTEtf
REVWX1NEPXkNCj4gICMgQ09ORklHX1NDU0lfTE9XTEVWRUwgaXMgbm90IHNldA0KPiBAQCAtOTEs
NyArOTIsNiBAQCBDT05GSUdfUlQyODAwVVNCX1VOS05PV049eQ0KPiAgQ09ORklHX1JUTDgxODc9
bQ0KPiAgQ09ORklHX1JUTDgxOTJDVT1tDQo+ICAjIENPTkZJR19SVExXSUZJX0RFQlVHIGlzIG5v
dCBzZXQNCj4gLUNPTkZJR19JTlBVVF9QT0xMREVWPXkNCj4gIENPTkZJR19JTlBVVF9KT1lERVY9
eQ0KPiAgQ09ORklHX0lOUFVUX0VWREVWPXkNCj4gICMgQ09ORklHX0tFWUJPQVJEX0FUS0JEIGlz
IG5vdCBzZXQNCj4gQEAgLTExMSw4ICsxMTEsOCBAQCBDT05GSUdfSTJDX0dQSU89eQ0KPiAgQ09O
RklHX1NQST15DQo+ICBDT05GSUdfU1BJX0FUTUVMPXkNCj4gIENPTkZJR19TUElfQVRNRUxfUVVB
RFNQST15DQo+ICtDT05GSUdfUElOQ1RSTF9NQ1AyM1MwOD1tDQo+ICBDT05GSUdfUE9XRVJfUkVT
RVQ9eQ0KPiAtIyBDT05GSUdfUE9XRVJfUkVTRVRfQVQ5MV9TQU1BNUQyX1NIRFdDIGlzIG5vdCBz
ZXQNCj4gIENPTkZJR19QT1dFUl9TVVBQTFk9eQ0KPiAgIyBDT05GSUdfSFdNT04gaXMgbm90IHNl
dA0KPiAgQ09ORklHX1dBVENIRE9HPXkNCj4gQEAgLTIwOCw3ICsyMDgsOSBAQCBDT05GSUdfTkxT
X1VURjg9eQ0KPiAgQ09ORklHX0NSWVBUT19FQ0I9eQ0KPiAgQ09ORklHX0NSWVBUT19VU0VSX0FQ
SV9IQVNIPW0NCj4gIENPTkZJR19DUllQVE9fVVNFUl9BUElfU0tDSVBIRVI9bQ0KPiAtIyBDT05G
SUdfQ1JZUFRPX0hXIGlzIG5vdCBzZXQNCj4gK0NPTkZJR19DUllQVE9fREVWX0FUTUVMX0FFUz15
DQo+ICtDT05GSUdfQ1JZUFRPX0RFVl9BVE1FTF9UREVTPXkNCj4gK0NPTkZJR19DUllQVE9fREVW
X0FUTUVMX1NIQT15DQo+ICBDT05GSUdfQ1JDX0NDSVRUPXkNCj4gIENPTkZJR19GT05UUz15DQo+
ICBDT05GSUdfRk9OVF84eDg9eQ0KPiAtLQ0KPiAyLjcuNA0KPiANCj4gDQo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwNCj4gDQoNCg==
