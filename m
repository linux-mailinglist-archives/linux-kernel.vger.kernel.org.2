Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D066C33AE86
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCOJUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:20:31 -0400
Received: from mail-eopbgr70104.outbound.protection.outlook.com ([40.107.7.104]:32953
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229553AbhCOJT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:19:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwtm2fSP+4LO5h21LxAEONFN8rc+cmy75m4JHs0eVLlxcNdWFqfARtEB2TDodgWuWb5UAjLyHhbIk7puOqTWDI8MqPnKuvAjtJNSBWWcyrM4F5BVO7q7WQn+l2S/TeK9TRG0rtoFs6nyM6HCN+P0LXjJM+0vX9IRdXhvbOosEi+bS2wz8QVYkpewNFSP+gHoa2k5Q1Vzn6X0aRBk3/yxin3fps0sUDOTQdS6wvjGe8FCG/IJNZudNG3T4nPsFQj3A6PsFFJKq3fdgd51VAZSOgxtPvAlG6412Vys7Vl+Yqo5hSShpGO7DWTdd0wkv+4YsMRnd6SghYoMq/ig1yY2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3GZVCAonfvwHWNnRehuiDG/g+Oc3IojuQHwQAmdaow=;
 b=Y3JlynSdKfX4gfLWhdSJ/stpl0imCZrzgOgfQK92u7KWlA/56QM3/RQ1EYz9RpyPELEHqvYDE2AC6LqReSKoOBAGqHZsmkq+R9zWtp3uXT74jWXmGQ+gWMuctfB2+MAS4VSfl4P+SdPSHSIJplZWOK5sedPMd7gSUkboAKZR35Z9e4cqSGdhR6enrHS6QNrv/9Ryw83IAXt9DliyRf15nLmWzCzU7HB4xqTc16nrUDE+H9YloQz/nc+MZLSWdmLsnbIXuHG5NafBKrB9Ge8qHx76zIaeJwY8fR/QycaR2Pgmiacyyq5rMxtM6U+Yo32aEjv/ZlLgozxrL8Gpv3aikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3GZVCAonfvwHWNnRehuiDG/g+Oc3IojuQHwQAmdaow=;
 b=waReo9zPdBTdOxHhK0MQM0rGlX8ImAP9CHlvHWqdy3l+RPrbj2upoQpfN2azENNb3g4yU1hxWhrC92dbAAu61YfcAs+ee6E47T7pCceFBFwBJ9waJKYvremhfc+CBvY/CafpLXSupvo2323tLS34V9vGAlBeTH47LasUFrdV4J8=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM0PR07MB4036.eurprd07.prod.outlook.com (2603:10a6:208:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10; Mon, 15 Mar
 2021 09:19:45 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f%3]) with mapi id 15.20.3955.010; Mon, 15 Mar 2021
 09:19:45 +0000
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
 <20210127110944.41813-3-alexander.sverdlin@nokia.com>
 <20210307172650.uztx3sk5abybbp3f@e107158-lin.cambridge.arm.com>
 <0c122390-6e76-f773-86e9-8c085f4384f2@nokia.com>
 <20210309174201.n53za7mw33dqyleh@e107158-lin.cambridge.arm.com>
 <3eecf51d-b189-9e8b-f19d-a49d0764aae5@nokia.com>
 <05608bc8-f44d-5f91-15ab-af00c59b53e6@gmail.com>
 <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
 <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
 <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <ad517652-edc7-7f0d-f768-2cd7ed1298e6@nokia.com>
Date:   Mon, 15 Mar 2021 10:19:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.166]
X-ClientProxiedBy: AM0PR04CA0019.eurprd04.prod.outlook.com
 (2603:10a6:208:122::32) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.166) by AM0PR04CA0019.eurprd04.prod.outlook.com (2603:10a6:208:122::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 09:19:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de5e3d00-140a-477a-3f8b-08d8e79378e4
X-MS-TrafficTypeDiagnostic: AM0PR07MB4036:
X-Microsoft-Antispam-PRVS: <AM0PR07MB403634C543ED7A3301CBA09A886C9@AM0PR07MB4036.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDxXnnb3J5KM9e+GmChkUgwQgB6/EcF9ID9zoG0sX4t9ZkL2HbS3Ie+nBuikdN/1g6n5aZYaOjYVyrD+uz8KAN1CcZJquKAuPZABji5ZyHJ7ARJd5Ma/hFsV8e4mV3s2LuCZIIl0XCBIZO63cqQpYKMYPaOQpYNh6lZLX8rGAnD0vzxOoaOgz1ofEFXDmAoq8TM7MdmNEIm7QAzUbf2LolmvDk62XHomBBIpqX32wgsYbRLKhF4IpNIsRy+8/hidTkmXJlgAYKJh6XRx+b98SA288MVLLeepth18+BQL2afksySJL/sFsidl1G0VOeROmoPe3hrs3/Vciex9vUA+Xq6wwsE4GOGYEWkqou1YP4vG5rg71FxsfJkgqTY84Xr0S0BwNcwH1ls1fwDHQ5k/SUkxP1DuWXv4ItkLN7gRmSGmY2KUpqOZbYghenwHTbJ2h129DlZQkzOuQnhwJRQy9Y7qWKlZU9hcofd0kg2Qvv6dWrf0CgN2yeSLE0wkJ1Rj9MoE127gBo9pWBoPNEsBqetdUIXzJwLZf2KGyZqnTJSMbhB6sNZuD60+D9uqW9HnqgliQTHo7U8UFFqhtun98fJcwgTGTBB8bnWIyFfQ5KJR49xna4KMAlxd3L6zW20WC/FkmtlXIPYd/jcawwjdvgbCxjYUTGDJUiXiLxgmNqk/TrP7KHJ96po2f0Yo0VK7SI18G47M96Y7Jw0Lw/1GOe3JnKYFxIGLJAXoZBNPeqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(31696002)(66476007)(86362001)(8676002)(6486002)(83380400001)(52116002)(6506007)(6666004)(31686004)(53546011)(36756003)(110136005)(5660300002)(54906003)(66556008)(66946007)(16526019)(2906002)(966005)(44832011)(2616005)(956004)(4326008)(478600001)(316002)(6512007)(26005)(8936002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UGNOQmJEQjFEQ1l5ZFFKVzNaN2x3dU4vOUh2c3FJOGh6RUwyR0FndDY1ZEJv?=
 =?utf-8?B?dkhocjZMYmRkNjlXSDdTSHVZdzZ1bkRQMzA3dkFtYU52dS9WNDFlVE9iTHdI?=
 =?utf-8?B?SlZPSng2UkdYeUpqLzQ1VTN0M3lmdXN3MDdBKy85dytTM3pUdmhiekxjT2JQ?=
 =?utf-8?B?MnYvbGlXYzVOSnZKOEt3dkZ2MHBlWEZkbmZUYy9BZXA2Z1Jzamd3NGpYcy9m?=
 =?utf-8?B?YXZ5bFZoRWZ5MzF0bXl0UXV1L2FkSVVLTkJiaFZaZ3BiYWttQW1lNFk0R1Zh?=
 =?utf-8?B?dldseEFhdFBLWWNIdnNDRGRrQmpVRm1pek5tbmlHUmhWam1nSFdDbEh1Ykpt?=
 =?utf-8?B?T05iTVdkOVEwRGhNMzVkKzJNbmZIRUx1R0d6MGZRakZXZTJybS9VekxPUHhk?=
 =?utf-8?B?SUhnTzhNSnpQY0x0Tk9yRXAveUdzQUpEK1FncGZZN25ja2prWi9Kc3VjTnoy?=
 =?utf-8?B?elRGSTNmWFZ6VzU2OE1uU1JiV0NSTDlOb1hKbnAwcGdZZjRUT3U5QVlscTRL?=
 =?utf-8?B?UjE4WHptTWJWa3pEcjRVZjFQOW84VkJNSDBqeWtxSk5jMGQ5S0ZVMTRnTXQ5?=
 =?utf-8?B?SW03WDBXUUxTTGhFdnFDY3ExSmlBVHNlNHBTeWx5VC9Rc0dnTUlqbmlSUjFv?=
 =?utf-8?B?VGhnTmhGZHhXVzJLZ3RRdUtVdkFueENjK2JObUNMeTRZSTJZZTNleXhWQlhp?=
 =?utf-8?B?M3M1SldicnFjT2tVN3BIbHNvVEx4VE82dUNSc3llQ0s1eVM5dzQ5ak9DNXhZ?=
 =?utf-8?B?Sm85L1o5QkJCUVkxN3IwV2pTaUVXMS80dVMySFk3K1ZaNk9MOEF2eTZiLzJj?=
 =?utf-8?B?UG5qNkZjRnhyMHk5OG1mVjhYelVwR0ovN2lhbVJTTFVld2pUR2hPTHdUZmll?=
 =?utf-8?B?TFFZYVR3S0tYUnlJbjVYYzYzOUp3ZFFsQTZnVTBDQTNNWGg0cGhFUTFzTE9U?=
 =?utf-8?B?WW9UNHB2ZTZBM2lqVlJ4MGZrNG0wZitsc0NzUXd0N0Zxd2IvMXZkYU5VWlVi?=
 =?utf-8?B?RkltdUlIUXBuWlh4eFlLRjRBLzZMd05hRXExbEZNb2trTnQ2Z3Bia0R4bERE?=
 =?utf-8?B?S2NpVGw2c3dvcTVDcDVWNEpJQmJNemZCR3FpT3lsQXQ0cDNyVjdsaFNpNkg2?=
 =?utf-8?B?SHJWU1ZsNmp5dlhEaG1PU2srenpiQUVOUlBQQ0VlcGFNeTNwbDVWdWQxREJo?=
 =?utf-8?B?MG9yS0pXazc1alNFSWdmV1daUGEvRzFoNENXZDBlK0lycjJGVUpwN2M4bStW?=
 =?utf-8?B?VzdDTVpKSCs1WGNnQmEvVEZMeGJpSDJtbytMc2JIeFhvdTMwZEhFaEttelJk?=
 =?utf-8?B?OXQxZFIzdElrY2ZpaWppUEFEa0RMcFVCTjFHajZMNGZBcjNUOUltSHptbHRT?=
 =?utf-8?B?K3hYNU9HU0hMRWhBbDExZ3BhNVN5UVV5cCt0dEJCU0djTk5CZmQwLzZaWXAy?=
 =?utf-8?B?U3pUUGRVcTFOdzlGTVBxV2ZhMS9CdHVhR09uRlpLZmpsbmxxd1BnR3FGSEF0?=
 =?utf-8?B?NXAxWUdVemhxWXZJc1daV3lieTBwRlBDYXkxRTBqTUJHUEJ5VjdYWUN5Nm5v?=
 =?utf-8?B?elVzMHN6NEtGbXhseGZua0daMDVzYW5ReWE0YTlaOWRxOE5XY2trdzdiOGZu?=
 =?utf-8?B?NmU4cld4eVltbWw1Y1JVc2dqMHNlRG83NmZGQytqZEluenVRVzVlR3I5blNE?=
 =?utf-8?B?MmpOQ1ZCU04wY0JFQ1hlRjNkYllZRHQ1eHBOUFQzZ0NldGxsaGVwQWxFZ2hn?=
 =?utf-8?Q?8iJW1SFRm744pT+awvE0DWf02xYgWHJEvi0MR8u?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5e3d00-140a-477a-3f8b-08d8e79378e4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 09:19:44.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: musRad/AkQqQLAa2hzLH/i7uoJqizzV41vqVCjQErkYozC6eR8e72Reo4grU7w2HI12trBDL/RK/osWwB3Euichs0kzsS4Rkvfwl4KsOpVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Florian,

On 12/03/2021 19:35, Florian Fainelli wrote:
>>> https://www.spinics.net/lists/arm-kernel/msg878599.html
>> I am testing with your module. I can't reproduce the problem you describe with
>> it as I stated.
>>
>> I will try to spend more time on it on the weekend.
> Alexander, do you load one or multiple instances of that fat module?

One cannot have "multiple instances of the same module"...

> The test module does a 6 * 1024 * 1024 / 2 = 3 million repetitions of
> the "nop" instruction which should be 32-bits wide in ARM mode and
> 16-bits wide in Thumb mode, right?
> 
> In ARM mode we have a 14MB module space, so 3 * 1024 * 1024 * 4 = 12MB,
> which should still fit within if you have no module loaded, however a
> second instance of the module should make us spill into vmalloc space.
> 
> In Thumb mode, we have a 6MB module space, so 3 * 1024 * 1024 * 2 = 6MB
> so we may spill, but maybe not.
> 
> I was not able to reproduce the warning with just one module, but with
> two (cannot have the same name BTW), it kicked in.

... well, may be the size was arbitrary chosen to not fit into our module space
and we have more modules already loaded. But you are free to adjust the 
amount of NOPs! :)

-- 
Best regards,
Alexander Sverdlin.
