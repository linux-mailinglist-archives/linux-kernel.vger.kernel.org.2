Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B47441781B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347257AbhIXQDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347252AbhIXQDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632499287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TudUTjEP0k1/HE5s4PUTK9xUpG/DldUIjjGXuBeaV2g=;
        b=IFM3AI+4zlsCwRqUE+4lgNP1nFbln1CnEYndNMekWoym9QB6456Zb5kWoygLUXon970MvW
        1R7lFGIWnh2U5NswDgQRAgY6nALsdm/uC5A45JfDeqdCgoZ9g+u6PzQ7XgOKBLF5TNOfFF
        XC8kNH+Oq75NR7sYX2FdB+gDmskVXgI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-3QoBVnGSNae4ID1mg6xiIQ-1; Fri, 24 Sep 2021 12:01:20 -0400
X-MC-Unique: 3QoBVnGSNae4ID1mg6xiIQ-1
Received: by mail-wr1-f70.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so8482270wrt.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 09:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TudUTjEP0k1/HE5s4PUTK9xUpG/DldUIjjGXuBeaV2g=;
        b=1Rv58vQ5DT5g9f0u8Fbi3ViprxLdyGkH3VrehVySLfeRa+5GxEnCWZpE4Wmu7Jb4n7
         RL2z+d8vJj7fiZPTppQGxAXap6EhAYTPu1u4f8mTIG8hzBa1VE9tEvpgxJOd61d5fSzq
         WPuknd6fSpTHIHGY0wdSz+xuPTI7aQ7obSRrG8Tvduy2BZbFXohms+qDH+snbPtoZrW3
         0u230e9CAE9UUyl2BBD5ltuY1xu0uXN8IpDxlu3ZMGYg0dHXBYt1FGKNiNv0mS6ZAHAH
         KxsgH/H6jdVEXCdujh6jOSpuK0idoYLtP/i0s9HKytJyhF+V7A+zUPZgueNq54IsRGnI
         qXkQ==
X-Gm-Message-State: AOAM533QJAVbXR1i6GjLxoibuafZywdA2eUCe2Se8i9tU6RIb2EoMxOd
        EGRsOfNw/u0nxcJy2r2iqghNY5KKzBL3pwKxGAcuumfXJ/q0uJylRAYhdC7wMcVCU229/bbjoG9
        AEzte826gA0IVkgz5uhmjysZA
X-Received: by 2002:a7b:c845:: with SMTP id c5mr1032241wml.17.1632499279516;
        Fri, 24 Sep 2021 09:01:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/wZXfPe7Vy8SRZtDxf4Y674y47Z6H0NCE2CsQlcz9CeIwPLUy83tbmW0CljWDa+ec8tDF2Q==
X-Received: by 2002:a7b:c845:: with SMTP id c5mr1032205wml.17.1632499279322;
        Fri, 24 Sep 2021 09:01:19 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i203sm12811432wma.7.2021.09.24.09.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 09:01:18 -0700 (PDT)
Message-ID: <4005b824-549a-094d-82f2-e921fcd22912@redhat.com>
Date:   Fri, 24 Sep 2021 18:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [GIT PULL] KVM/rseq changes for Linux 5.15-rc3
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
References: <20210923181252.44385-1-pbonzini@redhat.com>
 <CAHk-=wjp7psdNc8KpxVDmcVYaAAxDUvvFTgx21OwZJzkghktLg@mail.gmail.com>
 <87r1deqa6b.fsf@disp2133>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87r1deqa6b.fsf@disp2133>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/21 17:13, Eric W. Biederman wrote:
> Does anyone have any idea what to call
> tracehook_notify_resume so that it describes it's current usage?

There isn't a more precise definition than "sundry slowpaths to be 
invoked before returning to userspace".  Whenever one of the triggering 
conditions becomes true, set_notify_resume() is called and 
tracehook_notify_resume() will execute them all.

Paolo

