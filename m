Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84DC3588D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhDHPsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:48:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231655AbhDHPsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617896904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Ez81rKbVxY5HMvJiqp7/KQr7CIYn4JH0OZcXlzdxz0=;
        b=ZQ3RTuqDJRmgRCthRmAobY+ONheq/5iHv56w2H8+5kr8mfRpYz2Ikc4j+atTOUbCjtplTS
        EMvNyOj6z2Hq+vzuQG1PBMFm7EGq6AKEc3/W/V9K1Y01AJYtOk0SpVkk8hzCDYTy0/2crD
        X6WS9Fxo+bhqqt8euj2bC8RESgjYa4Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-waqpHCSzO1-A5NvnUMZr8A-1; Thu, 08 Apr 2021 11:48:22 -0400
X-MC-Unique: waqpHCSzO1-A5NvnUMZr8A-1
Received: by mail-ed1-f72.google.com with SMTP id b8so1242039ede.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 08:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Ez81rKbVxY5HMvJiqp7/KQr7CIYn4JH0OZcXlzdxz0=;
        b=AD8aj0XcmxJSWQFymVhpt2gNbi6xanGnGcsvlMNakDWcchj9iCBbUtg6qictWKK9hu
         IMFpNm9lMmWpybgf+6xIKtXDEmWhJ5P8NHXWIxY+YBmzRYcUmYeK4ryByxnNGhOA78lE
         w1C3eENJdVYTPHprHFWg5fCR/QWpg28Z9CyQMOg9VBhPxqPEDry5nYykphWkY2fitCky
         QWPKElL4WvDBv03RSHeckOyszlXKN3+iZGuvfsL340iB1OIGfP51ByMD7TNevmMnJBc7
         2j/F9yxcAV0zn0ygeu9d//5lB1IcIJYvSgdos7WifEBf2Rj26DCk6ojNmcPV2hPLwRiU
         zBmQ==
X-Gm-Message-State: AOAM532173FA4Zd2eknMmXcdO1Jztg4CIaWaMMOyhfvA+dse8H3KJYnY
        GSr1BGS6YaQhUsX3jpqy45MOVMmeMWmLucrMhgAacLZ8Ja6PDdNHCGp9WykNwB/p/9pXZzdFwiV
        WCWs9gWpBrg99eKtW1UlMOGd+
X-Received: by 2002:a17:906:54e:: with SMTP id k14mr9587113eja.149.1617896901527;
        Thu, 08 Apr 2021 08:48:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXnmeOmLWAVA7akg2Cat3k5vhWt6/ezjq/k2VexhGZEjihjCFyuBbYjICxCCEFeuMNMKh3nQ==
X-Received: by 2002:a17:906:54e:: with SMTP id k14mr9587084eja.149.1617896901394;
        Thu, 08 Apr 2021 08:48:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id o17sm10489411edt.10.2021.04.08.08.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 08:48:20 -0700 (PDT)
Subject: Re: [PATCH 0/4] Add support for XMM fast hypercalls
To:     Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, graf@amazon.com,
        eyakovl@amazon.de, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210407212926.3016-1-sidcha@amazon.de>
 <20210408152817.k4d4hjdqu7hsjllo@liuwe-devbox-debian-v2>
 <033e7d77-d640-2c12-4918-da6b5b7f4e21@redhat.com>
 <20210408154006.GA32315@u366d62d47e3651.ant.amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53200f24-bd57-1509-aee2-0723aa8a3f6f@redhat.com>
Date:   Thu, 8 Apr 2021 17:48:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210408154006.GA32315@u366d62d47e3651.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/21 17:40, Siddharth Chandrasekaran wrote:
>>>> Although the Hyper-v TLFS mentions that a guest cannot use this feature
>>>> unless the hypervisor advertises support for it, some hypercalls which
>>>> we plan on upstreaming in future uses them anyway.
>>> No, please don't do this. Check the feature bit(s) before you issue
>>> hypercalls which rely on the extended interface.
>> Perhaps Siddharth should clarify this, but I read it as Hyper-V being
>> buggy and using XMM arguments unconditionally.
> The guest is at fault here as it expects Hyper-V to consume arguments
> from XMM registers for certain hypercalls (that we are working) even if
> we didn't expose the feature via CPUID bits.

What guest is that?

Paolo

