Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C942801B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhJJI6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 04:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJJI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 04:58:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA41C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 01:56:04 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r19so57360443lfe.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yyXljrCsuaKi/hk32Po1bLMhod0HcJD1tY6TViwOFFc=;
        b=U02fvddADb6kZoDKtg/l0K9TyWLSrhktKmFWsBpbC7UFiWx4tnwivJi0tsISAJZoPX
         m5znKyn2q95tySit8+PvvSqi/TNiBkrHZSKInX9rA+8nYKhijt/XmeuW47wo/D6UTtkl
         b66cjv9kqP7M0IoQjOJjVjfDd/Pl8zuc/0IL3kO2pWyWXww3TWL1OYaZIVQF1C0PMbt9
         Xi/ywXVRrvg2BUJRlUBidgbNncEU+71/nKg95scfE6XAieNbwrfS3HOvjxZiKFv5py7Z
         g1AjT/0CBJ0GBldMXzjdFnlNoAePtCPtvR0IJKu2zYUOM4A8Ja+fdET/F19BPUPD30s2
         fIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yyXljrCsuaKi/hk32Po1bLMhod0HcJD1tY6TViwOFFc=;
        b=FPGj0qaKQk8K102H+IsRXrCEQ/GNN6BLMIYSalAFdCSRPf3C0SIiDGFdbMRLhWMMhZ
         nzU3s344w4uQG96CwHH9qrXM40A1o1vTWobsgbaqbkSfhp4sUocFVjbrgSwjvE4H30I4
         +lCQtDC5j032l6kL2Hf+MaYZZC/J5thiiUeTFlGvs4NyWCqEmlMr5wsEcghFzgRyvitP
         Z7vnI3sqTh0uSqz3zQpqs6fwwX8l8xNQoOj+hgw23SSFVW7vc9EFdTmGrmNoB9nFPM8g
         Dj9tivuH7Lp+J1Vn3zXWwZOstSqRC4M/xw2WNAz2Y+WpFMS10zVpwVygr9lq0rK3V2RF
         91GQ==
X-Gm-Message-State: AOAM530m6GcNBffaS4aa7MaA/aysDKcEWS19rW+ko25MO59CjSzT/ZBh
        +muVp2w1qJ6TM+sb1Yf/PSc=
X-Google-Smtp-Source: ABdhPJxUg2ikz8zUCi3lW83l6lwiMK8xurRZLGqcz6mfdat3YJ2L94NcIbHrrY1FFrO1vgJfYQAGDQ==
X-Received: by 2002:ac2:5c06:: with SMTP id r6mr20862011lfp.103.1633856163029;
        Sun, 10 Oct 2021 01:56:03 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.235.120])
        by smtp.gmail.com with ESMTPSA id d3sm444554lfa.100.2021.10.10.01.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 01:56:02 -0700 (PDT)
Message-ID: <cb878891-f7e0-6a3d-6f81-b1deb4eecdcf@gmail.com>
Date:   Sun, 10 Oct 2021 11:56:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] staging: rtl8723bs: os_dep: simplify the return
 statement.
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YWJ0vSrgsiKK7suE@user>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YWJ0vSrgsiKK7suE@user>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/21 08:06, Saurav Girepunje wrote:
> Remove the unneeded and redundant check of variable on goto out.
> Simplify the return using multiple goto label to avoid
> unneeded check.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

[code snip]

>   	ret = cfg80211_register_netdevice(mon_ndev);
>   	if (ret) {
> -		goto out;
> +		goto err_register;
>   	}
> 
>   	*ndev = pwdev_priv->pmon_ndev = mon_ndev;
>   	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ+1);
> +	goto out;
> 


This looks confusing for readers. This is success path and ret is 
guaranteed to be 0 at this point, so isn't `return 0;` enough here?

Thanks


> +out:
>   	return ret;
>   }
> 



With regards,
Pavel Skripkin
