Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26532394621
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 18:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhE1Q7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 12:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230337AbhE1Q70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 12:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622221071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsUDfVx6kw1QKKH4CSV+8SNh91THtBJmewd0AtxZsM0=;
        b=c2skMdoTMJRIkLkofoNFXOg/9jGRnjy0WqJLJcdFjO/FOf/+o6fO2rHr6N0JUug472zvbt
        FHU+cjnVfekV4WmmwbLtPCBFhott69xdXmHxL5JddunocdKQ7QW2eIkKfyIfHg2nkX4hJy
        XnkqHJ4iLMFZt65u26Qg03QYOodf9Go=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-p_NMhzPdPYKhaiJWeflKjg-1; Fri, 28 May 2021 12:57:46 -0400
X-MC-Unique: p_NMhzPdPYKhaiJWeflKjg-1
Received: by mail-ej1-f72.google.com with SMTP id qk29-20020a170906d9ddb02903e6eb7046f6so1267960ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 09:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsUDfVx6kw1QKKH4CSV+8SNh91THtBJmewd0AtxZsM0=;
        b=qiGz16jEI1w5tCtGsRfBJaCUOJn/rEIJ+WUl2oHCZ0K+6AyNb+VcUkrv5atCu3Fz2I
         prgHPk5Xr6BaxMwOlvEMFY4D9YRGpN3HgucEFeN9DrDAQ1Zi2KwkMbrNJ1sJuu1ZRA+N
         X6hxVM8mHEUL4bCUGKYlkhFYjsctyz2qBVyZb9outTVUX6rwte/bThYwIKuxmEMhd96E
         Z5JUALKzwoHEmFladCGTLaV/SbDo5EGZdxIDM1Bg4VYY1DAW8HFEhWXalWQt9aQzJQXm
         wYNZe61MpbJ+Pxx9mGxj5NyqV7BnRHz3R6YpuA5R22x/rUjOKDugc1dOa6nPQCUsFlad
         405w==
X-Gm-Message-State: AOAM533M0GGNGoaaM38MyUm9EtW7N1ZcnI5DDLJNxuB2RAOql278F8XR
        l6YGpMrEMcBYvY0Qy/cb0suXRQEFSpp24WQW6S6osWvDebabIVWjICJAj8zHi19tOTZms4023mP
        +QEuo8P6gu1RzXWPUkxNrw+9n
X-Received: by 2002:a17:906:a88c:: with SMTP id ha12mr10040289ejb.129.1622221064241;
        Fri, 28 May 2021 09:57:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7sI8kp8yuGAgJ1e35LlzT33u7gefY6svEG8stz3Z+BamOigP5rdwUT8mplASzQlfiImy/Jw==
X-Received: by 2002:a17:906:a88c:: with SMTP id ha12mr10040273ejb.129.1622221064030;
        Fri, 28 May 2021 09:57:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l19sm2197864edw.58.2021.05.28.09.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 09:57:43 -0700 (PDT)
Subject: Re: [PATCH] Move VMEnter and VMExit tracepoints closer to the actual
 event
To:     Dario Faggioli <dfaggioli@suse.com>,
        Sean Christopherson <seanjc@google.com>,
        Stefano De Venuto <stefano.devenuto99@gmail.com>
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, rostedt@goodmis.org,
        y.karadz@gmail.com
References: <20210519182303.2790-1-stefano.devenuto99@gmail.com>
 <YKaBEn6oUXaVAb0K@google.com>
 <ab44e5b1-4448-d6c8-6cda-5e41866f69f1@redhat.com>
 <d7dc2464a8aa3caf64f955fe6c9df0cb8fe3b746.camel@suse.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c30bfb44-2dc7-cb9c-c038-5ab08f611586@redhat.com>
Date:   Fri, 28 May 2021 18:57:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d7dc2464a8aa3caf64f955fe6c9df0cb8fe3b746.camel@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/21 18:55, Dario Faggioli wrote:
> So, Paolo, just to be sure, when you said "the tracepoint on SVM could
> match the clgi/stgi region", did you mean they should be outside of
> this region (i.e., trace_kvm_enter() just before clgi() and
> trace_kvm_exit() after stgi())? Or vice versa?:-)

Just outside, yes.

Paolo

