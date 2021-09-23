Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC185415850
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239403AbhIWGjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239330AbhIWGjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632379048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r3N1Pk90niGm/fYHoe53S2YI5UtAjlPE7QGhiZeYU94=;
        b=DHiTGzdRkln+CBNBuFR5p/GhDuIw0ofYM9M6EAO7Zin1lpizLC6Em06sXPqj1HSCd44ZxE
        JaiwOer9Zq/2SARDb3uhS/NyvOzOdyDHt3vMUanA3ExFrWT1IFW/8RWtGki/ov4LdSZSu+
        2zXn8vhIjt+Jnr8pGiVyYiwTv69s38U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-oF1itKmBOrGbqCIhlp7-2g-1; Thu, 23 Sep 2021 02:37:27 -0400
X-MC-Unique: oF1itKmBOrGbqCIhlp7-2g-1
Received: by mail-ed1-f70.google.com with SMTP id c7-20020a05640227c700b003d27f41f1d4so5742935ede.16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r3N1Pk90niGm/fYHoe53S2YI5UtAjlPE7QGhiZeYU94=;
        b=UYrVTbpDbqxtohSuNU4C/BGuPGBFH5IJ3461/2wwL5k6Gu1/aqoX3ABW/ejjFghNW4
         QeIhWHuRV1dHjUltXKzKPjnrf0xkPVH28pAUCNpNSK25tmNYgg/N3hW721xQ0OL0tdOI
         G4V7hSQTcUcbXipUoroUreAM9opErLTv2vYucPByZf9X8doz/XfGUQX+SRWFsn18al2C
         aO57QCgRxoIsJNDTVHDmSsX1IpxVlVzB/nFbLddnqa63EX2K30pMRI2eziX7ppypQoT/
         8CHVxm2eFEIHuDJnkLs+aoxQwbsEQg1L+fd4sFDmMbrn/xr2b76efIGP9EQT425OtzL0
         pTGQ==
X-Gm-Message-State: AOAM5324zQWPOzcnGr8Vb3UtLhx83S0Z8AkYY/9C0eydchSds5/c5Lua
        Amd57IkWFgeZb6IHOoxoupXBdTCV2sS/Zj3Y5YeDLtrDQKVkiQfOVVv//YREXwIozF+scamdynq
        kMnEhgKs7t+X+EZ+B4QC8JF1+
X-Received: by 2002:a17:906:144b:: with SMTP id q11mr3489659ejc.78.1632379045846;
        Wed, 22 Sep 2021 23:37:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8+tt6EgDc6snF2gl3BYAQrxR5dQeSrRfvqz2EVy/8Rxah+ezCSf6VfGuZJo/6DI0wkSBBOg==
X-Received: by 2002:a17:906:144b:: with SMTP id q11mr3489648ejc.78.1632379045682;
        Wed, 22 Sep 2021 23:37:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w25sm2722302edi.22.2021.09.22.23.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 23:37:24 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Check if bus lock vmexit was preempted
To:     Hao Xiang <hao.xiang@linux.alibaba.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenyi.qiang@intel.com,
        shannon.zhao@linux.alibaba.com,
        Sean Christopherson <seanjc@google.com>
References: <1631964600-73707-1-git-send-email-hao.xiang@linux.alibaba.com>
 <87b411c3-da75-e074-91a4-a73891f9f5f8@redhat.com>
 <57597778-836c-7bac-7f1d-bcdae0cd6ac4@intel.com>
 <a0d6bcd8-11e4-4efd-0317-0bec6e59f06a@redhat.com>
 <84cd2713-3cc4-3120-946e-0cf8b8a8187d@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b8714ed-c3ae-01ee-d2fd-fe7542d01596@redhat.com>
Date:   Thu, 23 Sep 2021 08:37:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <84cd2713-3cc4-3120-946e-0cf8b8a8187d@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/21 02:59, Hao Xiang wrote:
> EXIT_REASON.bus_lock_detected may or may not be set when 
> exit_reason=EXIT_REASON_BUS_LOCK,  It clould depend on hardware 
> implementaion. No matter when intel states it clearly, I think it is 
> better that we avoid repeated assignment by adding additional check 
> condition in vmx_handle_exit.  Of course , it is also ok that 
> hand_bus_lock_vmexit do nothing , but the code is not clear, and the 
> code logic will be inconsistent with spec description.

For 5.16 we'll go with something like Sean's sketch, that sets the 
bus_lock_detected bit on EXIT_REASON_BUS_LOCK.

Paolo

