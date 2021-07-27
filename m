Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AFA3D7E03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhG0Svc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229453AbhG0Svb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627411890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZXvxEfiOuEcK4kkcEfzYdMbGqWYAa1VJ44J5+cysLMY=;
        b=W1h4FToaI5lfGS7U1j/kVUUlGkuhCIHMJjJWEk28BD7aEwqZ8RsxK6x7rkQbs0PEHdGXBP
        BHTjqcXvQBcGBstqo6DmSPyjtm2QxAzAzn/ZdqVTG9lxU9G8R9UTYcaUk4nzgkVDndb4LV
        8zztCUBrIRXtz14xA9nIk9QM7OrxfvI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-tkw_vtdyNLKyvBF11nXpnA-1; Tue, 27 Jul 2021 14:51:29 -0400
X-MC-Unique: tkw_vtdyNLKyvBF11nXpnA-1
Received: by mail-ed1-f70.google.com with SMTP id n24-20020aa7c7980000b02903bb4e1d45aaso5363882eds.15
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 11:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZXvxEfiOuEcK4kkcEfzYdMbGqWYAa1VJ44J5+cysLMY=;
        b=RxheoajzRyqNka/HJNDvSiNHif65iQCLFvLeqFC7iNBO32Q4SQQA/BInT/HmIlKCHp
         h8vYtpUQqjiq2LKWfArUssGcNtjKUobYMB/pfur9R+/84ULtGDgEzFcrRnXhpaO2x4Xj
         s2I8Yf4ylJNQvyBB/AMxEOBOj7Tr0mknDjeGX3F1Tm0rJrwxgk3l5M+qRJrvY+INypBt
         QNSA4HQ9HWFYcXqkClLZhD4WS8Avyf/D5ihqRpYm34cm9z8uCMasX9dAgmiISDmLBvAu
         lu6dGaegwb5ncDfsUPOK24CtQk8ElO3CdJSYIt48caKhPCUfSCTJ1BeNRhED8YmzAW9s
         iKzg==
X-Gm-Message-State: AOAM533PbUJxOCFM0DAlOzgGnuJjCQjOXYd77OgvT36mMzefMNrXUw8k
        kbh90uEQYKxWPR6xnGXI5zK1YQ1Aj95vWHuIays5wfAEH2XuaGo9CbzPd2JcLvsKiT48+KmAScp
        USm9IgoThwrHaHY48zhGXlA2+
X-Received: by 2002:a17:906:1cd5:: with SMTP id i21mr23045054ejh.478.1627411888154;
        Tue, 27 Jul 2021 11:51:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrk624GQKYRMpqA97Vdd8DklXkZv+JcJB91YbBrHkNbOCJGWvnyPIpkfnsSKV8Lv8r6OqfEA==
X-Received: by 2002:a17:906:1cd5:: with SMTP id i21mr23045041ejh.478.1627411887939;
        Tue, 27 Jul 2021 11:51:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id j5sm1573908edv.10.2021.07.27.11.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 11:51:27 -0700 (PDT)
Subject: Re: lib/x86_64/handlers.S:20: Error: unrecognized instruction `call
 route_exception'
To:     Sean Christopherson <seanjc@google.com>,
        kernel test robot <lkp@intel.com>
Cc:     Aaron Lewis <aaronlewis@google.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>
References: <202107270520.DIJjv4ia-lkp@intel.com>
 <YQAvVGwJqUak1E0l@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <65701bf2-e980-6cf7-8263-5eed7ba338ac@redhat.com>
Date:   Tue, 27 Jul 2021 20:51:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQAvVGwJqUak1E0l@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/21 18:07, Sean Christopherson wrote:
> On Tue, Jul 27, 2021, kernel test robot wrote:
>> Hi Aaron,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   ff1176468d368232b684f75e82563369208bc371
>> commit: 29faeb9632012d6c3fa4aa33c3d589b9ff18b206 selftests: kvm: Add exception handling to selftests
>> date:   9 months ago
>> config: openrisc-randconfig-s031-20210726 (attached as .config)
>> compiler: or1k-linux-gcc (GCC) 10.3.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.3-341-g8af24329-dirty
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29faeb9632012d6c3fa4aa33c3d589b9ff18b206
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 29faeb9632012d6c3fa4aa33c3d589b9ff18b206
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1
>>          CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc
>>          SHELL=/bin/bash -C tools/testing/selftests install
> 
> KVM's selftests don't play nice with cross-compiles for unsupported architectures.
> arm64 and s390 have expilict x86_64 -> {arm64,s390} support from commit 66d69e081b52
> ("selftests: fix kvm relocatable native/cross builds and installs"), but for
> anything else the Makefile assumes an x86_64 target.
> 
> Realistically, only test bots are going to run afoul of our laziness.  Do we care
> enough to fix this up properly?

Seems easy enough, I will give it a shot.

Paolo

