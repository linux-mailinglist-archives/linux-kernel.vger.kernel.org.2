Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464043AFD23
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 08:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFVGmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 02:42:49 -0400
Received: from mail-mw2nam08on2089.outbound.protection.outlook.com ([40.107.101.89]:11324
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229490AbhFVGmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 02:42:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDzbWasJeylp9R3CLy4YwJYejq2PRE72pJlQo2fdsHNQFeVSWsbTsAQrliOWeDVR+B1Bs1KGxlOfZMEbE04em6LQ+moDQNXdCpb49e7yT1SW2rQWuOeVHDelVDhIo8CfBWkePj2J7LEe4ZNl3YjdlV4pcRyJn1f9G6gGViKazZ12FNi6ks/Tex2zOG5d+6qmchrDk0+vZnT9OgJJuJPDYDi3nLSP0vHwvKxz4AvUJZrpz/5kWb5BQCdY1MJMvYtLY4o7h69PCjJnPeu45l3gZnrNa/3Llt0j2QGFgN3iSOTY/zVmYNWLGgC2GK34wj7cLkmDSoTdYIoGjxRho9iO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJg1DdBauHJ9Nx/amwcB26FuZjpDX0LuH58L/ZDBmAY=;
 b=cOCRQf4UB+GFtljEnprsGkf4M2+oyhpH5zw6wa4RzpaukW7bWY0mXg7Ku1MgQMC4hi9YNsSwsBnbiXrxAhUrKOA54ZRETNlL93+IKrhunjw4CbbT6Y/2PKjCEjwIySHXmsq361VHa2t4JPLFkuLd6QZBWUyAAbkz3uR0frumxkM8Mdd3xpDwITDcIdvQewUua4HZ1NG39NoWXvsFuSYzX7kYWN0qKijF5sXHt/2y9rw7UiVaWqfk5DDQSWCJmDlsmxfwJr/IwlvCn5Y74mWFvMHfRvHaDkxTguyrxjbj+NChTjMbq9FwODMzpPwFB3lr29WCegYNeYYJ5Q5cPW3jag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJg1DdBauHJ9Nx/amwcB26FuZjpDX0LuH58L/ZDBmAY=;
 b=Tw+slSQwe9Bdtyf0MPJwXVl3zrPcpQEzKYzGdJrFOEuw1q17XFrrhb2ldmuY0iC1n1l5LWoF8+92Rk+/UrvEClPEuzeoXZMJCC/+EQw9KYw5fvICoR/oHStiyTH0kT74JuolMU8ehEjBX0UjvUOJumQUjBQVa2pMOCsr4g+41KM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4607.namprd12.prod.outlook.com (2603:10b6:208:a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 22 Jun
 2021 06:40:31 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 06:40:31 +0000
Subject: Re: [PATCH] This patch replaces all the instances of dev_info with
 drm_info macro
To:     Aman Jain <ahjain2706@gmail.com>, alexander.deucher@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <YNF+Cr9wHupnt3Za@reb0rn>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <43f6b863-2594-1eb1-c2ef-f8251a10336b@amd.com>
Date:   Tue, 22 Jun 2021 08:40:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YNF+Cr9wHupnt3Za@reb0rn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4]
X-ClientProxiedBy: AM0PR03CA0077.eurprd03.prod.outlook.com
 (2603:10a6:208:69::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4] (2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4) by AM0PR03CA0077.eurprd03.prod.outlook.com (2603:10a6:208:69::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 22 Jun 2021 06:40:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de51c4bf-3edd-4b4d-3ccd-08d93548a150
X-MS-TrafficTypeDiagnostic: MN2PR12MB4607:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4607F212D23971C71C06F9B883099@MN2PR12MB4607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Evhzh7w6ydxewyUO6NAHlwz+knA3o0Lf0dRKOHpVGhOHcOXGMwzzv24WHKQ4gxv/oVSXD9Bpd/JTP2y6xUFQN00GOH5sWU6LzYLFx/DPoM/6D+M+jyKhAiAjCBmB8wvUL/bdnMT8ZIZ6LlDf6nRAzO5lS9UzhMeqYFBDy/yiFP81+2fsfjidD5lsCCSwLHl8+z12PA0GE0Ba2JtCbtAg4fwuHCvU+TW2pe388EcFlhECN8K0D/jM+16aZqPi72kF4yh5TWkfssqWD7b9U5KtvnmRGOrXl9BLx/wdsH0Kjeo22xgX/a9iPG2DK/YHLGdQ2LYeiijXUCN21Y3Wnp9f6IiIhRR2MbfCeZFjVGSAwXg8xXp1lOB7BB+w51gbQrupbIyS6lZX972EvP26V2ELgjmhOIE9OybL+e/XQ1rU1S5lildlA/1b2QEdiMB8kr3/aKKUkIcarM7aDg71hX2qyfdcWEuH7Ixwugp90vKMIk+bm9Hh+nY4nkgu0hMlB2Ww+2nmhR/cOo3uYamMEJE+q2Et9LFOTb/jbDU+iXDC0eGkoKnc5qFSV562qOGOa+lWbgFF+UmC2wT7QOVleazovwcY5PBhAAXUCqbEUjoHUy0GeG7tiJTZm8GMqUxhzOPXqb4QgZS/cr4plHxMyn0RicG4QWsHPDyoGzwry37mr8412USK0O8qnMrjnPJND8g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(31696002)(2616005)(36756003)(66556008)(66476007)(316002)(66946007)(86362001)(83380400001)(478600001)(2906002)(16526019)(6486002)(8936002)(31686004)(8676002)(6666004)(186003)(38100700002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhHekJVN3JnNC9YUFZIQzFxN21tanZ5MldIOThRVmFnN2paRitPRUxOQmFJ?=
 =?utf-8?B?YkxmYUxuSFVtWmJBRkJCaHpscDZNT1JvQlI5TE5wNkMyMjI2N21UTFo5WkdQ?=
 =?utf-8?B?bUppaWNTZytSaVE5VUhwRkpBYmRHSzB5aGtLNEhlN29iTElhUldBOVU0Wk1Z?=
 =?utf-8?B?MU5nTzhTOWJ5Y0dvN1JVUmYwaUh1bFJPYlN2R0VrTXVXRk5IOWxpQXhJT2pM?=
 =?utf-8?B?enloTVY4R00xTTF3cXhpbSs5WDBZWFdXNlc1WTlyRk9kREVHcDQxZ3JrTnZH?=
 =?utf-8?B?aFpJVGd3OVp0cG5sQmlZS0xBMTNXNXdWd0szL2oyYXVOTGFTOGxOUmU3S1hl?=
 =?utf-8?B?Y21vVEVJVlM5SHRLeThOYnNrK05qRlJ0WlpWK3dwNGQ2NnNNRHdPY3NsUFlO?=
 =?utf-8?B?eCs2RFc1YVQzbzVDK3hxc093bXAxd3NoYndUNHhQd2luV3lPendoTFdWbzZX?=
 =?utf-8?B?eWhGN0VwWGJCLzMvTEtCMVBlMzljMWxVa0dqUlVkZjlIdnE4YThtaHlBckcx?=
 =?utf-8?B?Sm9oSW5mNTlLTSthODA4THlBNTVCMnVOTGwrNFhsUFhVYjZQbC96UWhtR29B?=
 =?utf-8?B?YU9hVmNEUDNUeEo2OHpmVFo5V2ZJd1RkakdOL3RqWWlqcFc3OUEwSXdjbTFm?=
 =?utf-8?B?c2p6QlplRWV0WkRVcWJYS20rVC9pQzB0WDFsNTlxdkJxenJlb014bWcvQ2d1?=
 =?utf-8?B?dEJGWDBjc1craFQ2TUN6U2hTZjZKVllESjJIcjRrODcrU2YvVGJlZDBtYnJB?=
 =?utf-8?B?VWIwd3FHVU9XdFB6bG1vYVlYVVlJL0RkVnEvV2pETjdWMVl1TnBoSmFaU3ZZ?=
 =?utf-8?B?TGtPOHRTS1RFbzB4blFlNXIrSkcyNldVS3dVamtWT0hTT3I5MUl3VFk0Z2FE?=
 =?utf-8?B?aE84Ykk2MFdqRFR6U1Fob3YxNjNRWUZsYXp0dnNyNDI0d2FTVE91MGF0RlBv?=
 =?utf-8?B?Q3d4UkJTRm9LVHAxME5ld2RsTjJ5cHlkYjhOQUlGVHlFTE13ZVZHbmU1UHcx?=
 =?utf-8?B?NmxIdU5Ib24rREhVazJXQllvczBBci9JTUlLRWw4eXg3T25aeGVwRTN3SDJE?=
 =?utf-8?B?SU9YSEd5SE9hY05WbzV0NWorNXFXNEF5MHZGK20wdUVtOW9zWEhQalh3cVJH?=
 =?utf-8?B?SmFyTUMzTld4N3pwd21RcVV3Wm8zSjBrdlJqakcvMlhlZjgzaW81bFhDQm1r?=
 =?utf-8?B?KzQ3dkNkL0svNFJyZUVoSm5VVmxTUnJ2T3QyLzFYcUsxSmxMVUlsOGZLQ2Ry?=
 =?utf-8?B?cTVCcTBEWXB3Tk5zeGJYQmFSOWhZQmt1bGZJMTUwSHpKMGxYQk9PSFBMNHQ4?=
 =?utf-8?B?K1dPc0VMNWNyYzZxL016Y1JYV2FzVFoxZ1Q2eG5xREtXTi9KYkxJU0VuZXJ4?=
 =?utf-8?B?SllGbmpwK0RMMVU0VDNvZmVmZ01BTVU5eVRKZ0l6endpLzNlcTBkVUxQNVZN?=
 =?utf-8?B?T3FhdlZOUnVvblZURzBJaGEzMW41STk3dHFhRTZVNTRtbHArNGlwMUM0Tjht?=
 =?utf-8?B?akZsY2M3NGNZbjQ1bFVyTEJ6cC9BcHIybjFRWnNsZnNndU9wNkR1TkhmM0Z3?=
 =?utf-8?B?NG15TnpISnVRTTIybHZjQ2tTUEQvNjVqQTFNc211bFEvVE83bkVnb2V6R29u?=
 =?utf-8?B?TFVHYzdndVB5a0RoZktqNk5RbXMrS0d3YVBUSVBnTVFTY1ZMTXVTeGRkTFBD?=
 =?utf-8?B?UnBlQmxsM2ZrQXZ5VE5MSjJ2TkVzSWF3MnBCdE9SL3JwUWJONktFaFNpVmVI?=
 =?utf-8?B?WDZOYTlPM0lydzMvZk9IR2xXUGFjYlBnYUFUK2o5UENmT1ZUVzVCclF4SFZn?=
 =?utf-8?B?dmRvSFRZYW5RV2VXTmJBKzN5WjUxNWEycG5iL3BKcTJZSFRYemY0b3RvaXFv?=
 =?utf-8?Q?opbWfF3uO4fqj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de51c4bf-3edd-4b4d-3ccd-08d93548a150
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 06:40:31.2592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvepQm3+B3j4oHzwjjEN+3gFnkYPIgV9xgGBoWAkWHgB3I5U7Ub4onJxehldZVRc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4607
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.06.21 um 08:07 schrieb Aman Jain:
> When a driver has multiple instances it is necessary to differentiate
> between them in the logs. This was done with dev_info/warn/err since
> DRM_INFO/WARN/ERROR don't do this. We now have drm_info/warn/err for
> printing the relevant debug messages. Hence, this patch uses
> drm_* macros to achieve drm-formatted logging

Well first of all patches for radeon should have a drm/radeon prefix in 
its subject line.

Then I don't think this patch makes sense since this is about the 
hardware support of the module and not even remotely drm related.

So we most likely don't want the drm-formating here in the first place.

Regards,
Christian.

>
> Signed-off-by: Aman Jain <ahjain2706@gmail.com>
> ---
>   drivers/gpu/drm/radeon/radeon_drv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index efeb115ae70e..75e84914c29b 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -308,7 +308,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>   		case CHIP_VERDE:
>   		case CHIP_OLAND:
>   		case CHIP_HAINAN:
> -			dev_info(&pdev->dev,
> +			drm_info(&pdev->dev,
>   				 "SI support disabled by module param\n");
>   			return -ENODEV;
>   		}
> @@ -320,7 +320,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>   		case CHIP_HAWAII:
>   		case CHIP_KABINI:
>   		case CHIP_MULLINS:
> -			dev_info(&pdev->dev,
> +			drm_info(&pdev->dev,
>   				 "CIK support disabled by module param\n");
>   			return -ENODEV;
>   		}

