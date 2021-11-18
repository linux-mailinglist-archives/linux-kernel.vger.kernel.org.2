Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32BE4553FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 05:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhKRFAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 00:00:39 -0500
Received: from mail-am6eur05on2138.outbound.protection.outlook.com ([40.107.22.138]:21985
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229579AbhKRFAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 00:00:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBUL58rBD5A95olH3A/ytkRfO79/g6sEqgvQ7zIf0d9Rpzd8C4vaN2O8XFSKR+8eLCmLiY3qVQkccpJ7cXdbZOX8oFNMNCL6XAhBurvw1VrAujDtt0BFSVmGc9kBMEt/9fy9gP54LJIwAQD5lF6cXk1lpncCDvg78TteQhhbkZMprjZ/EgyL75t3HaS8aSX7iC8Fxq0Ck+2JuqTV6Ks3KraKnefqDRjqNjVmW3283DQxylCGEbsl95vAFiQLhFxkvNn403M5XB8sgmBbAt6I8+sqK0ofhkbbwfCGuOu2FYFyEsxnHsr7Mfowy8mSSw9s/bpJDmBiZVDzkGRBfmOP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFCXBKhPDeOLrqXrkCzFlAC6oy6j8mW23BwSPneIlZE=;
 b=H2gbPWmAMypFFloaOUrPzS4NJRBzdhUjonCRk/271x0b6QHqbKRQscrUbA45BOO1Y03FUfDEy6sFzjJ9OqMMYoaErRjpXpVrNFrTURaZLOE5XkUQJlX7Zb4bRtfDFjiyA0+f1zWyzq99ffdmFmw0UZs73IPGMecvP9yTey9EAwefm1UUBRrRK6eU45qL91f8+gJMd04K96AeO2xt5KW0+V2HNypeu3MAb4bY0H0O/JUytQCz4JvUdfN4FS4BWZGBm8jgwi+/nToOplgslX5Oon7jTiDcTTJLuI2PUmOLIMMAR1up/QOz+giKgHiG2rt1npM1OMfoaAzJjrNPLwS77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFCXBKhPDeOLrqXrkCzFlAC6oy6j8mW23BwSPneIlZE=;
 b=rK9d36Y4+WbbWo0VZwK6VtEaJErPqZFNDJaqbzbj3UfCuPus7wsXaRvQdPNi63AKtuuHWWiHWGUa9NPoWgY/6Qt4yH2hC3Q7bj2vzBFVkKbTilUWzx3V3uysWUvrnxUu3fBOrKh2W6iDy5bq1ZsMcozXuooqT2CiJBJ/V7iSqO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by VI1PR08MB3053.eurprd08.prod.outlook.com (2603:10a6:803:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 04:57:36 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::f875:8aa8:47af:3b75]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::f875:8aa8:47af:3b75%7]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 04:57:35 +0000
Subject: Re: [PATCH] tracing: fix va_list breakage in trace_check_vprintf()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@openvz.org
References: <20211117183720.15573-1-nikita.yushchenko@virtuozzo.com>
 <20211117183827.4989cfab@gandalf.local.home>
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <ae2254dd-dcc8-3375-e8d6-efb73e280574@virtuozzo.com>
Date:   Thu, 18 Nov 2021 07:57:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211117183827.4989cfab@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::26) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
Received: from [192.168.112.17] (94.141.168.29) by AM6P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 04:57:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5caa7216-0bd3-4f82-c468-08d9aa4fefde
X-MS-TrafficTypeDiagnostic: VI1PR08MB3053:
X-Microsoft-Antispam-PRVS: <VI1PR08MB30532AAA79AEAF631722BA65F49B9@VI1PR08MB3053.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBItKO1xRETzoWxrj+7pweFN8fQLIVgNtxhsQN+GbHOXOojNIGTP09d3EIA9Bqbg8A8spSFqxSrAaFt/hTXLfseCSClX2fOQ8fnwJHYuQoTWFS6RtXyYLmk1/gkBbjG5Ga/t66iUUvJbxzKr/APYjQdnwwOqNyi0RUcuXzowyRhGSqi3He2LDUsxEtdJqqtG/eME8Xnj6UUWOpqQXXaj8wZQWzRT9QGJ2wJAVfmeKMHXC8lm/6a7T3PUMnWeaPH71KoseVwQRi7WrdB7jy/Z6Nnxo6zS1v9blmGSAAB97FQi8xmMOaQ4ij+vYujDAG6VTCwpfLclj8h4C73yAzwfxo42TrNbN/n9gwVclW5RBH77f8LZOunH5oWSfQKmO7KM1sbBPJJ/FGGIlfyAGvj7apG3xiGD3+IIkLMeFAO3DQPBGVD/rI9MzVE/lxlJKzZkE286fbYCYFCRpogFK7epLOTkmnqz6w+9NMOHw67J0N4sBmiUKnTLaxrebHeecML3gcqvBjbaYnOOx15HbwU4HKe+5YrbDt/LDOFsGnoPiEcqd8o6Lm5rX+lvkDm7fULsp21soOR9a0ZEjg+PUPq4WjYJPMp09bZ6W3uchhfOaT+GfevOr/b3dKqJZGYPN1xLa/tMcCjfbZivnfjI6bzwEEESu3K4Y5hiYDJgy3T+yz9OahCZ1ZvhN0IfT8y7xjuCFWDB+3pzZxWBVNpyK2aht6sH1CxyQHws+PukfpMUdX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB5630.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(8936002)(31686004)(44832011)(8676002)(86362001)(186003)(4326008)(2906002)(2616005)(956004)(16576012)(31696002)(26005)(5660300002)(6916009)(508600001)(36756003)(107886003)(6486002)(66946007)(66556008)(66476007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0pqM1ZFZGtJU2FJMlhvUkI1NDZ4Y3RFVVZSWWZnRFFYeWVwdUJrb1EzQTJK?=
 =?utf-8?B?YlZKNHh4OGRHdys0Y0xlL2UzcEljNVBmcm5uVTZyWXhTelRwRldXOU5hUWI0?=
 =?utf-8?B?L3F1TVF1d1AwdVZrZmxxTUxQMml2SnVzNmlCcjFVYWQyQUJpblE1RngzV3Vo?=
 =?utf-8?B?QW5Nelhyb0FmcmdQTVYranAyTVpqZEhsa21nOTdJbXlOR1UwWUkwMWQ1a3Av?=
 =?utf-8?B?VTF3VUF6WXBKWG05KzZ5cTl4T3Q1VGRDNDZtaWh2M0Z3QjFCNENMSW5FVm5R?=
 =?utf-8?B?VzAyQ3R3VGcyNHZUZ1BpWnRzeTBGRXozaEtIY09iMHl1ZnF0VXpKYzlkaDdQ?=
 =?utf-8?B?clRhQk5FaVFyRXFXWnd4VndIcTQ4VTZsN3VSbEtMT3VldUhFVnFYbWEzd093?=
 =?utf-8?B?Q0ZlT0lDVFNOSGpwMHUvdE1sYmV3dnNrYjlOV0s4b1NtckNNb3VWNSs2Mjlv?=
 =?utf-8?B?bXZ1Uk9tbGZIdFNpaTNwZXl6cnlpRFpITEs5cFJyVGpIb2ZHU3RpRWxpRVIx?=
 =?utf-8?B?anNHOTNPYWhjTGYraStONW5ERllpWlNpMmNvcVVsSkZlZUI0eXlzTzUxUjVV?=
 =?utf-8?B?Y2RTS0ppcjJUOHpNNTBiVGlTNEQ2czI0eGhhV2xFdm44REw4REVIMU94RnNI?=
 =?utf-8?B?WHJDVWV6c2FSQWpWaWM1MHBqeSt4SmJyNFQ0UlVOcWpOTTFqd0tHMmRmMk1G?=
 =?utf-8?B?cHl4eXZqUXRDTTN3bmVMU1FGSDZ5RlZ0VEFoT0ZNcFNuaDB4aFRJRDFhaUxl?=
 =?utf-8?B?Y2p0Z29tODAvNFRuellUSlRtNEhaZ0lMTEtkTFVaWFd0bHhwWkhETDRZS3JR?=
 =?utf-8?B?bFhUSTdZZlpDdmY4eTNneGZFYkJZc2ErWXllNkh0SFh1QU03dXpaZnhkZVFt?=
 =?utf-8?B?Uk9nVE1OMnliVlZKYXh0S2FIRGx1dnFpK1VLa2pXODQzUzJYRlZKeFl5ZzVl?=
 =?utf-8?B?UnNsamF4N3l6N2dMUEtCb09BR1RqRzBjbUFpSURvR3YycWJPWm5sRUxIUWFv?=
 =?utf-8?B?RnUwS3FJZTFWU3FBTDBjNzhQTXJHTTZYTGgra3B6T1J6cU8xZDVuUy80SDRN?=
 =?utf-8?B?YkkwMzByendRN0xYSXZvOHZFeEtNdmEyV0lqTGRQTDJuV0lhTU5mbVB5b2FZ?=
 =?utf-8?B?YnovSGthUTlkTEticUkvSmhmUFpaaEROMXhkdE5PcmVQWkxZb2VvaE5xeEI3?=
 =?utf-8?B?c3I1TVhiMGpQa25wZXovSU92bGZ2WmswZEptNHVuK3g0aG00MGR5dEc2OE5O?=
 =?utf-8?B?K1BnTW5udWFlVk81VnVzQnhLRUpOQjV0ZjVLalIwQm9kdm9YbGdVdHpLYXJC?=
 =?utf-8?B?RDVNNW15am04Ly85emRGR3ZMdlk0NkVqWlJ0M05odm9RVUZhK1RWUjY1b0Fj?=
 =?utf-8?B?MTNTRlNaRHJpWis4MHMyL0hPVWlZSmdyV0NnZWNVL25pcWlLdTE0S0dFMkYy?=
 =?utf-8?B?cFZtbDRla1V5eTh3d2Y2bmR6b1hSemZzdUxUSTA3SUI4Zyt6d1VvaTlRTURk?=
 =?utf-8?B?SHRNc0RlSFpBS2xGbVpKRTlSU09LNkRwc3ByZWhyS0pFQlYrVzV3a1psNW5q?=
 =?utf-8?B?SXluSnlwdGhjZDhMWkVnS0NGeGxHUGhoakdpd3BDZnNEai9VVXVhWms1YW8z?=
 =?utf-8?B?MEEzMnVoRkVvWjkyem42NXF4S1gwMzZZZmo3RG5RejhJRksxMk5IeTEySDcy?=
 =?utf-8?B?c3NhWDFKNmRiRWh3c2FHbTJUN0p0aThaOVFsRTdaL0tZdHNaVU1kNFJEMmdO?=
 =?utf-8?B?RGdIbGpvRCtXWUVVekpGK0lVUlRNaG5MZlNSaGNTK2RTbzZZQVg0WVArNWgr?=
 =?utf-8?B?cDJOVEhPRXpoWUF6TGJJMHROd1NsMTg0dEhCQUcxVjdCQWVJa0pEQlkzeE5S?=
 =?utf-8?B?aDlpb0Nyb2dXRWZVMk9iS3pmcDZOcnFyWTVCeU1lUUhYN3lEdVMvL2NtWDRX?=
 =?utf-8?B?NXR0blgvQi9nMjBlSmVZemltNHMydmtqY29ZWVJUZkdTV2pTRFRqRnhjVTdi?=
 =?utf-8?B?K3ltVmF0Tjk4S2NDdTJNUnh2NXhvMUNySXhhd29EcnpCL1NWQW1HdnNLQldn?=
 =?utf-8?B?YWsvbTdhUUpEaHY2bnlCVzFpenZmN3p5cERwaklHS2RrMVdDYVVFTEhFeWIw?=
 =?utf-8?B?VlhPMlZvSm1MVVJNSUZWdHlmanVKNkpMUlVWZFJmNCtscnJkMk1qajU4TEww?=
 =?utf-8?B?ajZSTlB5M0Vlem9BVTFHTXZOeDdkaWI5eUY1ekNVTHB4WHY3MnRQRkdPVkxi?=
 =?utf-8?B?QUlodWJFK1ZvTnFabXFESWdqaUV3PT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caa7216-0bd3-4f82-c468-08d9aa4fefde
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 04:57:35.6652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Dpwt47Ohv5ClCLjgcrHFh9a/a5y1AXkHbO5vqSnHfZe+ADMYtXgFCX64MjiFrUn9Si+ceZ1GGl9nYlDkf/e7UDrr13lQNSLxLBml3j8hlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> The real fix is:
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index f9139dc1262c..7aa5ea5ca912 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3654,6 +3654,10 @@ static bool trace_safe_str(struct trace_iterator *iter, const char *str)
>   	struct trace_event *trace_event;
>   	struct trace_event_call *event;
>   
> +	/* if seq is full, then we can't test it */
> +	if (iter->seq->full)
> +		return true;
> +

What I don't like here is - trace_check_vprintf() will still extract wrong positional arguments, and use 
the result as part of it's logic.

Although with your change such use becomes a no-op, this is unintuitive and can turn easily into real 
problems with future changes.

And, the above comment is inexact...  why we can't test? We can, testing code does no depend on 
iter->seq. What we can't is - reliably extract str to test.

If testing seq->full condition is preferred over forcibly consuming args from va_list, then such a test 
shall be done before trace_check_vprintf() tries to use va_arg(). Will submit a patch doing that.

Nikita
