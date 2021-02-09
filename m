Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAA63149FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhBIIJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:09:11 -0500
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:1508
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229517AbhBIIJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:09:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCbk4hI0VrbcBAbfbAebXoCIh/0QYICD3Ou0RWyR7rEfX/7oI1xkbZhiIERMP6IUW2+H71u132YUW3bdrqxMSdT+PhW19K2NyE8ELOhASTHD6VHe5enj7PUPPXEi2Qzyl54tJqAZZsNhFVIUlkrCQ4UX4zdUW4wNitfAQIA+E3E293hWuLAdTix8pngPlqtPz9BXasfOAmP2kkTArJnQBydsdHSSy7mqY6NKVeMI47RNmmcTWeLxhddsAfenHiiawVnSK9yZXy76NwRKzz5Q3qprbM6xMprOtlp4bIABZL7IsX4yxqiREhW6q4WdQe1DOOfAkh8aPwo11bGzYki8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmc/oBkdqo9jCgMv7DRuDIfIsbxE1s+XLpb/jSlKBec=;
 b=JWOUMr7ycDaOVFXrqM1Zz0SSx9QP93qveissXdokzV7S4Lo0ltRQXjo8LmBdqJ3+UVbPELtkoZK2D41HzNTT8ANqYUqELCVbyuwGQ1uhy3QCvqxcAEMe79Td9mkWu2iyTXHXvrx9RLlFWgnoZQq2RcOUqZfQqm7NIlsCxYrn9O9tiXAhwcuSMSj8giS3ozKilFPIvu18I8aDa2XtlV97nII7IWWH+ARlwIEDCYTOlcVNTXfL5FIu/a//7WF1HVhDMJk1nktTFQPEM1Vazr/TSnlynX4LxMN4Qe63wfpCM5EUQWzA/JgJk4NLt298/M/pBFibECZoFDR3s8WG1wpDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmc/oBkdqo9jCgMv7DRuDIfIsbxE1s+XLpb/jSlKBec=;
 b=GtFhEIemzuTDVE5xxjjXQ6wspU1fIuNFk25nEnqgwjhAh0bjf+B6jktBByVkm5hFx1LX18gMRGe4lonQj9m+iAOKWRbs0mI226rboGeoLZWBOCsAEHyDyxGdpDkvQC3lhgkVS11/fUbgNR5oEic8IEaJ79jaw+6uq3cL+C6OjgU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB0069.namprd11.prod.outlook.com (2603:10b6:910:79::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.19; Tue, 9 Feb
 2021 08:07:40 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::5003:3066:e469:80a0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::5003:3066:e469:80a0%7]) with mapi id 15.20.3784.027; Tue, 9 Feb 2021
 08:07:40 +0000
Subject: Re: [PATCH] drm/tilcdc: send vblank event when disabling crtc
To:     Jyri Sarha <jyri.sarha@iki.fi>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210129055831.1702862-1-quanyang.wang@windriver.com>
 <1c6bd553-ee27-c93b-59e6-8d3c8368213a@ideasonboard.com>
 <40037f81-2444-1fe0-f5da-194f2a3d3f22@windriver.com>
 <d38abc6d22590f0eea1aa7aae3ff754f@iki.fi>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <29f8d014-ddb5-527e-70eb-eab1079562dc@windriver.com>
Date:   Tue, 9 Feb 2021 16:07:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <d38abc6d22590f0eea1aa7aae3ff754f@iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BL1PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::19) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by BL1PR13CA0134.namprd13.prod.outlook.com (2603:10b6:208:2bb::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Tue, 9 Feb 2021 08:07:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6419af96-dd1d-4c45-d011-08d8ccd1c55b
X-MS-TrafficTypeDiagnostic: CY4PR11MB0069:
X-Microsoft-Antispam-PRVS: <CY4PR11MB0069B84F564CFDEA1B7BC20DF08E9@CY4PR11MB0069.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nH+r8VkGDyDkHVKE8hrqxgavNIhmCMhyo0KXHrFgXP0xkP0MijPjvCsy6+F9YUcy0i7xuiIFlKg6tTYC96gFnppQXbQ37+3iglHVGwLaT32mEj+IvfVnSESYAIx9tpf7M6kCJnAlUFnXwYKQGz+zzxc+SqYiSUk59vJg7h69pGUkYGgEOaNfqOX+X+2Rwlw3DnCrNUwGQddlTzls7sbMsEsu7vuxvEL7Wp0/yl3a7elnF7waTjkWtUb0+0cBrzMwx5PKsKjqWIt3PODhZ0KgldQlcMtB8ekHY2WqS9dx6tCBRRDf1ecbT3qKxU0TrP8CbrgVHNWreEy1xVY3vUKlTGXLgfmD6qliygSq0I+3U2uBb5/n6WP+Dh/DZeCVEGlYmz5iXrJLG8B92FsuMo67MGZxMmmkG6bL9F5x4MME0xOwfv0SSsufTJ6a5sx1iAltOqNVz5+LXJ/e0IQ0n1hSqMBMydy+X3PTNEvTN7+Pub/6mRiH9MONjCqejdT2MoZ5Z1KnVeQ1R0TzFkuDqmcSB7w3NxG8mCBlfgKbiS68GLFCRwmBce20SB28V7oJsIJAd++P+/0B8Dx+mlznDFNG6ML8fFfFGggb9E2IoRib1jXZzsZuse6f9R06cY9eviL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39850400004)(376002)(366004)(396003)(316002)(6706004)(8676002)(478600001)(26005)(36756003)(66476007)(6916009)(54906003)(66556008)(8936002)(6666004)(186003)(16526019)(16576012)(6486002)(83380400001)(5660300002)(66946007)(53546011)(31686004)(2906002)(31696002)(86362001)(4326008)(52116002)(956004)(2616005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M1ozQUxtY1dCV011cTQrajZOSnZPQjZvVE0xQUtRS1NUNElZeER6L0Y2V3Uw?=
 =?utf-8?B?UVY0eUFETDhxTk1TTW1KN2hDUzNNQVBSOE9WdEc0WjZvR3FGaWxyOGgwZm5N?=
 =?utf-8?B?SkcwcU5TWjhaMUU3TkVCMldNSmpKeVhQTlJTejh4T2V3c3J1eGQzUzhIT3Zo?=
 =?utf-8?B?TWtoNkpsT2F1bHhLaEdFNEZkc2kvbm84VDFxVStoWnZUalV4TU92aHY3NWFE?=
 =?utf-8?B?VWtWNmVtSkhLREVZYXpveG5Jb1orT0NETzNLS1dxYTlueFByVldVdFVZa3Nq?=
 =?utf-8?B?SVY2eTAydE13WGlwTXNZNlo4a1RzU2NVOTRtcTJUa0k5U0dCTk5oYjBQTjcw?=
 =?utf-8?B?OGNESXlzOVJwdEl1SmhKbnI1L2lmaTJsSDRsMnR6Sy9nZG8veXgvbE9aT3Yx?=
 =?utf-8?B?VDBtanJqQU5zdHFMZWZGeFprR1JITHpNUHJVUjFySFBRcDgwZWNrd2NNOUlv?=
 =?utf-8?B?WmV2eE9lRUM1OFlLUXVITUtNa1QydlFobGRLNXViaHNlcjNucTNVVVlVVjlx?=
 =?utf-8?B?eWV6d0lOMHFtZWtNdHl1RE1sai9FUHhETEpRMzZxU2h6S3lmWHJ1aG5yVkoy?=
 =?utf-8?B?YjdlVDlIYjg0SHBybGdzb2ZVR2sxUmdmemY3OSs5VEI1ckhXa2Jqdk16dW4x?=
 =?utf-8?B?YkRyOHhHOFJPVDkzNlhxbmFZRzlXYWRuaHFvUHpwcENRZFdtVUtWWkdoaTJZ?=
 =?utf-8?B?QjQ5TEQrMUYxdFNuZE1Ga1kvSjlTRUtibS9mcFE3Rk9raVNqaU1mYW5VWVFG?=
 =?utf-8?B?dFdvc3U1aDBsZmI0cHQzbEpGYVNXa2tybzdmQmcwbEtIUVlFTVBWTkRGMDYr?=
 =?utf-8?B?UVNlcHRWcDlMeWhJaEI0TU5RSnBFR24vbHZyaDVJdlEwT2JGVE5rU0drTktK?=
 =?utf-8?B?aEl3T3RuMnpaQXM3YXFQRVRpWS9oOXRKSThCdzM1clIwamMxaWJleWZzdlVC?=
 =?utf-8?B?di9DWGlIb1VjUENGSVBBdGk2T0UvUVZNaklyZkxDdW0yaWxYU1IzSmR3RUFz?=
 =?utf-8?B?UzliSWdGcWh4UGFNejZtUG5UVFQ1UXdlU1dpRU1yd3p1REU0bS83bHJPb2Z3?=
 =?utf-8?B?N2krejNHN3dUK3kvbjBBTlAybjlMc3VSUlJxVUYxc2YybzNhVU9oOHJJRlY1?=
 =?utf-8?B?WjVDTERaK0Jzd2EvQ2RkZ3g5VTlES01SL3U4MytjL2pjNnFTdmtsdDM2Sjhq?=
 =?utf-8?B?K3M2TE5qM20zbFhUdXhvRDBQbnlRUDM5UkpMWWtVdVpVRG1SeHVpOHJUUXdD?=
 =?utf-8?B?TysvSjhjWXhraThiMFhPbzYzdGswcUUzUElYSEJka2x6NTdPdUpDZXVFczZU?=
 =?utf-8?B?Z2VvcHBNSnJDclJXeU45bFJiKzRmRjhGUGpjT2kxVXVXakFDcjhIYytoQThv?=
 =?utf-8?B?L2o1NERQL0NyeHBjbzJ2cU9ZZVlwM3luRnNBTWxRTkdtcldsTHJJaHZMRjVM?=
 =?utf-8?B?bk9jTUhEQkxWekFvbE11QUsxY1lIWExqVXhsUXkrMVJSRGFMSzFWMVUvLy9z?=
 =?utf-8?B?MlpRMks4cXg3eDA4UE1SU3Q3YnhFMExiY1Y0bXhRYTZVUnRXR1hkK3VFZHls?=
 =?utf-8?B?NlllR0xJWHRSMHNDVjFCNURXazJHUzFJMGZTaTlWN01qd201SlRBd2lSamJS?=
 =?utf-8?B?enZOTHdpd0M2YWtTNEVBNzZaYW4xYW9tbmJSZks3VWsxeHNFZkFQZ2JmSENK?=
 =?utf-8?B?L09Bd1QwN203ZmVVUE93K1hMSStHRHFFeldhaTVZOHRhODZERU1xOUxzMm1M?=
 =?utf-8?Q?ArM2l5XVXbGHpkfvoOA7FUHWymMbd/ZaJRmcsJv?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6419af96-dd1d-4c45-d011-08d8ccd1c55b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 08:07:40.7133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewB0emekJ7Ym5RmD2/vQhKO9RiV5SebZnV6SRVFGU3bSGGUcOKCvX8FJdcvYsp6xOaZPffPrMrp8YVkpTQowQzvBOWJOffDUR7tLuUjcDno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jyri,

On 2/9/21 3:58 PM, Jyri Sarha wrote:
> On 2021-02-09 5:09, quanyang.wang wrote:
>> Ping.
>>
>
> Could you resend the original patch (I have not received it) so I can 
> easily test and merge it?

OK, I will resend it.

Thanks,

Quanyang

>
> I'll find some time to do it soon.
>
> Best regards,
> Jyri
>
>> On 1/29/21 3:58 PM, Tomi Valkeinen wrote:
>>> Dropped the @ti.com addresses and added the new ones.
>>>
>>>   Tomi
>>>
>>> On 29/01/2021 07:58, quanyang.wang@windriver.com wrote:
>>>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>>>
>>>> When run xrandr to change resolution on Beaglebone Black board, it 
>>>> will
>>>> print the error information:
>>>>
>>>> root@beaglebone:~# xrandr -display :0 --output HDMI-1 --mode 720x400
>>>> [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
>>>> [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
>>>> [CRTC:32:tilcdc crtc] commit wait timed out
>>>> [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
>>>> [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
>>>> [CONNECTOR:34:HDMI-A-1] commit wait timed out
>>>> [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
>>>> [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
>>>> [PLANE:31:plane-0] commit wait timed out
>>>> tilcdc 4830e000.lcdc: already pending page flip!
>>>>
>>>> This is because there is operation sequence as below:
>>>>
>>>> drm_atomic_connector_commit_dpms(mode is DRM_MODE_DPMS_OFF):
>>>>      ...
>>>>      drm_atomic_helper_setup_commit <- 
>>>> init_completion(commit_A->flip_done)
>>>>      drm_atomic_helper_commit_tail
>>>>          tilcdc_crtc_atomic_disable
>>>>          tilcdc_plane_atomic_update <- drm_crtc_send_vblank_event 
>>>> in tilcdc_crtc_irq
>>>>                                        is skipped since 
>>>> tilcdc_crtc->enabled is 0
>>>>          tilcdc_crtc_atomic_flush   <- drm_crtc_send_vblank_event 
>>>> is skipped since
>>>> crtc->state->event is set to be NULL in
>>>> tilcdc_plane_atomic_update
>>>> drm_mode_setcrtc:
>>>>      ...
>>>>      drm_atomic_helper_setup_commit <- 
>>>> init_completion(commit_B->flip_done)
>>>>      drm_atomic_helper_wait_for_dependencies
>>>>          drm_crtc_commit_wait   <- wait for commit_A->flip_done 
>>>> completing
>>>>
>>>> Just as shown above, the steps which could complete 
>>>> commit_A->flip_done
>>>> are all skipped and commit_A->flip_done will never be completed. 
>>>> This will
>>>> result a time-out ERROR when drm_crtc_commit_wait check the 
>>>> commit_A->flip_done.
>>>> So add drm_crtc_send_vblank_event in tilcdc_crtc_atomic_disable to
>>>> complete commit_A->flip_done.
>>>>
>>>> Fixes: cb345decb4d2 ("drm/tilcdc: Use standard 
>>>> drm_atomic_helper_commit")
>>>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>>>> ---
>>>>   drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 9 +++++++++
>>>>   1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c 
>>>> b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
>>>> index 30213708fc99..d99afd19ca08 100644
>>>> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
>>>> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
>>>> @@ -515,6 +515,15 @@ static void tilcdc_crtc_off(struct drm_crtc 
>>>> *crtc, bool shutdown)
>>>>         drm_crtc_vblank_off(crtc);
>>>>   +    spin_lock_irq(&crtc->dev->event_lock);
>>>> +
>>>> +    if (crtc->state->event) {
>>>> +        drm_crtc_send_vblank_event(crtc, crtc->state->event);
>>>> +        crtc->state->event = NULL;
>>>> +    }
>>>> +
>>>> +    spin_unlock_irq(&crtc->dev->event_lock);
>>>> +
>>>>       tilcdc_crtc_disable_irqs(dev);
>>>>         pm_runtime_put_sync(dev->dev);
>>>>
