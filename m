Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41BB3532ED
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhDCHJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232200AbhDCHJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617433741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wnHJ7PNuNi/MgLZsBS26NgmPxT4+w6+zr4G3AhXM1uo=;
        b=e0xG4bEXRPNl+v+nmlhK1unHSEnuimOv386GNO+CPzxSkqJcZR91W6/nOH5OUm6wjv64Fb
        FE5RSgU0VRwXSK87MnDwhv6Di9KzXooUx2V1fzt7pxT2whLQkTifyN+0rjRoNHfFll2V2Q
        +VqR1aikIERBWdTHAuEqnOmUdOErvJI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-Y-PeA3R-NqWd0kv7e3WvoA-1; Sat, 03 Apr 2021 03:08:59 -0400
X-MC-Unique: Y-PeA3R-NqWd0kv7e3WvoA-1
Received: by mail-wm1-f71.google.com with SMTP id i14so2628093wmq.7
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 00:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wnHJ7PNuNi/MgLZsBS26NgmPxT4+w6+zr4G3AhXM1uo=;
        b=b+pqdN5si8ULZkAOfGvBlX9KSR4vzgLG55QhszYbAwUsxnK1BPIh3Ulnv+0aBrFgcg
         mebkEW4dlK6KsMMG3Kj02OsMgkkddwc+EXQVy6cOac8rI8HzGbgvSeYMA6DwfLl/Ccyz
         9WQPJHqEYbHlsFVb4Eq8/JQI3yTqRSV1galB1pzPSaGKD6nUco+3vr4j26N6RMhQpwrB
         Xf0iWN+rGnmVZ5HzwCeZLKB42og/8Pmw/RK5S99nS6XIje2DpVWnF9JQf19lfqjTbhBP
         HpkTVPTb2L4NPJjkxJAQAU4QKhvFjwvJxrf6etclswGdosl8WFnXIkBy2WWtLEm1Jja8
         93zQ==
X-Gm-Message-State: AOAM531smeJNAEvgWcfQgaO+quw66YVbYDpt1fR5pxwMY8dT6pBcCaiE
        ks4IbaT7RFL5RbT4oK2jbex2asr0oRNKzy+v0KqEURccvGKubQEexTy7ClLYCcuEDv5EzoDkYZP
        03o/K+GY1rPx5ydUdJedj8DwZ
X-Received: by 2002:a05:600c:4c95:: with SMTP id g21mr5493552wmp.132.1617433738527;
        Sat, 03 Apr 2021 00:08:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKKg6FYFR9/URCAc/S96/zR2Mwi57fYr/pcZK0d8tw1j+m5cU+rIHUFxcv6ps3Tjv0ZNzEmg==
X-Received: by 2002:a05:600c:4c95:: with SMTP id g21mr5493540wmp.132.1617433738355;
        Sat, 03 Apr 2021 00:08:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e8sm14835032wme.14.2021.04.03.00.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Apr 2021 00:08:57 -0700 (PDT)
Subject: Re: [PATCH 2/4] KVM: MIPS: rework flush_shadow_* callbacks into one
 that prepares the flush
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        seanjc@google.com, "open list:MIPS" <linux-mips@vger.kernel.org>
References: <20210402155807.49976-1-pbonzini@redhat.com>
 <20210402155807.49976-3-pbonzini@redhat.com>
 <CAAhV-H4wskLvGD1hhuS2ZDOBNenCcTd_K8GkYn1GOzwnEvTDXQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3cd7114b-9980-4b4a-bf31-2818c7eb4a15@redhat.com>
Date:   Sat, 3 Apr 2021 09:08:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4wskLvGD1hhuS2ZDOBNenCcTd_K8GkYn1GOzwnEvTDXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/21 04:31, Huacai Chen wrote:
> Hi, Paolo,
> 
> TE mode has been removed in the MIPS tree, can we also remove it in
> KVM tree before this rework?

Fortunately I can pull the exact commit that was applied to the MIPS 
tree, as it was the first patch that was applied to the tree, but next 
time please send KVM changes through the KVM tree.

Paolo

