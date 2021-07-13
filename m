Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459EF3C6DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbhGMJqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:46:13 -0400
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:20704
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235031AbhGMJqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux5ZeEaFo3r61B/a/+3K9BuN2nuqlumS7H5Iee7Fqyg=;
 b=AuVtXtDo6ruxfOR6pfovRkBHH59UByZ3KL4oYpmrT7RzuhzLUBf/Li0rq18Wigt7ge/TMPW7sNZgyQ3qNqIeV0hoOwLpY4suROprnhFTv7i3kKOLrqfOaN2D7dMqzPxJnH2MRgeD5o0uEKEk4xJNAScqyUST2FRx8hjDdntm2OI=
Received: from AM6PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:20b:2e::17)
 by AM0PR08MB3954.eurprd08.prod.outlook.com (2603:10a6:208:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 09:43:19 +0000
Received: from AM5EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2e:cafe::e0) by AM6PR05CA0004.outlook.office365.com
 (2603:10a6:20b:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 09:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT027.mail.protection.outlook.com (10.152.16.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 09:43:18 +0000
Received: ("Tessian outbound 17c2a40a31ce:v98"); Tue, 13 Jul 2021 09:43:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 99cddf1770bb61f0
X-CR-MTA-TID: 64aa7808
Received: from a95075073d94.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 231B3E0E-77EF-49C8-8E25-2EC0BBDD8419.1;
        Tue, 13 Jul 2021 09:42:59 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a95075073d94.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 13 Jul 2021 09:42:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/JsV9VUylnhxXTJ2DdYB628b2fJ1vCMDspRqi3njAfcRTfNw+vBMj2SjfinCmDSOeQ3jhNL7LdMo4pgj9C+yPP4VRso+U/nWo46QLF3fLnI5w9e3HZxYO+v3i7OlqTp/nAZElC8HFoTaKdvfpm7XdbKYeE98EMXrBjtjZLifhnpG0eGu4ehgl9epqNDADRIlQGia3VX0hiEURl0jwv/IAv2MBB+sXLoMDFLyA7vQLhhcWFpC2jRJXlsoe7i9sEbcc3llGDv+bp4Dr5L/+iErHmEjqH8YuphE/D+czMoejh2KyK/dXqqxHjHWAArrwqoyNnDDjHeLc3bkVV8G7fQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux5ZeEaFo3r61B/a/+3K9BuN2nuqlumS7H5Iee7Fqyg=;
 b=i1g0U9otAQnBmOMrM4Dh+JRk9cXWX9g8fhDUlKtONSRORDp2kKAa8MzF+w+3ymNbJoc6eTY2K2piJf6jfaC9lELKImDVGuxU2/CFddESzm0A17y9H4vW959iHemCW4rp04z0/1vUuqamCIJRBRfd/PfoRuSArqv4RWU/AfjOtneZle6yYiGxLktIdBZNi1JO8f1oWxTAt/24vMAsqm8QJuSyUImJj35mlLsHxXUJ5xthGzbGD1kN1cAMNaiFGzR4kDmGwj3zlSbaWl54xEQzxOk6W++fz7mkwTWezvx8LNBJSQaq4y0RUtHtXc/UPIX55Qy1NsM6HJy7D29LqY4DvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux5ZeEaFo3r61B/a/+3K9BuN2nuqlumS7H5Iee7Fqyg=;
 b=AuVtXtDo6ruxfOR6pfovRkBHH59UByZ3KL4oYpmrT7RzuhzLUBf/Li0rq18Wigt7ge/TMPW7sNZgyQ3qNqIeV0hoOwLpY4suROprnhFTv7i3kKOLrqfOaN2D7dMqzPxJnH2MRgeD5o0uEKEk4xJNAScqyUST2FRx8hjDdntm2OI=
Authentication-Results-Original: lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=arm.com;
Received: from AS8PR08MB6069.eurprd08.prod.outlook.com (2603:10a6:20b:29c::13)
 by AM5PR0801MB1841.eurprd08.prod.outlook.com (2603:10a6:203:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 09:42:56 +0000
Received: from AS8PR08MB6069.eurprd08.prod.outlook.com
 ([fe80::4cb0:5d8d:26b4:a9c5]) by AS8PR08MB6069.eurprd08.prod.outlook.com
 ([fe80::4cb0:5d8d:26b4:a9c5%4]) with mapi id 15.20.4287.033; Tue, 13 Jul 2021
 09:42:56 +0000
Subject: Re: [PATCH v8 00/10] CoreSight configuration management; ETM strobing
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210707133003.5414-1-mike.leach@linaro.org>
 <20210712164413.GA1777012@p14s>
From:   Branislav Rankov <branislav.rankov@arm.com>
Message-ID: <a80b9a03-01ba-3752-9e6e-ee2d194ba2a1@arm.com>
Date:   Tue, 13 Jul 2021 10:42:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210712164413.GA1777012@p14s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::18) To AS8PR08MB6069.eurprd08.prod.outlook.com
 (2603:10a6:20b:29c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.57.35.153] (217.140.99.251) by LO2P265CA0006.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:62::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 09:42:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 784a24b3-b586-4d64-e038-08d945e2a551
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1841:|AM0PR08MB3954:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-Microsoft-Antispam-PRVS: <AM0PR08MB3954E6F0C170428BC8886E7694149@AM0PR08MB3954.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LT80mFmU3ryMnQ6LzVxYTHF9DiknvYdxQfuFp2V1OKCyBfx7ctLcVA5gRC6MucZMP7JaELYqKlHKxDJur+exuqTk1o/d4KqxDLha5XABwNK1kkfeDj+XvvOzjoGJO2XTIGM5aaQZKTTL70nZk9RD4Un1xsY50sSqZzoPbMgQWvK0Uzih++8ohq4wd1oBFbUAgb55j+T99ET4WdHZ7CAqN4ySdL0S9mzIvmIEGfsmqVBVkvupRipvdQIf4pEaJ3/Z9eDqUptC4IOvZiQr5m9HcWFuNXgipBjUqQueThsbti4I5An1J/A32LexbJM6UoLu8zC8ZfZ9CcM+JiZKiH4o1uhyEYZlqEcMUY+7B4qzLHZMIFqgkXzToYoUesuBbf8joEns8uF66ymqoZfmGrT8aaTiMDVTUdpVO/SVkwtS5Wx/EEKCOG7dla/BIZDwqc2+lTBnZQ4HkQS9sic317dKoSmyFk97NC//J/WEpYqXDsxti0Tb12q8lCeOQ5Cv2bFJyvuheG69z7sDuAyX+pIf3Dneby2YIZ3n9gur7hYY8LLVXz9AKlDgyhkDPiEulDkM5Pw6sGLtrEtDDeGmSVROS2RiQTuv07NiohD7wCRUdKwS4RhfOGNQW5eTs9N1/A+hzSFAZUNsJaLdr+Ixr3IeyYVruqmN52Jiv92Syz/LzO0+Vrld0dmXsHJ5bjNuTYFHO3YN7jN9LpI9LCyQ2tiGySJSDZt/rYxc5hNFci7vDN1lFPzEDKgZJ6drD6bnYxBSEjsI6vJUo5g/7dkxP0X5gOu0drK5wje/3g+FY/9UbjI9CK/8Zri6HUmL2uIUfmMn
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(36756003)(66946007)(186003)(956004)(966005)(6486002)(83380400001)(16576012)(38100700002)(5660300002)(66476007)(478600001)(2906002)(66556008)(53546011)(86362001)(44832011)(31686004)(8936002)(31696002)(316002)(26005)(2616005)(6666004)(30864003)(8676002)(110136005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTV6dTZTUlRzSWFqOUFQL3NJOERjb0d0ODF2c0pWWkh6ZG9reVV6NU9oOHNS?=
 =?utf-8?B?YVphOVZJbERxKzl4aGdONUlpNWorQ2RhVmplaGxuS1FEdzkzbXVYQm56ODlR?=
 =?utf-8?B?dVNJVVZJd3RiTFR3cXBJbTVSWTE1VWsxRWU3cURVUjdLTS9iNUNEL2JUaElm?=
 =?utf-8?B?eE40WC9rcEJ4U1YzSzYxOUFzdmFpdTlTQk1DMVZRMEdhRXFueCttbUJNRDRL?=
 =?utf-8?B?VkFsMml4V0pFL0hMbEtLMThSdTNXaFdiaHg1Qk1EcW1FYzRlWHJsQjY2UE93?=
 =?utf-8?B?ZGZFVGxyKzdFZDZWYzNjQ0xab2JaMEZDbVl3ODYzOWZMNC8yclA3ajJKZ0Fy?=
 =?utf-8?B?WURuRjUxNyt2SUZwZnFpNlorWlFtdkhON2x3RnZYRlRiK1FmUTRPT3ZFUXp1?=
 =?utf-8?B?eXNNVHJ3WmlDdHlxQTBWY3k1eE8vUmVMdVRXOC8rQlNZSk1zSFcyTjZFNFB0?=
 =?utf-8?B?emZ4QmdBejZuMUZST045VC90LzBwN3hhRjg3Zm0zQVBDdk5BbXV3RnMwTHlQ?=
 =?utf-8?B?T0xyU1JpSjRwcFgxSWZaTFB6Y0NnendzTWhBTi9LeVlnK1cybS9FQ2JzUkJV?=
 =?utf-8?B?U3RwSjQ1bjNHWFVQQ2J5dkd3NzU0dngrVEhCY3ZIZEZGMUhZWjdtUitKckl3?=
 =?utf-8?B?OHE5WE9OMmkveHRlTTRyL2pBVHdaN09wWFA2M2xmR09VbXNwWVN0V2d6RXpN?=
 =?utf-8?B?eDFzeERxSGRaeWM0c2hqMm1qbEtlKy9RcFZiSC9ZV3dVb2hmMDVnVlJ6c2ZZ?=
 =?utf-8?B?Q3d0ZndJd0FobFA0Wmx2ZXpvU04wbEYzZlNQVWJ3ZXZHV011d3Jra3BLVVhF?=
 =?utf-8?B?OGNldml6NFZWc3U3Ukxqd0xTTGNRMVRCczd0Tk5hZU9sNDBqQjR6bys2VGpF?=
 =?utf-8?B?RmpQVDJrdlQvTUlkWmt1alFJeElXMU54V3g2c1lVSFJLU08zcm1QMFUzM09y?=
 =?utf-8?B?UndXUTR0Wld3Z2NFTzJod1lVZXJaUldnR2htWHNaUGU5Mm1Rc3o3SGV5MWpR?=
 =?utf-8?B?UktKMElxZWswYzZwaG5pTEFLUUFPdHprZXpMNWIwUlpzS2hySktJQU55K0R1?=
 =?utf-8?B?SFUwTDdWSWNjaFlNVHRpUHdycG5RQ3hyYk9oQlk1Qzh0dFNtcTkrZEtqVnlh?=
 =?utf-8?B?NXUyVXdVaWswRXVFd3VSRGdJUXUzU0VYYkRobU5SazRsWEI1SmdsMHl0c3I4?=
 =?utf-8?B?WEFoY0hYbEpBbHNyRGpjbWtCbm1ER2xhOTA2M3IrUTJ1OUtqLzlVbW10UCt2?=
 =?utf-8?B?ZXdGdFZZdzdhQnZrNVM3aW5IUU5mclgzNlk1MmRjUzgvTThGVUpmL3BvUVpZ?=
 =?utf-8?B?NllOUlQ3N1pIOC9ZZzcrSXpaUVhiakFCTjErYmFjei95NytEMVhoc2dtUU5t?=
 =?utf-8?B?a3p1V2NjYnZKTjRZVTROR1N3aHUwZm1tQ3Nra25CYVBRZlUya1lSUmQxNVVW?=
 =?utf-8?B?MmJnV0p3VThXT09NZ3dlckJvNlRBKzJPK2kzVE4rQUlUdlB2b3NjUWF4cE1i?=
 =?utf-8?B?UVRya2M4T29jVXNsWHRtcklGQTJUNmZ4eFBDV3RqMW1haEtBc0hRb0lQN3NC?=
 =?utf-8?B?V0pjZzhtaHl2TFA1Z1I1RzlYWlZlS0FRWHlwMkR1K2lQRlVZQnN0VlRQTmJX?=
 =?utf-8?B?SzhkbDV3ZDZ4NVhxcnVZWmhFSEJLM2lubVRJVGNPY09oY3dDMkVrTDJ6V09Q?=
 =?utf-8?B?RzhzeEpIVU5oUldaNmljOVFvWTZLekhyNnBPZld3ZFVDZm5aSW9IWW1CYnpz?=
 =?utf-8?Q?WY9MreU1582emWQPQHOgEr/Ns8jpE99UFLhQAnC?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1841
Original-Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: af1f5df9-d2fa-4425-2bdb-08d945e297dc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: devTJ2y1qH8GQdWAJSBgFkBnJFMhg8ngZvNUqJAw68FpDevxW+3ato3SyoPzbGJBWp5jnH4y4vyKyK3609PZZMjgZeDrBIajbO26kUJdTslBWRPe8sDHkJJ/f/UIUfrI2D222Pe42K3gvjpi+UfEKLN5jVnQxUdrpbx1ihTfgJk/ZFzewSrT0XdyW1cvEPi9AsBdz4yMaCljoXp2yQZs1lkr1qrqRzkzpnsOf8B3sgtBhP41X2LiBuMGpSj4Y0bxa6K5wHHsFwsoI2va4l8/j6rVcmxT6Y/MZdGcVAjEOF4bDFKA+YhHSZu9/SeeEsefSO6uG8UhFesj24jnSLHBM3wkxawkXgcfrnn/QJTGqE2xdy/i8wJEKJmd3/0ERzdRY4C0tJzZuzbbdNRd0LteoOIW4d0D8+ss87nhpRps7MbOmtdpxDEOAxz5imAygMRBWWHi0tcMckwS5Kf6MJybaOIVo2vM4OajYg7Cuc9vLQbDX+Q4jZE8Zz8mlUU6Jwajo2EDZ6youwhVXC+QwKpHTgkdXcsnVKP1jSca+y9ah2oPsVK3KS55Ld/uvZGc5chXLiC+24FGPY972KRCGgv40BrbsoSo8tyBq5p5Je+T3C8HjGrHVySizBHkSGpzbda93UIGOSBnXBAP/udAc//WbVjYiOEhDI6cL2uGdNowkn4p5uIMedU2Dzb92Xd1vfyFJuRoT6YSJedIzvrODdgXz/77GhOKGvf1JwvMGv1vz8qhHfQwEvLAwrJdGPXISpw/Mo81X8o5hb5+UCIcAozOCnkZQYWllP4h1EWhigUee17IFKKwGSiocj0hAmpwspl+
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(46966006)(186003)(82310400003)(5660300002)(16576012)(70206006)(70586007)(83380400001)(26005)(316002)(2906002)(82740400003)(110136005)(53546011)(36756003)(86362001)(31686004)(8936002)(2616005)(107886003)(336012)(31696002)(6666004)(6486002)(4326008)(956004)(44832011)(47076005)(356005)(36860700001)(8676002)(81166007)(478600001)(966005)(30864003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 09:43:18.7408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 784a24b3-b586-4d64-e038-08d945e2a551
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3954
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 7/12/21 5:44 PM, Mathieu Poirier wrote:
> Good morning Mike,
> 
> On Wed, Jul 07, 2021 at 02:29:53PM +0100, Mike Leach wrote:
>> This patchset introduces initial concepts in CoreSight system
>> configuration management support. to allow more detailed and complex
>> programming to be applied to CoreSight systems during trace capture.
>>
>> Configurations consist of 2 elements:-
>> 1) Features - programming combinations for devices, applied to a class of
>> device on the system (all ETMv4), or individual devices.
>> 2) Configurations - a set of programmed features used when the named
>> configuration is selected.
>>
>> Features and configurations are declared as a data table, a set of register,
>> resource and parameter requirements. Features and configurations are loaded
>> into the system by the virtual cs_syscfg device. This then matches features
>> to any registered devices and loads the feature into them.
>>
>> Individual device classes that support feature and configuration register
>> with cs_syscfg.
>>
>> Once loaded a configuration can be enabled for a specific trace run.
>> Configurations are registered with the perf cs_etm event as entries in
>> cs_etm/events. These can be selected on the perf command line as follows:-
>>
>> perf record -e cs_etm/<config_name>/ ...
>>
>> This patch set has one pre-loaded configuration and feature.
>> A named "strobing" feature is provided for ETMv4.
>> A named "autofdo" configuration is provided. This configuration enables
>> strobing on any ETM in used.
>>
>> Thus the command:
>> perf record -e cs_etm/autofdo/ ...
>>
>> will trace the supplied application while enabling the "autofdo" configuation
>> on each ETM as it is enabled by perf. This in turn will enable strobing for
>> the ETM - with default parameters. Parameters can be adjusted using configfs.
>>
>> The sink used in the trace run will be automatically selected.
>>
>> A configuration can supply up to 15 of preset parameter values, which will
>> subsitute in parameter values for any feature used in the configuration.
>>
>> Selection of preset values as follows
>> perf record -e cs_etm/autofdo,preset=1/ ...
>>
>> (valid presets 1-N, where N is the number supplied in the configuration, not
>> exceeding 15. preset=0 is the same as not selecting a preset.)
>>
>> Applies to & tested against coresight/next (5.13-rc6 base)
>>
>> Changes since v7:
>>
>> Fixed kernel test robot issue - config with CORESIGHT=y & CONFIGFS_FS=m causes
>> build error. Altered CORESIGHT config to select CONFIGFS_FS.
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> Replaced mutex use to protect loaded config lists in coresight devices with per
>> device spinlock to remove issue when disable called in interrupt context.
>> Reported-by: Branislav Rankov <branislav.rankov@arm.com>
>>
> 
> Can you indicate which patches have changed so I don't have to review the whole
> thing again?   It is also common practice to remove the RB tag when patches
> have changed enough to mandate another review.  In this case all patches still
> bare my RB tags.
> 
> Branislav reported the problem but he is not a recipient.  I would like to have
> a confirmation from him that this set fixes the problem he observed before I
> start looking at it.

I have tested this series and the issue I reported is fixed.
> 
> Thanks,
> Mathieu
> 
>>
>> Changes since v6:
>> Fixed kernel test robot issues-
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> Changes since v5:
>>
>> 1) Fix code style issues from auto-build reports, as
>> Reported-by: kernel test robot <lkp@intel.com>
>> 2) Update comments to get consistent docs for API functions.
>> 3) remove unused #define from autofdo example.
>> 4) fix perf code style issues from patch 4 (Mathieu)
>> 5) fix configfs code style issues from patch 9. (Mathieu)
>>
>> Changes since v4: (based on comments from Matthieu and Suzuki).
>> No large functional changes - primarily code improvements and naming schema.
>> 1) Updated entire set to ensure a consistent naming scheme was used for
>> variables and struct members that refer to the key objects in the system.
>> Suffixes _desc used for all references to feature and configuraion descriptors,
>> suffix _csdev used for all references to load feature and configs in the csdev
>> instances. (Mathieu & Suzuki).
>> 2) Dropped the 'configurations' sub dir in cs_etm perf directories as superfluous
>> with the configfs containing the same information. (Mathieu).
>> 3) Simplified perf handling code (suzuki)
>> 4) Multiple simplifications and improvements for code readability (Matthieu
>> and Suzuki)
>>
>> Changes since v3: (Primarily based on comments from Matthieu)
>> 1) Locking mechanisms simplified.
>> 2) Removed the possibility to enable features independently from
>> configurations.Only configurations can be enabled now. Simplifies programming
>> logic.
>> 3) Configuration now uses an activate->enable mechanism. This means that perf
>> will activate a selected configuration at the start of a session (during
>> setup_aux), and disable at the end of a session (around free_aux)
>> The active configuration and associated features will be programmed into the
>> CoreSight device instances when they are enabled. This locks the configuration
>> into the system while in use. Parameters cannot be altered while this is
>> in place. This mechanism will be extended in future for dynamic load / unload
>> of configurations to prevent removal while in use.
>> 4) Removed the custom bus / driver as un-necessary. A single device is
>> registered to own perf fs elements and configfs.
>> 5) Various other minor issues addressed.
>>
>> Changes since v2:
>> 1) Added documentation file.
>> 2) Altered cs_syscfg driver to no longer be coresight_device based, and moved
>> to its own custom bus to remove it from the main coresight bus. (Mathieu)
>> 3) Added configfs support to inspect and control loaded configurations and
>> features. Allows listing of preset values (Yabin Cui)
>> 4) Dropped sysfs support for adjusting feature parameters on the per device
>> basis, in favour of a single point adjustment in configfs that is pushed to all
>> device instances.
>> 5) Altered how the config and preset command line options are handled in perf
>> and the drivers. (Mathieu and Suzuki).
>> 6) Fixes for various issues and technical points (Mathieu, Yabin)
>>
>> Changes since v1:
>> 1) Moved preloaded configurations and features out of individual drivers.
>> 2) Added cs_syscfg driver to manage configurations and features. Individual
>> drivers register with cs_syscfg indicating support for config, and provide
>> matching information that the system uses to load features into the drivers.
>> This allows individual drivers to be updated on an as needed basis - and
>> removes the need to consider devices that cannot benefit from configuration -
>> static replicators, funnels, tpiu.
>> 3) Added perf selection of configuarations.
>> 4) Rebased onto the coresight module loading set. 
>>
>> To follow in future revisions / sets:-
>> a) load of additional config and features by loadable module.
>> b) load of additional config and features by configfs
>> c) enhanced resource management for ETMv4 and checking features have sufficient
>> resources to be enabled.
>> d) ECT and CTI support for configuration and features.
>>
>> Mike Leach (10):
>>   coresight: syscfg: Initial coresight system configuration
>>   coresight: syscfg: Add registration and feature loading for cs devices
>>   coresight: config: Add configuration and feature generic functions
>>   coresight: etm-perf: update to handle configuration selection
>>   coresight: syscfg: Add API to activate and enable configurations
>>   coresight: etm-perf: Update to activate selected configuration
>>   coresight: etm4x: Add complex configuration handlers to etmv4
>>   coresight: config: Add preloaded configurations
>>   coresight: syscfg: Add initial configfs support
>>   Documentation: coresight: Add documentation for CoreSight config
>>
>>  .../trace/coresight/coresight-config.rst      | 244 ++++++
>>  Documentation/trace/coresight/coresight.rst   |  16 +
>>  drivers/hwtracing/coresight/Kconfig           |   1 +
>>  drivers/hwtracing/coresight/Makefile          |   7 +-
>>  .../hwtracing/coresight/coresight-cfg-afdo.c  | 153 ++++
>>  .../coresight/coresight-cfg-preload.c         |  31 +
>>  .../coresight/coresight-cfg-preload.h         |  13 +
>>  .../hwtracing/coresight/coresight-config.c    | 275 ++++++
>>  .../hwtracing/coresight/coresight-config.h    | 253 ++++++
>>  drivers/hwtracing/coresight/coresight-core.c  |  12 +-
>>  .../hwtracing/coresight/coresight-etm-perf.c  | 150 +++-
>>  .../hwtracing/coresight/coresight-etm-perf.h  |  12 +-
>>  .../hwtracing/coresight/coresight-etm4x-cfg.c | 182 ++++
>>  .../hwtracing/coresight/coresight-etm4x-cfg.h |  30 +
>>  .../coresight/coresight-etm4x-core.c          |  38 +-
>>  .../coresight/coresight-etm4x-sysfs.c         |   3 +
>>  .../coresight/coresight-syscfg-configfs.c     | 396 +++++++++
>>  .../coresight/coresight-syscfg-configfs.h     |  45 +
>>  .../hwtracing/coresight/coresight-syscfg.c    | 829 ++++++++++++++++++
>>  .../hwtracing/coresight/coresight-syscfg.h    |  81 ++
>>  include/linux/coresight.h                     |  11 +
>>  21 files changed, 2746 insertions(+), 36 deletions(-)
>>  create mode 100644 Documentation/trace/coresight/coresight-config.rst
>>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-afdo.c
>>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.c
>>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.h
>>  create mode 100644 drivers/hwtracing/coresight/coresight-config.c
>>  create mode 100644 drivers/hwtracing/coresight/coresight-config.h
>>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.c
>>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.h
>>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.c
>>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.h
>>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.c
>>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.h
>>
>> -- 
>> 2.17.1
>>
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight
> 
