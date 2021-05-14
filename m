Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D301E3804D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhENIEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233358AbhENIEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620979404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FE60io7r9QIWZ+2HbVfZ7x5W1zNu5ip9FIeLOvLYCnU=;
        b=hKnglwiQ/e1b+A81eWrL0WKkejcnMbR4/NtxDKvNPEeM7S5S8BvV7AjvvomVxc4kSRA9Yy
        MPbrZ+QelYFxAi9CIOv3Cn21UuX7gWw4wMWqpZsqXbw6Zky+MqYSJywU1OtYXT6Q/9MklW
        sAhXOjjNKOIwO6eQRv8i7VqqmCxnskc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-Wr6q-rDfO-24Ia1SWszVCw-1; Fri, 14 May 2021 04:03:22 -0400
X-MC-Unique: Wr6q-rDfO-24Ia1SWszVCw-1
Received: by mail-ej1-f69.google.com with SMTP id cs18-20020a170906dc92b02903a8adf202d6so8298667ejc.23
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FE60io7r9QIWZ+2HbVfZ7x5W1zNu5ip9FIeLOvLYCnU=;
        b=U5W+lSzQrHzbWHS5laEg2ibYga1T4Kp9yyaBo9by137pZAAkKpJ+pwcl34rHyCFO4e
         4IFPhI9KwTPONA/oL9o8svKVW/pqRkOFbC1sTTlNMUsDTUYMYkQ+o8ejvKiA5ZX8jdNf
         dswiBxKbV9b2d7ukh/7BFXsmOjdO93DpRTPqh7/u7OnGQ+YYaAD1TurEPRU92lpbV3Xt
         F/kvImN4cH/NX+/JfQhRs0IpPtkT0QmsXPnSL5TAboMRNTlq71B3Btki0x08invEvwhk
         KPo80iYjZ0scYrfpOdxMTDr3cAh/DDP5X8IWVB85ZmntNLddBKmCFjZkdJ3iD4m7kwXb
         9XHw==
X-Gm-Message-State: AOAM531jvWDzMQHPAkbMKkO5Q5Mj9A6ntamFBQnOihnyb65/b41c1jfN
        UuK/1rqHSOP8Ow2109dHo/DnYLnkFdWOBYFlGYObJlftVcb34j3B+n9aiqbGxl9FHpfab1wtmfV
        6goDDo7fuidx85qWgJRjnydA7
X-Received: by 2002:aa7:c510:: with SMTP id o16mr54472585edq.310.1620979401431;
        Fri, 14 May 2021 01:03:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpDHOVkmNABs2GYteK1qO1NoUOqEFLYflF2NqT3dOmyL4hm384XqS1YbGvZOdh0vIVvk7JBg==
X-Received: by 2002:aa7:c510:: with SMTP id o16mr54472550edq.310.1620979401260;
        Fri, 14 May 2021 01:03:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id w19sm4020166edd.52.2021.05.14.01.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 01:03:20 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] mm: x86: Invoke hypercall when page encryption
 status is changed
To:     Borislav Petkov <bp@alien8.de>, Ashish Kalra <ashish.kalra@amd.com>
Cc:     seanjc@google.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, joro@8bytes.org, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, venu.busireddy@oracle.com,
        brijesh.singh@amd.com
References: <cover.1619193043.git.ashish.kalra@amd.com>
 <ff68a73e0cdaf89e56add5c8b6e110df881fede1.1619193043.git.ashish.kalra@amd.com>
 <YJvU+RAvetAPT2XY@zn.tnic> <20210513043441.GA28019@ashkalra_ubuntu_server>
 <YJ4n2Ypmq/7U1znM@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ac12a36-5886-cb07-cc77-a96daa76b854@redhat.com>
Date:   Fri, 14 May 2021 10:03:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJ4n2Ypmq/7U1znM@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/21 09:33, Borislav Petkov wrote:
> Ok, so explain to me how this looks from the user standpoint: she starts
> migrating the guest, it fails to lookup an address, there's nothing
> saying where it failed but the guest crashed.
> 
> Do you think this is user-friendly?

Ok, so explain to me how this looks from the submitter standpoint: he 
reads your review of his patch, he acknowledges your point with "Yes, it 
makes sense to signal it with a WARN or so", and still is treated as shit.

Do you think this is friendly?

Paolo

