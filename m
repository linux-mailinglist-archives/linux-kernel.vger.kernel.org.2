Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1344F42BB07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbhJMJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:03:58 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:9955
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229987AbhJMJD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCmRz6sQyqdJLwBkaVXI5y5SLdz1Nl/M7cmj9NRM1D0=;
 b=dzmUp5YkEEfiIl1NLhorG1Oiw+HNsyu0wtwJv4brMyBwQPIeND43PkrYN4EV6oeH6hr7g4RdqxgLTMWJeauAdE4hQALAg71FKhE10wjJOlAWxky8yfKzkpHEk4blIuJp3Sv96n3Pm+aW6S5i1kdEX3PS1CSOgZKHsJUZsh3fORY=
Received: from AM6P192CA0008.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::21)
 by DB7PR08MB3899.eurprd08.prod.outlook.com (2603:10a6:10:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21; Wed, 13 Oct
 2021 09:01:38 +0000
Received: from AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:83:cafe::cd) by AM6P192CA0008.outlook.office365.com
 (2603:10a6:209:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 09:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT052.mail.protection.outlook.com (10.152.17.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Wed, 13 Oct 2021 09:01:37 +0000
Received: ("Tessian outbound 16951d3c485e:v103"); Wed, 13 Oct 2021 09:01:36 +0000
X-CR-MTA-TID: 64aa7808
Received: from 9335649f1979.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DBF54D27-99BA-4CBD-BB4C-EC108DDB1754.1;
        Wed, 13 Oct 2021 09:01:26 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9335649f1979.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 13 Oct 2021 09:01:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9BZ3vBhRJ0f3tUiSIOEIwtf5Bgzt5/r+JXWg5LscMbXrzd8W0FV0ni1PJZ6UMyb/XyicusDp2ZxwJsb8kdgxlPMOuFlQrkDCfXmIj0dD/rKh8oO1tJit+h8s2UjB1f+Wv9QUdVCEE4zZCapGVnvSxaHq01tl/D5z0MYbGcb/SuqgyH/KGQIbV+tM81AOAC8Vl7mq1G94kJC/8y381+0qtxFWHEHumAgFg9kP60N/J09FH+rLD8wUj8Q9qTIeVBmeCY7p0GSXm61TY46Fw1lLonWMa9GtkmmH98GiN/YcJDwsaAMhMOneeqskXsEulxjBczEZlJ68uMkXZ7mMpZXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCmRz6sQyqdJLwBkaVXI5y5SLdz1Nl/M7cmj9NRM1D0=;
 b=hxvLhUZjk7WQ319gHxZ2wVLUrBqDmEU0Cgt4uEDiy/fT8FI2LODufLlTLyl67ilk0KFCaUTWf3Twyopr9NQI6XzfbRoMw9SFngRnW9qGHFWKZoMJilL+LG1ir9nK216sWzGlSF274kz+ZgxL7onlggPsjPbhjNSxuN0kvxpecM9Cy6vO+Jp9Bt9I16AxJuyoq3q2IGYsJPMETiBydx2NoNE87IY90uPApumkBPQnJ7H/poJkHN5vYfXDXjd37zobWIEir4nmj6gPxH1ILiFTRJgGuVxBwL1JKSWLEeD6QwKh22OZ4Vmhj4mInnbSu2bJ/9hPwydOOvw5VEKUUrB4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCmRz6sQyqdJLwBkaVXI5y5SLdz1Nl/M7cmj9NRM1D0=;
 b=dzmUp5YkEEfiIl1NLhorG1Oiw+HNsyu0wtwJv4brMyBwQPIeND43PkrYN4EV6oeH6hr7g4RdqxgLTMWJeauAdE4hQALAg71FKhE10wjJOlAWxky8yfKzkpHEk4blIuJp3Sv96n3Pm+aW6S5i1kdEX3PS1CSOgZKHsJUZsh3fORY=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB5288.eurprd08.prod.outlook.com (2603:10a6:20b:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21; Wed, 13 Oct
 2021 09:01:24 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::80e1:922c:ad90:583d]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::80e1:922c:ad90:583d%3]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 09:01:24 +0000
From:   Justin He <Justin.He@arm.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     James Morse <James.Morse@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Oliver Upton <oupton@google.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nd <nd@arm.com>
Subject: RE: [PATCH v2 2/2] KVM: arm64: Add memcg accounting to KVM
 allocations
Thread-Topic: [PATCH v2 2/2] KVM: arm64: Add memcg accounting to KVM
 allocations
Thread-Index: AQHXo+SXY1+Y7PRqPEOtXG6vaRVv1auZJ8aAgAI+QxCABoXbAIAu7Zgw
Date:   Wed, 13 Oct 2021 09:01:24 +0000
Message-ID: <AM6PR08MB437604FBA3C47C4D70D2A9CDF7B79@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210907123112.10232-1-justin.he@arm.com>
 <20210907123112.10232-3-justin.he@arm.com>
 <CAOQ_QsjOmHw+545J0T9i-nWV2bVGGEwHq5SPVvBOM-SHMXpP5g@mail.gmail.com>
 <AM6PR08MB4376DB4B908AC37DF24290CFF7D59@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <CAOQ_QshF+N7Q=-cXAoMSW4Gcy7mr_oFVpye7fEBqPeR8+3mK0Q@mail.gmail.com>
In-Reply-To: <CAOQ_QshF+N7Q=-cXAoMSW4Gcy7mr_oFVpye7fEBqPeR8+3mK0Q@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: A3B4FE0C01C5424FB1537B60F5CDDB0A.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b63b1256-bc4c-4580-3717-08d98e281088
x-ms-traffictypediagnostic: AM6PR08MB5288:|DB7PR08MB3899:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3899A5A4C79AA2CC38BF7F63F7B79@DB7PR08MB3899.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:5797;OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: aTbbbOn2+L+i9g9XJhanPlIghu7bpaJLni8td+Pelj9eksOHrhZ1tIjenLE7GpuRSLFuyu5Nu+61tvNviX//X7OtYpJ9CjVOzWfK7w9vuIJihYcNVEx4N9n2+PcsX6zprAB8iZpo206MkpxcTCiKE+OUYRk+piT8gCXYCXTq+Ngx3eLorG/XVssY4KTohMvjzYcPK9IzUWfg6YW0WnZtayo4qVTTLeXiwevExlDPXYHuifCMiu83snnR8VgHNT2URpMAMTBkOoQtBgmvoINnNCpWuV912Qt8p1D1JKEeuMmwUt3PG4iaFl4TVVtQQzkBr9CEArmgVF/dhW6sNlyDmZQ2CVw8ijLOuTdplnQeddmONKEx7e93pq9D1TqewSU7R7vzRe/gCcl/WeEr/fwIAcydQmEITQPR3jySpwx8YObQOGGNBRpyXmO/WRP0B1uSO2fgNEQLoLuFWRMVNLoFKUUtL8s86Ks57Eh+vURoRMzaukOo8y+omfG2dZJfIoqcXQGe1TE1JH41/JspfyQIqcMryOD31OEZU+9k8urvgCffJYpivdWh8KKomAR3Hj0DEbU6N0e5HlwQ0a6AN9wqI3pET77pXgr/WUQbBfGGdrqY0/EyAL+7iWXIy8JpVOHXK9/L1cJ0U7uHSwZV9+WCxp5GtKVP2PlzYIjzh0PcRiDaOj4wnjzsvqTL/Mt9pBuQ5+Fsk5agGWq3Z9Nasswjtg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(71200400001)(186003)(66446008)(508600001)(6916009)(122000001)(64756008)(66556008)(38100700002)(7416002)(33656002)(4326008)(9686003)(5660300002)(52536014)(66946007)(7696005)(8676002)(8936002)(4744005)(66476007)(316002)(76116006)(54906003)(26005)(53546011)(38070700005)(6506007)(15650500001)(55016002)(83380400001)(2906002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5288
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 95314b44-c5f6-4177-7abb-08d98e28088b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o83Rc6WlL/zBz3oJD2MV7xE/KcuiQlCV64u7olxi4DCH9mP+sgg0UhZ9QyBz2F/uFfMGaflci/XDGGexJqCnkBbsdwXTIRuk+82piXxGrKbDZg460R3f85wNLefH7olaOrb5SR7lDLzsSa6ElgAh3YEuO8LvW3wbWWZ6WXGb1ht77o8uH8bCpzoHkqai+rYTDx7uVVLw9i3AXsepXyidLjEUWKzrskY13gVATDYQQxxba09152bFjXSizGm9q7kAxWZcWpHzWlttlUVHTU3v7WUdlQx2WWPZ9j4DgNNENuSqNlS+4oWKBqWB9zg0Z4TzuIQ50lvlXS3jBod7VX5lky81yOVHq3WzlIIfHZjSPo/9eUeC+1b1uGDxL9URSnWJP6yAyJv+C+X0SnOt3FdwGehqWbtRkCrx51zwJBWiTx6WDlDmrl1lTc6P7lO4kU9Pwxs3xusd9pg7bBEH7Nbb7xxaaJVZTwobtG2+IyXMMDSl9DoTlOUpw9pNy7bumTpkOraP0WnUNWr2jNFjGHP8VPXvCMmzaFP+5dQJAMVZB74W6KRSq3MQEMgE2VGqJqMq99CUyT2xvji4QlG0euqPcmXqPXlh1NGcxw65q1zIV2tm0J/fKnFsmUeQSHMofFWx23Yf5RiFw6GdWKOxxpxskfGuZggzXpjc7YpCieSwn1PrRoCMdkSVswgsy0exlWaikuKqgcnePFOwwYAoxMO++w==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(81166007)(508600001)(70206006)(5660300002)(33656002)(9686003)(4326008)(6862004)(186003)(70586007)(47076005)(356005)(7696005)(316002)(6506007)(2906002)(52536014)(54906003)(36860700001)(82310400003)(26005)(55016002)(15650500001)(8936002)(8676002)(336012)(83380400001)(53546011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 09:01:37.6154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b63b1256-bc4c-4580-3717-08d98e281088
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3899
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE9saXZlciBV
cHRvbiA8b3VwdG9uQGdvb2dsZS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDEzLCAy
MDIxIDg6MjEgUE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+IENjOiBN
YXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPjsgSmFtZXMgTW9yc2UgPEphbWVzLk1vcnNlQGFy
bS5jb20+Ow0KPiBBbGV4YW5kcnUgRWxpc2VpIDxBbGV4YW5kcnUuRWxpc2VpQGFybS5jb20+OyBT
dXp1a2kgUG91bG9zZQ0KPiA8U3V6dWtpLlBvdWxvc2VAYXJtLmNvbT47IFhpYW9taW5nIE5pIDxu
aXhpYW9taW5nQGh1YXdlaS5jb20+OyBMb3JlbnpvDQo+IFBpZXJhbGlzaSA8TG9yZW56by5QaWVy
YWxpc2lAYXJtLmNvbT47IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPjsNCj4gQ2F0
YWxpbiBNYXJpbmFzIDxDYXRhbGluLk1hcmluYXNAYXJtLmNvbT47IE5pY2sgRGVzYXVsbmllcnMN
Cj4gPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgTGl1IFNoaXhpbg0KPiA8bGl1c2hpeGluMkBodWF3ZWkuY29tPjsgU2FtaSBUb2x2YW5lbiA8
c2FtaXRvbHZhbmVuQGdvb2dsZS5jb20+OyBXaWxsDQo+IERlYWNvbiA8d2lsbEBrZXJuZWwub3Jn
Pjsga3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdTsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gS1ZNOiBhcm02
NDogQWRkIG1lbWNnIGFjY291bnRpbmcgdG8gS1ZNDQo+IGFsbG9jYXRpb25zDQo+IA0KWy4uLl0N
Cj4gPiBEbyB5b3UgbWVhbiBrdm1faHlwX3phbGxvY19wYWdlKCkgaGVyZT8NCj4gPiBTZWVtcyBr
dm1faHlwX3phbGxvY19wYWdlKCkgaXMgaW4gYm90aCBnbG9iYWwgYW5kIFZNIHNjb3Blcy4NCj4g
DQo+IERvaCEga3ZtX2h5cF96YWxsb2NfcGFnZSgpIGlzIG9ubHkgZm9yIHRoZSBoeXAncyBwYWdl
IHRhYmxlcywgaGVuY2UgSQ0KPiBiZWxpZXZlIHlvdXIgcGF0Y2ggaXMgY29ycmVjdCBhcyBpdCBz
dGFuZHMuIEFzIHN1Y2g6DQo+IA0KPiBSZXZpZXdlZC1ieTogT2xpdmVyIFVwdG9uIDxvdXB0b25A
Z29vZ2xlLmNvbT4NCktpbmRseSBwaW5nIGZvciB0aGUgd2hvbGUgc2VyaWVzLiDwn5iJDQoNCi0t
DQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg0KIA0K
