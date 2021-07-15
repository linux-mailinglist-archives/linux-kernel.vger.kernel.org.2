Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D2B3CAFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 01:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhGOXhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 19:37:01 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:16736
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229783AbhGOXg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:36:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a578J7OJPjqweCpARnihu6SygCKgWD6KFE5LBEVqhWol+IQBIFyou+6TXeMjodQiZKePr5q9dSfJLnAeOsrYn4wp01VzhPydc7VYoS7g7lI2RsqICpHA8w91Mc+4r0Zt/1SgeLGiOW385X9clZxverYCHFZbB4yraVbtXOgGqi2seEh8AGTHOHlj8gPJeTSr3rmyV5352tqpUiHL6toCsXqlR8aVunmJ31q34fMCn/0ggpAKRMeKPstlK3Do9NsvRFc+PFmcYzPzLyAY/s5hPOhEiznUMK/mk643R4Ag83zRdd5TL1I8RuVu9J0IVidStVl6XvkNLOErTO0h0lJ7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RymkvPo6CUIQarMQlO3N/H9HmCYzOd5eKSzAYOK23eU=;
 b=BvcCY8F0CjYUCun0batvXcWRfsw+w0xkfgPzcHWhgZAtc2WTgmCxYORVspctW1KzTyhSN0gRDWnnQ80C1D6OmN/cBu5bIO1P4XKGcMCLzFvDh36jM+9Qt0eB4OMCu2A+TFEgW+lMDlvdHQlfANyUzpJdEAP9fmXBzRtdCCFtDjE71jyL2EcH7BwrJps9OrRYBbGcVbSZXjWgKENMMjkraqdQhJbHK2vbPHOjOvQtNnOzIssb2EJlU2/z8m2/OS2WrtKfPusfS4xxRI4+bDPIZntjUlhaAkCYoLjo/d5amYpTMk6vinjEd/cs9J25eN0DaprG2dQNh+Rrpt/7mWI3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RymkvPo6CUIQarMQlO3N/H9HmCYzOd5eKSzAYOK23eU=;
 b=bAEIsxLBfD/pF7tPveY0uqOxwLp1Pgc4a7Z55UYR/y7uqNeBcsJK27qZdRugjQ6swHVMQeAOSCb5eS/fsEip44EBmr91+lM6uBq1kTVIvqEn/jQjDL6F6l2e8pxyxoEO8knF0mL1onBQbHDMreyjt8f6eSHtgosdUj6y3l5DQJk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23) by MWHPR12MB1582.namprd12.prod.outlook.com
 (2603:10b6:301:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Thu, 15 Jul
 2021 23:34:03 +0000
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439]) by MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439%11]) with mapi id 15.20.4331.022; Thu, 15 Jul
 2021 23:34:03 +0000
Subject: Re: [PATCH V3] ASoC: add a flag to reverse the stop sequence
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, amistry@google.com,
        nartemiev@google.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210708175529.13313-1-vijendar.mukunda@amd.com>
 <20210715141740.GC4590@sirena.org.uk>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <364b3046-a8dc-3207-2dba-22fc70ed6369@amd.com>
Date:   Fri, 16 Jul 2021 05:21:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210715141740.GC4590@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::15) To MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.93.39] (165.204.159.242) by BM1PR0101CA0005.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:18::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 23:33:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecaac56a-3e85-4b0f-4bbb-08d947e907bc
X-MS-TrafficTypeDiagnostic: MWHPR12MB1582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1582941DAF99EC99AE306BCD97129@MWHPR12MB1582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcMQOBhnsYDDvWFrNNqX++8kZlrgYZfc/n0y7CRhd+tmIPLbj/C/M86WCgoQ4Qpq8E5ql76ZMVEn/Dlk1bV7Q/CozKR16DlqSuk2h22WvXD43wNVSVS1OUdlMzifJZ29u7dRBKpFtV3sb42FdUHE76h5LJ3ytQoTbbWwWyP1yxx16XvjbX1S7GU60PAvsCg+0yps44dtDnj6QOycFLvCDql8oKJCQw9RlbJF4lL1D6BsWwbJunqevLy+nJ6lrLBWd58eW1qUlYa17aEkJdd3CHWNnG03OdXSlfeECA0mapXxw6ZbQnsZtcJcTNmArgQTJgVg6PFc2+kFoCEMvdxGOTMoojkZfkTa9Od0tl+oh3rG8i1kcdDb9X/5dCrgp2zsvoVmrsC/YkOOc0U9nTSy18kaxkoDPJJYD2EEA635uOcVk/lUvSvRffd56rcy9xkiFOJdkSH3C3c4A7NLqnaxriMMM9Race+FGiCH/tqp3e46O7epHIvKWg73UkmAtLXO5oKMcOlg/5ukvlHK816lgC7F5CfUiQNpAALauCqd+Qnu2R2TuX+plDcntJpgXplXopDvOfPaH2JBhUsZLFb8K76qYURsCB0EcdaofzcTXAGFZtSRTaZyTGr/qmaTWjxW3nnv0Z8c3Jk7ex5f0ZqYwcOxB8K9RX3x4HnnKfRyYYYfdW4xCiABz1/g6MNI5OMIM1yC2B1Gcsh9ohQntOnSEp0oL6jhrO1FfIYr/Z/jam2v0GEJFjuAFUBsVMRK/dg+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(38100700002)(7416002)(66946007)(31686004)(31696002)(66476007)(6916009)(6666004)(478600001)(2906002)(66556008)(2616005)(956004)(83380400001)(4744005)(316002)(4326008)(5660300002)(54906003)(53546011)(6486002)(86362001)(16576012)(8676002)(8936002)(26005)(36756003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?SZMN82s/ucS+A31IfoNxXcPCE58MF7PUyVaJYiS8sFmzM+FLabtaO6SP?=
 =?Windows-1252?Q?3AOqzUe65B+nXwaoBdSHo3Z1pFz0Kerv3eg40FKLnc1HDvNpSFxG0el/?=
 =?Windows-1252?Q?bNlujg3wrUNg0Jo2fSh9Y/JaQAX126DEU+AxiQRfiEhvxMgtzjr0l9YA?=
 =?Windows-1252?Q?uDrovGZRgU+7oRa6nwhN5cwH2VOdHmsOMU6Ut+G9KPazUIZzZMzLSfe+?=
 =?Windows-1252?Q?8EaADsnljLOI/MqdR94c+MgLajZhDzJva50ZVt+UfElmjRjZaRhtTlu/?=
 =?Windows-1252?Q?3o/gB2KxM/YkOGf04uw4h5JxJk7PQjijWdU60WojUJA7JE/WRAsV7gsF?=
 =?Windows-1252?Q?Fj4DwEJpo3caAU0oCLtD6HsqnCzlhz28rS7WhBy1lWNnRH3toUnQPWuV?=
 =?Windows-1252?Q?g5j1HknUN2O9q6uJ7/N7jTsaAjRw9S1Ee2eKMZou3ihL46dMDafE1ae7?=
 =?Windows-1252?Q?iq5eZFO13zYpWDBAOnjNfEolDfCYyovhd7y4lq8Vi+GCoW3AEinoIn/P?=
 =?Windows-1252?Q?qfXBPT3U2aYEPj4g30JAO2vF1QUSn3ASr21mp82PSQLMbevwOcxuMf3T?=
 =?Windows-1252?Q?yZzj143T0i+1UICTm2puanzFrAb0QPXa1SzNyDKYEri7c9220Bl2l4fb?=
 =?Windows-1252?Q?huLqoC6mYJQVpXHFn3srfilVpEisoLu4WAxmHmEnaxP7P6LnBg+oHFP2?=
 =?Windows-1252?Q?9eCD5/ov1zGIQuzQx3HTm/CMGnKN4wW/0I96CKdyIiLtyKv+ZNQLgSTt?=
 =?Windows-1252?Q?lfyN+Hj9ge0bme0WhI7BkzDYLRUup/GtMHkCgOIGsQJHzqheZcDSNfsg?=
 =?Windows-1252?Q?5sz7B1TWcBG4GOrgflMVEZNZqGYK8U13fnBwxOMW5zoF9IJXgx1MU2A3?=
 =?Windows-1252?Q?cE8tiL4Ul/UCvMXyva1JDTv175jfm45FXW+82kKSeVr/F1Ecx4rXlpB+?=
 =?Windows-1252?Q?qriBnkMH5nXeP78y62UyxAXz7gXhfcnGDEmxSEUkBONXz3UKQdbrGBD8?=
 =?Windows-1252?Q?HFl8R0V2A29rcjieyjGZ+d0a5gJKQm+lconM5vIJUt3bViVu30+z8rEq?=
 =?Windows-1252?Q?IksBnZ3UU/X803LWAosd2otdalc6qCI+JnfnY/bAgsqTgEr0EcmdypN9?=
 =?Windows-1252?Q?AQ/4rY7IbA2rETST5/KPE1CpQ4rKs0F6rr4bKkYh9g0mR27kEFk0WHUw?=
 =?Windows-1252?Q?lQlpW2/WMiN0NpoP1D1a4wQEH497hGpZ1LPnR3ZdDa1VGbX5KfgO/Xa4?=
 =?Windows-1252?Q?cu/vryjHPUOsDGT5pwtU/KPntVyyRhzDC66LZcfwlrdHkr2yFRZ7R08j?=
 =?Windows-1252?Q?ZARtZnK6TQ1pGMPt/fNHTarVdRQFMeIyo8BbQPDWDCcD53hnZTF6TvVT?=
 =?Windows-1252?Q?DjvoMJ6eKSIws7NBfCi/l7EpoDmpnxMhGlnczZkWHQ8jxZl3PAdF+aSV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaac56a-3e85-4b0f-4bbb-08d947e907bc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 23:34:03.7396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzrFMG7xBiAVaPsk8Jo8iT2Dw4VonmrwbA2YquAc9yp/Eblql5hxNYqw+kbhggedNsQoAY8JbUkwIRndbUr5GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1582
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/21 7:47 PM, Mark Brown wrote:
> On Thu, Jul 08, 2021 at 11:25:27PM +0530, Vijendar Mukunda wrote:
> 
>>  include/sound/soc.h                  |  6 ++++++
>>  sound/soc/amd/acp-da7219-max98357a.c |  5 +++++
>>  sound/soc/soc-pcm.c                  | 22 ++++++++++++++++------
>>  3 files changed, 27 insertions(+), 6 deletions(-)
> 
> This should be two patches, one adding a new feature and the other using
> it.
> 
Will split the patch and post it for review.
