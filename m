Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE04E44D96D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhKKPu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:50:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232611AbhKKPu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636645658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wp8XtJbOEDdUfrohp3Jxf2oldPhi1HWW8kIQXI5hwuc=;
        b=gspPR02Kc4y0cUCG6+2l7YiMHYCr71zgdaCP0lwKRNF3XIXdMb/vnoQ4iwqnIrf7v7dJqt
        ZoP7a+N75cIi8xHdwvat7a002ABirBgLw+nP/vsxkZ9QT+/jcU1L1d0MSSuO2f4RdAkU1B
        I5ujnDKxfZQPuQnBocj2VNx4O0mw2GA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-Swh1KtHVOnSVmFuAwiKZSQ-1; Thu, 11 Nov 2021 10:47:36 -0500
X-MC-Unique: Swh1KtHVOnSVmFuAwiKZSQ-1
Received: by mail-wm1-f69.google.com with SMTP id g80-20020a1c2053000000b003331a764709so4981153wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 07:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wp8XtJbOEDdUfrohp3Jxf2oldPhi1HWW8kIQXI5hwuc=;
        b=ptmGkLc6xwvc3orIBNouCk1lPfQhPGHjyB4H6vnkZhR/yNpYjI2Kf182NFcEUYrIsW
         9xQSFUOaIeOAvJPiGG6TgmdTmx62YtFOuErqQHFuOTHAoCo/HZ74E6LhG+wZbNIdv8JD
         5UeQF7e4EhcZi1WqriB199l3eVQ7rstDVAfB/fevtLWD0F4hCik8mRjAUv0tKAoeW9fJ
         EJGaNX92H6SIfhWtEgWDDYPyOfyAPs9cehVXR8BIV/8/TI1oTYHkS6QJnHKn+IzpQsGu
         /47xsqrFu9hDiXkhCba5dL2w2LYleJVuFWbSqnHZCP2eK5URgrO1fB5w6PxXnVwm9sTP
         Hq2Q==
X-Gm-Message-State: AOAM532iVRT+Vn/OUo2NgYpKLaHq7pqYgkPQcCtdZOD+clXL7HOgdKI/
        G+BSKCOBkRzRghXL/iElGvL3kP8IKDQqp30693FW9yRfeQ+41NgMiVKF6m5WnK7RbmDdcjpYMKX
        Si27QwDiqbMLLJUlY4rq/zb/m
X-Received: by 2002:a05:6000:18ad:: with SMTP id b13mr9858567wri.195.1636645655724;
        Thu, 11 Nov 2021 07:47:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyZhWjSM4ltDBNus/eMUGzqq3NcZXPgNcM8KwKka0V2X1ENXBqXs6rMfnzEnJZcJz7DdHCjQ==
X-Received: by 2002:a05:6000:18ad:: with SMTP id b13mr9858547wri.195.1636645655523;
        Thu, 11 Nov 2021 07:47:35 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id l11sm3155167wrp.61.2021.11.11.07.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 07:47:34 -0800 (PST)
Message-ID: <b13cdd98-52b7-f70b-5aad-5f8ca6413bc0@redhat.com>
Date:   Thu, 11 Nov 2021 16:47:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] KVM: SEV: Return appropriate error codes if SEV-ES
 scratch setup fails
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211109222350.2266045-1-seanjc@google.com>
 <20211109222350.2266045-2-seanjc@google.com>
 <fc56edb6-5154-4532-242f-4acb8b448330@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <fc56edb6-5154-4532-242f-4acb8b448330@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/21 16:14, Tom Lendacky wrote:
> 
>> Return appropriate error codes if setting up the GHCB scratch area for an
>> SEV-ES guest fails.  In particular, returning -EINVAL instead of -ENOMEM
>> when allocating the kernel buffer could be confusing as userspace would
>> likely suspect a guest issue.
> 
> Based on previous feedback and to implement the changes to the GHCB 
> specification, I'm planning on submitting a patch that will return an 
> error code back to the guest, instead of terminating the guest, if the 
> scratch area fails to be setup properly. So you could hold off on this 
> patch if you want.

I think we still want these two patches in 5.16.

Paolo

