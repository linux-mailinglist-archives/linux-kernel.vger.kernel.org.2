Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA03B481E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFYRWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 13:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229630AbhFYRWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 13:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624641615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUgH0GOkQfIIk3JfpZs9t9DVg0sOfkCdzi/tS1XtQpQ=;
        b=Tw+HM0l/etauloLsZlCIx4PFPVj8C/IfNHy8WgaXZzNpaNkvuLMwVqcIGK6YumCcUqkU3b
        mw2y0iSCgKrSXKwmpWBhiny8jqPlZeiAzreWHDZELPvsAFyAMp9BZCh70Z6jTV3e2wlzbj
        cISM/5TbemAuyprv92OSXzf/s6JQxNs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-BT3GVNzSMTy5kvRiFmr7ng-1; Fri, 25 Jun 2021 13:20:14 -0400
X-MC-Unique: BT3GVNzSMTy5kvRiFmr7ng-1
Received: by mail-ej1-f71.google.com with SMTP id lt4-20020a170906fa84b0290481535542e3so3363209ejb.18
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 10:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tUgH0GOkQfIIk3JfpZs9t9DVg0sOfkCdzi/tS1XtQpQ=;
        b=BrG0cK2iZbaYJfCFtxL1Nx2w1tlDQ8UmpPdHxPo7tAhYU9hE4cWljm8VHZkPumIafX
         i09/OtyWFe7EYleVXQs7sk3lIL2temYuzgjrngsogFiOOCdh2f+DHJU2L2Kbh1CEfblG
         cG2Aql+GjPJj0yU6TcKnjTogYRC2D93No7tuKd5qxuXKLp6yuRsIiVeRLsICYTXQge6y
         NtJwrjVQyN49e5xrPt4lnKBB0iSBdg5Mr9NdFQkE7FXqcJUe6L1jvTZN5Es2PggDA3Ua
         rPvHsDhFWL6Z8hb0lrZVilMw0ljdxxn8MvXmjLnw8Ws729oWu5Dqp4MXSUcw5Zgl6vBy
         u2gg==
X-Gm-Message-State: AOAM532UBh7rbK+sFAYSXhGxkChdAxG6XiOjSlzPpdLAU6Ion/3sXq/k
        Zo/sw77i521R6VrfLqnputMA93Q5w6e8aVnHTqu0BUg+HaZvtDTX5XHuUD/g5p+aCNUpv5tavRB
        boQISXw2lqVEcq6v1QoREY+wevnBbNnyzwvvak/fUfne9SubZxUzDjL+MB5XoSBYc8dg6gIeZi/
        l5
X-Received: by 2002:a05:6402:27ce:: with SMTP id c14mr16022013ede.118.1624641612731;
        Fri, 25 Jun 2021 10:20:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZalEKvLpoVAX6L+WYwpJ7UlqlSdKIkSiS8ytC1UpZNEtc3ss1rUo/OpRV/BL2iZeVSDq3nA==
X-Received: by 2002:a05:6402:27ce:: with SMTP id c14mr16021990ede.118.1624641612560;
        Fri, 25 Jun 2021 10:20:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w10sm4294282edv.34.2021.06.25.10.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 10:20:12 -0700 (PDT)
Subject: Re: Question regarding the TODO in virt/kvm/kvm_main.c:226
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <HCVNTQ.0UPDP6HCEHBP3@effective-light.com>
 <2ZR8VQ.IJMS3PQLNFAS3@effective-light.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f9d355f-cfd1-d85c-b186-27e7ac573ad9@redhat.com>
Date:   Fri, 25 Jun 2021 19:20:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2ZR8VQ.IJMS3PQLNFAS3@effective-light.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/21 07:16, Hamza Mahfooz wrote:
> ping
> 
> On Tue, May 25 2021 at 07:45:53 AM -0400, Hamza Mahfooz 
> <someguy@effective-light.com> wrote:
>> Would it be preferable to remove kvm_arch_vcpu_should_kick or
>> kvm_request_needs_ipi when merging them. I ask since, the last time I
>> checked, both functions are only used in kvm_main.c on Linus's tree.

I think none, the logic have changed enough that the TODO is obsolete.

Paolo

