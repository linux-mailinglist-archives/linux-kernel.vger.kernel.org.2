Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3772391555
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhEZKuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234140AbhEZKur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622026156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irqMPhUSvy2ILxtVtEb7WKBccyA8xYtf3GSVWQVHR58=;
        b=RySTAjWhTzTcz5EXJeeCQNW3Z1kd+DXAIKNx5FNU6ZqqRA3vckh/DcIA9DQAKVYysgkuOh
        0llJIxTp05uv1JvvmmqbNAk+gwudM5M59Gxj4MH8rJO2I9jbmOV4xXyMhDXpwqdIPr37SP
        FU02qQiyrRFQW188ffMsBbhMiQSIyWI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-W2_7788ZMB--x_L-9zD4gg-1; Wed, 26 May 2021 06:49:15 -0400
X-MC-Unique: W2_7788ZMB--x_L-9zD4gg-1
Received: by mail-ed1-f71.google.com with SMTP id c21-20020a0564021015b029038c3f08ce5aso307752edu.18
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 03:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=irqMPhUSvy2ILxtVtEb7WKBccyA8xYtf3GSVWQVHR58=;
        b=cHkwqvZKgYFcR7s8qK4Qa83RBU5cXTrJYwbB1/0Cqm2RO36On5QB0oLrUbFoZCYLoN
         58ZKaYqN8jBZGW195wcMeFcKbin2CVBaqfaJMtxJj9JFkHTgWNcwALCc/xioVRnXbM7v
         F/BBobWPWsttaIozdOv9QdNjv7C20tmjlEDejH79YZER/jPiwGjSDqaGOrGcns5RvZA6
         uj3wpEBKvgsm4qJLRh0LfWLXe+tK3FXDirKmXGgGGRaHfIlA+LJN4vBf434O+YjgiRy+
         g+UjUJH5uNvRv6yHnOImnW0g3dEszILokN50u9zKkpxcEcFsvfXAdIV3p6XjmIyDVhkc
         oGvw==
X-Gm-Message-State: AOAM533yC4OISQk3DSW8vUV1d22Jw567tcNaRSL+WgAhBUhol17dTl7h
        rgNOoCrzXljL8A8dQLGLMe8rB5CbVYm4Mo3wHMB1XmctHqFOHeM10drJosAWQmKEsEXNjzpR6eQ
        WIxEyxbvCMMx8l3iC9G+I2+gO
X-Received: by 2002:a17:906:a945:: with SMTP id hh5mr1092572ejb.227.1622026153684;
        Wed, 26 May 2021 03:49:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRtG7hFeTjm7QRnbQ9ciLTc/XgAsTCAxGlvoiCi3XsLctD/kUx6aIlNrCo60BUJXhNPya+Hg==
X-Received: by 2002:a17:906:a945:: with SMTP id hh5mr1092559ejb.227.1622026153517;
        Wed, 26 May 2021 03:49:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n13sm10266934ejk.97.2021.05.26.03.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 03:49:12 -0700 (PDT)
Subject: Re: Writable module parameters in KVM
To:     Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
References: <CANgfPd_Pq2MkRUZiJynh7zkNuKE5oFGRjKeCjmgYP4vwvfMc1g@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <35fe7a86-d808-00e9-a6aa-e77b731bd4bf@redhat.com>
Date:   Wed, 26 May 2021 12:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANgfPd_Pq2MkRUZiJynh7zkNuKE5oFGRjKeCjmgYP4vwvfMc1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/21 01:45, Ben Gardon wrote:
> 
> At Google we have an informal practice of adding sysctls to control some 
> KVM features. Usually these just act as simple "chicken bits" which 
> allow us to turn off a feature without having to stall a kernel rollout 
> if some feature causes problems. (Sysctls were used for reasons specific 
> to Google infrastructure, not because they're necessarily better.)
> 
> We'd like to get rid of this divergence with upstream by converting the 
> sysctls to writable module parameters, but I'm not sure what the general 
> guidance is on writable module parameters. Looking through KVM, it seems 
> like we have several writable parameters, but they're mostly read-only.

Sure, making them writable is okay.  Most KVM parameters are read-only 
because it's much simpler (the usecase for introducing them was simply 
"test what would happen on old processors").  What are these features 
that you'd like to control?

> I also don't see central documentation of the module parameters. They're 
> mentioned in the documentation for other features, but don't have their 
> own section / file. Should they?

They probably should, yes.

Paolo

