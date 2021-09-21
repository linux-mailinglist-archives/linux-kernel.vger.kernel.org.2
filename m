Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A990F413929
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhIURwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231839AbhIURwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632246663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5tw38aQ342cTbcJn0n2v27W7fz1pROVSgYA+iYbHIIs=;
        b=hoxzCgchFN8yQN/RfsJrzA9u/W4yytz2SO/FQd/4QvbCjU1pgVzaPiJfRNYBy7NrOpDgAV
        DO2BMXuI5dEc8lfp1BjcC6QE4ccB/qyRbKnTuRMz2xe3KN4IJuCql8gwC09IarJnqTZiCK
        EEtKi/hFK0lR0DeeQpM5DWU+E0LKTLM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-Xyaw7gypMQm0boPi4Z5M8w-1; Tue, 21 Sep 2021 13:51:02 -0400
X-MC-Unique: Xyaw7gypMQm0boPi4Z5M8w-1
Received: by mail-ed1-f69.google.com with SMTP id o23-20020a509b17000000b003d739e2931dso18156465edi.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5tw38aQ342cTbcJn0n2v27W7fz1pROVSgYA+iYbHIIs=;
        b=vPsP7LWJ4dY+b4cAEG7+PUs92CmiXwNppgsvQhTW4NZcbn9U+fgP4fFz7V9mBT/+vB
         WN0DuVa4y6bPCBp99BzVKMAfI3vUT2Lo6H8K9pR09iPr4iZTl/qj6Oag31vOuT3Y8AXd
         otIGY9/5eKqhOQnrfkp0RZbWG4ZEoRBKuCc2Jfloy8F0hQC+U5z4eFUO6mG4XJtdD3bk
         5AbNvZrIvB1ewc4kTR9PbaDgiY62swVIDdMkbawiAPlykA3s82xGAzboIHFwtw6cy+aY
         t6AHjX/WKB3yM24utpSAgLm9wnPVQZyWfofc6WaPZ352rWXyF5VUFSaMshZ9o3QjaAk3
         FoXg==
X-Gm-Message-State: AOAM532j81oZx8Fg1l6C/slG8mPTCzVe13qvJ1v8Kmo6r28BkPAUQOzr
        1JvfywAMj9hRYsQxMcvrQE7uVRPvZDbCn5C5fKb0VzAfVQAeXY0PK3hHdxZoLyFSnkaGYwjt1DI
        XOXV8CzLb6GJRgd+4BDj61bNDtONUP5e38OQhggxe3XRkypG29sxrLa1IUSySFA5nQ9xuVFPRj7
        F6
X-Received: by 2002:a17:906:60c2:: with SMTP id f2mr35146341ejk.531.1632246660528;
        Tue, 21 Sep 2021 10:51:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1Rc9rLuX+xwLhLcPc+OCmunsre8pR9hj516mc2mmdpdkBpNARQZZY+XrWUahPkQ0TA9Dj0A==
X-Received: by 2002:a17:906:60c2:: with SMTP id f2mr35146327ejk.531.1632246660342;
        Tue, 21 Sep 2021 10:51:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id 6sm7881530ejx.82.2021.09.21.10.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 10:50:59 -0700 (PDT)
Subject: Re: [PATCH] KVM: do not shrink halt_poll_ns below grow_start
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Suleiman Souhlal <suleiman@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210902031100.252080-1-senozhatsky@chromium.org>
 <YUFPcphBWO8bz7Lk@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d76452b5-fd30-f418-ff4f-de10dfa831a7@redhat.com>
Date:   Tue, 21 Sep 2021 19:50:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUFPcphBWO8bz7Lk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/21 03:42, Sergey Senozhatsky wrote:
> On (21/09/02 12:11), Sergey Senozhatsky wrote:
>> grow_halt_poll_ns() ignores values between 0 and
>> halt_poll_ns_grow_start (10000 by default). However,
>> when we shrink halt_poll_ns we may fall way below
>> halt_poll_ns_grow_start and endup with halt_poll_ns
>> values that don't make a lot of sense: like 1 or 9,
>> or 19.
>>
>> VCPU1 trace (halt_poll_ns_shrink equals 2):
>>
>> VCPU1 grow 10000
>> VCPU1 shrink 5000
>> VCPU1 shrink 2500
>> VCPU1 shrink 1250
>> VCPU1 shrink 625
>> VCPU1 shrink 312
>> VCPU1 shrink 156
>> VCPU1 shrink 78
>> VCPU1 shrink 39
>> VCPU1 shrink 19
>> VCPU1 shrink 9
>> VCPU1 shrink 4
>>
>> Mirror what grow_halt_poll_ns() does and set halt_poll_ns
>> to 0 as soon as new shrink-ed halt_poll_ns value falls
>> below halt_poll_ns_grow_start.
> 
> Gentle ping.
> 
> 	-ss
> 

Queued, thanks.

Paolo

