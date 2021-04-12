Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D12135C382
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbhDLKQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:16:18 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:20832
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237277AbhDLKQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:16:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0zoqqaNFEpflS1mtBJEBEWaQ03s2s0lmD3/ms0bpnScPoCaSnxvpyIQXZ1DrBmmBg1kDZxovKLYULJmOtnTD6itG0X7hdrIkm2YaI7fiiyj1LurzZQ75cN+wcr1lX7NneQrPsL6w5Pbu8yFJeikAbZ2BB0jF7EOUQPfV2SoXLYwCQ9CBeop3ClLcTZZ0LtCubjZoQwiT+ul9RIQKv5ZHWMtQxZt7HB6DdaCB4o92iPK1KdrvX2fuYwQADTZRTNXzMIMycA5FRRKkxXodsQtDUh5t+a3/WcVoshbwfdSfPTzaUOWxjbT3Ni971Iyt2H86C5eFwjMinNDwWIEJr/q4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v5kEXKvao9OQYb4EpDY4nvox7WrVj5pX+LNj42JchQ=;
 b=UiX8k5SN2dosPD4neI2q4g8A4cLupOKiD3vyoRXqLNd5xo3EI8letPAEWC1EhREqd05eyrmMnPEnDxKbtXt70SUYYRVmmL1Q5L2TcjLM3Rj80lDhQyyVWwhHxtE4QAE2TrJVB94cHq2J/wQOnR1J58/ukAKroA9yx5RK5SOg4ewiK66KHllUbxVnTbQ6wL/u1a6H73hm04JHZtFfPAgnm82NBtFQwMHnYKEeb5koujtwqOQiFTyi6MhdKpLreJx7VQTm5i0pvWo0ZUqkA6nzFBlsS0/nmfwak4vJydLTXPRAiwRhsONOtKxVAGXXD0Ow0O7SMSUMrPYFj/YsWQWvJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v5kEXKvao9OQYb4EpDY4nvox7WrVj5pX+LNj42JchQ=;
 b=l5pHYS7RMGzz5EPsIQPCVwRGtPXtiMkcLIV1Y6f3SBIhhGraSeWy8Yl0jblbP2Hp3+koXOXDmMqzeCebtEHEyTiO/zzx/biT0rT0tUcWVOzhBtg1K7ctXd09unJLH6keFkv13yjHlOuN2cvOfFAXto0Cjya2xWIT2Z3zt5YSSco=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 10:15:51 +0000
Received: from SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b]) by SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b%4]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 10:15:51 +0000
Subject: Re: [PATCH v2] tee: amdtee: unload TA only when its refcount becomes
 0
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Mythri Pandeshwara krishna <mythri.pandeshwarakrishna@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <3150feb19421ca6b15202c853215f8b40fe35567.1617615067.git.Rijo-john.Thomas@amd.com>
 <20210409084541.GE6048@kadam>
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
Message-ID: <b74535f2-b0ab-2463-cac0-ffef8db159af@amd.com>
Date:   Mon, 12 Apr 2021 15:45:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210409084541.GE6048@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::26) To SN6PR12MB4719.namprd12.prod.outlook.com
 (2603:10b6:805:e9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.138.129.146] (165.204.156.251) by MAXPR0101CA0040.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 10:15:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f62c5db6-6d1c-47c2-8277-08d8fd9bf2ce
X-MS-TrafficTypeDiagnostic: SA0PR12MB4398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB439839B482282E7C009AECDFCF709@SA0PR12MB4398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBxdWSroKt+Y9brVlLS6vsUF6R1Y/CU6lSIsHf6L/hJO1oHrvQ6yaHr7Xt/uVB8QHGeiiO/G4n4KFAb6Csm7vz3WGtcUCeixdB9DHPpn2OSzEN7wv0bsi8/EnuVPOJ5kzWICk7YMHP4IXxMjAolRLQoCGXArF5ijBBdqWrKl/ySWGO0BDxR92qRhoK7PpsNlzjD39pcwHY8hsOq94Bf2vuJSxmC3fkWSYBcBvN9gL4M1TaBt5x0jQKjz+SKB6uAyUmE8zNhhFCgDFkq1tFSCw9EsS3HOd7bW4NZFWPNxkzmEtqLwld4KGT58O+F9TK/wqGe+ug1/QHf1NyLSx4RD2dq1Au5ofj0txztlPK4cFACkM/4reto4oP2F3PfFmlBn1QnYZ1AZBZKF1lUzFrW2RTeBeM6+8jQxWD53kv62Fm2B3sfWhxwv/ll2U6C4Qbwbe+mTjIbvbKro3edWz/JnsfQeAfNhQsf/fJg7NPV5/oTJyIhOx5/Xb4ibjoiCGR13ZqK/S+kbGUi7p11Wkw1WA1CEk0Feril0JDCm3W8FSi/WMPj2pq6NhPEuVqexvazaWMpCLVcCNbvFVj1vl7SloJwUIGer2pgSRtRy3/osMQ4Pi/q6xF+RP1RpEmlkcvV/SLyzmlGV7KPMI3UzrXNPYwdYKLfxk34XbSbXm1PywQAnl/Bl3IzeHL/X0kqS4wMUFILkqS+Xj0+SwAzixJSQhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(2616005)(86362001)(31696002)(956004)(16526019)(5660300002)(83380400001)(38100700002)(186003)(8676002)(36756003)(38350700002)(31686004)(66476007)(4326008)(6486002)(53546011)(478600001)(66946007)(26005)(6916009)(66556008)(52116002)(316002)(2906002)(8936002)(16576012)(54906003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b0cvOVR2dUlZakVxa0lKb1o4U2FGd1RmOTBVRU5NRFFqOEtid2hBL3cvaXpX?=
 =?utf-8?B?VjVRdk1DS1BHbFpJVmM2aXAwSzNrbVM0TXJCWWlWY0xsald4bXRRK3NUZDFF?=
 =?utf-8?B?OU5KMnRLcTJSbzN5QURQTUJZVENFVndHSk5OUm9Gd0FmSmJ0Wk5CcUtsb0F1?=
 =?utf-8?B?c1dmM0RqTjlUNmtFTEpBOVV4TFU4bnhYMDJ2bVpyRWZUTWQvTERlTDJCckV4?=
 =?utf-8?B?djMzVlhXcjJPeEZvQmphMkpDT0lwY2M5cmRSa0s0SFZWS1c0UmxweDJreWFU?=
 =?utf-8?B?UXhsR1VScCthNk43UWlRU3JIMXMxTjlvUGp1ZDVKWUNGdXJFYjRYRS9jRlgr?=
 =?utf-8?B?OFp1VWovY3h4M3RvbVVKNU1ZWXFHTTdpWWNiNG9IbktEK2FhK0Q3RGxNNkYx?=
 =?utf-8?B?OEtiRStrYVdyWjZ3N0hSUWQ0N2I2RHZpZDc5ZjZjUStnblowWThpd25KL2Vv?=
 =?utf-8?B?S3FEei9UYndIMFlwcXRpUGJac2RidkJtaGp6TlR2QWFwcnJTeklHTHA3a3VB?=
 =?utf-8?B?R0JGRGxOc05pc1FqbjA4MmNsL2FMUVJSVm9JaWc2bzlDb3ZIZVp0VWRlN1Zn?=
 =?utf-8?B?ZzcxZXRTUHR6U2tzYVBqY2VqUDd3akdkMDFEQWpEWXlOeGJlRDFMeHZ1L0Ix?=
 =?utf-8?B?V1pEb1EyM3I4eXkyd2gwRWNhSUZYdnQxR1dVd2o2RE9wMFQyZDVlREd3TGdx?=
 =?utf-8?B?SVNVbFdIUmNaUkN2bXVrSVFidFBkYlhUTmVET1d6S0VhSTJuSi9yOEc4SEFY?=
 =?utf-8?B?ZzJ0aFJNN0RyUlVOcTA5MG0ycUp2TUZjWmpsK05QRlcxWkN2bC9QbnQ4dlBo?=
 =?utf-8?B?R3I0MTg4Szh3ZmpEVDZEZ1BYZ0hDbkYxR1RnODk0MXlvSmxvQnFrODlmNWtS?=
 =?utf-8?B?Zk5zMHlEelI2c2djR0FhZm5YTmFBRmY1TVA5OXl2bmJuUkNoTGlvdDZza0xY?=
 =?utf-8?B?YUt5YWpIRlNrdElFZzZnVGJSSXNzWThxczNmTXdjT2t1aVBpdnBqQ1h3TTlY?=
 =?utf-8?B?RnlQMC9XdllaY0J2R2xKQWFVL2NPcGRhSWVCb1h4K0E3UXFMUDRXT2Z6MkJs?=
 =?utf-8?B?UHNZYjlGUTc3a2craFZHb0EyR3NaOUx4djJ2UjcyRjFQNi9QT3NDMlF1SzdJ?=
 =?utf-8?B?bUlLY0YxRWhWM3lUNC9vUnBVdjcwQ3hiQ0kvSTJnekhuR3phdXh1cE9GTXhu?=
 =?utf-8?B?NUc5OWRuVkN4ZFJNdUxBQWc2L3YvWEd6T1VGVENlY0VUbytvVkJXeEZjTHow?=
 =?utf-8?B?MWUzMkdhekFoN3pwcDJkWU9EQVJoaTUwalV4WjR1MmJuYmxaUnAwaExBUHpm?=
 =?utf-8?B?WXpGMHZPMVZNL2JrblVEMUxkNUx0bkpPZXB0T2cwdDR4bWRxc3RWSWRDbXZC?=
 =?utf-8?B?YmZUSzZDeW5jdVVjaVlqQnU3K0V2emdXRGlWdGEwdEdETzYwNElBNHovSFAv?=
 =?utf-8?B?U1pKa2lUZitsM3Z6WkhkdElOVHpTVEorazR1cVN6QXZyV1psTTdDSW9yWXpp?=
 =?utf-8?B?bzA4VHJhRHh5UkZFK0M5SmlDU1k0cVRNTVhpOW9pQ1k5WFkvK0hYcFpDVzVy?=
 =?utf-8?B?UXJ3d2RMcG4yai9uRFZwT1l5ejZoaGFyMlNTN0lZaFJ4Nnl4Wk5hTHRTaHFp?=
 =?utf-8?B?YjNoWUpGSXJPZEZkTFZ0UDNLbWRHV3V2Ync5eTNRSkNUSkVSUm96R3l4M2h6?=
 =?utf-8?B?Zkt6R0QzRWV1cE9ZTHpNWGQ4Z0tDVzhsY0ZzdjFRS1l1czJGQTVTOVg0clBF?=
 =?utf-8?Q?dLiWwn41bFnrJFh3J4c4EgCzM3eWDMFIo8TYwBF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62c5db6-6d1c-47c2-8277-08d8fd9bf2ce
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 10:15:51.0392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChPfybCsGObjEckisAm5U6Wl59Fvp45r++ouOrlMB8x2tm5AJ/6lxt8S2EphI7aJ8/irITkZdrZPeU6pqBvElg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/21 2:15 pm, Dan Carpenter wrote:
> On Mon, Apr 05, 2021 at 03:13:09PM +0530, Rijo Thomas wrote:
>> @@ -340,7 +398,8 @@ int handle_open_session(struct tee_ioctl_open_session_arg *arg, u32 *info,
>>
>>  int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
>>  {
>> -	struct tee_cmd_load_ta cmd = {0};
>> +	struct tee_cmd_unload_ta unload_cmd = {0};
>> +	struct tee_cmd_load_ta load_cmd = {0};
> 
> It's better style to write:
> 
> 	struct tee_cmd_unload_ta unload_cmd = {};
> 
> It doesn't make a difference in this case, but if the first struct
> member is a pointer then {0} can generate a Sparse warning.  Or
> depending on which bugs your version of GCC has it can affect whether
> struct holes are initialized.  But mostly it's just the prefered style.
>

Hi Dan,

We do not have any pointers nor do I see a possibility of structure holes, since all data
members are u32 in both struct tee_cmd_load_ta and struct tee_cmd_unload_ta. So, will prefer
to use {0} for now.

Thanks,
Rijo
 
> 
> regards,
> dan carpenter
> 
