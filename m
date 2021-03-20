Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803563429F0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 03:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhCTCOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 22:14:35 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40612 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhCTCOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 22:14:07 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 866D2C00D3;
        Sat, 20 Mar 2021 02:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616206447; bh=AUmSKk8qUO+aNcnyHSZtYuzB3fCyS5B6PgsH1uTltQc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=B4CvMW/1glBlQsPbYuc8JQ5nR+nSHJElKWvZPvYsP/IOG6N1mzQ7Javle5yNVtS0P
         NB0/mZdHSTiTDMjyExG54v4TBOeegYIJ4GZcybdIVO2zmdz3w+bTzzsWsf+c3AkMiI
         Tj/N9d0/9DrFLWbLo2cs+S/xjY22PQ82rx7lPA+d1j8S//khZ1mpX9Z5fgpT/uV2WN
         xw7yPWbZUwKvBE6zyyXOLgfV++4G/FuNQ+UuHH8loYxtoctMjlE4AtbkkZEUsqSBOK
         CVKiaMNtrYBhGR0awyvIXwjV9jjgNHl/7oJcvlBI7Mge41eUUXEojFOqbYmCCcAbBB
         TroJgoL3aCH/A==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C1982A008F;
        Sat, 20 Mar 2021 02:14:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D44C180056;
        Sat, 20 Mar 2021 02:14:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="fV3H54vN";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU0vFeTu7FMLS620z4RUEM77fsXwyP3U9J0NSASLJnzdPFgVSqpsD2Wl2hPVJtcvONHC6Uk5YK2gl6B1BY25awz3Bdw3nB15FYG5cP3IPDUzYaWobZpZLNPMjgzLalo2xAxydCUdQxpbEVN0lgQYFZntdELVSn1W5968Mgp0JYuOSbSbnMYrAdTTcxYxrNsvbd3CQwsQdiDA82Yu8l4RzlX+TRK6iJj+QhugP92xw2WHlTSV4EkUBDmkhX4+NVhYNtmhpyAseP4RtDpCrbhM4cyqSEmp94ptk77Hxzkfx6Fv8trhglgs2vEDRFa0inoJlWhMZDM6AqHgfZNlOhvmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUmSKk8qUO+aNcnyHSZtYuzB3fCyS5B6PgsH1uTltQc=;
 b=UdyUofEg32kDraWZ+I0e5aXAuc+Q+VDaqE4NgMBu2tQWpL/GDuTLudwcyumEVwcRbz/V9jf/NSqpzy2PvKzbVRhsKvab1zaOgvcDje6FuJxKs8P5JnuVnJx2E9Iz+LDsyLgBwZvip0cBssi/DABVOrkYDfm6zJP7oAOqg2QTVz+XPkem3zgs5Y7aLiaTt7XilxQP9hh2+g45IIqjLYwwQGPaeYotEFBhMxLnsIZtPTRmg2yYsZxaucvX6d8HHduQUX6yLABuQPBzlbeXkIjgPTNRjbqQjwO737A8XaA2NPVOJxEmIbyb1w7UgHrryw7ILsD4E89OdNVGfy5O9GGl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUmSKk8qUO+aNcnyHSZtYuzB3fCyS5B6PgsH1uTltQc=;
 b=fV3H54vNywACHTXfeXTsVkv5nlf4C8ryrxYcZQNeO/tcDCXK4G7zIMfTsOI+eWhi5e4d7j2W/LsGQgwcOzI3O07OGv+M99ppOVrr3V05NDW8+LbYj2fpONEiBHJ1tvmxmvucywgjv2rwLF0NM/7OCaTsn0YVXcIXi3jlme+L518=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB3937.namprd12.prod.outlook.com (2603:10b6:a03:194::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 20 Mar
 2021 02:14:02 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.3955.023; Sat, 20 Mar 2021
 02:14:02 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: Ignore EP queue requests during
 bus reset
Thread-Topic: [PATCH 2/2] usb: dwc3: gadget: Ignore EP queue requests during
 bus reset
Thread-Index: AQHXHKLL7cdvVEBRMk+XgbJ+0C2uUaqMCeEAgAAHrQCAAA8agIAAA3SA
Date:   Sat, 20 Mar 2021 02:14:02 +0000
Message-ID: <7b0795cf-37f8-fc2f-c40a-a46a230080ea@synopsys.com>
References: <1616146285-19149-1-git-send-email-wcheng@codeaurora.org>
 <1616146285-19149-3-git-send-email-wcheng@codeaurora.org>
 <eae3f779-acb0-c685-4323-d97c7c5c6296@synopsys.com>
 <1886f649-3da2-de25-405c-69c66876b0fd@codeaurora.org>
 <debcdb02-1164-df83-1174-440dbe31dcc3@synopsys.com>
In-Reply-To: <debcdb02-1164-df83-1174-440dbe31dcc3@synopsys.com>
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
x-ms-office365-filtering-correlation-id: 7305fa5e-f532-476d-fa43-08d8eb45d4b3
x-ms-traffictypediagnostic: BY5PR12MB3937:
x-microsoft-antispam-prvs: <BY5PR12MB39371C98FD12F82DF7E72FE3AA679@BY5PR12MB3937.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O2aGW3IyOoawqpDuzbpBFaEwGnmx205WMaW1VvUN9iJtt/OvpTKMqYfjq3CO1KmcLPOD6Noyp3yeBOARmB2wrxPJhcJ2sRWSqHmJFk7/Nsrb7uZgWZFNyrQ53lBrtjDY/ktlY+vsjO1I5SjoWb5Ht0i/UkVT4sI+ocUMSNp/RP8+Ssw6Ty/P+Z5kT4PoGL0kdfMMF0XflP8ngg335wvKe0p1LcE/sHqznfArxQ+wnFp/mq0WD1/oKLyRO1yKCt9U0/lgpUahsruh3Ae4VmYCsmG2wuCo7LqLhxrj41mCB0OO3IuOj903IT4c2kvZ0pVYby1VcdZ2lDTeBYMBZWraEVNUuvbXJaKeSUxmre7JTrXrpzpSqE0vtjvO23wtGoi3+LtsoXQgUCR2CFOHjU3LR5SyKs/dvrdCAgwGYarOQmffqVMSE5Xd8vuzd/g7WePyA7AKo2LDZZ7cmapDcTLbZeFYpU9IeW0d8zdciRsMhhHj7ovW6kWwW9Ria4xHb2Mztz43Pkp+oRQm79V/iechm1Em28n8p1zopg0e1yvHEzAgFvZCT1KIpMErlcjYzbzqMLAP8IHX/podIoRcCG5s8t7US7K1UZVcD9/H1OvbgKFUxIK4XwxdRLXGHMhmXk6RfCOS8QtuKtgxZWhFrKVLTofXiUBvAq+f3NiidXEWShrTfJdsvyeGeTGigQTIiwzNxPemYLD+h1IieYUfG6JVesphlrDGe7BjYI9dfk4q9ok=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(346002)(366004)(66446008)(86362001)(186003)(64756008)(6506007)(66476007)(66946007)(76116006)(66556008)(478600001)(83380400001)(110136005)(38100700001)(54906003)(26005)(53546011)(31696002)(5660300002)(6486002)(2616005)(71200400001)(8676002)(31686004)(2906002)(8936002)(316002)(36756003)(6512007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MVdCd0lQcnlRTE1GNnNuNktlZ0dMZGFWZTMvekxPeUNCb2Z4Tk1WNmJnRXFp?=
 =?utf-8?B?dUlUandla0Nwb3pPTW9ocmVGMEdkd1pDWHZMNE9VdC9tK3pyOWpHTnRvdmZR?=
 =?utf-8?B?RHBZUWxaNmxySHNaL0ZYQVZVVUFRUnZqZ3poNHBYTWlCTng3YlRUQU5Ec3pz?=
 =?utf-8?B?S1J3dUw4b2lHYUJiUVA3bXpjQ2ZzcUF2MlN4S3MyWXhJV3ByTlpWUWNhOFc0?=
 =?utf-8?B?eVZCL0JTNWNyVTJnOERKdHBKbTZhTytwNXVZTUx4UnljU3g0TGlhOEpRbUQx?=
 =?utf-8?B?eFRJMEdpQUxlYTg3cXZyN3A5eDRvbWoyVm9sdmZheWJCSVlYN3gxMjM5bUw5?=
 =?utf-8?B?T2NxSGJBMWw0RkFVUi8rSlMyNWl4NzgvSUVwNU1qVFlWZGpJajQ5bjdEeTNn?=
 =?utf-8?B?dWJwUm5nYWltQlIxUmJSSXdpeTBUZFVvTjFLQWt5SGJrRFZaWERJaERxYUpY?=
 =?utf-8?B?ZU41T0M0U2VGcE1MSzFHbWxSTG1XYUtJREpLVmpYeEJzcjZjYnhJYmFGbVhr?=
 =?utf-8?B?SVQxV20vNFVlSE9GOElFR3ZIZXFDZHMvUS9zWHNONWRqRUFmQ3hkWmtyL1Fm?=
 =?utf-8?B?YVZTQnlHRXNTaS9hMWd6bW1PY1RmNXIvS3d6UXc2MEpQTkxxQUtHK2tWTkxm?=
 =?utf-8?B?Q0UrTXpKOFRNYWltYVIzc2dsZXJXaU4wNng4amJsbHdOZHVzZytHUld4c3Bm?=
 =?utf-8?B?c1NNVlZNcFBuVEpDcDF5WEl0ZEFxamJKSHJuU2FUV0h5SXBSYjdpVVF2Zjlh?=
 =?utf-8?B?Wnc0S1NhdWhmREpCYmttejQxL0VwUGt5YlFuOWRXbEV6QkU2VmxSUU1GTWtW?=
 =?utf-8?B?QklabHQwUUxKaWNpVms5ZlZUN3gxaHhYdU1UV0gwdEJ5VDJtNkFicVlkcnNK?=
 =?utf-8?B?QThtQVZBVFArMmY4Z3FHRmJqVDVFSmN1ckV4OUJSbUxLUVVtc3M3S09XeHMv?=
 =?utf-8?B?RGkvQlNtK2szSXFSbXk1ckNocVRFYjhZZ0VaOGJHT1RoZzNYWTJlWkVEVVFF?=
 =?utf-8?B?c1gxRGRiVElwRFFCVHM5TWNqZHVIUmFjZEZ5T1BxMjY0RVdTZ3dMVjJyRWdS?=
 =?utf-8?B?SHBZQjdrVTZFQ1ZjcUZjeHdnZERYb3F0VnZIc0JkbWMwb29QMm9wbGc3aE1F?=
 =?utf-8?B?V2RJb2l2cFRkUXBQQzhieDVyS0NpU1IxNklza1U1UTdtV3lEVWJWMFJyaFVB?=
 =?utf-8?B?ZW5wbm5xamRUL014Q3JINFF6YXJUMEx5bTRjR3cwNU5GcERCamdhb0djbktB?=
 =?utf-8?B?cEJ5WTVxNXkzeGRaaG9ONEd6QXpWaDg1NDBYY0kvQXBpMDdIVFpOcmNuSzBm?=
 =?utf-8?B?TU9SdUhjTnUvcDFQVDRzTXFFSW9WY21ZTW5KcXRwcjBVM1RqbzBYTGZuUW5I?=
 =?utf-8?B?OWxmYWcxbVRJa3E4dnlOc3ZIZFFuLzhDdWIrVko2cUpOTXh1blQzRVUyaGg1?=
 =?utf-8?B?ZjVDWmVySE16SndEZHNzMDQvckNiZkNXeDJUL3hRNzI0aG5HUGF4WFYzSmJ4?=
 =?utf-8?B?MVg4cWVEQ0kzNlhpVU9YQzBsbDFFK3UvNkZvb2FiN01xb2loQnlGdDJUM1RP?=
 =?utf-8?B?bFRZdnozZURHeGh2eEUxZHdLRFRWR2cwS2g2NnBzY3lFTnlNb25rTlM2RjQ3?=
 =?utf-8?B?MlFYOGt0dkFjYXJERjNNSnUzMGlnT1p5KzMwY05LWGt4ajVnWENtK1Vhc0dr?=
 =?utf-8?B?Tnc1SGp5Q0kyQXNzb0RSRWtnWkNRa0hHMWI2WjVrWFZvSmtBcm9EcTFMeDNX?=
 =?utf-8?Q?6XUp7dVrvoa58l+cKxA6pZvo3bkTsXo513H3jwG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E06601DB72C88F4EB97B75E1DE9ECF60@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7305fa5e-f532-476d-fa43-08d8eb45d4b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2021 02:14:02.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Pdt+MIFcB2EgCmzK8hbBUumb0WmUyzof/VDlV3a3Z9iIM8IKzaEQIQtqKZKQPZzWPT9sjnbP6EVXctDrZC3vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3937
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpbmggTmd1eWVuIHdyb3RlOg0KPiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pg0KPj4NCj4+IE9u
IDMvMTkvMjAyMSA1OjQwIFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+Pj4gSGksDQo+Pj4NCj4+
PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4+IFRoZSBjdXJyZW50IGR3YzNfZ2FkZ2V0X3Jlc2V0
X2ludGVycnVwdCgpIHdpbGwgc3RvcCBhbnkgYWN0aXZlDQo+Pj4+IHRyYW5zZmVycywgYnV0IG9u
bHkgYWRkcmVzc2VzIGJsb2NraW5nIG9mIEVQIHF1ZXVpbmcgZm9yIHdoaWxlIHdlIGFyZQ0KPj4+
PiBjb21pbmcgZnJvbSBhIGRpc2Nvbm5lY3RlZCBzY2VuYXJpbywgaS5lLiBhZnRlciByZWNlaXZp
bmcgdGhlIGRpc2Nvbm5lY3QNCj4+Pj4gZXZlbnQuICBJZiB0aGUgaG9zdCBkZWNpZGVzIHRvIGlz
c3VlIGEgYnVzIHJlc2V0IG9uIHRoZSBkZXZpY2UsIHRoZQ0KPj4+PiBjb25uZWN0ZWQgcGFyYW1l
dGVyIHdpbGwgc3RpbGwgYmUgc2V0IHRvIHRydWUsIGFsbG93aW5nIGZvciBFUCBxdWV1aW5nDQo+
Pj4+IHRvIGNvbnRpbnVlIHdoaWxlIHdlIGFyZSBkaXNhYmxpbmcgdGhlIGZ1bmN0aW9ucy4gIFRv
IGF2b2lkIHRoaXMsIHNldCB0aGUNCj4+Pj4gY29ubmVjdGVkIGZsYWcgdG8gZmFsc2UgdW50aWwg
dGhlIHN0b3AgYWN0aXZlIHRyYW5zZmVycyBpcyBjb21wbGV0ZS4NCj4+Pj4NCj4+Pj4gU2lnbmVk
LW9mZi1ieTogV2VzbGV5IENoZW5nIDx3Y2hlbmdAY29kZWF1cm9yYS5vcmc+DQo+Pj4+IC0tLQ0K
Pj4+PiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDkgKysrKysrKysrDQo+Pj4+ICAxIGZp
bGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+PiBp
bmRleCA2ZTE0ZmRjLi5kNWVkMGY2OSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4+IEBA
IC0zMzI3LDYgKzMzMjcsMTUgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfcmVzZXRfaW50ZXJy
dXB0KHN0cnVjdCBkd2MzICpkd2MpDQo+Pj4+ICAJdTMyCQkJcmVnOw0KPj4+PiAgDQo+Pj4+ICAJ
LyoNCj4+Pj4gKwkgKiBJZGVhbGx5LCBkd2MzX3Jlc2V0X2dhZGdldCgpIHdvdWxkIHRyaWdnZXIg
dGhlIGZ1bmN0aW9uDQo+Pj4+ICsJICogZHJpdmVycyB0byBzdG9wIGFueSBhY3RpdmUgdHJhbnNm
ZXJzIHRocm91Z2ggZXAgZGlzYWJsZS4NCj4+Pj4gKwkgKiBIb3dldmVyLCBmb3IgZnVuY3Rpb25z
IHdoaWNoIGRlZmVyIGVwIGRpc2FibGUsIHN1Y2ggYXMgbWFzcw0KPj4+PiArCSAqIHN0b3JhZ2Us
IHdlIHdpbGwgbmVlZCB0byByZWx5IG9uIHRoZSBjYWxsIHRvIHN0b3AgYWN0aXZlDQo+Pj4+ICsJ
ICogdHJhbnNmZXJzIGhlcmUsIGFuZCBhdm9pZCBhbGxvd2luZyBvZiByZXF1ZXN0IHF1ZXVpbmcu
DQo+Pj4+ICsJICovDQo+Pj4+ICsJZHdjLT5jb25uZWN0ZWQgPSBmYWxzZTsNCj4+Pj4gKw0KPj4+
PiArCS8qDQo+Pj4+ICAJICogV09SS0FST1VORDogRFdDMyByZXZpc2lvbnMgPDEuODhhIGhhdmUg
YW4gaXNzdWUgd2hpY2gNCj4+Pj4gIAkgKiB3b3VsZCBjYXVzZSBhIG1pc3NpbmcgRGlzY29ubmVj
dCBFdmVudCBpZiB0aGVyZSdzIGENCj4+Pj4gIAkgKiBwZW5kaW5nIFNldHVwIFBhY2tldCBpbiB0
aGUgRklGTy4NCj4+Pj4NCj4+Pg0KPj4+IFRoaXMgZG9lc24ndCBsb29rIHJpZ2h0LiBEaWQgeW91
IGhhdmUgcmViYXNlIGlzc3VlIHdpdGggeW91ciBsb2NhbA0KPj4+IGNoYW5nZSBhZ2Fpbj8NCj4+
Pg0KPj4+IEJSLA0KPj4+IFRoaW5oDQo+Pj4NCj4+IEhpIFRoaW5oLA0KPj4NCj4+IFRoaXMgd2Fz
IHJlYmFzZWQgb24gR3JlZydzIHVzYi1saW51cyBicmFuY2gsIHdoaWNoIGhhcyBjb21taXQNCj4+
IGYwOWRkY2ZjYjhjNSAoInVzYjogZHdjMzogZ2FkZ2V0OiBQcmV2ZW50IEVQIHF1ZXVpbmcgd2hp
bGUgc3RvcHBpbmcNCj4+IHRyYW5zZmVycyIpIG1lcmdlZC4NCj4gDQo+IEFoIEkgc2VlLg0KPiAN
Cj4+DQo+PiBjb21taXQgZjA5ZGRjZmNiOGM1ICBtb3ZlZCB0aGUgZHdjLT5jb25uZWN0ZWQgPSB0
cnVlIHRvIGFmdGVyIHdlIGhhdmUNCj4+IGZpbmlzaGVkIHN0b3AgYWN0aXZlIHRyYW5zZmVycy4g
IEhvd2V2ZXIsIHRoaXMgY2hhbmdlIHdpbGwgYWxzbyBlbnN1cmUNCj4+IHRoYXQgdGhlIGNvbm5l
Y3RlZCBmbGFnIGlzIHNldCB0byBmYWxzZSB0byBlbnN1cmUgdGhhdCB3aGVuIHdlIGNhbGwgc3Rv
cA0KPj4gYWN0aXZlIHRyYW5zZmVycywgbm90aGluZyBjYW4gcHJlcGFyZSBUUkJzLiAgKHByZXZp
b3VzIGNvbW1pdCBvbmx5DQo+PiBhZGRyZXNzZXMgdGhlIGNhc2Ugd2hlcmUgd2UgZ2V0IHRoZSBy
ZXNldCBpbnRlcnJ1cHQgd2hlbiBjb21pbmcgZnJvbSBhDQo+PiBkaXNjb25uZWN0ZWQgc3RhdGUp
DQo+Pg0KPiANCj4gVGhhdCBzdGlsbCBkb2Vzbid0IGFkZHJlc3MgdGhpcyBpc3N1ZS4NCj4gDQo+
IEJlY2F1c2U6DQo+IDEpIFdlJ3JlIHN0aWxsIHByb3RlY3RlZCBieSB0aGUgc3Bpbl9sb2NrX2ly
cSooKSwgc28gdGhpcyBjaGFuZ2UgZG9lc24ndA0KPiBtYWtlIGFueSBkaWZmZXJlbmNlIHdoaWxl
IGhhbmRsaW5nIGFuIGV2ZW50Lg0KPiAyKSBXZSBkb24ndCBlbmFibGUgdGhlIGludGVycnVwdCBm
b3IgRU5EX1RSQU5TRkVSIGNvbW1hbmQgY29tcGxldGlvbg0KPiB3aGVuIGRvaW5nIGR3YzNfc3Rv
cF9hY3RpdmVfdHJhbnNmZXJzKCksIHRoZQ0KPiBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5H
IGZsYWcgd2lsbCBub3QgYmUgc2V0IHRvIHByZXZlbnQgcHJlcGFyaW5nDQo+IG5ldyByZXF1ZXN0
cy4NCj4gDQo+IFdlIHNob3VsZCBkbyBkd2MtPmNvbm5lY3RlZCA9IHRydWUgd2hlbiB3ZSBoYW5k
bGUgY29ubmVjdGlvbl9kb25lDQo+IGludGVycnVwdCBpbnN0ZWFkLiBUaGUgRU5EX1RSQU5TRkVS
IGNvbW1hbmQgc2hvdWxkIGNvbXBsZXRlIGJlZm9yZSB0aGlzLg0KPiANCj4gVGhhbmtzLA0KPiBU
aGluaA0KPiANCg0KSnVzdCB3YW50IHRvIGNsYXJpZnksIEkgd2FzIHJlZmVycmluZyB0byB5b3Vy
IHByZXZpb3VzIGNvbW1pdA0KZjA5ZGRjZmNiOGM1LCB3ZSdkIHN0aWxsIG5lZWQgZHdjLT5jb25u
ZWN0ZWQgPSBmYWxzZSB3aGVuIGhhbmRsaW5nIHJlc2V0DQppbnRlcnJ1cHQgYXMgeW91J3ZlIGRv
bmUgaGVyZS4NCg0KQlIsDQpUaGluaA0K
