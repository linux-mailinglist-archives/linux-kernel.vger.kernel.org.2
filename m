Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A26F333651
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhCJHYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:24:23 -0500
Received: from mail-eopbgr50132.outbound.protection.outlook.com ([40.107.5.132]:58580
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229574AbhCJHYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:24:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIvU0l9rXbSXuTenE1ip8lf/On1uhnzTXGNIoso3Exdldynv/7owclm7FKPqBl58FRHIfEMHsjGrw1xfZb+8Jgw5bWtrXKqS6MeE2llrtfgRxRGQPSSCxHMTFxFNfCKJbdl28LA9gANn0Efq37CRkXTRYWbjFOvv87ew+z0yDt/oiODNIn3HVfLz4AwSR3UfdpsESHoa3G9PtfxB1EifYD1fbGLP5pgsUcWv3nEzu4nRuF+oQlIVimhe2MJC8zfnTG2bdE3UtKMqE03JwGjQnzu8JJaKRGaiYz/gDqJbErSBKuByXjR6YKsivNqSE5u4+0ltQcIEZ2pnWQFbT/3t0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy0hbvxMREzBoAhVV2TDvbZoSeOkT2DQZVKUNed8VXg=;
 b=bEtbR3XAgkVHGLIJDYTUoZYkz2lRB2Q+yyFuBahSOL1KfgjejobqgqAPygiwPkeDWjrlE+2VKFJtDz1R/ks0nPMclZHxGwvA53SwYEdRSnt2F/8qgFOy8R1URNeq88ut7i8n9Y0gjSnvNcc4+ZQG8QswZIsxt6gTo+QxUEanCZl9ZBTdktC8/kJU8uAOhW26cI+j/KaNbXh9+xNCMYzVDcLKN3AMG2jl9BLDh2OJrgK4/zo0+Jqip8TBETcMNjEh+maSP+w6P+Wxa6Gbcdc5AHWYyWWqpDKihrClHNqAbZHZxa017JCNBzXZpoXlbOuS8/cwwMxI+HC0XyZo8TcGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy0hbvxMREzBoAhVV2TDvbZoSeOkT2DQZVKUNed8VXg=;
 b=Dj0FWcK8ndH8piivdpqgj0vmNM8ILi1ia85DyduIl0peQ3RUwVql5j+DxLclOHM20sOEWXjXBaSNH2cs2f6KJsNptVOwA3bZlkq44qBqnrgok2vN8+o389qCFE+mpf3AxfWC2VJlT0zbF+ATLouB35InbuFXH6uq4bkQqBCRK/k=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM9PR07MB7905.eurprd07.prod.outlook.com (2603:10a6:20b:309::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13; Wed, 10 Mar
 2021 07:24:02 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f%3]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 07:24:02 +0000
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
 <20210127110944.41813-3-alexander.sverdlin@nokia.com>
 <20210307172650.uztx3sk5abybbp3f@e107158-lin.cambridge.arm.com>
 <0c122390-6e76-f773-86e9-8c085f4384f2@nokia.com>
 <20210309174201.n53za7mw33dqyleh@e107158-lin.cambridge.arm.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <3eecf51d-b189-9e8b-f19d-a49d0764aae5@nokia.com>
Date:   Wed, 10 Mar 2021 08:23:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210309174201.n53za7mw33dqyleh@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.168]
X-ClientProxiedBy: AM3PR07CA0119.eurprd07.prod.outlook.com
 (2603:10a6:207:7::29) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.168) by AM3PR07CA0119.eurprd07.prod.outlook.com (2603:10a6:207:7::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.22 via Frontend Transport; Wed, 10 Mar 2021 07:24:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e14dfb1d-628d-4614-6d0b-08d8e3957aa1
X-MS-TrafficTypeDiagnostic: AM9PR07MB7905:
X-Microsoft-Antispam-PRVS: <AM9PR07MB79055695A26AD2343C50BBD788919@AM9PR07MB7905.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yd/EiRZ70gNjRRNPO9MhkxtclkBDqGONwpxQHFcl1pnKxmlKIpVQc+qy0E3kohzqC7as2rVB6ts+8IdGMY/mh6Gr+nqL8LGiOhmzuIOXoqLU7TD9f/zN4fKg2jCtQGAn1JV1pHjV7Fejbo4QPESxCoxxVMutJ/pbtdW6wZo58mw+oFi0OirjE/Xyq4Yh48t/qAnjp1nzrYKH+qzcWFF3BFJXWKhp/xhcLBKVN8R9IyqCsCQYwTU8XvHCqWfr4eaF0JzxY/ucxepttQre0J60SVbP0uG1DuM7Q0HiUqPzb7b12+z5YyGR1XYfkFaNKMgzp9+NGqOwAslQZh2MO5a+XccKCfXinTZuIQNAt34PN3E3kmwC/P9tLIXCu6zjn+ooe9puqlFvuFeE5QcCWybFJQuBgmLaj8SVs/0daKm4oKnPB8SXY0yIRhnbV8w+J0Juh/P8fpLtiP9zZkxqjig70C9dDxZgtbd16HONxyVAJ476HM3CNCNDOJTprbhOXJOBjV8o8HaTr/h9XR5DsAZ+SsTWqXkgYgPHWyNWavMBwdOkpd/rZjr1whsYMfctEV9ux7UjpbrNOjBXu1PcdouUj4DVGpdltWFgN33aUcdOl3nSMS0I8WumER95l6RKOB/T9suE2dL6FQ7PVGfYSzAbOarkkJJBq7Sqd+ga7C2nH9zuK1KBt6EPHFMkn2vabfg8BlK6m2LG/Jgl4P3Y0Ndu++Iqonw55yPfPp895/oERJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(26005)(16526019)(186003)(6916009)(83380400001)(2616005)(44832011)(36756003)(6512007)(956004)(6486002)(316002)(8676002)(54906003)(8936002)(31696002)(86362001)(2906002)(6666004)(6506007)(66946007)(66476007)(52116002)(5660300002)(66556008)(53546011)(4326008)(478600001)(31686004)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M2NIWlkvSDZZOHdrdHhYcFpmSCtuUUxRa3pCemlHWjN6RDlmajRuakFTelRr?=
 =?utf-8?B?SXpLaXltYkdTaGJwbENIckxzZ3ZXZ1k0WnRvN3N0RzVsc25DSWlnV0hJMy9n?=
 =?utf-8?B?UU9uRHdFdjJ6Q0JpanBsZWEyeEszblVKUWFNbkdveklHWi9wY0dGbzd0T2F1?=
 =?utf-8?B?Y0JMak5oVXl6TlNJcUtPVGJyVkFFTmVhd0VHV3BJOGtCSE9IR3dkWC9yRTZQ?=
 =?utf-8?B?eGlwQVVvZ2RTNVBvZ2F1L0tmMTBRR1poaGI1cys5Vm45N09nWXBwUE94aWNy?=
 =?utf-8?B?NjFZbjF6N3ZTQlZNMkxFTnlnVVdmc3hydWV4WGdmR1VLVXNYb3VCMWJScVR5?=
 =?utf-8?B?eEw2TnZqNGVpV1FnTzIzQ21nQi9od2RNVWNiSm5wazI1clgvSUtSVGk4M3dO?=
 =?utf-8?B?TDhTTW1nbHYreVNmSU1QOUl6TkwvNFl4WUpVNW1GQmo0bHpqQjczd3A1SnFw?=
 =?utf-8?B?QTVEOEFYdkFITXc0bFdERVRMcE1wQzFNUTU1cERpbVc2WXVZSFlxazhidkF6?=
 =?utf-8?B?d2lSV2RSOFVKdWtsSGVDZkFpRDU2djdGVWpPSGQyb25KTzhNRkdibVAxVEZa?=
 =?utf-8?B?V0RiZlNmTUd1OFdwdHhyOXZJb0wrR0RxaWFTZ1RpVnhnVFRyMmdKTjdMRFkw?=
 =?utf-8?B?a1FNQ1UrNzhpT2xYbW9GanJ5MnFrQ1RGMmFGNjlIVmpEYk1VZDFYbkZhcCtI?=
 =?utf-8?B?V1BGanF3a2Q4aFdoT0FHWjdnK1VkcTdCZG9Gek5yMVdPYjYxYVhoTFREaERw?=
 =?utf-8?B?WnAxU1BwblJSTFQwYXgxM3ZNMFhOc1BUZTY1ZDJhVm1GV0QxcUxweTlWc3pJ?=
 =?utf-8?B?bzhKMktPb1dIdWUybURRaUxmYkhycHdXTnZoYmFYSDR4MGMySXVXTEpQNUFR?=
 =?utf-8?B?MXc0MjdKNmorSGVzd04wZi9ML053enZLRFhraXFHRThYT285MTdHMXZKVTgr?=
 =?utf-8?B?dUZ6bTlud3RHY3VuQzl6cVlPd2xDSTR0RjhWbVZPWkl3VXJ5TjNFb2hBWHM2?=
 =?utf-8?B?S0tGWE9GZ0VVbERTTzRwUStIMGNrcmxJcEQ0UzBNa1dyUVZPRllVVy9rY0ZB?=
 =?utf-8?B?QVQ5VitrYXJWc0F1czd1TzI1Wjg0RjVLZlFoTnVxRk5zY2xVUUNzM21KWlZj?=
 =?utf-8?B?a3ZiN3R6U1NBekpQemNBVFVua1J1Sk9WTzlnaEdVVWhUc3VXZnVqSHd2K2lL?=
 =?utf-8?B?OFloTjEwblFxdk1NdGRreUNZM2p4TzFDVkh5R1Y3azdDcWc2MUh2alJMMm02?=
 =?utf-8?B?d1BVdHQxVmlBTDgva1VmeWk1amNQSHQvanltbTJMWFViZm9DZ3hmTWE0dkps?=
 =?utf-8?B?Und1QjcyZWJKc3c4Tld0NzlpV1hBdGYrY21wRVVUQXVnNnNubGQrOEE3cHJ5?=
 =?utf-8?B?b0o1SVFBRjRyYVl2TFRnSHZLOHZIc0drdVM2MnJrbk1QSEk4UThLRXF3dFZT?=
 =?utf-8?B?ekxmMzMrYTFrQWptU20yaHFtNU1kaVZZTE1ySjR3NnVZUFBmVlM1bXlFWjVx?=
 =?utf-8?B?WW9mTmtmQmVIeGtvUWZ2UzdnS093ZS8rV29kdG0zV3JFOU5uMWdxcW5ETlFx?=
 =?utf-8?B?aDB0d2dlK3FFa1FoZVdYSkxoUFRadWRUN21GOXlUOU5OMTJoNWtyNWo4Z2F6?=
 =?utf-8?B?SXJyWTkyeU9ObmM1Nytodk8wV01tNlFVWEtZUmVtMU9OREdUdzRwT0hCdlZ0?=
 =?utf-8?B?bzVwbTZhVC90SlFUTWxiMGVNRmZ4TjhvY0JFTUFnV1VYM1BUYUtsWjJtNnZD?=
 =?utf-8?Q?N0oIXE1wv898uHBWva9kcOvsaKtBwb+RHXcu0H7?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14dfb1d-628d-4614-6d0b-08d8e3957aa1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 07:24:02.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNONFjRT8Rf8Ip1RAlnDMVhOUMbsM8hCrC3AdExg3hQPRnn6xX1dDFRkWpcVEl5FGXSxpJ52tVDXAGf8rCpBGltHnuhVnP0HoLCsMjEMfGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7905
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 09/03/2021 18:42, Qais Yousef wrote:
>>> I tried on 5.12-rc2 and 5.11 but couldn't reproduce the problem using your
> I still can't reproduce on 5.12-rc2.
> 
> I do have CONFIG_ARM_MODULE_PLTS=y. Do you need to do something else after
> loading the module? I tried starting ftrace, but maybe there's a particular
> combination required?

You need to load a BIG module, so big that it has no place in the modules area
any more and goes to vmalloc area.

>>> instructions on the other email. But most likely because I'm hitting another
>>> problem that could be masking it. I'm not sure it is related or just randomly
>>> happened to hit it.
>>>
>>> Did you see something similar?
>> [...]
>>
>>> 	[    0.000000] [<c1b01a38>] (ftrace_bug) from [<c046316c>] (ftrace_process_locs+0x2b0/0x518)
>>> 	[    0.000000]  r7:c3817ac4 r6:c38040c0 r5:00000a3c r4:000134e4
>>> 	[    0.000000] [<c0462ebc>] (ftrace_process_locs) from [<c2b25240>] (ftrace_init+0xc8/0x174)
>>> 	[    0.000000]  r10:c2ffa000 r9:c2be8a78 r8:c2c5d1fc r7:c2c0c208 r6:00000001 r5:c2d0908c
>>> 	[    0.000000]  r4:c362f518
>>> 	[    0.000000] [<c2b25178>] (ftrace_init) from [<c2b00e14>] (start_kernel+0x2f4/0x5b8)
>>> 	[    0.000000]  r9:c2be8a78 r8:dbfffec0 r7:00000000 r6:c36385cc r5:c2d08f00 r4:c2ffa000
>>> 	[    0.000000] [<c2b00b20>] (start_kernel) from [<00000000>] (0x0)
>> This means, FTRACE has more problems with your kernel/compiler/platform, I've addressed similar issue
>> in the past, but my patch should be long merged:
>>
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1817963.html
>>
>> Could it be the same problem as here:
>> https://www.spinics.net/lists/arm-kernel/msg854022.html
>>
>> Seems that the size check deserves something line BUILD_BUG_ON() with FTRACE...
> So I only see this when I convert all modules to be built-in
> 
> 	sed -i 's/=m/=y/' .config
> 
> FWIW, I see the problem with your patch applied too. Trying to dig more into
> it..

Then it's definitely the problem explained in the second link. If you have THUMB2 kernel, maybe
you have to switch to ARM.

-- 
Best regards,
Alexander Sverdlin.
