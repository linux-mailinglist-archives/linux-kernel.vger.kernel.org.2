Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B93C3D9B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhGKPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 11:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235453AbhGKPZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 11:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626016971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTnUpGQrEV+LSYMbonQQeBGOolBQlW/k+1JZ7zxRtwc=;
        b=NyIzS1euL60l2QsR8Na5PinMEy4wOvjY4avmZNFOV/SkXZxNkT2lX7gCzGGak/naUU9mP5
        mu3lFTdPH8a7a9bm85DYU+d7SYVMaP5kQqMV/w1t9w869Lyjaodkl3Jo0hK4yMkjz+DfzT
        vrEc+tvnK8IzVgLtjy+n6XJeHLTdbZA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-AfXzvMpmN7iMJPW3JfcHHQ-1; Sun, 11 Jul 2021 11:22:50 -0400
X-MC-Unique: AfXzvMpmN7iMJPW3JfcHHQ-1
Received: by mail-qv1-f69.google.com with SMTP id k12-20020a0cfd6c0000b029020df9543019so11771690qvs.14
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 08:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VTnUpGQrEV+LSYMbonQQeBGOolBQlW/k+1JZ7zxRtwc=;
        b=oQhD8ElYmQmVDol9+LqSXNPl2YMd+QdaidEgQhE6nUJ9HCtL12YCO2eEjXo2tb7vaW
         GNcRX9eBVvvzxvMklNA1f206qpYeXGhckaUQ2uJR9I+v7mKzjWeMn7R0eNWIAk3+zk1u
         hIgtpH/rDehQorBFjCyH/6Hf3x+9hGlV5aVReP/Y9U6+XuHoFPsytONplvtnaQ+3xtlf
         6t9G9wBNz9MU+EtfntSvbkovSDVC2kcg1Ijg/wE8UZloeYbhSRzfPhi9NbUm4SYnv9NI
         vChy1Cvi09NBhY0TkJxzKBH8pw+QLGSYp0FScEcaU6A6nlC1NHeJJDMfBC85JrdYsnru
         7E9g==
X-Gm-Message-State: AOAM530BW33Crj5Nl8zPxZTlPqCrZwOPKyTk4YvnvYqRc4ME6k+89gcS
        o0gIofLMkVr0ygxLGZPDAfS47GBTAZZEHMPmQYKIJctEqpLD/LFS+9oHqCR0G0bLTCzdn98RWry
        g2bKtbuMfrQ2c9iXMD3LiQDdJ
X-Received: by 2002:a37:b0a:: with SMTP id 10mr1347228qkl.291.1626016969650;
        Sun, 11 Jul 2021 08:22:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNLdwFZM7zPxEdkWxzuSN3LFaXjkzAGfA1VfJCMjMZ/geXXJIWsoquAERpxBvyIEk6lhhTDQ==
X-Received: by 2002:a37:b0a:: with SMTP id 10mr1347214qkl.291.1626016969501;
        Sun, 11 Jul 2021 08:22:49 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id l6sm5345585qkk.117.2021.07.11.08.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 08:22:49 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v1 3/3] locking/lockdep,doc: Correct the max number of
 lock classes
To:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20210711141430.896595-1-sxwjean@me.com>
 <20210711141430.896595-3-sxwjean@me.com>
Message-ID: <93ccb871-7f57-9109-9072-8fc26f3b811c@redhat.com>
Date:   Sun, 11 Jul 2021 11:22:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210711141430.896595-3-sxwjean@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/21 10:14 AM, Xiongwei Song wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
>
> The max number of lock classes is 8192.
>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>   Documentation/locking/lockdep-design.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
> index 82f36cab61bd..5c2dcec684ff 100644
> --- a/Documentation/locking/lockdep-design.rst
> +++ b/Documentation/locking/lockdep-design.rst
> @@ -341,7 +341,7 @@ Exceeding this number will trigger the following lockdep warning::
>   
>   	(DEBUG_LOCKS_WARN_ON(id >= MAX_LOCKDEP_KEYS))
>   
> -By default, MAX_LOCKDEP_KEYS is currently set to 8191, and typical
> +By default, MAX_LOCKDEP_KEYS is currently set to 8192, and typical
>   desktop systems have less than 1,000 lock classes, so this warning
>   normally results from lock-class leakage or failure to properly
>   initialize locks.  These two problems are illustrated below:
> @@ -383,7 +383,7 @@ you the number of lock classes currently in use along with the maximum::
>   
>   This command produces the following output on a modest system::
>   
> -	lock-classes:                          748 [max: 8191]
> +	lock-classes:                          748 [max: 8192]
>   
>   If the number allocated (748 above) increases continually over time,
>   then there is likely a leak.  The following command can be used to

Acked-by: Waiman Long <longman@redhat.com>

