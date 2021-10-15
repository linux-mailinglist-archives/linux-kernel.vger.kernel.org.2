Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFF942EF2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbhJOK4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:56:32 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56622 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhJOK4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:56:30 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B531E45FEA;
        Fri, 15 Oct 2021 10:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1634295264; bh=e7urXS15HQJIxRP8octZYV+zY9ZOqBMXFTyhqUc6RLk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CVLaHd4FXiMGrX0Wb4kSLNKuRcSDyFe6vPXi7eZYSZ1JzJNydvFmi+d9NlUpWTDa/
         nOM1Gn3xxOZ+FrnvgM/SBlgCUYnVQJcmTLd5N5ZvKIr2F3ooi1wW0puYo6set/GUXy
         7iYoTlVNOPnqJB5pz+Ebo2P29rYSlOK12s9n8D8Bn6x0QvLZY6BVdHG6bjnUrlFVCp
         VjwCrv7jn6E0bNjPOljQoUL6tFC9rqD2z/HlqJh4j1De/+1W0aDqo3ZcV+OCvn9klW
         VpgjMhfJ2uQbkGeBrrTmzE+ORj2xdm8lc24GuxiBhG7Z96Mm7iuKnkV1M1F0zZuCDZ
         NXeRLAHrzluPA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 20EDFA00F0;
        Fri, 15 Oct 2021 10:54:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id AB40780037;
        Fri, 15 Oct 2021 10:54:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="XnlmORzZ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqYw7eKDAhHjuz+5x9C4kaJu1RyN16vlSeeZrgN1lIPwQjnHdpx+FIKmaLj7plUy5k4Dec2nX03DEAZaJ1YUS++c9iPnAFnVtC/XuA9pXknfKuNMpQUj0jAEHJinzQP3xmBjIjZf9PS+UXFdhaD/ElJuNVwUuAr39vUX+T0eBM3KnqYJj9fD86uylWPpi+42IjaITOP9Plm/k0B5k7M//yOvGkQdTb4CjwYro7fm0S/EkawWRZUlfiH9ABsbEOirOF8QaMdC6jk6qtVu+T8JGLNSHvhMD35uCbOSRsyZ3onChCfrlRDUWPNDierNDIqyRm+PyNuy6It7nIMimFnXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7urXS15HQJIxRP8octZYV+zY9ZOqBMXFTyhqUc6RLk=;
 b=kKHL+juM1OTIIFqGfp0O+79FOKMv4Hzjw7rrZ00Ili2LZDxSpj1QXaWDMT+e8toicKle5g594gq6/drFsuodvtGnAg9YaottNZx36O2WAAP+V+DSODt5SsjgPH+ASd/y0kczlNIi0rcwTm2NBASY31Q75iTjhq8Fi+Bte7KId0Rc/iwUy8YUqEnUxWWhisSX1VQugwn3dJRyeKJuXagKDXeXIEXr/HPm18gpUbuGMPcVcofOGCsYKsCMCVFCXRXVGcCukXZanRAHDvCFDAnX0xe+wb2ih9HR2xuTn/SmgVyp+IBFGBU9gBWpIUE7TE7AacCsrp+EuJ16LblEOgl9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7urXS15HQJIxRP8octZYV+zY9ZOqBMXFTyhqUc6RLk=;
 b=XnlmORzZnzMUp/iCVhCAsQheJ5bBnAeBrm7PXJNXG4RDVx2EYyVDPmi6dTIRtX7L4BUkuKPCOvOvS54ArvQcvYnx25bAP52oO6fGc3VA9Z/dm2IY4WHervn8q/Aii5z9rWarVCsOojD+bJS60n+lFvVPtUgRh2wEt2HD0VhNVnE=
Received: from BN9PR12MB5383.namprd12.prod.outlook.com (2603:10b6:408:104::7)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14; Fri, 15 Oct
 2021 10:54:21 +0000
Received: from BN9PR12MB5383.namprd12.prod.outlook.com
 ([fe80::88fd:96ac:c734:b363]) by BN9PR12MB5383.namprd12.prod.outlook.com
 ([fe80::88fd:96ac:c734:b363%3]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 10:54:21 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 2/3] usb: dwc2: drd: fix dwc2_drd_role_sw_set when clock
 could be disabled
Thread-Topic: [PATCH 2/3] usb: dwc2: drd: fix dwc2_drd_role_sw_set when clock
 could be disabled
Thread-Index: AQHXuc7dEoBUFnaIxEm0g/FBJLukdKvT8maA
Date:   Fri, 15 Oct 2021 10:54:21 +0000
Message-ID: <a864af26-c4c1-786a-bf4d-1b8d92d4d035@synopsys.com>
References: <20211005095305.66397-1-amelie.delaunay@foss.st.com>
 <20211005095305.66397-3-amelie.delaunay@foss.st.com>
In-Reply-To: <20211005095305.66397-3-amelie.delaunay@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: foss.st.com; dkim=none (message not signed)
 header.d=none;foss.st.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d55b407-559f-41aa-2788-08d98fca2515
x-ms-traffictypediagnostic: BN9PR12MB5226:
x-microsoft-antispam-prvs: <BN9PR12MB5226CAA012DC3D48D6B41B91A7B99@BN9PR12MB5226.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RVIsNLLszJXj3rLOd9HHD4/9NUSugJZsaSUChSfLGTu/oTVUMh5moMEAnWElLOoHU7nBtVzoxM0FF9FDWrUHQb4gsPzR/SSqxH2UybSlCYm0NpZt8gSS0/xBx5yF1L3twzLK0Rr/KlJdf8GmrXXYDoNkQeAIUl+Pap4S5v5yuXVS99MY+u068P8dWQpS++xRe1959mqRtpBihm+JlMAr02o2Gkl9xDkmc23mcgooHqgasM6vjb0CBrgGcbofBRefc5k1sPSlGmgBw9Rouw+/vJlApXlcI4G4Mftbh8mRJyrW/0gJjyvzauqF78ujsxazOpLY95czfOHv4FM3Dcmvnm2Ug+JTACL3Vyxh2PlJFC7rABCU4YzeYq2S0CpyQC5rLTfJ4T+DzT7S7y1/v3F2oEt4L3GxMfFyWb/k11uqsWsXetWJQgv3gv+BuuxjUT4u98Kgh2c3nOhpUInxtregaZbYPBtfkmMsguVNRV1qe4fHXZj6O7ZDzf7OYYPevybQ4g+pnqDfL5crG8uLHewgCB6/fAUyQPG7/1znrwr1s1MIsDMKwzhGb2VGWZTRO1g9I9t0B7g60/ncwJktdjXoB/Dd8w9M09hzrdqSS53hfx4JJdlSasWtqoLBiEJ8n1bVF+0n3lzB7uDvQvB2gobalRb2vzIZxSQhzHB7wos4UoikqEk+U/hNRiWvMtUi6hNvBny59Kz7VphRqhE3gWFXdsHfkQkbP3n5I9Ly5Ak4IjK0wN+2xnYEfjG73JYzyN6xxNaNIBYZjvictIGUrb4y8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5383.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(36756003)(316002)(66556008)(86362001)(54906003)(38070700005)(110136005)(71200400001)(8676002)(6486002)(66476007)(66446008)(64756008)(2616005)(2906002)(76116006)(26005)(5660300002)(66946007)(91956017)(53546011)(508600001)(6506007)(31696002)(122000001)(4326008)(83380400001)(38100700002)(6512007)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vmszb3JHNWk5Z1R2TkZva1MvbzBKOG14R1M1emhJZkNnN1YvNVplZ3drOWty?=
 =?utf-8?B?OVRWYTFxUitkOXF3SCt2N2NDSHNKZ2lMK0RRWnY1Qmd3R0xVZWNXa3M1RGxz?=
 =?utf-8?B?UUNIUnE0V1Y5MG5VaTlmSlk4dE1tWUZMUk5CL0hqSmVLaVVNSDlSK3BPMERW?=
 =?utf-8?B?SktZMThFbGVLblJoWVJYZXJqaGxpZDZJSm9naXVZaWFOQktGMWxBblI0cW9N?=
 =?utf-8?B?aGVOQk1LNUw1eG03bG02akFBWkRsQ2R1TUdTNVRBckNrZTcybHJaazFmSldY?=
 =?utf-8?B?aWRZYWdubGZpUVN0MElQT29ZZnZxWW1GUmtuakU2YldTZTJlSWRGNUdCOGNu?=
 =?utf-8?B?ZXZVaFQ3cG4wQWwwb0ZmNUx1T3NoaHh4SHRBKys0MGYzN2J4TSsyTHg5Yk0v?=
 =?utf-8?B?L29pTGtkYWhRRjRMZFNpRUt4dGFZWGRhdjZOb05Fb0VSRjhzbU9MTFJlZFJ4?=
 =?utf-8?B?eE5hU1d5K0U4SzJKclRKYVhHaVhrRlpBRFdQbWZYMmZGUzVJRmRPaFhlN2Iz?=
 =?utf-8?B?VnFJMGduaXVnNW9ZUVFxVHpVSGR3VFoxZ3RLLzJzTGJ6UWhuV0lMWkJrbFQ4?=
 =?utf-8?B?RVVZcTV6RkRJUGI0UmZIZUN3SDdpWUtaMVBxSE1BQ0ZUckV0U3FnZyt0ZG9o?=
 =?utf-8?B?ZDVoL05EK1ZuempmNjZ5SmwzVnBGb20vd2h5MHI0Mno5Tm9LZC9nWkcyOWJs?=
 =?utf-8?B?MUxXSkYrWTl3WlRMekI4MzhMbjU1aWtCUFBWelBsdWtIK1VUQlY5S2dsUVN2?=
 =?utf-8?B?RVgreTZhUHBwbDlsYjhwR1FJSTFuVWZ4c2Nmd1NqVjkxdEpweU1vQ2M1ZXpx?=
 =?utf-8?B?Wnl2Wkd5QVZtTGtCRE5WUG03bEhiWU1LR3ZhZHR3d2pxRzFwK0ZSd3I0aEdi?=
 =?utf-8?B?Q25UYmpQajJodndCcTBCTFN5N3BUY3FRZW9nOC90bVBydWg4aVkxejQzdjBW?=
 =?utf-8?B?RzM1NUhVUzlBaXl0NnZrUytrNHI0bmF2N0ZXRmZFWTJiZVB0SFFnUk9iOGhr?=
 =?utf-8?B?QWd4SS9RQ1FJcTc0TUoyMjMvVytCeisvTVFScU5md2VhUE5PNGcxRThHekZr?=
 =?utf-8?B?TXMybzhTbTZJWCtzRnRBL2tlaWNkNVlFS2pNLzhOQ09UQlNkbTdEc1kxV0s5?=
 =?utf-8?B?Uy9iOUF1VVBvOUlKK3FUTmRudGFodEVRSytvZG9rSEJYd210b3ZlMHNXVEpV?=
 =?utf-8?B?ck9ac1IwQzdGSnF5QjlzQ2d2ODdOV0FDbHhRUUFacXdPbUg2KzBOTUNadEJm?=
 =?utf-8?B?UjBmTW5RV2JUUUwrNjA0ZTFObjBwK29FNVhYRFVIYlhhOEV3bXppcDhucHNH?=
 =?utf-8?B?R2Q0RFhIL2h2U2Y0WVN0UzV5T2R6QkN3MlFYSFRhVUJuelZoWVg4R0IvalBl?=
 =?utf-8?B?Wlo4SHR3RjNQY21nb3ZFamtsVVduMHozL0VVSytiSTJTOTRWdnJYbWZORFFi?=
 =?utf-8?B?cWcrKzVyckE5VjBvRkFmVUFqYlRubnRhRVdRYnhEemtROTYvWXl0Ym5NcDRu?=
 =?utf-8?B?OFZuTXdaZHRyS2tCaVM0NVBpRkRIUXFOckg1QkJqaVpPNGRac1o3R0oyVUZX?=
 =?utf-8?B?T0p4SGJzYTZURFYxVGw0VFNwQUtVZk5EM3BWOVlWVXBhY3NnM1hiUHZ5b0RC?=
 =?utf-8?B?WjkvRWFGTDU0aEY1UXdaaGt5amRlYnVWcVJncEhiRFpDODd1dnJybXZicHRz?=
 =?utf-8?B?UytabDdMMzdkZXNGZDFRWkdxWHZyamZ3cHNtdUFiT2RDc1N5SG1OcllyUEcx?=
 =?utf-8?Q?BJHD3wYvNsu5RW1yTY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4BB6B95E6A2E04CACE4099C460AD7F7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5383.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d55b407-559f-41aa-2788-08d98fca2515
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 10:54:21.7108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/xNqMaZkVWaePA5oGKj+QSiTjke5M0OfwU49dkZ2LCCDmOhjRZIKkCvZ+E8pxgOmfD1XhQviNaioeD7iiUiHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNS8yMDIxIDE6NTMgUE0sIEFtZWxpZSBEZWxhdW5heSB3cm90ZToNCj4gSW4gY2FzZSBv
ZiBVU0JfRFJfTU9ERV9QRVJJUEhFUkFMLCB0aGUgT1RHIGNsb2NrIGlzIGRpc2FibGVkIGF0IHRo
ZSBlbmQgb2YNCj4gdGhlIHByb2JlIChpdCBpcyBub3QgdGhlIGNhc2UgaWYgVVNCX0RSX01PREVf
SE9TVCBvciBVU0JfRFJfTU9ERV9PVEcpLg0KPiBUaGUgY2xvY2sgaXMgdGhlbiBlbmFibGVkIG9u
IHVkY19zdGFydC4NCj4gSWYgZHdjMl9kcmRfcm9sZV9zd19zZXQgaXMgY2FsbGVkIGJlZm9yZSB1
ZGNfc3RhcnQgKGl0IGlzIHRoZSBjYXNlIGlmIHRoZQ0KPiB1c2IgY2FibGUgaXMgcGx1Z2dlZCBh
dCBib290KSwgR09UR0NUTCBhbmQgR1VTQkNGRyByZWdpc3RlcnMgY2Fubm90IGJlDQo+IHJlYWQv
d3JpdHRlbiwgc28gc2Vzc2lvbiBjYW5ub3QgYmUgb3ZlcnJpZGRlbi4NCj4gVG8gYXZvaWQgdGhp
cyBjYXNlLCBjaGVjayB0aGUgbGxfaHdfZW5hYmxlZCB2YWx1ZSBhbmQgZW5hYmxlIHRoZSBjbG9j
ayBpZg0KPiBpdCBpcyBhdmFpbGFibGUsIGFuZCBkaXNhYmxlIGl0IGFmdGVyIHRoZSBvdmVycmlk
ZS4NCj4gDQo+IEZpeGVzOiAxN2Y5MzQwMjRlODQgKCJ1c2I6IGR3YzI6IG92ZXJyaWRlIFBIWSBp
bnB1dCBzaWduYWxzIHdpdGggdXNiIHJvbGUgc3dpdGNoIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBBbWVsaWUgRGVsYXVuYXkgPGFtZWxpZS5kZWxhdW5heUBmb3NzLnN0LmNvbT4NCg0KQWNr
ZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxNaW5hcy5IYXJ1dHl1bnlhbkBzeW5vcHN5cy5jb20+
DQoNCj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9kcmQuYyB8IDE4ICsrKysrKysrKysrKysr
KysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMi9kcmQuYyBiL2RyaXZlcnMvdXNiL2R3YzIvZHJkLmMNCj4g
aW5kZXggODBlYWU4OGQ3NmRkLi45OTY3MjM2MGYzNGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzIvZHJkLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9kcmQuYw0KPiBAQCAtNyw2
ICs3LDcgQEANCj4gICAgKiBBdXRob3Iocyk6IEFtZWxpZSBEZWxhdW5heSA8YW1lbGllLmRlbGF1
bmF5QHN0LmNvbT4NCj4gICAgKi8NCj4gICANCj4gKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4g
ICAjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3Jt
X2RldmljZS5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC91c2Ivcm9sZS5oPg0KPiBAQCAtODYsNiAr
ODcsMjAgQEAgc3RhdGljIGludCBkd2MyX2RyZF9yb2xlX3N3X3NldChzdHJ1Y3QgdXNiX3JvbGVf
c3dpdGNoICpzdywgZW51bSB1c2Jfcm9sZSByb2xlKQ0KPiAgIAl9DQo+ICAgI2VuZGlmDQo+ICAg
DQo+ICsJLyoNCj4gKwkgKiBJbiBjYXNlIG9mIFVTQl9EUl9NT0RFX1BFUklQSEVSQUwsIGNsb2Nr
IGlzIGRpc2FibGVkIGF0IHRoZSBlbmQgb2YNCj4gKwkgKiB0aGUgcHJvYmUgYW5kIGVuYWJsZWQg
b24gdWRjX3N0YXJ0Lg0KPiArCSAqIElmIHJvbGUtc3dpdGNoIHNldCBpcyBjYWxsZWQgYmVmb3Jl
IHRoZSB1ZGNfc3RhcnQsIHdlIG5lZWQgdG8gZW5hYmxlDQo+ICsJICogdGhlIGNsb2NrIHRvIHJl
YWQvd3JpdGUgR09UR0NUTCBhbmQgR1VTQkNGRyByZWdpc3RlcnMgdG8gb3ZlcnJpZGUNCj4gKwkg
KiBtb2RlIGFuZCBzZXNzaW9ucy4gSXQgaXMgdGhlIGNhc2UgaWYgY2FibGUgaXMgcGx1Z2dlZCBh
dCBib290Lg0KPiArCSAqLw0KPiArCWlmICghaHNvdGctPmxsX2h3X2VuYWJsZWQgJiYgaHNvdGct
PmNsaykgew0KPiArCQlpbnQgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGhzb3RnLT5jbGspOw0K
PiArDQo+ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gKw0KPiAgIAlz
cGluX2xvY2tfaXJxc2F2ZSgmaHNvdGctPmxvY2ssIGZsYWdzKTsNCj4gICANCj4gICAJaWYgKHJv
bGUgPT0gVVNCX1JPTEVfSE9TVCkgew0KPiBAQCAtMTEwLDYgKzEyNSw5IEBAIHN0YXRpYyBpbnQg
ZHdjMl9kcmRfcm9sZV9zd19zZXQoc3RydWN0IHVzYl9yb2xlX3N3aXRjaCAqc3csIGVudW0gdXNi
X3JvbGUgcm9sZSkNCj4gICAJCS8qIFRoaXMgd2lsbCByYWlzZSBhIENvbm5lY3RvciBJRCBTdGF0
dXMgQ2hhbmdlIEludGVycnVwdCAqLw0KPiAgIAkJZHdjMl9mb3JjZV9tb2RlKGhzb3RnLCByb2xl
ID09IFVTQl9ST0xFX0hPU1QpOw0KPiAgIA0KPiArCWlmICghaHNvdGctPmxsX2h3X2VuYWJsZWQg
JiYgaHNvdGctPmNsaykNCj4gKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGhzb3RnLT5jbGspOw0K
PiArDQo+ICAgCWRldl9kYmcoaHNvdGctPmRldiwgIiVzLXNlc3Npb24gdmFsaWRcbiIsDQo+ICAg
CQlyb2xlID09IFVTQl9ST0xFX05PTkUgPyAiTm8iIDoNCj4gICAJCXJvbGUgPT0gVVNCX1JPTEVf
SE9TVCA/ICJBIiA6ICJCIik7DQo+IA0KDQo=
