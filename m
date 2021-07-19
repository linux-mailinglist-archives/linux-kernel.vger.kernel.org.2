Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA0C3CED76
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384764AbhGSSgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 14:36:06 -0400
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:14048
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1383769AbhGSSKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:10:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwBfDUiK1K1ZW0QaIkSdJxpXdDd6EIt7eUTn4nboLJm2v3v1CPUW4CVbDudiH+UWSMkHNOjytMbLWnHGQ8TCG8XF49bw81iazbPpv6Y4FxI/hvr5ZInJYMMcwz2lxlwL6yIf5h4am3G4Qrd+dyf1M846kVYeHHYGS75yggPTXkjp9ay3ywbEw13TtbIK/jnMhgl/QzHpL4kxa5AJaaL5MbD3BirJZuLpwqisHO5S2/K0YI8Ih0IUKKKgU6/USxhHKcfYs19jV8dbWf1tj0D8Hk/UpeT1S/mEv7taHaMrtTzPb5pVCqnjGK+HlHzq0IaRwwX8jKB6BUHFSqGPVdfqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chu8/m1K2XhyAv8J67xfGMOYg1FWRqRVaNsdxrfn4L4=;
 b=FDzwOd8wXlHLSKaibs8ofobsFtf/JuIxCCU21r6MFbzVJto663o8dvZciR3tmL8o9YdKybfKD2BOHbmERVcG4XqnbhSHs8tp7xjKNrRCxlGKn5Pax3g8JfXPJDpuxYI7oDuLPB9Yh0RF2Wu9iYAhHySHh7bP+dILOuKuIbuidkC4ENNPPRRAZ4v8YLb5Nj7U+sjZMWOJTMIR8ovingJhP7UAXmmrF7Jx6ayua547itkWzqOwnKx57WE5+Yy0JqKyuf3jwHj2723q9n8SSKWoBLbHQueWcjj6qZ0WNH+EP9De8ij33e8PzluPuS0d+uhtpxbmfgpN/7BEOpwwuGSGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chu8/m1K2XhyAv8J67xfGMOYg1FWRqRVaNsdxrfn4L4=;
 b=tAJ/YZLwlk78/+Xy6iuEF7tYN8fMuAbGBExZF9pdfvs97l/rRtIlYpSf3PWUaTkckhqrPmvJrADd/d2BvC01utxM8QnjjT1xQpMt670gxhi9DgD3xKnCEttXWyJO8NgqIvO+m/bcPuTJgsmwwA+9vAPG7wr0vG5Y8qaIkYMpWsg=
Authentication-Results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23) by MWHPR12MB1261.namprd12.prod.outlook.com
 (2603:10b6:300:10::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 18:50:57 +0000
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439]) by MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439%11]) with mapi id 15.20.4331.033; Mon, 19 Jul
 2021 18:50:56 +0000
Subject: Re: [PATCH V3 06/12] ASoC: amd: irq handler changes for ACP5x PCM dma
 driver
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
        krisman@collabora.com
References: <20210719165140.16143-1-vijendar.mukunda@amd.com>
 <20210719165140.16143-7-vijendar.mukunda@amd.com>
 <a9566929-0fa0-f8f0-58ce-99a1e111e6a2@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <0785f67b-e927-6eb4-9ab0-cff284768fe5@amd.com>
Date:   Tue, 20 Jul 2021 00:38:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <a9566929-0fa0-f8f0-58ce-99a1e111e6a2@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::16) To MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.160] (49.206.46.65) by MA1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 18:50:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd2d2ebd-5bf3-4d01-e692-08d94ae6249a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1261F203304CC3EE7691F5D497E19@MWHPR12MB1261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:84;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MxYlr0W5pCTvgk6MiFnwYQD4++Vq4T8YeUslXAUvIGqbKUb/1+VpVpTcdJ+sJ+D9JbDrbBOBlC0SxU5LlV0C7ExJ7yU0Ugrhfkknh5w/PtMe/Ju14i5E9AgxKeQdCUMI8ZbG3WOXL5Q6fFoVsPvTXNJRb6zMercaVrwe2Gsx6mbWSdmfIEmGIDBe1mEqjX+0PSTCm1JyA+bynGeBEfbd9n2Q1mKyUlCF/VSnkstiyMqOSsyAZjm5OuOS5h2q7gNqsEELdV05I33gbl3r41eA5NEbPKRgWdZWkqaaXiuJtSIyYf6G3P0ULLiEeJNUWu/CRz9qojJvXrP5HhfiXuWQG1Yc/vu5EnvNEQzD5iPCGY9AqU1+A7dPHVYJ6mj+FasdxgTwLJqLhcPUWKe8bG3kQLcSzI/EJ2HJNdZFpAAnnImVvRmgyhkV6e3r5N2jseyWlY2RUFSUL3DpG4KxE3Ij93UCrj4rR5dz3w2dMYQ2U/gAUI+pQTnfdsM1vsWfHZ3aTQOThLhp/HfO4T6AEh/4oJXH/vchI2rL79vcDF2HJqH2PKrNpnf9urWyhibcUFUQqBqO4BERuqfbuBeGK1L3Woz3TdyzOlKGWqjQDQvpZuE17ziqRCNck7J3vJHetWK6dN96waWZhgpQ4oM44QUiSmi/ynLZIq39iO9dQdVRjgFT5Erg62H77sA4RSRMVmchOoASw+pxKwJmQnJeAa+xR/vrzOOB9dg8++fGl3FUuhInnpC9awyqF5RQK8sjkGpQn/thHg7msA94F5J9nyHQvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(54906003)(55236004)(53546011)(2906002)(1006002)(6666004)(956004)(26005)(4326008)(2616005)(186003)(16576012)(316002)(38100700002)(86362001)(6486002)(83380400001)(31696002)(5660300002)(478600001)(8936002)(66476007)(66556008)(8676002)(31686004)(36756003)(66946007)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWx4UmNPZmhuMUNEcmpETEtjaVMwTzFYalRPVWpYcGZzZUJ1V0ErWUZoZVhn?=
 =?utf-8?B?U1UrQzVIclVvRVJlbVpUWm5LNkM1WG84bHVhZTFBMlJYcS9UTE1FQm5FRkcx?=
 =?utf-8?B?cHhKK2phOFBsQUlmNURrcW1RKytGeHdxdUJET0lvd281b1pkQ2NIN3lOUmtM?=
 =?utf-8?B?UkFnWWRPdjI4NXFwRVR0aEg4QTZQWFJUM2d1RCtwZkdna1dHQmI4blEzREwz?=
 =?utf-8?B?UE5UUGdFMXF3WXUzN0hqMVdLS2FseVpzN1MyaHU4czBrSTV2SEE3eVMrYXBE?=
 =?utf-8?B?V1BDdGlnZ3YyaHhRTC83akdjWUVINWRKdkpxdmZXMWZ2SEQvNWZqNEZwZGEr?=
 =?utf-8?B?eE5MRUxCcjY3bFVabGVXWUIySXFYTk96aUFlYzBwNGdwZzlTdFZtQWVMQTh4?=
 =?utf-8?B?NkYwRFAvSktQWkpaTjRpcmRsYy9TSFdPUkwrTVliaWw4NHM5MS9oaGV0N3kw?=
 =?utf-8?B?Z1ZtUVRwRXdQcWt5M0U1LzZxNjFRYjlJMXNZRktlT3NEcnp0UVNoZlVVVUZB?=
 =?utf-8?B?MDR2cHd3UVNpS3ROZU5ld0RGVVdXM29sdGFDejNBTUhubzdpZUlKcGZlMW5S?=
 =?utf-8?B?Ny9ERlJhUWc5Y3VYSDVOR281bzVzWWpFaEkrelV1UFZ0YmI3dCttYmplcHFq?=
 =?utf-8?B?WnBEZFkxN1RpMldTVHRiNFE0T3IvcEFVcWdHVjhrL0tlRFpoeHNhREJLVWtE?=
 =?utf-8?B?ZU5oa2N4VkdFdG1qa1BicEl1L2o4a1JSNG1NOUswdzRZQStabDV6K25Ebk9n?=
 =?utf-8?B?UU5TbXU5Y0xNMS9oNXJrQXNzVFMvN3hWRGhBRVFhZFJnMnBhdXJPYzB3WXha?=
 =?utf-8?B?aytZLzNNU290ZElzR1lRSGxhcHVYQThUc2ErK3ZYZE82b05oZ01XNEZFd2tJ?=
 =?utf-8?B?YStmc0tLSElLZFpVa1EzL1BCS0R4djNvZ2V3RnEyeGZ4TUdKQ0NHamVVR1hs?=
 =?utf-8?B?RzM3em1FUnBwREVwdllWYlRISUE2cHZ3ZG1wLy9HQXh2dUpCTHU4Qy9lTTdv?=
 =?utf-8?B?STROeTlYQXl2UVdwUGprUGR3VWxIVkRBQXRXbExUMU1ycXRKRzRWSG4wcU80?=
 =?utf-8?B?akduTHlHWUo4RldHL00ySFpabHFBZm1qTUZ4K05JbjF4SnFFMmlVTHkyL2Fz?=
 =?utf-8?B?dzl4NWc2eFVOb291cUhPR2NpMUxxeXExOTRvdkZXeEgvdVNBWHlYQ3g4UTRE?=
 =?utf-8?B?NU1BSGw5dEtZZzZHZE9xUHJxMmJUdkZCTDU3SnB3WTkyVTZpRGhnMEV1V0JT?=
 =?utf-8?B?T291VVNBUW1LTU01SjJNemJrSnM4WHhqNXZ6VEptbVVPY3RJazZYQk1qQ2px?=
 =?utf-8?B?UkVrUUR5Nng4Q1lCUU16NXNlclZ0K2hSYzZvQnZXV3BiZ2RzdnFpa1hsWU84?=
 =?utf-8?B?K0QrMkJzM21HcmJPeDVhZWhGZGZLdzFFRHZUSDNnYllEckZRMGQxZEhzdVZn?=
 =?utf-8?B?OGtvbHhWVmZhQ2NlVjN1TFRnY0tYajZnRjBwU3RIaUZGVUdwNmorcXRZUVpo?=
 =?utf-8?B?bTlrSldENWFqV2dvQ0s5Z3JkLy9XWG1ENG5nUGRwaGhDWUh5TWF2VXh6K1NM?=
 =?utf-8?B?c1hXVnhKV2hicEFKVXphSUF6RVprd21ZbkVvUjBEOW9QRngwNEZMS29EdUEw?=
 =?utf-8?B?RytuSlo4ZXpueVBmbDVkWXJKcFAyeXpsYlJTQkNCdjJHdGU2NE9SdXNnVmEw?=
 =?utf-8?B?OEhEd2I4M01sZ0NmZVl1RGJVSUg0ek56eUJYVmVYeEdRYkFTc1NYVzFRTlNM?=
 =?utf-8?Q?ruiywpVtx5gGcEIKWgVdewZYr2WC0APPl9n0Pd/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2d2ebd-5bf3-4d01-e692-08d94ae6249a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 18:50:56.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urINVsaGvNf5A8Eew5uaD210M5mknSni1REX2CsFHL4RkKSOMm8mVSGvfY4QV2P181f3vx4ygYdDzWFtf2Nu2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1261
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 11:41 PM, Pierre-Louis Bossart wrote:
> 
>> +static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
>> +{
>> +	struct i2s_dev_data *vg_i2s_data;
>> +	u16 irq_flag;
>> +	u32 val;
>> +
>> +	vg_i2s_data = dev_id;
>> +	if (!vg_i2s_data)
>> +		return IRQ_NONE;
>> +
>> +	irq_flag = 0;
>> +	val = acp_readl(vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
>> +	if ((val & BIT(HS_TX_THRESHOLD)) && vg_i2s_data->play_stream) {
>> +		acp_writel(BIT(HS_TX_THRESHOLD), vg_i2s_data->acp5x_base +
>> +			   ACP_EXTERNAL_INTR_STAT);
>> +		snd_pcm_period_elapsed(vg_i2s_data->play_stream);
>> +		irq_flag = 1;
>> +	}
>> +	if ((val & BIT(I2S_TX_THRESHOLD)) &&
>> +	    vg_i2s_data->i2ssp_play_stream) {
> 
> use single line?
will fix it.
> 
>> +		acp_writel(BIT(I2S_TX_THRESHOLD),
>> +			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
>> +		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_play_stream);
>> +		irq_flag = 1;
>> +	}
>> +
>> +	if ((val & BIT(HS_RX_THRESHOLD)) && vg_i2s_data->capture_stream) {
>> +		acp_writel(BIT(HS_RX_THRESHOLD), vg_i2s_data->acp5x_base +
>> +			   ACP_EXTERNAL_INTR_STAT);
>> +		snd_pcm_period_elapsed(vg_i2s_data->capture_stream);
>> +		irq_flag = 1;
>> +	}
>> +	if ((val & BIT(I2S_RX_THRESHOLD)) &&
>> +	    vg_i2s_data->i2ssp_capture_stream) {
> 
> use single line?
Will fix it.
> 
>> +		acp_writel(BIT(I2S_RX_THRESHOLD),
>> +			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
>> +		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_capture_stream);
>> +		irq_flag = 1;
>> +	}
>> +
>> +	if (irq_flag)
>> +		return IRQ_HANDLED;
>> +	else
>> +		return IRQ_NONE;
>> +}
>> +
>>  static int acp5x_audio_probe(struct platform_device *pdev)
>>  {
>>  	struct resource *res;
>>  	struct i2s_dev_data *adata;
>> +	unsigned int irqflags;
>>  	int status;
>>  
>>  	if (!pdev->dev.platform_data) {
>> @@ -47,6 +94,14 @@ static int acp5x_audio_probe(struct platform_device *pdev)
>>  					 resource_size(res));
>>  	if (!adata->acp5x_base)
>>  		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	adata->i2s_irq = res->start;
>>  	dev_set_drvdata(&pdev->dev, adata);
>>  	status = devm_snd_soc_register_component(&pdev->dev,
>>  						 &acp5x_i2s_component,
>> @@ -55,6 +110,12 @@ static int acp5x_audio_probe(struct platform_device *pdev)
>>  		dev_err(&pdev->dev, "Fail to register acp i2s component\n");
>>  		return -ENODEV;
>>  	}
>> +	status = devm_request_irq(&pdev->dev, adata->i2s_irq, i2s_irq_handler,
>> +				  irqflags, "ACP5x_I2S_IRQ", adata);
>> +	if (status) {
>> +		dev_err(&pdev->dev, "ACP5x I2S IRQ request failed\n");
>> +		return -ENODEV;
>> +	}
> 
> return status?
> 
Will fix it and post the new version.
>>  	return 0;
>>  }
>>  
>> diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
>> index d2853738eb17..18df2b5a4283 100644
>> --- a/sound/soc/amd/vangogh/acp5x.h
>> +++ b/sound/soc/amd/vangogh/acp5x.h
>> @@ -31,9 +31,18 @@
>>  #define ACP5x_HS_TDM_REG_END	0x1242824
>>  #define I2S_MODE 0x00
>>  #define ACP5x_I2S_MODE 0x00
>> +#define	I2S_RX_THRESHOLD 27
>> +#define	I2S_TX_THRESHOLD 28
>> +#define	HS_TX_THRESHOLD 24
>> +#define	HS_RX_THRESHOLD 23
>>  
>>  struct i2s_dev_data {
>> +	unsigned int i2s_irq;
>>  	void __iomem *acp5x_base;
>> +	struct snd_pcm_substream *play_stream;
>> +	struct snd_pcm_substream *capture_stream;
>> +	struct snd_pcm_substream *i2ssp_play_stream;
>> +	struct snd_pcm_substream *i2ssp_capture_stream;
>>  };
>>  
>>  /* common header file uses exact offset rather than relative
>>

