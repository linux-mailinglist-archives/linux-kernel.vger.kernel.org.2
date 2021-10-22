Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF33C437856
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 15:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhJVNus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 09:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232941AbhJVNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 09:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634910505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFmaoASDnexdE5qQmKYftfXRHv4WPfWCY1vwNo1gixg=;
        b=S2+Jci2K3YRdOE52zQUv2gdg9B01Y64feKff76L8891WpeDudHNx245r/azNLT8lvTNq6S
        MJqfehPdzOOTld1ACedQEH3yb9SPTvH5ubveuvHb5FTCbpas2Y3UbZMGGm/hJUaHoWX+De
        J4XaivDfMjqEAX6N9ZzGDVRVjqNFcSg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21--DB3FbjyNTyzVRkscyJWwg-1; Fri, 22 Oct 2021 09:48:23 -0400
X-MC-Unique: -DB3FbjyNTyzVRkscyJWwg-1
Received: by mail-wm1-f69.google.com with SMTP id f63-20020a1c3842000000b0032a621260deso1156138wma.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 06:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AFmaoASDnexdE5qQmKYftfXRHv4WPfWCY1vwNo1gixg=;
        b=Tio7gCXeiDvAGhYxDqqFlVcbQOqxD3t0JbDhWU7IK+vGGggCjYj751uI7hr72uqL+X
         bheGeHX/QGnXruPcjTL+gIz/qt9zYJtxUR3xJN1VGqx0BILehz+N3XDajWTM/a2PFLKM
         nUu24kKUNQRg5VtLSo7c7yPbdpB8PaAFWpUBvpY5fUjQtNmAtCf57XV9bV5hb9v8x6wO
         +6YWQsdHo9qbmQSINlfNq4XxrAI4sKDoWIW8AuyNYy//5N0XmeRu4F3SJBR+8ZcpVwPV
         BC8W/UN1iQ8RK6vBObslbFpom9AVqtUoK9zIWDXuG03RZTS91HPFIjFKqseAx5ZTO9tR
         0yEg==
X-Gm-Message-State: AOAM531Ds++E4SimTYlpHxwepKNtkItj1jLWq8SVBt9FOGplBJdmV5Kh
        5+NbelcCoRPIv7HkRPKQ28VZfus4ce2cfucW11sLGalZs7un05uC7QUS5AHEyMXaedXSkSOxL7m
        ab1HmX0H66dbxOdSEYRiQXYQ1AuXE1Bl/I5biH9RXLwfoHehniGdY7+Sie2iSPIiGNlQdemkwxi
        Nf
X-Received: by 2002:a05:600c:3511:: with SMTP id h17mr28648716wmq.144.1634910502414;
        Fri, 22 Oct 2021 06:48:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcb9UsH4+XyNMhSajPj+HJcLfs6908IOjXwLy/YhyfZQEySIf0pwRdUhBu0EDwAJytLic7lA==
X-Received: by 2002:a05:600c:3511:: with SMTP id h17mr28648682wmq.144.1634910502194;
        Fri, 22 Oct 2021 06:48:22 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:31cb:e591:1e1e:abde:a8f1])
        by smtp.gmail.com with ESMTPSA id v18sm8270951wrm.63.2021.10.22.06.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 06:48:21 -0700 (PDT)
Subject: Re: [PATCH v3 4/8] nSVM: use vmcb_save_area_cached in
 nested_vmcb_valid_sregs()
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20211011143702.1786568-1-eesposit@redhat.com>
 <20211011143702.1786568-5-eesposit@redhat.com>
 <48953634-5b7c-72d6-5fcb-a1b25800f443@redhat.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <f374979b-e2e3-ca6c-9055-a5e9ac107a2d@redhat.com>
Date:   Fri, 22 Oct 2021 15:48:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <48953634-5b7c-72d6-5fcb-a1b25800f443@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/10/2021 09:14, Paolo Bonzini wrote:
> On 11/10/21 16:36, Emanuele Giuseppe Esposito wrote:
>> +
>> +out_free_save:
>> +    memset(&svm->nested.save, 0, sizeof(struct vmcb_save_area_cached));
>> +
> 
> This memset is not strictly necessary, is it?  (Same for out_free_ctl 
> later on).
> 

It was just to keep the struct clean in case of error, but
you are right, it can be removed.

Thank you,
Emanuele

