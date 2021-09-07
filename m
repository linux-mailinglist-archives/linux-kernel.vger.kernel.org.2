Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38A940264D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhIGJlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:41:47 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:31222 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238076AbhIGJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631007638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ht5Nvy+2GoOpylK/+URUolfdS0Q4NTH4hoGJGk3inAc=;
        b=chUYwS0YlCL1iSb/9U0pZ3f8dcRB/cbv0O7eDwSWg3/ImxqDn/EnnOUw4rbTaTEI7pp8m3
        wpAfgG8IDzo8Of9d1BY+09WajgW41h2JjmL0pCHosG4/UkX70gOgjKmQ0PcLirYq28oMyT
        sWgXBy49ol2inhFViuOndbuXsNZaeKA=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-tG3b1woWPqWxYX6FXNuufA-1; Tue, 07 Sep 2021 11:40:37 +0200
X-MC-Unique: tG3b1woWPqWxYX6FXNuufA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYng3E49DynCqzCOhtWKiDi5a/M3gMS01niNMcEQYHPBO+By5fg0MeXrimrvHW8JSTGU/bua1wRz2C/MumwnQ41btZ15yj2QUrYxbbyRakzg+GUUlFQcUvct9GXjXj5467EXUKauNub3k7GVQLqRnHMpbk210BufoWW7VmdDl+guqOfb6ei7/bychMfQlmwtl4iQ1LebZ01PiOOjqAskOZTYYxcu21EmBt12P9U+3s9Nx8ekPJqZTNGud9nH+8Yfdcy1lmpM29te+KelrPNcaa2QPEMMmGQhXLpx9yIdZynviZkvvCg4IgCd6LKVtnva0Cek7fG7iZFqrsFfRjQQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ht5Nvy+2GoOpylK/+URUolfdS0Q4NTH4hoGJGk3inAc=;
 b=mqiU3khLQWHmkyUSBgxh0Ybgc5yq5NyH0+F8LwAuvCzjrXHrmYtmfA5e66z3s10iMvHwOd/cudKv2xDHv7+8X4Kb+zzuOXfcIS1vsUOBA+fy/kS2EdnX4mcdZhkClj9fnGsI/z3FDqdciti+mZNWeOFhJnfw5OeVS5GDBJythNIuC5PHoZa4mMOke1TIXpBuCNkdJvpGNTITAEdfQqNpRO2DsrtCkpnO0Y4fGja2E70x774uVhBl6wnA9mVy2LgQrp7W61KVZ1ZTyTZrgHDCJ0SfLiRNtIPq5IgAR+Y4XENk+3gv14m98zwW6sEJPNbb8g1iZfYQFL91/ZwlV3QXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AM6PR04MB5800.eurprd04.prod.outlook.com (2603:10a6:20b:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 7 Sep
 2021 09:40:35 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71%4]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 09:40:35 +0000
Subject: Re: [PATCH] ocfs2: avoid getting dlm lock of the target directory
 multiple times during reflink process
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, mark@fasheh.com,
        jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20210826075941.28480-1-ghe@suse.com>
 <41bc413d-0926-0eae-6772-076314bbae53@linux.alibaba.com>
From:   Gang He <ghe@suse.com>
Message-ID: <7510251b-0bf5-f14d-6c44-30385152a883@suse.com>
Date:   Tue, 7 Sep 2021 17:40:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <41bc413d-0926-0eae-6772-076314bbae53@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR04CA0066.apcprd04.prod.outlook.com
 (2603:1096:202:14::34) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.67.20.87] (60.251.47.115) by HK2PR04CA0066.apcprd04.prod.outlook.com (2603:1096:202:14::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 09:40:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cfc3ca4-6b28-4659-ca1c-08d971e38ac4
X-MS-TrafficTypeDiagnostic: AM6PR04MB5800:
X-Microsoft-Antispam-PRVS: <AM6PR04MB58000823E479A542984F3381CFD39@AM6PR04MB5800.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdp/NGri7v2pIDfLH9SMNFIUcng4zUIbFxsQiXozzjpFrU/SmfsAIel40oLRJCd+R/SdxaZCZnJjZIDMBMgxZJqS+wlJUfpMIQwCzuYwo0VBJK+p2IKg2/9YGeVn0q5NrCBjbSVGm54C6Qyg3jnYuVNknYMaQkowZ8Y70Ws3ofe1GVmWk0fzRT9ENKz2RyWcc4oNz37sFoIOmAP11d3/VSFTjW30DwUVi8VwpWxA0W/GRsMhDXv5IDT/HfKIHk98Lb12lOQwQqFBDosazXoKMg4NZ+JKIWOPV8bkygdVBRUTsS01ZVApqYoOQSc0+pCwJC1FkKjSZRI51sH5GW9W6dALJ/8GJ1izNTVi1T2SThuhesJ96SyOGvYy1VTTlqXalM2jtanJlVol2Je30qMsHx3S6F8AwqiX/Smc7WSXXS54wIamGEBuTf8Uoi/oCGVCovjxwQscWO/SgBdYaZSUvQ1zMh3Q14cs/HDXOjuaRkKwcI1OrohP4Te/yklX5LE2bFEhW++1klTu2za84qzmFEu84jUERanZnQJvP+gBSM+9znu4gfwqWeU6sCMdirfKhD8RnAgsM50ancIi+QmRRZ4l3F1ULmEB0uhe3lov3lDIHn0cnSCSEZOhkpY+IygPr90Q+lt+WPzoqX9OeFGcV08RIbb44Y+6sKwG4uAX8jGPD3DPojhoor86pil6XNR7p0T2x1h7SMJlHEWmLhv7drExRMqDBegIFEMuaFdBoCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39860400002)(366004)(2906002)(8936002)(8676002)(38100700002)(2616005)(31696002)(4744005)(5660300002)(956004)(86362001)(4326008)(6666004)(6486002)(31686004)(53546011)(66556008)(66946007)(186003)(66476007)(83380400001)(55236004)(36756003)(16576012)(26005)(478600001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEF6YkkxZ3BYOW5mMWZDSHZjaFM3SXFoNXlUWUNPaHNocWJKMjVKcWk1REQ0?=
 =?utf-8?B?QWFtZ2tWenVjYzMzNE5iUks2N0FXYncwSEZMYVhTcUJIZGVKUFZJcFU1aDdB?=
 =?utf-8?B?NHUxVkJlTDVCUStwVFpnN0VnbWZmY0tIb3lmSWZyc3Q2Ujk4WjB5QWNyaldD?=
 =?utf-8?B?T1hLWFFVeEE2TmppSk80eERqWkZYS0gvd3RJcHBQVVdBUjBHb3k3OVlxbEZG?=
 =?utf-8?B?dVNOb2RFSFNWZXhNV1ZINHlQM094cHcxSG9uYVRBUlBhRDN2bmdya1pxd0Yz?=
 =?utf-8?B?aHNqRzRFRzJPcFVrV3hOb2ZqMmg4MndleCtXd1QzbHFkZGMxczZyVHlZdWlG?=
 =?utf-8?B?K1QxalZ5QUQ3eEtGMTVaN3JmdkxUV3NFR3JVKzl6bkk4bWxHUzd5TG0rVDRO?=
 =?utf-8?B?U0t6cFhwNi9LeUlsclFvWHpScDhBR2FPTVNvN1gydnJISVU5anlKODNCNnRG?=
 =?utf-8?B?VVE2WThESGQvZkl3WlhTTTVINk5BdWRMUnMxM0RtM21NOUVCY2t0RW5sUW5Z?=
 =?utf-8?B?UzRNYnJicWlkbzByWlRFUUVOT0JseGVyOTBjMWdpdXRNdzkxNHl1U0dCRHc3?=
 =?utf-8?B?dWdWL21jcmV1cnRGSTF5bEgwS1Vmelo3eHRHSUxrbFN1WFg1b3FHWmYzV28x?=
 =?utf-8?B?ZGxKdVFhVEEvZVRueWVnaFpOU0RqR1RySVljRVZuNG1RalVDMkxtT0phaSt5?=
 =?utf-8?B?dmJ1TEsxbDNPaEtVM1FnTFdyYzJ5dkE4c0k4S1NxRktXbVpES3FLZDdTMEVO?=
 =?utf-8?B?YTh0UWkwdWNZYUpjcU9BK2p4YkkyR1dZUmxIMzFZRWNwdEtiV2ZSS3dXM1dP?=
 =?utf-8?B?VTZKcm5QdFpVSU5Hbm50RENtUlQ4MEF3UG13NE9SajcwT0N3bG84WkVacjZU?=
 =?utf-8?B?NnVrRzZhd1hwN3lTeGtDK0ROOENTMzVqM0dXNEZ0R255V1pteVU2Z1hNVUJs?=
 =?utf-8?B?bjcxY0VKTUtZdGpqS1hqeFdFTkVyN0ZPd1AzYkQ3WmRMMFVSdGZOSlpkbVZ2?=
 =?utf-8?B?YXZvTmhtQTF5S29UeHhYKzF1TGd5NEhvL080Z1RKTTlHRy9iREQvSU5BdWwv?=
 =?utf-8?B?bGtFQ3pucFNFL2dBOGRoK0lTMGNQR0JLZkJVLy9XZjZROUxaL2R4QU9zMXIv?=
 =?utf-8?B?MXB6blNkMG53RjVsa1JmeDlSTWdNUmxiNUt5SWxtdlEyMEVQdldxLzVKNHVY?=
 =?utf-8?B?ZjIrM3ZTc1RsVlVVN1lrUGdac0FNZnhJa1RZNzFXN0M3OWkySXd4SmljRUFs?=
 =?utf-8?B?c25naDFoSTFYV1RFOTRpVkoxa1kwRTlHMmxxM1pJcE1XcEtPMWF3NjNkeWU1?=
 =?utf-8?B?KzZiNzg0ZVRPbDFTY1RYV0ltWTFCS2x1NUdLaXVVN2JoM3lObjFHQ0x2K0Z2?=
 =?utf-8?B?Q2V5b2FxbXlzeTdzNnUxN3QzaHJVZFAvRnYvL0VCMDBqQ0N2VDM0dFRRTU04?=
 =?utf-8?B?WWZlMUhpdnkxVkh0U29GKzBoZEZJc29kU0lEeWk2TlQzRjR0SWR3a1diRmlz?=
 =?utf-8?B?aTdnQTFGN2JMM0kwSTloSGJzTzVhVE8zQTBOcmdEK3NKQ1NVUEVHaStsMG9S?=
 =?utf-8?B?dmJzeVBRcWRVU0hNc3pyVWN1TmF5NjRVNTZjbDVZM3YxS1MweXQwT1crQVZT?=
 =?utf-8?B?enR2STRTc2x2U29MMkg4d1hxS3U2WVhJUWY5b0ZJWC9YRHlkTTlYcEJmTko3?=
 =?utf-8?B?M1Y4dFBTVktjSXU5bnV1d24rMWcyOWNaekZhWlBWMFVhUDNrU2p0SjViMDI2?=
 =?utf-8?Q?0gRKZ9/Ad2oRHvOE74DYhpuCL4JWvAZ5Wy7qsXX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfc3ca4-6b28-4659-ca1c-08d971e38ac4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 09:40:35.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RnVw73nmICBry7HfKhvoFhtuSRfxVWeK1DAWNmuh/y0op5tFXvJl5XiTl8mPhsT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5800
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joseph,

On 2021/9/6 19:14, Joseph Qi wrote:
> Hi Gang,
> 
> 
> On 8/26/21 3:59 PM, Gang He wrote:
>> During the reflink process, we should acquire the target directory
>> inode dlm lock at the beginning, and hold this dlm lock until end
>> of the function.
>> With this patch, we avoid dlm lock ping-pong effect when clone
>> files to the same directory simultaneously from multiple nodes.
>> There is a typical user scenario, users regularly back up files
>> to a specified directory through the reflink feature from the
>> multiple nodes.
>>
> Since now it take dir inode lock across the whole reflink, it may impact
> other concurrent operations under the same directory.
> Have you evaluated such cases?
So far, I do not find there is any risk for taking dir inode lock across 
the reflink function, it will block getting that dir inode lock a little 
time, but avoid ping-pong effect during the reflink function.


Thanks
Gang


> 
> Thanks,
> Joseph
> 
> 

