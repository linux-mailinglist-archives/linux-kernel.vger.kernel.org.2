Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88FF414197
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhIVGWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232367AbhIVGWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632291660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVSdF519TDjzg1QeVMPay1vdg0A7iFXE86QzhnlbYWM=;
        b=CaO9mXodCBWdg/xBlvJXweasJVhTPxrH2znai5QB5Ei+mVCxgA3hnvJt4aUgao4f2y9mHc
        UWV9H0rjLQoc/x5yQBLMoT6iFd4Pl332PlCe4gN/PTkn7qnS7e2ydEFTskVgtzMmHFpUJb
        Pad3w+63vxZV6GheMnGIDnxJ6fdd+yo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-jAZC5QF1NES301r5PIqLzg-1; Wed, 22 Sep 2021 02:20:59 -0400
X-MC-Unique: jAZC5QF1NES301r5PIqLzg-1
Received: by mail-wr1-f72.google.com with SMTP id l9-20020adfc789000000b00160111fd4e8so1103151wrg.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 23:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xVSdF519TDjzg1QeVMPay1vdg0A7iFXE86QzhnlbYWM=;
        b=tAcwm71W6QmlL8/J/CLecEkE4si4XE/6ZOjirUBbLcLaQNAXWSWo6HJaoPK81maCt9
         odGmQJ++3xEQUlglXd+MflOWcbcwXKKyvmIp37buWSdStziDr/XIKJyxf+9FaYMU7CdV
         VumBQ2JlbsLcyrr6wayniupAcG3kVbJ3UH2nhoXeKGQ5LLYHiKlwvBkGQUG9A72WOCOq
         wnoPNt/LvzlMj59C6YrYEyUJxSgkmhkutQZ/6mP2C8c4ORHs/UupqcwL9DrV/VUi+mrb
         InQzuyTtOmOHWayeupsvSRcNOTNPXF4B38LEW9isUdQADkmwscYEFRAcR+cWYq5YTGFg
         vd4w==
X-Gm-Message-State: AOAM530rMZs7m1GMnl6/VJUBRMZjT//XQ6biCVksrhoA76W7bi38uqHp
        EWg+T5gaUrboBN8Mc4Vx/H9UON+LQgOwb2J2Sp9ES3VwipvOGza13ueEJrEyrdVddQNk4Ir/AFp
        p0gXgLQglPEVXcoIHA5Kg+1kQ
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr8529195wmh.193.1632291657975;
        Tue, 21 Sep 2021 23:20:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWamuC9/jAZ/67Hu2Cks4vmJvt1lGRL5+X81yLTOV7mAk+10ovLzkV1o2LD+Mr61lyumWy0A==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr8529169wmh.193.1632291657753;
        Tue, 21 Sep 2021 23:20:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w1sm4890326wmc.19.2021.09.21.23.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 23:20:57 -0700 (PDT)
Subject: Re: [PATCH 5.14 298/334] time: Handle negative seconds correctly in
 timespec64_to_ns()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Lukas Hannen <lukas.hannen@opensource.tttech-industrial.com>,
        Juergen Gross <jgross@suse.com>
References: <20210913131113.390368911@linuxfoundation.org>
 <20210913131123.500712780@linuxfoundation.org>
 <CAK8P3a0z5jE=Z3Ps5bFTCFT7CHZR1JQ8VhdntDJAfsUxSPCcEw@mail.gmail.com>
 <874kak9moe.ffs@tglx> <YURQ4ZFDJ8E9MJZM@kroah.com> <87sfy38p1o.ffs@tglx>
 <YUSyKQwdpfSTbQ4H@kroah.com> <87ee9n80gz.ffs@tglx>
 <YUYJ8WeOzPVwj16y@kroah.com> <YUibLGZAVgqiyCUq@sashalap>
 <YUowhlVfLiLWE8K/@sashalap> <87sfxx65dr.ffs@tglx>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7e3ca2fd-d634-68ee-c7f9-c4d112ddc4a6@redhat.com>
Date:   Wed, 22 Sep 2021 08:20:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87sfxx65dr.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/21 22:27, Thomas Gleixner wrote:
>   3) Maintainer allows AUTOSEL, but anything picked from files/subsystems
>      without a stable tag requires an explicit ACK from the maintainer
>      for the backport.
> 
>      Is new and I would be the first to opt-in:)
> 
> My rationale for #3 is that even when being careful about stable tags,
> it happens that one is missing. Occasionaly AUTOSEL finds one of those
> in my subsystems which I appreciate.
> 
> Does that make more sense now?

I like this!

> Might be a bit overbroad as it also includes x86/kvm, x86/xen, x86/pci
> which I'm not that involved with, but to make it simple for you, I just
> volunteered the relevant maintainers (CCed) to participate in that
> experiment. 

I would opt in to MANUALSEL too; so Sasha, feel free to do the same for 
everything that I'm involved in by the MAINTAINERS file, or we can start 
with x86/kvm via the generic x86 entries.

Thanks,

Paolo

