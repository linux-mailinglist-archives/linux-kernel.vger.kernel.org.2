Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57FE41D602
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348505AbhI3JKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:10:16 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:43230 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348400AbhI3JKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632992909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cm5DHmD8fWk5sVNmTLkUvpgDOpCNihkSVaY5RYpAEYY=;
        b=jtwLMEb8cXzZFQJZ4nwkQTsryN73Ripi+ne4EqIMDQwp3oLQDIaeBbnOJZnfKL2z2EJ1Sl
        rOKXQJAFzSMsu0h1WouTGAk0s+M+Kn0lkWbQNob8sLIu757plfaEKqR1j633eeGUZvg2O8
        Hpi8OApDtqk9sFehL2chjvdbxiu8Ojk=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-3-yEITWgU6O7eQN2swipvguA-1;
 Thu, 30 Sep 2021 11:08:28 +0200
X-MC-Unique: yEITWgU6O7eQN2swipvguA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfKsCcAL1ROU0mU7u8yMihrZ0vLxxrf142KgOpOH/9Ep5X+rkgIlbVSZZkbnzf9IOr890coWbEBRR46UFQH0guqFUw8Fo0jkHBz327jeXmVkh+pr/vmekEiuKsbz+HE1QiuMmsfV7e8tUz6I/cgHwiy7WsHxCX6pqDxdcWjFjKylwOTFMG6dwLSC1+W+x3pBLFS9R0qLFjtaiddvHiVADXcXyHbQnqTTmU5/e+ogk24sr8GWgQhJWFCuQE7m4nA+IpCysNJ06knE8yVWsVIBMRy+iQ+nmoLT51ABjR0vELAqC7nOXRNNHwjuGoFIRWsk5oDRNKDI3cJlWOG0lHwdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Cm5DHmD8fWk5sVNmTLkUvpgDOpCNihkSVaY5RYpAEYY=;
 b=eXbkmAwOI6KVNBhHwP3m5icLSed2A2y48sx8TzgLw3/fBBBDmvXmHYi2j45Wt/zf+eK8NssDh9zs1UdFC6rpK0cTIm6Rh+RQnwaeE9SxNl0JhGmzU2hRWmDR8ZQNhaCJwI7zV1c718EUrwlmG2XigqcgCIT0SqnMedMZ6/YFrEk5CRrsuJ/e3muDBU9pZpq8LI8n9dDYWa+GNtq2Vr/XGjkEMF3zqNfST+Fs7Fbh6uZXm6vWbr0sEkkXnWQiKDwor1q7nzk+91mwpwTRj457/m/jbmLIcnzJVitjvaw+CfAvL37IwXMNCU9o+0b2ml6kdJc1XRqjxKYS8klC/7lCsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB7PR04MB4137.eurprd04.prod.outlook.com (2603:10a6:5:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Thu, 30 Sep
 2021 09:08:12 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::61c5:2592:9e7f:a390]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::61c5:2592:9e7f:a390%5]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 09:08:12 +0000
Subject: Re: [PATCH 2/2] usb: cdc-wdm: Constify static struct wwan_port_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Junlin Yang <yangjunlin@yulong.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210929132143.36822-1-rikard.falkeborn@gmail.com>
 <20210929132143.36822-3-rikard.falkeborn@gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <053aca41-e67d-a64d-14ed-ed5bfcc50b67@suse.com>
Date:   Thu, 30 Sep 2021 11:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210929132143.36822-3-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM5PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:203:69::14) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
Received: from linux.fritz.box (2001:a61:3b0d:4601:21ab:d1da:15e9:ca07) by AM5PR0202CA0004.eurprd02.prod.outlook.com (2603:10a6:203:69::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 09:08:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af692e38-0fd4-45aa-66c2-08d983f1d44e
X-MS-TrafficTypeDiagnostic: DB7PR04MB4137:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB41377978D62AA3AC2E5F2A9EC7AA9@DB7PR04MB4137.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHxoXopdF6IpVYAH7izbaw5jR7Nih57/Er0Ac2QSTgvlsFZo5St4apZoW8dmfzP5UH+XjZlDChaRtFSN9xSjrjDVDR4LSFbVzbi1qB+xVxnsR00N8ImyW3AyRZcw6468zK8mvj8g3VyLmpX1BpOnJCbXLmNrY9f6bQG1KYrh7zN4u6ExkjwQ/uK0JtE8BlxXjs4ISPJX8SiM3j6N4U3QBLK+K26p0syYKXNf1h6sMpFLvBqGp3n7EgIy2KnfbutYa97o5fWouK35rniKUtAzyvZOfBys3lWfejsN52XUSoHe1YP4ZJKCgld7LEpDOdogYZiK+rL3bC/L1KoXOBVoaKh1t46vppnvphBLRonhR7LxKPXSrtFTeaxnSqMQ3rKLvPrf/BpB49VKbQ3TCXcPJdPuwWxVl+8VzZXVt76G5YQKoiWWzM+NkB4/40oahjlgqA7dfQtsVl0VuNQ8v4YnLvFby506enPMCxFidjItf+KF6FT/EXzL7f6lxP8wTIw5xGq9VFDdIRNoXnOagybGi3LhfXVmcQrpAghFSRD/lMyRdqvXjvcdchl04vHE5LLJT7dCsRthfNRc8xG4PivGJ0hNhOjEa0Pdam8kthZ9zV8024Cs5Z4YKbXdY1zE/z+x+cYXoW62j5XgOE5UNkOxqmeLFUEzB+hIhx4zKU6vOk52vvGvXuo/XMDhWQpcXAfUKrb/5iWgVX0Uax53ed2mIq2GXbZd0OHE+iqkPccgDzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(66476007)(66556008)(4744005)(8936002)(66946007)(186003)(2616005)(86362001)(53546011)(6486002)(508600001)(110136005)(4326008)(31696002)(8676002)(6512007)(2906002)(6506007)(31686004)(316002)(38100700002)(54906003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1VUWGNSbWR1QTNvK1kxUmsrV0h5Vkc3Y2p2NW56dmFNMzFxNWFBZStrdmFi?=
 =?utf-8?B?ckFvWlRkMUhJSWJOWUxIcFhzOEpTWHIwVnhzMExRL1plQkxqeTR0QWJUdXEr?=
 =?utf-8?B?TTA5dHkza3dSMFcvbFlENFVreVh2dE5Ib3JFK0cxckxMaU11L25RYWF2dDFC?=
 =?utf-8?B?REdRVU8xSitxdGZpRmRCbWRsWW40SElwc3dVTEM1bWZaTTU4YVR0TmdobFhn?=
 =?utf-8?B?UEZNWGlLYnM3NXdkSmVJVWpxZFovdXZpTW91ck5nRHRTb2V5ZEYvaFhxWnNn?=
 =?utf-8?B?T21veUJiY0s4a0s1Wm91UW9Rb3ZlU0dEMVBXTzlSdlZ1NThKRVZLUWU0NFBq?=
 =?utf-8?B?R0U3WlF0V3FNNzBNcEMwaXhCa0FFNVZMT1haVkhsS20wajRWbVNaWVlZOXBa?=
 =?utf-8?B?QzRidVJnS2lCZnZrS1l0U2pSaHU4UHYvNGZUaGkzbFlKSUhBYUxldW10QVBB?=
 =?utf-8?B?N24rTm9KaFlzQ2pET3MxSmsxSzlWb0JwR25iQjZFSFBwUG13SjFFYXZsVjdD?=
 =?utf-8?B?NUd5SkRqWWl1N1UrRWQvMUhXN1lmZmRKY1IrTHJFUkhUUStJNlRlM1RaMDli?=
 =?utf-8?B?RWhhMXlzWldKRWJlOGFLVU5HT1hoWWhGY3FCMnFsNit4UTJzWURmQ0dIT0M1?=
 =?utf-8?B?SHh3eDlwVmc5TFJjRjFHV3lha2gzQkVXVlR6RXRnL2NpKzV4UmJBc2xEMGh2?=
 =?utf-8?B?enI0QjF4YjlhWDlHOWZMQUR1TCt6ZDM0d3drdldsZVRubHB2NGVUVUZKSHJT?=
 =?utf-8?B?TUdjWmNJMkg1YzhocUtKdmVyaHVGTUtWaXJVZ3ZjVjgzUFc4ek9lL3pJL2ph?=
 =?utf-8?B?U2ZFWldvZHlmNU9KOXdxQ0VDTFdVQUtLTjRGOHg1VVpWQjY4bi9aSi9HRjJm?=
 =?utf-8?B?TmxWL1N0ZVpZMEM4OHEwelk0anh1ZTNqcURiNU5OZ0Iwdm4ydEg2UDBNNDVZ?=
 =?utf-8?B?d2p1RFBZZ0ZMNTd1UWRpUGV0TEp5NTlpV1FOK1FudG1BZmZUM1ZyUGZaQy9T?=
 =?utf-8?B?RjVVMityS0E2UUZ6QVo0NXhVbVZBOHpuTkJvblk4ck9wbXlNL1ZOM3BOSGVR?=
 =?utf-8?B?a3ZWTnYyeFp4Nzg4Yk13YnVCbDlZeFRhc291NlpBT0MrZVJuZThWMkU4MnJW?=
 =?utf-8?B?a2pON2YxNkFaL21PU2RkRnFjS3dyV3YycG1PSmNaZ3A5cDNUamJEMHptQkZE?=
 =?utf-8?B?ZDVCSXNlNWVQSUdmdW9SNHpmQWh1WCtjNnRZaDY1TG5tVlJySGUzUjBLbjJu?=
 =?utf-8?B?T1ZkRnIyZTNRMG9TTnZMZ2tiTTE1ZG5PZTFBOHVlaXJtQ25KcEVEbzVxQ3d2?=
 =?utf-8?B?cnlPMEMxZ04wMHZ6Skc2RjZPNGZKY3F1bis2OHoxWGNaUkxPNzBqekNTYTVt?=
 =?utf-8?B?MzNxY3dqNWNWUUFHRWdkMys1SlFYNW0rd3EvZ0YwOVJHVW9QQjhXelFTT3NO?=
 =?utf-8?B?a1hPQTdmS2JFV0kwa2crUHBoQzVEN1FoNFkyU1Z0RWhmaERuVzRrVGtNWHQ1?=
 =?utf-8?B?aXFVYmpVa1VtUDEyVmFxaDBpTmpzTzRXcS9lMjRFc0RXcUFzbExYVXcwWGNM?=
 =?utf-8?B?d2hLQ3B1bll4dFQvb2xtK282OUtKUHpKdW0rTDNqUnR0RG9Ld1JjcUpnNjlo?=
 =?utf-8?B?VUVSTkFpamZNbjRBTzlQTzFrQlFCRGVpb1FuMjlXUHdvRklveCtFR3NYMG01?=
 =?utf-8?B?UkJkMHpRanVZS091YUNveCtBa3JGM0xzWXJwUVVVWmpaZi9Dek93UE1zcUM5?=
 =?utf-8?B?ZjQrbGNXbk0xNWEvWWVSbFZMWWJoK3hPOHIrSVNtUkRzME82RzRXV28yRFNs?=
 =?utf-8?B?SzhNY2Z6RGJJekkwQkN3bGhWWmxWQUNVUzRXeCthYTROVzBDSVZxRTY0S1A4?=
 =?utf-8?Q?l7Kd5ksMTYKRG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af692e38-0fd4-45aa-66c2-08d983f1d44e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 09:08:12.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waOPu6GzpdP9WkUI1QGAI6ofs08GkeUcga9bK8SNU24ubyh051XNXt/Pjdw8laN//CK2eMMPnCrWGLkGD1pcUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4137
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29.09.21 15:21, Rikard Falkeborn wrote:
> The only usage of wdm_wwan_port_ops is to pass its address to
> wwan_create_port() which takes a pointer to const wwan_port_ops as
> argument. Make it const to allow the compiler to put it in read-only
> memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Acked-by: Oliver Neukum <oneukum@suse.com>

