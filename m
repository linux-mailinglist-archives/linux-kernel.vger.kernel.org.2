Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533E5340723
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhCRNsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:48:18 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:19264
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230096AbhCRNsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:48:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgB92JsThzpSSFb6k4TGJGitEtacWNNP1ShvIZom3gPj1MI8YMg/zzIjTM+tgAh36EuE4J0jh91UTUC9JMfkxnJxgkWhTRKeEhzbuR3J9WoG3WyPIEqPObtNrCcxII1ZyqQspzthTf5xVQOucQOX+o2ga70n9t9p59IROhtnrSrlEN4bjXQL9WhkvU206f5/lAdVVwvWf3jvA0Lw+Sb6Hw+9gHcuGOUN8qE3BsgEDqBvyqGVWtKqA2NLplsU4E+mqeOEubMRFWOl6FRiYfHK0zyxxJqVDM/Anbp35GO4OjjUgA03xhk/8zcEWtjLdU7HVMEF6vnBCq8Lw+fGVFtwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXfTA6n/e9C6Pe0iBJLxGYxo6dVIA8QL2H2vM12861Y=;
 b=mvdFoM1S1TTMRvxCZjAWp5GNz1ZckvtEql79lc2t8+2igLVNl3RJaU7W5JwULrQTJqdMayllemCysp/v1v8MqWg3tqg8xESewKrFqxkDxjLqvmv2ybMRwh2fYfz6bPjNkykY5B8H7i7b2qLFd17/Ghl91pVljj+CfaJmks6wUABz1Y5tPL/Z1VLRs4QASc0y8EytDKGijpkjpqrRiRN6ivPCxjWutINVukHw0iMeixEiuhpg0rh+noBTOOMneDHbgmmgiDbnkpZawQ5ZhMTAhcnnNYF26aMWWgTI4bMbrs5MK9qQ9OniP4H28fNQg3pIqLT4gxCSN7e0gIwP8Kukpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXfTA6n/e9C6Pe0iBJLxGYxo6dVIA8QL2H2vM12861Y=;
 b=EnlWADmx5t830YN7GUlNGr5byBzYPaPq+gm2Mn+MSMqZCU7xiwcK9GYprKLEKRNK2DZRWCxnwqmKrgJGYUpe/D1SW5cXb/UWGi7v1naGDkkaStu/4V4fybNiaTdlOqde5TrR2uWi//wybYjeOlI5eRfEvjblQnj2aD2Yt48Y6jY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23) by MW2PR12MB2505.namprd12.prod.outlook.com
 (2603:10b6:907:4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 13:48:05 +0000
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::c977:4e9:66b8:a7e]) by MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::c977:4e9:66b8:a7e%11]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 13:48:05 +0000
Subject: Re: [PATCH v1 2/2] ASoC: amd: fix multiple definition error
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, shumingf@realtek.com,
        flove@realtek.com, derek.fang@realtek.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1616013238-12254-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1616013238-12254-2-git-send-email-Vijendar.Mukunda@amd.com>
 <20210318130227.GE5469@sirena.org.uk>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <062f3050-342d-9bd5-6b9d-b6488e873094@amd.com>
Date:   Thu, 18 Mar 2021 19:35:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210318130227.GE5469@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: PN1PR0101CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::28) To MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.93.39] (165.204.159.242) by PN1PR0101CA0066.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 13:48:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f297c110-320e-4dfd-fa81-08d8ea1474d8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2505D08255BEA3CC9116208F97699@MW2PR12MB2505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+k0W7WPCqfCxXgFGmtmwhjkCkAaeFazM5jsAH+PiKbmYLsbLu5WH1a5fPVvU+H9oVqnSU04sVE4CZn6mtmvq4Uy4np23h6ECVieuEn+BUC0Y5mO9j9BY7r3C/y+WRnjF3id1xdUIkbG2TX5/jh+nLtL+uYEEer80q3X2AWoOW9JEhq4G+/d5k/1biAGrI7uSCk+EF0Do9wNFC8zS01L2mv924b5uUs9yfVMxk0YtjBX2VykGHEIPlAIe3UhxL532V29ea67BsQWgRTgVhcrPu6xX6mDhlA7OdO8XFnXJ3UIXlYkeB019JQmYMBwuJr3Anp0d7pejcQ6xcvoXKHN51KhPMBZVIcB/bwyPAgYm8yqZXBzcZcq02hl/w7ZGYKop7I3V60F7sdIDtBPL4KjsEAETQxyCX1/Vv24d7SlcExc3qbAFPwTZbeGxvviH17WCSpz2Bv0QhUFGKO4/gUYsG0+2H0YdxHi4AZppNamXYIvo8Z5AdiXcfGFX/fqG4Cjpco4Z0Y3+t7wDeSqO7u6lI4RzfRKeJMsMA+PtYlFk2b6oOmL+Pl/d007Z9kfU0A8yYJK9JZmnnwbWydqWzZIyNrJcnGPJ5eTfDNejqrWbHmBEC+JuGjxAjtbGIOJNSG2rDAM5IC0TqNTyfGV0ZY8JNrx0L1IdbxkCHCs4r2UBas=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(6916009)(6486002)(26005)(6666004)(66946007)(5660300002)(66476007)(478600001)(52116002)(8676002)(66556008)(86362001)(7416002)(31696002)(53546011)(2906002)(16526019)(186003)(38100700001)(2616005)(36756003)(956004)(4744005)(8936002)(16576012)(31686004)(316002)(54906003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?jWcRQF7c4+xiVlsA6BfSC/m3iV7TJnK62/5Pu9kJ4i8Xc3ZlV7bTxoRZ?=
 =?Windows-1252?Q?Yqlcno72TNoaUwWt9Ezzfzfo+2WErK0iVCwzU1VjdAlSXXGF4LSFux/z?=
 =?Windows-1252?Q?7WQoePjLJIAl1JFloaGhJPtWMrkPX37W+n2dOZ7YU0VIowApdBvSBxQE?=
 =?Windows-1252?Q?jILjS6YF1G1gigDoRWvFtEynUxEqZSTPaL3MDV3YLxxt71oo6CVkQh70?=
 =?Windows-1252?Q?gk8Nhm8Wcc51H/Agi1U9hu+IchYJeiyOPxlhMrghGw7Cc0dBOjI+e4wk?=
 =?Windows-1252?Q?o5den+kj8qj9tw3qr+vrlqURoT1aNW+k8QJJbPFGsBcO1KRvxpOzHHB6?=
 =?Windows-1252?Q?iatmE3qfj45Ifaw+TY3DrEhgbOGcijsTr2DlhWbWZknenpXhKB4zBMZo?=
 =?Windows-1252?Q?sislIPRf2JBkOveqMv4HN5LrOu81f5ENFpLqu2M8FLRRbt8oc2oCHmFk?=
 =?Windows-1252?Q?h+C3K7ENblC4IFwQ9AEeni9q7OzX1iFCSHdOzzfe6NLK1Lhz8/ZVlTYz?=
 =?Windows-1252?Q?YnQSZHyv8uQZGPnnrsrvRidgyHV53BpKhUa/p0HyEtrk9UUEF4NR9NBQ?=
 =?Windows-1252?Q?k+oev8DYRQRMMWJAcl19bnw44hCSoVOGwSXwb3ZAAl5Uo9bGcyDLJqCt?=
 =?Windows-1252?Q?6oFDSsjD1KuGDoah/SIViT5hhNhW1MfYrieS25rVW29nD38XecXtK3NL?=
 =?Windows-1252?Q?bt11utJ0GGVNs9DRStD+151ETa7UOk1Hc8Nw8UrmU5S4ly/4rFgpGcrW?=
 =?Windows-1252?Q?JOv5nQ6umZRG3NVd0/W9D5QumtO093DNCsZjrL4kP7+riZ8rnL8n/pfE?=
 =?Windows-1252?Q?li3Dy6UhnLBG1IugU8mK6b/LfFAhJbmeKefNDj6iL96+CK+eT6nSpadA?=
 =?Windows-1252?Q?MV8VVgGcfCwSb6Oy0Z8X+rXzl8k9TvCUhRidRpdltWrN6Tw5vLSqzHX/?=
 =?Windows-1252?Q?lDKWUAjG6w0mWBixIrjDkbS9aO95QSkX23+WWx3jk5JZ5fj+xuCKRC+y?=
 =?Windows-1252?Q?BicAd6jgt+pxB8Oq82hiSvamiJGCf78in7eaUVybdkvm4HXC6Kh676A2?=
 =?Windows-1252?Q?40twjXj4BPJcdc/oYLPlpqK3RIajrfE0FX3BUMdXpJf3jGwRLDP/jVe8?=
 =?Windows-1252?Q?udpRFj0TvABVttIs8ZpLXQAIgMUUvuHdSClIvY1bP8M60KfU3sP1zQWI?=
 =?Windows-1252?Q?3Y7MN/EOZbKUQSVEupJ3EToM4Tjhr2+F4Mh1thTnFCudK/cAzqMvYYpk?=
 =?Windows-1252?Q?YLDqhglfgrlCt48mDBQ0OwYYv5oFANq0oA/LO5M9V+UFK9ML40B4DaFE?=
 =?Windows-1252?Q?LPUWwJI07n3S95VqCiAI8kfyMGaFml/klMEfWxpvYiaLSNn3XzMp1cTr?=
 =?Windows-1252?Q?X46SxctVfcBPjpotoZKtPAw0YUZppV8pgc1yZrCvOpLrCn8u64FKR6s1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f297c110-320e-4dfd-fa81-08d8ea1474d8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 13:48:05.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQij5mNFWq+MVpLhFSA0vmGYuZtbL93uTlfXEVIZ8ck4EE58RAgfvJr34EPQC31k0Gx1gvXiOPPTJit0KU/cXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2505
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/03/21 6:32 pm, Mark Brown wrote:
> On Thu, Mar 18, 2021 at 02:03:47AM +0530, Vijendar Mukunda wrote:
>> make W=1 ARCH=x86_64 error:
>> acp3x-rt5682-max9836.c:(.text+0x840): multiple definition of
>> `soc_is_rltk_max';
>> sound/soc/amd/acp-da7219-max98357a.o:acp-da7219-max98357a.c:
>> (.text+0xd00):first defined here
> 
> In general you should put fixes at the start of the patch series, or if
> this is a fix for patch 1 that was spotted by the bot when it was posted
> on the list then you should just roll your fix into new versions of
> patch 1.
> 

We will roll this fix into new version of patch I
