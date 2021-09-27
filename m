Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E2E4190CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 10:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhI0I3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 04:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233418AbhI0I3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 04:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632731245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xd2B5fP8mQFJBNajYxsw0M/C64aAXorv26cE9NMuxUI=;
        b=CF/l7UB/rN5r0p9cm5RMdF3W5SiDUUohAzc4lkqf4H5s3aUA81w75gGxoahaG7Nv+pUy79
        tmVOwSQ1/ZkXiCRYsqhe6A/iX0N61xJpjdrkknmPDazq9VU1TqyxkJKHz0jcZh+uVPtWsL
        f7I0911GtM34duScFI4P8eQhQYaYJeY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-uKQL150BNuqQ0wcENZApPg-1; Mon, 27 Sep 2021 04:27:24 -0400
X-MC-Unique: uKQL150BNuqQ0wcENZApPg-1
Received: by mail-ed1-f70.google.com with SMTP id s18-20020a508d12000000b003da7a7161d5so1404035eds.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 01:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xd2B5fP8mQFJBNajYxsw0M/C64aAXorv26cE9NMuxUI=;
        b=urIFepwfKqlqaeeil83TYy+Vr8bIJ9/hTSMRwj/v89Gh5J3qN/NjBO+wnmWGoHLbmh
         I073YE+ZVlt4wYHyyXSupF4qECv/VsOJtNMclH/CQKObAdEcJpoFoc1lvkm+IW1CyuUi
         TqFpKiRGbNRy5uY64bAad7nklYjUuVLKs5lhLIAU3mubWRfHun77brHZkJxsIkZoJDqV
         a1N1xzTxXnNqWN1q2nwwotsw3cRgOch7Iod+mQLuBjIKtOCwKX3uRIo78zyZ2yv5d64p
         GDWpy9OOE0kDZnv54cptalov9JQhalGUdQgUztxBfvfWHFSNoMgFGBiOHevUAQfxyXBE
         zvOg==
X-Gm-Message-State: AOAM533shrkIRRuwvHyWZrYXB2wgpz4RpphkuX7Yxwm20yAtbcOYj1Zu
        aeScag3OudEJ3eFv7F5jtgUI+6eB/pB/OPRf8E91TyhPfZq+k4Y1b5h19XFvmTT5hF5Tf6zvi2w
        nAvjOAjER09dEQVTRpnlNqOBab7Yf2CfXmFYbX46f5sMvO6rd8kDgOOlM5Sr8AsvYyFxl+zcShL
        Pp
X-Received: by 2002:a05:6402:21ef:: with SMTP id ce15mr21341515edb.19.1632731242865;
        Mon, 27 Sep 2021 01:27:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnaUDH9Y9p6JlmlVpo4at+7c8OOuBUxcgBd+LF71OeobsFVs6GkDkwTlUHXfTat8CiCOUYcQ==
X-Received: by 2002:a05:6402:21ef:: with SMTP id ce15mr21341496edb.19.1632731242641;
        Mon, 27 Sep 2021 01:27:22 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id w5sm8445816ejz.25.2021.09.27.01.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 01:27:22 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: remove meaningless pstat->passoc_req
 check in OnAssocReq()
To:     Longji Guo <guolongji@uniontech.com>, gregkh@linuxfoundation.org,
        fabioaiuto83@gmail.com
Cc:     ross.schm.dev@gmail.com, marcocesati@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210927033056.27503-1-guolongji@uniontech.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <13ccfad4-ed3c-5cff-653f-1c78ca0af883@redhat.com>
Date:   Mon, 27 Sep 2021 10:27:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210927033056.27503-1-guolongji@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/27/21 5:30 AM, Longji Guo wrote:
> kfree(NULL) is safe and the check 'if (pstat->passoc_req)' before kfree
> is not necessary.
> 
> Signed-off-by: Longji Guo <guolongji@uniontech.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 375d2a742dd2..a46ab97524aa 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -1344,11 +1344,9 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
>  			issue_asocrsp(padapter, status, pstat, WIFI_REASSOCRSP);
>  
>  		spin_lock_bh(&pstat->lock);
> -		if (pstat->passoc_req) {
> -			kfree(pstat->passoc_req);
> -			pstat->passoc_req = NULL;
> -			pstat->assoc_req_len = 0;
> -		}
> +		kfree(pstat->passoc_req);
> +		pstat->passoc_req = NULL;

This "pstat->passoc_req = NULL;" is not necessary, since directly afterwards
pstat->passoc_req gets overwritten with the return value from rtw_zmalloc()
so please drop this line too.

Regards,

Hans



> +		pstat->assoc_req_len = 0;
>  
>  		pstat->passoc_req =  rtw_zmalloc(pkt_len);
>  		if (pstat->passoc_req) {
> 

