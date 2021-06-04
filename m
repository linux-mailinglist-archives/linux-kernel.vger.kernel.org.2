Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6EE39B17F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 06:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFDE31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 00:29:27 -0400
Received: from gateway20.websitewelcome.com ([192.185.54.2]:22100 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhFDE30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 00:29:26 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 4F151400C877A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 23:14:23 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id p1QplFuhAnrr4p1Qpl45y3; Thu, 03 Jun 2021 23:27:39 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JdshLO/vH+7uOPFxVZD6KKIRBdDODlb7hcZCspqOfmM=; b=Z6i6UINq1eeiwZp5S2Zl843z6J
        DyhJrkStpYNwMEAtyAHyAfRRJWAqiHGwMIaGrD3EYoXGTfot1MFMwUiQp9CdhZu2TfrdEByQjwqKo
        mv4BSA79267agq+6dOVtuyczYL2xNVvqhdXc2LJs03DKD8viT5oGFqc9T5m7LKVadJJ0vw4IG0WOA
        aa90BEwDJo0PLrLe9xL3Y1rI4ufUv2vQeSDff7ucFujkZTqLCt3Rr6jTJkasqnjUGzJIUAbpbtH1K
        teymwRsAguEgX34otNc0yM3wETm2VtDbgb0KgD2f6x7m8wip4iuXKBz934jAvgsjIrmhciR5zmvgs
        7JxzQuUQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:34472 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lp1Ql-0017cx-ND; Thu, 03 Jun 2021 23:27:36 -0500
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
 <b3daee1b-95da-c9d0-3214-661807d22f50@embeddedor.com>
Message-ID: <1b3cc4c5-f84c-24cb-4b6f-3bdafbaa85bb@embeddedor.com>
Date:   Thu, 3 Jun 2021 23:28:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b3daee1b-95da-c9d0-3214-661807d22f50@embeddedor.com>
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
X-Exim-ID: 1lp1Ql-0017cx-ND
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:34472
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

If you don't mind, I'm taking this in my -next[1] branch for v5.14.

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

On 6/1/21 17:58, Gustavo A. R. Silva wrote:
> Hi,
> 
> Friendly second ping: who can take this?
> 
> I can add this to my -next branch for 5.14 if you don't mind.
> 
> JFYI: We had thousands of these sorts of warnings and now we are down
> to just 23 in linux-next. This is one of those last remaining warnings.
> 
> Thanks
> --
> Gustavo
> 
> On 4/20/21 15:13, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> Friendly ping: who can take this, please?
>>
>> Thanks
>> --
>> Gustavo
>>
>> On 3/5/21 03:58, Gustavo A. R. Silva wrote:
>>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>>> by explicitly adding a break statement instead of letting the code fall
>>> through to the next case.
>>>
>>> Link: https://github.com/KSPP/linux/issues/115
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>  drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
>>> index 2b031d4eaeb6..684aff7437ee 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c
>>> @@ -41,6 +41,7 @@ pwm_info(struct nvkm_therm *therm, int line)
>>>  		default:
>>>  			break;
>>>  		}
>>> +		break;
>>>  	default:
>>>  		break;
>>>  	}
>>>
