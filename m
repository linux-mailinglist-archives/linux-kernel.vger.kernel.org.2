Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034E13791FB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhEJPGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232884AbhEJPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620658931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SSKCNUzKlt6unZPOx+lQtXRtPyOSSWMLCTpTg7CYZ1k=;
        b=Eou4kYhQ2fCL7u5Dd6gckeooRgfWXtPOZ70Ql9LsHRvi/z/Jm1cKyDl7b6in5473n/lPaG
        5fIFzcNq3vqib7MerFOouJkTEL29Yrqj+dSHQCJTssYSHXHugUELRq04/VeMr5VpFApo2e
        8VlTAGTo6hKD6AlJbl7sfGMSfkfOPOs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-GLnrhFI0MKafyJ0q7ZeDuQ-1; Mon, 10 May 2021 11:01:57 -0400
X-MC-Unique: GLnrhFI0MKafyJ0q7ZeDuQ-1
Received: by mail-ed1-f71.google.com with SMTP id g17-20020aa7dd910000b029038843570b67so9204552edv.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 08:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SSKCNUzKlt6unZPOx+lQtXRtPyOSSWMLCTpTg7CYZ1k=;
        b=JG27unVMyfib28bbX4vm9OwyYK9wXnSLdkVEGIP2/owy3RGWpfcV0SXz+gav59M+G7
         zVXfOAxu0b0K+OEtkiju43Ot464b4JhxfKrZfBW72Zv3Ziv9FDsxK6OiKCObGps9SDQa
         pNhjaVQbkGnOm3ra3jgeR5s6bf7wRpWSd6MtmJ6Aufah7KGgPZbIDOYfJ9DcFrQuV5iT
         e/iWo7ewxqZtxx+dfMLXtEyVw2/1NcDhC6ql/aatu7/pIgClUzakywFZnlEdqAWXlTeE
         DR9Q3Hx0x609pC67ml7lpxrmRvAwVn7EGpdkT6D1JYgIQSHOF0APvQa7iMpM1Ic5CWB1
         6+zA==
X-Gm-Message-State: AOAM533NkOUzVrGMBG+c3N5OvD239wRgBeDtBWCFlpd54RIk5cYCI/24
        i3eGVw6QiT2wbnuQAWc97lmjJ8+B/bxtPSLCeosisjK5eBLnyWosuJSwsz3NHEulUrHOWbFK3Dl
        24HbUHeEgYRu5sTkeX1welPRj
X-Received: by 2002:aa7:d543:: with SMTP id u3mr30341601edr.26.1620658916515;
        Mon, 10 May 2021 08:01:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJya0NVvJRL8eIfk38seIDjzRl8n8clFqG9PALQkjgv7k4fH6d0K8YCGPu2CNevpmq4Bj4ldAA==
X-Received: by 2002:aa7:d543:: with SMTP id u3mr30341573edr.26.1620658916200;
        Mon, 10 May 2021 08:01:56 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676a.dip0.t-ipconnect.de. [91.12.103.106])
        by smtp.gmail.com with ESMTPSA id k9sm9798954eje.102.2021.05.10.08.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 08:01:55 -0700 (PDT)
Subject: Re: Profiling execution time for __alloc_pages_nodemask
To:     Shivank Garg <shivankgarg98@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        sergey.senozhatsky@gmail.com, pmladek@suse.com
References: <CAOVCmzGX54u4VLUSLt_yEM4E8MQNLwW4VTkNVurPXbCuQX6d_g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <03693c3f-e95e-d0a7-d7de-f2cda92ba6ea@redhat.com>
Date:   Mon, 10 May 2021 17:01:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAOVCmzGX54u4VLUSLt_yEM4E8MQNLwW4VTkNVurPXbCuQX6d_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.21 16:57, Shivank Garg wrote:
> Hi Everyone!
> 
> I want to profile the time taken to execute the __alloc_pages_nodemask
> for different linux configurations/parameters.
> To measure the execution time, I use the ktime_get() apis. I get the
> ktime_get() on the top, and I want to do ktime_sub(ktime_get(),ktime)
> and record it in a tracepoint.

Don't tracepoints already record a timestamp? It's bee a while since I 
worked with tracepoints ...

> However, the patch on implementation prevents the kernel from booting
> up. I debugged the bug to find out that the issue recurs on adding
> ktime_get() inside the __alloc_pages_nodemask path. So, that the
> kernel fails to boot up ( and show the blank screen without any logs )
> I'm using the Linux kernel 5.6.13 (5821a5593fa9f28eb6fcc95c35d00454d9bb8624)

Are you maybe calling ktime_get() too early during boot, where some 
subsystems are just about to be brought up?

> 
> Is it an expected behavior? or a BUG? Has anyone else faced the same issue?
> 
> Can you please suggest, what would be a good way to measure execution
> time for page allocation (if not ktime_get)

I could have sworn ordinary tracepoints would already give you a 
timestamp ...

-- 
Thanks,

David / dhildenb

