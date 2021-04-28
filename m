Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4039736D601
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhD1K4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238554AbhD1K4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619607331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zvc3vNNxz45rt/LCFpFY8oVLaPcFw8dZ49me47+TJac=;
        b=W7oeGQVsliRMpYnvBKO7FLsJrNl5YyE65QRwah6bNho+IOfq7zgcPf4O1reu1a4uYwU/ff
        v5oQ4OU34oPhS7SJ/Qxu+3pZ3Vv3WtmDjjRzcfrdP0URETbFreGrAq608PgXS1Sf5Mki/Y
        4xHk6Kqqy5/L/tATKcuPRvuCwGmzI4k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-rVtjdF6TN-6by3H9PF598A-1; Wed, 28 Apr 2021 06:55:29 -0400
X-MC-Unique: rVtjdF6TN-6by3H9PF598A-1
Received: by mail-ej1-f70.google.com with SMTP id q21-20020a170906a095b029038718807866so3228069ejy.19
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 03:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zvc3vNNxz45rt/LCFpFY8oVLaPcFw8dZ49me47+TJac=;
        b=WEf2B8KnggruZl4AJKp4vThasSFfWmyL7gZUQ3aOoDkkj3xw8VUo93oe8GLSQWZQvv
         WRAUTQtn3pHhFlLeEwK57nhN16hh920BBjLN0ZCITiIhRvCgkGy0R8uu9a+5RHubBZaM
         GxD8ZXvwyINsUJVRJe0A2S3kIIy+RfLzzW2UJRddwuvAU0Cp2A70r/TPfLaNC0k8HPhn
         qLquo7Br4yUylik1yB6bfZIY7fHgxPNPY6mXpI9PgcxgDLyrur1ORei6nWrt7fbqKr2V
         v1iv3H5Rmaano2VDviXQ3ZvyUBiq55aTk9O1zY4h7peY3msjCQpdS7mQiUpJOMSEKXqx
         W/VA==
X-Gm-Message-State: AOAM5314FfQ7Bqf9IVqxFVBKawJBUFadUjYrpVGeD3XPy669Nku23ept
        NtfT+bJjwdLE1GVmLfAF2G3w2goiS/eCRy/YhL6iIiMpnhzDsvK7IhasAh36izxy4JeRGyncgqu
        B4v7HrE9n2EOBvoT32QPI79oy
X-Received: by 2002:a17:906:28d4:: with SMTP id p20mr28615882ejd.552.1619607328238;
        Wed, 28 Apr 2021 03:55:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYn7xonP1V7TNDer5HGzhc8B7Rjp3DtgnbvYRlOWZD2AOyvF3yrtc96WiL6D6v/Fl0D8tS6Q==
X-Received: by 2002:a17:906:28d4:: with SMTP id p20mr28615866ejd.552.1619607328048;
        Wed, 28 Apr 2021 03:55:28 -0700 (PDT)
Received: from [192.168.10.118] ([93.56.169.140])
        by smtp.gmail.com with ESMTPSA id k12sm4596828edo.50.2021.04.28.03.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 03:55:27 -0700 (PDT)
Subject: Re: [PATCH 3/3] x86/msr: Rename MSR_K8_SYSCFG to MSR_AMD64_SYSCFG
To:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, tglx@linutronix.de, jroedel@suse.de,
        thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20210427111636.1207-1-brijesh.singh@amd.com>
 <20210427111636.1207-4-brijesh.singh@amd.com> <YIk8c+/Vwf30Fh6G@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e687194-5b68-9b4c-bf7f-0914e656d08f@redhat.com>
Date:   Wed, 28 Apr 2021 12:55:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YIk8c+/Vwf30Fh6G@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/21 12:44, Borislav Petkov wrote:
> On Tue, Apr 27, 2021 at 06:16:36AM -0500, Brijesh Singh wrote:
>> The SYSCFG MSR continued being updated beyond the K8 family; drop the K8
>> name from it.
>>
>> Suggested-by: Borislav Petkov <bp@alien8.de>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
> 
> Thanks, looks good.
> 
>>   Documentation/virt/kvm/amd-memory-encryption.rst | 2 +-
>>   Documentation/x86/amd-memory-encryption.rst      | 6 +++---
>>   arch/x86/include/asm/msr-index.h                 | 6 +++---
>>   arch/x86/kernel/cpu/amd.c                        | 4 ++--
>>   arch/x86/kernel/cpu/mtrr/cleanup.c               | 2 +-
>>   arch/x86/kernel/cpu/mtrr/generic.c               | 4 ++--
>>   arch/x86/kernel/mmconf-fam10h_64.c               | 2 +-
>>   arch/x86/kvm/svm/svm.c                           | 4 ++--
>>   arch/x86/kvm/x86.c                               | 2 +-
> 
> The kvm side needs sync with Paolo on how to handle so that merge
> conflicts are minimized.
> 
> Paolo, thoughts?

There shouldn't be any conflicts right now, but perhaps it's easiest to 
merge the whole series for -rc2.

In any case,

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

