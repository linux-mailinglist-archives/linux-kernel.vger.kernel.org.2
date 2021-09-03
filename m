Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575D43FFCFB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348770AbhICJXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:23:08 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:47222
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232257AbhICJXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF/yaBI3RKlaFS20UZZEYLCRMlUoUmfuwOXEC6ImRzY=;
 b=wvBU7qgSaVSv+Y+A4nCvSgWlBFRRDOrR9yfu+B0ogxNNn2VUbceX+lLMmuOf01EtIcw6QIMVSvZ9nxYhpFYxWxnx+uvzVeA9r8P6SGe6utLP6KZeeKxRBCCtSchwFwhJH9tSq8Yv+CpciJN/ruse2Yp5Ziq5r1aGF1QtWBKLIwo=
Received: from AM5PR0701CA0060.eurprd07.prod.outlook.com (2603:10a6:203:2::22)
 by DBBPR08MB4443.eurprd08.prod.outlook.com (2603:10a6:10:c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 3 Sep
 2021 09:22:04 +0000
Received: from AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:2:cafe::69) by AM5PR0701CA0060.outlook.office365.com
 (2603:10a6:203:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend
 Transport; Fri, 3 Sep 2021 09:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT045.mail.protection.outlook.com (10.152.17.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 09:22:03 +0000
Received: ("Tessian outbound f11f34576ce3:v103"); Fri, 03 Sep 2021 09:22:03 +0000
X-CR-MTA-TID: 64aa7808
Received: from 40d249bcf2ef.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 01FDF230-551D-4AED-94FA-2F11ED832E00.1;
        Fri, 03 Sep 2021 09:21:52 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 40d249bcf2ef.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 03 Sep 2021 09:21:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhPanh0CHibkqpeJBTvnulOyvhPZojjFcyQEs8owo01X+R4kRXH/acNOKWGt8EZFFP0wiCeI9IdEl51rU+tGxlOrc+z0fWGL0Tu/tb9hP1phq0AofK3eUL+8fCrvvwBo3hZuOL1AHIm6RXy0jCJaPC0eyd9J+wTqDJkIh1Uuzs9iLjtpOAl8bN1Cmhj6pR7avKYGEpflGLWKmZiGIU/dq3NhoJ+Up3o+MR5OaQjACgi2K4o+A7FSsY6/XDnFIeFJx+tWKtaCPHsiggd2ELxV9dijHYJB3Ese1PDjMmgxaWJmuDN+COlcaZPTDJ3yBJ8LXJlDkzA+7I4mssMhqDf1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IF/yaBI3RKlaFS20UZZEYLCRMlUoUmfuwOXEC6ImRzY=;
 b=JFjZx67Ui+hdK4Rez7VJ/QmeugkvfrK/tuRdgpBvHEm8XxuS0fkB8NMr/JA9qDfrPkmvQzO2La4DYaqiB+IOx6qBHc7F4iGlTTASTH31cKNZWsFp5XZjCUrigIB+trHhOiRqcis9hK4aNP/U3ykmfgkDwY+LZVrBbCFH7Ri6xSrj0Qf1TwsQL+v8xs3145muVm2Eh/7Yzg5knl9kPJRCs6zCibcdDYoSzMdhVADOc8JzYuOF5F3IfMAwfYXomsmu6/sPuktG38BsRlxMQdzTxMZduY5J+PE+mBDIgGY8Jx2UrYsOpEsgIc9QJW5/iy6dmTV0CrOdKtsdav1lWSxgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF/yaBI3RKlaFS20UZZEYLCRMlUoUmfuwOXEC6ImRzY=;
 b=wvBU7qgSaVSv+Y+A4nCvSgWlBFRRDOrR9yfu+B0ogxNNn2VUbceX+lLMmuOf01EtIcw6QIMVSvZ9nxYhpFYxWxnx+uvzVeA9r8P6SGe6utLP6KZeeKxRBCCtSchwFwhJH9tSq8Yv+CpciJN/ruse2Yp5Ziq5r1aGF1QtWBKLIwo=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB5016.eurprd08.prod.outlook.com (2603:10a6:20b:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Fri, 3 Sep
 2021 09:21:48 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::a443:3fd9:42c2:4b85]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::a443:3fd9:42c2:4b85%5]) with mapi id 15.20.4478.021; Fri, 3 Sep 2021
 09:21:48 +0000
From:   Justin He <Justin.He@arm.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     James Morse <James.Morse@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shenming Lu <lushenming@huawei.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] KVM: arm64: Add memcg accounting to KVM allocations
Thread-Topic: [PATCH 2/2] KVM: arm64: Add memcg accounting to KVM allocations
Thread-Index: AQHXn5F5LaBhMNeZaUatlmkgbJxAuKuRDNoAgAD+FKA=
Date:   Fri, 3 Sep 2021 09:21:48 +0000
Message-ID: <AM6PR08MB437698F3753375F73F8748ECF7CF9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210902002801.32618-1-justin.he@arm.com>
        <20210902002801.32618-2-justin.he@arm.com> <875yvix2xn.wl-maz@kernel.org>
In-Reply-To: <875yvix2xn.wl-maz@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: EC71F66BF124C5409252E24E66C875BC.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ada6cdb1-5c75-441a-e784-08d96ebc4ad1
x-ms-traffictypediagnostic: AM6PR08MB5016:|DBBPR08MB4443:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB4443DA9C06CBA45813E78310F7CF9@DBBPR08MB4443.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:4941;OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: DDrs5rYvc3zeVI7NrXkA92hKeBaKYTikoY0ZlKtG55IgOvJTf3T4A1SrhadnTbWmiccAQ9v1YjWiuphdntvyf+WYYJidZNM7HM4NuGdC/bg5jeaYpH8JOt6wW6X20xaQuX0lJbuSb4sX2INbqQtUq2OAHZburxTSXhFUUH1PtTAHWQHjER2aC6hxxiqVhiAGJC/ooHcWBF6bWJbm+BdLaB7QqrZD5j+3kk3UeBONpD7CuCk1KJs2OLUZMyNdSbd54JEQ9hPG01t8fzqB5SjJNeutpzbg4EWOcKBBqenh0PZHX3T9PvpPb1o88WjIko/R3+5WE5EwcKAkEAo4LIlPAXIm3Ju2Jk8aZAhU20y47smKZnDFORRqkBKAAIpZt95RhF/Qgh3s5fW37iWC4PdS1tCwRqiJjzONyDPDShhw/TUGb8ZCmHR4CrEyLfXnIy7mSj+TvTZpNpv3hF3U6xTB7+WL5rHt3kKMZz292JIDYexUDixLdgTWwh41I4etp15cdkQq0EL1GieEwa9YDR5WxKsZmFQzav2rkbwZChgzmyiYi5mExtgu/l98at7ff36Gl6In9c7JL1Fph9sCYsh0q4hW36uV+SPE7EWHDpPNNHKGY4/zuqEDyBbT3AGJaaNzmx+6MnjTMaffQ0/LlDyZEZkIMJpa5tcdd6YmuSTa9VBbTVwTirbqkmGxpON90JTvW5T1/ZL7rPytFX6FXH7NNA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(396003)(136003)(366004)(4326008)(52536014)(71200400001)(122000001)(316002)(7696005)(15650500001)(5660300002)(38100700002)(7416002)(86362001)(8676002)(55016002)(8936002)(9686003)(76116006)(6916009)(33656002)(54906003)(53546011)(478600001)(66476007)(66446008)(66946007)(66556008)(64756008)(38070700005)(83380400001)(26005)(186003)(6506007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s93Z5u3LGGAV1yZhifBhTlhIPVJWfMVSeqfuhUk2Igu6gLbG2B/wqRZaAO14?=
 =?us-ascii?Q?UkQJ6MZpLJya00Fk38ORuZAayF1IXdNCQAD0qo8m5teskO9GpsDHhLkUWKM2?=
 =?us-ascii?Q?O5rnh7Qvu5K+A9YRQlxMNFsfQDKCOoR282ShSDYbqPHc5U0DSoaJUsLxrdd/?=
 =?us-ascii?Q?dO/gPTddw1aJpnNGDQLpaR9t6guvmQsl3TrllvXXPD9BBUk1BBgKyp5ESFou?=
 =?us-ascii?Q?uR4xuK8h5jjzq2ZpAbOtB5BICooLTEwcbstpuWKyGcxgFJCJIoSBMhlBbMx8?=
 =?us-ascii?Q?uicabbAQA+IfzHXrqXSuokDFgpSyRxDiEpRVD5hnM1CP3VoWG15Se8cC0VA+?=
 =?us-ascii?Q?vI4RMt8RasEVJwpuVr+VFgQxxu0ytOze41Ayexi/wAmx28YjXfFfUGceebSZ?=
 =?us-ascii?Q?QTD+ytgiVMfu6E5E6jgj9/YqLQYFuyWg5VlIv7cQ62Kut8g0Ny8EBpFSuh56?=
 =?us-ascii?Q?erv1oO9neN8GEpHReDRxraAes9rDn549o/ptTR2MxrPnRRiODMR8At4fZtkJ?=
 =?us-ascii?Q?rOkiSRGQpRmzQzPv8CzpSVyc+VqRSgb48CXzPMGwoV9lhzKjLHJuPrq1aAbl?=
 =?us-ascii?Q?3kzzEtdPqFYBo59kpx9NyVWjBqmPkGYsilnnHZ8lKNP/VY8c2TFWII1tJI9K?=
 =?us-ascii?Q?1a6ZvDhSUvr1wBC0txagDRPzzSsDF5C5IDry46hbOeGQ+tW7GDLfPHdQiZHC?=
 =?us-ascii?Q?JvxE4FXyQ/VTUlM0mOcu+RIi4BvT/A9jxCQfoOj8ul2M/EnZPz5YD6RcUJSy?=
 =?us-ascii?Q?bBhKnUhgAxP8iTmY2fCqlZ5Y4YrIrvTsjqxKnwtIT8s5Tz52/sKUzYmhh5pT?=
 =?us-ascii?Q?Tyxwe5MemNpV1z27ccsXeDDKOVVzU3xG+OSoE0PKW0WTBpHAjj8o4jY36cop?=
 =?us-ascii?Q?hqboLJiZrZksL++bcSkNzJ03LAHrtk1vikiD8IdpQOc8KsdlF56v2WV68tvz?=
 =?us-ascii?Q?rRBT1aaxklyTS4mOZeKMxlumPznP2Su/iIOoueIJhhoi+ljqYEIAmKw7jxJb?=
 =?us-ascii?Q?fCCLYlM4FOIjkb3bqAXceWZtqKmCEghtiI7HwPENBH+xkAU1wEbEY60WnqLI?=
 =?us-ascii?Q?dxNLPmXvotDCj5AjpBi9ZrPxvvcIzddFC/fBxBpBVVS2qq21M5hoqtb4yvyX?=
 =?us-ascii?Q?COxZnF/54Os0V/ztVxsN+kSPJCv97lpx+MXrezS2La0NDRwIdcZGn3mB0OJa?=
 =?us-ascii?Q?K14K8YBneNov6khxcnkAH34QkZOqZem06lotrE8orYDKICXmq7jEMNaM8Hw8?=
 =?us-ascii?Q?h5C3dh8+PgWz5CViJeLV7CC4P5KVnK4fMdvtxAnCHmtoVdtm0iRWvQzFHxW0?=
 =?us-ascii?Q?MHQ4W1oIaM94uv18GqvsIO6S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5016
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: fb3172c8-7ed8-480d-2990-08d96ebc4194
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcNhf0VDI0E9t5lwMMmNH0sE+wTFRhDdRGii0bWvd7zU9VD/r8dUK+sipgOe/4Avr1ZysLN8xKEm1XSf1n3CBiRlOqHDvxp36VMVxKJDkPBCUKX1uwJ/xWXrUI5iwD18CRruFMahuXyecNuq+dDubvobFvXBI85JvJu8TBRfpee6Wxz0iLzLrbEqVtmQRmvo651gTPwAV6CsAeUZAw68sOZrfCM0B6dm1YDxa/iibyJ9GdimyI80GFUp0QBuAWt4q/1LcKq8Gn5Vcvj46aARmKZHO0joYMiG7cFzUgdK0/f8U1hHx2+jOKs4S935nQfmYMTzAXw69B9q/zG0vetyGhKXzwuCDa0uq/yqYapz/4GYkk+Nu48G7ImNo4Kh/5LnWGjnTSRLTP3kuSUsERFgGDqlY36OZSENpX6/azRvrHqAGbPIObAG/CGxlhwyyNCz9mZJZmbQA+qeudYA6F21pPmpeWQ5WZzU67y5cfsg9ShsVJsJIcBVUV486G9tzxkk4+YjidpTArWkR/q0jIIYb6lB5QWLIeGGuOKN9GfsV4hpOuME+9fqPRFR+d7E5P3OpJ9ebznh/8zxC9ESx4uBaLpNFOMha3c9pyE7tEch3Mc+EB7x2qMjZczautQc9FM59679M/98LybB/DU3h5uLPMnpDyJO1CqYcJkNDuy12KgwL8ZlwJzHe+P6R+HiGHtBjD1wozlMMZ/YbkXeqdfW+A==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(36840700001)(46966006)(53546011)(7696005)(81166007)(70206006)(8936002)(52536014)(336012)(55016002)(83380400001)(478600001)(9686003)(6506007)(54906003)(186003)(82740400003)(6862004)(5660300002)(47076005)(356005)(2906002)(86362001)(33656002)(8676002)(26005)(15650500001)(36860700001)(4326008)(316002)(70586007)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 09:22:03.7004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada6cdb1-5c75-441a-e784-08d96ebc4ad1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4443
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Friday, September 3, 2021 2:12 AM
> To: Justin He <Justin.He@arm.com>
> Cc: James Morse <James.Morse@arm.com>; Alexandru Elisei
> <Alexandru.Elisei@arm.com>; Suzuki Poulose <Suzuki.Poulose@arm.com>;
> Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon <will@kernel.org>;
> Liu Shixin <liushixin2@huawei.com>; Eric Auger <eric.auger@redhat.com>;
> Kees Cook <keescook@chromium.org>; Nick Desaulniers
> <ndesaulniers@google.com>; Shenming Lu <lushenming@huawei.com>; Sami
> Tolvanen <samitolvanen@google.com>; Lorenzo Pieralisi
> <Lorenzo.Pieralisi@arm.com>; Xiaoming Ni <nixiaoming@huawei.com>; Zenghui
> Yu <yuzenghui@huawei.com>; linux-arm-kernel@lists.infradead.org;
> kvmarm@lists.cs.columbia.edu; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] KVM: arm64: Add memcg accounting to KVM
> allocations
>=20
> On Thu, 02 Sep 2021 01:28:01 +0100,
> Jia He <justin.he@arm.com> wrote:
> >
> > Inspired by commit 254272ce6505 ("kvm: x86: Add memcg accounting to KVM
> > allocations"), it would be better to make arm64 KVM consistent with
> > common kvm codes.
> >
> > The memory allocations of VM scope should be charged into VM process
> > cgroup, hence change GFP_KERNEL to GFP_KERNEL_ACCOUNT.
> >
> > There remained a few cases since these allocations are global, not in V=
M
> > scope.
> >
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  arch/arm64/kvm/arm.c      | 6 ++++--
> >  arch/arm64/kvm/mmu.c      | 2 +-
> >  arch/arm64/kvm/pmu-emul.c | 2 +-
> >  arch/arm64/kvm/reset.c    | 2 +-
> >  4 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index e9a2b8f27792..9d6f5bcaddef 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -289,10 +289,12 @@ long kvm_arch_dev_ioctl(struct file *filp,
> >
> >  struct kvm *kvm_arch_alloc_vm(void)
> >  {
> > +	unsigned long sz =3D sizeof(struct kvm);
>=20
> If you are going to introduce an extra variable, please use the
> correct type (size_t).

Okay
>=20
> > +
> >  	if (!has_vhe())
> > -		return kzalloc(sizeof(struct kvm), GFP_KERNEL);
> > +		return kzalloc(sz, GFP_KERNEL | GFP_KERNEL_ACCOUNT);
>=20
> Why both GFP_KERNEL and GFP_KERNEL_ACCOUNT?
Urgh, sorry for the mistake.

--
Cheers,
Justin (Jia He)


