Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FBB35BA1E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 08:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhDLG2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 02:28:44 -0400
Received: from mail-eopbgr140118.outbound.protection.outlook.com ([40.107.14.118]:10756
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229461AbhDLG2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 02:28:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfD8wINTE4bQIPAkvQXCxhsSzd7OdxQLBpbjLcQBJjWVfmH3QZqjcQ980aav2CM2B3zjDWVaFZb7WtQBv9kU44cgMCr9lVUqXg/GH8+/y5Iqxgfom5V15U6erBBZsR8oGB1/6Jq0noBwkOpmzXN5eF46MD8msXkCnVtYgCUCMZu1n/jA+djxnET9dQo0BKo2liG7gjhwC+K/tLeF4FTNf9wfJlyFzSOHUZxM2O80Kau2PHJLLdmJSU140ixSU2gsVuiedjvwp+OsC849XBXMR3XdsUqsE6LMzUGTY381YhrzhDPZgzBPp7BSzvWpYBabyI2WkJaEMmBgsy+HakJbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVdAItAgFIKEGUzjFks59EnajxmldWSDpbzva2D2kbw=;
 b=MeZot1+IORyEjrMEkjWrOaOPuzp4lDInloPIBpST9VN+0h6nSAWObySfJVX/2o4lPylg3cwbYz7wsrBZJFA8fz+7CGOwJkjsFVMN1kfRHMIXPO+b18mFk0EabM/jpaj1xaWZLZq9bSFDQuJCZOohpiEdwaKzJtQkYgB/DPppiYVLb2BUiWqvOPmUDzcMmrk5vOnD+L/FnXjNKWmOOM7i4pQMZtX01SLEz+thI9BBFBMGQbojM7v8GDFn0953s4r8R4MNGbm6AtOR1HKrMU4BrQBXaqt6tndUbtYOhde8QwWUpLjeVXB43VGfq8WJbeJAzQDwnnjbR66BgnQ5mtC8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVdAItAgFIKEGUzjFks59EnajxmldWSDpbzva2D2kbw=;
 b=Qu6JqdMDIQP5UpvsMnist0xmvhzL7PcZ5iaIPSzzZP/QWelvbnOogxK3P0r64ImYVs0C59HfxB0ehHGBcyA/WclBKERiHxIRpDYUb7RtC+FRLMVIZOP9LMztHJ024mJK3nl/m2xKNt3633ETXOMFc19XgWs9H13tmxhkXl7CPCE=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM0PR07MB4467.eurprd07.prod.outlook.com (2603:10a6:208:6b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6; Mon, 12 Apr
 2021 06:28:23 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::64c6:3c3a:6327:7340]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::64c6:3c3a:6327:7340%6]) with mapi id 15.20.4042.014; Mon, 12 Apr 2021
 06:28:23 +0000
Subject: Re: [PATCH v8 0/3] ARM: Implement MODULE_PLT support in FTRACE
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20210330114035.18575-1-alexander.sverdlin@nokia.com>
 <20210409153309.wbebto3eufui35qs@e107158-lin>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <be48adb2-c838-1a9b-37bc-da783f3d5dd3@nokia.com>
Date:   Mon, 12 Apr 2021 08:28:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210409153309.wbebto3eufui35qs@e107158-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.169]
X-ClientProxiedBy: PR0P264CA0206.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::26) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.169) by PR0P264CA0206.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 06:28:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d6900be-47bd-451a-1142-08d8fd7c2c1e
X-MS-TrafficTypeDiagnostic: AM0PR07MB4467:
X-Microsoft-Antispam-PRVS: <AM0PR07MB44677CB151B3474AED2C170188709@AM0PR07MB4467.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zw46PQG7bZZiFVvMcJkjx4rq07rigAY6gV4Zku6Nh2K9MqJ67wDExQeLa+RdwD3Rm9ZW9qQY4Xy4p3N/1F7DDJ6MZ9ksacowoKkMkyOBy1QqDm+vehEHMQ1eZM5JUjLrFWMVI1X86xv8hOC38EYP1uFy/6ZgOpIQvWa8sv9pPNfzcXUI6rwiBgeviI6axSSMjQKnsfYm3W8l6HEhppxKaD9Or0nkrB9Mir8WbBNXYuM+hlBGWo1W+MQgtAtbcVFgerhpz2kmRshlO84uD70AE53xYByzXmHpG5bro+AOxeCOA7Zhrvzg210PIheXTva8dl1eMM7/kmH0WXuzaswAql5HeV+PD+DzkHZdlgA/ic8zULI8IWiBjhZUTeJRW26ST+11I3RfQ9nAzE55gQ9Im2D87l3DUZybBTEvy7oyb5chBcAHRBpSOc+4eme8Ut6mOPCNYlBvr3OqhAxuKAb4bQXjtqNF//u54RRHSDZfU4cKTPOJc5YxGk3qOtvPhCXlt8/02QVvKhQ+qnlruhkDvwsPC8qn4UIsk4CemC7OPqTyh1tvdPWDM4f97G29HCyTW3haC3WhzrVM/krbEUr5HEBNkEU/Jlhruq6HuIlfprivHtRrddT7bjFbsFRxuDRxg05iBSa8gn+yOrmeA7YytS2xkIYnRQPecfrT7FWk/UnyDLqh0078NqIo65D9nVIMR9t2LCKmROchk9ki4y6agF5C8wdeLAlS16BUaPoypBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(31696002)(316002)(54906003)(6916009)(6486002)(5660300002)(6666004)(36756003)(31686004)(8936002)(86362001)(44832011)(26005)(2616005)(52116002)(66476007)(66556008)(83380400001)(956004)(8676002)(186003)(4326008)(38100700002)(2906002)(16526019)(66946007)(6506007)(38350700002)(6512007)(53546011)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TEtHb3Bhd29lWEFQYStzdDZFa1VzVkUrVklFWHVXUzltWEVMcGwrOGVJMU55?=
 =?utf-8?B?ckI0YWNxL0lTUDhJdzBWVkxYVEZyUmhKeVhsZkZHT1B1YXhEY2d1U1NjZ3c4?=
 =?utf-8?B?ODU4cEo2ZnNYRmQ1WHpybjdaRjdoUlVnUDE1NFI2WU5Ga2VTS0FVaHZXc3E4?=
 =?utf-8?B?a0RDd2QxRWlPdmtjelV0dU55VTdGanovVFMxcENIZ21zc2h4dTk3eUp0Wml4?=
 =?utf-8?B?S3h6Z0c5ejE3Um5HNi85TkRLajhTYWJuVmdZd3NQREZ6M2pGMVNJM0VVeXo4?=
 =?utf-8?B?MmozMVg4dkRpOHRLR2FGVndyR0Jrc3BmRUpmYUovcDFjSHhDRTE5N2w2OGll?=
 =?utf-8?B?RjVnMFgyVnpmckp3di9BTGFuMkt0S1JTU2NkdnE1aThhZExLOW1KVjF0N2JV?=
 =?utf-8?B?OXFIS1JJK0FWSG5RNUxqdVRsSStsUXZpZ0tRdW51a2tHYkpKTldDMC9tdkRB?=
 =?utf-8?B?aGhDNG5mbVZoOE5hUDRvMmZ2WFk2QlRSM1BReTMrcWF1aG8wRXdzaXVNQWFa?=
 =?utf-8?B?ZzZ4aE12d3dPbUczcTNPVkMwZStHZ0pXYkNoL1JWV3FUK2FHKzNFcnVCYXFX?=
 =?utf-8?B?NTZCMW56Njd6V2hjTjhGTzNtS1pzY25wN2x4eHprWlFoR2xId09UaWdDNmVp?=
 =?utf-8?B?WnlOOHVVdTBoYjNHdENiRGI5VjhJZGM4cGg1U3UrYWl6N29ndExOcGozbGlW?=
 =?utf-8?B?Y1NIZlF6bVN1VXJtVk5wbXNpTjMwc0ZId2lLbTcveWQ1V1poWUtpZEFLR1lE?=
 =?utf-8?B?TitpZUxhVXlVMEhhTVZNSTJqRTlZYXRFZGlCenhzWmxQeDY3emNHMGpqMkNU?=
 =?utf-8?B?SVNrOGcyRFBIemdwc0R0WFlGT3cyenFYZzJvYVhzNy9IOHBIZkgwWVpDcUky?=
 =?utf-8?B?bWYxNG1sZXYrSzVxVE1yWGZCNFp6Z2k0c2lhVmkyOFFhbk85cFlMOVdzOFdl?=
 =?utf-8?B?Q3liMG9pSXFrOXdGcjcxWEgraHF2RXFyQWo5QzUwNWNHaVpCWU9NQXIxQmZM?=
 =?utf-8?B?cHEyUmFyc3dMay83MlF2VTJKeWpvWGoxdXRJMkRWQmZvNkIwTlZSTjhSWHR1?=
 =?utf-8?B?TnR5Y3VyZmdkUThJWTlNSC9iYVUvSlA3RXhmZ0RLY2ZlNVVOUzh6M2RxTW5X?=
 =?utf-8?B?ZlBudkF2N3piVHlDN3FxN0VzZ3Z6bDdpYkNLeHlGQUdWSitWQ3hBb3MrazZl?=
 =?utf-8?B?SGtCWHREWVgwenlIR0xiZURBaStpRlJ2QTRoTVAwVzJ6OTdOcWhDU3kwS3lj?=
 =?utf-8?B?SFRGK050d2QxUFdpaU90OWxBcjZzb2V1NkNvOXFWRmdiMFhMZzF6N0ZSWlN5?=
 =?utf-8?B?Vkp2Z0pQOEJ5UGNHdGpuWW1QQklJaEhZUUFXSnNjK2lFT3VIM0NuajAyaFlR?=
 =?utf-8?B?Y1p2dWNtZUJzaWR1cysvUzFDV3UweXNqQ3kyK3loQnZLVXRYOURLTUZTVlRI?=
 =?utf-8?B?MjlEaFhqUXFpVDA5MFFoMHZueVFKU2s5Y0x4SGcyNEJrVGV0bzVrZ3hnTWpP?=
 =?utf-8?B?WGVMUmxscjNVK2RwbHZoTnZLVHdvR2Y1QmNsUEZ4aTZ2bWVEaFA4ckdJYzgy?=
 =?utf-8?B?bjBTeUNUN2syNWpMQms0K0h0UGphNi9NU0pnandnOEFjeGY0RkxJdWNDU2k1?=
 =?utf-8?B?NmlVVmgvb3ltNXFYdllYSUJNSStTcGpoRk11N1doNmFzcTRVcEorQi9nSEZi?=
 =?utf-8?B?TlMyMENldmxaZXczRzgyZytrVnN6cmRFcjdQbXBDcjI4UVhMYkVsOEFzZFNT?=
 =?utf-8?Q?3O+GogDnf+IIgxBm+gMCRTYGKNWinzvcFVptw1y?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6900be-47bd-451a-1142-08d8fd7c2c1e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 06:28:23.2724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgQ/qtKpM3tkVbSWMQkq+oWNhF915IOv/GgUdUD/0ucL5wurHYAAMHDl49zbYiiQJLJQYCV3ZAc+V/uXRkEjyrqNpNuQPsH0bk+/3A/W5lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4467
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 09/04/2021 17:33, Qais Yousef wrote:
> I still think the ifdefery in patch 3 is ugly. Any reason my suggestion didn't
> work out for you? I struggle to see how this is better and why it was hard to
> incorporate my suggestion.
> 
> For example
> 
> 	-       old = ftrace_call_replace(ip, adjust_address(rec, addr));
> 	+#ifdef CONFIG_ARM_MODULE_PLTS
> 	+       /* mod is only supplied during module loading */
> 	+       if (!mod)
> 	+               mod = rec->arch.mod;
> 	+       else
> 	+               rec->arch.mod = mod;
> 	+#endif
> 	+
> 	+       old = ftrace_call_replace(ip, aaddr,
> 	+                                 !IS_ENABLED(CONFIG_ARM_MODULE_PLTS) || !mod);
> 	+#ifdef CONFIG_ARM_MODULE_PLTS
> 	+       if (!old && mod) {
> 	+               aaddr = get_module_plt(mod, ip, aaddr);
> 	+               old = ftrace_call_replace(ip, aaddr, true);
> 	+       }
> 	+#endif
> 	+
> 
> There's an ifdef, followed by a code that embeds
> !IS_ENABLED(CONFIG_ARM_MODULE_PLTS) followed by another ifdef :-/

No, it's actually two small ifdefed blocks added before and after an original call,
which parameters have been modified as well. The issue with arch.mod was explained
by Steven Rostedt, maybe you've missed his email.
 
> And there was no need to make the new warn arg visible all the way to
> ftrace_call_repalce() and all of its users.
> 
> FWIW
> 
> Tested-by: Qais Yousef <qais.yousef@arm.com>
-- 
Best regards,
Alexander Sverdlin.
