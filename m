Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB993F3622
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhHTVpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHTVp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:45:29 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB507C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:44:51 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so17272941oti.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sdBtLLcxFh85B7imhpoS1jrj2mYz3GQrzK1SA3JSPBc=;
        b=Ymx1V8TzLYDcDqYJ/At9cSPdQ3bHct1g2Kr6Mtw5NjPyKpRn0fzpgwcpfZwC5DWfOI
         sCBlsjJ9h4mBw5HogM+Iea8kk5/h4yA20FI9rYmLMGm1a0BozIuav8hXt8Uq3pLVjpvB
         PPlG35gEeN1Jm1cVZvzqZiNzh7DWrPkeUHdAj8M3/dBl7xArr2zHXZuB9QHf15F2NznY
         +HrLp0nPzILP5lrEXnysznE2egUIC4Iay0ALS4u7/uZZ6qZHsL1sYdRT2PGej2CxF1f7
         r0aCX6rbwEb2ISBDLlEAxXW2PuGMpNpYzZ8xpMnRi+7UiYH9lmapoXDq8iUbQW3+ljuL
         zGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sdBtLLcxFh85B7imhpoS1jrj2mYz3GQrzK1SA3JSPBc=;
        b=HChTXR6CwWM+5ToSpd7rtVShV0hkN8uNGybzaSBNPHiYEDpX9LU1MLHMS6CvEgFlPb
         arfPd9yUhkarUdY2rU7DsYpoDDwTkrd1cPcXV/BGV+8lh03u0ddh9QE1RnSKdzwIM9Ix
         h4LfC0cyNwv9Ss+Qgr2kBeaq88kO9S4P2EUeviddpPG303li8hDO1xDoWICvzHxOLmaI
         olmNO23s5+u8L1PchziUqFNMcIw46g4XtamfYrR5mDISoOaGs7nW5HWoeT7wK9ehZ7Ng
         UVuRwfOss8gn8mkFw7tEgIX5QAz3ykuzGTwovxDTuSDxRcg9TrLwJ4p7sXFe2gCdb9dS
         XpMg==
X-Gm-Message-State: AOAM533N6gQB5LYNB3Cd8n6BVsUEFfXYEXJlhECvKJKJD7qYffpLnpy4
        zjw+8VV/rqOPpSFlLq0diW7dGKSEkH0=
X-Google-Smtp-Source: ABdhPJyxBZwR57KcXB+D7nrMaUKCONnXfpHfleecCDZgR0sJRFcpOrptgS51YnUefxVerk3Ekc6XgA==
X-Received: by 2002:a05:6808:90a:: with SMTP id w10mr4625994oih.164.1629495890817;
        Fri, 20 Aug 2021 14:44:50 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com. [2603:8090:2005:39b3::1023])
        by smtp.gmail.com with ESMTPSA id m6sm1708799otf.52.2021.08.20.14.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 14:44:50 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH v2 2/5] staging: r8188eu: cast to restricted __be32
To:     Aakash Hemadri <aakashhemadri123@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
 <602aefc30b0d979dc6e402d52da2f096ea5c67cf.1629360917.git.aakashhemadri123@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <4be5c5fa-c3fd-8c86-e904-8e2e60173380@lwfinger.net>
Date:   Fri, 20 Aug 2021 16:44:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <602aefc30b0d979dc6e402d52da2f096ea5c67cf.1629360917.git.aakashhemadri123@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/21 3:17 AM, Aakash Hemadri wrote:
> Fix sparse warning:
>> rtw_br_ext.c:836:54: warning: cast to restricted __be32
> 
> Unnecessary double cast, remove them.
> 
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index 404fa8904e47..6a0462ce6230 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -671,7 +671,7 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
>   				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
>   					struct dhcpMessage *dhcph =
>   						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
> -					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);
> +					u32 cookie = dhcph->cookie;
>   
>   					if (cookie == DHCP_MAGIC) { /*  match magic word */
>   						if (!(dhcph->flags & htons(BROADCAST_FLAG))) {
> 

This patch is wrong. All the documentation I could find tells me that the 
multi-byte entries in dhcph are big-endian, thus the new line should read:

					u32 cookie = be32_to_cpu(dhcph->cookie);
combined with:

@@ -649,7 +650,7 @@ struct dhcpMessage {
         u_int8_t chaddr[16];
         u_int8_t sname[64];
         u_int8_t file[128];
-       u_int32_t cookie;
+       __be32 cookie;
         u_int8_t options[308]; /* 312 - cookie */
  };

The old code was, in fact, correct, but not in a way that satisfied Sparse.

Larry

