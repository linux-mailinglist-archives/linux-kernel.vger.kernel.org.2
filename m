Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6FA3D6869
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhGZUYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 16:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233023AbhGZUYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627333506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsAdnl9z18qs+3xP5OpyMQ6xLIDE+aQIuQ62ZMIj5qo=;
        b=drPHbmBcotkaPqnqHPQ4TnWethu7zlOZZsGsIjNGX+P/ZB/JCjQ8CNosUs0jGZIh2xgIMH
        gMONzSd72odexRHzLjPoggkUrr0QfG+4+hI1iqZI1QUf5uY7sLv187U6fMAi2OBy8Q7+hG
        wTjasPd4myewEcGDLOzoDy13UzNek7M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-rReZzCoINbOCFyPpbf5bzg-1; Mon, 26 Jul 2021 17:05:05 -0400
X-MC-Unique: rReZzCoINbOCFyPpbf5bzg-1
Received: by mail-ed1-f70.google.com with SMTP id n24-20020aa7c7980000b02903bb4e1d45aaso3660118eds.15
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsAdnl9z18qs+3xP5OpyMQ6xLIDE+aQIuQ62ZMIj5qo=;
        b=LMeUG8k8aPOyIUB9jFzC5QHXh1DSBawwTs+ZXtRYOjk9ZXmYX5xEsPhl7jF+iEnj8g
         014q5OAy7MY6n+CMC4CIXJlMYbdXaZRjd8vlh6TXB8IZzBq7zKiK98b5AV6sR8F9NrLx
         VjafAmkVn9/AMdpzYUpOCuHJsXVyqknKthklUiEWelX1a3iJFIVvNr91tI+gGGZxThAo
         8LxvF0oWqJr23w3685sPbyxdIUmXbwJvQWDIrvZHQYiSlMhQaTkfBNmFZrxxC/tSfm1o
         ILpN1VfGhWiVCkxEbyflbpaIX8O2oAlfDW1bPBBqgp2imK+ESNcb1P8uXjjsTUGzTlCO
         u8nw==
X-Gm-Message-State: AOAM532CAqXVMGbMVRf94R3Dne8UpmzxuqvCyjL4razBna+dOpzVWpGj
        Sri89HKiJI4nynA4AA6mX1ubC/MWUhmFhlimZAzRYdHujt6by5oKT09RsUKb6+io1UJagcFxUcz
        iQrZeS1qRu4x9IPyX2Q/hQ72v
X-Received: by 2002:a17:906:4097:: with SMTP id u23mr4283063ejj.98.1627333504015;
        Mon, 26 Jul 2021 14:05:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJmpito0eoGb/asuoiq9cKZaDuLXEqU/j/+/G2DXClJMx/169UBBWWLSlR+E4w1QqdfrbbWA==
X-Received: by 2002:a17:906:4097:: with SMTP id u23mr4283049ejj.98.1627333503819;
        Mon, 26 Jul 2021 14:05:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id n13sm389090eda.36.2021.07.26.14.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 14:05:03 -0700 (PDT)
Subject: Re: [PATCH v2 45/46] KVM: SVM: Drop redundant clearing of
 vcpu->arch.hflags at INIT/RESET
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
References: <20210713163324.627647-1-seanjc@google.com>
 <20210713163324.627647-46-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47679db7-5662-100d-c9be-b3df8e2d647e@redhat.com>
Date:   Mon, 26 Jul 2021 23:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713163324.627647-46-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/21 18:33, Sean Christopherson wrote:
> Drop redundant clears of vcpu->arch.hflags in init_vmcb() now that
> init_vmcb() is invoked only through kvm_vcpu_reset(),

Not true if patch 9 is kept, but at this point hflags is zero anyway, so 
the patch is okay.

Paolo

> which always clears
> hflags.  And of course, the second clearing in init_vmcb() was always
> redundant.

