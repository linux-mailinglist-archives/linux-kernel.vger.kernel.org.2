Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8845840D01B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhIOXXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:23:15 -0400
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:57728
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231579AbhIOXXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:23:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1FmgGj69rFubFTnZbfqa1hnbmFJyTVBfz8iHKVmbm1FtXl9C6/0fBF1zRfv/Jar3E2sYczzXlmovG9GXo02vbYP36FIXGtZXHGLobhloNUor7e70CyWI7xVFe4h/Hqezl7oqwXgVKY5HejHLwWjuy9xcwA7FzwoAOpjgAAx2rubIZHJdV6YNxn8hamHfmQmjTUFqafwcI1lRDWQbQfBlIw5RqZR+o7nXJW0mU3Wbgbm0zQGr5GIWESXUfQ8h3Olkv3PJswfv429kBgVdG9F3qOp2SIoClbyRPGD6AoCD5WIxGzoGcspGLpV3KiQFKdidUgmPh/usl4dJ6Yn+jPNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WYXG+5GHct43lCwx1eOn8uuGmaqEDcr/9jIaE6r0hx8=;
 b=iCnWr673mhK1fT959bpOI6XVFBnkpxsTuSbNm6eTrYmSUbLLp4nz9Zp8u3SS2ahfPHRisjP0opN9JVhjU1CKIxWzNRqXu91h0LYt1adpDwaH697BZogHjOeLYnpNmfXUYrwI0h2ELwlsp3VhTPZKMeQ6dHakgw3GvdT3L2iV4h7LsdBBDeNp7FVFS+QIxkSd4ggiO7VGBCRDEcpR3yvuaUdnkzyeeuky5r1V8dhco8jjrLu0k6tdMadvLoBcpjgQjZFu2w5JXAPIIlt7GuuhUGPzO3AduV1UG40whi9KeW7Wb0KscEGxZHy+4Ax604h3pswFROmTMMtLB9860ilNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYXG+5GHct43lCwx1eOn8uuGmaqEDcr/9jIaE6r0hx8=;
 b=vH0/oMURkDmJc0kdKl0CoqHeSucsE+P5TLIOLHlW1a3lcxrxvv4X41mtdoFwpeeYD5S4rrhNv4zXPvi50WAoZatSDVpTpfjwXeEw4wLyn7rUn9/mYuISO82MzaE4Ba4eSIur+MkJC/+1tHFfrBpS1lVZzIMAOyeM798EeqPCnLA=
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Wed, 15 Sep
 2021 23:21:53 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::3d10:92c3:3a52:77d9]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::3d10:92c3:3a52:77d9%5]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 23:21:52 +0000
Subject: Re: [1/4] drm/amd/display: Pass display_pipe_params_st as const in
 DML
To:     Harry Wentland <harry.wentland@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     ndesaulniers@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arnd@kernel.org, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, nathan@kernel.org, linux@roeck-us.net,
        llvm@lists.linux.dev
References: <20210909010023.29110-2-harry.wentland@amd.com>
From:   Anson Jacob <Anson.Jacob@amd.com>
Message-ID: <a14776f3-213d-9bf8-6ef1-224b80a20086@amd.com>
Date:   Wed, 15 Sep 2021 19:21:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210909010023.29110-2-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::30) To DM4PR12MB5072.namprd12.prod.outlook.com
 (2603:10b6:5:38b::22)
MIME-Version: 1.0
Received: from [192.168.2.12] (142.118.127.251) by YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 23:21:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1b29333-bf4f-4b04-1d13-08d9789f99c3
X-MS-TrafficTypeDiagnostic: DM6PR12MB5534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5534270149B9D967BC50D183EBDB9@DM6PR12MB5534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddqWywJzYLthOgKmxHYEoNLqtqmXoHpfdmVdqgSHyj4uOQms7JJOzsi0z+iio+B2Y7QYW1g/2NIC69SKvww4dY6csgMEb/E/qanFIwOcv4TE1DwBbHkTbZHtTZ007FmBxawReEIPi3yJF9B7c9v/JBgiBWAp3P2XayRhafhdY9nN4mWp67BPaeeTtN4W2KPDIVtTeWOgW0QS/C4+mEYepdRIOFrUmtOQkhAcFI9c4HlhHIswkK6n2cb7CU8BQeyhge8U+igEquuw6kac33akB+I5xBjyJTdN1ZL750gZ8m1Cu3tXreySzCwoFeeMAk+PB9HQr4JMZkw4SCbW1pfSYmYXbmTEfR3HpOLEIZiT/0N8U5Okhd/qEKtETmKd7F94mZM9RAcdz0f5MMz6UGsr49pqkShHmWBjKQ4HXOH6ZFkrPMx2//sPoNZJ1ZI5ojOyErqVCdL2O63bGssjH8qyGsWYvNDX4PFdgsyvZfScpEBv/vReiTWo6cbtOnTxfVNHeRLbIesByfsTr0BtD2b2UKvf9Dwp1qjgC2pDM5UftO4LnBGW/VenWreXfUq97dqnKPTGLX1Zyhk2e97Odn+VeKCKtJhSWncVgHYjbPqu+q4YPmr/IcrrrFyMmnrBMN1sw2jSPp7je4wyjFpiUQH12qZi9WtHfBE8nfe4KoB9ynTDhtjIks7h1odGExQYzM3SmaTnoOu2bX1c3u+5dKOrp2yT0uJOeK1gL5LjAltFKc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5072.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(31686004)(8676002)(31696002)(66556008)(6486002)(26005)(38100700002)(2616005)(5660300002)(4744005)(8936002)(956004)(36756003)(86362001)(186003)(2906002)(16576012)(4326008)(316002)(66946007)(478600001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2xiR0NpNktyL0xNaGhPdWdzSzhLUVdpT05wd1lmc29ZS1NkVDhmZnJuUVJh?=
 =?utf-8?B?MXBXb0Z2cU1Yb2JBNnFCWnYzSVNQZEx2a1duMU5Ielppc0F0cmtONnNsczh6?=
 =?utf-8?B?SUJiT056Mit4VVhuU0ZJbW93cEtsZXpyejlJbXN6c0RnWVpMUTFHenA0UVdi?=
 =?utf-8?B?TzNsYUg1d29KTURUR1RlUXRuMnppL0pzd2crbk5oaEhtSmVEK0R3VHVMMTNp?=
 =?utf-8?B?UmpWTFhtTlVDRUJiTlhpQWwwM1l4L2Z1eExCSm5YWExmWlhTNXFpek11UCtI?=
 =?utf-8?B?WmI5WlJlZ2w2Q2JmSFljSVZsOHBiSUlmeGZSeWxjNlIyOWRldDNFSnpRcE5v?=
 =?utf-8?B?Q2MzQ3k3eTB5bXpQaTA2NlR3VkVvQnlHM2lDa3ZrUzRTZGFtWVJJMVFjb01a?=
 =?utf-8?B?WG1OREZQZGdiSlhmZDE2RjhLQUF2bWVKWWlYL0xlM2NsY0U2d04wWGdpVDV4?=
 =?utf-8?B?R3BIaWh0SENIU2lqTGNxbEVUV2FGY3EwdnZOQ0w0ZTduajJLbXBKYTBuTERM?=
 =?utf-8?B?REM4N3Z0T1l2Z1pGNlpqYzVuZlc4N3JkYWRhNkVVakJsdVdZbEdrTXMvbkhX?=
 =?utf-8?B?RDBPSlJaWXBHQkpMMmx0V2pIM2NScC9uVlQ1cGpieUF5TmtMWGxGM29SK09a?=
 =?utf-8?B?NnRxankrd0c4bXhBUEt6aFJFZzJzazJmbGhrdDN5d2pNNXZzN2xFZ3RqREhm?=
 =?utf-8?B?d0xxUHBPeTc0WVJoRW5GWEtvb2xwRjJJL1V5TXNJck5lZitZTG0vZzh1akhI?=
 =?utf-8?B?S1QrYjlVSVZxTGwvbzlaZjVwN2hpS2FIWDhpd0JjVzllaTdQQ0xQOUVmNkVJ?=
 =?utf-8?B?RTVLeE10VHc1eVhrWThwT2lGcG14dGVtTkNtQ2tHeTFFR2JtaDh4ZnQzTEIv?=
 =?utf-8?B?eHJZSDlNcDFIbmlQUHpWdkZ3SjhLaE9VYVc1WWtmendCS3JJN3V0TFN2RmZ1?=
 =?utf-8?B?ZFZzRzNhWitLS2xvVkFmSU0vK3IxRTgrSzd6L1JzTjhLQXF1MHFSQmx2TUxm?=
 =?utf-8?B?cVN6RDBDOG1acXdNZXhST25XaTdLVHlHUVROejd4SjFIUDlxcEZpYktaWmor?=
 =?utf-8?B?NFRLQ0hkU2s5Zzd2ZmhUOEJiTVNxY090bEl1eEZRN1RQYzRzRndVTFRJem02?=
 =?utf-8?B?VWZ6bWYzZWEzdUE0RkFXdDRacHkwNW9CcTc3RWVUZ2h3VEYwRTh6aVUvVS9x?=
 =?utf-8?B?WUxSdERKei9GNXhKOW9pZGJ2L1FJR2NjT0JMODgyWUVkdExZd1hJS0pqUnJx?=
 =?utf-8?B?ekNmSDlSb1pOa1o3UDA2czg5b1dLWDEvd01saG5MSFBpUCtYeTBLc2tySlRp?=
 =?utf-8?B?K1RGUzA1dzE5cUF6ZUhiSDRBSE1TSDZnRVNFdEU1UXZxNEJFTU5aMkNhSGp4?=
 =?utf-8?B?aTBZb2VZR0xKYU9iUE1OK3NwZFUrTWpMMWdvbk81a0tiWDNEWHhKdHYvSEly?=
 =?utf-8?B?TFhuQXdSaExRTGRRSWNlcUIrbU1MWVFoMnRCdFVsR2FNZW0zN3owNW8xUnpQ?=
 =?utf-8?B?TEk1RnJWUFduUnBsUE5hNVdpUjUvUzNmd0JYSEhqUWV5d20wRERqQzFla0Rh?=
 =?utf-8?B?Q3RwMWY5eUYyYU9GWVExMXR4cnl2OEt4djFSSVNWdmxTd0J0Vnc4ejFxc1Zy?=
 =?utf-8?B?N1VqaldWejVRY2VwN3JOSGRlWmxRa1JvdFdBSWJ4M05uWWVXOW10MFFuVXkz?=
 =?utf-8?B?MHNJN2k1NnV3eFhTQURIMmtxaWpWdW93ZWRmckR2RmswbDl1WU1lL0ZaRTJt?=
 =?utf-8?Q?dazp2jKBRZAwjcuar1HKGI0hxwjq/TIkm+0oSqp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b29333-bf4f-4b04-1d13-08d9789f99c3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 23:21:52.8173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiaQGrO0NvA9n+qBnjQk6VRfEAOBLVAF5LAJ+7BaNFAsEBBsVogT9QDio9jLmxXJKDJ1aM9TWujSr3kcpO/P4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5534
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harry,

This patch fixes the following CID's. Thanks.

Addresses-Coverity-ID: 1424031: ("Big parameter passed by value")
Addresses-Coverity-ID: 1423970: ("Big parameter passed by value")
Addresses-Coverity-ID: 1423941: ("Big parameter passed by value")
Addresses-Coverity-ID: 1451742: ("Big parameter passed by value")
Addresses-Coverity-ID: 1451887: ("Big parameter passed by value")
Addresses-Coverity-ID: 1454146: ("Big parameter passed by value")
Addresses-Coverity-ID: 1454152: ("Big parameter passed by value")
Addresses-Coverity-ID: 1454413: ("Big parameter passed by value")
Addresses-Coverity-ID: 1466144: ("Big parameter passed by value")
Addresses-Coverity-ID: 1487237: ("Big parameter passed by value")

-- Anson
