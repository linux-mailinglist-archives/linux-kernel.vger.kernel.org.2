Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E433437809
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 15:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhJVNgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 09:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231961AbhJVNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 09:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634909634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Vg6punm34oYk+y9zl1LSGNiEzLmAAfArkoDnEvG2GI=;
        b=ax6nwbayyx7EwrV1nebh3uJfQYGV85CuFa9tc4GHyU8tajl38de7LbZhmdOR0pOlkivS/R
        LygjXl3eyGIBUSTlpwtwenD7/3AZjANi8miltLdF+RePGwgTTSUDec/BfbElm2/ZXzxoaM
        sylZWbrdhJFQzCdHdh8Smp9NfOQiaHo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-Zt2AKPtFOjaa2dH_qnp8_Q-1; Fri, 22 Oct 2021 09:33:52 -0400
X-MC-Unique: Zt2AKPtFOjaa2dH_qnp8_Q-1
Received: by mail-ed1-f71.google.com with SMTP id d3-20020a056402516300b003db863a248eso3677212ede.16
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 06:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3Vg6punm34oYk+y9zl1LSGNiEzLmAAfArkoDnEvG2GI=;
        b=W7Js6bkbvAFDSDtLAonjKmiQBAuDiueWTcEUlRHq5meeo8clQPElPv9m2Ytqhf4N31
         4NzhiVn7AfNKAS+LKf47jWsG963VpWSobmFUGHOSD1CBIfDOKqLuCu4k64WeeGLxPq7q
         SecQvP+doEvPTXcQR3imEUP/B+mbqT/FYhS3EqIHRnp1Ab2F4FrcNAXB2cB4btZFfGLg
         HaeBoOHAU//6oMHLw+ytZDEuJtTSbl/XHVGaF2z36plz9MKJdD0O3ufU9fIlOHFB5D72
         c5LmR4RBr3xJX/gd4hGR+3oalx8u4u9XAFCUMY0lHa/bqoyOOzzNa0bZrAGPx+AmvJl2
         McjQ==
X-Gm-Message-State: AOAM530wxy8wky3bQWtnCluzQaXUeqGV323UWzlxHJ7AKM9F4VufV+ec
        M/0hASm0wPu5ZhzKzPk+RNXlrg6qzw+tU/gZM+Fz8TCIfXGOZsIUbcFqpOl6iLZEQNRI2eJEB0/
        1b8T+w6wpO9wBM5Wq8hSAe7TQ
X-Received: by 2002:a05:6402:1d49:: with SMTP id dz9mr25561edb.17.1634909631634;
        Fri, 22 Oct 2021 06:33:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYx1KIeAxL0rRpHT3vlVyvYf2GIBD9/4Aw8TmBkbWuyBpBvoIXF2O0dh8keeQzPCvsdCjZWw==
X-Received: by 2002:a05:6402:1d49:: with SMTP id dz9mr25536edb.17.1634909631427;
        Fri, 22 Oct 2021 06:33:51 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ku14sm490022ejc.30.2021.10.22.06.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 06:33:50 -0700 (PDT)
Message-ID: <43fd49ff-d54d-558f-f5c8-6dcc5dc726b2@redhat.com>
Date:   Fri, 22 Oct 2021 15:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/8] KVM: SEV-ES: fixes for string I/O emulation
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        fwilhelm@google.com, oupton@google.com
References: <20211013165616.19846-1-pbonzini@redhat.com>
 <YXH8hmB64gnwxIx6@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YXH8hmB64gnwxIx6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/21 01:49, Sean Christopherson wrote:
> On Wed, Oct 13, 2021, Paolo Bonzini wrote:
>> Patches 2 to 7 are a bunch of cleanups to emulator_pio_in and
>> emulator_pio_in_out, so that the final SEV code is a little easier
>> to reason on.  Just a little, no big promises.
> IMO, this series goes in the wrong direction and doesn't make the mess any better,
> just different.
> 
> The underlying issue is that kernel_pio() does the completely horrendous thing
> of consuming vcpu->arch.pio.  That leads to the juggling that this series tries
> to clean up, but it's essentially an impossible problem to solve because the
> approach itself is broken.

I agree on this, but I disagree that the series does not make the mess 
any better.  At the very least, the new signatures for 
__emulator_pio_in, complete_emulator_pio_in and emulator_pio_in_out are 
improvements regarding the _role_ of vcpu->arch.pio*:

- complete_emulator_pio_in clearly takes the values from vcpu->arch.pio, 
which _is_ the right thing to do for a complete_userspace_io function. 
This is not clear of emulator_pio_in before the patch

- __emulator_pio_in and emulator_pio_in_out do not take anymore the 
buffer argument, making it clear that they operate on the internal 
pio_data buffer and only complete_emulator_pio_in copies out of it. 
Which yes is horrible, but at least it is clearly visible in the code now.

I managed to clean things up quite satisfactorily with just 6 patches on 
top of these eight, so I'll post the full series as soon as I finish 
testing them.  5.15 can then include these to fix the bug at hand.

Paolo

