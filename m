Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A3B331D4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 04:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhCIDFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 22:05:24 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:36198 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229694AbhCIDFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 22:05:20 -0500
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5AAE240391;
        Tue,  9 Mar 2021 03:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1615259119; bh=b7Cc6rPPfBJoWKTLbfEFer6NKO6WbDDsAm6Jr5JmVbo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cEEtvfFAuutwXBEdl20bL5NBKKsYZbPqSlEkTLze0pmor8R/8XmPAylpU97Nl/vT6
         cqfkJIROyV+4rAo1+jnGJemcC0mkRa6S/TBv4jUVRGWumSeCLplj0q79O8h2ERXejz
         npdRHcHp4e2oDOQOizCAuLFV4OJEu+xE3LM5JWmpH/Y4OPVhDCvPUK2uJeb825cXwy
         5GuY28qei8hL/Djeinq6RAfn3yDU+3XmjsMA0H0MrGomCDtSAziNaq7++8fcrT4YrI
         lmAoSmL9tRNMUjRbxP95KKYzliwmdk7ZiCLiOw2neu3V80bUvEOBQz9Y3S4nZQPdeo
         fJQeu+/7EbMVw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id AD99DA007C;
        Tue,  9 Mar 2021 03:05:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7A474800C2;
        Tue,  9 Mar 2021 03:05:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gi4ckrAJ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZVLsQJnRM+McNHnAYTHvJO9s6Fj7MoGF9zge2liz9dvOjFAm7FfC1DAnhuq9yQRNjYq00vOs3VX4ddW3B7eFVDNH0a3VMcjLCufY17UqUA5AvTP/6NtzlC3NvZqBERxNCnaTHv7e8Bw6mhMeRnAyUS7t25QOl+kMmAbci6Jst7VJOMl4ZLsL8NeLoq9i4rOQZY9aGMRlkVaC9XXh5oJDJm6iW0OxSvHT17BhEHAigYvHsM0478S9oasfvUpOzTM2pYSXv8dKlf+OrCb8k1EEjfB1Qi1fa3d2I0S8knqpZcStVVGqnWQDTPWXXD4TkMYdLmSNS+vV6kiyoxFmyxKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7Cc6rPPfBJoWKTLbfEFer6NKO6WbDDsAm6Jr5JmVbo=;
 b=SqN7zUxKmcF7Gs805Wsv7dT8boe8hAbxwAh64GX5YOL32AGrmvITQUoZKE5ZKUjf0QhsTGKEO10hP+RUIyjRrQUMuW9S8EpxUKUXaXKh81BYkbK+OXES8ciLsBHF9s8ylsK9pIXPhSLj6OU1IZipu8OaPvSaqZi9XwcyonV0wy6rRHjftLtZtbX0jHc6H3b9dKlfFbsbna6GKpFrCesAyRfqBDUAgGleiln+8AaHtoKdX4+NIEOW45Obny3KCYRGW5GCurKO5AGw9mBXihFmI4yp1ZWHeUfoJ3fOg7KUZqdJqa6HoQUS9CCWkXt6Z6Gu8BwSFxJ/4wvCtQ2pKHnf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7Cc6rPPfBJoWKTLbfEFer6NKO6WbDDsAm6Jr5JmVbo=;
 b=gi4ckrAJ/Nnsi6AGhqDyVWWvXkKG/gTMEUzrTa03X6YNmRcvfCRxXcFMYGDkfCdNYwNfPPIfOIukIxxpHzFrwwBz3JdDFK72AhGcn9lksMP0LtTeXh0lgZi3TU3dq+CCauaexli4zgGMyaxxDFfQDNcv6v2VRbBcv3aBFWiCreU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4019.namprd12.prod.outlook.com (2603:10b6:a03:1a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 03:05:13 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6%6]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 03:05:13 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        John Stultz <john.stultz@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 1/2] usb: dwc3: Trigger a GCTL soft reset when
 switching modes in DRD
Thread-Topic: [PATCH v3 1/2] usb: dwc3: Trigger a GCTL soft reset when
 switching modes in DRD
Thread-Index: AQHW5WDHaQXdezZAr06Yos1UmLp1A6odqBQAgABzRQCAAFsegIBYjhOAgAD1JgCAAVXNgIACB8sA
Date:   Tue, 9 Mar 2021 03:05:13 +0000
Message-ID: <3db531c4-7058-68ec-8d4b-ff122c307697@synopsys.com>
References: <20210108015115.27920-1-john.stultz@linaro.org>
 <87bldzwr6x.fsf@kernel.org>
 <CALAqxLWdWj9=a-7NGDzJyrfyRABwKnJM7EQo3Zm+k9JqAhPz+g@mail.gmail.com>
 <d95d0971-624e-a0e6-ac72-6ee3b1fb1106@synopsys.com>
 <06a44245-4f2f-69ba-fe46-b88a19f585c2@codeaurora.org>
 <a33f7c33-f95d-60c3-70f2-4b37fcf8bac5@synopsys.com>
 <fa5cc67e-3873-e6d9-8727-d160740b027e@codeaurora.org>
In-Reply-To: <fa5cc67e-3873-e6d9-8727-d160740b027e@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d83275e3-1827-4a1c-1447-08d8e2a82878
x-ms-traffictypediagnostic: BY5PR12MB4019:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4019E1BDE7652A718B353AD3AA929@BY5PR12MB4019.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oUg1brzLnDXdyFRP+uMcrBjpNT1UgEgxC3b0rIq9W7rX8/DlIxXciTYEhUslx0KgxZ61OvJHCfvbL1N8TWnstAublBvgP0Yq2fBDzAAvlLoYz1jeI6fmDs4Y4dOYP27lSSUwclaRLgmYu2MJa3JnPHjpNSXynqeyhC5oVkL+Hg4MqR3TtT263Y0tFY6Zi4D2WzxXIdPvc5TLZdtZhk5Kjc/I9KXjJ15PLTrRHho+9V0eL4EGvq2vchQxlenUhCAATOLU03pdAReF0/51Dbn5TirI+5MNjT9/hP/JcJzgxPhWPtLPZMYhusCF4QB0KQpmf27mGov63x3fj7sOHbAFyndk8zwRFszTocligdJLPnYgEL79AcxImMbHkDPulwuS6ZWQFXKrz+849Q0zhYYHIe4xGoGBGcCSF1dKoNdtrnXUX2URDG9EOAJrCEGF2ZnLN7vgskpJJt9wQxETGFw/BTJFWkNNEZvI3FU09Je3b3a6n/PUFW9wlYpktCgceSTPPOstlSrclBT/NYcT4rTzsblC5eYHNSBCbdGSplOEMz9T0hdLwEkj5vQhGwNVfRXzqlFkl3M5YWgQRfNBoJ7fz4ATyDDRzPpiTQ1dWRsxllUH7a+8IMGLANQzpUz9yG5BXWQWffxWdYCAtwN/IWk12LKzeRF3WJ1Moomp365VKCDL+GE3Rzr9+zbeIC+jcgUR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(66556008)(66446008)(2616005)(31686004)(966005)(26005)(83380400001)(4326008)(186003)(478600001)(76116006)(64756008)(53546011)(6506007)(66946007)(316002)(110136005)(7416002)(66476007)(8676002)(54906003)(36756003)(2906002)(6486002)(86362001)(5660300002)(8936002)(84040400003)(31696002)(6512007)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bDBuKzFWRzVDbyt1UG1CdmxkRFFYbVJVaUVYVTVBNGlkZzZ0Z0VPQzdOYmFN?=
 =?utf-8?B?UGpuRHRqUmdyYll2NmhhcTN6QTNFTkQ0ZkZmWnJPdEtZVUZBeFFMMThaTEJu?=
 =?utf-8?B?ck1vVGVKcjZJK296WmVadmxaL1NWblJ5NmFaMU5aeWJqNEQxYlRrcU03RHFz?=
 =?utf-8?B?VUROckxlam9qQWpjSjY2NGZSbnFEZVpkSjRRMzF3Y0xhaVUyWFdrV29pVzdP?=
 =?utf-8?B?VUg1a2U0MlNYY1ZDNWhUODR0L2E4bUZmOTgwTGRZNFVYaFllVTNsRUVJN1Nh?=
 =?utf-8?B?aWNhWFNPV0JJbEM0NllkU2NST3ptVmFPeG16bHUvYlNyY2VkZTdQeHlXQU95?=
 =?utf-8?B?bHRpTUtYV2N5OHFSdGN5cEpaSTI4a01QbGFXNmE5dUh2NHd1b3J4QzhBOW9t?=
 =?utf-8?B?bUdob0RMZE91NHQ3NDNDeGVKQ0NtT3VGTVRyQ0NCYUFwTXNSNkhmNmJuajg0?=
 =?utf-8?B?eHc0TzNBd3QyWTMrUTB3VGN4ZndCQlJQcUlYRUppOVVrejd5dUNJQ2k0SkhZ?=
 =?utf-8?B?azZlRyt1ZGxzQXhXOE01TVVuRWxKMENLaXNjVVBQS2VzU01RMUFKc1IrT0I2?=
 =?utf-8?B?VmFteU1rTUh1a3p2dHh3SG5jYUtrbmRPMldYWEJZSXZxWFJ0MS8yUm5HVlR0?=
 =?utf-8?B?MCs2VUplWEo4YkR3aFNFRXNwNkI0NFVkTXU4d2x3TmJjcUNjQnhwS1hUNkJ0?=
 =?utf-8?B?MEVSci9qSnN6UnlBUTBBVnNPaCtIVFlaVGFUVUt2VG81amo3ejJaT09mY3RS?=
 =?utf-8?B?aW10aWtOaWtVa1JrYnU2aGZUV1h2UFd0Sm9BZ2gzQjMxTDVPSFh3Nm1KVFNn?=
 =?utf-8?B?cXhsKzlRbGx5ZlZpaE5rV1dFUjRCM0JsMnVkSDd2TSt1WDdKYkxXWmx2U2VT?=
 =?utf-8?B?YmVlTDJpTGZpeWpZSE4rT1hOUnZGMFp6Um83eCtOSkNmaEswTDAyTGhwY1lV?=
 =?utf-8?B?RXgzVVdUUmF4TUlZRjdwWngxcWs5WkQyTk5jNVdGM29wdjVkMjRLQjcvcmxy?=
 =?utf-8?B?MVpNUlJPYWxsd2p5VjlZbEN2eHVEUnRMT2NjZko5SFRWbDlOSVpubWozamNh?=
 =?utf-8?B?Qm5DL2hSTzNOcWhUZXVwVEZRQ0t3NDdHMjNyWWQyeUlsZXRlenhtUFpFajJu?=
 =?utf-8?B?Z0lRMklBbFo1L0t3T0lVc2xHWjl5RktUUmxvakkxVml6a1lNZU82cm5OS2U1?=
 =?utf-8?B?elQrbkEva3hya0E4SHRkNWVEYlNMSmhCeE5WZE9US2Q1UGx1YUxQSC9ZUVVr?=
 =?utf-8?B?WWUrZGdEVjJ6M2lBMlROQXlRcUoxUjhXVHN2WVRLd0F1MjduUEhoS00wQWtC?=
 =?utf-8?B?aVZOOUQ4eVYxOVROOTJ3N2JXajNpQkpWbzBGbWxSTU1uRGJtY0p4OUVlQ2dl?=
 =?utf-8?B?b0V0MVRUNDI5ZDJQdkxUK1dzSWEzKytwaytIbTFRYjR0N2JUdkMwMWdJckh6?=
 =?utf-8?B?NW9WUnBvejRJWmVYV1M0RzBOMDUvNG5qOGVxa3owbnQyWnJXQnJmWGRuMVJN?=
 =?utf-8?B?aEFWd0RTRDh4TzNSMzBIakVFYXpCdmgrckhaRkNkZnZmaXQ3Y2dJajdpY0tj?=
 =?utf-8?B?R1lXSG5PM2lEMGZWTndUMXRZMWhvNldYK1ZCbE03MUZPY2laWTRzak91bVd2?=
 =?utf-8?B?UG9wSGNJc0hzTkxVWE40K3hIbVhFZWZnWTVJOHJaR1o3Q1ZudUp2OTJkckdv?=
 =?utf-8?B?dnBZeGxZTm9ocmFKemhtRDA2Q05sa0FaWDNiOVVPWm1QQlhZSVFVdUMyOXFk?=
 =?utf-8?Q?G5Udy+bef5I5YpB+mg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A677F7D2701DF741B32697C1524E97C9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83275e3-1827-4a1c-1447-08d8e2a82878
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 03:05:13.3546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jowUh0AwMNUEZ9L0wqUr0teXyi0igz0M9Ipz+8SEKym+tO0+dQoE3bMd1HAojfESX+R2xV4CjSkX/HmYakAdDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4019
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPg0KPiBPbiAzLzYvMjAyMSAzOjQxIFBNLCBUaGluaCBOZ3V5
ZW4gd3JvdGU6DQo+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4gT24gMS84LzIwMjEgNDo0NCBQ
TSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+PiBIaSwNCj4+Pj4NCj4+Pj4gSm9obiBTdHVsdHog
d3JvdGU6DQo+Pj4+PiBPbiBGcmksIEphbiA4LCAyMDIxIGF0IDQ6MjYgQU0gRmVsaXBlIEJhbGJp
IDxiYWxiaUBrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4+PiBIaSwNCj4+Pj4+Pg0KPj4+Pj4+IEpv
aG4gU3R1bHR6IDxqb2huLnN0dWx0ekBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+Pj4+Pj4+IEZyb206
IFl1IENoZW4gPGNoZW55dTU2QGh1YXdlaS5jb20+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IEp1c3QgcmVz
ZW5kaW5nIHRoaXMsIGFzIGRpc2N1c3Npb24gZGllZCBvdXQgYSBiaXQgYW5kIEknbSBub3QNCj4+
Pj4+Pj4gc3VyZSBob3cgdG8gbWFrZSBmdXJ0aGVyIHByb2dyZXNzLiBTZWUgaGVyZSBmb3IgZGVi
dWcgZGF0YSB0aGF0DQo+Pj4+Pj4+IHdhcyByZXF1ZXN0ZWQgbGFzdCB0aW1lIGFyb3VuZDoNCj4+
Pj4+Pj4gICBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC9DQUxBcXhMWGRuYVVmSkt4MGFOOXhXd3RmV1ZqTVdpZ1BweTJhcXNOajU2eXZuYlU4
MGdAbWFpbC5nbWFpbC5jb20vX187ISFBNEYyUjlHX3BnIUxOenVwckFlZy1PODBTZ29sWWtJa1c0
LW5lLU0teUxXQ0RVWTlNeWdBSXJRQzM5OFo2Z1JKOXduc25scWQzdyQgDQo+Pj4+Pj4+DQo+Pj4+
Pj4+IFdpdGggdGhlIGN1cnJlbnQgZHdjMyBjb2RlIG9uIHRoZSBIaUtleTk2MCB3ZSBvZnRlbiBz
ZWUgdGhlDQo+Pj4+Pj4+IENPUkVJRExFIGZsYWcgZ2V0IHN0dWNrIG9mZiBpbiBfX2R3YzNfZ2Fk
Z2V0X3N0YXJ0KCksIHdoaWNoDQo+Pj4+Pj4+IHNlZW1zIHRvIHByZXZlbnQgdGhlIHJlc2V0IGly
cSBhbmQgY2F1c2VzIHRoZSBVU0IgZ2FkZ2V0IHRvDQo+Pj4+Pj4+IGZhaWwgdG8gaW5pdGlhbGl6
ZS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gV2UgaGFkIHNlZW4gb2NjYXNpb25hbCBpbml0aWFsaXphdGlv
biBmYWlsdXJlcyB3aXRoIG9sZGVyDQo+Pj4+Pj4+IGtlcm5lbHMgYnV0IHdpdGggcmVjZW50IDUu
eCBlcmEga2VybmVscyBpdCBzZWVtZWQgdG8gYmUgYmVjb21pbmcNCj4+Pj4+Pj4gbXVjaCBtb3Jl
IGNvbW1vbiwgc28gSSBkdWcgYmFjayB0aHJvdWdoIHNvbWUgb2xkZXIgdHJlZXMgYW5kDQo+Pj4+
Pj4+IHJlYWxpemVkIEkgZHJvcHBlZCB0aGlzIHF1aXJrIGZyb20gWXUgQ2hlbiBkdXJpbmcgdXBz
dHJlYW1pbmcNCj4+Pj4+Pj4gYXMgSSBjb3VsZG4ndCBwcm92aWRlIGEgcHJvcGVyIHJhdGlvbmFs
IGZvciBpdCBhbmQgaXQgZGlkbid0DQo+Pj4+Pj4+IHNlZW0gdG8gYmUgbmVjZXNzYXJ5LiBJIG5v
dyByZWFsaXplIEkgd2FzIHdyb25nLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBBZnRlciByZXN1Ym1pdHRp
bmcgdGhlIHF1aXJrLCBUaGluaCBOZ3V5ZW4gcG9pbnRlZCBvdXQgdGhhdCBpdA0KPj4+Pj4+PiBz
aG91bGRuJ3QgYmUgYSBxdWlyayBhdCBhbGwgYW5kIGl0IGlzIGFjdHVhbGx5IG1lbnRpb25lZCBp
biB0aGUNCj4+Pj4+Pj4gcHJvZ3JhbW1pbmcgZ3VpZGUgdGhhdCBpdCBzaG91bGQgYmUgZG9uZSB3
aGVuIHN3aXRjaGluZyBtb2Rlcw0KPj4+Pj4+PiBpbiBEUkQuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFNv
LCB0byBhdm9pZCB0aGVzZSAhQ09SRUlETEUgbG9ja3VwcyBzZWVuIG9uIEhpS2V5OTYwLCB0aGlz
DQo+Pj4+Pj4+IHBhdGNoIGlzc3VlcyBHQ1RMIHNvZnQgcmVzZXQgd2hlbiBzd2l0Y2hpbmcgbW9k
ZXMgaWYgdGhlDQo+Pj4+Pj4+IGNvbnRyb2xsZXIgaXMgaW4gRFJEIG1vZGUuDQo+Pj4+Pj4+DQo+
Pj4+Pj4+IENjOiBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5vcmc+DQo+Pj4+Pj4+IENjOiBU
ZWphcyBKb2dsZWthciA8dGVqYXMuam9nbGVrYXJAc3lub3BzeXMuY29tPg0KPj4+Pj4+PiBDYzog
WWFuZyBGZWkgPGZlaS55YW5nQGludGVsLmNvbT4NCj4+Pj4+Pj4gQ2M6IFlvbmdRaW4gTGl1IDx5
b25ncWluLmxpdUBsaW5hcm8ub3JnPg0KPj4+Pj4+PiBDYzogQW5kcnplaiBQaWV0cmFzaWV3aWN6
IDxhbmRyemVqLnBAY29sbGFib3JhLmNvbT4NCj4+Pj4+Pj4gQ2M6IFRoaW5oIE5ndXllbiA8dGhp
bmhuQHN5bm9wc3lzLmNvbT4NCj4+Pj4+Pj4gQ2M6IEp1biBMaSA8bGlqdW4ua2VybmVsQGdtYWls
LmNvbT4NCj4+Pj4+Pj4gQ2M6IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYitodWF3ZWlA
a2VybmVsLm9yZz4NCj4+Pj4+Pj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+DQo+Pj4+Pj4+IENjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnDQo+
Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFl1IENoZW4gPGNoZW55dTU2QGh1YXdlaS5jb20+DQo+Pj4+
Pj4+IFNpZ25lZC1vZmYtYnk6IEpvaG4gU3R1bHR6IDxqb2huLnN0dWx0ekBsaW5hcm8ub3JnPg0K
Pj4+Pj4+PiAtLS0NCj4+Pj4+Pj4gdjI6DQo+Pj4+Pj4+ICogUmV3b3JrIHRvIGFsd2F5cyBjYWxs
IHRoZSBHQ1RMIHNvZnQgcmVzZXQgaW4gRFJEIG1vZGUsDQo+Pj4+Pj4+ICAgcmF0aGVyIHRoZW4g
dXNpbmcgYSBxdWlyayBhcyBzdWdnZXN0ZWQgYnkgVGhpbmggTmd1eWVuDQo+Pj4+Pj4+DQo+Pj4+
Pj4+IHYzOg0KPj4+Pj4+PiAqIE1vdmUgR0NUTCBzb2Z0IHJlc2V0IHVuZGVyIHRoZSBzcGlubG9j
ayBhcyBzdWdnZXN0ZWQgYnkNCj4+Pj4+Pj4gICBUaGluaCBOZ3V5ZW4NCj4+Pj4+PiBCZWNhdXNl
IHRoaXMgaXMgc3VjaCBhbiBpbnZhc2l2ZSBjaGFuZ2UsIEkgd291bGQgcHJlZmVyIHRoYXQgd2Ug
Z2V0DQo+Pj4+Pj4gVGVzdGVkLUJ5IHRhZ3MgZnJvbSBhIGdvb2QgZnJhY3Rpb24gb2YgdGhlIHVz
ZXJzIGJlZm9yZSBhcHBseWluZyB0aGVzZQ0KPj4+Pj4+IHR3byBjaGFuZ2VzLg0KPj4+Pj4gSSdt
IGhhcHB5IHRvIHJlYWNoIG91dCB0byBmb2xrcyB0byB0cnkgdG8gZ2V0IHRoYXQuIFRob3VnaCBJ
J20NCj4+Pj4+IHdvbmRlcmluZyBpZiBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gcHV0IGl0IGJlaGlu
ZCBhIGR0cyBxdWlyayBmbGFnLCBhcw0KPj4+Pj4gb3JpZ2luYWxseSBwcm9wb3NlZD8NCj4+Pj4+
ICAgIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzIwMjAxMDIxMTgxODAzLjc5NjUwLTEtam9obi5zdHVsdHpAbGluYXJvLm9yZy9fXzshIUE0
RjJSOUdfcGchTE56dXByQWVnLU84MFNnb2xZa0lrVzQtbmUtTS15TFdDRFVZOU15Z0FJclFDMzk4
WjZnUko5d25SV0lUWmZjJCANCj4+Pj4+DQo+Pj4+PiBUaGF0IHdheSBmb2xrcyBjYW4gZW5hYmxl
IGl0IGZvciBkZXZpY2VzIGFzIHRoZXkgbmVlZD8NCj4+Pj4+DQo+Pj4+PiBBZ2FpbiwgSSdtIG5v
dCB0cnlpbmcgdG8gZm9yY2UgdGhpcyBpbiBhcy1pcywganVzdCBtb3N0bHkgc2VuZGluZyBpdA0K
Pj4+Pj4gb3V0IGFnYWluIGZvciBkaXNjdXNzaW9uIHRvIHVuZGVyc3RhbmQgd2hhdCBvdGhlciBh
cHByb2FjaCBtaWdodCB3b3JrLg0KPj4+Pj4NCj4+Pj4+IHRoYW5rcw0KPj4+Pj4gLWpvaG4NCj4+
Pj4gQSBxdWlyayB3b3VsZCBpbXBseSBzb21ldGhpbmcgaXMgYnJva2VuL2RpdmVyZ2VkIGZyb20g
dGhlIGRlc2lnbiByaWdodD8NCj4+Pj4gQnV0IGl0J3Mgbm90IHRoZSBjYXNlIGhlcmUsIGFuZCBh
dCBsZWFzdCB0aGlzIGlzIG5lZWRlZCBmb3IgSGlLZXk5NjAuDQo+Pj4+IEFsc28sIEkgdGhpbmsg
Um9iIHdpbGwgYmUgb2sgd2l0aCBub3QgYWRkaW5nIDEgbW9yZSBxdWlyayB0byB0aGUgZHdjMw0K
Pj4+PiBkZXZpY2V0cmVlLiA6KQ0KPj4+Pg0KPj4+PiBCUiwNCj4+Pj4gVGhpbmgNCj4+Pj4NCj4+
PiBIaSBBbGwsDQo+Pj4NCj4+PiBTb3JyeSBmb3IganVtcGluZyBpbiwgYnV0IEkgY2hlY2tlZCB0
aGUgU05QUyB2MS45MGEgZGF0YWJvb2ssIGFuZCB0aGF0DQo+Pj4gc2VlbWVkIHRvIHJlbW92ZSB0
aGUgcmVxdWlyZW1lbnQgZm9yIHRoZSBHQ1RMLnNvZnRyZXNldCBiZWZvcmUgd3JpdGluZw0KPj4+
IHRvIFBSVENBUERJUi4gIFNob3VsZCB3ZSBjb25zaWRlciBhZGRpbmcgYSBjb250cm9sbGVyIHZl
cnNpb24vSVAgY2hlY2s/DQo+Pj4NCj4+IEhpIFdlc2xleSwNCj4+DQo+PiBGcm9tIHdoYXQgSSBz
ZWUgaW4gdGhlIHYxLjkwYSBkYXRhYm9vayBhbmQgb3RoZXJzLCB0aGUgZmxvdyByZW1haW5zIHRo
ZQ0KPj4gc2FtZS4gSSBuZWVkIHRvIGNoZWNrIGludGVybmFsbHksIGJ1dCBJJ20gbm90IGF3YXJl
IG9mIHRoZSBjaGFuZ2UuDQo+Pg0KPiBIaSBUaGluaCwNCj4NCj4gSG1tbSwgY2FuIHlvdSBoZWxw
IGNoZWNrIHRoZSByZWdpc3RlciBkZXNjcmlwdGlvbiBmb3IgdGhlIFBSVENBUERJUiBvbg0KPiB5
b3VyIHYxLjkwYSBkYXRhYm9vaz8gIChUYWJsZSAxLTE5IEZpZWxkcyBmb3IgUmVnaXN0ZXI6IEdD
VEwgKENvbnRpbnVlZCkNCj4gUGc3MykgIFdoZW4gd2UgY29tcGFyZWQgdGhlIHNlcXVlbmNlIGlu
IHRoZSBkZXNjcmlwdGlvbiB0aGVyZSB0byB0aGUNCj4gcHJldmlvdXMgdmVyc2lvbnMgaXQgcmVt
b3ZlZCB0aGUgR0NUTC5zb2Z0cmVzZXQuICBJZiBpdCBzdGlsbCBzaG93cyB1cA0KPiBvbiB5b3Vy
cywgdGhlbiBtYXliZSBteSB2MS45MGEgaXNuJ3QgdGhlIGZpbmFsIHZlcnNpb24/DQo+DQo+IFRo
YW5rcw0KPiBXZXNsZXkgQ2hlbmcNCj4NCg0KSGkgV2VzbGV5LA0KDQpBY3R1YWxseSB5b3VyIElQ
IHZlcnNpb24gdHlwZSBtYXkgdXNlIHRoZSBuZXdlciBmbG93LiBDYW4geW91IHByaW50IHlvdXIN
CkRXQzNfVkVSX1RZUEU/IEkgc3RpbGwgbmVlZCB0byB2ZXJpZnkgaW50ZXJuYWxseSB0byBrbm93
IHdoaWNoIHZlcnNpb25zDQpuZWVkIHRoZSB1cGRhdGUgaWYgYW55Lg0KDQpUaGFua3MsDQpUaGlu
aA0K
