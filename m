Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807A93C140E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhGHNRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:17:31 -0400
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:50017
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231438AbhGHNRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:17:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNGHzLB/lQCUZ+hfLodjTVb0JJB3+r4HoD/UX186VMhLrSGtmt1k/GFp/R5t5ACKXpvMHwKBvamqg0roZ6SdSB3CcBjb6M32Vwq8i9KVSa1ns6zmIpYIKLL1jRNiGQCmzTHqBbWUDFdZNIVWrbzuk9RKrcp6FBMBSiZ4pjw1N/mCNUNgZX736hMTMFxHK+0o2uF0O/eOqGwr2IA8Q3WpeHaFmoFfGzsBW11NVvsCVnOZ6+qctmdepZB4k9xeb1lyRREINTBX2UyQuRi94jZFCHIGinQmeai9tYEkXVz6JgbUh/NGNFvSQ4vjwPrPidBkVqZ5j6bnEN7B0MZGkjCjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5OiufOCgzCwJ4Aa+6oVgev0V2t7QCtwDIvhv+uWfS8=;
 b=fV5nwAzaLS4g64L3JWmNIDTQ/nWYu2Yu0yMpdtbATUnuCkIjnZ95VZb6dHnSGmhndCKG0XzKI2Vsmq4nV3OfCdSPFNYTLmQ/ltKOjh/w5Lg73MNy5tXtSrJ0jeqauCmN+DofF8lUwG9kdOoxZXj53sGNsJeCvR01itSgXepm0AGFp3Aw21fTrN6Jkq4gs/1VTog4X9AshkAR6aYu5n6kVMx/kkExzjCvN7Kio2xDH7/b81qGcAUiPK2laV+eLP8csbgw1IRWlGl5FK6k1tcavkd5XHR8GOXaO/I2GZXWibNsaRBK0hHOwX/TrrjV0WXLZSNHqukOlQANfhSD/eb0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5OiufOCgzCwJ4Aa+6oVgev0V2t7QCtwDIvhv+uWfS8=;
 b=cjLB9k7jaqVSPTw8sYmHDEN2VOFHLHL4KLWH+GPEKWct8WSa1lZsPW3RmC3YvZv1I9tla0QgH2QK0N0n1OCtQwVv7OIh30XzjHHYkhLYFX4agk7INq37WQhNrNQmE9d7u7TcUg4EOTdLpaoFWbVN+LVKClL9fHCnZuCupJo9Nlg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB2550.namprd12.prod.outlook.com
 (2603:10b6:903:ce::13) by CY4PR1201MB0039.namprd12.prod.outlook.com
 (2603:10b6:910:1e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Thu, 8 Jul
 2021 13:14:46 +0000
Received: from CY4PR1201MB2550.namprd12.prod.outlook.com
 ([fe80::d53a:8bc9:23fa:46bb]) by CY4PR1201MB2550.namprd12.prod.outlook.com
 ([fe80::d53a:8bc9:23fa:46bb%7]) with mapi id 15.20.4287.033; Thu, 8 Jul 2021
 13:14:46 +0000
Subject: Re: [PATCH 06/12] ASoC: amd: irq handler changes for ACP5x PCM dma
 driver
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Alexander.Deucher@amd.com
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-7-vijendar.mukunda@amd.com>
 <6ae6e658-692e-70f2-6bda-ce139168aae3@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <b8f12c04-34d2-0bcb-e12e-04977bb552e9@amd.com>
Date:   Thu, 8 Jul 2021 19:02:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <6ae6e658-692e-70f2-6bda-ce139168aae3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To CY4PR1201MB2550.namprd12.prod.outlook.com (2603:10b6:903:ce::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.93.39] (165.204.159.242) by SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Thu, 8 Jul 2021 13:14:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c97aaf82-016f-4fa0-5634-08d942125baf
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0039EFE8D5D3C2F7F1B2A0AE97199@CY4PR1201MB0039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSt6NH4W5VjKJOS0P5mDpzvLrzKm0AGySiKmd2BZNPI7fxZaBtHHrCKy1jfk/1i8yboUX16HLpzC4z3FWFtNaNaKk0hnHF2Rt6v+gVUbHpP1PKB78lf+Sz5LoNMLZyxLnufRBHmPTeMNLkeEzcOsUGxRBgkp+B9zRY2SA+yVH5ROr+BCwvox8QHCNB0nBbkAo5/4M7hatlfeLnJUe46CoeVAhtuCGTsZxUaMtVLdQzPD8ZNcp5YweWXoQZ9r9lq1SL2XDHloFXAze3S6VIdDKjM7L0U7ze+rHOZrwjDeWnxSNHefcmuFhGzWvpoqEznnoXcLL0+KdF0HUxWjVSm5DBE4XwUZXCphD6y4HjTS6FnveZ/uLRtYXPxNetnKohge4EF0sUfIGiy/eYL4LLUL4fRXncbKtUkyHl/0O4glzdrAsRMN+9VkL4SKi0WdOUazeKZ+bjyhemWUaeW021Nyy77wjbRmB9B5eMbl1VV8Frc/K1/dS/a2edslQ0/xku+4XlzGSvegXZGBHGHfxrSD+BrcTz/CciVBq7zW8NvAampgORGnhOzFWAseI79I24wBUK70gVFwAbSvcF4eOI+RLY0Ibi3mwhtjMs52CNxJGitjbSAZ3SoXVNeemejWyNi1dmUOR6C53O0K5vU89j5JOqkTpw5yVNuw1qEBZkvz8MLW3jDyLMaYnpc3faTHUzwIaiwPcXKxHKB2QLmlZVqM4GjM5/0n9CTvs57c5XdTcdnGGAuqXC7sBcv4pyVLESU070uAww8zt5T/+vokjEt6/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB2550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(366004)(346002)(376002)(2906002)(38100700002)(186003)(66476007)(66946007)(66556008)(478600001)(6666004)(31686004)(8676002)(956004)(6486002)(26005)(5660300002)(31696002)(86362001)(2616005)(36756003)(54906003)(316002)(16576012)(53546011)(4326008)(8936002)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm1aU3F5TUxLMlBNc0dRNEtoUEhTbkM4eUZNTkZGK3d6RE8rNGFGenNQNXp0?=
 =?utf-8?B?M3dlUUlQVkJiRzZTalY2TXZzOEU0blE0bUpQOU9wbkpFeWFCNEpHSXVOdjVW?=
 =?utf-8?B?V3NYanBuWEdLcGQ5TWlQY3J0SlZ3a2x3WS9VbGpzOEczcWoyZlN5bXZ2dkRr?=
 =?utf-8?B?RHZndjdxVnZ2bnFtK29MUGRVN1dQaytKcUNSekloV0hPOUpOSnNsZlQ5b2s3?=
 =?utf-8?B?UE1FZlVzWHprakVtU1VERVhjVnVQSGpqVVlGYmU5Vks0bzMwQmxFeWVjRm5i?=
 =?utf-8?B?aG1VU05HK29kNi9nTnVIZG80Z3pESE53bG5icnl4NXNGR3NhVDBiQlo2VnlU?=
 =?utf-8?B?K0o1SnRrMDJaVDJNK3RPeWpRVlc4QURLOEMrd0xNTW1ZS2o3OVlLTkQ2bm5r?=
 =?utf-8?B?OTRGS1IwVFFaQi9jQU0yQWEzWnIvT3c1SWVNT3MyaTc3emMwdmxhQWxQYjIv?=
 =?utf-8?B?eWdrS2ZUNEZMZHJ1TUtIVWpieFVoOUYrVE4wMEpMd09oenRIU2lGZTBkK1pQ?=
 =?utf-8?B?MXQybWFPRTl2QitNTVhMOFplZzdWejR0THhCV0xaOURmTVpKSGdOaGE3Qnhv?=
 =?utf-8?B?WjZ2eUVublVkdTUxSkxWaWdPaFlKUzhhdFI0a01GVC9DMHFHd2YyZDByN2tD?=
 =?utf-8?B?QTh1KzQ2REZjWVhqSVdOMUJjQ1gxUmRNZklYMlQ0TnpTRUNLSDY2UklNdmhN?=
 =?utf-8?B?N2U5VmlPeklmSTQ3dS9uS3h3ejUxUnZNdVRWVjBtVTRROG9ITDd4M3R0VlB6?=
 =?utf-8?B?NEZZaVFkY1FMd2FiUWpJNWlJeXVUQ1lEeVdDY043dkgyM0MvSFhJRmtybWow?=
 =?utf-8?B?emNFOW9ZcTJYLy9XQlQ0WW1GSEIzSnNaNlRvTXNtZVVmakx1QXY3TFVkMjJp?=
 =?utf-8?B?VlZ0U0s4L20yWlVyck14Q3pKeUlFbU1wWSt4SkZwZjZjam1iY3A4Q0ZYZmFK?=
 =?utf-8?B?Sm1xODVpelJrRC92cHl6d0xiNVAvajkvVHFLNHgrRG9RY2tWMGJRR3UwTmgw?=
 =?utf-8?B?U2t4cHZTWHpoRTNTNDNESFZHeUpGbEluejNCUGt4RWd2N3RXSUhxMWx2YmNZ?=
 =?utf-8?B?SWdlTjQ5OFRQZnlNR2l0L3ZZNGN5d3JqL3h0S0xYeGl4MjhaUEI5b0phUmZZ?=
 =?utf-8?B?U1NadkxkZmFPTy80L2VWSzJoU2kwSUlEUzYyL0FCbU9KbUJ0MHdJcm9TRUxy?=
 =?utf-8?B?dWVlR3Bta253Z1lMUEpvNGV1cXBlUndiNmhRQzJNV2IvRjJmSTlMSGl3enNn?=
 =?utf-8?B?QnZiZS9MTUhwUTNSRlh1SFZFQjF4RFhRR0VQQzJ0dGNpSlhybklWYWJncGsy?=
 =?utf-8?B?NEZ1aW90bHF5bWc5S0o0bnljbDBkbjhwdGJvWmdIZVN4cDFUSUNGZk1HN1hC?=
 =?utf-8?B?N2JHeFc4S3k2ajJOclBWaFVvV2hMQ0Nxd1lOeUtIMGZKR0kzbUl3WjlMWitr?=
 =?utf-8?B?TzNMQmgxMTI0VW1ra2pkQXA5RVZPR0pOWTlQVitndHR6N3pBSHdQSjZmcFBS?=
 =?utf-8?B?UGdCc25kTmNWMS9xS0d6ais0VzBtUWs4TFdzUmZ5eFBhaWNSbjBGdDNqR3hz?=
 =?utf-8?B?T1FITlZGSVcwa2JqK0lMaStCNEtqUUlRREdOdnhKc2paU1ZBUEwrc0c4dVFS?=
 =?utf-8?B?cTd3Uk1PREJNRkVKQyt1K0dLakd4VCtWa2hTRUh6ekhmOTdkcmM4SWQxWkdQ?=
 =?utf-8?B?L05wRktIb2lGcmNMMmZwYmJoSmF6ZTN2aGJ2ZnhqTFVBVGNLby9DYXkrS2s1?=
 =?utf-8?Q?X+5n8Pn+WBKoIsphfN6iuvv7MpFAQKAbTFe1b0y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97aaf82-016f-4fa0-5634-08d942125baf
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB2550.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 13:14:46.7486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bDHzOimYRM4DHt8pcIQLirv9J/rMC9AlI0eclyilmlCU/E79Lp9I9B0suSADtWc7XivCxiCfK582nPKuO4jww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/21 9:50 PM, Pierre-Louis Bossart wrote:
> 
>> +static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
>> +{
>> +	struct i2s_dev_data *vg_i2s_data;
>> +	u16 play_flag, cap_flag;
>> +	u32 val;
>> +
>> +	vg_i2s_data = dev_id;
>> +	if (!vg_i2s_data)
>> +		return IRQ_NONE;
>> +
>> +	play_flag = 0;
>> +	cap_flag = 0;
>> +	val = acp_readl(vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
>> +	if ((val & BIT(HS_TX_THRESHOLD)) && vg_i2s_data->play_stream) {
>> +		acp_writel(BIT(HS_TX_THRESHOLD), vg_i2s_data->acp5x_base +
>> +			   ACP_EXTERNAL_INTR_STAT);
>> +		snd_pcm_period_elapsed(vg_i2s_data->play_stream);
>> +		play_flag = 1;
>> +	}
>> +	if ((val & BIT(I2S_TX_THRESHOLD)) &&
>> +	    vg_i2s_data->i2ssp_play_stream) {
>> +		acp_writel(BIT(I2S_TX_THRESHOLD),
>> +			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
>> +		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_play_stream);
>> +		play_flag = 1;
>> +	}
>> +
>> +	if ((val & BIT(HS_RX_THRESHOLD)) && vg_i2s_data->capture_stream) {
>> +		acp_writel(BIT(HS_RX_THRESHOLD), vg_i2s_data->acp5x_base +
>> +			   ACP_EXTERNAL_INTR_STAT);
>> +		snd_pcm_period_elapsed(vg_i2s_data->capture_stream);
>> +		cap_flag = 1;
>> +	}
>> +	if ((val & BIT(I2S_RX_THRESHOLD)) &&
>> +	    vg_i2s_data->i2ssp_capture_stream) {
>> +		acp_writel(BIT(I2S_RX_THRESHOLD),
>> +			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
>> +		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_capture_stream);
>> +		cap_flag = 1;
>> +	}
>> +
>> +	if (play_flag | cap_flag)
> 
> it doesn't seem terribly useful to use two variables if you can use one?

Agreed. Will fix it and post the new version.
> 
>> +		return IRQ_HANDLED;
>> +	else
>> +		return IRQ_NONE;
>> +}
>> +
> 

