Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366CB397CF3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 01:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhFAXUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 19:20:31 -0400
Received: from gateway20.websitewelcome.com ([192.185.54.2]:20832 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235034AbhFAXUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 19:20:30 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 975CB400C6FCF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 17:42:40 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id oDIclK3qXx8DpoDIcl42Ng; Tue, 01 Jun 2021 17:55:50 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HZ/MTcaMdemBlTWSin6KFaYC79fzi9Rdgyc+g76CuqM=; b=foLOTTxYICaO7v8eLQaTaEahFo
        zqebbpvFrS2kAgzqy9S3OFlG/fnrpbjNnsO0RksEYJwbSQXsWadiaXj1ycYeRgPOQ2C05nluoLE9h
        AbCD83ALZ1/cnY7emezcWoHuhq0b3ZCvKlzlkTT913+nuiILPwA6EqwDtsASJtZcYWudAlLmRpIgF
        LfDwItC8QsHvHV/QVsXXo09bcRgBH/Nh7asrYJuNQJIEmYkCoR2dDDOwC6K3DTNHUgJMmJPbItOyv
        zRuOB4fM44016mDSn1VXhxQA/CMwBCmjBzhTrPloJFolwyCQJ5+tXNYQiAiGTBdSDiwYRUxcLn58T
        xHrrEwgA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53062 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1loDIY-000tqs-Pv; Tue, 01 Jun 2021 17:55:46 -0500
Subject: Re: [PATCH RESEND][next] drm/nouveau: Fix fall-through warnings for
 Clang
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20210305095657.GA142006@embeddedor>
 <79ff569a-5828-ef21-538b-12d07d34a4ff@embeddedor.com>
Message-ID: <1ec627af-514e-b24a-da88-13eb561ccb15@embeddedor.com>
Date:   Tue, 1 Jun 2021 17:56:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <79ff569a-5828-ef21-538b-12d07d34a4ff@embeddedor.com>
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
X-Exim-ID: 1loDIY-000tqs-Pv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:53062
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
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
> On 3/5/21 03:56, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
>> of warnings by explicitly adding a couple of break statements instead
>> of letting the code fall through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/gpu/drm/nouveau/nouveau_bo.c        | 1 +
>>  drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
>> index 2375711877cf..62903c3b368d 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
>> @@ -443,6 +443,7 @@ nouveau_bo_pin(struct nouveau_bo *nvbo, uint32_t domain, bool contig)
>>  			break;
>>  		case TTM_PL_TT:
>>  			error |= !(domain & NOUVEAU_GEM_DOMAIN_GART);
>> +			break;
>>  		default:
>>  			break;
>>  		}
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
>> index 61e6d7412505..eb844cdcaec2 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
>> @@ -157,6 +157,7 @@ nouveau_conn_atomic_set_property(struct drm_connector *connector,
>>  			default:
>>  				break;
>>  			}
>> +			break;
>>  		case DRM_MODE_SCALE_FULLSCREEN:
>>  		case DRM_MODE_SCALE_CENTER:
>>  		case DRM_MODE_SCALE_ASPECT:
>>
