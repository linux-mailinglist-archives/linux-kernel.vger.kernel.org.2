Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC5244DECE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 01:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhKLAG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 19:06:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234146AbhKLAG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 19:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636675446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+aI3vIA8L2jTbmaVH9PAGWa1rUBVm1aF92U3pHIQZow=;
        b=DoLkf3EEuoQm3tEPhwfe86gtwXfafh9U8cmsmlNMUaaJsvTNXCqf/QSsZbGCuCx0PyxJJ8
        BTqrrXxkD4GT7ZkFagJ5KY3ISWoymnuBw1K70XAreSEgeU/F/chmDoY3bHkf5/VirHkXlm
        S8Zbx1TEmXh/pT6F8FKZzPFQBp9gEzw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-pDZD5aHTPeiTwg6bSdQUWA-1; Thu, 11 Nov 2021 19:04:04 -0500
X-MC-Unique: pDZD5aHTPeiTwg6bSdQUWA-1
Received: by mail-qk1-f200.google.com with SMTP id j6-20020a05620a288600b0045e5d85ca17so5232663qkp.16
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 16:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+aI3vIA8L2jTbmaVH9PAGWa1rUBVm1aF92U3pHIQZow=;
        b=Wj1UMNgimB18+6DYjRyzz8uIWU3TbboA2ERS+1tgoQzqPQ3a1nhojsD3lkNeDxDD0w
         dGl/O+XHlxByLN7rtC9x9IT68Be7T8YvsqRIcUURzlWpQ3/pgTlITnu9efBPBJG28/NY
         oYyiaWGE4FHCsktTEO0lFNgQO3isZROLy5ROMBrjuF2erwF9rgQRkwEvlGo5eY4KHMHt
         xZV9EMoG2YzEbXYrREDtx2jpeOybBKCcKlFqOdMSxQCEzAIZmNkPiFl1qCbErGhTpNmP
         RaeBWxBaoXEO7JyEVysAYNomnXcecDV6w5M3Psz61hFXCf3r3N1ekUP0XGz9n6gVn0KN
         SBLA==
X-Gm-Message-State: AOAM532KK3CdfTHs30UxaI40CescRApA50LGDrDHL5WUGkAKw5lYdxPf
        30IZHLDTesIrW0AAdBmtYC8HPmK+ju1DwaQFz2OMMyYDQ2DH6md3Mm6KA1p34yjWKUGbfBk/P8D
        JUdcIVUPwvqgvPnkL+12Emvek
X-Received: by 2002:ac8:5996:: with SMTP id e22mr11956145qte.373.1636675443936;
        Thu, 11 Nov 2021 16:04:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymwzqftQwSVQz3EVwVZALeAzcSvuKspR4FbE1BNS8tjVDd4h2McovAbqJCNwooPT1nnA4EMA==
X-Received: by 2002:ac8:5996:: with SMTP id e22mr11956129qte.373.1636675443741;
        Thu, 11 Nov 2021 16:04:03 -0800 (PST)
Received: from [10.0.0.96] ([24.225.241.171])
        by smtp.gmail.com with ESMTPSA id o2sm2346985qtw.17.2021.11.11.16.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 16:04:03 -0800 (PST)
Message-ID: <0f144d68-37c8-1e4a-1516-a3a572f06f8f@redhat.com>
Date:   Thu, 11 Nov 2021 19:06:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] tipc: check for null after calling kmemdup
Content-Language: en-US
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
References: <20211111205916.37899-1-tadeusz.struk@linaro.org>
From:   Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <20211111205916.37899-1-tadeusz.struk@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/21 15:59, Tadeusz Struk wrote:
> kmemdup can return a null pointer so need to check for it, otherwise
> the null key will be dereferenced later in tipc_crypto_key_xmit as
> can be seen in the trace [1].
>
> Cc: Jon Maloy <jmaloy@redhat.com>
> Cc: Ying Xue <ying.xue@windriver.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: tipc-discussion@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org # 5.15, 5.14, 5.10
>
> [1] https://syzkaller.appspot.com/bug?id=bca180abb29567b189efdbdb34cbf7ba851c2a58
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
> ---
>   net/tipc/crypto.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
> index dc60c32bb70d..988a343f9fd5 100644
> --- a/net/tipc/crypto.c
> +++ b/net/tipc/crypto.c
> @@ -597,6 +597,11 @@ static int tipc_aead_init(struct tipc_aead **aead, struct tipc_aead_key *ukey,
>   	tmp->cloned = NULL;
>   	tmp->authsize = TIPC_AES_GCM_TAG_SIZE;
>   	tmp->key = kmemdup(ukey, tipc_aead_key_size(ukey), GFP_KERNEL);
> +	if (!tmp->key) {
> +		free_percpu(tmp->tfm_entry);
> +		kfree_sensitive(tmp);
> +		return -ENOMEM;
> +	}
>   	memcpy(&tmp->salt, ukey->key + keylen, TIPC_AES_GCM_SALT_SIZE);
>   	atomic_set(&tmp->users, 0);
>   	atomic64_set(&tmp->seqno, 0);
Acked-by: Jon Maloy <jmaloy@redhat.com>

