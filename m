Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878DD31526C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhBIPLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:11:38 -0500
Received: from mail-eopbgr50103.outbound.protection.outlook.com ([40.107.5.103]:12207
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232047AbhBIPLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:11:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBke6dHGSWPXUjQc4tENEpcxdGpEoPAd9AODPC2+u1nkO/VbwoC5t+is7BOlUEUWSKBH551A+3VjgBtGXkZZjZb0hWcVJ2NykXLRZB4HXIZF9/+aY8ZjMtYep/bYial4zXwNwjH2lcvvakCVJplD/gHr+e4AwgaoZJ4UzfpZZVrxDHhxdERSptygID9PDBLgc12ufMOIq9ku/YSkyhnpYWOlKg2VQ3xKIpX/DD8If+ecxNAWlc2fqBmmFb8zdJOB6zWPL2JLd5v7S9GPdW57amBlSSjhboOPdkpfZK3vtYs+ri/Ca1Tuz6fFpGWYsrE5YC6xHLwxTfEuMwcb6hLTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyoL696bq4xidxRUpc1FISybHNBP3GZqqqdOKBsqa38=;
 b=fkNltd2Nv1CJI5pTUfFlU0JEetSUsipitXcFOG9vVpD3NqSTGRCFE+c7lWzIKOaCvwxD4cvGlZ5Ctv4NycvG9Sbyu2/KGqIAEnBgXrUiAYZEsTJ6ONbvoaZVTloRMfrcI61VS7Drbz8rGqisHj+XQX/7F6KJeYoCWq+vJwOyQNfguGQXLfpHlODh2wTy1mxkAnE+ILQrxfiexB44hUzB2ochaimu1J+trbhxTWS3Gt39WUpPkzKwzxAchqB19KHSOQGjVExBH1cB4dhVYSrc/N5zcm/Umf4athiStWpg1AAgC5Pt1jA94iLK2GU8B7PVTQHwaweCEGYybR2SFcROig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=studio.unibo.it; dmarc=pass action=none
 header.from=studio.unibo.it; dkim=pass header.d=studio.unibo.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=studio.unibo.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyoL696bq4xidxRUpc1FISybHNBP3GZqqqdOKBsqa38=;
 b=i4IniqDx76AI3yq8EEsKnUTwQpIosUfm5dS3lY/rdH02yfHh0u57YWdguYor+og78k7ma7/xGmeclMQy8jVxDbALVqFTMFWvmsKzSIjJWYRjEhCcpIq/26PgEJZhD3SPLlfK8mwBSTKOC0+aqLZjevWJGAsyTzKeQlACayCMF9c=
Authentication-Results: narfation.org; dkim=none (message not signed)
 header.d=none;narfation.org; dmarc=none action=none
 header.from=studio.unibo.it;
Received: from DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:19a::15) by DB8PR01MB6472.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:154::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Tue, 9 Feb
 2021 15:10:44 +0000
Received: from DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 ([fe80::39e5:9fa3:1133:7922]) by DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 ([fe80::39e5:9fa3:1133:7922%6]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 15:10:44 +0000
Subject: Re: [fuse-devel] [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Richard Weinberger <richard@nod.at>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Ron Minnich <rminnich@google.com>, sven@narfation.org
References: <20210124232007.21639-1-richard@nod.at>
 <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
 <563952295.378372.1612881357746.JavaMail.zimbra@nod.at>
From:   Luca Risolia <luca.risolia@studio.unibo.it>
Message-ID: <3a9c19cf-2c25-a3bf-a200-6d223952797a@studio.unibo.it>
Date:   Tue, 9 Feb 2021 16:10:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <563952295.378372.1612881357746.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [151.41.227.128]
X-ClientProxiedBy: ZR0P278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::22) To DBAPR01MB7109.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:19a::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (151.41.227.128) by ZR0P278CA0012.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 15:10:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebeaaa6d-c7d4-4c27-48d4-08d8cd0cdf13
X-MS-TrafficTypeDiagnostic: DB8PR01MB6472:
X-Microsoft-Antispam-PRVS: <DB8PR01MB6472F706FD6B42507A63D47BDE8E9@DB8PR01MB6472.eurprd01.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EovliBl6+1VRKtryYjFcmRHev5mVi9H3JQ+7SQbrR6hkPRa5ZwZ2rGe1Ak98uhux4d6wFbtvVCBKIu/rGc202eh8OAv1UHiJ1aEUBe/26u/o0cZnQYS+qyiudWRNDAlaQmesL+6qwUT8siOA7TMF2Yl91dvm+7kX6uLKQfymSZrXyTkBDUgQ7TinOkeJt8x5YTFEUKntF0OdjIIk9ac9faPO7ddLI1EW5ZA5CywvYzNQtUFwIMvlO/cXOyMGZDBE1RZ15H2upA8qzazoeHBjEq1mCdweczLMzihz0Xg5DWXbfZG+bYrAIwEiffnucyvnE/3XKxM5jdfVHglAtGEDPqV/psr3Zpi9kIbN5YqJ2QknkaVDOl1wGhRTxr5HxozzVEAtuvItUxr7dpmXmkFpxSlIfMfszZPUmFhd73X9OsdHS8fAsCehWB6vckl2PTj8n/Avrr4V8qGDvFXOmM06Ag/ZXOCvG6QgN8ZjpiwVpROnRPNm3OcE98kU4bUey1hvrSN97Pafm9EUl0uwIqehQ+bOQiyb6wCSgyg5znsW7yZ/oUUkIeQmzKYkyGMxe6ilGO4dO9vJfVA0R7dFYazea7DE/ZDFRQnL/BOR2U9F3mQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR01MB7109.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(86362001)(66574015)(31696002)(83380400001)(316002)(4326008)(8936002)(786003)(26005)(186003)(16526019)(52116002)(53546011)(2616005)(956004)(44832011)(66476007)(8676002)(5660300002)(7416002)(31686004)(66946007)(66556008)(6486002)(2906002)(16576012)(54906003)(110136005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?clpaQTRBbUkxQUo5RjVXK1JBYk5zR09xblB1eStYdVp5cWVzQmJJL05WYkJ3?=
 =?utf-8?B?OHJuZzcxMnZLbVVCT2k0TURyUlpIMVkxRUZlcTBaelJMR1N3WGxWcWYyaVU1?=
 =?utf-8?B?eURuNzJFbktyRkRoaDFCeTBsVkF5OHpua2drYTdGaEpFeFZTaXk4ODhyZVRz?=
 =?utf-8?B?WE5uLzl3SWtWWjlidzZlWTlyOGp6WDlQeTRJWW5TTU1Hd3VhNGJlRHNLSGdM?=
 =?utf-8?B?OTJaQUZRSG80QWlnMUlYb1JLODlwbGZDNVhVdDZLMjhtc0JrRnJRd3BNcXJh?=
 =?utf-8?B?SU1BY0NCZ2szRFJGVGRYbU1GL2krMFc3c0xMclVsOTNMOU9QeFhGTkFIVTFM?=
 =?utf-8?B?Q29UMUtmVmd0a2R5ckpETnpCWk5yUXlWWlRzV3ZsZzRvT240cDh0eWt4SkNl?=
 =?utf-8?B?NlJWd1hud2lLRlA4ck9uMDJlY3NTZEpmUkNFeFZnWmV0M3BFdW9qVSs1V0dw?=
 =?utf-8?B?QVpHYStiTytHOFA0SHI5K2syVXllbkI0YitsSURUTGZmSDhLd3NOeGZaMERB?=
 =?utf-8?B?QWFXSHlML2NKbnRyY1EyaUg1V0xkUWptdE9wVVpOQmd0LzBta21oaitZSjhy?=
 =?utf-8?B?TjM2MUVEdXdDRVlZZUZ0ODA0SzdYN1ZkbDQ1U2RnRFVSQnlqcWJzRHpsN0Qr?=
 =?utf-8?B?aTBPa0ZVR0lJWHZPTkI2eG4xRkxMKy9VUWJEUWY2ZDlMbUk2bS9JOWl2SnhQ?=
 =?utf-8?B?Y3MvRkNJbE9zNXIwNm1vTzJ4RFdsUGd1QzFzZEYyYXVQY2NQWWdzVUFjL2pG?=
 =?utf-8?B?MDZHUCthbnNWR0MvS2o5Z2xVczQwQnRuNDR2NHJsWHBEUEs1Q3MwSTgxVUM4?=
 =?utf-8?B?MzZKUnU4ZlgrYUhDek5ZbDRYbzJnMnhXV2hiWVMvQU5MNUgxUVV1MEdLaitJ?=
 =?utf-8?B?K2kvcjUzMkN5cEZUUHBqVi90Tmt3VEVGUzlINi9hbmlPb3lUSEtLQVFMSmtG?=
 =?utf-8?B?RXh3aXF5K1dTK2VPbUp3c05RSWNuRCtCeHhNWWhCOVl1YVdMTmVyQklQdmFB?=
 =?utf-8?B?b252b1Bhdmk1SmFtRjVjd3pCSFJMNmhJbk9PZ2xSUVE3SGxTelQzTVYxT3dh?=
 =?utf-8?B?aWx5bkpQN0dSLzg5K2JSbGNXcjZybXpDQjhsNHdlTnlwYzhjL05WQ3I4Q01w?=
 =?utf-8?B?ZlNEdlg0KzFhRjlUSUdLbmdkSkJmL0hFUW1TOWw1MFlXa0I5eHdwV2R2ODFu?=
 =?utf-8?B?ZDdDWllGT0RyZmk3Qjg1K3liYmtaZmFNMmVGNnV5ZXdqWE4xNGpmNlVVaEZZ?=
 =?utf-8?B?c1pUK2tkZS9DZ05SY0pYMnNFNHhXckVJcHdUL0tWOUVKbUxXOEYvZWcvbU40?=
 =?utf-8?B?ZHdKZ2J4aVZiN29hNS93RW12Z1I4VGdrWnppMFFjVFZzNTdhQk5ObFpEaUVl?=
 =?utf-8?B?VkFRc3dreFZ5S051RzVUaGRxS3ZuQzB3VkpYSTIzZ0NZRjdwdXRjS2lpYUxz?=
 =?utf-8?B?RjQ3aE4yVWdyMjJsbE5aY29Rc25ldUJIQWoybVBhNG1USjdrVGRId3E0VHBk?=
 =?utf-8?B?bkJQbzR2VHVaRGd6VUFaSFBnK0VzSXEzeXN6Y1o2aGp2UW9GRWpZZlR6SFpJ?=
 =?utf-8?B?Unc0RFlZV1FsWkNIaWlwU20vMzF4RUV4QlZzTjUrQkI3MVhCRXp4bzRsbUxD?=
 =?utf-8?B?QUNnR1Z5MncxeVRJeE9uNWhTWG9aUGZNR25zV3dHY1EvNzNrVi9JcjF2akFv?=
 =?utf-8?B?N3pia294OEsvUFZ6OWhRL3NjaVBuSXVzaVhWdk4zUzJSNFBLb2pGQlMzWC9q?=
 =?utf-8?Q?8CT37yprKtHF6RG/6rsQnlOYDKKV7Piim9pcPrU?=
X-OriginatorOrg: studio.unibo.it
X-MS-Exchange-CrossTenant-Network-Message-Id: ebeaaa6d-c7d4-4c27-48d4-08d8cd0cdf13
X-MS-Exchange-CrossTenant-AuthSource: DBAPR01MB7109.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 15:10:44.1577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e99647dc-1b08-454a-bf8c-699181b389ab
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrbzTEUQpr1ZtAVY7nnBXcUbcBUEiQ9P4zrwP03aKwUuy6BpS//SFjYfo3WrVSG3PFmKmcQJLPbC+XFjoIGubnaQ9zgGsMG6tr2j0F9TGoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB6472
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

a bit OT probably: is there any chance for you to also implement mmap() 
for CUSE? That would be much appreciated.

Thanks


On 09/02/21 15:35, Richard Weinberger wrote:
> Miklos,
> 
> ----- Ursprüngliche Mail -----
>>> The core goal of MUSE is having the complexity on the userspace side and
>>> only a small MTD driver in kernelspace.
>>> While playing with different approaches I realized that FUSE offers everything
>>> we need. So MUSE is a little like CUSE except that it does not implement a
>>> bare character device but an MTD.
>>
>> Looks fine.
> 
> I'm glad to hear that!
> 
>> I do wonder if MUSE should go to drivers/mtd/ instead.   Long term
>> goal would be move CUSE to drivers/char and move the transport part of
>> fuse into net/fuse leaving only the actual filesystems (fuse and
>> virtiofs) under fs/.
>>
>> But for now just moving the minimal interface needed for MUSE into a
>> separate header (<net/fuse.h>) would work, I guess.
>>
>> Do you think that would make sense?
> 
> Yes, I'm all for having MUSE in drivers/mtd/.
> 
> I placed MUSE initially in fs/fuse/ because CUSE was already there and muse.c includes
> fuse_i.h. So tried to be as little invasive as possible.
> 
>>>
>>> Notes:
>>> ------
>>>
>>> - OOB support is currently limited. Currently MUSE has no support for processing
>>>    in- and out-band in the same MTD operation. It is good enough to make JFFS2
>>>    happy. This limitation is because FUSE has no support more than one variable
>>>    length buffer in a FUSE request.
>>>    At least I didn’t find a good way to pass more than one buffer to a request.
>>>    Maybe FUSE folks can correct me. :-)
>>
>> If you look at fuse_do_ioctl() it does variable length input and
>> output at the same time.  I guess you need something similar to that.
> 
> I'll dig into this!
> 
> Thanks,
> //richard
> 
> 
