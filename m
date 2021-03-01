Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD4D3275A6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 01:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhCAAtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 19:49:03 -0500
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245]:51120 "EHLO
        esa1.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230084AbhCAAtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 19:49:00 -0500
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Feb 2021 19:48:58 EST
IronPort-SDR: LiK5QggWm65wFnfr7CEQ1K6iD2+am1g0jMTeqd+xJgm793ScoLbXYASLcpdQYkboZn9BGCSC6v
 oJ6D9//ZANyhxr8syPFSE3sOJfBeMCS0kRbzZoFFtGxmVhegP1k9oBzodwWzAyDNIi1r3BVh0f
 lnpHULi8zmH/5ze7q4e3n0lEaSQULbET4iFnrSxVfIqfLciSW190+AxleZtTXMmIPgPqEva3Jz
 E/X1zb2LX2uN814bbcfJCNzx1jHnZyQoYEckUKAiMG3itUTLFVPyRtxVRicHlQB9FAZGBK5SGW
 m9g=
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="35143670"
X-IronPort-AV: E=Sophos;i="5.81,214,1610377200"; 
   d="scan'208";a="35143670"
Received: from mail-ty1jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 09:39:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfhdaxuTk3a7L8zdZHGB3tBUrr1t1F2uqtqhUHtGAW6bYQxb8sc59tpZuOECeYHwAfqcw96P42H2PvWJMKbeDvfs6cbFM03fPOzSDY9WbuWpzzJMT8wycLXmWZsNijNZowHTtVC33TWJWbP5TN5EAR2jFARQ+NGl4kJdj/0YaFWB1LtcX9jseUhDe/r3WvChtMEJhIrzBJmfDtDrLyRNkCZJIWGwBp5PgWSF5yLOcGhP9ep6NtclXaZr6AREC3aMxinVjBEEjtR4fsCjcdqu7lSTKRhBey2npOzwKcKGWVnOeDbmqir6W9qiC3EVJ5PdxKbZMTOah2MxGHAsIgFrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6G0h1P7yua2u89QCT7N8Js22Z4MLdQIEXkFGoiY3QiU=;
 b=WLZkSP5sJEqnrChvhiJt9i9sL4/zqWZVYoP6Orfe3wYS3pXcnn3tKJwjwg3yUMPiTJwTn0esm64GrbZ29CfEi+b/QVo7vir2U60f/GVtDKTFduu7rm68mfR2Qhd9Gtf7HS7hwEhHhT3cRGmu0Hgj2BmrU8+DLBTXj3xNrSCUCbk6u51LHKhfjwrGqS39J5sTi+qJCi4UDl0y8zvILOnqaZ99oef08LEFbA/+QzkeAgSvR76OTMOdFF6hR9DWwYaKYE94K+Ve/UMpDaOtPq/QurK5yitHJNv8MZGF4XcsyDpRE6MDBrttBgCARcJhBUH/0guv/Rcv/5cc2GNMQCwA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6G0h1P7yua2u89QCT7N8Js22Z4MLdQIEXkFGoiY3QiU=;
 b=JrNFzl3L/ZMb7QZbhhAWCxXuemScGTn05SPf/t0YcXC799IfTSaXeKlNuhVbZ/6xPlcMm+QtfTwGB0hIGo/1GDImmfDEj/hBmGiWWGPGYPuh7iS1RmxR0pKwWMF1xQ/qiP6d4Tu5d3kic3XUBPqFGklfx0KyCa+WxIn3QWlGJTA=
Received: from OSAPR01MB4227.jpnprd01.prod.outlook.com (2603:1096:604:58::11)
 by OSAPR01MB2050.jpnprd01.prod.outlook.com (2603:1096:603:1a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 1 Mar
 2021 00:39:02 +0000
Received: from OSAPR01MB4227.jpnprd01.prod.outlook.com
 ([fe80::14f2:4ba5:2df1:c5ce]) by OSAPR01MB4227.jpnprd01.prod.outlook.com
 ([fe80::14f2:4ba5:2df1:c5ce%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 00:39:02 +0000
From:   "ito-yuichi@fujitsu.com" <ito-yuichi@fujitsu.com>
To:     'Marc Zyngier' <maz@kernel.org>
CC:     'Mark Rutland' <mark.rutland@arm.com>,
        'LAK' <linux-arm-kernel@lists.infradead.org>,
        'linux-kernel' <linux-kernel@vger.kernel.org>,
        'Android Kernel Team' <kernel-team@android.com>,
        'Russell King' <linux@arm.linux.org.uk>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Will Deacon' <will@kernel.org>,
        'Valentin Schneider' <Valentin.Schneider@arm.com>
Subject: RE: [PATCH v2 0/6] arm/arm64: Allow the rescheduling IPI to bypass
 irq_enter/exit
Thread-Topic: [PATCH v2 0/6] arm/arm64: Allow the rescheduling IPI to bypass
 irq_enter/exit
Thread-Index: AQHXDjCX5pcWkOnSIEuMT0l5BllREqpuRxbM
Date:   Mon, 1 Mar 2021 00:39:01 +0000
Message-ID: <OSAPR01MB42277439964B9E14D3AC94F18F9A9@OSAPR01MB4227.jpnprd01.prod.outlook.com>
References: <20201124141449.572446-1-maz@kernel.org>
In-Reply-To: <20201124141449.572446-1-maz@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19d2bff8-7d6e-4132-9833-08d8dc4a68fd
x-ms-traffictypediagnostic: OSAPR01MB2050:
x-ms-exchange-minimumurldomainage: kernel.org#8760
x-microsoft-antispam-prvs: <OSAPR01MB205097AEBFC2E08E872892C68F9A9@OSAPR01MB2050.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w5HIFt6HJvmWSvKOcsNNrt/44KosiopBW7aOhtQzNFostrgu1PH9IDl4kolVK3HN2ZzT7is5XMshQtaaK4ShvUZkxwSPyrsEnLv3KCfjn9CBkt62oZdvm+HZX84ekA3ldLmweikV5djaaiIdiEBd2ZrjQ9rNpfqRhCkNe/tDD1DY3QqQPSkY668g3qOhjpwgXdFMR4pKibFKy1JKy/d5OBCSzjo4MAHvP3wDKfrsO8jx/f4SoqvB0arRep6AkzPyU5ARxjZVOajgtDE2y/8m74ugP+MPyHT/hFXJ2OriHi+hblbp7SzyhtvVRSM+PrgO/YKoZdTuMgN5LKRpldkp4x1O7Ftxpl71Cx689QAAUkBDuWCm9mRh7N4p+Mv6/kZc+pVOfF75bPNZDbloP1KYErcGLuFgwJEh6Un9Ak/qocCPqa9YkQRpRrwTw4BDeqtRf/ZbvGwcmGlSFvnv/zV+IzF9Ag6ccusS80SMFa5ScwqpBh1tui+MQ1zJCvpg5vHJbD3NXTNbBByaqHfRnsLuU3tX/K59EqxxfZJ27tRUpDjO+AHQCvsxxqtv4QnFlnMTC8EeU9WE9ne41lJWn6CoI9C1/tpvYozLdcqh6IVAdkM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4227.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(6506007)(478600001)(4326008)(71200400001)(86362001)(186003)(7416002)(5660300002)(26005)(66946007)(6916009)(9686003)(7696005)(66556008)(54906003)(4744005)(52536014)(64756008)(8676002)(2906002)(8936002)(316002)(66476007)(66446008)(85182001)(33656002)(55016002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?V09RdUNab2lzTzVFOHFWOTJjYXZqb2hSOW9mWnhMM1NrWHJZTFF1WFhP?=
 =?iso-2022-jp?B?emdDWXczRTlCQll6R1JLS25wTkZydS84czF5OStzRjBkWUVDMGJNQ093?=
 =?iso-2022-jp?B?dTFrSWcrSE9XWW8zaVoreEk1NXdvNUpXK0llTWt1dm9ZWkljYVhKOU1R?=
 =?iso-2022-jp?B?TjFYVFA3YXp6QStWSjcrRlhlK1dnd3drM3VIY2F2Q2U3Y253UzArb2w5?=
 =?iso-2022-jp?B?S0VOVkZsQTZKZmtEcVRXYWhidS9vcituZ0cvNE9ENkVQeTJka1V0cStn?=
 =?iso-2022-jp?B?RmdDa0ZzMlRMbVlTdkFjVG4vbStmVTJIeStBYWs0Q3ZJMUZSSWlFYjIz?=
 =?iso-2022-jp?B?RXhncm4rWGVYOHRDV1F3ekVqSTdnNlh4R1Jpbjk2MXF2YzFQN044MEU4?=
 =?iso-2022-jp?B?K3BQL2JpMkZnVFJiWkRXeUZVY0ZmOWp3TUU0RDBDU2QrZFhMeW8rU1F0?=
 =?iso-2022-jp?B?bkxDZjNQaytOeFRqQ3dUWDYxK3NjVGZxak0rU1l0K3lOVFVvY25aSzVv?=
 =?iso-2022-jp?B?NnlMbW9WZnFyQ2NTa2JKdlVHUmZNZTFad3pMU3RIQVMrWk85R09BakZP?=
 =?iso-2022-jp?B?a2ZhMlpQNUtYd2N1dlEvdmFqTU91L2dPR1FJK0dLcE1nU2NYTHh0aXRC?=
 =?iso-2022-jp?B?VVFkaVYxOHV2SmhBRXJwcUUyRlZ4anNmV3BmUkVHQlNaYnVtYThzV2Ri?=
 =?iso-2022-jp?B?b1A4b2MxajFmQmx1WkJ1VEtRVWp1bGxZYnFQRW9lMGJELzhhd0RrcFFY?=
 =?iso-2022-jp?B?endaZXVMV3NnWVEraVR1anJaNllQWmgramRTZUl2elNDRjJZWTJVVWRp?=
 =?iso-2022-jp?B?eXdVVVlLTVFzWFJnaHZJQUkxNFFlNC83TWtZY0tPY1owVWd0YkJlSzE2?=
 =?iso-2022-jp?B?Y2lySVdNcjMrOGE4ZFdwSGpFaklMK0VPRXNYQUxZMjc0ZFdBRVMwajRN?=
 =?iso-2022-jp?B?T1dJNTlxd2Rtbmg4NHlDSGtFUkRyRCsrWkQ3SkRPbDNzYUYvSytlV1ND?=
 =?iso-2022-jp?B?cERseVNKT3gyWEpMVGN2RWtJbm8zK3ROV0FBRnBjQVhUUExzSm13cGJt?=
 =?iso-2022-jp?B?U09GdGFwSzVKU1hWTFNFNFlWYitKQ0xzQnllL013dTg3RlVyRmEvQ1Vw?=
 =?iso-2022-jp?B?dlg1RFFodlYra2lHVnErU2lLRXlGcXdGZmx2V2hiT2RuWUFIeGR0aFVN?=
 =?iso-2022-jp?B?MEdxUCtQSUVGVktwZmtvWE1pU1BET09nOUF0bVNWMm4ySWVvRXBCanB3?=
 =?iso-2022-jp?B?SWs1cm03T0FmanpjclJRUGlEa2I4aklpdnVIbXZYM05HMVRYSGRSd0ZE?=
 =?iso-2022-jp?B?VnFGMWplMTFlZ2hyQkwvWVc0TjNNemdYTDdMaVE4T04xMVl5RDhJU3Zw?=
 =?iso-2022-jp?B?VjZhY3ZyVXROeE5uR2lZVFdiakl0U29HTXlBWUlscFp1V3RkVnk2OVFx?=
 =?iso-2022-jp?B?enFBMkVIaXZwVHlZT1ZUVDBtdkF0ZjRUZnR4NmNJTWhjbjNUcWhVTm5F?=
 =?iso-2022-jp?B?dHNwVzhMMWN2em5qczIwTWROWWJrSXc4b2JNVUFxSTRHQlJLc0J5dzJu?=
 =?iso-2022-jp?B?aTBDeVZPSURSak5wVjkzWmdFZnprUlQ2cGNHU3JrVTA3S0ZMdjlzZ2lI?=
 =?iso-2022-jp?B?ZmYyYVEwN1JjWE5yeXI3R2VZbmJkS00xZjRTei9OSmV0eTRlUkpsZytO?=
 =?iso-2022-jp?B?SlNEUjI5NytwSFdQbWNORzBmWUFObWk0OHFzVU9helZRRnRDRk1xV0J0?=
 =?iso-2022-jp?B?ajBIZ2VxTFJOVVZpRTdtL3dyb0xMUjdudE5INmk1Z0llZXJoOS9uVkJH?=
 =?iso-2022-jp?B?a2h5WDdnYjhuWlRQRHp0eG8yR3c1aG9HamhIdmcxTEplL3lPcmF2endV?=
 =?iso-2022-jp?B?UENsSGNDcWJWYzVESkE2TU5DSlhZPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4227.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d2bff8-7d6e-4132-9833-08d8dc4a68fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 00:39:01.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBDldSJmrG5EbFtcs2mSVKNoF3xTZz/PpyvW/tButPBw3NF/fGTY5kJ2zb+SHYMFIUsBVFkC2eYCHHDQtxTuE7xFYfwXDOSyeJhciuXGzk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

I plan to add NMI patches which enables IPI_CPU_CRASH_STOP IPI as pseudo-NM=
I[1].
But I know need to resolve the instrumentation issues before that. I think =
need to moving arm64 entry code over to the generic entry code(kernel/entry=
/common.c) for that, is this right?

Can you tell me current status?
Let me know if there's anything I can do to help.

[1]https://lore.kernel.org/lkml/20201104080539.3205889-1-ito-yuichi@fujitsu=
.com/

Thanks,

Yuichi Ito

