Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC6E4193A1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbhI0Lw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234053AbhI0Lw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632743480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAAFmmttYKv0+kVUPuJp9q/QqV+8DAP59uUvJMpuDGU=;
        b=cG8LhKF7RyEWG1sNb7CxJQiPNYbt4XGHRjxYtfOnlrkAg1IKguDCXB7LUDKNnDFn/UY2oi
        v86V1aph9zfpIuo1HzZJc86rohH+Ib4gBYn7Uoe4bXzp0fFOWOn2HXgwroHhckTzTI0WY3
        hgq1Ko+drg8tveBGThUfLQyKoCjyNjw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-vuZY_RTANEqMPRKOZD-tiw-1; Mon, 27 Sep 2021 07:51:19 -0400
X-MC-Unique: vuZY_RTANEqMPRKOZD-tiw-1
Received: by mail-ed1-f72.google.com with SMTP id 1-20020a508741000000b003da559ba1eeso7380355edv.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 04:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FAAFmmttYKv0+kVUPuJp9q/QqV+8DAP59uUvJMpuDGU=;
        b=xVPXts2J5a/s+Wep/qFb1Ep0xHA9drcjHCFAGGg0Ps+1T5SHUg+624vgO5bp5/ky1l
         XnHheAU+nsva8m+xAxcusQLeEFplzrNPZ7g7vYQhzPnz5Qcg5OuW3MRhNEqO2uapfQsw
         wCm2+cKMCc0kHfCk8Dr5Vy/X5w/xLDBgZNLqa+1WVtnqLURE5/DBoAJGMpE7N+BqZZS2
         aWZVaOJWuZFEMhhYu4hJTtknr0dMVKt8ox7eViwjT8v4wKhYklByVCyGEy6MicEymh6f
         5MWpFEGbL7wuy6AcPdh3ibAwVsmUkcixqsdqLL9ypaMd8iiafe/2kFrnyY06gKrzSuri
         YhMQ==
X-Gm-Message-State: AOAM533bJU37hqGLoi2nT/sZfqWUVsarIAsK1nDymW7QhGsKpcvhMbNb
        N55+wnra/I1R9GBKBu3wn7LGknzLNjdAeRdzNl3b7iFO6+oUR+4WqC2Hj3A+JOzm45QlQigboOB
        iz5ghSoRMRal+OFkXOGLBXHSukJcTd/TFfCe/dP8IIQEl10hv9YDFatW69IaqVa3c+BpNpA6MoK
        yR
X-Received: by 2002:a17:906:dc47:: with SMTP id yz7mr10119361ejb.487.1632743477901;
        Mon, 27 Sep 2021 04:51:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxbqNV2eYafPP8c75+i5zT8dgetv4aibQSC7rfpRdyczZ3eD1Vw707E1bBkk+SBQP3B3lSxQ==
X-Received: by 2002:a17:906:dc47:: with SMTP id yz7mr10119333ejb.487.1632743477599;
        Mon, 27 Sep 2021 04:51:17 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g9sm8751645ejo.60.2021.09.27.04.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 04:51:17 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: remove meaningless pstat->passoc_req
 check in OnAssocReq()
To:     Longji Guo <guolongji@uniontech.com>, gregkh@linuxfoundation.org,
        fabioaiuto83@gmail.com
Cc:     ross.schm.dev@gmail.com, marcocesati@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210927114925.15940-1-guolongji@uniontech.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6bec8a71-2233-9549-ab5e-1b1f62e2f488@redhat.com>
Date:   Mon, 27 Sep 2021 13:51:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210927114925.15940-1-guolongji@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/27/21 1:49 PM, Longji Guo wrote:
> kfree(NULL) is safe and the check 'if (pstat->passoc_req)' before kfree
> is not necessary.
> 
> Signed-off-by: Longji Guo <guolongji@uniontech.com>
Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Next time please mark a new (v2) version as such please by changing
the [PATCH] in the subject to [PATCH v2].

You can do this, by for example doing:

git format-patch -v2 HEAD~
git send-email v2-0001-.....patch

Regards,

Hans



> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 375d2a742dd2..51390a30fa55 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -1344,12 +1344,8 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
>  			issue_asocrsp(padapter, status, pstat, WIFI_REASSOCRSP);
>  
>  		spin_lock_bh(&pstat->lock);
> -		if (pstat->passoc_req) {
> -			kfree(pstat->passoc_req);
> -			pstat->passoc_req = NULL;
> -			pstat->assoc_req_len = 0;
> -		}
> -
> +		kfree(pstat->passoc_req);
> +		pstat->assoc_req_len = 0;
>  		pstat->passoc_req =  rtw_zmalloc(pkt_len);
>  		if (pstat->passoc_req) {
>  			memcpy(pstat->passoc_req, pframe, pkt_len);
> 

