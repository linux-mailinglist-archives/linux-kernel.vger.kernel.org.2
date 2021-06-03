Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AED39AAF6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 21:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFCTd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 15:33:29 -0400
Received: from mail-eopbgr1400124.outbound.protection.outlook.com ([40.107.140.124]:47292
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbhFCTd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:33:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSoecG9i582qoon0MGfjw354cJnUDjuq+XvofZzlYX8KbRQ2lFnGwDXEqyTgnGRnieDE6CuXca6ls+ew7XBCjt77SYox0N9JOfHv7jri8mOKL6K2k371ajnUcuCE/8U0LrZ+9w1jO5ghqPm3ZI2b6VDJKbfNEWBLdBGVCyPcVk7mkLryFfkmRQGBo6PeG3iEcAE6wcrdGpK6wXn69FUx56vdidHlnrQ4wsz0SrYgWVUiaBCZlFs7eVpbDmAcP4SgKCgkYGLf2FS9SuHWTxd95ExNI0tibUWE5StCGNx8Ir2yyDRe+FMpQ8gLXZs9LEcUYB3cHhXkdisi8V2lGx8I0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OlcC6au9Gs/+h70PY9VqWGtpfRlbKP4EJk05s0Ogws=;
 b=bbn/rPtyD5Fq4PFI4YqyS67FPJl6HYYFgaYW16RUpW5vB8Clck9Gj5MdzJfPIyNnPj3JC3ZKGRawI3cv6qgbGdD1lUtihbYma9RFkw2BH9jt7VKXbVlCmtaQcHB8y5HVnO5l//M3JUqHoCuwEodoGNqutuZxamW+58GtY0jSHLAaKxP3iurB1r8Lgp+czZwyA7W9wdoHhA+AT7KrpIJgNx+6Fdyiq8hvi6dqniKFd66MEubkpREQl8rf8viq4ILlDroOV+wYxPQpHgBfXazpvtUNs6XrB8xQRJ6btE1wBUHGTj9hcrnfpCWjFbzHsOdUag3+uq2ZeG+yHBOuAorjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OlcC6au9Gs/+h70PY9VqWGtpfRlbKP4EJk05s0Ogws=;
 b=mj3nhHl5IQ59h/ZX0O+nd6tJhRWBUiwIwGN2DiZI3cxmFKDUeoZ1tvp8El1HicUT4+XEhjg2F3HIARxCLEbJy55q1lecYJI5avwltDtUvPoc0aUWu2X7nia3rrYQL0Iuqr4YmtZ04LM5L28BJjxqlsow0SaLQJM2UAYNn7THkHk=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OSAPR01MB3780.jpnprd01.prod.outlook.com (2603:1096:604:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 3 Jun
 2021 19:31:40 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6c45:c45:40f8:e4a2]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6c45:c45:40f8:e4a2%7]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 19:31:39 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXOtSPoxM3P4fkKEmDrY8StfrCU6rqloqAgBhRldA=
Date:   Thu, 3 Jun 2021 19:31:39 +0000
Message-ID: <OS3PR01MB6593D2C7A1CD1E5280176AC2BA3C9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
 <20210519080807.GH805368@dell>
In-Reply-To: <20210519080807.GH805368@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1fca864-a878-4bec-035e-08d926c635ef
x-ms-traffictypediagnostic: OSAPR01MB3780:
x-microsoft-antispam-prvs: <OSAPR01MB3780D6FC727B465D302F8C2FBA3C9@OSAPR01MB3780.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lh7kU1bUVIvgUfIwcDLLx3cgTA63vmOTUc3Fqk+DcWF5DcPy4onMfTOFGQKPf4j4OyQ8gm+Nb1r/2THaNbhUnSOm6hwMEEO0jHSu0h5qLjZZl1GfS+BrxpCCgbIyOhpYIKZ+cNeRaV7CTCiSuz/cFiorBVzA04h6NpsSyRgzGboxnT1Gd6LqLDDx/NnrCki5lfMIk2caM3M0gPSzOka5DtNn3pCnHC8v4ysKljJpU1vQx1z0BTeVT74cY4dMAijE+ukcBGFeSJTQeN+OqkikQt3zIzFQRAz9dtcn7GZemLjuslQhSfe3+uN05MTD7vBiNXR4dU8TGjGiJ+pnheMlKwne2hvxiJzgOt4DHDKlfcL11ftXHEkozc0QDLKAS4+omdEbsb12E9O3Z32uBTTvbUsKdqOCxjwqz6453vrtqtLVBWXBoAtdnbHwF5hoUmtA6MjcgTEwj0bUHIPjVC3WRdeC0pUIV9AwXzfqJ9Wn2dcUwHAc4OQJKBLZofexdC0nRbjApVAh8E0jBbTu1uuEmI4qcsg2PpN83x8VUADEoYXG0SMqkiO3J+Q7+AlbfpYkHwVLDDhvYhqELfJSLHjtNCMSFDF4G9UuCJIlsmBX7B0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(346002)(396003)(366004)(376002)(4326008)(38100700002)(8936002)(316002)(55016002)(7696005)(26005)(66556008)(64756008)(86362001)(66476007)(66946007)(478600001)(66446008)(76116006)(52536014)(6916009)(33656002)(5660300002)(54906003)(71200400001)(558084003)(186003)(2906002)(122000001)(8676002)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QllSQ0YwTDFBUXE3bUE0L29RNW9kdEJMYlcxemZSUEdNdDVKdVg1eXg4VWVn?=
 =?utf-8?B?MjFuYTJMMkxsUkEyOXZieWFWdWVERmEzV08zbjlUZkJQS25BREIyU0NTcEtP?=
 =?utf-8?B?QWhXWGZPYVR1dGRNa2ltZWdoOVlETE9pRlE1ZkptQ1V6bFB4TzRLbmQxY3NS?=
 =?utf-8?B?ZVhHclJjZmhhVTBzb0s0MHM4NDNtb0RkOWV6R3FHdXUwaUIrYUpmeXdEaVB0?=
 =?utf-8?B?a2lwZnYyYzBCN1VOLzVybG9jRForbEYxa1RSZDFYdXREV1piWjA4Nk83QTRP?=
 =?utf-8?B?dHZZa2M1YWNHVGtYUC84UzhuTUlmZURLaWN3ZTUxN0ZsS3FIWTJlNFdFZjlO?=
 =?utf-8?B?YWp0VXpBbjJJNFlrbFYwVEtQU1JzZjdCRXhWVjRuYTlUNEIrZ0IvbmFKWC9Z?=
 =?utf-8?B?T29KYWZHUmQ5Z0lKeGg2ZXlqcTJHTklPN0dYdWtFQlVUbmJ6R1QyQVl0Sk1J?=
 =?utf-8?B?S2s3R2lzUXYzVlJpZm9JSmZjWDNVcWVZWGxBVUFkUGREOE5meDZiYlphcVFo?=
 =?utf-8?B?WDQvLzYvbE96OTFuOG9PK2RJWXlJaXJzdVkwNVdBUEpjb3hBSW14eWx6UkV0?=
 =?utf-8?B?QTZyRmt4ZG10VTZoMzFqcGZxSzhQUlBqZGszMW52bkhSY2Y0dk9ITzhOVUFW?=
 =?utf-8?B?V3VScFlPcmFuSXh1VzhSL3UwQ3YrYldZTTQ0TlBGVFNJV2MyTWU4b2piRVJR?=
 =?utf-8?B?NVpWSGYxTGJBOXhIOGlEVC9NL29qK1R0TzluWnlmaHVPejlJOGpzeWFZdXRp?=
 =?utf-8?B?Zkg3OSt0VWlWSk5xN2s3Yk5hV0JPMjJZenNUNENwMTFUTGJiK3p5Q3FNQXBr?=
 =?utf-8?B?TWFybW8ydjdrL25YS1l4OFlKeTRqTVJNbTRmNC9FOExDamJuTVFCeS9LK1lu?=
 =?utf-8?B?OGRhMTFmcFRQM09sV0NMTERwY2dYSTZVY3lNaGdVT0FVU0tPSTJnakttN0dv?=
 =?utf-8?B?eTlobURTU1k2MkNkTmpYaG9yT2pxYnpuQWs5RkY2cHpFUmNYb3hZZEZTcHh4?=
 =?utf-8?B?NWU1TjFOcjRkVitOaDZ1Z05sWHJUTWJ1aEQrekRuQU5lMHV3VG1YSzhwM0V1?=
 =?utf-8?B?bDg2OUVmdHNld0VPWFBVYXFPemI2V0NCOStJMUdQQ0duS3J3RmFZMjlaZW5E?=
 =?utf-8?B?eUVnQzBLM1IxUGFJWEdPY244SzhvWjNsU3lyTWxKQ1pyU2ZnWElOUXN5b0Q5?=
 =?utf-8?B?QUFmNUh0Q2dRcnErSG45UXpPZjBvMGU2YnNDem9WZWwxajNqQm9rQzhCSFhR?=
 =?utf-8?B?bmY2eGZLbVBubFlWK25Sb2h2QmlQWkxUTHl6NlFmRGJVRnZXMVlCbkpMRm5J?=
 =?utf-8?B?TXQ5L0lNK2Rxd1UzQ1lpeHV0U3NDTUdvOVlKem5XdE1memt5d0s2aDJUZWRN?=
 =?utf-8?B?Q2JtaDlsMEo5dldGMzlFVm5hcFZZTm1kZVRiTExVVHJPbnNMTUsrQzR3aTlL?=
 =?utf-8?B?TW5Od0R4dnZDL2pNbDdJL0hzVmZxYUdHbml5c2lnSEltcjgwcUtBMmxMeCtX?=
 =?utf-8?B?c2lQZ2xiTXhWQjVZV2Z2U29RT29MTzR6dVR2T0RicWF4dWF5MWZhenlzSHRX?=
 =?utf-8?B?c0RhM3NQRk9wWXViSXVKa1QyZkE2cnRLM0xpeFJRMXROa0s1cW5QKzN3TEhn?=
 =?utf-8?B?R29JbE1PdkU1OS9peUVlTnMzQkZhOFk5MUV3Y2gxQ0ZQdUFPQ0xIeFlBWnZ5?=
 =?utf-8?B?dTRCR1QvVmovY2NaOURsME4vVkpVZXdYWkJ1SjhCdmc2ZFgrd2R6WTIvQ2R2?=
 =?utf-8?Q?ZUuwRjt8H/HMNf8q4PFHFspsYl11d+mohE5yrRM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fca864-a878-4bec-035e-08d926c635ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 19:31:39.8856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: io22hjdHqAFufUMFLMFk6VAWixokIwZfZtgaWMrAhLqdoFjzrkKJaKcLbR9h0VsC2D9s3df7+pZ5fxXwgHQ33w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3780
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gU3RvcHBpbmcgaGVyZSwgYXMgbW9zdCBvZiB0aGlzIGlzIGR1cGxpY2F0ZWQuDQo+IA0K
PiBQbGVhc2UgY3JlYXRlIGEgY29yZSBkcml2ZXIgaW5zdGVhZC4NCj4gDQoNCkhpIExlZQ0KDQpJ
IGp1c3Qgc3VibWl0dGVkIGEgbmV3IHBhdGNoIGZvciBhZGRpbmcgdGhlIGNvcmUgZHJpdmVyLCBw
bGVhc2UgdGFrZSBhIGxvb2suDQoNClRoYW5rcw0KDQpNaW4NCg==
