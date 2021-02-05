Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F2A3107CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBEJ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:26:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230347AbhBEJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612516844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ay95j8ZOJweqoeSHjCRRFfGdbMEYx6rMAyvOQfQnfuI=;
        b=FKoPzjkp4F1YI9wMBorzWhFqLSsRw9Nut9SQZbP8uEuuDowm9sY1lDEr046QN/W+8A6aZX
        svPEKQ+Tk9rPIRHoBEexhGQSxXjNNvvASkeg2XeOmiNKGiHOTGlSYcfFBXvRcRSmBUM24u
        j9UPL/MuoncgeJ5jdJSjtU1PX1m5O1w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-cASRuG3NMyOI1Vp8RPE04g-1; Fri, 05 Feb 2021 04:20:42 -0500
X-MC-Unique: cASRuG3NMyOI1Vp8RPE04g-1
Received: by mail-ej1-f69.google.com with SMTP id yc4so6384416ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 01:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ay95j8ZOJweqoeSHjCRRFfGdbMEYx6rMAyvOQfQnfuI=;
        b=Xz/5V8QlBE6A54dvsrPfgAY5nvhjaHk+mGUjsxx8Tg57IVkDfLiHamzjDvMnt7OLty
         95qe0cfd4QT728SMSEn17dxJMtob3H7n3+B/qumtkqNmG6sOIZwHic/o5VThTcRTo5MD
         0fK+tskaFlWnnyD7Y1tysrOFwred6x4t6GPiYVdSszivfNUy500TkwVVAi0aYKPx3mB5
         HqX6+U/fvUtyrmZgngNyvIlMn7HRGll587qnZeoXXv84gxsLYjf/WpDBJZ9vsMebF3/n
         bOcHQTt835F5Hib7aTtaKf4XNFJQniy0f3F6/aF2QcwihKLvD5F486xIEsll+dcvKi1d
         Q9wQ==
X-Gm-Message-State: AOAM5311aeU64FCDaNWxyTfyb1TdZL2ESVm3xIryG2gV9lINcD1EGtAi
        6mvhSMxy3Gl/GiMFbtYuGlt1cy940Xc3mGEZdC9/saW95VkhS5ra3+/XL1+pB6dPpWPs47iEvFB
        dxnMHiWNFT5+GUeswPSV04NRiEt+WCCHOn/Ekr1WL58enpRdjDuCLEYOzZrGsFDfsBpnvctbfdo
        jJ
X-Received: by 2002:aa7:cc98:: with SMTP id p24mr2753580edt.126.1612516841250;
        Fri, 05 Feb 2021 01:20:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzU95X6x/jd0HaI7sckA1in5gXTVMvQUyFgo4kCKOezCNFIpUz++OHiVuzTw7O1f+9VUnnSIA==
X-Received: by 2002:aa7:cc98:: with SMTP id p24mr2753556edt.126.1612516840979;
        Fri, 05 Feb 2021 01:20:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u23sm3713829edt.87.2021.02.05.01.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 01:20:39 -0800 (PST)
Subject: Re: [PATCH v4 4/5] KVM: MMU: Add support for PKS emulation
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210205083706.14146-1-chenyi.qiang@intel.com>
 <20210205083706.14146-5-chenyi.qiang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dabceac5-876f-a145-fffc-73df917fa1ce@redhat.com>
Date:   Fri, 5 Feb 2021 10:20:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210205083706.14146-5-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 09:37, Chenyi Qiang wrote:
> |In addition to the pkey check for user pages, advertise pkr_mask also 
> to cache the conditions where protection key checks for supervisor pages 
> are needed. Add CR4_PKS in mmu_role_bits to track the pkr_mask update on 
> a per-mmu basis. In original cache conditions of pkr_mask, U/S bit in 
> page tables is a judgement condition and replace the PFEC.RSVD in page 
> fault error code to form the index of 16 domains. PKS support would 
> extend the U/S bits (if U/S=0, PKS check required). It adds an 
> additional check for cr4_pke/cr4_pks to ensure the necessity and 
> distinguish PKU and PKS from each other. |

Slight changes to the commit message:

   Up until now, pkr_mask had 0 bits for supervisor pages (the U/S bit in
   page tables replaces the PFEC.RSVD in page fault error code).
   For PKS support, fill in the bits using the same algorithm used for
   user mode pages, but with CR4.PKE replaced by CR4.PKS.  Because of
   this change, CR4.PKS must also be included in the MMU role.

Paolo

