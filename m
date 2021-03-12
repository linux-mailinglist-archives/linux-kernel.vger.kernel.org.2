Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C430338E01
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhCLM6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:58:19 -0500
Received: from mail-eopbgr20068.outbound.protection.outlook.com ([40.107.2.68]:7911
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231454AbhCLM5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEBOozT9D8Lw2SL0A/GVO3ZCqfukBVgJwvItoNA0TnI=;
 b=67IVoF3o37UyDOYlX7KidyB17jB0Fes98HVRHixXeFN88qmZi5Tw2ZAgNtR3RNzLmaMGSJ8b2KHr5plzLnJ2dAsp52k5egtShBHVcv0nf+Kx2UI1DjRHJG29N/Nc1Zb5bkgpuTIm5sho4iSNK57uuC6oGR6+yk3IyLMFYGFDEyE=
Received: from AM6PR05CA0023.eurprd05.prod.outlook.com (2603:10a6:20b:2e::36)
 by DB9PR08MB6441.eurprd08.prod.outlook.com (2603:10a6:10:252::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 12:57:40 +0000
Received: from AM5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2e:cafe::7) by AM6PR05CA0023.outlook.office365.com
 (2603:10a6:20b:2e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 12:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT054.mail.protection.outlook.com (10.152.16.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 12:57:39 +0000
Received: ("Tessian outbound 67e186bef91c:v71"); Fri, 12 Mar 2021 12:57:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 83cde20c6e9dae1d
X-CR-MTA-TID: 64aa7808
Received: from 19c0e8a0316b.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 49FE4716-C237-4233-BA33-B817CF759387.1;
        Fri, 12 Mar 2021 12:57:28 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 19c0e8a0316b.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 12 Mar 2021 12:57:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIXYgVWftb9yU5hUd7QA+7kOAOuvKr707tn79IE0Jvs9SPxIGz9iniH2O5YAx1ly7N9ZMyBJEkMrEb3Wkeb2Nne5DfLj5018NNfKvBksBYTwR6dH39BEktj55v0ObXJks20D60X9Dyy/nhOz33bH9jDZWkIn/cmB/IW4bx8u1Pn+3mNWNZu8RvOxb6G6+d6uPBLUeeDu3wvuw408lF2zi6edUKCyHF0B+LN93LxhwqlnShCcesmcuh0i/dtFhz4N5WblXrwmHquzog96J6b/NrzgXuiyj+1xreL2TO68cOl5z62OvwLA1j96NSEQGb4xZNWRXVoISyTslmY5kkRAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEBOozT9D8Lw2SL0A/GVO3ZCqfukBVgJwvItoNA0TnI=;
 b=cPnNTJe1mivVp8/82zYUljsNHZttgr2PIm0dGvBK5Fz77CM4Vx+v68c+yHRmgH9djb4T8UoFhUZMTIXnX7pqkhSA1sPQ/zr+YLGqt4o52Ub/FQ0GT9U7dwrs7362aPijWINX7etVEKj53blES5LtjU9VtoBVtpoxGfBk/P+geN9EwwV1bFPCEp955zU3LinNpkVCWxpJtLQPrOY1FqN+db1v1EjDjYAcYAdPJrUpos/mtdAr4ycydj7Ixh3LuxyAjrDkEMXiepHKhgo/4IpRfsP8YrUqY+CXoWtkYFkR0Ghhk5dHZYxS9zSw7ReWKbu5JWpeAc1nh11LLj5MQH7ynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEBOozT9D8Lw2SL0A/GVO3ZCqfukBVgJwvItoNA0TnI=;
 b=67IVoF3o37UyDOYlX7KidyB17jB0Fes98HVRHixXeFN88qmZi5Tw2ZAgNtR3RNzLmaMGSJ8b2KHr5plzLnJ2dAsp52k5egtShBHVcv0nf+Kx2UI1DjRHJG29N/Nc1Zb5bkgpuTIm5sho4iSNK57uuC6oGR6+yk3IyLMFYGFDEyE=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM9PR08MB6130.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 12:57:26 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 12:57:26 +0000
Subject: Re: [PATCH RFC v1 08/15] iommu: Add asid_bits to arm smmu-v3 stage1
 table info
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-9-vivek.gautam@arm.com> <YD/E+XASgn9PL9HM@myrica>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <c705cf54-39ed-0b66-e02c-32969d061b16@arm.com>
Date:   Fri, 12 Mar 2021 18:27:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YD/E+XASgn9PL9HM@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: BMXPR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::11) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by BMXPR01CA0001.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 12:57:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6045380-0594-4a9e-1766-08d8e5566b22
X-MS-TrafficTypeDiagnostic: AM9PR08MB6130:|DB9PR08MB6441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB9PR08MB644121F6988F09BDE1B85ADF896F9@DB9PR08MB6441.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: EiIiW1OpcPur6xQKCM20VQy0+nAosangeilNUNfhDxpV7YPyuKpTesLQKM2g0A4LzhIWiRRPUmO2R2l+o7q3oSF9ol+A6aRpclY5Nwlvl4EKCkm9MruuC6BSpfLoD0hulQVcEerpZv3I4sClERgDXp9hV+o/XKk/CfJWOla7rTisw6asEWyw6vmdjy2NNsNZgigUvEaidl0gFmSW8DLvi3Za/XWoZmDd9SMD19+HrTAj5EIJR4YH+LCDQ1DJ3LQb9BpfGVDwxo3rmFfsENJRacAD8liZmyMKa4ElOsKe0SAc2E27TRH6KU4tkAD2lur6d5hPu2vujyf4i1NfmqMOy9chZBlcKXlPD1qymHETVnF0TcwlRrIc3Yalmm3MZD+WPwUp9cr3JhxfJjGamlOvV+gk/C3nhtAfD4hCUGEEIiQX9xd/IdxzjhUcgKs0XMEo2pabaSZiNDiNjilRb17RSwMmrmn/y3tylDv9DhVgCN5M1SLVGRJKoZeSRxf/JbqBxaAI3whxLbPC5065ouBYVBMTV1535qp1cdgq4xUTexDyH1pEpvnCIZdJfDGsDOiccF2yUIygQQSamprk/BugveyWY00RanNvOX/Mo9tgFGa+px4Zjpa6ZPcfWdK8Vwe8orMP2ptF0VGoyuPzD6BlWl1wQ58zbllKpHIG8tmOd7We1Klmfv+vflOrg8kvKusuL6m6u1ODrdh3XySuGDtx6w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3268.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(52116002)(83380400001)(6486002)(31696002)(53546011)(31686004)(186003)(66476007)(6916009)(26005)(5660300002)(6666004)(2906002)(86362001)(478600001)(956004)(66946007)(2616005)(7416002)(36756003)(8676002)(66556008)(16526019)(4326008)(316002)(8936002)(16576012)(45980500001)(43740500002)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SkJYNWNuMHo5YzkxTE1GbjFVb01hejM4RENqSk5VeWo2QzFIek1JU2ozR0cv?=
 =?utf-8?B?SHlkUnRWSjBUN1ZOeTd4ZUpFSmppR2FqQ3ltOGhObVZaUlAxdDd3NnZDcllL?=
 =?utf-8?B?OHZFSWVTeTI5Uk9md1dYNE81WmZTQzJsMEpSdFpFRTZQUEtkRFlNM1MydzBQ?=
 =?utf-8?B?MEtJbmx4WFFpK05UWTlXMXNvaXdXUjZSQkxaK0RPODVJNlBtek4vRUFrbCtj?=
 =?utf-8?B?SDBZUjZlTGxhSlRaTzV4WHpQRFZrSXNPU1FzY29xa2dGdzkxNjJRR0EvOVo2?=
 =?utf-8?B?STQzeHA0ODliR0dVSmVTN1lvKzQ0dlpsZXNZL01qVDl3Tzl2dVhIUkY4MGE4?=
 =?utf-8?B?L0w0WTVCMjhTV2lvN0MxRGR0YzdrbFNFaCtSc0wwM0NFeXl4bE1IRERLL1Ar?=
 =?utf-8?B?R3ZXZ3JObks2dGhnM0tjbFFKLzNVNUFEOHhXbmR0RTQvM1JJenp4Tms1Z1Rm?=
 =?utf-8?B?K2htSmlDSWZydkswd0FoQjN0Q0JNc0FQdTdKY2E1clVPWG9HZjYyOGJXS0FF?=
 =?utf-8?B?cFVvSThoT01EOG5uSW02V0xvVS95dEUxU3pCcHhpUW1iN3BqL3M1RVJFNWU5?=
 =?utf-8?B?YjF1YVR5K2JYT2tuMzc1MFhLcWYzT01EL2xCaTJIZmJ3bzVUcGM0VW9KeHlm?=
 =?utf-8?B?Ri9mMXJGYTJzOTh0dUhFTFJMRy9oengzZm9yZklLOTc2RjNGUDlXREl1ZmpK?=
 =?utf-8?B?N1JGYWR3STlKYkFXcXNmYWhSYXYrTk9RZ3QrYVI3VnRGc3RSRU9nL0dTZDJ4?=
 =?utf-8?B?cmlsMG50QnJYSVBDOFNQVEpsRXJtd3UrcUFjTDlzekJ0ZDY0bEpwM2NVOHJJ?=
 =?utf-8?B?ZHVwUWRSM3pXaXgyekJyWVo0bjRmemFjK2svcXV1ZDl0ZnlXcUc5QmNHSDVT?=
 =?utf-8?B?L3pMcmE0bUlIYm9VenpCbDNoL3Y4U3RXMkRpMjBLUGtiYmxlUE9NWi9wajdY?=
 =?utf-8?B?d3dvRWpKS1BKUWdIZVdGYmcyMTg4VWN5S1BEY05RUWc1NEFjY2xZQXhndXVl?=
 =?utf-8?B?WXArV05sdGh1dDVwRnVRdVVuSFcwZG1UdDNiR3BaNDcxakw3OXNSbG5RZlVS?=
 =?utf-8?B?Ui9zUHlBTGZOQ2YzVEZiSVVCeFY0RWxJOUE1TDcrNHNHRVZUWm15QnJvQWhl?=
 =?utf-8?B?aWlYYm5uc1RQdHdaNGYrZEliMjBZOVJPVGlEMXcyVXFQcmg2SGNJNGtOSWtW?=
 =?utf-8?B?alZ3a2NyQzd0SGtFSmROcytteFZ2VzhYcUNDeldIYkxyWndyak9uaGV2RXZ2?=
 =?utf-8?B?d3FuZ1B2V0h0a1F5QlZuZkJEajFZOGhySFVPYXBTYXQ1RlpLUGNrbGRsT2p0?=
 =?utf-8?B?bVBaNWhYRmlYeU1Ec0l4Q1Vra0pLV01uOEkvZ3V4Vk42YWhhUWtnTEVyL3dP?=
 =?utf-8?B?YXpIdFdMdEJ4cG5pcThzZWFFNHhjeW5reVBjRDRsNVQxcVg1VmxmcTV2M0lt?=
 =?utf-8?B?RGxVQ0F4L1B0dUlmeGYwaGs4MzFpaHBsdW1Bamt0REFIT1NoMzVUdkVDYnNY?=
 =?utf-8?B?L1VQeVdIeDdsaWVpY0hmU0VobnhKRHpqY04xR2FNRTk2WVR2OFkrdEVFNkoy?=
 =?utf-8?B?WXZrUmg5a0VGN3JDUnR1VFF5bVFJTFFCQXR3YmtqYm9Nd05kR2luVFp4Y01x?=
 =?utf-8?B?dk82TWNKeW5yVzBEbmlRNEw0Z2U2QUZrZTZnNlBNcXVGV1RVaTlQL0c5N3VP?=
 =?utf-8?B?SXJRSmlzaytpYlgxTzdlTDNVWXlmMTF6K3prcjY4aUcxdkZWb20wOE1LM3Zh?=
 =?utf-8?Q?mEqyFEqnldCE2TsZRoTT5A6QPewTW3G5uKspw1V?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6130
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: df9537e5-f5f1-4943-f924-08d8e5566282
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8lx7hjhLpbdFSw+TvyOVEtCcaX0pa4/F/75m1UTol/xbXIWvOdrEa8i1uOOKUvL0D988FQ/C9uxAHeIce1OptWpMujzRLfQ6GGJDanY1vpwgnPrW+VNGakz9hGjRPbz6vfXjaQgPkSLI+Nl3uuaERRpkiwr/qUEIstRcCr2HQL10H62eBz8Lp3S6pRng22zJnjh4aVez93Ta4K5qoeHPjUSsZj4VWPMDsSBxQp7dU0LBKfdM5/CiP3Lo3zW0iaQzTNQoIXQrmwxuxkJelZdhvF9tP34EAYZYuPt2sWUO1V0zA9cdKBJHrWEsprzBl1gA63kjooALTJMpjLH/OfPHo7r11/AQsckHGG9U+pctSSLep2+Lrfgg07iiY3SV/gRZL+Wu3tToDljGsUaTLlhr1ZDhhm+sC4R4Sfn2X4+nKJ+w3wcCVX7aIZplkJ74XOzSAEaEV49wkoLfFim8YczKVMO1hLJ2onYjTMauchOExLlocuBhyRp5S4gcDOoJZaE6Qqd57qx94Qr1D0jJRkuMH+nkBXLBt+72nW6lPdPCSFanuGaW6VJMlMgSvjNOFDwUmzwHSmJ7m2KtH6my4/ulTOCs4wb1H+iSq7llVtLlvIk8SO0g/YGv+LSByj/co5ZsWOeQoe6+i173s3b+zHyCf4WBhPuBOSN7p8bH7xwSKtCA4APWMwHGD4JfcvSw6YyuyV6m/AdVRgV3SUYCBauU2yK9+NugihoocOwx7gCp9IaxOp1u0dCYEhoBbVxSgSa
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(31696002)(70206006)(36860700001)(86362001)(5660300002)(81166007)(2906002)(8676002)(8936002)(6486002)(36756003)(53546011)(356005)(82310400003)(31686004)(6666004)(83380400001)(4326008)(336012)(26005)(956004)(2616005)(186003)(16526019)(6862004)(107886003)(316002)(16576012)(82740400003)(70586007)(478600001)(47076005)(43740500002)(473944003)(414714003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 12:57:39.9360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6045380-0594-4a9e-1766-08d8e5566b22
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6441
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/21 10:48 PM, Jean-Philippe Brucker wrote:
> On Fri, Jan 15, 2021 at 05:43:35PM +0530, Vivek Gautam wrote:
>> aisd_bits data is required to prepare stage-1 tables for arm-smmu-v3.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> ---
>>   include/uapi/linux/iommu.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>> index 082d758dd016..96abbfc7c643 100644
>> --- a/include/uapi/linux/iommu.h
>> +++ b/include/uapi/linux/iommu.h
>> @@ -357,7 +357,7 @@ struct iommu_pasid_smmuv3 {
>>   	__u32	version;
>>   	__u8	s1fmt;
>>   	__u8	s1dss;
>> -	__u8	padding[2];
>> +	__u16	asid_bits;
> 
> Is this used anywhere?  This struct is passed from host userspace to host
> kernel to attach the PASID table, so I don't think it needs an asid_bits
> field.

Yea, must have missed removing it from the WIP work. Will remove it.

Thanks
Vivek
