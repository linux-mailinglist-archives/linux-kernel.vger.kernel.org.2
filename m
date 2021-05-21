Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB3938C9EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbhEUPTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231616AbhEUPTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621610261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoYhqqzDmicG8nqQq3Z4gKK4A7xeq01hKkih7BDgRQQ=;
        b=ft9ZK1OdfWrKyq9meeUi4dHcrWBmWZLdb6pzmKtfmoGz0/LqUhqXKF2HrVTpnHi+iB4g8x
        cV2lLEEGboDew9L9Ip1fMRL7AkhCearjZXb7XkFS9lsJoVRYuuzx05MiKgbWC3nOh/tb8z
        uej/osjKvH3jTf51Sup28hXdtSC3XCU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-ttTFc4qIPzSqvzGVQ3GeSA-1; Fri, 21 May 2021 11:17:39 -0400
X-MC-Unique: ttTFc4qIPzSqvzGVQ3GeSA-1
Received: by mail-qt1-f200.google.com with SMTP id w15-20020ac857cf0000b02901e11cd2e82fso15707947qta.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RoYhqqzDmicG8nqQq3Z4gKK4A7xeq01hKkih7BDgRQQ=;
        b=YKhXbCf6gCTBIq2xaHaPbAmU6h528Uojf6ysBuD/5gpZAzDVT8YwYsnONq+y8k6ytW
         zMkNro9hjLWR3OQr/Zr//LVpkOxp7NjYPjuMKwG2u00khYd+PYF9J4TKZ/8882weS/Iz
         FZsDkiHueETh//4GMvuVipTnKHkxLZ4mZd0MLU/yDUzQo4pPZ0kOFDOlITs9HQZblYlO
         rbgv6ELyHcViPRRz5kxc4Zw6jEgvc/B/na6VkoJwO//GQN/nkhFIUBdbLB176Y/tbim4
         Gk8233O4JNgK2lDehYVwgoUrGq360/REOQkLvx4MnLy900aCv/cxoUVtmb+/pw1TwGRX
         xwTg==
X-Gm-Message-State: AOAM532tapskOL6us3fTxGYazJicInKZDtYfwLxm60JJ2WalDUXTTQng
        1nV9x5keDivKGHSSWLqhwWY0gDNQSLjIza8MlK3jrcj0OBzxAvWhlhTsMhRzxY2UkaaKORISNzr
        1spedcXZtpMRrGlqiqtREplsZ
X-Received: by 2002:ac8:5ad5:: with SMTP id d21mr11877203qtd.167.1621610257590;
        Fri, 21 May 2021 08:17:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEIsyCtsBuBfdyij3/7qNA1kAHeoRXkFlZHhVZ8IT4lYajSTtySLt1mT2P9dgK6jTZwptx/g==
X-Received: by 2002:ac8:5ad5:: with SMTP id d21mr11876953qtd.167.1621610254177;
        Fri, 21 May 2021 08:17:34 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id k125sm5038764qkf.53.2021.05.21.08.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 08:17:33 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] docs: lockdep-design: correct the notation for writer
To:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
        corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
References: <1621578594-13237-1-git-send-email-sxwjean@me.com>
Message-ID: <e0c0302f-e63f-7eba-872b-85e21b0b1622@redhat.com>
Date:   Fri, 21 May 2021 11:17:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1621578594-13237-1-git-send-email-sxwjean@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 2:29 AM, Xiongwei Song wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
>
> The block condition matrix is using 'E' as the writer noation here, so it
> would be better to use 'E' as the reminder rather than 'W'.
>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>   Documentation/locking/lockdep-design.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
> index 9f3cfca..c3b923a 100644
> --- a/Documentation/locking/lockdep-design.rst
> +++ b/Documentation/locking/lockdep-design.rst
> @@ -462,7 +462,7 @@ Block condition matrix, Y means the row blocks the column, and N means otherwise
>   	| R | Y | Y | N |
>   	+---+---+---+---+
>   
> -	(W: writers, r: non-recursive readers, R: recursive readers)
> +	(E: writers, r: non-recursive readers, R: recursive readers)
>   
>   
>   acquired recursively. Unlike non-recursive read locks, recursive read locks

I would say it should be the other way around. Both W and E refer to the 
same type of lockers. W emphasizes writer aspect of it and E for 
exclusive. I think we should change the block condition matrix to use W 
instead of E.

Cheers,
Longman

