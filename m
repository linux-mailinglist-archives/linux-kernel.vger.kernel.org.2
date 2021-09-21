Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EFE41391C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhIURtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231722AbhIURtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632246452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyiZgpf6z6VHbt4M8PYYjgsOSNX9IDXClXU1vhAYGNQ=;
        b=CXDc72kXUK5ZE56CFQgD/JyACgUgVvahN4s0vwU2nw/pkHGNft1T2P73dNWri/jfOT5Tl1
        nU0GS6n1BlN7HfP8Krh9SOcHRz4QpuaeWiGsda5mo+Ujdm+0TLV6KI/a1g0XBishnCb6+H
        Rch7nafemuWus6He+eADDgioNGZ/cD0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-Xr43iUXqPJuNLch8rKd2IQ-1; Tue, 21 Sep 2021 13:47:31 -0400
X-MC-Unique: Xr43iUXqPJuNLch8rKd2IQ-1
Received: by mail-ed1-f70.google.com with SMTP id w24-20020a056402071800b003cfc05329f8so19891114edx.19
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gyiZgpf6z6VHbt4M8PYYjgsOSNX9IDXClXU1vhAYGNQ=;
        b=C7kVT4+/7nX0GcWhzdvgzlwZDOXrAjpKJPwGd98x+qGay8e6PB9oEthUAGAJ2UrRw/
         cww1fFCA/dHT8rKqIImnrN7SYd5BYNAXzQWefsD2c9neXsEwc07rwGqa70xY2xy4l48u
         uqysOas5X1LAuvD8zOUcC+t77hdMkrlPWZK6scab/LIKd5RdzjA9EjzK8UFJJwpUIZo6
         ZzXQnVGXrDZv1u18dnYKIT0lIMniou1Jkdz5gcR65NAjYp/NUeyQxs5N8T79JKDP1sN8
         I32LBQ8gm0R6CNNL/x+Ooq4z4QkJ3VvY0+cbBBBKpbWatiUWxTWHBHlD52QdmFSDtpVO
         FjsQ==
X-Gm-Message-State: AOAM531cGTzqwxQ57c5DkS1vIljIQ+tP7oe023wyT+xllZLI1Jx+lgn6
        COgwdB6V2rqlIyb2xEo+LWHUpkB00SG6SB5U5cz1arkwmggXBXuE29H1PxoIxaC1XS9hq9fuDVe
        /4zQLRxuhdxx0e+k2tgPHOmVN
X-Received: by 2002:a17:906:fc0b:: with SMTP id ov11mr15717223ejb.22.1632246450662;
        Tue, 21 Sep 2021 10:47:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw54DB94GKIEx7PyUCLeDDhZBrVAwqAJwaBALM6jtLbnit1i3d3XWfwOsRqFKoOB51L8AuNJA==
X-Received: by 2002:a17:906:fc0b:: with SMTP id ov11mr15717203ejb.22.1632246450444;
        Tue, 21 Sep 2021 10:47:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u19sm6214710edv.40.2021.09.21.10.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 10:47:29 -0700 (PDT)
To:     Sean Christopherson <seanjc@google.com>, tcs.kernel@gmail.com
Cc:     vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko@kernel.org, Haimin Zhang <tcs_kernel@tencent.com>
References: <1630636626-12262-1-git-send-email-tcs_kernel@tencent.com>
 <YTJK4aACtboaPAF8@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] KVM: x86: Handle SRCU initialization failure during
 page track init
Message-ID: <af562685-673a-489d-6a00-5e77329dc2a4@redhat.com>
Date:   Tue, 21 Sep 2021 19:47:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTJK4aACtboaPAF8@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/21 18:18, Sean Christopherson wrote:
> Before moving forward with a fix, I'd like to get Paolo's input on dropping
> track_srcu in favor of kvm->srcu and avoiding this altogheter.  Note, Paolo is on
> vacation at the moment, so this won't get attention for a week or more.

The reason for track_srcu's existence is to avoid complications in 
kvm_arch_flush_shadow_memslot, which is called from the _write_ side of 
kvm->srcu but is on the _read_ side of track_srcu.

I think this should be fixed easily by taking slots_lock in 
kvm_page_track_register_notifier and kvm_page_track_unregister_notifier, 
however it's a bit more complicated from the point of view of the lock 
hierarchy and possible deadlocks.

So I'm open to patches that drop track_srcu, but for now I applied this 
patch.

Paolo

