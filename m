Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B174533815A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 00:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhCKXSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 18:18:53 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45198 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231543AbhCKXSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 18:18:25 -0500
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 63B39C03C2;
        Thu, 11 Mar 2021 23:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1615504705; bh=6dEAyx/EMfxrSWQy4STjT1+SplREoPz183XdDZ/ByUo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PtZk//q/GhHbYK1LYTkoLcNroPN0eOCuW/0LZn+6JHx63KEkUNnAFA9VWBo5HOUFx
         AbJvmWDivDBF7SRaAu/4rwuQZcMltrLsTODhz8K2aJ7dXR4dUWaOa0DxoSGP9IQxem
         D+jAdOOQ4tW2QlOtJeMZ7HgxiU/cSVersc2PB7WgSfk+tOdep81anNFNP4zMT7oRFF
         9qNl8gB7hpsTte2iJx7DRvc/NCbr/qZMLCA9X9MfqLR6dJVafXEIXTZhLgejY4w1Zh
         0PlznJtPFnQF9QiJstuTTafsYF/Pz20NeUYS8IIZhf82kbukG7VTpIu30hPkukJp31
         I2Sv7L2sqEaOg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id BCFA0A0096;
        Thu, 11 Mar 2021 23:18:24 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2052.outbound.protection.outlook.com [104.47.36.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DC40E40133;
        Thu, 11 Mar 2021 23:18:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="P9/Ut0pm";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORRuH4ED4gcN5Bc0cPAeshoHKo+vGwGFOXjzCjz4p3C22Klu1FPUJ92H1LT5Z4wNsW+bEkMbruWIOs5dBO6Qkp84BDQ7hbFCFVXBqafGTef1rnNsHvJS3xndTumy5bxjaUd3VPElBLITBsaYULXstVQ+/g6H+/PfqPJl7d+4ff+bHNDSnJ/J7jTXeoUjwD78Z9RT+A2xdrRbr3ulcETMmjRXOJG5Ob4mGw79JSfM1xdo3/FSLbV6JZRiPyaOzeB2RgiJASHAfk4tWK6X6Wp5Iyd5L/aEZO1PAvF1aeD24Dv7Q+E6D/TmmyKjc2mlGJtTNRaG+4m5cSba3c893KiQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dEAyx/EMfxrSWQy4STjT1+SplREoPz183XdDZ/ByUo=;
 b=mYKXB+cMd4Qfq+TeeV0PnsIF9DE2x7XRY8U5MtImij08jGCEupcKXL+21yYnMolVaCSYPslIgLWzQiLrzbldOa+/fzY3pIi8jRMi+yEkJpPK0VU0pPLB5Bx/MF8GI0jf/cIQBbMi2GKDRdUm79GxY4Yx3ABhgGkaN9ooSiABbIxoj4U1gB/VyM/KGCsMoDrwL6tkHgcWSWUjQ5Vzl4NUoe38ruS/cRN6aIJe09LTCCvMaPJT83lSwnDr+kmfE52w2GWpQD/z3W6KKA7As2HpD8Dq/Obhy8AQ07A2+GPpcYPTIhgd1gw62ZPSw+SFYUTYonXzBJMcxtHbThH0QuRu/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dEAyx/EMfxrSWQy4STjT1+SplREoPz183XdDZ/ByUo=;
 b=P9/Ut0pmhm4Y5HsZYc8eS+AgMlUUKsufnFMoTMcjIS8/4jQEiSvMhq/g6CpcQfuZVZIfTvu1IceR7RjaQi0brnd66zcUxjoFxjNb/6EnQumHt6aXlw4H6mfCr7DWW8OfrM+hYzBF2F42xVqH/GkXP1ErKEyM8y4ZhAv54ENnqFE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB3351.namprd12.prod.outlook.com (2603:10b6:a03:de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 23:18:21 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6%6]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 23:18:21 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EP queuing while stopping
 transfers
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Prevent EP queuing while stopping
 transfers
Thread-Index: AQHXFsbeYBJXwLrOKkWKmUFbl8eR2Kp/bBgA
Date:   Thu, 11 Mar 2021 23:18:20 +0000
Message-ID: <35079ed1-d730-6dc7-9e4c-639b33115c79@synopsys.com>
References: <1615502070-19705-1-git-send-email-wcheng@codeaurora.org>
In-Reply-To: <1615502070-19705-1-git-send-email-wcheng@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13a6c8ec-6cc6-41cf-a222-08d8e4e3f62c
x-ms-traffictypediagnostic: BYAPR12MB3351:
x-microsoft-antispam-prvs: <BYAPR12MB33517B1549EDD5557A60E30AAA909@BYAPR12MB3351.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMm7Htu7+2zaqFE3bwIQts3Rixw9CMdG6WgPdPklY9P7Wz0L6a62rJrCRtJhuZG35/LwOGNbt3rDYmZ/Qd0khC7FR9NVdy07/6caS4vOrsc1y6aG/kFcg4kevRvCzPY558xYj64GsHUGFXOuGgKitpwYLzy47wxBQXAp2JPo6FImI7UJNGVtDCh6wp9qYJZWFOzNF3sVvIGVYvC7igQp9dMePLydCIo3aHBgZvP9gZ6zqPrK4+nC1jv1hwaKem7D2QVwtEutAuH6/Nj14BhWp/f6AgkwZfeK8VzrRDMBUwJqRXAw9sLT0RWx/C54Vn7SsrIF3x7UV5Wm0wZTN+I2t9y8kspc0diFjiB4vHSiD5Bdc7NZrJVW2nKpCkBOPnKc6jq/BAB1XKyLt9/m3tDsUfsjI50Wekikd+8N+kDgruEYJJAHVIc7AoO5Loh4pGEQ5x92+DmXvwGc/VxwCe+oHsMSl7RmqwG2swe6Ha2l9w++4hIVx4gkAPVG1X3L9pZe0Vro60+hJcnkf1lykDHNkoI8aY01Sx4nWJ1t8FYiQYZBKcfpKqn7iicujv6EOF+NutvSTPm6uqpOKBzPkc6dFQo+0WAjK3LuAVYbXxcPabs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(39860400002)(396003)(376002)(478600001)(31696002)(2616005)(83380400001)(2906002)(8676002)(6506007)(26005)(86362001)(8936002)(6512007)(186003)(36756003)(110136005)(31686004)(5660300002)(66476007)(66946007)(54906003)(316002)(76116006)(66556008)(71200400001)(64756008)(66446008)(6486002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QVlSdERXRkNxVytIRHQrVHBYS3FKdVU0SzJWdTFoQzU1L1pRK2txSE02aGFo?=
 =?utf-8?B?alpOb0NLU2hYbmtBOEdkWnRqbGEySUxvWnBTMEJEL1MwZlRhcUtLWS9xQVhK?=
 =?utf-8?B?ZTNBYXl3Y3U0TmJ1L0tKOHM0K01IOC9VZkxJRjhmZWtsT2drU3o2NG80MFE5?=
 =?utf-8?B?MzJvTmkzT2VXT2taZFJKYnVIRTNlSS9QVEVzcCtid25TalFBTkpwVStvZkk5?=
 =?utf-8?B?RzkvZGFSY1o4K3VZallFZzYzVVltZ0g5N3ptQTNNNTRDMnhjUHVkU0hWd0wz?=
 =?utf-8?B?NWlTdk1wamVyMkhRcFROZzd1b0p0WWZXb2d2c2ZDeTlFOWE5eFUvZGlJb1Va?=
 =?utf-8?B?RGx3eGdwNzJQUmtBK3lhMDVHT3dYU2twbjM3OSsxSkRXS0hZbkdZelIzMUQv?=
 =?utf-8?B?UGk3ZERQRnZMdnVFcEc1M3ZmS1k0Q1hOZzVRZlF6S3lwQ3hyR3BrQXBHNUNh?=
 =?utf-8?B?S3prcVBnMmtab3RTSWV6L0hEYithZXdWTGhkMzhxRTR6SzY2VGFodklKK1lG?=
 =?utf-8?B?Z1hBOXpwZ2ZvUjdVaE1rbm8velliT2h6aEtCZkxZRUREQXFpNjBLdU1CczV1?=
 =?utf-8?B?ZVFqY09LNjB5Z09UWUlLKzNPM0tLNlJGeGY5WWFydjdhbVRFSCtqTDFLTjlr?=
 =?utf-8?B?b3VoUFFzN2RvQUN2RzJ5ZTZJOUxkRktic1lrd013blR5aEdyT0ZuZitGbGVk?=
 =?utf-8?B?Tm1zUFVvdHloVnNsOXVTbXlLd3VaNkdOZklNTUpqVitpVnFHMWltL05ES2xX?=
 =?utf-8?B?RkROenh0YXJjb1NySmlsUzJ0V0hMTk1sYVI0VVZJcVB4aTRJZzkzS3dBVjgx?=
 =?utf-8?B?eXI0RURTbXlQWU1lUlQ4dG9NTkVZZG1uMUxVM2pGczhEaW80aTcveWpsbXNs?=
 =?utf-8?B?cUwrSlcvc1J0L2tIUXpRTURBSEdKNjc2Z1BmaFpCUCtROEx6a0JWM1FzL1FZ?=
 =?utf-8?B?U3gyYUJaSTdQaHhwbDJGT09aMTRjS2R6Vk5UaC93MzF0bjZkcnYwdTlFdVZn?=
 =?utf-8?B?THVMb29rYWFMVjhZMmdnSHlNbkxUdWJ3dG1qNHdpNlFtR2IxeDlnNjIzMENG?=
 =?utf-8?B?blh0WjdQZzZEZmNnempEOVpDL2o4SllUMVBVcUpZUVZNcHluNDE0QlVwM1Vm?=
 =?utf-8?B?VWt6akFjdDBoR2Q0YjFiZ2xEN2s2RnlEbUQ1NkVlYkhUZlQ3by9TMk9QcWtQ?=
 =?utf-8?B?ZzBMam5EdWdCUEpVZzdIWEZmdnNSS2NXTGhhS2VKY0RoM0pyazFVMDRkNko1?=
 =?utf-8?B?d2Q2T3Z4WEt4YkVLeldKTEFHYU9Xb0RDYjlPRWRzVXMxZzFBSW1iQU5HWnZx?=
 =?utf-8?B?cStNbGs4REJyS0ltVkg5VU8yTW0zRzNLNFNkbVZYTDVXSzRnbGNOajFUcWg0?=
 =?utf-8?B?bEdOWWhzZTY1UTdwZSt5RUdDWUlPMHVLL3lkYnZ6Y2U5NHRaYzNHN29RQmlM?=
 =?utf-8?B?WWV6U3g2VDNmb05oaFlhS3htVnVRSFoxNWd0di9SWVg0K3JrTFB3SXQ0eCtX?=
 =?utf-8?B?N0JkdWZObnRsVzM5RG0zVW1KU0QwTm9JZnc0RkV3NUxSWWRqOURjV1ZvbUMz?=
 =?utf-8?B?MjByaGhMM1NZTm5kRy9mVVhLd1VBMjNRVGxtZnVERmcrU1I1c3l5UnI0Sldm?=
 =?utf-8?B?Q0tmdUROb20yL0dVMldxa0RJRDlsd25hS3FLazRPQWxxTTRibS9GOTZEMzJ0?=
 =?utf-8?B?Vlpvd2FrcGFvdDhpNmpJWERwT1dqL3F2VVkvaWZBbUdyZTVmbzF0RnQ4S05U?=
 =?utf-8?Q?473HPMUOE+VycuLV7E=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0756FF09C6C64548AB06F089AFDB694C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a6c8ec-6cc6-41cf-a222-08d8e4e3f62c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 23:18:20.9985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTgFNfad+gJOSUQRnYIl2dTUoowr0wGj6mZb6jF9Nqof/B2VRc0c70LjWK1XAcJcFfTGKqPwxE9MTzpPqyci4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3351
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBJbiB0aGUgc2l0dWF0aW9ucyB3aGVyZSB0aGUgRFdDMyBn
YWRnZXQgc3RvcHMgYWN0aXZlIHRyYW5zZmVycywgb25jZQ0KPiBjYWxsaW5nIHRoZSBkd2MzX2dh
ZGdldF9naXZlYmFjaygpLCB0aGVyZSBpcyBhIGNoYW5jZSB3aGVyZSBhIGZ1bmN0aW9uDQo+IGRy
aXZlciBjYW4gcXVldWUgYSBuZXcgVVNCIHJlcXVlc3QgaW4gYmV0d2VlbiB0aGUgdGltZSB3aGVy
ZSB0aGUgZHdjMw0KPiBsb2NrIGhhcyBiZWVuIHJlbGVhc2VkIGFuZCByZS1hcXVpcmVkLiAgVGhp
cyBvY2N1cnMgYWZ0ZXIgd2UndmUgYWxyZWFkeQ0KPiBpc3N1ZWQgYW4gRU5EWEZFUiBjb21tYW5k
LiAgV2hlbiB0aGUgc3RvcCBhY3RpdmUgdHJhbnNmZXJzIGNvbnRpbnVlcw0KPiB0byByZW1vdmUg
VVNCIHJlcXVlc3RzIGZyb20gYWxsIGRlcCBsaXN0cywgdGhlIG5ld2x5IGFkZGVkIHJlcXVlc3Qg
d2lsbA0KPiBhbHNvIGJlIHJlbW92ZWQsIHdoaWxlIGNvbnRyb2xsZXIgc3RpbGwgaGFzIGFuIGFj
dGl2ZSBUUkIgZm9yIGl0Lg0KPiBUaGlzIGNhbiBsZWFkIHRvIHRoZSBjb250cm9sbGVyIGFjY2Vz
c2luZyBhbiB1bm1hcHBlZCBtZW1vcnkgYWRkcmVzcy4NCj4gDQo+IEZpeCB0aGlzIGJ5IGVuc3Vy
aW5nIHBhcmFtZXRlcnMgdG8gcHJldmVudCBFUCBxdWV1aW5nIGFyZSBzZXQgYmVmb3JlDQo+IGNh
bGxpbmcgdGhlIHN0b3AgYWN0aXZlIHRyYW5zZmVycyBBUEkuDQo+IA0KPiBGaXhlczogYWU3ZTg2
MTA4YjEyICgidXNiOiBkd2MzOiBTdG9wIGFjdGl2ZSB0cmFuc2ZlcnMgYmVmb3JlIGhhbHRpbmcg
dGhlIGNvbnRyb2xsZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHdjaGVuZ0Bj
b2RlYXVyb3JhLm9yZz4NCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgVjE6DQo+ICAtIEFkZGVkIEZp
eGVzIHRhZyB0byBwb2ludCB0byB0aGUgY29tbWl0IHRoaXMgaXMgYWRkcmVzc2luZw0KPiANCj4g
IGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAxMCArKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+
IGluZGV4IDQ3ODA5ODMuLjRkOThmYmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtNzgzLDgg
Kzc4Myw2IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9lcF9kaXNhYmxlKHN0cnVjdCBkd2Mz
X2VwICpkZXApDQo+ICANCj4gIAl0cmFjZV9kd2MzX2dhZGdldF9lcF9kaXNhYmxlKGRlcCk7DQo+
ICANCj4gLQlkd2MzX3JlbW92ZV9yZXF1ZXN0cyhkd2MsIGRlcCk7DQo+IC0NCj4gIAkvKiBtYWtl
IHN1cmUgSFcgZW5kcG9pbnQgaXNuJ3Qgc3RhbGxlZCAqLw0KPiAgCWlmIChkZXAtPmZsYWdzICYg
RFdDM19FUF9TVEFMTCkNCj4gIAkJX19kd2MzX2dhZGdldF9lcF9zZXRfaGFsdChkZXAsIDAsIGZh
bHNlKTsNCj4gQEAgLTgwMyw2ICs4MDEsOCBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfZXBf
ZGlzYWJsZShzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiAgCQlkZXAtPmVuZHBvaW50LmRlc2MgPSBO
VUxMOw0KPiAgCX0NCj4gIA0KPiArCWR3YzNfcmVtb3ZlX3JlcXVlc3RzKGR3YywgZGVwKTsNCj4g
Kw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IEBAIC0xNjE3LDcgKzE2MTcsNyBAQCBzdGF0
aWMgaW50IF9fZHdjM19nYWRnZXRfZXBfcXVldWUoc3RydWN0IGR3YzNfZXAgKmRlcCwgc3RydWN0
IGR3YzNfcmVxdWVzdCAqcmVxKQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzCQkqZHdjID0gZGVwLT5k
d2M7DQo+ICANCj4gLQlpZiAoIWRlcC0+ZW5kcG9pbnQuZGVzYyB8fCAhZHdjLT5wdWxsdXBzX2Nv
bm5lY3RlZCkgew0KPiArCWlmICghZGVwLT5lbmRwb2ludC5kZXNjIHx8ICFkd2MtPnB1bGx1cHNf
Y29ubmVjdGVkIHx8ICFkd2MtPmNvbm5lY3RlZCkgew0KPiAgCQlkZXZfZXJyKGR3Yy0+ZGV2LCAi
JXM6IGNhbid0IHF1ZXVlIHRvIGRpc2FibGVkIGVuZHBvaW50XG4iLA0KPiAgCQkJCWRlcC0+bmFt
ZSk7DQo+ICAJCXJldHVybiAtRVNIVVRET1dOOw0KPiBAQCAtMjI0Nyw2ICsyMjQ3LDcgQEAgc3Rh
dGljIGludCBkd2MzX2dhZGdldF9wdWxsdXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBpc19v
bikNCj4gIAlpZiAoIWlzX29uKSB7DQo+ICAJCXUzMiBjb3VudDsNCj4gIA0KPiArCQlkd2MtPmNv
bm5lY3RlZCA9IGZhbHNlOw0KDQoNCllvdSB3YW50IHRvIHNldCB0aGlzIGJlZm9yZSBfX2R3YzNf
Z2FkZ2V0X3N0b3AoKSByaWdodD8gVGhlbiB5b3UgbWF5DQp3YW50IHRvIHJlbW92ZSB0aGlzIHNh
bWUgc2V0dGluZyBmZXcgbGluZXMgYmVsb3cgdGhpcy4gT3RoZXJ3aXNlLCB0aGlzDQpsb29rcyBn
b29kLg0KDQpUaGFua3MsDQpUaGluaA0KDQoNCj4gIAkJLyoNCj4gIAkJICogSW4gdGhlIFN5bm9w
c2lzIERlc2lnbldhcmUgQ29yZXMgVVNCMyBEYXRhYm9vayBSZXYuIDMuMzBhDQo+ICAJCSAqIFNl
Y3Rpb24gNC4xLjggVGFibGUgNC03LCBpdCBzdGF0ZXMgdGhhdCBmb3IgYSBkZXZpY2UtaW5pdGlh
dGVkDQo+IEBAIC0zMzI5LDggKzMzMzAsNiBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9yZXNl
dF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gIAl1MzIJCQlyZWc7DQo+ICAN
Cj4gLQlkd2MtPmNvbm5lY3RlZCA9IHRydWU7DQo+IC0NCj4gIAkvKg0KPiAgCSAqIFdPUktBUk9V
TkQ6IERXQzMgcmV2aXNpb25zIDwxLjg4YSBoYXZlIGFuIGlzc3VlIHdoaWNoDQo+ICAJICogd291
bGQgY2F1c2UgYSBtaXNzaW5nIERpc2Nvbm5lY3QgRXZlbnQgaWYgdGhlcmUncyBhDQo+IEBAIC0z
MzcwLDYgKzMzNjksNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9yZXNldF9pbnRlcnJ1cHQo
c3RydWN0IGR3YzMgKmR3YykNCj4gIAkgKiB0cmFuc2ZlcnMuIg0KPiAgCSAqLw0KPiAgCWR3YzNf
c3RvcF9hY3RpdmVfdHJhbnNmZXJzKGR3Yyk7DQo+ICsJZHdjLT5jb25uZWN0ZWQgPSB0cnVlOw0K
PiAgDQo+ICAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfRENUTCk7DQo+ICAJcmVn
ICY9IH5EV0MzX0RDVExfVFNUQ1RSTF9NQVNLOw0KPiANCg0K
