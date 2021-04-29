Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A47B36E838
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbhD2Jvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:51:55 -0400
Received: from mail-vi1eur05on2046.outbound.protection.outlook.com ([40.107.21.46]:2336
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231722AbhD2Jvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frTri+Q7NwGbx3odiHRi+fbuK4TRlZv9JwiBgimW/XI=;
 b=H9ZxjKJFWUY0XG/GmYGky7+IwFAqjluMvM+AhzWYyYbxCleqkfTmhvtqRTaIyDcbaFWSHR35a0RgPbqXZ6e/Pw76G+rH/uWEKE4IcP1YdMr06FWFgXNRwYRdrbwqUCJWEp1MgQXf5IEesjKhAK09KMw2QDg+i+sULMnHegmkH8w=
Received: from AM6P192CA0033.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::46)
 by DBAPR08MB5798.eurprd08.prod.outlook.com (2603:10a6:10:1a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 29 Apr
 2021 09:50:49 +0000
Received: from AM5EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:83:cafe::69) by AM6P192CA0033.outlook.office365.com
 (2603:10a6:209:83::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 09:50:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT041.mail.protection.outlook.com (10.152.17.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 09:50:49 +0000
Received: ("Tessian outbound e566ed09e411:v91"); Thu, 29 Apr 2021 09:50:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a42d2b56714297fc
X-CR-MTA-TID: 64aa7808
Received: from 9129948de33d.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FA6A4ADA-A39A-4EA9-A47C-5EFBAB5CF67F.1;
        Thu, 29 Apr 2021 09:50:38 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9129948de33d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 29 Apr 2021 09:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSWWFNyPXiTmyJPKDG3mENlG1bVAiVgPul4CbqKGPsqRyJK8HEEoEr7jW4ujUPcE6n4W0+YgRYw02nq82RBU4bbt+aktf5g31OneA7ghSWFhVFPvlmMgcuKjbbkm9CIWyd/JSxk7jthFgXWES+ccJUkpYp6qxZWnWSASMsM1st8Bw6MAZljOR/LfpaqVpCCVEsKP1VbnFuvH7Yj0A19TYvaYJCPbYhuVJvbrNgs6jffQNwuSCM0tF/dbuWVtHc0XKnbG6dDaJpYvpnz/nGxVf+sGhlrK/p1MsypB6rvaScuropMul/fbHS/m54cXYywSgUwo7zNY4jNH5xswjggfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frTri+Q7NwGbx3odiHRi+fbuK4TRlZv9JwiBgimW/XI=;
 b=oWwdY8NlvpmeQbd87Xn0dZe1QHMcK7xv7S1vR/JwJWAUaO/+nEoZZ668gQhc7kVi+0LefIv1SBby0hLjPU7dNKqmFxzE0NkQ9yEMMPXx9BFGEAluAHzyNd8sf/1mXPzSl821GAWuEInEdfcAMGbkXt7cf3bXCns3TOEa5cdikONKewffPnHVu9GYu/wnAIXujLQ993yEwOWKPGzqKBlyajtwIdPyErZRdWFKHA/C8cIKbMInC6Cexv68Zru7fHHD5/iAXYmP2nHuPwG7oUjKdcw37/OtKkkH4DyOi1n4K02iBtRZ2bwONWcZTvq4j8l2nNC2axJeFnjezgzMEVjImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frTri+Q7NwGbx3odiHRi+fbuK4TRlZv9JwiBgimW/XI=;
 b=H9ZxjKJFWUY0XG/GmYGky7+IwFAqjluMvM+AhzWYyYbxCleqkfTmhvtqRTaIyDcbaFWSHR35a0RgPbqXZ6e/Pw76G+rH/uWEKE4IcP1YdMr06FWFgXNRwYRdrbwqUCJWEp1MgQXf5IEesjKhAK09KMw2QDg+i+sULMnHegmkH8w=
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
Received: from PA4PR08MB6320.eurprd08.prod.outlook.com (2603:10a6:102:e5::9)
 by PAXPR08MB6880.eurprd08.prod.outlook.com (2603:10a6:102:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 09:50:37 +0000
Received: from PA4PR08MB6320.eurprd08.prod.outlook.com
 ([fe80::c99f:671d:bb2c:f20b]) by PA4PR08MB6320.eurprd08.prod.outlook.com
 ([fe80::c99f:671d:bb2c:f20b%7]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 09:50:36 +0000
Date:   Thu, 29 Apr 2021 10:50:28 +0100
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
Message-ID: <20210429095027.GR9028@arm.com>
References: <20210423205159.830854-1-morbo@google.com>
 <20210428172847.GC4022@arm.com>
 <20210428174010.GA4593@sirena.org.uk>
 <CAGG=3QUATefn9AG+HvnCfEOBv3iRu4fzFwfmA7Djrh2CmP_weA@mail.gmail.com>
 <CAGG=3QUNykCfkS22g+HRWb0Goa8DJ72TUueLtMe5v1YfnStojw@mail.gmail.com>
 <20210429075454.GQ9028@arm.com>
 <CAGG=3QV0kR__23yEmwwXBpcE1gvjLqRNmF667hhVeY0B3urTqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGG=3QV0kR__23yEmwwXBpcE1gvjLqRNmF667hhVeY0B3urTqQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.55]
X-ClientProxiedBy: SN6PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:805:66::38) To PA4PR08MB6320.eurprd08.prod.outlook.com
 (2603:10a6:102:e5::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by SN6PR08CA0025.namprd08.prod.outlook.com (2603:10b6:805:66::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 09:50:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc9e7f12-1576-4e0f-f1d5-08d90af444f2
X-MS-TrafficTypeDiagnostic: PAXPR08MB6880:|DBAPR08MB5798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR08MB57983E9E08252DC8AD89F6A9ED5F9@DBAPR08MB5798.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: oNUiSLVFShThHfbG4csoCuBauPnIkRuyPSUkNF9No/e5Uk04uFj4po36qvIDIwJufUHd+8/AW7I/Oz1DImuzJFSCbkTw+F1K0qj7kcR/VpVYpr4PyauExgRKDLsmNSMy05/eD3tOrb2f2bG5G4lGqnKOmoZwmY3oc6xRtmyXNaxyceo+Muzolxy5sXgSDSMk5gI+Bc7NZrGlAvXhTr9raVyi6FX7+H34V3Nab+rHjWlToiYoWFn3UAmFtQ1xpyOz5EPf7IJ84QVs1DToqowlchoZPb17BJmXNI09w+xf94SM/LTRpser6iC5r0i1EwFCgn+KH2iOwy4YYTtpn5FA8mtgfdDO/Lw9plta+Vf7VOt/NabXSsnK6DVJkLUJbqNq+E6K5CIZPi+jmvFzSKF9JZCopp8lKe2BxXNvn40XsXcGL6kXXL9aW9WaLZQ5oCnGgkyXEqTkkYlktrUG5QUC5vuHDT+qmil2F6saypriS/CapzdzJ34QiUpSq1IJqAydmLmN0oA+V7czy4a9qdmJqtMFG8kLoCtXq4Z7fEynV21rG2PNlj3jNedRvOiIU1x+Y4TKSZkwbS2LfRkyyvDIMrCTcKye8ccHCrC1GJXEgH79Md7BNIK4gHquXzcuZ44M+j407jrPQGqTipnKvmGs0Epl63B1i6ZcujplBMczCgGAWtX/BuRe44+2MnW6ZISvTahUIsPJjXy1RtX9Eg9UYa7i3mnGklXskRk079DCuIZHVagjJ0GAIIId6UZ7jr54
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB6320.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(1076003)(86362001)(66556008)(5660300002)(52116002)(66946007)(66476007)(6916009)(33656002)(8886007)(2906002)(38100700002)(36756003)(53546011)(7696005)(55016002)(8676002)(38350700002)(8936002)(478600001)(16526019)(956004)(316002)(186003)(54906003)(4326008)(6666004)(44832011)(26005)(966005)(2616005)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ck1QblhEaXFJOHVXOGRoMTRIT2Y5cjgvSlg0Qkt2bDdtcGZJWitLa3U5OHdS?=
 =?utf-8?B?bGNPSDNOa005WVlYbTFlSTA4MHFYcmZnZE1Vc0VXQzc1R1dSVkJpOGpFK0w5?=
 =?utf-8?B?U3NsT3EyVVNYVEJ0bzFETDBGWVlLN2VXRWlUZEhHZGYzc0xoSjBRSmxTQzBY?=
 =?utf-8?B?SFdFN0pMbHlYeDU0WmRJWmc0Y1hHTFNUa2MvMVpsN056NmtJbUlCR1F1RWhI?=
 =?utf-8?B?RG4xUWlIZkdacUtQOVVvVlFZMzVLTVNBL1ppdEpOM3RnRDRRVjdTYzhZVWg1?=
 =?utf-8?B?aTNHQkNKQUo1YTJLSkRzMG54cVBBY2luNkFLZ2NaVVRKdlZYS2xuQnNQQm5O?=
 =?utf-8?B?WUtDVUZoUGdFUFdyRmV4Q3hMSEd0YlY1Y081KzFSSFNWYkUyS2YwWE1kUUox?=
 =?utf-8?B?V2tTb3JhZVY2ZnB4dDBtN2wzK21qbVpYTWNkbG1UYmQ1bnpvQmpSWk5LeGRa?=
 =?utf-8?B?bDJYVTJSbGZkcXRKK054ZDZXYVdVTUcvUk42SUVjaUJXUGZjMGp4WFdTeXdW?=
 =?utf-8?B?Y2VtRnVUa2ZVOEgxbWF0SWdRVFBKQThjLzVZOEFCWXlQNldxQWhKaDFCYjk5?=
 =?utf-8?B?a0FxTmY2V25ZSGxLeWxoQ0hDdWgrNXgxelNnNEJpdlJHQ3RhbVo5YzQ2b2JP?=
 =?utf-8?B?Wncwb2NSMDVKQVdLQ2FRWXhEWm9qc3FNZlIzTHFIaUY3ZW12WGlHTDZSdTFl?=
 =?utf-8?B?V3Q3bDU0V0kwUytxT3lIQUROaUU5b1VUTWZ1RVlXSmJxbDljV0NEZHovY3VW?=
 =?utf-8?B?OVpPT3g4WnJSd1ZVZWFRSEVGM3ZGeCtPd2VoQTRXcUEyL0ZPNlNVMXNqZXFv?=
 =?utf-8?B?RVAxYlREczRZcVlxVmRtM1BodlZGSVFnOG13VTVPcVM5a1lmNlh1d3ZKRzd0?=
 =?utf-8?B?U01kajR1eHZuVWQraDhJY2NMcDRZK3N5U2MyYWFMbGQ1Njh0cjRuNTdZZmpT?=
 =?utf-8?B?cUpPYjF6aUNndmtHdHpUZjdFTHdEMzVkQXJrV0RETEp3S3JqK2tLRCsveHU0?=
 =?utf-8?B?dUs3UkZPU1J2STRWZ3dyVmNUdzRJcnNPMXRNTnFDQk5mVHZDaFhzZ2J3Mk05?=
 =?utf-8?B?UmtQUXlFUXAyWkVGVUpUZk4wM3FOcEtnT2p6QnlEYnF3VUpnNXhudDQzYmQ5?=
 =?utf-8?B?NHJkbjJ2N2VFa3RGSUhibDg5ZFpDandOdyt4Yjc3Mm1YUkUxa1ZnYk9va2xU?=
 =?utf-8?B?NHNZNWVrZUF5NHJEN3R3MG9TWWd4aWlJK09iQm9qVnM1by9XTXpHTEljOTk4?=
 =?utf-8?B?clNHWmhDRUpMQlplYmxNV0g0cjFxZW1DeUgydHBlQTBJUHRrMis1M3VaSzlR?=
 =?utf-8?B?WUp0STlTWGFZcW5sNXhtM1JnWldJMmV0Ymk5ZEFYZlNyVjVjOVdqWTRRVFhr?=
 =?utf-8?B?RUplUllORG04V3VUeVJyYWQ0VmVlelczMDA2YVM2MW5rVGl0ajlyQXRQekVX?=
 =?utf-8?B?OXZRWHlUSzBhb3l0aWJDUWNsWWl2TExvUGt4WXFDSFdPQnU5V3VZR3AzemRw?=
 =?utf-8?B?bEhQWTVUN3FRWHE3RWdxOXZOOFJtcVRJbWJiWS9GTEtraW1sQWZ4a1MvekRY?=
 =?utf-8?B?OWFzcWZ3Qlh5blh3TlFnUFpBZDFHa0VnWW5KWERBU1F3OVdXNlF3SmZ1ZFFj?=
 =?utf-8?B?R0lJZGhLK3RkZUZCR0NjL0Q2aXNGOUVUYUJCeElGS0srWWN3TFh6a1BnNnFt?=
 =?utf-8?B?N09ZOFdxcTBLSnlSR1llY2ZpT3dLSWZFWit0Q2hxcktYUmd5NjVZRS9RWXpY?=
 =?utf-8?Q?YXC2Yhw0iG6vTpszG/4/O5/lCBudW4y0PcSn+KP?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6880
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d90ec4e1-f9b9-4233-bee3-08d90af43d27
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUXf15cHhpjXIHnEUIoPMTMsiTqd9wx2VzWEQkEmLYi3su4QkYXy58bqqPIKvTztDBj0TxrMiB6ga6L4+9V7xpA+k8UlSL5tvWQ5j5j5RClg978eFXZNwAsvmaD3xyeLd1HNyxBim31ew/uwPcAx+D/yo1RaCk92QdcbOcPzL8U9NGd88fbzbfrv49ZP9TlgUg3rNoopiGfidmeNH7NFNjIfsG85wwp7+yaVLEJ2ySWMaqR3puef2dIi4QHjmrkRqQl9pzUWHm187xlJ496qbZMxwrxsML81cC7tCUJhV13Ev1JXinWiTQoPGRrD82hYBFxdZ58mUrz3e1FK75g7wF5Z6t/QmPmlz5Pliw9JoAtBMw0vPMAIkTupZsO3BNiGCbHg4J1TDDauP+pOatjxVKIC6oORpdGGnO/tDtkLnyd6MueFRrUJf51XcDUqY9RFLlnx6NJc50fvSBYBnXQ2lhnnGIFre8hvCDBpvGIv+xdHkUCx+kYfPT4lWdq2oqFijIyGWtSPzjyMtjuhd5yk7YOOwZDmZDD3mq0ofV6VQeen6mevNoZm+8uxL5AnMP3qfpeGziunLPq5Baarxa8QOn/+BBdXaGbxfXMvIww5R2eQPOFu+I8DmfWy9q+gXqar1Fwt84mH+CUO65zsUwiSuxEMbarEQ4Qgs/B4c9Wy/jaGrgOGtIduH+lKvA/G4zec5RinJh79PQYJ5mIfGX+EzZDl/m9S1n4ShnH7nwdDINyskd83rJo8KV8ObJHIi2e25zU6knArlHq0g8RqLuB1s/UltCM4mKYYJq3tHisrFWk=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(46966006)(36840700001)(36860700001)(34020700004)(336012)(6862004)(33656002)(966005)(82310400003)(8886007)(7696005)(8936002)(356005)(4326008)(54906003)(6666004)(44832011)(53546011)(81166007)(36756003)(86362001)(47076005)(82740400003)(2906002)(2616005)(1076003)(5660300002)(55016002)(478600001)(26005)(70586007)(186003)(316002)(8676002)(70206006)(16526019)(956004)(142923001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 09:50:49.4116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9e7f12-1576-4e0f-f1d5-08d90af444f2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5798
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 04/29/2021 02:23, Bill Wendling wrote:
> On Thu, Apr 29, 2021 at 12:55 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
> > The 04/28/2021 12:31, Bill Wendling wrote:
> > > On Wed, Apr 28, 2021 at 12:21 PM Bill Wendling <morbo@google.com> wrote:
> > > > On Wed, Apr 28, 2021 at 10:40 AM Mark Brown <broonie@kernel.org> wrote:
> > > > > On Wed, Apr 28, 2021 at 06:28:47PM +0100, Catalin Marinas wrote:
> > > > > > On Fri, Apr 23, 2021 at 01:51:59PM -0700, Bill Wendling wrote:
> > > > >
> > > > > > > Since the note.gnu.property section in the vDSO is not checked by the
> > > > > > > dynamic linker, discard the .note.gnu.property sections in the vDSO.
> > > > >
> > > > > > Can we not instead fix the linker script to preserve the
> > > > > > .note.gnu.property, correctly aligned? It doesn't take much space and
> > > > > > while we don't use it now, it has the BTI information about the binary.
> > > > >
> > > > > > Cc'ing a few others who were involved in the BTI support.
> > > > >
> > > > > Not just BTI, we also flag PAC usage in there too and could add other
> > > > > extensions going forwards.  While the note isn't actively used by
> > > > > anything right now due to the kernel mapping the vDSO prior to userspace
> > > > > starting it is part of the ABI and something could end up wanting to use
> > > > > it and getting confused if it's not there.  It would be much better to
> > > > > fix the alignment issue.
> > > >
> > > > If there's only one of the 8-byte aligned sections guaranteed, we
> > > > could place it first in the note. Otherwise, we will have to change
> > > > the alignment of the note (or somehow merge multiple notes).
> > > >
> > > I should have clarified that there's only one *entry* in the
> > > .note.gnu.properties section, and if not then is it possible to merge
> > > multiple entries into one. (Excuse my ignorance if this is already the
> > > case.)
> >
> > .note.gnu.property should go to PT_GNU_PROPERTY and it
> > should be merged following rules specified in
> > https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI
> > and
> > https://github.com/ARM-software/abi-aa/blob/master/aaelf64/aaelf64.rst#program-property
> >
> > it may also be covered by a (8byte aligned) PT_NOTE, but
> > that's not a requirement on aarch64 (x86 requires it for
> > compatibility with old dynamic linker, but since the vdso
> > is handled specially that may not be relevant either).
> >
> > i don't know how this works in linker scripts.
> 
> This is a potential patch. I haven't had time to test it though.
> However, it does appear to format the section in the "expected" way,
> so one's able to grab the build IDs. Thoughts?


please show the program headers.


> 
> $ objdump -s -j .note ./arch/arm64/kernel/vdso/vdso.so
> 
> ./arch/arm64/kernel/vdso/vdso.so:     file format elf64-little
> 
> Contents of section .note:
>  0288 04000000 10000000 05000000 474e5500  ............GNU.
>  0298 000000c0 04000000 03000000 00000000  ................
>  02a8 06000000 04000000 00000000 4c696e75  ............Linu
>  02b8 78000000 000a0500 06000000 01000000  x...............
>  02c8 00010000 4c696e75 78000000 00000000  ....Linux.......
>  02d8 04000000 14000000 03000000 474e5500  ............GNU.
>  02e8 958db149 af5156cb 45309896 7a53ae8a  ...I.QV.E0..zS..
>  02f8 ef34e95c                             .4.\
> 
> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S
> b/arch/arm64/kernel/vdso/vdso.lds.S
> index d808ad31e01f..d51e886c6223 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> @@ -31,7 +31,13 @@ SECTIONS
>         .gnu.version_d  : { *(.gnu.version_d) }
>         .gnu.version_r  : { *(.gnu.version_r) }
> 
> -       .note           : { *(.note.*) }                :text   :note
> +       /*
> +        * Add the .note.gnu.property section first, as it's aligned to
> +        * 8-bytes, while other notes are aligned to 4-bytes.
> +        */
> +       . = ALIGN(8);
> +
> +       .note           : { *(.note.gnu.property) *(.note.*) }  :text   :note
> 
>         . = ALIGN(16);

-- 
