Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A0E3BE626
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhGGKKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:10:45 -0400
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:11873
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229949AbhGGKKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:10:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTflFzmxFQKVoJtWhl6YZFLJdRgxPsTkVIvfMWx0QKihGDNV5YcqNboERqRDWz3P2ktOovHhEHHSjxSnwIRX/S6S4m+KXKLlOX9Vb5HGNtewfsyM3drElWuY+PiTKbf6QHWfomOScjTJ9W6I6vHcy0e+UfYp9pO/4bdy4CmosnWA6Wj0nYPI+AfN7zdhtdW4z13C8AL510iCQL56gNjV4Y/daboUprEfSQI1BaR51jfSJBKuFBLTyqi3KEB9UBa5bsBG3JGbGErLtBaDKud1gR9BqYwKg1vYQIulgfV2gNWxZvvF3LcrsqOYv+eM+WhKDq9sze4GGhaKYkIvvAvYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDb+bG9eOhCv7P3JJoAjmhw70PW5zDkR5sZxGuDDT30=;
 b=Z0xsLIP0oXARm+m5wXx4EdhS7UvucXtLNWPsElmbv9wG7yFbVDzTbwVIilsigN3J/Yk88pZu8NJUhBNddikqkGqmQaNwc2tpKS3j6XY0/qgyMybqQekx2qfiglHPueyu7KzonHHLfjZPJt9TctsR+4APCp+M4oYQ+KnaUpKYhmAxrtFTpHaEiUpmNSUVopuQY8LqSkeFVlH3Ztdee2jrfEMikURvfWE9t+20LV444MjNzv0sSN66D28uNyENWaejcYFkrmWs5Ha4rZlID/snfBAkWEMnrsd1rBpexcACyxXeg/Hv2Pw2vqMorv9cg2WKd6xD3u9Kileyj8NvV6jikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDb+bG9eOhCv7P3JJoAjmhw70PW5zDkR5sZxGuDDT30=;
 b=cKwdqF6XNcUbQdZDqQbajVpcR79Fl8+hSsF9vQRl4fTFrjTAHXYjTbntrvaszQv8USRu3p62vYCCn4dlrtaB5DrH+0ckpo+dsjsLbLo6w5Ro6Jwif6A4pFDYkwH/SpQUJ4kbWWNy5TqQeLvDIkPy72EERfM8lP5nEvj28vzmcMM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23) by MW2PR12MB2570.namprd12.prod.outlook.com
 (2603:10b6:907:a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Wed, 7 Jul
 2021 10:08:01 +0000
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439]) by MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439%11]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 10:08:01 +0000
Subject: Re: [PATCH v2] ASoC: add stop_dma_first flag to reverse the stop
 sequence
To:     Mark Brown <broonie@kernel.org>
Cc:     peter.ujfalusi@ti.com, alsa-devel@alsa-project.org,
        amistry@google.com, nartemiev@google.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210705193620.1144-1-vijendar.mukunda@amd.com>
 <20210706122844.GD4529@sirena.org.uk>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <07047388-6570-6501-abfd-f940777ad5cc@amd.com>
Date:   Wed, 7 Jul 2021 15:55:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210706122844.GD4529@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::13) To MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.93.39] (165.204.159.242) by BM1PR0101CA0003.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:18::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 10:07:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b5da8b3-bd49-4d7f-9510-08d9412f1a69
X-MS-TrafficTypeDiagnostic: MW2PR12MB2570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2570A340E53ACCF2FDB467BC971A9@MW2PR12MB2570.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GoToXm3RDo6i7ExqnYdlZwFKOmuBbdcZM89ZKjDtjnW3sq3cX1ZWVaBKSjYNPv0XHjBLpcCjBoEFqogD2mo80qBBzeJVEGJ/tzWwA10iw9icRFif/OVdUGS+SxkOK+G8cz9d/zR1U0twUz3f9YvNLBK9SKHzcaDl5UaGNIW5hhVznXulbbbRp0oTwGgMnCFuklZHnNKxTkW+PMyVDfcpFretNnKhmZPkgL8xYU3HDlm6wk+8D+pcJv1fNR+gs0OxkDfvuNfHOLN/4naA++UggFbl0dtAecE4tfJmCC4lA3r1C1glZ7zTJGeCgu6MiiauAf0D2okbQOnKUiFf4iNhn5Ik4bgCV7p6OzYpjS74Ai/dq5rXZabX4sZb9MWMHfjn3Nwqsab5r849hCvTxkclngHShefyyoU9FFu1a6u0SnPe0obV1hFqSFwQEImKTFfDRkeuDpaOWXz6AQIPSCxV/48AumI3KfBQ9RwNDzA8guu64NYAYFM64c6PnCP8AqNERycpRKp51YMCESET5/8boWz2uZSp0v+qBPTiU5CCRJhDLkWYfVkWVMZkpc7UTSqS1ri8q0BJB/OngvLJ+IfdHlqFrEnLsG8tTpWLPvHy4MCBnzxT47HfVCX0jTLWh0xFkcxp9MotzSjxNuvMg8idMPjWel1BF+lKO/puXiwPCuwYPl+GKfsLiy4bBf7BwCME3UCr+WZoAWxLPQ3Dwx5kHpkaaoA+T5sTbeAvWKBSqjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(8676002)(31686004)(38100700002)(6916009)(956004)(2616005)(4744005)(6666004)(66476007)(478600001)(36756003)(66556008)(316002)(8936002)(16576012)(31696002)(4326008)(2906002)(186003)(53546011)(5660300002)(26005)(54906003)(6486002)(86362001)(66946007)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?5q5Nnc7nHflas1e4DICMLCcWCn+xmnwkoTI+vWAPrZNugxh5XuGJkclk?=
 =?Windows-1252?Q?aDpwoyNRuOdTmkrGc4sXwxzwF6gabKoZYO9rNfF9ge6NEa7zRvcQtube?=
 =?Windows-1252?Q?NSqNVUvx83j9UyopIufk8ZDrfco7Ky2eU7Vo95Mtlud7+ldyGmShMavv?=
 =?Windows-1252?Q?p1nTkhHfVKFuEhd/iiJba1M2bTYEykF/EIDY9aZZFAu6m2UAwQkKXaSg?=
 =?Windows-1252?Q?wtHjEFN/82qVoK/nkHVS7okHqWS44HOdRZw6oaYlIwVJrQCU3LZCkRbQ?=
 =?Windows-1252?Q?MW3H9IL1yjgHkmAdJka+CnAhtcWQnc6H/ds21GSNHzY0z6Zt/UokgXwH?=
 =?Windows-1252?Q?pB7y76vpqoBh4nHRWoVKMN0cBVKKQYPLT5zXDM/Cn20rYT17Spz3tGbF?=
 =?Windows-1252?Q?qGY/yKs1z0gmXf6RQhXVFEc4Y5I1Vygir9OJiHkwi2EhoiAROXkDZmEy?=
 =?Windows-1252?Q?Guheess1NkGqWXXpYrGu1AZQggcqEPNMJ5MCQ27BlNoSPvhbuPKlv9WD?=
 =?Windows-1252?Q?9r/dTtNbsDUi5h5WgIgFxhcdwTlUeMH+JeVlTaiB7tubNUg2RRx2ypeV?=
 =?Windows-1252?Q?cZ6XtgccyGPH6D/qmpjJFZzceEOxBOoHK5f1iqDyIid9MxiHSG6CDh7c?=
 =?Windows-1252?Q?Y64BRf3n9MqcJplZbCDP/RlN+Vr9e5599vKkTAP1hWEbvHv+pr36k8Zf?=
 =?Windows-1252?Q?RB0toPa3xoh15yWV79Ja2iTpuK+KvpGiOS+QpedWfWXEFCTrv7v2g87x?=
 =?Windows-1252?Q?XrAvVanFqPWZtn7WFi14PV5wEFhG9BrMJeugKk2Gu+boicVdiLyDp2Z6?=
 =?Windows-1252?Q?IkobY7Pvj5/FY9gMCZ3CSA+AP8jCS1siwbWZsKcBJoH10Zwh41mKbyXm?=
 =?Windows-1252?Q?vPS2xJNV53zBX8Lzfer5CFChHp0n8ypwjhN4sIaPTRX9OdLLchTUKvxV?=
 =?Windows-1252?Q?Che72nabR63vFSk9CixyYvqel+fJjdep9f4GxOEsbi6lCd2//PTYa6m6?=
 =?Windows-1252?Q?fD2KBV9VeXO7nkznxadOS7bBL8eR4qefmFIAi0vMKXKY3eEcT4qstH0k?=
 =?Windows-1252?Q?TgDKHFtHUJDzBfQEPmi2relG0LWviq/7xs429JPy22nNewxuEOU35p9q?=
 =?Windows-1252?Q?Z86D4gCQuKWC6D87m4deixZ2njClDdOfZgo6vHSbQGsvoapbWLbGMZm1?=
 =?Windows-1252?Q?IhfG3uyhn09mgopgfRIjlpmfQOh7l5yCB81/R4aCPxLdcgzjvs9Bz+nG?=
 =?Windows-1252?Q?jB/RZhStqwV77e2PniiqDf9Jih19K4/LfHNFC6Ad7m5zPCgv5U99bI8i?=
 =?Windows-1252?Q?z7QMzyPJW6pNyQhVXE3tDBHY7D57lHiVKZg1Tp7oHZ0+dCCv2jxv9BZo?=
 =?Windows-1252?Q?erGPHImWNAQx7RrRfJPjiJZJRN6iu/jclFGTEHQ25dTTjTkfO6iGuF6Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5da8b3-bd49-4d7f-9510-08d9412f1a69
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 10:08:01.7278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hz5hFAxWGVN6eUWax2G4BE9+uaimvlL/eMMcoSSTRyjQgy7vH9x89jPDwJNnS3ReRS3BsXDa/LZ8BXzZWsQ3pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2570
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/21 5:58 PM, Mark Brown wrote:
> On Tue, Jul 06, 2021 at 01:06:17AM +0530, Vijendar Mukunda wrote:
> 
>> @@ -982,6 +982,7 @@ struct snd_soc_card {
>>  	unsigned int disable_route_checks:1;
>>  	unsigned int probed:1;
>>  	unsigned int component_chaining:1;
>> +	unsigned int stop_dma_first:1;
>>  
>>  	void *drvdata;
>>  };
> 
> This still doesn't seem like something which should be controlled at the
> card level, I'd expect it to be configured at the dai_link level.
> 
will make changes by adding flag in dai_link and will post the new version
