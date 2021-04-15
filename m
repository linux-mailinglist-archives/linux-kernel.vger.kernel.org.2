Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A33360FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhDOQIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:08:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233595AbhDOQIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618502902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPWTOZkuVV9uKxyAib9OOYGzA4pl+7XPQzG6f3iPsNE=;
        b=VlAlpaK+xy2VtCmAopdRM3jQo+uBZWOk1mRzs0pG0LA4gjx5HVQLtM/GDbasdn+z5/uG1v
        N0Jepxhj3GvM0rOrUVMeu7vJfFh1gme9epsE7AoFML6vZoFz2c+ihrknPfw+teA4Gv9+kP
        EAJWynSGa4K4u0D23HeDJTURjj5uJc4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-7WzpsfMWOpmduL2EChPGww-1; Thu, 15 Apr 2021 12:08:20 -0400
X-MC-Unique: 7WzpsfMWOpmduL2EChPGww-1
Received: by mail-ed1-f69.google.com with SMTP id z3-20020a05640240c3b029037fb0c2bd3bso5492383edb.23
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GPWTOZkuVV9uKxyAib9OOYGzA4pl+7XPQzG6f3iPsNE=;
        b=WNHNh41sURVMeAYoEnolM6hxInikjNXkxrlD5y9gxku5jRhWKumzc8njhzv11T0b0f
         juvQXPWjSDI8z5d+fdI0NY1bvho47OWWdMv1/Hm20UWN//DFYNBoz0C4TtXcHHNOm1mv
         YfhN96mKAzoBd4e110u1twa7DQXjk9DddwMWeQnXZCGe+1l/WA2Zoh5JpIYn54W2WxMp
         rfe2lHRNonckAhDjtISaWEyGZOeh0JPcu6MEWmNdTv60YkXzK4a4r27QZjWyIgcXi0LF
         wnLmVG46Kxy/p0HYf92WMunNPlrzXIs4wiMud7qBVJHwtp3mPSh3/Ubq6tKFJd3B95k0
         hBYw==
X-Gm-Message-State: AOAM531xDqSOIll5oxTcnv9C2Xp1Q9RA9uEWIo+ratwAYFCZS0s9bG7A
        ZlAj/0VVkxQIkp5d56oym81hp25qkCQXnBxJkuY+auypNmlmsxWRj6APX9vEqdy2JFk/g06xMBx
        JOIu3cY0QKVyfB/MbJ0uJI4gpGm77TUO+pWr5AI4Hb7OqoOV4ZVNIY3mHk4shOem5LVEV1Y0cWs
        wK
X-Received: by 2002:a17:906:7f01:: with SMTP id d1mr4338515ejr.136.1618502898624;
        Thu, 15 Apr 2021 09:08:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7WrvK1l6FVJlJKF6M6McOJ8gnW3B/2pPeOqGw+FE6kSlfaUMAJeNxJh1gTw4wVr2vncSDmA==
X-Received: by 2002:a17:906:7f01:: with SMTP id d1mr4338497ejr.136.1618502898384;
        Thu, 15 Apr 2021 09:08:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id la24sm2393268ejb.71.2021.04.15.09.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 09:08:17 -0700 (PDT)
Subject: Re: [PATCH v3 5/8] docs: vcpu-requests.rst: fix reference for atomic
 ops
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1617972339.git.mchehab+huawei@kernel.org>
 <fc194806772325d60b7406368ba726f07990b968.1617972339.git.mchehab+huawei@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e72a06e6-d027-74f6-14da-31666187b893@redhat.com>
Date:   Thu, 15 Apr 2021 18:08:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <fc194806772325d60b7406368ba726f07990b968.1617972339.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/21 14:47, Mauro Carvalho Chehab wrote:
> Changeset f0400a77ebdc ("atomic: Delete obsolete documentation")
> got rid of atomic_ops.rst, pointing that this was superseded by
> Documentation/atomic_*.txt.
> 
> Update its reference accordingly.
> 
> Fixes: f0400a77ebdc ("atomic: Delete obsolete documentation")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   Documentation/virt/kvm/vcpu-requests.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/vcpu-requests.rst b/Documentation/virt/kvm/vcpu-requests.rst
> index 5feb3706a7ae..5f8798e7fdf8 100644
> --- a/Documentation/virt/kvm/vcpu-requests.rst
> +++ b/Documentation/virt/kvm/vcpu-requests.rst
> @@ -302,6 +302,6 @@ VCPU returns from the call.
>   References
>   ==========
>   
> -.. [atomic-ops] Documentation/core-api/atomic_ops.rst
> +.. [atomic-ops] Documentation/atomic_bitops.txt and Documentation/atomic_t.txt
>   .. [memory-barriers] Documentation/memory-barriers.txt
>   .. [lwn-mb] https://lwn.net/Articles/573436/
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

