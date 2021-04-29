Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958E336E661
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhD2H4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:56:21 -0400
Received: from mail-eopbgr150057.outbound.protection.outlook.com ([40.107.15.57]:51685
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231465AbhD2H4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0zYGuWsORuOyUDHwqNarb4MmvAPV4rl076rWiPM96g=;
 b=V4g2bNyy2F7Ui8Bq2JSo0yBDirObe41XKRkzcGpRmPAh0QAE7rJG50HL999jfTb0crIHrHjHgC7Rei/ZbxoAi4sYrWkuLuvmtqNRPEcpSzJy1ndWU/CWcxx77Hi1TNHI+xfIDueYl1EQXz4cs++4Tek3zll3fG7zzZ6j1rsUdQA=
Received: from AM3PR07CA0074.eurprd07.prod.outlook.com (2603:10a6:207:4::32)
 by AM0PR08MB5284.eurprd08.prod.outlook.com (2603:10a6:208:12a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 07:55:13 +0000
Received: from VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:207:4:cafe::79) by AM3PR07CA0074.outlook.office365.com
 (2603:10a6:207:4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Thu, 29 Apr 2021 07:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT045.mail.protection.outlook.com (10.152.19.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:55:12 +0000
Received: ("Tessian outbound 52fcc5bd9d3a:v91"); Thu, 29 Apr 2021 07:55:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8a865141ab0bcb9f
X-CR-MTA-TID: 64aa7808
Received: from 044c776e8350.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1D677A24-A8CC-4AAB-A251-3A361FD8502C.1;
        Thu, 29 Apr 2021 07:54:58 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 044c776e8350.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 29 Apr 2021 07:54:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2Af46A4QXdzMheYsaxn9CylDPYJfwraRz9medSmePaSNZqAIyYIcSCwh9aZPohAGr4sCBD92Ej8WF0aTKYxR3L26drZZUhUj//Fcib1YWBUZYDU8fa40eI9vd67LQ+KuWcvFpfS4apyrqo+A8i2c9A3mhWMHcom6HjfKs01zZjdiVzWswmmcWgGVnju5pZ9vAL/8VIe8LszScDX5vzDrSrJGLdYfPpAzQzMofREph8tVIcql+xF5I4NrMPKa8sF1YGKzJrRILo6IRblRgHnZe3xoteOFVxBonI//wzj4AsBGZ0t3+63KBH2AJwEaYpNGA4BE6wlLJdCnxFHGPj8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0zYGuWsORuOyUDHwqNarb4MmvAPV4rl076rWiPM96g=;
 b=G7/DZ/rvOV6p7fAJgAaXOuWtNU3Z+54BYvn/TFW0VHvdPl4lHzL1cdp/NkbYeAWEX1PeP5CqRSNnpEiGnWHZY++cDEOxkHJPpBxi3B779qJEr0TDcrGHvxVGDO4BwAzF/ZZGVdyND9m7OR1DnoRkRhBLcSsdXsqMYblQgh2yYWT1tPQy6gZcTsYRqGmgzAJP7H7K01EL/9UJ8jyAS2FO+BYuptkwNKLEEAUWDNfqkw7LBgsmgRhVHXAwP51EbAAO5KnFgTHaWRpKsNlI1ytCtjCMCSf2vhEGXERv49tAb8a/XpVUtWqV6h1hxM8RWohMheCUmpe5clsdt63ue0kSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0zYGuWsORuOyUDHwqNarb4MmvAPV4rl076rWiPM96g=;
 b=V4g2bNyy2F7Ui8Bq2JSo0yBDirObe41XKRkzcGpRmPAh0QAE7rJG50HL999jfTb0crIHrHjHgC7Rei/ZbxoAi4sYrWkuLuvmtqNRPEcpSzJy1ndWU/CWcxx77Hi1TNHI+xfIDueYl1EQXz4cs++4Tek3zll3fG7zzZ6j1rsUdQA=
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
Received: from PA4PR08MB6320.eurprd08.prod.outlook.com (2603:10a6:102:e5::9)
 by PA4PR08MB6256.eurprd08.prod.outlook.com (2603:10a6:102:e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 07:54:57 +0000
Received: from PA4PR08MB6320.eurprd08.prod.outlook.com
 ([fe80::c99f:671d:bb2c:f20b]) by PA4PR08MB6320.eurprd08.prod.outlook.com
 ([fe80::c99f:671d:bb2c:f20b%7]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 07:54:57 +0000
Date:   Thu, 29 Apr 2021 08:54:55 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Bill Wendling <morbo@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Kiss <Daniel.Kiss@arm.com>
Subject: Re: [PATCH] arm64/vdso: Discard .note.gnu.property sections in vDSO
Message-ID: <20210429075454.GQ9028@arm.com>
References: <20210423205159.830854-1-morbo@google.com>
 <20210428172847.GC4022@arm.com>
 <20210428174010.GA4593@sirena.org.uk>
 <CAGG=3QUATefn9AG+HvnCfEOBv3iRu4fzFwfmA7Djrh2CmP_weA@mail.gmail.com>
 <CAGG=3QUNykCfkS22g+HRWb0Goa8DJ72TUueLtMe5v1YfnStojw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGG=3QUNykCfkS22g+HRWb0Goa8DJ72TUueLtMe5v1YfnStojw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.55]
X-ClientProxiedBy: LO2P265CA0210.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::30) To PA4PR08MB6320.eurprd08.prod.outlook.com
 (2603:10a6:102:e5::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by LO2P265CA0210.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:54:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d9f16bf-634c-4690-ceb0-08d90ae41e40
X-MS-TrafficTypeDiagnostic: PA4PR08MB6256:|AM0PR08MB5284:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB528494FB4883B6B597FA9B4EED5F9@AM0PR08MB5284.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4gvN+Kl2dJ0OBiiwaGpculbg7TLxfhDQ2F9+j12MKascjlrUYOli86S4/SPsShTmGLIQUEzZ5bgYSb9I0C+7ruP3OzvIDpQU9/KhrDJsSapc0Pn3jbJfSBDq35N9Tj55gFAHnuXrj++Ym8PsTzKPv2YCmZQ7BB6bVqFF5j+HaSm/jVR7zMNyqj3UCrdpM8ZsK1yEIVjYdAQWIzdl2r/srslPn10puP461OwWMOemFsbzUp/TiKk0KhBivoBZJ1fVLieOivUDTZP7OBLNK+iYHdREADOVIk+41P0IagLCMtSyizHW4NBpT4U6vlnLXRJyk4o0e7c3jFC5z8nCXvfxftTDX1rZwLlHFm7PNwn1PeV0sH68JS/X2NtFvQS2TSRC/J1Fvmz5zjkTMyjORdG1oNjo3KS92ZvUUefDCkYGdmfND8RQBpL92MPPI/JXNQWT10+RLg4as4BAWSOKFYTWVry/7+rL8m8AE+jP6Cg6vJa5ZMmx1F50gs4Wn+9Ee8ptKz8/N4sspN+p31mnDdjZiRZUkhoh6/N0XQSs5uYo1IobobDPNgqyKkdWNOzM7fkV3SBTZnwXEV9+JgFqjSOahdnzcordHGH3qy+psxfWYn5If0AfLQ7So1MrTl2zUgj4XcmvCFUzWHhbWCUs2HBGGLeumjV5JuVeKXhA2WDkwIQEn6d+GE255mehJaHp1UakNV9Mcbbtv6RzmJeGiHH4Mb6sCwJPE6wZTdJ7wJZYqG+5dR+nYQa2vXafhOx1ogpL
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB6320.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(136003)(376002)(346002)(8936002)(54906003)(8676002)(33656002)(44832011)(1076003)(66946007)(66556008)(6916009)(66476007)(53546011)(5660300002)(38100700002)(4326008)(8886007)(26005)(36756003)(186003)(16526019)(38350700002)(55016002)(2616005)(7696005)(478600001)(956004)(86362001)(966005)(52116002)(2906002)(316002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NzltYVRNMUFIcjFDa0h0TlJKd0pMWHZEbXozdnZheHdRWCtvQjZRQUhmV2Mz?=
 =?utf-8?B?ZllxdUVKQ3B2TE5vTC9KSFZUWHdPd3g3Y0ZxMHR5bHJ5SGN2ZlBsRkZVN2hn?=
 =?utf-8?B?aWpGVDZoOUZVdk8wY1RYdU9WVC9NVFVJTkdxVU1TT1hzOG9IejRid3RyU3BD?=
 =?utf-8?B?STN0Zk8xYlc2UTVKWERKQlArRCtpMURUMmhSamZITklmaGZJcDZ6V2N2MU5o?=
 =?utf-8?B?WmR0aE11QUNjemtwenNoQlRJZWVzZUUvS0xjY3gydjExVVdRMGllYVFuUFpV?=
 =?utf-8?B?b1NIYmlabFkyMmRrRHZCbHN4TnFCbGsveGQraUw1cDVhVkZyeTErVHpBcVpS?=
 =?utf-8?B?a0RiM21NaEJKUEZvQWNwdzUvWXd1TGZNNFdXdEVmVS9NVS9mY05rdFEwV2tZ?=
 =?utf-8?B?bkI2Wk1zNitISDg5eUtqaE9VZDhjR294TkZKYnV5aHRXTWZqY0NMWkZMczlt?=
 =?utf-8?B?WnA4NlRZcGhaZW5YMEY0U2gwdEN5Y29VTE1OaUhXTVM5Zy84Y3VISzVVQ2pV?=
 =?utf-8?B?U1hIRXJ1d0ZUOVJjV3lwUnVIYkt6MEhJZUN3d0JhamVMaHRjeFlUcTgxTUlt?=
 =?utf-8?B?c2NhVjVqOElUM0N0VE9vRm93UE1EdjZabkIrdWJCejlWZVJPRUxyMjJKd25m?=
 =?utf-8?B?aElCaDI1NXZNRDQrM2R2TktVbTlheXRueUJRR0JEMXZnNmRBNm85OEsrdDN5?=
 =?utf-8?B?ZnFIRnpmeXBEK0w5MGtsZ3c1Y0RVbGVNTzVVckhHeHdPZHBwcWZqSEJoNTNj?=
 =?utf-8?B?TDN3WGExc2tuUDZkTVQ3ZllqeTlLVEFuWWVjRTJVWTdIOWcyRHBva0YvU083?=
 =?utf-8?B?TkJOR2dsUmNoQ3BPWjloN2R4bjdpc0w3RFc5N3VLTjlZUWhzTlhwMDNNRDhW?=
 =?utf-8?B?OG5FK2JaeVdyNlNoNG1kb2F0L2wvS3FvVXdmNE10RzNnSjlESnArTkdtSFQy?=
 =?utf-8?B?RDBXT0JyMXJtVS9DZ3dxNzc0bDkzOHhGMEpYTis4N2t1UW9Yd0I4cHNJVGxO?=
 =?utf-8?B?cENSMjhTQlFNVjZmN2EwQ0dQRTZaSmJFeTJ6dDdTcmN0V3RMMit4cE5tQXJt?=
 =?utf-8?B?dXF3QndXYnR4c3oraEVSRGUzU0RPOFNTWVVDMUxYdXZoeGlKbzlONjVITkta?=
 =?utf-8?B?US9jZnc5dVJ3c0xlYlNVK3hjYkpuOUt1N1Z4US9LS2NDMC9uRHNWVDh2Y1N6?=
 =?utf-8?B?TXNRb0d5Nk1JbkwwUHpYRG9BZURHazltVnVXSmd0RmxSZmpHVDJNLzNTTGRB?=
 =?utf-8?B?aktoNFBNZkR3eWZTUVM3UVFJNm05MWlhZGROTVFSTWtiVC9pek5lQXdVOTJ3?=
 =?utf-8?B?WGRrWnVPRUkxZnVHN0pMWkt5d3RFM1JSQjF5eGtSNWVDczhpbnJKRGRWczFX?=
 =?utf-8?B?K2R3eW11RUs4bEo1cnlkeDhrMlp5Qml0Z3IxamNYbFBwK2NlRkFzN3ZFNnlx?=
 =?utf-8?B?V1dWNUwyclVaMVRlTEVpb2dPQUpwaTRkaVM2a1hxSTl4ZVZmYzlLNVE3K1lC?=
 =?utf-8?B?aVo0L1A2ZWZEZFRIcFpMZDNteHVwUHRLbExXb3llclFCK1Bqd2M4MEpqWTJH?=
 =?utf-8?B?MkZQNGtmSmtEbUIyNWpYWS9ETkxTUERYNm1hN2pLNGw1UlZzdnE3ZFE4R0o2?=
 =?utf-8?B?WFVPbVMveEZ3YzVxMlZZRTZhOWZiQmpKTlpueGhONDdycWVhdG9mdno5S05r?=
 =?utf-8?B?Q0RLNytCL2NhaWN4K00rbEpPOHU5QWRScmFvZE9aY0xiY09BUnYwclc3V2dt?=
 =?utf-8?Q?ovVjnkonPh6avM5bWRXd8PbHgSp1GHKYXriQGzt?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6256
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d90bd315-c7f8-4102-ef6b-08d90ae4153b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: di1kNottnBnHi/07LkWjy+MnpHCrf3B4fiQnrZ9tw7lpQRcpiHk4bGtU8WuFFYfRUDbADDMm/MPWSOZGBjvAuvC2ohghHR1mm46+4rpHpQ1MKEFjLTA5XdtGjd/627mvTsdT85RFnbyYS7dCkpVh+VYsuAz0CZ3rz7PZVTeSaYW0mwTam57VqyrDtWubG0PgBsvve4fGbqHNJKPANqjX/SG0t6iD26KZFbO+hyQUhE1EuPH+Hz2donGM/StSaf+a2tOepEyRFz/KtkX5tZ4h5B76nIKRsQYiBeOToPLbFpDFF/yx80yDAvmb18usA7MnE1PkV0d/YtYHxtdQSSxU3Ozos4Y9lzL1hcgy9oWA9FtcL4T+TfeQDAcgTl9h6pr0pW+ZaEtvBNcaTlGvjLKvCZY7QpNNEvHgC0t6T8FGJ3RO5jfh0dcbxtiOhNtDhnXetS3cJFEe8EFOAmUNaHh8QK6VNBSsp1AZh3lNNTRtd60ZCf9B0isuhB5PRW2MaLfUbUl6L54feOXN8w9WZSymsidOYCb4rtYZjJPvJCN7eteiiCjgi1RmqeyWK3mm8OWBTEc98Xq6+ZiBaeDwRV+zV+HjoapGy6U5E1yIjwjXVL8ZOIcsXnYp/WpSWXSNj/7dsnZfE2ESkxyicIUNY7NQ9PJZdaW5GdmTVgMwd91c1mRtYE0kG8vF8Jb0LzxMutjBnv5Ae4wtlC6pG84meLNW92V8R8H4JTSABI3OG34XP7RMZTJ1c4DkbtC/K4D6gmIswPkuar/FxdiVBjDX/4Dau4ItthBQ3XmgvYeoJrOQI+g=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39850400004)(346002)(396003)(46966006)(36840700001)(966005)(186003)(16526019)(478600001)(316002)(44832011)(36860700001)(5660300002)(36756003)(81166007)(356005)(1076003)(8676002)(8936002)(55016002)(86362001)(82310400003)(70586007)(336012)(956004)(47076005)(33656002)(2906002)(53546011)(26005)(7696005)(4326008)(70206006)(8886007)(34020700004)(2616005)(82740400003)(54906003)(6862004)(142923001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:55:12.4311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9f16bf-634c-4690-ceb0-08d90ae41e40
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5284
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 04/28/2021 12:31, Bill Wendling wrote:
> On Wed, Apr 28, 2021 at 12:21 PM Bill Wendling <morbo@google.com> wrote:
> > On Wed, Apr 28, 2021 at 10:40 AM Mark Brown <broonie@kernel.org> wrote:
> > > On Wed, Apr 28, 2021 at 06:28:47PM +0100, Catalin Marinas wrote:
> > > > On Fri, Apr 23, 2021 at 01:51:59PM -0700, Bill Wendling wrote:
> > >
> > > > > Since the note.gnu.property section in the vDSO is not checked by the
> > > > > dynamic linker, discard the .note.gnu.property sections in the vDSO.
> > >
> > > > Can we not instead fix the linker script to preserve the
> > > > .note.gnu.property, correctly aligned? It doesn't take much space and
> > > > while we don't use it now, it has the BTI information about the binary.
> > >
> > > > Cc'ing a few others who were involved in the BTI support.
> > >
> > > Not just BTI, we also flag PAC usage in there too and could add other
> > > extensions going forwards.  While the note isn't actively used by
> > > anything right now due to the kernel mapping the vDSO prior to userspace
> > > starting it is part of the ABI and something could end up wanting to use
> > > it and getting confused if it's not there.  It would be much better to
> > > fix the alignment issue.
> >
> > If there's only one of the 8-byte aligned sections guaranteed, we
> > could place it first in the note. Otherwise, we will have to change
> > the alignment of the note (or somehow merge multiple notes).
> >
> I should have clarified that there's only one *entry* in the
> .note.gnu.properties section, and if not then is it possible to merge
> multiple entries into one. (Excuse my ignorance if this is already the
> case.)

.note.gnu.property should go to PT_GNU_PROPERTY and it
should be merged following rules specified in
https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI
and
https://github.com/ARM-software/abi-aa/blob/master/aaelf64/aaelf64.rst#program-property

it may also be covered by a (8byte aligned) PT_NOTE, but
that's not a requirement on aarch64 (x86 requires it for
compatibility with old dynamic linker, but since the vdso
is handled specially that may not be relevant either).

i don't know how this works in linker scripts.
