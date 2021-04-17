Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AC03630BF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbhDQOwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 10:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236563AbhDQOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 10:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618671124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yG7CbGT59OHfRevt3XXh2eiyrKABZpdeb+wHsJG++fM=;
        b=Oy+DwEiUKcutEDPdmFSqgDtyZLOds06lPykyE41ZPnVV1e5i0AQFyUbOPI1u21Oa0XibXq
        4+tGF4fRAEtYWQv2xEX+Nz/6ncgn2AEZMMuk7XhQjLiymILW1UTyP+MDRozvk/uPbJkrjv
        uM0G7sDrtJb6Us9NOVMuIaUFZ5YbbEA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-zuUpCWE3OrW8u7210DPaTw-1; Sat, 17 Apr 2021 10:52:02 -0400
X-MC-Unique: zuUpCWE3OrW8u7210DPaTw-1
Received: by mail-ed1-f70.google.com with SMTP id co5-20020a0564020c05b02903825bcdad12so8701519edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 07:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yG7CbGT59OHfRevt3XXh2eiyrKABZpdeb+wHsJG++fM=;
        b=tNMgLVmIcHGFhJ6GVDzWZzG8EaTZFeEsYGaVsrTJ31/TKk4T2Arb0XrZlMsSEz6M2h
         VhVU5tGVpxEXhFeYqKALzJXMNtbWKG3FrlERntb/CBfjLqI3YJ1ns1Fg4PPpMAqhI2en
         /WHe+UYd+5CulZiGxWMWYxunENPPMcoXOEyGW6IU9npidCu4kS6rUW/w2c4Y0nKKhuF1
         DwDlupPeiPeielUDwgluafhWoxWF6VTESUp9jZVMDZ+To9eIflhgWGFxIUGW7jQG1qlw
         wNZXpk5PPdiBqqhtZPctASQNmekj7bMEvAPjqRnWCQpu3oqRFyzXuO+5sV9l59AFWGk8
         b/+w==
X-Gm-Message-State: AOAM5336EXO8j73aVXgFBZJ/y1Qegn23T+FVjNJ0/bwOp6Ja/ksX1bB8
        LXCRgwVaY8R2V8y3e0NXzJWYRSSrOuoqOlSOcQSWZBgT+9Who7Cn/DtFFWyZ+rUsmk2T7PImXX9
        /UJP7x61Ty/0Qxx+M7TGtdtgnLWVGxAaLyozA3poVlF3D4OnZY23DA9dNjdgL9U7Vmt8QwuJO75
        1y
X-Received: by 2002:a05:6402:290:: with SMTP id l16mr5438968edv.337.1618671120424;
        Sat, 17 Apr 2021 07:52:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHc4iGjW4sOLaFFmFfqQFNbzRCiVqgH6eNtR/zBIoDeFLhVfTfFdsedBGskI5MmVb9QV6caA==
X-Received: by 2002:a05:6402:290:: with SMTP id l16mr5438944edv.337.1618671120248;
        Sat, 17 Apr 2021 07:52:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a24sm6468394ejr.58.2021.04.17.07.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 07:51:59 -0700 (PDT)
Subject: Re: [PATCH 00/13] [RFC] Rust support
To:     Peter Zijlstra <peterz@infradead.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Cc:     ojeda@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210414184604.23473-1-ojeda@kernel.org>
 <YHiMyE4E1ViDcVPi@hirez.programming.kicks-ass.net>
 <YHj02M3jMSweoP4l@google.com>
 <YHk4DZE1ZWTiBB1f@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa6e44ab-e223-73aa-279e-8103732460ac@redhat.com>
Date:   Sat, 17 Apr 2021 16:51:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YHk4DZE1ZWTiBB1f@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/21 09:09, Peter Zijlstra wrote:
> Well, the obvious example would be seqlocks. C11 can't do them

Sure it can.  C11 requires annotating with (the equivalent of) READ_ONCE 
all reads of seqlock-protected fields, but the memory model supports 
seqlocks just fine.

> Simlar thing for RCU; C11 can't optimally do that

Technically if you know what you're doing (i.e. that you're not on 
Alpha) you can do RCU using a relaxed load followed by an 
atomic_signal_fence(memory_order_consume).  Which I agree is horrible 
and not entirely within the standard, but it works in practice.  The 
Linux implementation of memory barriers, atomic RMW primitives, 
load-acquire/store-release etc. is also completely outside the standard, 
so it's not much different and more portable.

The only thing that I really, really miss when programming with C11 
atomics is smp_mb__{before,after}_atomic().

Paolo

