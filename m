Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF2C3D04E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 00:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhGTWO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:14:56 -0400
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com ([40.107.94.77]:62176
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231336AbhGTWNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:13:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNUaGtZJzZeCVnprS7sujVpWJcPNp8TkL90qiq/wkTXG/jPd2R0d0b67F0DloDbcrd+eaiUPdtBgJVcil5CfNcYRWsUdcxJmqaaO05wTN9PHWnBNclbHwE23ESKPZZtroX/Rcc/iFeGNIZQ3g5w2O7N04lXBpmbuDZ6YjDNz5DCZc7P8d7hDcZC02EnbFD/iF1NQDOZNGcUAdmQLcr6XuBII05srvjodOr17PIpCpvFBUh5o1nWxo7ZqD8eiag5kvsTFVkGW4MuMoMJlFsaf8fINdjSwKjE6hz7qiH6CyMiM8Lo76yOcX19CZOAUtGcbcvq3Wtx/VCANJegLLi8CNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXJ65pFvqZ3Z6eqoDcXMtnu0D+tA2IlL5UC6OjgSBGY=;
 b=nuww0vo/XF+zIXO//DMuTgzrZAbGh+iXgxLgOpRFvWF4ncOHZa2ojWfxu0A3Id2Ysr/ogcjF+lgQA37m9w/n5nWrUtA1CdVCmB2OmUvwtYM/n/vZs108k3FDn/bQzt8rZP1eAFihC6qhOMVnljkQT4fnuUlsAimRA51azJX7ahCap0eCdmMSXiBsWrwkOHolLUHm8YPC8Dc30oNSyhxpPnvPn2KNIjXbvkjDPUfkzTWjvv1rNfA+TYyPNeDyZkHpdTSzP4XeL7C8FxgriaVX+JjhbnG0IaF6EdiSOqFEX2Mbym9roRKeWzRzFlfYc9TD8w/ig/GNsRsaZAw/4mpjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXJ65pFvqZ3Z6eqoDcXMtnu0D+tA2IlL5UC6OjgSBGY=;
 b=Oeoq/7YYQChqgtn8rnmBDAhmm+7/iUnTOucVYMLOfPRbVCbgdcgvKecgajnPb395BEgaMgi6j3qkMR1jJgP17dbukinj3J5hauY1SeRViIxWu4iRKLMY4c0fzb8hpvExvbraCdBcefTiwg0oRmW2wM2EJ1KV5amNuzAf8G04jiE=
Authentication-Results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23) by MW2PR12MB2507.namprd12.prod.outlook.com
 (2603:10b6:907:c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Tue, 20 Jul
 2021 22:54:19 +0000
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439]) by MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439%11]) with mapi id 15.20.4331.034; Tue, 20 Jul
 2021 22:54:19 +0000
Subject: Re: [PATCH v4 05/12] ASoC: amd: add ACP5x PCM platform driver
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
        krisman@collabora.com
References: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
 <20210720163732.23003-6-Vijendar.Mukunda@amd.com>
 <106fa9e8-1d22-dd6a-8301-20761a212e4f@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <48583e18-7def-12f8-c320-490054cc5751@amd.com>
Date:   Wed, 21 Jul 2021 04:41:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <106fa9e8-1d22-dd6a-8301-20761a212e4f@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To MWHPR1201MB2557.namprd12.prod.outlook.com (2603:10b6:300:e4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.93.39] (165.204.159.242) by SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 22:54:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0d2ae8c-7098-432d-57ce-08d94bd14ea6
X-MS-TrafficTypeDiagnostic: MW2PR12MB2507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2507A41EC2578234CBBC1DB097E29@MW2PR12MB2507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGbbwZdT/8xn0YPW77Rcb9G+8hzlzKUwJJ6YwPwZ7be1HHyOymo01Bu2o/Mvxk338Jf6YkuzFMPVoRufJOHAV1xOuKkAFWVXr9PVZQxASKQffEYD6NTNHZbaNpgeZlF/PE4ATyjTv3GuPn49iPYlKpZ1yEJIysBqAV3lOam3T1yMpu6aOkX7piNp+kyve8uE+dAcRweusoZU6Ky6Iz5LjE3xtXUJJPsvB49MTcnDgl/LqltxR6J8ebLL3L9KysErJ5k5+K1pWD/zT2Yqd1Uui5VlKVVq2oWWE2hWXiQWbEHZbVL+sKOX0aAgDaDPu9q+qdgN1glcVeEuOszYh5Q/o1OQEBR0YiFIMeWOHM2KKfEoryh9KqV9Lzq1K2FH4im6lFdyyBsbX6nG8ra7qZEHb7TKeYYYEbkVWFfjzWotaiIo87cFxUfA0+zAZtLm+Hv3mNo3RGnaeibYEBOT72jqrEzwspNqnISM8LQxUgxLcc2QXw84sS3cfyh9coeJuB6EdrqdZFZbvdRnBsuNAGeYxvQTZsaPFrDBAEndBl90vlsuxTvt3YoYgvhwWJZ8b26MG8A0RNmqdAcGt8TqRGZcORcelTgeR9upDBSaR1AJlGtxv8v9s0nMvZyDCxwS0SZZZFUpzXOASXNRvtN6P2s8ItIVSvEnbMzhyxhk9lWtKMsXh1i1QFVGsZRD1/i2arEWz351pXSRXBO3IDuw6rFbC2Cr1eBIs5H+FwJtWWEC4xv5D8YFe2Ubeq0SJKnt9yAB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(38100700002)(5660300002)(66476007)(36756003)(86362001)(2906002)(26005)(16576012)(54906003)(316002)(31696002)(66946007)(186003)(8936002)(8676002)(6486002)(2616005)(956004)(31686004)(6666004)(53546011)(66556008)(478600001)(4326008)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmpuMXZUNXJCSWZnejlRY2ZKUE5LaVhkcHVJdFJZRldsNGJkckhabXR2UzE2?=
 =?utf-8?B?dnFtMkJObjBUR245ODFNMmZhT0kxSEUvdGRMT1pId216OGthUTc4bU5RU00w?=
 =?utf-8?B?R0I2S2tYU2x3amxnUzZQRHpqT1ZENkkzZlN3ZTdPSXQrY293eVhhd0p0Zm9k?=
 =?utf-8?B?UzVxUzhWNUJmQXptVHlOaVJFSkFvUUVxbHd6MkQybDRDNkxVelVOWmZIajFQ?=
 =?utf-8?B?ekU0a2NoMkJjc2tNd1k5VGtobUx5MFlTKzhpcXFMNzFWb0dyZ28wNHB4WGpL?=
 =?utf-8?B?N0lYQmdRUjc0aGptcE5CN09QV0J5cU9JVXRRdnNLUklxM0h5RmJtQjVHOStL?=
 =?utf-8?B?ZTFWdzVrYnhZb1N0bjE0TjIwMWxYbUhHd1JDMTV6bE1HZVRXMEZLdTR5REVN?=
 =?utf-8?B?S1RQcmc3MzdacWt6YWZ3NmRDRmNMZ3d3MWxKTWF6ZFhLK0ZaQ1AreHgxanIw?=
 =?utf-8?B?UnEvTURzMFRXaHRmMmkyc2VUa1AyZGhtcHBjTUhPT0RTdWpoa2hNZldINFFP?=
 =?utf-8?B?VHFmRU90dUd5QjcrUnNEN3hRMmt3S1dpTzh5eUozVHNHa1dUZ3E3TkFGb3hn?=
 =?utf-8?B?RGFTdkZZTWJRbEY2ZHpLV3dlUitxWVI3WTZwYTJ2NUp4ay95eHNocFFwUlZq?=
 =?utf-8?B?b1E3d0hvYVlzY2xaYlk4dG9yK3BaY3RaZS9UakNUeXVSQmZ0VkxrYkwzbUZE?=
 =?utf-8?B?Q3BJbUxhWUk3UTl0Z0dDWWhLZU5BY0p2SU4yK0VFSU1yaTYycnU3Y1VNWm5l?=
 =?utf-8?B?aGFwRlU5NGt4dzkveFpIaFBjQWpXVFJyanY2cTBpOXNoNkZOd1c2RDF3Mmoz?=
 =?utf-8?B?ZVowTi9TUVVLSmZGUDJBNDRhdXVzRFhTei85Yktsb3NwY28wYkRYRzQ5MUJq?=
 =?utf-8?B?ajhDQnJTRE9CMng0c3pJRkFURlhDREt4SEQ0UHdab1VrMHNGVTd6Ry8veCtG?=
 =?utf-8?B?Ti9YYmIrMGhTWTg1cExKOXpFSnlCR2hHaFc4S2R2aU54SGxGcVIwTFlCMzM2?=
 =?utf-8?B?eHJjczN6NDdNcjB2K0tUaEI4bk52LzhiY21LTlNLUWVobk1uNEUwTEk0RXpy?=
 =?utf-8?B?WUpMSjNkSEErWENpeVZ3UnVkR1pGbWhGMGwwSFluandNMi9DYXBLdktqUGZr?=
 =?utf-8?B?djNFVCs5elMxU3lBU0FVK1F6SEhuSnBJRXpjQzdHY2RnR2E1eGZWSTZ6MnNa?=
 =?utf-8?B?eVZ0NFhvZVNReVFiamxVTDNkMkkvSUpOcFBjSEdNSXVna1dxeHNQcGU3YWU3?=
 =?utf-8?B?NllMelNteGwwR2JHV1dHcUFzb3JrdUpySHBaL1YwWEY4bFE1K0I3SDYyZFAw?=
 =?utf-8?B?eHNoeHNWKzdOQUFHM2ptWHFkdlNMdnZJYk9WTFM2dWFEcDN3dk1RZmU1OHh3?=
 =?utf-8?B?UzA0QlpJMzNkSGxFT0lTcDltVVBMR05JUHNZMFdERndCSEprd2MyV0hsUHZ5?=
 =?utf-8?B?VmRRMjRFS0ZpZG1lMDZ1WVQ3d2gzWkF6Umd5cTRXRWFYTXZOQW5KU2NYbXpI?=
 =?utf-8?B?NVdESHpBOEw5aTRsTElmRWFXQUwxelExT0Z5T3BrQjdVV0cvaG9PRDF0SWNz?=
 =?utf-8?B?S21ibnphZXloRUpFcit4UUhjZ1h5S1VmaVE4bzhxcSswZndER21sSDVRV0FT?=
 =?utf-8?B?NVE0SjFWd01hc3JaY1FhV2RES25hTElSZkdyUWlEdTIyRkdEbGRrZEFzeVNa?=
 =?utf-8?B?MWtJTnM2QktvN2picXpPTExvNGtMZUJLckJmcjFiYjRBK2N2S0d3K1NnY214?=
 =?utf-8?Q?aPMRlyHI+RR6Xo1P0oK4CllYsTY8MchviP/Wzhz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d2ae8c-7098-432d-57ce-08d94bd14ea6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 22:54:19.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeqG6MC/FtS5r2RGm8B+OWBiLI3Fu6LRDemKmla26zHATFgVY9A5SClKG5WCzvIk3qr7DZwDJnR1iJqk2WwQrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2507
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/21 11:42 PM, Pierre-Louis Bossart wrote:
> 
>> +static int acp5x_audio_probe(struct platform_device *pdev)
>> +{
>> +	struct resource *res;
>> +	struct i2s_dev_data *adata;
>> +	int status;
>> +
>> +	if (!pdev->dev.platform_data) {
>> +		dev_err(&pdev->dev, "platform_data not retrieved\n");
>> +		return -ENODEV;
>> +	}
>> +	irqflags = *((unsigned int *)(pdev->dev.platform_data));
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
>> +			return -ENODEV;
> 
> indentation is off?

Will fix it and post the new version.
> 
>> +	}
>> +
>> +	adata = devm_kzalloc(&pdev->dev, sizeof(*adata), GFP_KERNEL);
>> +	if (!adata)
>> +		return -ENOMEM;
>> +
>> +	adata->acp5x_base = devm_ioremap(&pdev->dev, res->start,
>> +					 resource_size(res));
>> +	if (!adata->acp5x_base)
>> +		return -ENOMEM;
>> +	dev_set_drvdata(&pdev->dev, adata);
>> +	status = devm_snd_soc_register_component(&pdev->dev,
>> +						 &acp5x_i2s_component,
>> +						 NULL, 0);
>> +	if (status)
>> +		dev_err(&pdev->dev, "Fail to register acp i2s component\n");
>> +
>> +	return status;
>> +}

