Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F41331412F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhBHVDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:03:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236490AbhBHTvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612813797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fbn7GdaBKVLKbPiuQemPacIJV9xqx2rXfL8BnWQu1BA=;
        b=QXh6kN8fIX1TRM/eIdd61Mk3sgVrrl47alh0UyBfnIcwl3uXFSb1cw3PD/ytRhjFZBiYWr
        SOLXPixs4m4r05MSfjXPEpBDHNwR3qvNEJojwacrLPnoCfqVPEkAsgZIXPHnkffsh4MmkS
        Ke4wiPHEcMhI8FriNPPzU5TdPuhAsl8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-_DEBITShN-yRR0z9iiMCZw-1; Mon, 08 Feb 2021 14:49:54 -0500
X-MC-Unique: _DEBITShN-yRR0z9iiMCZw-1
Received: by mail-ej1-f69.google.com with SMTP id k3so13418803ejr.16
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 11:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fbn7GdaBKVLKbPiuQemPacIJV9xqx2rXfL8BnWQu1BA=;
        b=rSUcHZZREgOwxQe2HiNLJFNNwtPBMMhtHEyMwNMppfm58syrLV6Oz7VBi1BI2wSsQ5
         O44hR4kKR46KGLNPSZ1za9VmNufFd/Zs+QPunSKEFVhCKd05KyJubdgrGPO+WUb/S/X/
         a9FRAsd8UXcCT3dRRCPH02C9POBbgwnMpZzZzHD+oh/1TIGlH7Y4X3Z27GE6DFytzVAg
         R7mhR95eD+B1wOsN6qSKIBDpCkySkDk+85gAX0lzRwEXvrKJi8lIobGuf8EA5BVfJ037
         LRkQ3+CWYQeA4F7d2HKbF2OkVn4NMQgWn5HopktnDqQ7EMD0XIXAzQVaeUTvQ7GiyqS6
         HwnQ==
X-Gm-Message-State: AOAM533z6SV55Iceo4h1Kyq3v+POZlHX12PbdFsliN1MtjBfZWbV4Jmp
        n86+eEbnODMlP2fZ1po/YTYMLPwD5UtletTwSNoRoXiWdmE5Swk1qciOwWp/qDhlXg3FSFZHkxR
        Q9Vl7792J/XFMAPkBM3MgfoWv
X-Received: by 2002:a05:6402:1398:: with SMTP id b24mr18085554edv.108.1612813793315;
        Mon, 08 Feb 2021 11:49:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwARQ4C58IlhAqgbkOSrum8emzTUjTpBZYrfMp7Hx+e0BH4Olv/xtake/poBSSiELcuHYuUmg==
X-Received: by 2002:a5d:4a09:: with SMTP id m9mr21584778wrq.122.1612813299508;
        Mon, 08 Feb 2021 11:41:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d23sm423802wmd.11.2021.02.08.11.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 11:41:36 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: compile out TDP MMU on 32-bit systems
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210206145333.47314-1-pbonzini@redhat.com>
 <YCGQVdPio+LSNWGi@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24735404-2cde-42a6-14c4-f734da5d5493@redhat.com>
Date:   Mon, 8 Feb 2021 20:41:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCGQVdPio+LSNWGi@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/21 20:26, Sean Christopherson wrote:
> This can/should also expand the #ifdef to the TDP-only fields in 
> kvm_mmu_page. I also vote to #ifdef out all of tdp_iter.h, and probably 
> the TDP-only fields in struct kvm_arch. 

Agreed except for tdp_iter.h, I don't see the point since it is not used 
outside tdp_iter.c and tdp_mmu.c.

Paolo

