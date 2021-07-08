Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482693C1809
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhGHR1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhGHR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625765095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gYbu5hFrVhU07xsTrQD/lLzrg/xnBBdhMnFYA3y+lTQ=;
        b=TTBrYo0nbd0P2/erJQccaBbaV4Tiz/J3WnuIrmveLHvXC/v8qPsokmO490mjr5olGJp4FG
        qLt5RaM3j0I/g1pzLdLGspGUmmdWXobPreJRUf1dQmPhZo58ewlJYGjwIK3HAVOThCNNx3
        f53t7kjxGrpdNeQtnf+Yfstf5258i7c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-Uy8_uIDpP5aI5zj3tN_gzA-1; Thu, 08 Jul 2021 13:24:54 -0400
X-MC-Unique: Uy8_uIDpP5aI5zj3tN_gzA-1
Received: by mail-ej1-f70.google.com with SMTP id f1-20020a1709064941b02903f6b5ef17bfso2128834ejt.20
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 10:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gYbu5hFrVhU07xsTrQD/lLzrg/xnBBdhMnFYA3y+lTQ=;
        b=a3wAlBf0y3PJW7J0+Vf7ndMlHlc8T+U+ahKdTRO+TrgYT4bbw/Ds5gNdz2/xgI8eoJ
         Ol9gAv2gYh6Jz5yuyUI6lZV3VJDPaAodZVx/KgY3cqyF7GW4jwPuWwiUJJFZWhpT+VJu
         DaXsFrtZh+5AboFeAlnujjOoGgOQaf2YjdZwdou9mwgbKbiZbzjl5PoIuJkafRePTm2P
         5FDfDUTEiEgvNfAmoMuAQ2sTNyJAj0mrhfgAVUXUs2pp5AqzlhEDsfFO4+xgO0Y1YDO1
         ZlruFKkLyZMwwhHb0A8fN6Oj9wBAnu7fumOCpT4Sq2jzpVyQRJvYdlq7qSvTnBhdHd7M
         9k/A==
X-Gm-Message-State: AOAM5307jsUFmrXijD8lS5NZOQjz097vmfonzDR2S+yjkBk7onww+g7q
        pwZ97S8n5Rv0aT2Fj/0g+9Cvy0GhyM4Jx2qJJVmbdxPOno+5J1jw9cQrCvDM7H1aX6/+YYZi2lJ
        eN5uIMLNtaSAvYEb7U4hzqNnh
X-Received: by 2002:a05:6402:5109:: with SMTP id m9mr39737085edd.297.1625765093482;
        Thu, 08 Jul 2021 10:24:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKnQGediYS6R/H5jXHHVUNLCOWqoVsHk7Z7g4osE6a/73c2rzf34wI2x8WHX1i82VIoOX63g==
X-Received: by 2002:a05:6402:5109:: with SMTP id m9mr39737066edd.297.1625765093339;
        Thu, 08 Jul 2021 10:24:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ee25sm1621735edb.6.2021.07.08.10.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 10:24:52 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: SVM: Fix error handling bugs in SEV migration
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Steve Rutherford <srutherford@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>
References: <20210506175826.2166383-1-seanjc@google.com>
 <20210707134255.GX26672@kadam>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2cc27835-b3e3-3ef5-9f79-c3f3a3bdb32d@redhat.com>
Date:   Thu, 8 Jul 2021 19:24:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707134255.GX26672@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/21 15:42, Dan Carpenter wrote:
> These patches were never applied.
> 
> regards,
> dan carpenter
> 

Queued now, thanks for the reminder!

Paolo

