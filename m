Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A893BF92F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhGHLmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:42:43 -0400
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com ([40.107.243.51]:44103
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231753AbhGHLmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:42:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAQO9MX1tq9hmUUd34gMyC62pxwfjCe7hIiNcPtSfKUigmrHUnRiBPpidV1eXLAuY712bl/YPQnVN3weiDqECZp5TyI7aR/g2TXZzNi6M+W8YfCqqBV28EDnup4VDtTP547xSdOdEV2HabdMwcENdbdBi5E5Zb/cqyxw5Rw5tFmMfELKPMGPR4QErJq7GUIrXLcXYtk83ZOtmP9/zFdEKIfyuxZtU3efW0dSIgjbKDghMcymPzNhroK1ZBexOAjUMQ+gFVi5Yphyes7/cRGBs3ZBKhkkKlgOFbWkn+yxHQj4UbSEc5Rm0Px3+h6OOZD8J+qS+LOa8NLEnZCNZGssTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oF93lj8d/CKRFJCa7P53Ywm8l3dqkeVeKNOoM+OOb4=;
 b=JFeD5EFGYK5OfS6k+fa2Y+j7ubZ1CjAzo0ip+SfczSrJp+ULmeXhzd/hXVn2a8XMAtOqiHVdvPuhwWhbG/W9V+LAAICeKBmljDpTnDp8g29//looNNrbXId6zUcr+/AoU/TwNVDBzyauxam6cWN3VG8MuH+jIOcWB2vdI6/TFIzVKHvG7Q2ngZJUWvPXjFFBFNfbWxfxjDQ0T8D8XFhoPpJHmMHiEQkUeHBODmhjurc7Ocn7b8ZXj6VWVaadvbYv8BAab6M4AHNLmw/ZNmbzTCHkwCh+8mtz2y6HylfDis43kFNTLcVSvlehPJIQVCA9BnXOLhdnZTnkILAdjWO73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oF93lj8d/CKRFJCa7P53Ywm8l3dqkeVeKNOoM+OOb4=;
 b=MP4Rk446kcpeFNQJWv784KYO2xNSzKI7vx+Ib75Pl38FUTE/pEeyGeIybu5dddSmmkKfEAqEkBB8IZABy2EcrrrN7HLIF/vDkWbRAwBHPFB3FMH1lNWsCpXg2x+xwqJWDsYuOqsTawE1iehNrw5m28QNKWExDehjbp5L9vHIuG4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23) by MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 8 Jul
 2021 11:39:58 +0000
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439]) by MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439%11]) with mapi id 15.20.4308.021; Thu, 8 Jul 2021
 11:39:58 +0000
Subject: Re: [PATCH 05/12] ASoC: amd: add ACP5x PCM platform driver
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Alexander.Deucher@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-6-vijendar.mukunda@amd.com>
 <20210707162420.GG4394@sirena.org.uk>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <5abfd669-6a54-98c9-519c-ff7b5a195ebe@amd.com>
Date:   Thu, 8 Jul 2021 17:27:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210707162420.GG4394@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To MWHPR1201MB2557.namprd12.prod.outlook.com (2603:10b6:300:e4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.93.39] (165.204.159.242) by SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Thu, 8 Jul 2021 11:39:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb367196-a9d3-4a19-d839-08d942051d4c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2379F7A830AF112B08D6957B97199@MW2PR12MB2379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ju34W9QtQYK42GVSvJHdMR8skgZY+umEnLvYQXeVwO+wB9XTgkcCbwUXdAUkQEP7nMD8H+jOBWBFotRjUmCF3znVPHfgjv1syAeJUyAoyV1D2FSm3/QIl1wW6w1WbZ9YmXfcIb+05zBFjtOf2WPnswvBUk72YrjqlCl6HbBCoiMu5qCivTcxnl6Ctq9l0M2v3ajDURAMF7XTnTniyr7qo0fz21y3wxW7qXxOVowPDnOdKQdDc/HwUIipkhieHop3J/A8o0UIw9iZhxi97G9kkntjMhOzcfb/hjyRw4efOlOYyjUsrI17HjTZ/DHDNnVxlIQjEGIegEpMvqY9lPtufUhissXo/gFPoLZs1YHa6TvZRr1wOI/guOnSvHxIs1qKz74WiyJLE8CfUr2QFcI5+aKjabzBDU6hVPaoynKMezxMtozYl4jocNK43GdkefHAZzO9mrie0UmqiwPNldIATX0VpTr4c9CglKhK7fmzgIOjFkxvB3eYyztg38hrrkgXCpXq0OKcyw5RNegZ2d14iqP+r3yMtLgxk9sb+W8rFB8Ce2AJyY0NA5OGB5qHByQ6UgB46UmtVDyq0wPO8Scdi9x/FTI/LdJG802rxmPBE7+nYwaiEHNixeG4lNXtOFuoxDASBsNlg3lBMtsvXzVLx5gUGJSOOZXQYdZV+LUszjn5J5SU5wcZRwZ6NN6afp8ALNrm5KpaUqS6BwBqAv+/3sEhmMKDB153mwfwYiHBwsbZzvsW8J+f8CEwZ/NgMZWw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(558084003)(26005)(6916009)(2906002)(8676002)(31696002)(956004)(2616005)(6486002)(4326008)(6666004)(5660300002)(186003)(478600001)(53546011)(8936002)(16576012)(66556008)(66946007)(31686004)(66476007)(86362001)(38100700002)(316002)(36756003)(54906003)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?/rMs+uqyLpwGMTh2J/F0Tlqg6Qc3Wb2uIOxW0zDu5iINhMS82kfyfyBL?=
 =?Windows-1252?Q?37T5MnV3ggY2jTi/cPyICPonYd1qJAPcFO4QI4YjJtSYeJE913sY/YhO?=
 =?Windows-1252?Q?YkjWYyZ8vpxyhgdtjf9Gl/iO7oC9xW2XDBjSmsbhEglRH+JiSL00ZSbI?=
 =?Windows-1252?Q?aIgJjLtu2GR6mfv1JLHuUBD/d/iraQSzN1ew/smVjCs1N/uEMtzmITSu?=
 =?Windows-1252?Q?JJZkjXCEQEH621XzihI1BtQTWXKgVCEsRyXqbyeh6np69Wz2UV5DsCA1?=
 =?Windows-1252?Q?2C8nCS7MUP0apoEFIzzxUIt160kLlGw/bpW+mvbTi5Pllo37NBc3MeX2?=
 =?Windows-1252?Q?cL9VjMxSDeb863g4wE+CRWhlb5jwzD1hkxVvaLFWsomvT+IbbI/KL7jr?=
 =?Windows-1252?Q?a/LZqPVCuAmN5w6s3Vkv8tKCw160FKthQBJAyMDF5ZLWI1qz2RvfrOPN?=
 =?Windows-1252?Q?wbOd0YC8MqR9QXqFHY13kpuqcGHXaweb/OS7VIRvp4jnuMuvIU7UHBgT?=
 =?Windows-1252?Q?mbye3qJTEM2mnCYjx1W87MTtXSCHaRG6/PIWfhgPVhsPy4wNJDFHr3Y6?=
 =?Windows-1252?Q?QDO6KU8TF62bLwhjdsCEMbwfmWfQYhceTAxpFW4zRFiLRZ/ImeFBj+vV?=
 =?Windows-1252?Q?FcoLJDjKq5FCHwyj9Yeb5gYAxrBuC0xFE+ipw0jSCs5BsCZqoY6D2m94?=
 =?Windows-1252?Q?AS8CWAjyemDPUJHMHhvjl5AzMgFVlN2mrIDb2ZgGOQmVn4toAxOV5Erc?=
 =?Windows-1252?Q?VWIjU36IvBoP4zeABUfRoF/bVh86DhU46gqrvf/ANdsmfetTpUlhfV2N?=
 =?Windows-1252?Q?zugVVFRdnY6GD6RoL0Jm0C5UHDIyxl8L1CwK32KWu96GZ2OEe476+TM8?=
 =?Windows-1252?Q?3+GF1mcOkIoNKI9Z0p6FYBRh8M4/XX9zqm7SjomulnFXDzd1atjCiITq?=
 =?Windows-1252?Q?HvztxPUxCXTBgZdJdJ2AfJq8ZeK8FdN7qks8LG+RYOIpncUTVMs4tZvc?=
 =?Windows-1252?Q?IV7PQj8dhGXHd40pw5mCftzTfFGO7dcbN7txsszbHM94tBtkHpfJWjTe?=
 =?Windows-1252?Q?N8bnUn9h6ZW58iH/7eQJ4zYKcXKc06icbmgOwbUJX5DR165xwpfDPH3O?=
 =?Windows-1252?Q?eS+CP3Wp9Pl81J97NsLlQPbxs1Ic8OMP1fXIqfR/EpgAbsNdGPeuT9SP?=
 =?Windows-1252?Q?U/E+lLfkTHYOzgwcxQjJVfP3jqHg1/YOPY/zpjOSilRJd/NSpZvVOZ0J?=
 =?Windows-1252?Q?eGafDI7fTngOYkRFrY3c2VjrEqFnjB/suAVavWDEjwlHfNQK1TTWpm2b?=
 =?Windows-1252?Q?ZnHZDQggt/3Ct5cCEA7xV6uzqfZKHc/Flg3rNrLHweB/cIrr0SXMCzhk?=
 =?Windows-1252?Q?ImUKQv2GiORYltBM4Sn/JQvVqzvQ02UtBnv/genZI8uCooe+98V9oMAz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb367196-a9d3-4a19-d839-08d942051d4c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 11:39:58.6629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRdDOpMokCpSzW6JQ9oV6DIeVv8EX92JxG77wEvtuGddY/V5vss5MCACoDuOw1Gp3jPBZPgPGzG5LQg+AdQ8iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2379
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/21 9:54 PM, Mark Brown wrote:
> On Wed, Jul 07, 2021 at 11:26:16AM +0530, Vijendar Mukunda wrote:
> 
>> +static int acp5x_audio_remove(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
> 
> Just drop this since it's empty.
> 
Will drop the code and post the new version.
