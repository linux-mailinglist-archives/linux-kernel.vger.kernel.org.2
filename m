Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8857933D3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhCPM3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:29:19 -0400
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:42070
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231538AbhCPM26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1j9Be0NWsBxJXa1DDvUd6REtlrVC8MF/CtLqG87+wQ=;
 b=q3rTIWgzr6lvIoTeBgpYEDDEuzAtc2fwxnzapEbANOlV4THdT4KBBXsmaAOueA4Moxc2PmdSfXar/XcV6HNn5nywkDYmYX9SHirOIPfnmeRyxeOZIXh2iAi0lMjdsIGhM/VE7FFrQj52+prAMhtMSMIMtlq5F+kX4H8QwD2Vjmc=
Received: from AM5PR0601CA0052.eurprd06.prod.outlook.com (2603:10a6:206::17)
 by PR3PR08MB5692.eurprd08.prod.outlook.com (2603:10a6:102:8a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 12:28:54 +0000
Received: from AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:0:cafe::ce) by AM5PR0601CA0052.outlook.office365.com
 (2603:10a6:206::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Tue, 16 Mar 2021 12:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT005.mail.protection.outlook.com (10.152.16.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 12:28:54 +0000
Received: ("Tessian outbound 259fb7427a57:v87"); Tue, 16 Mar 2021 12:28:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4d8e886c46346694
X-CR-MTA-TID: 64aa7808
Received: from d1aa31154d56.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D44211FF-3B1F-49D6-A125-C64A4F4733C2.1;
        Tue, 16 Mar 2021 12:28:47 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d1aa31154d56.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 16 Mar 2021 12:28:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWqFguNwwKpt4xpLO93YzuSWsHmrOecEMg0YMZ+Z4DfQfrHvKslOn0klBEN+s64QUor2DQy3yqYQ5QAYnQ4hxMpIFUIsdDNhlnpbYgTUra3z1lQPXOfYF46Hrfr04/RsXgdJduY9fOKl/a8oogvkimTekGLGvqCieWzXeKPPk+8sAegctNLO5ybK1G+vC7i9U9zqeLe12xFBTfhF8KJln6iwXMbIHwbUoESrbfmu1Slzv3QktC9li0MU9CvQ1xw/zvIRK9pChU0NKAD5vFDj7l2fFOMzaXKAzU/sLPTsyzOJ/cWkJfoJHeoFH3w3KXEaHjOUnM3O7kpcMzPkIjesJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1j9Be0NWsBxJXa1DDvUd6REtlrVC8MF/CtLqG87+wQ=;
 b=JF0iZHBEGFRmzOGG8c0MXV+RV6t73oRa6tHoaWQUTpv1xfIAiI4/cIpqDX164MajcSFihhyqdex0Em+fRi0Tqm7MjkzpkoJaqtptqMKs05CdB5QlZ6MKCX55GrDGjDESJhM0pjEZGcnk/uymDKHWNZ7ulKb5rufOsBG6SMXZrnGvqcXpcqG/eu61QxkGCEpeIAEdrsbfwicN2E3hmxTITmOZhrnNRX5VevQsA8URicsBoqe328jMTnPBGa8Zb2sVQVLjAFn+tGjlH/+xI/jDJ6b7SOGPrSKg6kmAqq7cfz9fym8Dh9cchWUEzfwH1ZgRWxnufzzssUeg2s8vOnxcrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1j9Be0NWsBxJXa1DDvUd6REtlrVC8MF/CtLqG87+wQ=;
 b=q3rTIWgzr6lvIoTeBgpYEDDEuzAtc2fwxnzapEbANOlV4THdT4KBBXsmaAOueA4Moxc2PmdSfXar/XcV6HNn5nywkDYmYX9SHirOIPfnmeRyxeOZIXh2iAi0lMjdsIGhM/VE7FFrQj52+prAMhtMSMIMtlq5F+kX4H8QwD2Vjmc=
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3568.eurprd08.prod.outlook.com (2603:10a6:803:7f::19)
 by VE1PR08MB5742.eurprd08.prod.outlook.com (2603:10a6:800:1a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 12:28:46 +0000
Received: from VI1PR08MB3568.eurprd08.prod.outlook.com
 ([fe80::d032:5b3f:97cc:6c4f]) by VI1PR08MB3568.eurprd08.prod.outlook.com
 ([fe80::d032:5b3f:97cc:6c4f%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 12:28:46 +0000
From:   Mate Toth-Pal <mate.toth-pal@arm.com>
Subject: Re: [PATCH v5 33/36] KVM: arm64: Wrap the host with a stage 2
To:     Quentin Perret <qperret@google.com>, catalin.marinas@arm.com,
        will@kernel.org, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-34-qperret@google.com>
Message-ID: <ec9df9a4-a419-089c-469f-1a1509597dd9@arm.com>
Date:   Tue, 16 Mar 2021 13:28:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210315143536.214621-34-qperret@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [188.142.195.117]
X-ClientProxiedBy: LO4P123CA0063.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::14) To VI1PR08MB3568.eurprd08.prod.outlook.com
 (2603:10a6:803:7f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.45] (188.142.195.117) by LO4P123CA0063.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:153::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Tue, 16 Mar 2021 12:28:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bdf499b6-bf54-4e6f-9848-08d8e877101d
X-MS-TrafficTypeDiagnostic: VE1PR08MB5742:|PR3PR08MB5692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR08MB56921F4562B2E9DB9B233AF1AF6B9@PR3PR08MB5692.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xELQn9BI6ZIOWAENqPiMyjo4BTdo5s98c6UsZIR8GBTnp6Jm16xT4vSsCcEwrZ5DcwlVyGALPBDKWFkDMREcBrl1CUGDNPJlzkJB2axqO+itYYF8w207AuINNGJT4OtDDqBGwwAztwBzu/iKPf4Q91Gs/T3HmqtgbqG8Uo9Dea6X5VENnT6hXY+5TLjhLANJ3Q/nFLDlqebHITu2ls9KxFeW08K3GCHfRkcuKUWoMlGn0GNzq47peeSKZKenvGG6/74t2tysUgqbZZr1PVmn+m3rHZ9KqVeLwEzqOl8sYCqXZS4KcJ0JlqJJG/ZU5jTzvcE58B+Mw77L1bqHVdCPE5TpKPeKw48pwH8EKZoIDM1ZXaT5hPsWefNQR9kaus5ykp9UlzLHao+1tQKWsaoLnPgIuBDoiNEEZIHlqUcEo04X3hr3NWvtkvedQ1ln8kpTakq1uYReKLwLTADQcy9V9UiGwhVfnOoqCJeztMbdcePor1/ad9ZysgU65v2gmBB9AbnUs5pq+vyqGWOMn8Rrq7LC0HfDzA4wbZWmo1/n9vOlXFFSSTOG4SeSBNA7MaH6qEqjJDUVUeh99aJI1k8GB78mW9PMJ8dkLGs0cmZlQHlswtcXyg8h9hsuNEV1FpdcMOAbL2mYHuc7mG1v8/RNxg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3568.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(346002)(376002)(136003)(186003)(31696002)(6636002)(66946007)(31686004)(66556008)(66476007)(7416002)(26005)(8936002)(55236004)(53546011)(36756003)(5660300002)(83380400001)(2616005)(6486002)(16576012)(86362001)(316002)(956004)(16526019)(478600001)(8676002)(2906002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SC9mNlZRV0hpRitMN3o2NHVNM3ZzclljM3N2djNGd0hESGxVSU1VcEhLVjdw?=
 =?utf-8?B?eG9pVzViRVV1cmFrVW44U1ZrWXloQlcybkZRNUdIcERKdlVJYUd3V0ZqTzlV?=
 =?utf-8?B?Tk5McjB2bENEeGtEcUp6NnltZHRxZ094MWxyWS9jRVBlc0N5eUNRR1o2OXkz?=
 =?utf-8?B?YTlacnhkZkFRYXY5enE2QTBPUjR2bG9IZlJNRTJqb21yaGdwVlkzVTV6NVYx?=
 =?utf-8?B?UlF0ZHhkTTJvN2ZocEc0aWxtT243bHJLYjkrTzlQWURLK1BaWWVOMUxDVjQz?=
 =?utf-8?B?aVZNM1RVWXRicER1bFl3aWJCcEpQcmFQcE9POHR0VjFDekliaURtdDJ5ckdK?=
 =?utf-8?B?TGd4b01kWDFqcGR2Y1haS3JCa0ZxNEIrUUhEVThoQUlMRFZpRjdtSmpJbnNu?=
 =?utf-8?B?VGNyWktuMUMxdjNJUlNZejVac0VaUHh2dGpnOGJtTG9vQUROVVhhMktRKyth?=
 =?utf-8?B?ZFdwV2xvc2FlZTFQcWJkNVhXVGFQKzdkZHBkSW9aUHR3RTV5bkE5VmlUNUNE?=
 =?utf-8?B?U3QzVm0zNU1aaHhsSVJXZWd5dkIwaUhXbzJhT0JJWkE0UDN1N0NSc0pjQnNQ?=
 =?utf-8?B?Vnl0V1hEdjZKc3RHcXNNOHFhMkdJQ3ZUclBsTEZXUGlMcXNlVWdZQVh1ZWRV?=
 =?utf-8?B?bzM5ckRXemVtblJGZjZSUVhzTHFRYUJMZlovSHRIVjR0QklYa1RvK0NLQko2?=
 =?utf-8?B?TXBBU0hBbXdMc2R2N1RCNS9oQWo2cmI1QlBRa09PSVM2ZktlUGJSMWxWdU1t?=
 =?utf-8?B?TiszaVFtRlYvUUNLTFB2b29iRGxiNHV3ME0zZllzQVhKeWExUk1xMFlZbjVB?=
 =?utf-8?B?dGdXdmZyTWo0emx4VlFPa3Z3WGtubTVFcEFPdFhnKzJUN2huOVEzcmVmSjJz?=
 =?utf-8?B?bzdCSUgxaERHY1NnNEx3SEM3endDT2NqZHJSWjVrU0FPcnlRMjYwSkhtUkkr?=
 =?utf-8?B?WHRKbStQRWR2ZTRZTEtZTGltdGdNTzJMRlpjT2k1anFqanJQSG1HUFYzYm9B?=
 =?utf-8?B?b3dzUlE1V3ZnNUVocldpL0gxeWNFa3lQN2xUSjU2aHNRcWxKekpPUkxBT205?=
 =?utf-8?B?akxDYU1xV2tEU1dONGZyN1I5SldWNkxkTFFNeGgwZmhkWmJmRHdXOWdsMFRF?=
 =?utf-8?B?UmYzOEZpbzNoZndhd29IUkhTbHpVR3ZENjhxZWxMNUF4c2FtT2VTMzV6K3Yv?=
 =?utf-8?B?WTU4ZXhZaHJMK2V0Y29hamJ6bWNUM0JLQTNpM3lpT2VUTUJMWjgxRkRaRjRV?=
 =?utf-8?B?LzBqTXhFN2lzSmR1cHZrOS83WFphbXJGSDdrVWxMQnVIVDZEUEFxWk0zSTZN?=
 =?utf-8?B?UmMxcS9ZOS9KdHQwUmJrZzZyUk5UYXB2cnJlaXhHWTFOaTBvaHJ5VVdlWEx5?=
 =?utf-8?B?SlQ4TUtNZVV4dGdTS2dGWm9oTEJ0VklWTHliTlpxLyt6KzNweTFIVUZKRFJT?=
 =?utf-8?B?K0o5cGw4SGFSQTVFY1hLcXdDQXlWWHJQNmExbjJab0ErZ1owTHZ4b25KcTNJ?=
 =?utf-8?B?ZVRUdjNjNWdRdWFhTU5BeUlOZDZKNkRyd0FWclJFbzRLQkxXYTlNcUF2ZHVM?=
 =?utf-8?B?Q3l0TXJqTlhEL1o4K1FTcmVudTB4VXVVaHlnbDQ4bmhOSU54SEQ2T2pmbzk5?=
 =?utf-8?B?L1o5bUZ2NkFHUTY1M2JyZjUzQnZIYm1LMThUZW9xa05HU2NCMUxYZGM1Z3Jy?=
 =?utf-8?B?RSt5cENXeGdFZDlGejh5ellvTWZ2b0hhVXFFRDN5ZW45RXRoL0ZqaTNHYzZp?=
 =?utf-8?Q?Qe/YvFCjXOImFJ2QFz2lBFiKOd+3h9KIuva0mzw?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5742
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: a99b59fa-5ab2-4325-8b64-08d8e8770b47
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSsWruC21eWx5SbL4+WSIwjKy9ot9vZsf81yswl5FoI3gVJpJiNxcYrDVUP950X9G3CMnc2+XPK6hhYm2VDZUraKhfVD9ansRznEzx8t5KaKtaA0Bb1wQEA7w3KiP7kcAEdfiIDfClH0AkK9+/Yi9rYEhh1MGGCd9eDC8dXaCLavcMKAcNgNXSMPDdYmNdJrjjlaCwazOg5jGzAu6A2WnXXtwr4OgDKNxLNQyzeVm/ey9cjBGBj06B/XzC4Cqbwh7ls7uOUUzuG97K51P4sXKzO47uxZbvbfn2y3zDZikxCZ7Dbs6Kthc5mri0dT2lRIw/RYltnoS4Q+jR6bJPgOt2KR+8NvmVJYcukiq22SKI2Sbe9d3zGCNdsD2eSBQMUZ/3UT7k4FIGCHCjLnNXSFymH7Eo/RM+akjdMD6jWeKqWwBvB0eztMRLgBUyiOtIdSr6V/jeYowne5EZ5O97Cf11+JeXw/6nCSPFso9GqaMDhzx+K11fKE8BJn+DbKS6jN0Pq0lQBexmHDGQlkraQIuZTQ9Gl3szhOZD3h1aH6fenbZFylDs4FmJqsvo4i9a/WQ0ve1NVq1FFaKM8igud4GU8GLMT04OwBlxfKV76sxkXnzWK/BzuiJ1Syo7pqdfrNB1rqx51o4fvqoiJrgXIjaNtAUHbZuDY3RKrv7XIPuSVRgwxWjZ09yf/qYyA+1SAJ
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39850400004)(346002)(396003)(36840700001)(46966006)(186003)(107886003)(16526019)(86362001)(316002)(6486002)(16576012)(26005)(70206006)(2906002)(70586007)(82740400003)(31696002)(83380400001)(8936002)(36860700001)(4326008)(356005)(81166007)(6636002)(5660300002)(478600001)(8676002)(2616005)(956004)(55236004)(36756003)(31686004)(82310400003)(53546011)(47076005)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 12:28:54.1312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf499b6-bf54-4e6f-9848-08d8e877101d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5692
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-15 15:35, Quentin Perret wrote:
> +static int host_stage2_idmap(u64 addr)
> +{
> +	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
> +	struct kvm_mem_range range;
> +	bool is_memory = find_mem_range(addr, &range);
> +	struct hyp_pool *pool = is_memory ? &host_s2_mem : &host_s2_dev;
> +	int ret;
> +
> +	if (is_memory)
> +		prot |= KVM_PGTABLE_PROT_X;
> +
>   		/* Ensure write of the host VMID */

Hi Quentin,

Testing the latest version of the patchset, we seem to have found 
another thing related to FEAT_S2FWB.

This function always sets Normal memory in the stage 2 table, even if 
the address in stage 1 was mapped as a device memory. However with the 
current settings for normal memory (i.e. MT_S2_FWB_NORMAL being defined 
to 6) according to the architecture (See Arm ARM, 'D5.5.5 Stage 2 memory 
region type and cacheability attributes when FEAT_S2FWB is implemented') 
the resulting attributes will be 'Normal Write-Back' even if the stage 1 
mapping sets device memory. Accessing device memory mapped like this 
causes an SError on some platforms with FEAT_S2FWB being implemented.

Changing the value of MT_S2_FWB_NORMAL to 7 would change this behavior, 
and the resulting memory type would be device.

Another solution would be to add an else branch to the last 'if' above 
like this:

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c 
b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index fffa432ce3eb..54e5d3b0b2e1 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -214,6 +214,8 @@ static int host_stage2_idmap(u64 addr)

         if (is_memory)
                 prot |= KVM_PGTABLE_PROT_X;
+       else
+               prot |= KVM_PGTABLE_PROT_DEVICE;

         hyp_spin_lock(&host_kvm.lock);
         ret = kvm_pgtable_stage2_find_range(&host_kvm.pgt, addr, prot, 
&range);

Best regards,
Mate Toth-Pal

