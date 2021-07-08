Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFBD3BF8BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhGHLPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:15:54 -0400
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:49889
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231540AbhGHLPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:15:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anv0Ou+/Kn3yHsPZs0zX1TNxw7rlmvAWM5BvPJ7tDv5r0ZOOPzBko8IJ1oKXTmC2Lg6tdDOzjQ0/KCMmfULdC3P6wwFW3smnebpSQxYUE5XPuxwonhD1aI6DzcKLufe3k1HcuBnflHSAlZTlaDYiv2dHbXUdkr318GP7Xe+dwnjolvVrJk0Kv45tymf/ST5V/U+lXt+busVg0QLowXJMz6/K1SCGlrFIE+m8IBcVTqGwJUptu7b/HG0mOg38efT8m3xNTvDAYAKmD134J7IYUGeFqDBeCW7i53xfJtNfM6rgn8txrL27H6TFGEOnLydjAyJDzxWlXrAzSXYqVPrXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckWccHxu35uPsbASg9dZ1HkEp3GjMZXJim3TKTkAejc=;
 b=kPFllwKim2em+V77gAxW1dpSNQgWPa4v88zJ9EsYnlixf4c91vcGWAxcKDOWTQaATmc/Uyr7irY1A5lci+q/e1sNtt5c7pJ5zNSxFy9Yn9gPH+WN0HFoEzYG5hBPjkJK8BkdcljxbL7QJoozuQa5co4Mn3RvFMMQKtYnC6iGpe8eOUPAQTBavZTnVTA2JV9Qg310Ip5Hzl5oJBTV9/a6Vja0NNeaBnkIdihp63zYvke3ApI4DhbA810CF+qBs1tjlbkynMQWuDyqhc20lmribEhIovNwExzkzEs22kLjAha+bif37fiNi9xXy7IZ01rePd2qZhfU5iOMeQRMJfZUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckWccHxu35uPsbASg9dZ1HkEp3GjMZXJim3TKTkAejc=;
 b=2BITVG/83+V9lNVKhiQUxUfMAgY1rhJq0vQrb+rGYyQHBgmXMyfyJY08qoLqjv5/bhab8VkMWJlkHi8ZuWkSl44TdzgJKphKVqTYJcbQxazlRdIU+0XhiivNN2edZfKGCahZHJU7m9m2CO6QwMiQCvKY3/VyURxrQfzMnq4J8Vg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23) by MWHPR12MB1261.namprd12.prod.outlook.com
 (2603:10b6:300:10::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Thu, 8 Jul
 2021 11:13:09 +0000
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439]) by MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439%11]) with mapi id 15.20.4308.021; Thu, 8 Jul 2021
 11:13:09 +0000
Subject: Re: [PATCH 09/12] ASoC: amd: add vangogh i2s dai driver ops
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Alexander.Deucher@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-10-vijendar.mukunda@amd.com>
 <20210707163507.GI4394@sirena.org.uk>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <a4f4c59a-8870-1939-51ba-9ee9681d9f93@amd.com>
Date:   Thu, 8 Jul 2021 17:00:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210707163507.GI4394@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To MWHPR1201MB2557.namprd12.prod.outlook.com (2603:10b6:300:e4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.93.39] (165.204.159.242) by SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Thu, 8 Jul 2021 11:13:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc1c19d3-a2f9-4c56-7177-08d942015e10
X-MS-TrafficTypeDiagnostic: MWHPR12MB1261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB12612DEDB5F5086DD9C8446F97199@MWHPR12MB1261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +POKv9wC5zO0yypHr4nlxCYvyUHwwFDF4OOQlJC9miao/FqXDH6iQ0MMNN+CosNR7bOSVpgLkroB5xZ3dfsaLw/95kkRKubMdUq/4MTRKojNpt/e2Zn/zBEbEe5c06sMOS3gkUZ43RylbCIIIvhcFchB5Wu7UkGlLSupy0pyLtNr92/DONlB0Wt5OMnyYeJfrVQimu/R2PpaoYIk7jO2aix5bIMEYQfe38In7VBUaH71m8ufvKagRPz0H9R45noMTeBrhgZrid+wyMHplootB0N6M7jJHV+TNywIAddmWdJwFzK6Ukf3+GS/rIR6Kso0Ht42fbc3Swrek3HlBeCYiju2sSu/jJxfjays+Hr76X4Fgpefh9KMg2hA+45le1W/2SvoDz8jLJfR/BC6b+mYBrqYwo3T46emyu1vfqdMzz4zjo7oDjkAIqH/gy7IDIcRV4Ncgqc5LHdqokgo0uDq8hoU03GqlQXL6p4MaMyQKRZiqrsu+QjjBEb58oR+1L7QWV9g6GN3viiraEqy3cokem7hLObGn39hMZvVDlTJgkSg9++mYPlh2PePyPRNLB4UO0T2WcVGnkuixGSDbS1fFDeFGJSRCwv4tFJIjuDiRQ9yQfai2qlkeCTbXI2V8kg42327bmrZtiLpjNpU0WOQ/IQYLdrLb4x3JdnDtrNAjxyZZNj7K4gYk6fAHL1bFPl24hK+korjXUTzuHBOGBmozhESR31T/SwShgAp35hQa8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(5660300002)(316002)(16576012)(26005)(2616005)(478600001)(4326008)(2906002)(66556008)(86362001)(66476007)(6666004)(4744005)(956004)(6916009)(186003)(31696002)(8676002)(31686004)(53546011)(6486002)(38100700002)(54906003)(83380400001)(36756003)(8936002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?Wwi4z8kuLd4NKG1a/vHlBrKD6700PTs9Xy1zRoOSLbuNnh46SG18ipon?=
 =?Windows-1252?Q?e06yu5HzTDMclxyc+N0QOld9VszkrWefJHqTIl2eGjW4RKa1nOO+pdZD?=
 =?Windows-1252?Q?AagYemQWLTjC9Rq9d6F+EVUlxWOo2Pxy676YuwboRylrdijhXa8uZYy8?=
 =?Windows-1252?Q?f/s1mGDglafl0SDixL34fR2imPc/bK7n7Z5fzIRtSWVRbth4vtV9ly37?=
 =?Windows-1252?Q?eJBDxkp9iY5bM7Swfi0RfmQz0OSQW9Ba52Zer2o0xGdbgpYD6lGHJsBD?=
 =?Windows-1252?Q?y1qWWgM5cws67F/6xGUlJssa6+m+xwzNZI2Zuzv3sIKeEWXfrqX0t8HO?=
 =?Windows-1252?Q?e/LTlKHdXwcZeEwZYGr+ilhSu/E6VC/lczWvfkPPQqJNtb/UiXLVbeWw?=
 =?Windows-1252?Q?acECmZoHMZFOs/+G7+6c+pPyKvq7JTB40ZoC2Z1nYMUQXYEuvwNrCigO?=
 =?Windows-1252?Q?4BBQjUJStJbAfFm06cpOWHpdm+O1e5TNuNbOUl26bUzeWIuDvyo7yRyQ?=
 =?Windows-1252?Q?PDKPxUjgZRjoAMHi9n9fdBuVXZ/mSQkHQLM/7EVLS9fMCzi70UPHBGp2?=
 =?Windows-1252?Q?fpoqpIDz5ZLgQo9HXwMgLxWSIP/5Tym977GRsv/3taCKiOzNC3RrAuqk?=
 =?Windows-1252?Q?ft/bcWy9iIoosY7VEf1xlVVY9eE+LTx0cQ/Zbet1sYYUoIA/hD+K0BSz?=
 =?Windows-1252?Q?KbhAR2cUl8dwEX889X1R55qoB+Bx1Xnk6edUGD5Eh0iV33MDaaiUY5O6?=
 =?Windows-1252?Q?AEiUkoIgt/MmYd90T2z6wqvdjQ0bUaW7h6iGjW2GgeIUHwMZvbq03a21?=
 =?Windows-1252?Q?Ru10c7fsrOKoBdFRiNBjV2cMPFd+WipGgBjFEOaoyoxXyVDAEdnj3ZEa?=
 =?Windows-1252?Q?GPZTAy6keCk5/3FHlyrDTDy7FvweR/PN9wtQBnwyu4O9Im9+rM7QALsM?=
 =?Windows-1252?Q?9Oro/gmAKzzpymGM0vZd+H7IcJcLzwE/7rkHpBmDphQvfyz9wrOVpegm?=
 =?Windows-1252?Q?S3nLLxATqJBH+V8ZJgKwlyNLFoKGiBUpOZSVvFfxTzeHOcPh5sgPjMa8?=
 =?Windows-1252?Q?cNLFI11IxwzbjByTpafHCZSEH68qYGgHSjb0FV5m9bJAY1PZ+EJeyXYz?=
 =?Windows-1252?Q?hL/FkoGPQqX+7mBxK2V7F23F0LkztckuBduht9EcXA8gZODxi/Ee9fTZ?=
 =?Windows-1252?Q?yhi8MMM6dkTwXBbl91tF/rLCWy1xINWFlsKMqAPeL5mxcN0oI/bDrb0M?=
 =?Windows-1252?Q?E2suQ7yesNZwifZGTPQ0k+UctOq9fqcBQ6SDvi3spK7nPCCTIuP8dacc?=
 =?Windows-1252?Q?Wt6i7CDyFCIMukXrwk49qgLpn+Huuya9WJgoq8PAuYKRIZPpqGXf5FMT?=
 =?Windows-1252?Q?9SCSyiMeg+eGCUuzE6A/5GpK2cmH1pI/0CI6aF50U4kvAbuX1SQo4cUC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1c19d3-a2f9-4c56-7177-08d942015e10
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 11:13:09.3750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcLbUG55zW+U1Hdl/HQL+ewJeDhATwL1ZVSLAbPSB/thJyMVhgInVqGoA7qOM/xdFoVeWRVoMw0OWrg2x8KB/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1261
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/21 10:05 PM, Mark Brown wrote:
> On Wed, Jul 07, 2021 at 11:26:20AM +0530, Vijendar Mukunda wrote:
> 
>> +	mode = fmt & SND_SOC_DAIFMT_MASTER_MASK;
>> +	switch (mode) {
>> +	case SND_SOC_DAIFMT_CBS_CFS:
>> +		adata->master_mode = I2S_MASTER_MODE_ENABLE;
>> +		break;
>> +	case SND_SOC_DAIFMT_CBM_CFM:
>> +		adata->master_mode = I2S_MASTER_MODE_DISABLE;
>> +		break;
>> +	}
> 
> As part of moving to more modern terminology it'd be good to move to
> _DAIFMT_CLOCK_PROVIDER_MASK and associated constants (with a similar
> change for the driver local constant) - see f026c12300 (ASoC: topology:
> use inclusive language for bclk and fsync).
> 

We will modify the code and will post the new version.
