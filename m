Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3F84296B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhJKSUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:20:34 -0400
Received: from mail-co1nam11on2084.outbound.protection.outlook.com ([40.107.220.84]:57776
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229565AbhJKSUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:20:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzbPPh+L+2R+8EtzY9jPQnWXKBizahkyqwY2sRU13FfibGZGNvkB3pzmIma7Lc/F543tSffgNQwlpxV/ymDLq7tJv7pKQHtQSSak0od0toamGnYdZ7fEzVvadP1zgcwu2CLzhAJ5TyiuIozqsmdNPoIuGCg4LT3OrlYhutLR/IHUm78ZuICsRsoRAJ4BJcXcpVDlsFgjxvoGz0BFwUjwjnz3QvcCzll61pEo14W7MlgosMKpzB1LmhAnYjI7I9KJlWW91geLj29w6Z06uA74sQc4TVwdCZCEidVi8oXDi5Hnwhzj1/cAvMpXyo2PXU4lJKrSCKFA2Y5TzUNEpYqKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xis2J8sSfz6rprrSgBJS7DhLTwVG0UhMC1JFgaBQ0IY=;
 b=SFXIgWUdeyt416ORaRPpi/HKzZoIGRoF8FBi2E2ieLx09PNryElx4jDe0HVA3r2vH2X3yjiSyBYqfE3T3GNhU8Y3kh4PqTT3TUOuE0+x1X45gKXPQe4DdL59wzkOK3HmRnYRniX+NWWDfnEA7TgC00phmdyGaNYpuHvOqiVCoKpKPwRfxoABMt0WGzfNHZ107tDcB+SPV4hpZrJyJlwY2WX+3qgsnwOfbYZ77azXNvk75ydBbrEKmCYzFUK6hg4mU6HLAItIFjvaGhiLNjzOBig8jGF8+qByWHFEeCaeeLNaeJkyGStSDv+jSvi4dWZFvQ6mUng1beyXJR0psUgjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xis2J8sSfz6rprrSgBJS7DhLTwVG0UhMC1JFgaBQ0IY=;
 b=z8SqWCLQzUVH4197sTYKOSaJZo+OTCORkXQLbERyl9xdi0qG19R5ntsLc6gLRHtSw9MCk2Wd461GxQAI2QbPAwNZejXXUBaiBjgOUNvtL+6aYaXZ4l/4GzVy+K4RJQCk2UPGJdz2WELzpN1pQ9gjNrsh78727/TOrtMR1HwMBrs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM5PR1201MB0252.namprd12.prod.outlook.com (2603:10b6:4:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 18:18:28 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e887:8ff6:34b5:99b3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e887:8ff6:34b5:99b3%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 18:18:28 +0000
Subject: Re: [PATCH 1/3] ASoc: amd: create platform device for VG machine
 driver
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Alexander.Deucher@amd.com,
        Sunil-kumar.Dommati@amd.com, David.Rhodes@cirrus.com,
        wtli@nuvoton.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211011184715.61573-1-Vijendar.Mukunda@amd.com>
 <YWR5QH1lYqiT1cX+@sirena.org.uk>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <57f313fe-fb8e-8b4b-8839-d9d8653880d1@amd.com>
Date:   Mon, 11 Oct 2021 11:48:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YWR5QH1lYqiT1cX+@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::14) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
Received: from [10.129.9.123] (165.204.159.251) by BM1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend Transport; Mon, 11 Oct 2021 18:18:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09e21f74-4d74-42b7-43d5-08d98ce385fb
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0252:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02529CD1AB8505E56C75BA9D97B59@DM5PR1201MB0252.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHYUuXhATy2P4JGSwQ3wd0KPZ8CHQWBMm+1nG3Ppr0+bHiIXQWb6HyrBRBCZbb7WfIkuhFOv/NulyrYsSquTWws+b5NPj61ZJ34wk92e8dPHGtIE/UI8F2g7y54xnFipmyvUACsZ7X4wYcfK4PrpLiHDSxyHoaDGSYPX8PhozzMBfWjCVbeSoOsdCOM5C/UpHAhkij0Vrnk/0LGmsu8c27hwDXsy03e3vN28MOyaW/aDZrpaPalxQLrkMea+4IszP8w6O3fYBXY1W0ChQrNWweOUk88fp6kSFGonCVjsU2+qknyRMuatBxWLFZh5vFX9+K1rBrVIEbMvLH+Caq5QubKRbHqnC6vIFUGIRXjcAzwuUmO3SjrTrZnEg3TiRq251DVC2MbDYRsxBtYRr3AkltyltLI0EhBLYJt4A9TnntPLNMkB0tUW77BURoYFuBW9fhNNClVtQb4//1rEqWdUHqVwciYVpEc+Nupg1fyUoIOTWrmVzfpi/c2/n8MExg4ijD3txVL38hemuYk8ESD4r2yUjSI7+2HRzSZuFzYPXgGrC3e+lVxCfAWUWJ/waJ7AY9xY+MlApVgHQTiLrzTVONa2fPx/nMyLiMGheG8pu47b6+2PXgTzYOtrHKCoYVNbhQN8VNTXg1pQBVeUG5b4DK09Yodr/QyuSFT47rjClYwTPsDx5qrNO847Kesp9B9JoGMeuok13x01Ko6voAzDYsMxZh60EECVGCyOQsed9fQJDrQ7eGu42+fqOXkJLCZW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6916009)(53546011)(26005)(186003)(83380400001)(66556008)(38100700002)(54906003)(31686004)(6486002)(956004)(8676002)(16576012)(86362001)(316002)(66476007)(36756003)(4326008)(2616005)(508600001)(6666004)(31696002)(5660300002)(66946007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?efShogG5EfdN5uFoOsHAQxXdAHw58+qrfQhfxirvyQ6vU/GE4HUwEUdt?=
 =?Windows-1252?Q?s3LRVR8SlZ76kYbyAGmKhGnGfcbda8WC/PUlW9mCpPJ9YGLFPUJQ4bO7?=
 =?Windows-1252?Q?XmfoXW9JV1lKNTyMKXJcqQK150Sjm8/EDOI0cbTXgMm4knAx6Xy5JJ59?=
 =?Windows-1252?Q?EPFnFOg0qg3ZxGICTYj4NGpRe2VYL/2VfGz7ciPUrkRL+m5emn88JUcH?=
 =?Windows-1252?Q?8JRV2SoahJcv+54eU8tcJwGu510ohfrMsoVUqxueDg0H0WzBIytAGDyB?=
 =?Windows-1252?Q?/bEbfhejVNeaFlOwPLHg23NdBMdnzEjH6WlAac3zIkeuSZ/yy/lF6Fj/?=
 =?Windows-1252?Q?xziffQbao1zOR/eM1IcAOAY10v3hSTPGP4Dyu4iAMBecKIhbaXzWGrsE?=
 =?Windows-1252?Q?1yrW+vWSSsww04p7V5uYwSTEkbfNjNTzvfjCvfzD83bvQ6JaP3fdoARq?=
 =?Windows-1252?Q?AM8ZfjJRpKHOq2sHYFjsoqd1KS1AvX1uBjj+1dgOhvpf4YGXiy/J0w2t?=
 =?Windows-1252?Q?ODwULHXCQtdQIM9ZVmmRHF2BnZuAgWXPl1BDZ3mk0cG7ZBy/okk5Y7MV?=
 =?Windows-1252?Q?WMV7NE8PHlugMj6u2PyNHmzzhuKgvcCU2tXV1ftqzIpxKIGMBS0VqbAf?=
 =?Windows-1252?Q?oWaghXIyBb4SIqgou9clLaCg67p4bTW93X55Olo//OM9tRWmqRNYGeDI?=
 =?Windows-1252?Q?n+UTCvphMhVPECLK9hL/nWjhrLBIVk8waDOnxrku0Saagn8TMycAAFIO?=
 =?Windows-1252?Q?/P30hSB3EhJGfFGic0LWRaMjYVgEJYo9lmEUqSwBAT6r5q+4eOzlF0yy?=
 =?Windows-1252?Q?MpV5BYhU2ep7APngno2+5q+EY7OLPBHZcWfBK8cmigE1SLhHkDCoEKBD?=
 =?Windows-1252?Q?9sBLR/aT4lv/5inBtsQZ4tE2AYhiLSIV+uvQaH7jwjNkUKnxjP16nFv3?=
 =?Windows-1252?Q?o5oq0LMDE0dPlSYxBK4ZQ2x/XlVRxN0KjKkwVI/S0PUw8gK5z/ZWwqGi?=
 =?Windows-1252?Q?rq9w/IqBgvTvwHGW8bWRUUcPbXp9bEJ+MtYrrCRBg04H8W3Vim/HwT3x?=
 =?Windows-1252?Q?Vpi14vth1q2e+/T4e7vKdq+C3JWQMhoktZNsVDMtOZs3t6fhI3+Fx6n7?=
 =?Windows-1252?Q?e4guhnMAC9biNEQhM1AEBrS8kB8/RDWDq4FGbUtlgz1TFaEupGUQGETg?=
 =?Windows-1252?Q?wTb9F0bsMeA+LL/lZ4pvwWs39FaMyaLwA2hc7HWKXWXLzaWz3e48ioew?=
 =?Windows-1252?Q?Fq2/U+2eV88IN5QzyN5xC79lOKyKAeWF6SAhiXzAczh3mWKEmUG+3p4o?=
 =?Windows-1252?Q?nY6IxZuJHyUPWPD7I4TLYoz/TW27FZpTQP/2WEciOFeTDpOtzanvGOGc?=
 =?Windows-1252?Q?cUOwRtAHyrDXgeaTdUdeOKuvio8QZBL+QarIixzqOMH5XoT7YQFuAViB?=
 =?Windows-1252?Q?nJlLpF8Lk6IN7ltn600IDQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e21f74-4d74-42b7-43d5-08d98ce385fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 18:18:28.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnlImqZjGZV1rK06iCsi4dY2ZCH0HCaIT6X87uVdz9bsEtPZ+MKd7YuPBMHUc3UJIwxyAvEpkP6rjWiKiMW0Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 11:19 PM, Mark Brown wrote:
> On Tue, Oct 12, 2021 at 12:17:01AM +0530, Vijendar Mukunda wrote:
> 
>>  		pdevinfo[2].res = &adata->res[2];
>>  
>> +		pdevinfo[3].name = "acp5x_nu8821_cs35l41_mach";
>> +		pdevinfo[3].id = 0;
>> +		pdevinfo[3].parent = &pci->dev;
> 
> This appears to unconditionally assume that any machine with this
> hardware is going to have exactly the same CODEC/amp combination - that
> seems like it's going to go badly at some point.  Shouldn't there be
> some other check that we're instantiating the right machine driver?
> 

we will make the platform device as generic one something like "acp5x_mach".

Currently we have only one target platform with above codec combinations
for this APU series.

When we get new codecs combinations to support, we will address it in
machine driver by adding DMI checks for distinguishing codec combinations.



> BTW your clock appears to be set quite a way into the future (possibly
> about 24 hours?) which is confusing things.
> 

Will fix the system time settings.
