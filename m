Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E0E45F2B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349902AbhKZRP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:15:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240330AbhKZRN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637946643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2oAsaBCZqzzu8lg0d4rHOgTkD3t28sGm93eznlHHRPI=;
        b=e7IPqsYYZ7iH/TT5T9SAqXyD0QMcbRkVUAdA3MB0ZkX999Iqw69vrNwzOzjjVFjvr4o5kS
        MbLjmlsJ1dZptfXTuCmFtsbNCQGYjGGVZNW234znfsiJPo+a98D4gpF6jptK/ucczwAkRI
        OFt0jy3IhNd120UcCatpvJQWHqFfl2g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-559-vKK9ZQ_lOW2jdSwwFH10Ag-1; Fri, 26 Nov 2021 12:10:41 -0500
X-MC-Unique: vKK9ZQ_lOW2jdSwwFH10Ag-1
Received: by mail-wr1-f70.google.com with SMTP id q17-20020adff791000000b00183e734ba48so1786735wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=2oAsaBCZqzzu8lg0d4rHOgTkD3t28sGm93eznlHHRPI=;
        b=MUMihHlxdUFjbfDiVAYjBbjC8YU7gwbQel6+glMIfZ4XH907fqsb9qAx9svb4BsXXO
         zVy8N7n1BqnKbgkIp5wTUDx+dqWEumFcjkD4bkZwHRQ581HHWqY2FxjRauR0ijpPIN7D
         FzG081jyrQWF2A2a0x2ChtHP2XRhhayah2VSJZjtVKKmDd69+lpVoTVVr5cWNA3XB1pQ
         9nCenmihf0hqGTGDIV5stXMcQgJ8gc3YncKpHSOMagQAwcz52riMglUZCXtV/uUXzPNN
         +HDJZtBcnF8NewDiBiFLRmjwRP9O3A1STIbqjkYax+3afZTtLS8pXAjaKfkbt4Vwi9wg
         QF6w==
X-Gm-Message-State: AOAM533o/mD/kj8GXHyw7jBQb13BbpuyEMUe79Skt2yyQHf2o0q3teWR
        k+4Ilv8bdd84Nwi1HkIuPJt2b2bzUeBrvEjJfRtiKG11q3dFon5HAvq9U4LJoaZyBEayja19bAN
        f11IUklh2XNcR0DsvlwbUfuDY
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr14647312wrn.349.1637946640054;
        Fri, 26 Nov 2021 09:10:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzK4lbduIqJTvg1e0XLUeXX1W9HH6Y9/Kp+hpm07N7j62khyd/8jP9NyIkPWSYXkfOcaI8z8w==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr14647286wrn.349.1637946639887;
        Fri, 26 Nov 2021 09:10:39 -0800 (PST)
Received: from [192.168.3.132] (p5b0c69e1.dip0.t-ipconnect.de. [91.12.105.225])
        by smtp.gmail.com with ESMTPSA id o1sm6042808wrn.63.2021.11.26.09.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 09:10:39 -0800 (PST)
Message-ID: <78b0d664-a029-b239-c7ab-cb5ce0b2d269@redhat.com>
Date:   Fri, 26 Nov 2021 18:10:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 1/3] KVM: s390: gaccess: Refactor gpa and length
 calculation
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211126164549.7046-1-scgl@linux.ibm.com>
 <20211126164549.7046-2-scgl@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211126164549.7046-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.11.21 17:45, Janis Schoetterl-Glausch wrote:
> Improve readability by renaming the length variable and
> not calculating the offset manually.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/gaccess.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

