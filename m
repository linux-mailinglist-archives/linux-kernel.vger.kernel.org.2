Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF587338D82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhCLMuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:50:11 -0500
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:14660
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230443AbhCLMtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4YCe9ZI3MUPLdITUwFbvybwd2udMN9GCnKhkMHjF94=;
 b=gXqZiAi4J+18FRoPEEe2I/Eyq/C6YesckMP+/X4PuH9chs7ABkF/r1YnME8qsC0XED5iqdK6G32DzHi4Zk2DSRBMBgzsqypjrP/gab8vRts6YXNF4Q4lvtOgA94oT2hqmM8yD0qlfNSykpXhn4uXu5r6MiyGTtxupXIb88NPfeI=
Received: from DB6PR0202CA0043.eurprd02.prod.outlook.com (2603:10a6:4:a5::29)
 by DB8PR08MB5066.eurprd08.prod.outlook.com (2603:10a6:10:e4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 12:49:41 +0000
Received: from DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::cd) by DB6PR0202CA0043.outlook.office365.com
 (2603:10a6:4:a5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 12:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT004.mail.protection.outlook.com (10.152.20.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.30 via Frontend Transport; Fri, 12 Mar 2021 12:49:41 +0000
Received: ("Tessian outbound 520e67c3dd94:v71"); Fri, 12 Mar 2021 12:49:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0852768d57652db3
X-CR-MTA-TID: 64aa7808
Received: from 6f0a22f58ec3.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 08AFE571-33A0-4D69-98EA-C604AEFCB22D.1;
        Fri, 12 Mar 2021 12:49:35 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6f0a22f58ec3.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 12 Mar 2021 12:49:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJZ3fDMQs5NnC22NN4k4RVZHc99cHYRqXBjz6Eo1R933GoqOK2cZ+7npKqyLla/iaSblv3n1OnRyWDjP9KVHcxWElpN62RUOMdFYjeLJP7da2jxa2hI6lyErJJU7XHlOHkcH0/T6K0Khq3wCurJfqphauu/yWVhuk13++mgGmwD4Z3Qz3StVZ3g9usufNIYmuMe9AXAOIYvUEZda3asLYIeD/HQF2uj+sXAvpa30+OKg76G+YU5vUkhUwPmznyWYIPM2V+hHvjun9dZ3X/xfa4NwpbbTmEh6YDKpevQcf5g+KFnfX0VD/uNUUBGWBRhTnnuCuu0Y6lvO2WFxOuhhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4YCe9ZI3MUPLdITUwFbvybwd2udMN9GCnKhkMHjF94=;
 b=VzNE3YB9NcayhgbujPxMa0s+mScM5bXPyT7qtpiKnZywSqtib+6CdZquU8L1RQdxkQonoTSdepIdYz9X99BGvRKDgwTwuNs5n6zdpAzkoOO3dvo3Zhgu3zMMoeR8ynLyDjQB5MEsT6sVp1s6HOBOmCrAPRbgk24CteCgLF4G+PuHSTIW82ZuPsH52LzVkgRG4qxHXCXIOjCO8T9L/Fh7fFOHA+SN+zhpA+RvFwLvwuUFblyckQPXXe5If8bXSWhZHld0NGNLYsfxNCakTk5NBb9d+NDVGkd41umKktAXUdkq52G8jkLEgk2vladeLJqtLtNZ3OoHE2djAEaVIxqR4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4YCe9ZI3MUPLdITUwFbvybwd2udMN9GCnKhkMHjF94=;
 b=gXqZiAi4J+18FRoPEEe2I/Eyq/C6YesckMP+/X4PuH9chs7ABkF/r1YnME8qsC0XED5iqdK6G32DzHi4Zk2DSRBMBgzsqypjrP/gab8vRts6YXNF4Q4lvtOgA94oT2hqmM8yD0qlfNSykpXhn4uXu5r6MiyGTtxupXIb88NPfeI=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM9PR08MB5890.eurprd08.prod.outlook.com (2603:10a6:20b:281::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 12:49:31 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 12:49:31 +0000
Subject: Re: [PATCH RFC v1 05/15] iommu/arm-smmu-v3: Set sync op from consumer
 driver of cd-lib
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
 <20210115121342.15093-6-vivek.gautam@arm.com> <YD/ETcVwWATG4M6e@myrica>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <8ca14697-06d8-86f7-50d9-fd9a7fdfda11@arm.com>
Date:   Fri, 12 Mar 2021 18:19:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YD/ETcVwWATG4M6e@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: PN1PR01CA0096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::12)
 To AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by PN1PR01CA0096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 12:49:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5bdef0be-be62-4bff-90d6-08d8e5554da2
X-MS-TrafficTypeDiagnostic: AM9PR08MB5890:|DB8PR08MB5066:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5066EAA1152FB177C950C17C896F9@DB8PR08MB5066.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xpFnz6OsoqM9FlYkZoFWr/++HkjFIxIbTmk2pIM8etQWcgpZG0a1hnnX5kvUr31ZfkCiZHDAoSTzHX3C1Xo5kT/nLLBvNC2URZ6QBajgrdyUfpPsnKChrsrouhfz1jt64qId+NNrOit8C3ZAydMJtvHuP99ahy84bVkafIgNBrmW6K+ohBdbWwyxklhIW+z8KVfMMua1rQ1nBOi2tILvgT0hDnfSRKuhQCDW15jNxdb1XJqoxrlWujdqbWJacQ8wwmN2yA7svJrheBJDueXjnDW/GgXW4v1RZoU9sg50p146maf89BIN6j6mOH7Og11qIUyX0x4W2YKRH5up8ckkU85qQXYAEaLZ54sbAmjO5z3IyOPzVqm47rFbytdmFhmCfXSkqm3A1Rl7VOGSXI4rqrcj9upgLO+SD16FX9LrFOQQEf2fO/BmftPJaGQToFhm0HJWp0kjIOUMCLdAdx3VBbd/wW3Pj7a4Ca3m6HRLYR0gBxrPFe2RAfAvQmFZ+P7qRie18AIbQeLrclmKDzsPNu2a5ez5FSUXn8UeflSFeeT9t1nF82vm3ZHIGVXRvnKWFS0v3CgZhG+domBOJkBLT3GHFvxZ+b1On+vLIvEhkPg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3268.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(86362001)(478600001)(8936002)(16526019)(186003)(31696002)(6666004)(956004)(2616005)(5660300002)(6916009)(66476007)(31686004)(66946007)(66556008)(16576012)(26005)(52116002)(83380400001)(316002)(53546011)(8676002)(2906002)(6486002)(4326008)(7416002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RElyQjBBclZYRW8rdmZWMlFoWVBNNUtvL3lrZEZGVWxqQzAybWNaV09aOEx5?=
 =?utf-8?B?RUdmbUJCSjVLdXNTNkI1K0w5enVBbzJmS1dpdDRmTE1sTjVIMUlkWkphTXhW?=
 =?utf-8?B?TE0zYXNFME9CY1l6TUhZVEhaRGtNczNMNFhRSFhFZVBaYzM1eHhkT2R3enJK?=
 =?utf-8?B?Q2hiQnZ4d29uS1BKZ3F0K1drYk44UEFudng1OGp2cjVhR1MvazdCUG9aYitr?=
 =?utf-8?B?dWg5N3NvK2xBSmt6dWdXcDFIbEZtSGd3N1BRYUREL2IxdkdFaGlNQ2g5NUNH?=
 =?utf-8?B?V3lPUC81MXRScldlZ0JTdlp0a1ZiN3oyK1BwbllySDBMNjVwQXRTRkZoSTFx?=
 =?utf-8?B?VmwvVGl3QVlMVGJydXBaTlc3ZkNESmxnYkhTaFlienQwZFRKSHYxWjNyS3oy?=
 =?utf-8?B?ODE3QWtMVE5LV2FRVHBKS0tsNVUzK0NkTElzM0FRaXUyMlRvVHpCdVVnU1NZ?=
 =?utf-8?B?b1hpNnNqdEJQL3RWMDlLaitmWFZ4OEI4TGRJZkFMa05wdGNxVk42eVVnZ3VJ?=
 =?utf-8?B?UVNvM3BHMzlGSEtSa0UwWWZIMkN4TVNKeDVYN1RXRUIrMFhTT3JkWmF1Qmx0?=
 =?utf-8?B?V1VCWStqM21UaUVHdUJ4c3oxSDlZOHZ5TG1WbkpqSkZZYkRXRjV2RnRhWXZY?=
 =?utf-8?B?RmJSeHNJM1Q3S3hxcUVEUU00VVZRc0J2Tnp2L0oybVA4UjdJenRTTlVYbUpH?=
 =?utf-8?B?TlE1b1VRYzdxNk9KbUFrcW1LRzZjL1cvQUFhZHdQcXpkTjhNMFRLTGxMRWVk?=
 =?utf-8?B?NUlieGtQZFphWlJRN01vajF0WU1BcVZ5Y1VvRUdjYlAxb0xmcGI4dlp4RFZo?=
 =?utf-8?B?Y3FVeHJYRjhYbjQvM0lGNzFRTk53YVNjZWNHQ0FDRG1QQnBjRlMzUjhhZUxs?=
 =?utf-8?B?ZHpRa1UybjdHWHFHVXlBRk9hOTJZRWNLMkFOYURNOFgwcHIxdXJSZmV6MEEv?=
 =?utf-8?B?SjB0MFB0NmVYc0RNMlg2c0NDdG1JdkJPQ1V5OUJKYmhrRFdDNjNabXlERTZ5?=
 =?utf-8?B?TWpIT2VPZFNrcExGbGJnUVRLM1dRbHl3bFFRYmtab1hiVk1PTjBzeWJjOURJ?=
 =?utf-8?B?dkhDWmtPdytyMXY1Q2VMWW5HNHdTdFh2MjJIVXU2N0VjUVNNdldlNW43cUh4?=
 =?utf-8?B?RkJlQU1Id1I2RUtMUXdWMk1hQ2h2bklXeGhZaWJlUW42UEpyS052UmF0OFNQ?=
 =?utf-8?B?Zy9xeVdRSW40VWlJd3d0eFJidzlRK2dEV3JKcjVSRW9JY0ZBWWY5ams1NmhL?=
 =?utf-8?B?TkVMbFFGUCtvODhxV2JVNE5sUXo0Q1orYVdPcmUvTUxXbWkyV2dEUjRKWU04?=
 =?utf-8?B?eUV0U3gzK3RHdmEzNGVEWllUdmdRNy8xYllxMWFlall3OUQra1Z6QllJWHJK?=
 =?utf-8?B?ZVdZZ1VJT3NEdkRxYlpCTjRiaGhSUUNTZXRrRmxWTHZMcy82Q3g4NTBybDBj?=
 =?utf-8?B?RVUyTFVzWlVPMDZNTzNNd1B6dm9MdmRCZGFZM1IrTFQyaG4wQ3VEQ3BSazFE?=
 =?utf-8?B?VDVUdVo3VGtaVDA1WE9RWktrNytiYUo2akZ4RXpkODRBampFMkJid1YybnZX?=
 =?utf-8?B?RFZwczBvTU43dm9sOGFJcCtHQk1DanJNekp3RVFBYlFiUG1wbXY1Z0UvYUpY?=
 =?utf-8?B?M0RLZUhjUVJOK21JMWpvY2pHQ0FMTTlLcWdxOUNyVnR4Z0FyVEcwdVI3d1g1?=
 =?utf-8?B?N2tueFdWMnptVHlwSStxaHBtcU0vOGJKOTlMaHEyM3ErK0NneU55SjJEMGo1?=
 =?utf-8?Q?R7YDRa9veMqAVS+msCkImDtb3hSblT1yFW6VGhp?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5890
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: f1b31c8b-ac77-4f31-463f-08d8e5554767
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CYsIRB9RHRBIK87gfnT3thnCEJkNMhLvG/fXOelwpFyqsoIA5YSphLPFV26Uvs0yGmTtBiQOQ0iT+HhDVQfIN/77t+20AdhtE3/50g1JpUlAavRDVm5kea371PbqwB0gbvXKZe1hIqLmUqfqZjjhzPcklL5TVKCmaYMcgPWCqD8PQmOqFt77jOxRE2KGaRURwhLO/UpnFtDgAaie4cb9vPNBiSrGkLIYUPArJXZHKIbFqyIRm25gGr1yPaqL5HQqDTzMyf7gDWbUgUv64JubVDw1cxcM2KJaAEfqixIkkMxa8B7130/UWL7iZi9LCejGLffD6MgHGIyqt9YcRRqd+DuT7wCSPymh6N3QmjzyWR4wG2cL8E5Oh4X6HSRtQqJ6X0rCOh8392zKRvlgIAuN7iFIAkHDr/Ozcgs93CLoRi0mrrlHMOrTl6sOXE3jQ1iIDAy8ksB5F7+ZSxj9WidLMmfFQFXhj/RH9IJq6sfu/f8DBxwtzZdmZ2r6IrhI7nBdLuXcfuGemJT4H1SNl5vzYfEncX/3VAi7bFXbBEziqAaoV67Bv+WSKA1ta3Ov9e2y+GHOOQGlLfxevqQYuovDr5akeOlD26GS7tOk98yswn+Ql1zS7ThmV/CoqsffaOlvkEGT9qqVlttRVNY9aFevYJp5f4ntFhYhjJ87fc9VdV9NYt0ujxqZnuGWOu9Z4Jd
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(36840700001)(46966006)(478600001)(70206006)(5660300002)(8936002)(107886003)(8676002)(70586007)(336012)(6486002)(2616005)(956004)(26005)(4326008)(16526019)(186003)(2906002)(6862004)(6666004)(356005)(82740400003)(47076005)(36756003)(83380400001)(81166007)(316002)(16576012)(82310400003)(36860700001)(31686004)(53546011)(86362001)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 12:49:41.0265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdef0be-be62-4bff-90d6-08d8e5554da2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/21 10:45 PM, Jean-Philippe Brucker wrote:
> On Fri, Jan 15, 2021 at 05:43:32PM +0530, Vivek Gautam wrote:
>> Te change allows different consumers of arm-smmu-v3-cd-lib to set
>> their respective sync op for pasid entries.
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
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c | 1 -
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 7 +++++++
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
>> index ec37476c8d09..acaa09acecdd 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
>> @@ -265,7 +265,6 @@ struct iommu_vendor_psdtable_ops arm_cd_table_ops = {
>>   	.free	 = arm_smmu_free_cd_tables,
>>   	.prepare = arm_smmu_prepare_cd,
>>   	.write	 = arm_smmu_write_ctx_desc,
>> -	.sync	 = arm_smmu_sync_cd,
>>   };
>>   
>>   struct iommu_pasid_table *arm_smmu_register_cd_table(struct device *dev,
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 2f86c6ac42b6..0c644be22b4b 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -1869,6 +1869,13 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>>   	if (ret)
>>   		goto out_free_cd_tables;
>>   
>> +	/*
>> +	 * Strange to setup an op here?
>> +	 * cd-lib is the actual user of sync op, and therefore the platform
>> +	 * drivers should assign this sync/maintenance ops as per need.
>> +	 */
>> +	tbl->ops->sync = arm_smmu_sync_cd;
>> +
> 
> Modifying a static struct from here doesn't feel right. I think the
> interface should be roughly similar to io-pgtable since the principle is
> the same. So the sync() op should be separate from arm_cd_table_ops since
> it's a callback into the driver. Maybe pass it to
> iommu_register_pasid_table().

Sure, will take care of this.

Thanks & regards
Vivek
