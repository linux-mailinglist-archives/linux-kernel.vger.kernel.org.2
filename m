Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B533575CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356057AbhDGUVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:21:11 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:34768 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234971AbhDGUVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:21:09 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CF09AC0273;
        Wed,  7 Apr 2021 20:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617826859; bh=/j5r1SzDdBXa7F5fwEXNTs1hYUM6A8oJMHz7KG8q864=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=C6obl0yrpvimFta5h/+v5wxd5ScA96I7ZB6UPHf4kjDabwBuYu1VmC2VhqSiTZkBl
         0AyKHHQJ3TlORiGH8yfr/XgqoxVM0SZ5uoy5lnElju0aYdJ6A/erWJGP73cOvmq4Yu
         mVJ/omy7pq80Z733Yon8bpo7SjoDeA6DW0/PHnv5GKPoi0Pq3uAl+H2PcJ26KV7P+4
         TBuiFIfKxvpvwkLsJqis6Ox2uODiaFU+E4ArlImWH1d80zDAE5jwgZukByPZXI0sD4
         Oo72lgzWjAIVQAD2CQS2XHLKKUjAwdkMH4A6rQj/mR9uha5k5svJ9YSCpS0kmp67NK
         urGROyg5Euupg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2B847A0071;
        Wed,  7 Apr 2021 20:20:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E5CBA400FC;
        Wed,  7 Apr 2021 20:20:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="LHZNhSoI";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3FyvS1qqVIvcwSdVTIs/Ng913dYmedVZEG5cw0FbBd/W6V33wwJ+HdUQ818na0YrLaY/ppQ3IwaBKbSVDxmQTLhjCqkrZpiFI1uZDeht/KOX0AykRBsTKL7C9C5z5oEaLbWguZQ9iGD7tJbDXcKJlaGVwD0AtVyIMpkWyBM34LLJ1L8WnAm0G8SU3IjIosMTARS0+DuzgAQd4H514Yxp9WRqvCpmewQTQ2MMkzzxqNbMgSe9cO/+9YQ70kcRDGQPnmA9T6K9eOy5hUR41CIX9f+xvpuc3/8H7JI3hWrlKyEXHiblemrXCfIQxgEZ/9SeOcECgkqcopEJUUzu5VsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j5r1SzDdBXa7F5fwEXNTs1hYUM6A8oJMHz7KG8q864=;
 b=KsSeLS/uA8ww6HzDYYE/jOdxWmdURShsECmqY2bwTawSci+V2CxRi83GES5BPUInWF8hBtVBdI2Nyir6NqcCyhOLI5JnwUTyImgZ8vf4MdoTpLmqE/b34S9yJ0g6ZD3fDWHXkQc6lMX893ix+yfnphk9Xgi5bMRcUvRsDj4BX/2PrD9kuBKDVBEst/bRIS3YrKX+sOOdb+2rKiy8w3T4lMpke0PoiAvrmZ5ydziVLIgpvF4VOezd/4ZAajppvUYBvycPIZm1oP4F8Wk9xnOg3Od62+GrXFbhk6SnNqM0V4XKZQUXHcDAkEstraFMcIeHFKZENe9umDZespqYJydB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j5r1SzDdBXa7F5fwEXNTs1hYUM6A8oJMHz7KG8q864=;
 b=LHZNhSoIPSoItv+ATNa3WEvho0vdl/+Emt46vHgpuiT+3Qrsh73AK9Me98JIMInc5W24wIGkukSEHa44PGZKX/P7OuIqWj9VJFoOvHj9NAZ/Jn2AWfeVPOBLXydTD4Ov8ssyMfBJnDBD4SP2EgjOERDPcY10mfalnQ5HECx+KsY=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 20:20:45 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::88a:1041:81ed:982]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::88a:1041:81ed:982%7]) with mapi id 15.20.3999.033; Wed, 7 Apr 2021
 20:20:45 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "walken@google.com" <walken@google.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH] arcc/kernel/process: Few mundane typo fixes
Thread-Topic: [PATCH] arcc/kernel/process: Few mundane typo fixes
Thread-Index: AQHXHxovXnk1vLT8iECGhoflJfEDQKqpmMUA
Date:   Wed, 7 Apr 2021 20:20:45 +0000
Message-ID: <d90ec8a1-f719-5145-fd70-849cdac99162@synopsys.com>
References: <20210322125155.3401540-1-unixbhaskar@gmail.com>
In-Reply-To: <20210322125155.3401540-1-unixbhaskar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 058b383c-e72f-470c-ada3-08d8fa02a03e
x-ms-traffictypediagnostic: BY5PR12MB4082:
x-microsoft-antispam-prvs: <BY5PR12MB40820E93FA55F36DF382BBD6B6759@BY5PR12MB4082.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KmIvoJvHQ1eoPHDUkdXV6JFKdNq3eMOHF2aXuVCQ2nM3Ol91Ldqxagq/m5pQpblz2ZGQ3BcFW/7gGPw9aiFMRJI0ti31KYYnKhowL11lxXxSscioc3237Sp8zcescJR8hdDOO4Bxu0W3bb33xgDpQbOPg9dw7ziCLfwMhTsJGrumR+hsJ6Xe+qrFyJPsV8uqxGFXs/JYCsNM9e2wjVxDyzXeVVcV0+qEISJQJs4ur4Afo3lvUXK0T4cU64FmfLFX+cAepXtl9iSg2gC2uXT2o1claRzvE58PFenxJlDObvI5MArN91Yus47QeA57weRpHzUIFQcOlDmmuJHZW5pvoCn/DtV6TowSiQ7q8udYEzlKMhmjpFEVXOZuWg244HnGFqoYrPUCdKudpWB1v9iO9b6kT1lYi2BMHZO/iBdBR6gKfR447doasBEyzGYTpHW8Izb3ZQJcH/V6ybGe+39BH3I/uffVYwulgd0bzcwCAMgXiRIZ98B9iqAPGl+Cqvw/BQXxEG83NFkOJPsmB8yITxO9q8YgEMT88bsNX1zIk0UJtrHs5cxWpAO1alx5pGs6RXyLcQlTEfM1lQZb8/oTdF83dVLdVS5X2IFsQr7os+zXw//HMBw6VO3MLOVtwiM7QaR+nrD3RojFa/No0NT8vkQB9Cs9s0x/Dk4ZII3fWdA8w2m81go84fJ6QnVAuO1G7t+wCcnln/q69vvnMYVIp/eMkKl9tuh3Zds+TGLc9kAb3CLpYoA/Jq8MYAFwcD/q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(39860400002)(396003)(66476007)(66946007)(66556008)(64756008)(66446008)(31696002)(31686004)(8676002)(4326008)(8936002)(6486002)(110136005)(2616005)(6512007)(83380400001)(38100700001)(5660300002)(186003)(921005)(86362001)(2906002)(71200400001)(36756003)(316002)(7416002)(478600001)(53546011)(76116006)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QTF4T2U1S2xhem95UUdrV2dLNlczTDRVbGhDaHBkUzFuWmkwNi9QNjZGS3JY?=
 =?utf-8?B?R2g0QTdSOEd2VXdHTDZzZVkvazBLSGtEcVJaVHlPcVZpM3dIRUREajRwV3hR?=
 =?utf-8?B?ODlXOVhmNklOelpZU21ZWW4yaUZqdzNGUldLNStCQzMwVlVTRzI5TXFNKzNL?=
 =?utf-8?B?RERwZzFxOWlIQUg4SmRXK2FYZGordms5eStHQ0ZwZlRNbGxCRWNJRE5rZ3R6?=
 =?utf-8?B?aXdTclVEcExjWTlGSDd3dGxyMnJUWWxMVC95OGZtb1kwVnVJSHlCVlZkL0hq?=
 =?utf-8?B?Zm1MWFpxazVyTXZnRWdpeDdmSVQ1dXJQdGFUUUVyOXkweEttY1BhQ0pTN21o?=
 =?utf-8?B?Q0QyclQ3WHF2eWpCcW1HQzNKeGlYVlpESHhOeWdwYXZYZFhKT3FKQy80NG4z?=
 =?utf-8?B?em80SDBDcjBYcHNWWm84cmxHSTFDdHoxOENhYkpWdiszMkRvRUZaUnNDa25U?=
 =?utf-8?B?c1IyQVZWVm5LZkhnNTRtVzBaME5MeUt1NVl2YlAyMDFLUklRRUpmaXZIODgz?=
 =?utf-8?B?cWljbnVtcXp3ODBiYzFZZUJDMFRYVzdqUENiQThVeUttbWdMQW5PMDY1clVD?=
 =?utf-8?B?R0U3VVpSQXB2TUgxZ21iZFE2Tmk4M1NuKzdtdXY4R08wam1SK0QrSXlYcDNG?=
 =?utf-8?B?U2RiaUVFSThwWWlQMFZWRnNyOGhjTTBBbVFabmk2OWdkUHVzY3l4YlhjV3ZP?=
 =?utf-8?B?eCtHcHZXQ1dlYXUwc1g0eXgrMWdjei9DSkIvZ0xlOEZnczlRQ3paODhKSU1y?=
 =?utf-8?B?RlByWTNtek5ia296a1lBdFpWNHpVUXpUUVk0Z1MvdGxkbisvUVdmNXV5bWF2?=
 =?utf-8?B?b3FMSDVVYUJNa1QxSDcrdzRaRVVody9nRCtUa1JDOUVTbmJCNWFKSHFYMW9i?=
 =?utf-8?B?bU9KNkU3aUk0dmV3c0VKUWlKV3B0bUxNUmkrYXF0NUJ5blJiT3phVHpJdGJS?=
 =?utf-8?B?OWZRaU8xSWdlcXZzdUU0QWJOWFo3QTJZU3pnZXB6amxmVHlySEYzbVdpZ2cx?=
 =?utf-8?B?OC9XLzk0VC9ZMEdzUjh5eFFQWDQ1dEJlWGdGc3lvV3pSM01wVU1QUThBWW1o?=
 =?utf-8?B?VFFnbmt3aHp3TWRMb2c4RjRyTVNwUmhPYlBNTXpVTnNySHhJQlVGUnFFc3Fm?=
 =?utf-8?B?Q3ROT3Q0SU1LcTVZWjFXU2NWcUpxcXRwV2xYcHZQNmRsdVpvTUpvQmR4NHE2?=
 =?utf-8?B?RStCdWNQazBFUmhTckd5VGh4WjQzNk5mM3JtTVhjUDNEZWRBTExtOEVBRVpO?=
 =?utf-8?B?SDBTaWxoLzR3TE1sakpJbjNjdXR5OU5NN1ExT1VsaHQvV2VrU2N3VEd0SDRa?=
 =?utf-8?B?M0kwUjZ5dEt2U1ZXL3JOd1l3bkxkd0drNVlWcUl6eEVQNytEdGVpSTUweW4v?=
 =?utf-8?B?bWw5emtNK0lMRjJYY3M1Yi9SME1rZG96Yk5rZHNJWDNXL25nNDF0SkIvN2da?=
 =?utf-8?B?cUY1M0hoM2FCcHZVbGY2b0k3WmZQTFIwMnpRUDRuQ0lQZmNab29wU0ozazd3?=
 =?utf-8?B?Nndjb3lGdkFESHRubzhqT1g1UmEzbHlKWXN5aGVvUFdqSCsxeGsrejZtOVZZ?=
 =?utf-8?B?UFFENGh5YUpadGNIVlY5UlY2ZzRzWVFlTURwV1loUDY0cHkrNzdWbkdpZUNW?=
 =?utf-8?B?WUtWVlF2L0QvYzNrL0ZOVG1YUXVSSzlDQnpPbGNjeHMzdlMzSlZIa0tIdFNY?=
 =?utf-8?B?bHlwZ3VMbmY5bWdubHorK1BsaGFHWU4xMVRvcWJXU1BKYlhleUZlODlGckQr?=
 =?utf-8?Q?r83AtURfgDMbtYEiNo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E6881EF3B832F4F887D8D91BDBECB6A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058b383c-e72f-470c-ada3-08d8fa02a03e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 20:20:45.7236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAPnK1rlZHb6QJEWIFHnJeF2qU1qGWRejY0Jd2MfpH/AZRN+n4NM1BoG38aKjJyw2Xdkygrxm5JO4fQGpPMjVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yMi8yMSA1OjUxIEFNLCBCaGFza2FyIENob3dkaHVyeSB3cm90ZToNCj4gcy9kZWZpbnRp
b24vZGVmaW5pdGlvbi8NCj4gcy9zdWNjZWRlZC9zdWNjZWVkZWQvDQo+IHMvY29tbWl0aW5nL2Nv
bW1pdHRpbmcvDQo+IHMvaW50ZXJydXRwcy9pbnRlcnJ1cHRzLw0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBCaGFza2FyIENob3dkaHVyeSA8dW5peGJoYXNrYXJAZ21haWwuY29tPg0KDQpJJ3ZlIHNxdWFz
aGVkIGFsbCB5b3VyIDMgcGF0Y2hlcyBpbnRvIG9uZSAobm8gcmVhc29uIHRvIGJyZWFrIHRoZW0g
b3V0KSANCmFuZCBxdWV1ZWQgZm9yIDUuMTMuDQoNClRoeCwNCi1WaW5lZXQNCg0KPiAtLS0NCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJjL2tlcm5lbC9wcm9jZXNzLmMgYi9hcmNoL2FyYy9rZXJuZWwv
cHJvY2Vzcy5jDQo+IGluZGV4IGQ4MzhkMGQ1NzY5Ni4uMzc5Mzg3NmY0MmQ5IDEwMDY0NA0KPiAt
LS0gYS9hcmNoL2FyYy9rZXJuZWwvcHJvY2Vzcy5jDQo+ICsrKyBiL2FyY2gvYXJjL2tlcm5lbC9w
cm9jZXNzLmMNCj4gQEAgLTUwLDE0ICs1MCwxNCBAQCBTWVNDQUxMX0RFRklORTMoYXJjX3Vzcl9j
bXB4Y2hnLCBpbnQgKiwgdWFkZHIsIGludCwgZXhwZWN0ZWQsIGludCwgbmV3KQ0KPiAgIAlpbnQg
cmV0Ow0KPg0KPiAgIAkvKg0KPiAtCSAqIFRoaXMgaXMgb25seSBmb3Igb2xkIGNvcmVzIGxhY2tp
bmcgTExPQ0svU0NPTkQsIHdoaWNoIGJ5IGRlZmludGlvbg0KPiArCSAqIFRoaXMgaXMgb25seSBm
b3Igb2xkIGNvcmVzIGxhY2tpbmcgTExPQ0svU0NPTkQsIHdoaWNoIGJ5IGRlZmluaXRpb24NCj4g
ICAJICogY2FuJ3QgcG9zc2libHkgYmUgU01QLiBUaHVzIGRvZXNuJ3QgbmVlZCB0byBiZSBTTVAg
c2FmZS4NCj4gICAJICogQW5kIHRoaXMgYWxzbyBoZWxwcyByZWR1Y2UgdGhlIG92ZXJoZWFkIGZv
ciBzZXJpYWxpemluZyBpbg0KPiAgIAkgKiB0aGUgVVAgY2FzZQ0KPiAgIAkgKi8NCj4gICAJV0FS
Tl9PTl9PTkNFKElTX0VOQUJMRUQoQ09ORklHX1NNUCkpOw0KPg0KPiAtCS8qIFogaW5kaWNhdGVz
IHRvIHVzZXJzcGFjZSBpZiBvcGVyYXRpb24gc3VjY2VkZWQgKi8NCj4gKwkvKiBaIGluZGljYXRl
cyB0byB1c2Vyc3BhY2UgaWYgb3BlcmF0aW9uIHN1Y2NlZWRlZCAqLw0KPiAgIAlyZWdzLT5zdGF0
dXMzMiAmPSB+U1RBVFVTX1pfTUFTSzsNCj4NCj4gICAJcmV0ID0gYWNjZXNzX29rKHVhZGRyLCBz
aXplb2YoKnVhZGRyKSk7DQo+IEBAIC0xMDcsNyArMTA3LDcgQEAgU1lTQ0FMTF9ERUZJTkUzKGFy
Y191c3JfY21weGNoZywgaW50ICosIHVhZGRyLCBpbnQsIGV4cGVjdGVkLCBpbnQsIG5ldykNCj4N
Cj4gICB2b2lkIGFyY2hfY3B1X2lkbGUodm9pZCkNCj4gICB7DQo+IC0JLyogUmUtZW5hYmxlIGlu
dGVycnVwdHMgPD0gZGVmYXVsdCBpcnEgcHJpb3JpdHkgYmVmb3JlIGNvbW1pdGluZyBTTEVFUCAq
Lw0KPiArCS8qIFJlLWVuYWJsZSBpbnRlcnJ1cHRzIDw9IGRlZmF1bHQgaXJxIHByaW9yaXR5IGJl
Zm9yZSBjb21taXR0aW5nIFNMRUVQICovDQo+ICAgCWNvbnN0IHVuc2lnbmVkIGludCBhcmcgPSAw
eDEwIHwgQVJDVjJfSVJRX0RFRl9QUklPOw0KPg0KPiAgIAlfX2FzbV9fIF9fdm9sYXRpbGVfXygN
Cj4gQEAgLTEyMCw3ICsxMjAsNyBAQCB2b2lkIGFyY2hfY3B1X2lkbGUodm9pZCkNCj4NCj4gICB2
b2lkIGFyY2hfY3B1X2lkbGUodm9pZCkNCj4gICB7DQo+IC0JLyogc2xlZXAsIGJ1dCBlbmFibGUg
Ym90aCBzZXQgRTEvRTIgKGxldmVscyBvZiBpbnRlcnJ1dHBzKSBiZWZvcmUgY29tbWl0dGluZyAq
Lw0KPiArCS8qIHNsZWVwLCBidXQgZW5hYmxlIGJvdGggc2V0IEUxL0UyIChsZXZlbHMgb2YgaW50
ZXJydXB0cykgYmVmb3JlIGNvbW1pdHRpbmcgKi8NCj4gICAJX19hc21fXyBfX3ZvbGF0aWxlX18o
InNsZWVwIDB4MwlcbiIpOw0KPiAgIH0NCj4NCj4gLS0NCj4gMi4zMS4wDQo+DQoNCg==
