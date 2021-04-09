Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FD235A06E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhDIN5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:57:36 -0400
Received: from mail-eopbgr1400113.outbound.protection.outlook.com ([40.107.140.113]:8085
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231946AbhDIN5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:57:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0eXTIMNvBAei8KYTtBYPDRzQwrOIQ3O+A0/MqFW5R/Dg+hHIa77yt6MVzm5YmyCwlEVNCvROCkLmJh8A8EHFKT+4eTRmAIcukVXl+GdUDmBPrJZpAtxTNOy4GY9XB2M8Jq27vXjlYNpAPTdMiEE2R7DDI3Jej2IeETpyt5InN8G3GncojBw52szNg8UAQoH6MfMSbql1srXqfMSXwNUFGTN8TKlsoqaOjMIk1SLtGzZ6MPDnjlOPUhmPvy350TN+75FsvJlNOPVG99IKUMJOts3wdVPWRLVJJUzo+/Tuw3pVJ9tK144FBVQN44Je1EixjLs1OJaP4P7eQj2sUw/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z8bUNqZH+FzDsHGTgSLeAl9kAj6PD3QfFAjwf4k7y8=;
 b=D5tjGTNC/82vvClcj7uphw0jU2t46Q7VK/uRCewI3SAS3WuQDn8CvzHXoEbmFBjPJIyj51w/ugOsGK1+679ikBbDM28i96fJwDQLILeP67D2htF3gQ6NUp2YraSSw7wu3P7pppY8sm24tbTykTQEUnqIwqEZr+gkXdvGxmHFsoSv28EEQ6HiVFytBY0E0KA9v+hH51DYj8pcZv2u8j7PGc8r5yBB/5dEq18IzRXR5A8qw1Z3J8Vd2Cba0pCCaE6YWWqxelMlyorFEXSXqWijwblPSvk0t9U16dSiPFSrTgPa7OPy1Mnq68fwDJlMPO8oaxGPwV/B2zIgNdvUemPEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z8bUNqZH+FzDsHGTgSLeAl9kAj6PD3QfFAjwf4k7y8=;
 b=JgV3lvUvFWM/dvmBpVJoI5jfiT0ACMj1M7WHDdHhB0N/bs/sShruXSCSO1YNVPVsirlXJ+PqUY+h/3X097urrVlYJXf2UbiDHHViXFsv+CVhPeAE8U0bZc21/1goNAwsYjm6I1PX7hlueOydnpWUcijgRlw4P3C2LiM49sRkI4E=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSAPR01MB3316.jpnprd01.prod.outlook.com (2603:1096:604:5b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Fri, 9 Apr
 2021 13:57:18 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 13:57:18 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 1/2] mfd: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Topic: [PATCH net-next v3 1/2] mfd: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Index: AQHXLBphMmpyIdnLSkKcpoovCRWuzaqqM6eAgACvi9CAARN0AIAAQUGA
Date:   Fri, 9 Apr 2021 13:57:18 +0000
Message-ID: <OSBPR01MB477344142FC1C3567A3F6A87BA739@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617846650-10058-1-git-send-email-min.li.xe@renesas.com>
 <20210408070809.GD2961413@dell>
 <OSBPR01MB4773DF588214D8B9E613E074BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <20210409100220.GE2961413@dell>
In-Reply-To: <20210409100220.GE2961413@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6837c688-4641-4b8f-a18e-08d8fb5f639f
x-ms-traffictypediagnostic: OSAPR01MB3316:
x-microsoft-antispam-prvs: <OSAPR01MB3316112E7424601E04D46E38BA739@OSAPR01MB3316.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Auq9QhzBvzxyX5jVvz4920EXdu6Ay3f6r/EuQ0l3SNdabHgAr1lLpiBIIkCN1fArZ0AiRiN8KUwHjwVelgHaogAYYXSwzP0zMscHb4jmeXE++CKS77syNKZcL7YsdCQZJg7OGHf8UUtOvHxaZQhHE+FnsqJhljh/K68m2gbXfQfAB50LfA6lpvjsL6WBZRH9EWlfzM0G7hzbxFLlVZU3iRFfie76oX/lQkFAzDMjMwXYJjyF+hDZ4yGBn0iJTpIWb2EVMSDv7IoZBj2JzB2eZlPHKUUf1Iucl2iHnljm+Tr94yz0M1quTBVZC4kvR6dGrGoSURmN53/XFfp5P97unuElySmoHlrnGmYP6+sDcYkDTowkgwfStp+Ql/xdzW8uN8zv+xGJoEF+mZBrNj2RnVESnqokj61l8kW/YkwoI2O+mcLGCmyW915kNCErNyDheVp52C3+fijte+vQUogIALM75fB60OtM8SAlnBR8fhPJ7iBZkiv0pdqJYyoiQ+HbgMEhoE3j8iirQRf31TD5dVsDXCt9cKVwa83CKdLtoCvIB9IQmjvRH0uEle8pJ0qiv0HOtoRFnmv9L9CVFcjBmcSz5i6vs6DP2Eghk1xpD0gGaLOfw47c6KvvdqW3w5qKdTO91QelZpC3x+nJ7Q2Q0J9CI+U+tXPY4jARP579UQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(7696005)(66446008)(8676002)(8936002)(55016002)(186003)(478600001)(558084003)(33656002)(86362001)(66476007)(66556008)(9686003)(64756008)(66946007)(71200400001)(52536014)(316002)(2906002)(4326008)(54906003)(5660300002)(76116006)(6916009)(6506007)(26005)(38100700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?anhwV05BaFU5ejZJdXBSZVUzZUJjRUo4TEVRR0xpeVFiNVhqS2ZkeGNkczAy?=
 =?utf-8?B?cFdyR1N6eTNZU0FwSWVQUkJFdnF3VHhLR1habnlkbnVqK2RSa3JSSHhMc1lX?=
 =?utf-8?B?TlJyVmpJeG43cVZzZDNoTWFCK1docXYxbmZwQjZEcThxWEh6Zm9UdjBFUEpW?=
 =?utf-8?B?MFkxUjZlWjNCRGtyMTFtRTB0bkx1VG52a3RMMXdzUDdVR2JrUUR1WEg0TTI4?=
 =?utf-8?B?ZzFZdGRNSjB5MjdkZ0xzK2gvelRNRTlNZFZDU1VsdGx4bFZEU2NDdmdLaWZu?=
 =?utf-8?B?YXVJWUh2NlRoVlNFSVlDckJsQ0hTSHpQbGFvZm9KUlo1MlFPSGNjMTBjT3Iw?=
 =?utf-8?B?VFFxR0FhMC96ZEZ1QWJBcUxqM05qUzI2Z0s4Ni83Slc4dmNzU3AvZVVDaEhL?=
 =?utf-8?B?b1crRW5yS3djZUZiMk9YU2dMTWMxTFJSVW1vZnJDNmUzR1ljcVZwbS90SkZK?=
 =?utf-8?B?TWYrbHI4Kzl5bm0yQ0xMZ3M3NVkrenczTXd6eUdIRElKMHNBaHlCYnRSY1dp?=
 =?utf-8?B?TnFtaFpMQ0s0Mjg2M29jOGRsMitCcHlOQVZyZzJLRld4NlJ4UEJTeXptTEhw?=
 =?utf-8?B?UlFpcUhkM2VuaE5ZdnhENmRPWVgrV04zTldEWG9sR3VRVWNOZkRycS85ZjFO?=
 =?utf-8?B?SllITWdLSEZDZWQ1cE9IcEd4cC9LZk0yMFpBb0NnYm9LTE5oOHh6cWZneGNk?=
 =?utf-8?B?NytjUjYwVEIvaG1WZmMwdzNTUHJsYWFTUENxWjNDOHkrSmtMN05GQ2dnSVhv?=
 =?utf-8?B?UG52T0lxL2tnSDJicVdrajhjYmJZZGM2UjhzQmE0NzE0N2VvUnNVQnZhczJZ?=
 =?utf-8?B?dDFEVHRRNlBvcEhQaHpWR2RFZDlSV1c3cWsyOHAvNk4rbmdlN3VRYmVZSGhW?=
 =?utf-8?B?anM2SUVHTGM3OXEyYkZwUlZFUVFkTCszMG9wQ2V1OXp5S2U5L09FTGZYMmlV?=
 =?utf-8?B?T2I0RldwVUJYZWgvNjZlcVlxOWVFVjE0dkVNQkxkVndUNUNxS051VkRnMlVz?=
 =?utf-8?B?VlpnZXV0R2ZxVG5KZXE4Q1BjTmIySFFvMU9yYlJvdDJVSjluRTEwY3h1eE1p?=
 =?utf-8?B?aDJNVVk2VUg2YkdkWTZXZ3hHbHlhd2w2MWdGaXdaTFo0THI0RzV1citycjE4?=
 =?utf-8?B?QytUdS9POVVOdEFVUkFqYmwwMVMxaXZTZ2ZteHVyNmdHbXA3L2lab1RQODJz?=
 =?utf-8?B?RTJybkEyTG9STVpPN2RMdkZ0TkhJUEZFVGsxY1BIYlNZQVIydHozemh4bmxU?=
 =?utf-8?B?YUFWdXI5VW9MVUJxYUNpQTUwSWN3SGY5RGhnMmhBd0VhZGJ4bHBCc2c4a1R4?=
 =?utf-8?B?YXdmb2ZjTnVLcVJyMUdvRmRYM09xY1U1amxtYzZNQXUwVElrdVMxcXBDSDZV?=
 =?utf-8?B?N1pWdGdncWVCelRhT0dNMFNSd3JKTEg0UURwaE9jN25sMUJ3VlordFZEYzJu?=
 =?utf-8?B?c2k2aVgwVEFtMzJmenNBZUp0MnZ2WkhTSUxZaUNqNE1wclFZOHA3MDZrOWRm?=
 =?utf-8?B?cHN5QnpLZGUxUHRzSnJqRGNXUHppYWppTUg2c1pkc2M5OFJUNFNDZ29oS1Za?=
 =?utf-8?B?OG5JQVNKY1NtQ3BmckZYeU1obU8rTmcyTzBsUTBDT0NRYUg1ZWs5MERZcHlR?=
 =?utf-8?B?NmVGUU9wcFg4TWJBMW5ISklPSGlkTXgyMWNKQ21ENlZHVFYrQlcwYXB5RHIx?=
 =?utf-8?B?QXNPTVVhRlpGS3JZSC9IcHVwNWtqcDgyek9WMWtzRjIyakVyaUwrbTNQS0cx?=
 =?utf-8?Q?8eiQsIiRVo1n3lRt1qmC2T90302Qjo7Mew5yLG0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6837c688-4641-4b8f-a18e-08d8fb5f639f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 13:57:18.2827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxwzGa5vntAT+J3JVWdN3J4Zlk6OSdU/VDa2LeQGe/1/x+xBIEK7pWg9KJsXQHFxZnOo6VSTL8MHClQz39ERZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3316
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gVGhlbiB5b3UgbmVlZCB0byBtZW50aW9uIHRoYXQgaW4gdGhlIGNoYW5nZSBsb2cuDQo+
IA0KPiBXaGF0IGNoYW5nZWQgZnJvbSB2MSA9PiB2Mj8NCj4gDQoNClBsZWFzZSBsb29rIGl0IHVw
IGJ5IHRoZSBsYXRlc3QgcGF0Y2ggSSBzZW50IG92ZXIgeWVzdGVyZGF5LiBJdCBpcyB1bmRlciB0
aGUgU2lnbmVkLW9mZi1ieQ0KDQotLS0NCi1yZWJhc2UgY2hhbmdlIHRvIGxpbnV4LW5leHQgdHJl
ZQ0KLWFkZCBsb2cgdG8gaW5mb3JtIGRyaXZlciBsb2FkaW5nIHN1Y2Nlc3MNCg==
