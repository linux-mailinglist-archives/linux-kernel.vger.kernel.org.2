Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3143F1957
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbhHSMcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:32:10 -0400
Received: from mail-sn1anam02on2041.outbound.protection.outlook.com ([40.107.96.41]:18494
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238931AbhHSMcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:32:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpeLH39zG+akAuTEOAbJ8QokB4NW4jWmOK/bn4S+5r3Cde2osX3ZYh45+ssMZY1aoJq9pRh/Ey4FH248Ti2zlqSASoKLAGZ5YZfcmYErJ90yW36lfIugOa1mImQG2G9ONOqZ1iFbYmY9W8RtP8qU6llvVjlrmb8g6dD+NFSb++ONjctPFCkEVjYlRFs256NucMGx/QpCziWIYUWp07KyASH0C09gtPvOrnJAVCUNiWkHiQJJuFvR7nTgqbqRJxcksvm6g1DXKDvSoWE1r9O0aDrttpEnw3u1Vk8oaEf/MNdnJGnKyyky0CVF978AJqVqsF8rVlik9ZeP0vtcg82+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWR/4u2dwk9HUXUF5IIv1Dl+vr0XLmfgQzH08JtRm3A=;
 b=Dd61cK+rtSJ3qC4ThWsO3OG+GqK0d5dMY/eRFnjV8ylPiyaNmCF6b9WVtEzSMRXbiUgouxjC2Xxx4RICykUBSOTN4GnGG55QRz8SROwF2MxW2t+o1Wmhz0CHB2C/1nzUq9SoH7NS7AA9LAt9WwirP8rxB7hL81Kqe+XqHpqyFfMjjOybRWEjiF7T5UWEZxUC6QoHX4SHie56K2ZtOgysZMjVjAdNQ06jURtByebFi8j+CTnIBd7odlSwfm5MMrN+vUk2fa9hGqV7Qs12+AHGX4x0gJ1PaD6GeYMD89/24K/vKmSwxXMI8GRSqh2lshYdfCyBPrKMQ6jfbA6Cv/GdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWR/4u2dwk9HUXUF5IIv1Dl+vr0XLmfgQzH08JtRm3A=;
 b=LyrRjcNFzHB9prfTDtLsswwc6YG1rLf8U3pbE7kc88mHh9hGxUP3U+zpeO0ePix/yHGOCR/iTZrYkVD4beM4nvDnAUtXrEA3ybAMk48C8ymsiS5W4S7+pMIQ3+qos5xTWOYz4bQngj0WZgJv0i8naO4z68pIOgPR/mpkJ/mnGlM=
Received: from DM5PR05MB3452.namprd05.prod.outlook.com (2603:10b6:4:41::11) by
 DM6PR05MB4763.namprd05.prod.outlook.com (2603:10b6:5:16::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.13; Thu, 19 Aug 2021 12:31:31 +0000
Received: from DM5PR05MB3452.namprd05.prod.outlook.com
 ([fe80::94c0:39f7:9695:56ea]) by DM5PR05MB3452.namprd05.prod.outlook.com
 ([fe80::94c0:39f7:9695:56ea%3]) with mapi id 15.20.4436.018; Thu, 19 Aug 2021
 12:31:31 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     Wang Hai <wanghai38@huawei.com>
CC:     Vishnu Dasa <vdasa@vmware.com>, "arnd@arndb.de" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "dtor@vmware.com" <dtor@vmware.com>,
        "georgezhang@vmware.com" <georgezhang@vmware.com>,
        "acking@vmware.com" <acking@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] VMCI: fix NULL pointer dereference when unmapping
 queue pair
Thread-Topic: [PATCH v2] VMCI: fix NULL pointer dereference when unmapping
 queue pair
Thread-Index: AQHXlC+AAUMQmktxck27qYkVanzNjqt6v06A
Date:   Thu, 19 Aug 2021 12:31:31 +0000
Message-ID: <38CD3BE6-5974-4875-9130-668C001C4E56@vmware.com>
References: <20210818124845.488312-1-wanghai38@huawei.com>
In-Reply-To: <20210818124845.488312-1-wanghai38@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7a60992-2d7a-479a-d174-08d9630d461d
x-ms-traffictypediagnostic: DM6PR05MB4763:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR05MB47635896F8E6A6AC3BFA8B4EDAC09@DM6PR05MB4763.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJ4oZi9xepn0mQezgROqlSaQ+vmtYU7b/3IZFT+90ZedeHddbouc8dqugsC+ETPk81KqBYeG4gxU21lHtJdGzww7R/wM+41LJLU2pCPVTPMrfadcY4DdP+CyU6Q0baMp0gksJ9gCk5HBVs6CqD6GVVitQ9OJ8g6uMb8MTjLsl3QGtDUej5dbPTIgpmlzDUk9GJZ3tjf5eJqRHATo8NUayTCe8UKvzJ7feJqTyXesAS56oRp72Zmrvogp5750ZjhRwnlHhWQ05sd5f74VQCrm5+8ZgwIvzTKYBVV24odLIkKapVsEuBl93f/OSWG64lQWN8f4FbqXhpaMcM+Myo2zjLLN6Yx927HRoepZ/T25wj1PqD+H/9h9tptuR/pzm+zUgK+8dc66vqNQOnKM0YRd1+7gFazYo93DdcEyAGTUeOJMAjNWwjZ84pw/WqMEx+9CeP4RdyzngatFU5Y+g2fxGYATrWzV6C7VJLTeM4Xm6MFAOuYPM5xgVgIZuoJCZozol5KaHc/w2OX7WU8qBBg6C8XT63xtOyxByGKb9IJuYdbnqpWOSDeGWZv9HKQwE/YqMtb97OtsS7I91NYYqtEAzmYtf0IfsshLOEGiLPGgEa/fWKOKorElHX4fFOrG2u4k+dBO56kkzF9YnIOhBg8oJ2+nEY8tYQxr+vxl6mkmX0fpFehFBO/VE44A7bRrLfduvlAp00qd4mDZPr+ElgbCzJ6BZkgdkxUP/Cg2rzM3FP4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR05MB3452.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(26005)(186003)(6512007)(38100700002)(8676002)(122000001)(6506007)(91956017)(478600001)(8936002)(36756003)(53546011)(76116006)(4326008)(66476007)(64756008)(66446008)(66946007)(66556008)(2616005)(33656002)(71200400001)(316002)(54906003)(6916009)(6486002)(83380400001)(2906002)(5660300002)(38070700005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGJPSVdSYnhPYjh5ZUZXZXFrelNyc3ZCOUhkZThpN0w1TFRuanErQlJLNEZ3?=
 =?utf-8?B?bVRCZ2FIYW1CN0g0alpYc2RYeWMzVzFTemxTbmM5MUxmUytOOEtFWHppNEJm?=
 =?utf-8?B?dVZCcUx6RUx6NzQ4aUFPUjJCZlVPRW1VYXhXSmZPME5PWlBpSUwyYjhsTDF5?=
 =?utf-8?B?b1JmVFNqb3VWS1ZIeE9sTWZVU043QmdCT2FINVQ3OXVzVjN1SzVORElHUnhF?=
 =?utf-8?B?U0lBQ2lWc2NTL3dzN0ZPdmljMmlwVnpxL2RzY1NKbjN4cU5hNnowMVRabDFP?=
 =?utf-8?B?Y2xKU2h6RmRCOFhBTUw3cHFYSmY4bGJzN00wQkhjcUttcVJKQjlyUEtzbUVY?=
 =?utf-8?B?UWZkWnVHWFl1bEh4YmNBNTBGRDZlVFhCaGJycWU4ayszWmhRazRPZExsbC9m?=
 =?utf-8?B?dkdXNUtCMFVPSmZET2kyZUlIUGcyeVpWTUtMWnJxWTd3M0tMTXV3SDVzbVBy?=
 =?utf-8?B?VXN6dHVmM3FReXIxbzRZUzFPSHZGLzNPSmtMT1Z0a05vNVVYYThSYU5Za2tr?=
 =?utf-8?B?QkFJVm5hY2tMaG9vNFpLSDQydEk2NlJGN3oxbVp1aFZkK0RyNmw5aUlDTEp4?=
 =?utf-8?B?VnpDZDJiWjRCZDhYbEVlMlZuRDNNb0gwdU9ER2hRQzA1c3lwakh1TTFjenVv?=
 =?utf-8?B?Zlo1Z0xRL3RlOHZZcjVLN0ZqelZRa3lSa0duWm1kemRIQ3U1dTY3MTJ2c2VY?=
 =?utf-8?B?cjk2c1lwQzlhMGFEVW1xK3RhMmxkVFZZbzVyb0x6aTBzZ2Zmend6N0VYbjA1?=
 =?utf-8?B?YURSdTdwSlJmMnNlamV4eGN1UXYra1lOaTQwNjVDK0xSOWNaTVdaU1AwVXVM?=
 =?utf-8?B?RnZQUFdIRm1saTQzTERWNXpadS9DcUJYWjZyWXFzWlBNczZ1eU12b0d2Mmdr?=
 =?utf-8?B?U3dDOXRTUm9sdDZKNkVFRWFWMThPbFdjbXEvZTUzU3JOeWpMK3JYR0dxUW5P?=
 =?utf-8?B?YWgrQUwvaDJnbnZkNFRKT1ZiRHZkaTZ6dkJ2YTMzajJEcGt3b1YrVUtaWldO?=
 =?utf-8?B?bUprR1pSNC9GeU4vZXVVM2xuTkZWZVU3eUd4cDc5clNXa0Y0NmJtRkMrNFRB?=
 =?utf-8?B?MEtlVGkrVUwrNHBmUm9LeVZlelRUdVMySjhzdXdMVU1NR1ZmWDFtdWRvM012?=
 =?utf-8?B?UndqZWo5SnhaZE10dG5xYmYxUkF0c1ltbXdhOVIzRWJDL2J4WUVXVURMVzZZ?=
 =?utf-8?B?a1k5bDlrTDFrNjVXNDFGdFpINkpvNjJ4Unk0dGUrQ2o0YldXcDVVNStyZ0NG?=
 =?utf-8?B?UktpNStMN3FMeGZHNWdaUTQyMDhCZy9sc0pUNHJPSUl6WjVmS1JHQU85TXIw?=
 =?utf-8?B?YVN3NzFwRHI4MUJpeXNxSk40TFNGTEZiRGV5bnpDUyt5WjNrMnhNTXRsNkZY?=
 =?utf-8?B?WGMwNTlacjk1UXI1VFFVWVVLbkNHT0M1R3pZTURzRW1nSTBlWVJVdXZVRDRZ?=
 =?utf-8?B?NFJ1djUwcysxRW5iT3I0QlFWVElkTW8va2czUk9lVFN3S1Y1SVI1K1AxaTJv?=
 =?utf-8?B?TnY1d1gzSWVOMGdqQncrK0ZLMmsrdEUrUXhCUE5JRXU0NTlUamVFbXBHb1Yx?=
 =?utf-8?B?TWtJK1o0bVB3N2hxUTM4MWIxNncyMk9CSVpxM3A4cWwzVjJBUDNLSjFUNzVt?=
 =?utf-8?B?am5Ta1JadTQzTmJNWG9oMGtDWTlRNEQ5MmZlOTF1R3pmMGJpUTFTYTlCSC9P?=
 =?utf-8?B?aHZ6b0hNZDFZdW44OUNLaXQxZCtLRTQ3ZEh0dkR6ZTdOWW9JUXNBRHhrc0RD?=
 =?utf-8?Q?OOznfCF3ouPKT9QNSohqOy+Oneg+HkMFqypQKg9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <327C24B5A3ADE04293E93A004231209B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR05MB3452.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a60992-2d7a-479a-d174-08d9630d461d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 12:31:31.1350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5V4s+gUgTnHreuGnQ/z7uGN3CikZjjdyXQImaSc/ISSVNDuUdi/L4GzjHZ1iGmvFc3fKdCY3nCh2Zpw4dB59Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTggQXVnIDIwMjEsIGF0IDE0OjQ4LCBXYW5nIEhhaSA8d2FuZ2hhaTM4QGh1YXdl
aS5jb20+IHdyb3RlOg0KPiANCj4gSSBnb3QgYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgcmVw
b3J0IHdoZW4gZG9pbmcgZnV6eiB0ZXN0Og0KPiANCj4gQ2FsbCBUcmFjZToNCj4gIHFwX3JlbGVh
c2VfcGFnZXMrMHhhZS8weDEzMA0KPiAgcXBfaG9zdF91bnJlZ2lzdGVyX3VzZXJfbWVtb3J5Lmlz
cmEuMjUrMHgyZC8weDgwDQo+ICB2bWNpX3FwX2Jyb2tlcl91bm1hcCsweDE5MS8weDMyMA0KPiAg
PyB2bWNpX2hvc3RfZG9fYWxsb2NfcXVldWVwYWlyLmlzcmEuOSsweDFjMC8weDFjMA0KPiAgdm1j
aV9ob3N0X3VubG9ja2VkX2lvY3RsKzB4NTlmLzB4ZDUwDQo+ICA/IGRvX3Zmc19pb2N0bCsweDE0
Yi8weGExMA0KPiAgPyB0b21veW9fZmlsZV9pb2N0bCsweDI4LzB4MzANCj4gID8gdm1jaV9ob3N0
X2RvX2FsbG9jX3F1ZXVlcGFpci5pc3JhLjkrMHgxYzAvMHgxYzANCj4gIF9feDY0X3N5c19pb2N0
bCsweGVhLzB4MTIwDQo+ICBkb19zeXNjYWxsXzY0KzB4MzQvMHhiMA0KPiAgZW50cnlfU1lTQ0FM
TF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhZQ0KPiANCj4gV2hlbiBhIHF1ZXVlIHBhaXIgaXMg
Y3JlYXRlZCBieSB0aGUgZm9sbG93aW5nIGNhbGwsIGl0IHdpbGwgbm90DQo+IHJlZ2lzdGVyIHRo
ZSB1c2VyIG1lbW9yeSBpZiB0aGUgcGFnZV9zdG9yZSBpcyBOVUxMLCBhbmQgdGhlDQo+IGVudHJ5
LT5zdGF0ZSB3aWxsIGJlIHNldCB0byBWTUNJUVBCX0NSRUFURURfTk9fTUVNLg0KPiANCj4gdm1j
aV9ob3N0X3VubG9ja2VkX2lvY3RsDQo+ICB2bWNpX2hvc3RfZG9fYWxsb2NfcXVldWVwYWlyDQo+
ICAgIHZtY2lfcXBfYnJva2VyX2FsbG9jDQo+ICAgICAgcXBfYnJva2VyX2FsbG9jDQo+ICAgICAg
ICBxcF9icm9rZXJfY3JlYXRlIC8vIHNldCBlbnRyeS0+c3RhdGUgPSBWTUNJUVBCX0NSRUFURURf
Tk9fTUVNOw0KPiANCj4gV2hlbiB1bm1hcHBpbmcgdGhpcyBxdWV1ZSBwYWlyLCBxcF9ob3N0X3Vu
cmVnaXN0ZXJfdXNlcl9tZW1vcnkoKSB3aWxsDQo+IGJlIGNhbGxlZCB0byB1bnJlZ2lzdGVyIHRo
ZSBub24tZXhpc3RlbnQgdXNlciBtZW1vcnksIHdoaWNoIHdpbGwNCj4gcmVzdWx0IGluIGEgbnVs
bCBwb2ludGVyIHJlZmVyZW5jZS4gSXQgd2lsbCBhbHNvIGNoYW5nZQ0KPiBWTUNJUVBCX0NSRUFU
RURfTk9fTUVNIHRvIFZNQ0lRUEJfQ1JFQVRFRF9NRU0sIHdoaWNoIHNob3VsZCBub3QgYmUNCj4g
cHJlc2VudCBpbiB0aGlzIG9wZXJhdGlvbi4NCj4gDQo+IE9ubHkgd2hlbiB0aGUgcXAgYnJva2Vy
IGhhcyBtZW0sIGl0IGNhbiB1bnJlZ2lzdGVyIHRoZSB1c2VyDQo+IG1lbW9yeSB3aGVuIHVubWFw
cGluZyB0aGUgcXAgYnJva2VyLg0KPiANCj4gT25seSB3aGVuIHRoZSBxcCBicm9rZXIgaGFzIG5v
IG1lbSwgaXQgY2FuIHJlZ2lzdGVyIHRoZSB1c2VyDQo+IG1lbW9yeSB3aGVuIG1hcHBpbmcgdGhl
IHFwIGJyb2tlci4NCj4gDQo+IEZpeGVzOiAwNjE2NGQyYjcyYWEgKCJWTUNJOiBxdWV1ZSBwYWly
cyBpbXBsZW1lbnRhdGlvbi4iKQ0KPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1
YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFdhbmcgSGFpIDx3YW5naGFpMzhAaHVhd2VpLmNv
bT4NCj4gLS0tDQo+IHYxLT52MjogZml4IGJ1ZyBpbiB2bWNpX3FwX2Jyb2tlcl9tYXANCj4gZHJp
dmVycy9taXNjL3Ztd192bWNpL3ZtY2lfcXVldWVfcGFpci5jIHwgNiArKysrLS0NCj4gMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21pc2Mvdm13X3ZtY2kvdm1jaV9xdWV1ZV9wYWlyLmMgYi9kcml2ZXJzL21p
c2Mvdm13X3ZtY2kvdm1jaV9xdWV1ZV9wYWlyLmMNCj4gaW5kZXggODgwYzMzYWI5ZjQ3Li45NGVi
ZjdmM2ZkNTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy92bXdfdm1jaS92bWNpX3F1ZXVl
X3BhaXIuYw0KPiArKysgYi9kcml2ZXJzL21pc2Mvdm13X3ZtY2kvdm1jaV9xdWV1ZV9wYWlyLmMN
Cj4gQEAgLTIyNDMsNyArMjI0Myw4IEBAIGludCB2bWNpX3FwX2Jyb2tlcl9tYXAoc3RydWN0IHZt
Y2lfaGFuZGxlIGhhbmRsZSwNCj4gDQo+IAlyZXN1bHQgPSBWTUNJX1NVQ0NFU1M7DQo+IA0KPiAt
CWlmIChjb250ZXh0X2lkICE9IFZNQ0lfSE9TVF9DT05URVhUX0lEKSB7DQo+ICsJaWYgKGNvbnRl
eHRfaWQgIT0gVk1DSV9IT1NUX0NPTlRFWFRfSUQgJiYNCj4gKwkgICAgIVFQQlJPS0VSU1RBVEVf
SEFTX01FTShlbnRyeSkpIHsNCj4gCQlzdHJ1Y3Qgdm1jaV9xcF9wYWdlX3N0b3JlIHBhZ2Vfc3Rv
cmU7DQo+IA0KPiAJCXBhZ2Vfc3RvcmUucGFnZXMgPSBndWVzdF9tZW07DQo+IEBAIC0yMzUwLDcg
KzIzNTEsOCBAQCBpbnQgdm1jaV9xcF9icm9rZXJfdW5tYXAoc3RydWN0IHZtY2lfaGFuZGxlIGhh
bmRsZSwNCj4gCQlnb3RvIG91dDsNCj4gCX0NCj4gDQo+IC0JaWYgKGNvbnRleHRfaWQgIT0gVk1D
SV9IT1NUX0NPTlRFWFRfSUQpIHsNCj4gKwlpZiAoY29udGV4dF9pZCAhPSBWTUNJX0hPU1RfQ09O
VEVYVF9JRCAmJg0KPiArCSAgICBRUEJST0tFUlNUQVRFX0hBU19NRU0oZW50cnkpKSB7DQo+IAkJ
cXBfYWNxdWlyZV9xdWV1ZV9tdXRleChlbnRyeS0+cHJvZHVjZV9xKTsNCj4gCQlyZXN1bHQgPSBx
cF9zYXZlX2hlYWRlcnMoZW50cnkpOw0KPiAJCWlmIChyZXN1bHQgPCBWTUNJX1NVQ0NFU1MpDQo+
IOKAlCANCj4gMi4xNy4xDQo+IA0KDQpUaGFua3MgYSBsb3QgZm9yIGZpbmRpbmcgYW5kIGZpeGlu
ZyB0aGlzLiBUaGUgbWFwIGFuZCB1bm1hcCByb3V0aW5lcyBhcmUgdXNlZCAtIGFtb25nIG90aGVy
DQp0aGluZ3MgLSBkdXJpbmcgdmlydHVhbCBtYWNoaW5lIHNuYXBzaG90LiBJIHRlc3RlZCBzbmFw
c2hvdHMgZm9yIFZNd2FyZSBXb3Jrc3RhdGlvbiB3aXRoIHlvdXINCnBhdGNoLCBhbmQgdGhpbmdz
IHN0aWxsIHdvcmsgZmluZS4NCg0KUmV2aWV3ZWQtYnk6ICBKb3JnZW4gSGFuc2VuIDxqaGFuc2Vu
QHZtd2FyZS5jb20+DQoNCg==
