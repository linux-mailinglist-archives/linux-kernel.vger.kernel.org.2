Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449DF3670B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbhDUQ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241421AbhDUQ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619024164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHVpGOnvgUdnZaidGHvCao8vNO73Bx6jgVM9T3hkQo4=;
        b=OTjPwCdUp3KbCqZ6jidFEDILy2FLjeRcW5ipzQrdBl+zjtBuwa118KQuWXQQ+UyVWhOpVI
        pXthNaaBsGyJOIMa4XdjXwW2pHjttleRYAaLqYlWKNJEEhX2/Q+6qkt41PtDPD6qBGHEh5
        UZLodE6U6DWcijjdLapmVRB0ssSj2ps=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-owvcPJw4PzuPMDQUSoDOLg-1; Wed, 21 Apr 2021 12:56:02 -0400
X-MC-Unique: owvcPJw4PzuPMDQUSoDOLg-1
Received: by mail-ed1-f71.google.com with SMTP id h13-20020a05640250cdb02903790a9c55acso15336815edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WHVpGOnvgUdnZaidGHvCao8vNO73Bx6jgVM9T3hkQo4=;
        b=MlujyCts3teD1njyOd4EnnNfN+w4JdhnLcn/ijyOD8fxnGVsaTvwBfBuO85WeQ+xNL
         8zsn5EevlNAP2eg5t+nhnOZ9TaxfCScBY2eYZAdavESzz44YKRfgugdAi94v5+doMhBC
         Gd+8efxl7Y7GQhguerX2zFfr8XWFy+/ALI5dusNr8XKw3xcxMzdMUnfavFzN50tt053r
         H9BNzUQNPkJ1HkQ4tzKPKiesIVK5qapBc2kvQTao30MOEdrZFIiUCVZxQDgf31oC4Ofr
         Dsq4e9cDRortzszan51k5C80EJDjiieYBC7OH0TT513YN0eZ3SSkeHhspxnC6zDYxLck
         H02A==
X-Gm-Message-State: AOAM532YUrb42PsLtZlUE+s4cabPImtL449tMz0jx+HEdg8skhpmHVvj
        0VeeWz8iGjzGJwv/k073Q3g01+SBaHDsSSEjdFT7ShmGiX1Lxtne4aE83RWamySan3VN/zpjNj+
        XAPadIE4DWtvZtmii3eUxt7Yk
X-Received: by 2002:a17:907:d04:: with SMTP id gn4mr26911414ejc.152.1619024160711;
        Wed, 21 Apr 2021 09:56:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwirT3k5FbggerOtX8ZxAcTHiz+/y2q6Bqqt1N0daROeqmGEmRRHpjtf53zoOvfQmfVl7E8yw==
X-Received: by 2002:a17:907:d04:: with SMTP id gn4mr26911403ejc.152.1619024160559;
        Wed, 21 Apr 2021 09:56:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z17sm51669ejc.69.2021.04.21.09.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 09:56:00 -0700 (PDT)
Subject: Re: [PATCH 114/190] Revert "staging: rtl8188eu: Fix potential NULL
 pointer dereference of kcalloc"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Mukesh Ojha <mojha@codeaurora.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-115-gregkh@linuxfoundation.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cf31b48e-25b5-bd8a-113e-64dbc96a063b@redhat.com>
Date:   Wed, 21 Apr 2021 18:55:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-115-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/21/21 2:59 PM, Greg Kroah-Hartman wrote:
> This reverts commit 7671ce0d92933762f469266daf43bd34d422d58c.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Mukesh Ojha <mojha@codeaurora.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

FWIW the original commit seems fine here. So if that is an option please
drop this revert from the set.

Regards,

Hans



> ---
>  drivers/staging/rtl8188eu/core/rtw_xmit.c    |  9 ++-------
>  drivers/staging/rtl8188eu/include/rtw_xmit.h |  2 +-
>  drivers/staging/rtl8723bs/core/rtw_xmit.c    | 14 +++++++-------
>  drivers/staging/rtl8723bs/include/rtw_xmit.h |  2 +-
>  4 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> index 317355f830cb..580a3678acc6 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> @@ -174,9 +174,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  
>  	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
>  
> -	res = rtw_alloc_hwxmits(padapter);
> -	if (res == _FAIL)
> -		goto exit;
> +	rtw_alloc_hwxmits(padapter);
>  	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
>  
>  	for (i = 0; i < 4; i++)
> @@ -1505,7 +1503,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
>  	return res;
>  }
>  
> -s32 rtw_alloc_hwxmits(struct adapter *padapter)
> +void rtw_alloc_hwxmits(struct adapter *padapter)
>  {
>  	struct hw_xmit *hwxmits;
>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
> @@ -1514,8 +1512,6 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
>  
>  	pxmitpriv->hwxmits = kcalloc(pxmitpriv->hwxmit_entry,
>  				     sizeof(struct hw_xmit), GFP_KERNEL);
> -	if (!pxmitpriv->hwxmits)
> -		return _FAIL;
>  
>  	hwxmits = pxmitpriv->hwxmits;
>  
> @@ -1523,7 +1519,6 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
>  	hwxmits[1] .sta_queue = &pxmitpriv->vi_pending;
>  	hwxmits[2] .sta_queue = &pxmitpriv->be_pending;
>  	hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
> -	return _SUCCESS;
>  }
>  
>  void rtw_free_hwxmits(struct adapter *padapter)
> diff --git a/drivers/staging/rtl8188eu/include/rtw_xmit.h b/drivers/staging/rtl8188eu/include/rtw_xmit.h
> index 456fd52717f3..59490a447382 100644
> --- a/drivers/staging/rtl8188eu/include/rtw_xmit.h
> +++ b/drivers/staging/rtl8188eu/include/rtw_xmit.h
> @@ -330,7 +330,7 @@ s32 rtw_txframes_sta_ac_pending(struct adapter *padapter,
>  void rtw_init_hwxmits(struct hw_xmit *phwxmit, int entry);
>  s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
>  void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv);
> -s32 rtw_alloc_hwxmits(struct adapter *padapter);
> +void rtw_alloc_hwxmits(struct adapter *padapter);
>  void rtw_free_hwxmits(struct adapter *padapter);
>  s32 rtw_xmit(struct adapter *padapter, struct sk_buff **pkt);
>  
> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> index 41632fa0b3c8..9b1b8add34e1 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> @@ -248,9 +248,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  		}
>  	}
>  
> -	res = rtw_alloc_hwxmits(padapter);
> -	if (res == _FAIL)
> -		goto exit;
> +	rtw_alloc_hwxmits(padapter);
>  	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
>  
>  	for (i = 0; i < 4; i++)
> @@ -1990,7 +1988,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
>  	return res;
>  }
>  
> -s32 rtw_alloc_hwxmits(struct adapter *padapter)
> +void rtw_alloc_hwxmits(struct adapter *padapter)
>  {
>  	struct hw_xmit *hwxmits;
>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
> @@ -2001,8 +1999,10 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
>  
>  	pxmitpriv->hwxmits = rtw_zmalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry);
>  
> -	if (!pxmitpriv->hwxmits)
> -		return _FAIL;
> +	if (pxmitpriv->hwxmits == NULL) {
> +		DBG_871X("alloc hwxmits fail!...\n");
> +		return;
> +	}
>  
>  	hwxmits = pxmitpriv->hwxmits;
>  
> @@ -2027,7 +2027,7 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
>  	} else {
>  	}
>  
> -	return _SUCCESS;
> +
>  }
>  
>  void rtw_free_hwxmits(struct adapter *padapter)
> diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
> index c04318573f8f..9f25ff77aa2c 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
> @@ -483,7 +483,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
>  void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv);
>  
>  
> -s32 rtw_alloc_hwxmits(struct adapter *padapter);
> +void rtw_alloc_hwxmits(struct adapter *padapter);
>  void rtw_free_hwxmits(struct adapter *padapter);
>  
>  
> 

