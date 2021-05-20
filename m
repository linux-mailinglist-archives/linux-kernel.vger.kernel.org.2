Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD79438B422
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhETQUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233840AbhETQUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621527528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6OgNPYxA7i+etU7xLj3nrXr95skp7dY81DNzdhoz9rg=;
        b=MbsdO9p21Pkqs8IQ0urYaiImkcuy7g1gNMWLTZMZGpJLqdv4uo2/3EqOymTAztfVA54BjK
        cFxtdpy2XXa5ppZXxRWb+jXjxuQZb8c7sL5CPCqc4UCg18euIXBxMzzyZ9EDWIeuSBzWmc
        GB3PTWHbmRXEvLVVXAaYOBRSknnOAvg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-cQVypByEO0-L9DU84zn2RQ-1; Thu, 20 May 2021 12:18:43 -0400
X-MC-Unique: cQVypByEO0-L9DU84zn2RQ-1
Received: by mail-wr1-f69.google.com with SMTP id i15-20020a5d558f0000b029011215b1cf5cso2424190wrv.22
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6OgNPYxA7i+etU7xLj3nrXr95skp7dY81DNzdhoz9rg=;
        b=oD72nqRMnmLeUxd8QeJ4IK43QZGMDjzmFgfV5YprhTJ4xE7GUHF2X9+Kk97i3I1g8t
         pr43mmu6IyH+HtHrReDo6mb+Mj126ZdMffLoJSGQhk5Zeyvf6D6fQzbK8joorr3gZMsk
         4XBC8gHCkNdaT6wXk9FlU4Q8JCfnXfae5ZmQs0QhYTX27ysGgty5lwsv1tDBBNwm6Y7p
         6733Osl/Giz99gX/XB3HooegTrv5QPdZwiLWBn+yu4Zyz+sZgpIMr3Qtl71aj4L6S9mX
         RndWmHNt42hJHhlhWstlkAKXFG1MyN74Z0BgT/2CqxQTib75+Pe+3n0IxkvrMcVGG3wa
         JiZg==
X-Gm-Message-State: AOAM533WzKWJTvjqbVNJ+L7T4VdsnpaWge64uRk1LrLGG8dNlvf6MAVw
        7cHxzEcPSmIDsYlWMjLKrIMbJLHLZ9c7QspkQoXqXlTSLpOi3ql9s6J2LFseF5z9qa7m1Q0M5BW
        s60BSGof7T6AfVBhoa1qc/Zjs
X-Received: by 2002:a5d:59a4:: with SMTP id p4mr5320581wrr.248.1621527522005;
        Thu, 20 May 2021 09:18:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHdHvZnHkFtg16t/tFIWUALZddO72xh0A6mKZ4eMSItEm7NWMHJO7CM8CAVLCm09/8wvuHlw==
X-Received: by 2002:a5d:59a4:: with SMTP id p4mr5320562wrr.248.1621527521813;
        Thu, 20 May 2021 09:18:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b8sm3978942wrx.15.2021.05.20.09.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 09:18:40 -0700 (PDT)
Subject: Re: [PATCH] Move VMEnter and VMExit tracepoints closer to the actual
 event
To:     Sean Christopherson <seanjc@google.com>,
        Stefano De Venuto <stefano.devenuto99@gmail.com>
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, rostedt@goodmis.org,
        y.karadz@gmail.com, Dario Faggioli <dfaggioli@suse.com>
References: <20210519182303.2790-1-stefano.devenuto99@gmail.com>
 <YKaBEn6oUXaVAb0K@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab44e5b1-4448-d6c8-6cda-5e41866f69f1@redhat.com>
Date:   Thu, 20 May 2021 18:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKaBEn6oUXaVAb0K@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/21 17:32, Sean Christopherson wrote:
> On VMX, I think the tracepoint can be moved below the VMWRITEs without much
> contention (though doing so is likely a nop), but moving it below
> kvm_load_guest_xsave_state() requires a bit more discussion.

Indeed; as a rule of thumb, the tracepoint on SVM could match the 
clgi/stgi region, and on VMX it could be placed in a similar location.

Paolo

> I 100% agree that the current behavior can be a bit confusing, but I wonder if
> we'd be better off "solving" that problem through documentation.

