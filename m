Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF373E80C2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 19:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhHJRwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 13:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236351AbhHJRtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 13:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628617720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4WETgCfRJxaNKN6Crj5K5of7vonn/3mT6kzvrsWM8k=;
        b=hT6bpKzV0VGQbPS4PSfL/wY26hbAbfSf6tqL3zO1h+F64efY6UcBfXC9b7JvvlMdTWxfCE
        q93w+mbFn5ADJJlDsvPKHI4kTNPN0p62kB0zanxmR6YmU1cEpuiqXIqqXhQDVzfWhG2IIS
        MiJFW69yVyxW/N3dJU/9LmX2HJ+7j0Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-Fp-i4Jp6MEunCAJwkXfJOA-1; Tue, 10 Aug 2021 13:48:39 -0400
X-MC-Unique: Fp-i4Jp6MEunCAJwkXfJOA-1
Received: by mail-ed1-f72.google.com with SMTP id v11-20020a056402348bb02903be68e116adso3220086edc.14
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T4WETgCfRJxaNKN6Crj5K5of7vonn/3mT6kzvrsWM8k=;
        b=uCtjRv9Kj6dsgnpW/TEcT+nj+3WkuQwpZftAya+fIUxm9dqiRR7cOAIk86SpWaecm5
         P2wtW1oT5HRslBgrXnD21qTL3WvquWjeKW/yGQi7Md+nlzZdEpFY7aGiNd/AJ7SSR0b+
         PYE4WAxJpvYXfhT+U+GUEpj4h4v5x9xYKzJWNrXTw2iaE/9QWDkje7qmNDEaLH4IhTn0
         PVHFVGNk5Qw75J5bjIpTKLXqamuUeW0kWAei1K+YkJVolYc0qMyUAJ2eqNorhdkIyrKj
         A7URgkAdYo1ia9B0IVadGXwZYMZwaN3/EkU5nB+z4IvyTOXoLbSioB8USQxOZIKhq7on
         pZZQ==
X-Gm-Message-State: AOAM531WH5i9BkSZK7svZ+ZgogcenO34arYxy82JusaNm7tub+qF/f0Q
        e5MdeMOjW1Ojf5UaIDCMHgJUVY7tlMYUdy4R6K1LfTTjfu66gmH2ZzWXV/Yiihir9xaW/1c262G
        VOiNQM8qWA+JCApsz1GEiMProq73kpngyyJa4qwNdYProzqQgHGEPtFa3+DJOPDUEPiVyrQQZyX
        OY
X-Received: by 2002:a17:907:a06c:: with SMTP id ia12mr5197889ejc.377.1628617718319;
        Tue, 10 Aug 2021 10:48:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrMd+rSdhrmZJMswekFFSLTYDnGlb5onUGeP39SAUo2P8TibmmHx3hYQBbVOaszMWerl6Ozg==
X-Received: by 2002:a17:907:a06c:: with SMTP id ia12mr5197861ejc.377.1628617718077;
        Tue, 10 Aug 2021 10:48:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id x12sm9805718edv.96.2021.08.10.10.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 10:48:37 -0700 (PDT)
Subject: Re: [PATCH 5/5] KVM: x86: Clean up redundant pr_fmt(fmt) macro
 definition for svm
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210809093410.59304-1-likexu@tencent.com>
 <20210809093410.59304-6-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef84c98d-9b33-052b-0747-2d2d327b1dfb@redhat.com>
Date:   Tue, 10 Aug 2021 19:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809093410.59304-6-likexu@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/21 11:34, Like Xu wrote:
> +#undef pr_fmt
> +#define pr_fmt(fmt) "SVM: " fmt
> +
>   #include <linux/kvm_types.h>

Why do you need the #undef?

Paolo

