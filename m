Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA22397CCC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhFAW7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:59:11 -0400
Received: from gateway30.websitewelcome.com ([192.185.168.15]:46171 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234766AbhFAW7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:59:09 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 84D7DD96C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 17:57:26 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id oDKAlw6vFFRe9oDKAlnLFU; Tue, 01 Jun 2021 17:57:26 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EJjRNBIb1t/JVbuc9ZYLViGQoZmuO/z8cpH4lbWGbvQ=; b=JOidhVBNMgAlBwN/pL8izI0orq
        28RS3VeyVKl5j9UeURZQpF3Pi/zNn8Ahj2qcT8HpEsxOvZcany91xRaW2KxaO/iPeM224rF8VfYiE
        iTwTN9n9PR1uOqi0tMyr8XNYlnSdo8kw2kzxYAtun6ShA32tMQ0Oom7plfPoG0iS/xBXcqiejEAja
        XRVgYBb9w3CxOtsyY99ealNQ+vPZ58qi9kTfFdwQcByIKCfYxsTSJZs49KOopzhJ8BZIk1pEzFTMi
        cwCFYTSgkO1Yk0YGrb9/F34YJ0mZFK6SecrT0W4fxHXu7D6SUIFIDdwL6KiJXZfnLvredKFKpomTN
        kbej1dUg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53078 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1loDK7-000vU5-0n; Tue, 01 Jun 2021 17:57:23 -0500
Subject: Re: [PATCH RESEND][next] drm/nouveau/therm: Fix fall-through warnings
 for Clang
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20210305095807.GA142125@embeddedor>
 <af4363d5-982d-3168-21aa-921c65f35554@embeddedor.com>
Message-ID: <b3daee1b-95da-c9d0-3214-661807d22f50@embeddedor.com>
Date:   Tue, 1 Jun 2021 17:58:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <af4363d5-982d-3168-21aa-921c65f35554@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1loDK7-000vU5-0n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:53078
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 39
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Friendly second ping: who can take this?

I can add this to my -next branch for 5.14 if you don't mind.

JFYI: We had thousands of these sorts of warnings and now we are down
to just 23 in linux-next. This is one of those last remaining warnings.

Thanks
--
Gustavo

On 4/20/21 15:13, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 3/5/21 03:58, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a break statement instead of letting the code fall
>> through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
>> index 2b031d4eaeb6..684aff7437ee 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
>> @@ -41,6 +41,7 @@ pwm_info(struct nvkm_therm *therm, int line)
>>  		default:
>>  			break;
>>  		}
>> +		break;
>>  	default:
>>  		break;
>>  	}
>>
