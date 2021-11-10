Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC5244CC52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhKJWTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:19:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234185AbhKJWOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636582307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9M4M5Q2ZucJ6CoLKISzLEFtE7hD6R0Y8QipK4pqCC48=;
        b=gQrs0yvLMp0Uug+BUDBhju0I+QYS8UJxWADPGmIZo1UDV7fxUvQFD7DwIWVI4QGIjFcIXY
        tZM8AUyqOvuLo0+0nViaqvYS4+L6yBsldtdGNzbPxpwab5Oq4xA1f+mcOG70DnQl8porBf
        flLoPKzBlUH9JUecljQFpadoBS0fBT4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-SAwH4RNbN3y3wBW7jbTMWA-1; Wed, 10 Nov 2021 17:11:46 -0500
X-MC-Unique: SAwH4RNbN3y3wBW7jbTMWA-1
Received: by mail-ed1-f72.google.com with SMTP id g3-20020a056402424300b003e2981e1edbso3646788edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9M4M5Q2ZucJ6CoLKISzLEFtE7hD6R0Y8QipK4pqCC48=;
        b=K91hH0cskPPST/EuXEaX7iyVSFSsHj3Ecygj9c/2Y7W5AD2+xVW7o7NIhr3UyflDgu
         eC7ybE8DsuLkSzDhDiGC3wSQQ9PZkhL4zVx4rAI7TJsR2Xh7tuFs4jw5H3qSTjzaS5dd
         0ILmqZDaMNAQ4f2g/aO7MLPLFmXjGMTVithk8Exv8g/kSnApV4ZIMX+UoP5pjW+1pHkm
         ZZEGC5riydTrXG4i8PRPUJXuvuyNhMGztS7nlYgvDYz0C/kpOonheOSF4wP7Vge29b2R
         ErS6UrusgmiiLHgeLUcwaDwAPLin12haS988ivIW592nf/qVaWBcSfTP3Q6J+0d/G99O
         tSAg==
X-Gm-Message-State: AOAM530MGPWpe7WrbQyjrHcPmFzVdDtkHIp81yCyaZKa4V47kNySNDB6
        HkWXf8jeolH4AW4Wk8/P1H5W2DTjAE1rjpcuMp+pcVIkxuyL3droUBTHvJChlnVA/mW1lT77pAK
        tRoH3ej1lvi5+WKGEkgGqOo9h
X-Received: by 2002:a17:906:7c4:: with SMTP id m4mr3296520ejc.18.1636582305169;
        Wed, 10 Nov 2021 14:11:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLz88n6UKYjf7wZF/H3sNtotK8uw0M0xcZxDFsafqJXUn8ocEGbvSuzUtOl88hBbWaqFBxng==
X-Received: by 2002:a17:906:7c4:: with SMTP id m4mr3296474ejc.18.1636582304923;
        Wed, 10 Nov 2021 14:11:44 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id cq23sm502989edb.92.2021.11.10.14.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 14:11:43 -0800 (PST)
Message-ID: <6f069301-f0c7-4eae-943b-3746a7350260@redhat.com>
Date:   Wed, 10 Nov 2021 23:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 1/5] x86/kvm: Add AMD SEV specific Hypercall3
Content-Language: en-US
To:     Steve Rutherford <srutherford@google.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "Kalra, Ashish" <Ashish.Kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "tobin@linux.ibm.com" <tobin@linux.ibm.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>
References: <YUixqL+SRVaVNF07@google.com>
 <20210921095838.GA17357@ashkalra_ubuntu_server> <YUnjEU+1icuihmbR@google.com>
 <YUnxa2gy4DzEI2uY@zn.tnic> <YUoDJxfNZgNjY8zh@google.com>
 <YUr5gCgNe7tT0U/+@zn.tnic> <20210922121008.GA18744@ashkalra_ubuntu_server>
 <YUs1ejsDB4W4wKGF@zn.tnic>
 <CABayD+eFeu1mWG-UGXC0QZuYu68B9wJNWJhjUo=HHgc_jsfBag@mail.gmail.com>
 <2213EC9B-E3EC-4F23-BC1A-B11DF6288EE3@amd.com> <YVRRsEgjID4CbbRS@zn.tnic>
 <CABayD+dM8OafXkw6_Af17uvthnNG+k3majitc3uGwsm+Lr8DAQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CABayD+dM8OafXkw6_Af17uvthnNG+k3majitc3uGwsm+Lr8DAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/21 20:38, Steve Rutherford wrote:
> arch/x86/kernel/kvm.c: In function ‘setup_efi_kvm_sev_migration’:
> arch/x86/kernel/kvm.c:563:7: error: implicit declaration of function ‘sev_active’; did you mean ‘cpu_active’? [-Werror=implicit-function-declaration]
>    563 |  if (!sev_active() ||
>        |       ^~~~~~~~~~
>        |       cpu_active
> cc1: some warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:277: arch/x86/kernel/kvm.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [scripts/Makefile.build:540: arch/x86/kernel] Error 2
> make: *** [Makefile:1868: arch/x86] Error 2
> make: *** Waiting for unfinished jobs....
> 
> but Paolo and I will figure out what to do - I'll likely have a separate
> branch out which he can merge and that sev_active() will need to be
> converted to
> 
>          if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))

Hi Boris,

can I just merge these patches via the KVM tree, since we're close to 
the end of the merge window and the cc_platform_has series has been merged?

Thanks,

Paolo

