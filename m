Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B113931C0E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhBORp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:45:28 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31952 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhBOR0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 12:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1613410006; x=1644946006;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=PzA/SS489QN5rxjFkBxYo8rSotDynw0L+296WG2CIvU=;
  b=SntbGhlganR7a97VG/7+IZXxahNOG5vjHIJnv0wVTPizluwg11hQcEX5
   ysRWBzDxDI4d374F5Se61Ekm/0zKYOmel+QHejYm17JYtfVmBjMsZImkX
   1oFoJ2BRm44r+Qn/gLBPu6L6zJB008GsOkxTFlK1zDGsCW9GLygcpazU9
   ypD4Jb6SUfwMUwNh9Yc8PX52rXyeIxUby6VLgWWBIZEUG64hE/9ryt1zw
   vZ+1BpOqv+57AnKJyAEUYPpXcqHVFhNNzNVAtArocHIQwdfOJrEikoX6R
   F892F/c5h8DPXqmgBkOos/VewlJsdXFS23m5CV0/B1MnKt4qFueyB+DJj
   A==;
IronPort-SDR: rsDGgZnWFO3nEREfHsriV9b42wYe0Gixgmg1BPBPTK1LoC2HxdV0QoUbZKTKLa/fMyH7E+0h9Q
 xvKfvgS+RT6mkPtyMNPlI9Gk4HKKM8B7traMShSz7kEt9WV0lwI10getyQufLi209A+MjbY2i5
 KZSCK9J8v1r+TgnGaSPjg2tc3ya+Q6WHU6JrFcBHaLh2YOT4ic8/kCwxUr9ZvsUljf52NTtPMX
 B4VZhdua1XupPWHSivwCdieHkgvAmt5tBE95VfBBtzTXYr7sZTkQ+BHOkJoT95bxorF+xoDf2F
 TsA=
X-IronPort-AV: E=Sophos;i="5.81,181,1610434800"; 
   d="scan'208";a="115144831"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Feb 2021 10:25:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 15 Feb 2021 10:25:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 15 Feb 2021 10:25:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiLJUtnBwgRwF+20NVZslEKcPvA5/v9JMKXD7cZ9LpUXRZ8EA0t4Koqwprtln2w2JGLGqh7PnuykNtucKM5wJQX5dhdVivOFbedm0LQmfQk/BY5YDQ6kYtbKBBzq4T/N6UQ+zSiSzV//vZnDR1ZxkIVj+v0Q7Jtv4Rbcog84x01yEOvL8WmmEFM5ruqQHjbtOm1jGvNejztY/wi2aDHmZUmnQUjcZCqgEzJYVBZaLCAa1k92lwxa3WeTJx5iefjl4mF27ExGOOte1Cs7fa+E/uc/vLkj+6TL+vwRnmogQxEgM4/zyF5d+YVqOySWWuFVH18cS5/vOJYNrnDQJKSr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzA/SS489QN5rxjFkBxYo8rSotDynw0L+296WG2CIvU=;
 b=oAI6CYN0CIig2+wBY8wXRcAInVtnYn7HdirDyIW2YcsYHl/DiwYr2K+qXdxUSYegrvEarlhBeIk8JOdfahVw/jJhmK3nwDNryI9p0PTlird/oBWB6w6uP3UHUYcN7D+cOJqjqLxaxYsFjzeCfLLZKN5sSp7VTy7zhenihMhr5Sj+rH/LsQbwhBD89yJ5RT7L+2Q0qjiN6qyIyjnqwrTbR/2JEaEe4sT83hoKw+bGV9FH+jax9ptB7EY26jp3QSRKxjJE8vSlp2rrFXoaS95ooDk1vAQQ7Fo1qywFXQ307qKeBHqahuW3c4KlDIHVFeJMj12X6GCkuBFyI/vY6aKyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzA/SS489QN5rxjFkBxYo8rSotDynw0L+296WG2CIvU=;
 b=dAJzObGFZ8WpZ+CYIMk4+LuSbSiW5wQ2iI8rP05k8SuzYosxgwYjfy/lTdmFQgdt7XyCjwV6Dt9KPntG6PohJlHoGZ3vkXlTZ3lksaKl6CZQvdg4iKZxUMzYCRR9qWCbzJXwIAB1JPlrc7n8962a75LzFmqXjeEHkiSgeYZWVQQ=
Received: from CY4PR1101MB2279.namprd11.prod.outlook.com (2603:10b6:910:17::9)
 by CY4PR11MB2005.namprd11.prod.outlook.com (2603:10b6:903:2e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Mon, 15 Feb
 2021 17:25:29 +0000
Received: from CY4PR1101MB2279.namprd11.prod.outlook.com
 ([fe80::7175:a8ee:6351:5a11]) by CY4PR1101MB2279.namprd11.prod.outlook.com
 ([fe80::7175:a8ee:6351:5a11%4]) with mapi id 15.20.3846.042; Mon, 15 Feb 2021
 17:25:29 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <linux@roeck-us.net>, <heikki.krogerus@linux.intel.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Using TCPM for ports without Power Delivery support
Thread-Topic: Using TCPM for ports without Power Delivery support
Thread-Index: AQHXA7+OKoygPd4GXEGTVNQ1L/OawA==
Date:   Mon, 15 Feb 2021 17:25:29 +0000
Message-ID: <6cf411e1-8234-d1ca-541d-067665620945@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [2a02:2f01:5e02:3600::92e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8829555f-a9c9-4f16-2a19-08d8d1d6b0ea
x-ms-traffictypediagnostic: CY4PR11MB2005:
x-microsoft-antispam-prvs: <CY4PR11MB2005AB45B58B4728C1D80B63EF889@CY4PR11MB2005.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9hGW6qJLf7rmiy+Zpt/vhEGIKpOG/K0aJq+K9V1mikyKRTDvC9/JTJC/FCkW+ryX7SrGGRPgMIOhD99OQC/PeYdCWbRFgX1g0aqX4YB8+PgirMnawRgVHpH1RwMgIEfW7pf7tvt0/HILIWUYJRVKmL/0J0n0rrqjx7QhueeuHm9Vi/sL68VaprrN66QOBIenBTzLDizfmE4eSoDiiXDIWy4tcjggXaf+yVs7kHD11tZh3Sjy3e5fbKYwG2cKhaq2AUOrvDKW8ql88+ZEdae1AZb4w1aouoYj8LnUq50c8WWQVps4DCNhR2TpTuayctNe228lNxNW5mDxMAxotoLsXUdWdK97I8Nh/VeGuS4qJ+aH6geOwyAbB3V60OWx6NqoY5tc4HelvvJdS16MlRvCsrC2JKFhlPH5LteceyMhq0obdWEDfqOh9/UdgJ88uv+Mrgh5fcoEqEPo6+VvayJesWyE5LcMImkF08PU6J0pT66k8x8VximMDTcQ7Zz5T4pyYrsFIwrrTIRxJmSST/8Pq5mQcVwqLF5jfUK1ZTzt+MfHM113n+hw/UQfwtJPdwDbUBod0j+ffO5ij7Lrl5uBy7YivIoDGdVXThqy1kzI+wkske/N4UrwEuI0KWC9wJM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1101MB2279.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(186003)(86362001)(64756008)(66476007)(36756003)(8936002)(83380400001)(6486002)(316002)(66946007)(66446008)(76116006)(91956017)(2906002)(6506007)(8676002)(66556008)(71200400001)(31696002)(478600001)(31686004)(110136005)(6512007)(4326008)(2616005)(54906003)(5660300002)(43740500002)(45980500001)(36394004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YkZIS3d1MngyT01mRWxsMHZZbDQ4eTNUK0RRb3VDSjlHQ3J0ODJqZ08yendM?=
 =?utf-8?B?VUU0dnNjZmNmcFQ2SVl5Ni8wMHRXekcxTWJFdTMwNno4T3pzZEk1ajRBTmtr?=
 =?utf-8?B?aUx6MFh3Q29QMkJXbHRXenZxc096dk1wczRyTlpMVjMzNUpRNDhhOU91aCsz?=
 =?utf-8?B?VTlrYjNWNS9nNk5rTDBhTzJsNkpNMXRQTmlTSmdmQzVTR3p6d2NicTlxNjVt?=
 =?utf-8?B?NTB3MXBNa1MxYjYrN2FlV1ZKSDBKYTFtaHQ5WEJuWll1cWNzSnNXWWlJdFRp?=
 =?utf-8?B?dGZyTis5b255VlJjeXdCM3IxSWhFRXlqekdCRzNDbmtOMXpmQklFYlduMVJt?=
 =?utf-8?B?TnJHMENmcHRwb1BxRk1FbjQ2eCtMUzFaQ3pISDQ0MVk4UHhLLzc4L1BWcDc2?=
 =?utf-8?B?VS9FcmM4ZWNWakRMaVhNcXFuKzNSdTluSkhabFF3WUhqZkcyb01FK2pFOFBX?=
 =?utf-8?B?K0QvejVkazMraE9sNENoLzRMQkpSTmw5RWRzSzhkWU9lWkx3cGtrU0xXTE9J?=
 =?utf-8?B?NklKeHlycHdMM3E1T2tSWVpGeXRVUXA5QnppN3VhZi9kNTZnRFFNU1dYTU4w?=
 =?utf-8?B?bWhWRk80c2dTeWc0eGd3b0RYSUtLL2pCM0Q0OE0xRHBnemdBeDlvZlBodGtW?=
 =?utf-8?B?Qjk5QzArZ2IwY2dvcFZjYS9qUFQ1L25raDJQZkU4MS9KRzc1SHV5aWVIUU5F?=
 =?utf-8?B?YS83UEdDNWorNHVudWN0Vno3Q3ZMcUlCZnppeEFDRWtHeHhsRXRMRVVVSTB2?=
 =?utf-8?B?VDhzWU1TVmh4bmludkVabzFValR3eVF3OGxJT1dTLzUvbkpUUmIwVUlLajlu?=
 =?utf-8?B?SldWZU9oYUJtVUVTUkJab05jV2tQUWZTZFVhZDEyZmpLL01mTDZ6VjJjS3lP?=
 =?utf-8?B?b2dWRFZoK3lrdklRL2ZoZ21vaGhURlBwcTdQak1jNUtIVGU1WmlHMFR2SWhV?=
 =?utf-8?B?YXp1WkRleUcwd3AvTDN5Z1pRRk8wVTJVRHFQZSszdVp0bmh2UHdFQ1NRV3RV?=
 =?utf-8?B?eUsxQytMaFRITTVmRnZJNXZBaS81VlZJZDFJeWZOS0U3dy9uTmROZUhnMlJH?=
 =?utf-8?B?UmFJbUpxMHhGYnF2M0hiVmlFM1BzaEdMWFVhTDRVMjFpS1hkOVNGdzhoS0Jq?=
 =?utf-8?B?Q2VqMHF4ajRCai9DalF3ck0wdWdLNS9zaG11bFYrajAzbzVpNW1TTnpXNlNE?=
 =?utf-8?B?akJMNGZkckNIYlcrc0cwU2FXSlVUOFE2cDlMakZlK2JpSlJqRXRaN3BPOGVT?=
 =?utf-8?B?aGhUL2w2Zmx4YUpVSjdCTkxZM2FKVm9WVFpIRWQvSmtHVWhtMElpRUhqSnNT?=
 =?utf-8?B?TytsQ1hvdUZSUmdITFVIUjFpWmRiQlBQMGF5dSsyVXJZWEppcjhVeWorc3R1?=
 =?utf-8?B?VzJ2azdFdDV6SENTTDY3STAreWUybHpTVHIzODJpNmJ0M0diM0hEeDNmT3pQ?=
 =?utf-8?B?Ulgzc3RZdkt3UzZPMnkyTUJuYkdYWXhKSjgySUk0YXdWRHZLRm9YaFQrOEpF?=
 =?utf-8?B?QThzOVA2M3lIWEdsYmhFOG4reHZhSEt6anVadjIwQk5ZMnh0cS9Jb2xkVGwx?=
 =?utf-8?B?TW5tTDBFT3dEeWRuNGUvVU9IcXVINlpVSE1JTGZpMENJVjVIdzNHcER4K056?=
 =?utf-8?B?L3FJMURDRWFaZEFpZkZxa29zcmt2Wmhhb3JLREFIRGZKYU1CTXZ6UjNRUWJM?=
 =?utf-8?B?UmtiNks2Wlc5a1Q2U2VkcjFhK2k3UVNHdHdKSnNGT0xoUHVINkkvN2RFYVZT?=
 =?utf-8?B?QzV0STJ4Q0hqT0dVeDR3eDBpMWxqTWMyM0d6c2dqSkRjZU5CWDJnSTYzdTNL?=
 =?utf-8?B?cHVPYXIxSURvMGRwN0dXUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CBA1D065D031941A1037DE100E66611@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1101MB2279.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8829555f-a9c9-4f16-2a19-08d8d1d6b0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 17:25:29.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAF4QnA1mmPsxhOO7faFB+XZBBcxf3bEpJ70X45PUXSjUELZmc7vg1URmDEJ4fuDSzC6PAThvL2YEFmQs7PHYQSQrF3TYStix8W/ONugxxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk15IG5hbWUgaXMgQ3Jpc3RpYW4gYW5kIEknbSB3b3JraW5nIG9uIGJyaW5naW5nIHVw
IGEgVVNCIFR5cGUtQyBQb3J0IENvbnRyb2xsZXINCihUQ1BDKSB3aXRob3V0IFBvd2VyIERlbGl2
ZXJ5IHN1cHBvcnQgd2hpY2ggaXMgaW50ZW5kZWQgdG8gd29yayB3aXRoIFVTQiAyLjANCkhvc3Qv
RGV2aWNlLg0KDQpUaGUgSVAgaXMgaW50ZWdyYXRlZCBpbnRvIG9uZSBvZiBNaWNyb2NoaXAncyBT
b0NzLCBpdCBpcyBtZW1vcnktbWFwcGVkIGFuZCBpdA0Kd2FzIGRlc2lnbmVkIGJhc2VkIG9uIFVT
QiBUeXBlLUMgQ2FibGUgYW5kIENvbm5lY3RvciBzcGVjaWZpY2F0aW9uIHJldmlzaW9uIDEuMi4N
Cg0KSW4gYnJpZWYsIGl0IGhhcyBzdXBwb3J0IGZvciBkZXRlY3RpbmcgdGhlIHRocmVzaG9sZCB2
b2x0YWdlcyBvbiBDQzEsIENDMiBsaW5lcywNCmNvbnRyb2wgb2YgdGhlIGN1cnJlbnQgc291cmNl
IChJcCksIGFuZCBwdWxsLWRvd24gcmVzaXN0b3JzIChSZCkuIFRoZSBtYW5hZ2VtZW50DQpvZiB0
aGUgY29udHJvbGxlciBpcyB0byBiZSBpbXBsZW1lbnRlZCBpbiBzb2Z0d2FyZSAoaXQgaXMgbm90
IGF1dG9ub21vdXMpLg0KDQpIYXZpbmcgaW4gbWluZCB0aGF0IHRoZSBjb250cm9sbGVyIHVzZXMg
cHJvcHJpZXRhcnkgcmVnaXN0ZXJzLCBJIGNob3NlIHRvDQppbXBsZW1lbnQgaXQgdXNpbmcgVENQ
TSBkaXJlY3RseSBhbmQgc2tpcCB0aGUgVENQQyBJbnRlcmZhY2UuDQoNCkZvciB0aGUgYmVnaW5u
aW5nLCBJIHdvdWxkIGxpa2UgdG8gZW5hYmxlIHNpbXBsZSB1c2UgY2FzZXMgbGlrZSB0aGUgb25l
cw0KZGVzY3JpYmVkIGluIENvbm5lY3Rpb24gU3RhdGUgRGlhZ3JhbTogU291cmNlIGFuZCBDb25u
ZWN0aW9uIFN0YXRlIERpYWdyYW06IFNpbmsNCmZyb20gVVNCIFR5cGUtQyBDYWJsZSBhbmQgQ29u
bmVjdG9yIFNwZWNpZmljYXRpb24uDQoNClNvbWUgb2YgdGhlIHByb2JsZW1zIHRoYXQgSSBlbmNv
dW50ZXJlZCB1bnRpbCBub3cgYXJlOg0KDQoxLiB0Y3BtX3JlZ2lzdGVyX3BvcnQoKSBmYWlscyBp
ZiBzZXRfcGRfcngoKSwgcGRfdHJhbnNtaXQoKSBvciBzZXRfdmNvbm4oKQ0KZnVuY3Rpb25zIGFy
ZSBtaXNzaW5nLg0KDQoyLiB0aGUgcG9ydCBjYXBhYmlsaXRpZXMgYXJlIHNwZWNpZmllZCBpbiB0
aGUgY29ubmVjdG9yIERUIGJpbmRpbmdzIG9ubHkgdGhyb3VnaA0KUERPcywgZXZlbiB0aG91Z2gg
UERPcyBhcmUgc3BlY2lmaWMgdG8gUEQgbW9kZS4NCg0KMy4gb25jZSBJIHdhcyBhYmxlIHRvIHN0
YXJ0IHRoZSBUQ1BNIHN0YXRlIG1hY2hpbmUsIGl0IGNhbGxlZCBwZF90cmFuc21pdCgpIGluDQp0
aGUgcHJvY2VzcyB0byBuZWdvdGlhdGUgdGhlIGNhcGFiaWxpdGllcy4gRm9yIG15IGNhc2UgSSB1
c2VkIGEgZHVtbXkgZnVuY3Rpb24NCmp1c3QgdG8gYmUgYWJsZSB0byByZWdpc3RlciB0aGUgcG9y
dC4NCg0KUGxlYXNlIGxldCBtZSBrbm93IHdoYXQgeW91IHRoaW5rIGFuZCBpZiB5b3UgaGF2ZSBh
bnkgYWR2aWNlLiBBbSBJIGdvaW5nIGluIHRoZQ0KcmlnaHQgZGlyZWN0aW9uIG9yIGlzIHRoZXJl
IGEgYmV0dGVyIHdheSB0byBpbXBsZW1lbnQgdGhpcz8NCg0KS2luZCByZWdhcmRzLA0KQ3Jpc3Rp
YW4NCg==
