Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B349F4161A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241860AbhIWPEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241857AbhIWPEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632409363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qE7GPIib/TqcHJElLW3kWkqMJdaFGTm64XdSZ6wstWA=;
        b=glXURLarzC8Drjte2AuKkFyQCM7aI/p9DdkqNi+31RvSlYZLbKXK/BMkh9FMwC7LVJ6cVA
        Smbb5XZjid+uqldAQkaEYjyREV7mIYB9SXerMmqXzBZys8mG4QEMASsadz5QyMqs4Kvoxb
        IdpZrLgPwPo8oohu6fBfMp7J8yk8BqQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-qHDEH-6tO0Oz3A-_TbYY9w-1; Thu, 23 Sep 2021 11:02:41 -0400
X-MC-Unique: qHDEH-6tO0Oz3A-_TbYY9w-1
Received: by mail-wr1-f71.google.com with SMTP id v1-20020adfc401000000b0015e11f71e65so5411704wrf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qE7GPIib/TqcHJElLW3kWkqMJdaFGTm64XdSZ6wstWA=;
        b=VYXYsr96d1In2Dt/F39vvE38tI6jY0EloVGly5iituWU67E53h0lFW/9gcaygkrgVg
         r1xn1/ZEjD/Eb1cn7KwgN7nl5atDdkk+y39fK0jg10RIdsH4vO8uIfumD0ugdd9fIYk8
         /jrMXMczO0IXIiOqNCZoJqNPuFZD+Y6xW/H9xqCGUXMkppltiIXBqOoj9/yXu3aIK30A
         Okjws4h+X7edFvb8hrhUtfgfLm+4f89wTX7rYL5BhClzxHDIDbR5TtiVgNkrPXjKJfe5
         CBD9E994IUgAAVIk6cJLdpPu0oN2XoQyBlNr5VycQPcFZAC3hIVSArQQZaECdM0TYsf4
         i5Xw==
X-Gm-Message-State: AOAM5326QH3q7FBB9QZgqMp0uZ9OaqO0MmP7YLeozXUMg8G5oYJrHKoK
        7mJ7puS3ep+A5V68N/R1RZLKYmRmiccIG5rb80Aj9WbGdVN3SBARYe6mVj1ogCalBv8r//yNGen
        PANM9KPLFZkafpu0Je3Rv7Ywy
X-Received: by 2002:adf:f486:: with SMTP id l6mr5459846wro.375.1632409360605;
        Thu, 23 Sep 2021 08:02:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDwLhjkh5ZedG+e3pcJGq/4nK2a2JFYq0D12EfWetqicmJHnbNHybTwy4aGdzuU+6HwkDwHw==
X-Received: by 2002:adf:f486:: with SMTP id l6mr5459825wro.375.1632409360406;
        Thu, 23 Sep 2021 08:02:40 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e5d.dip0.t-ipconnect.de. [79.242.62.93])
        by smtp.gmail.com with ESMTPSA id m2sm9390537wmm.3.2021.09.23.08.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 08:02:40 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] Documentation: update pagemap with shmem
 exceptions
To:     Peter Xu <peterx@redhat.com>,
        Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        jonathan.davies@nutanix.com, chris.riches@nutanix.com
References: <20210923064618.157046-1-tiberiu.georgescu@nutanix.com>
 <20210923064618.157046-2-tiberiu.georgescu@nutanix.com>
 <YUyWganKYoWOF1ns@t490s>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <46e8e621-fb0c-9868-3b17-9ebe9c616c0b@redhat.com>
Date:   Thu, 23 Sep 2021 17:02:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUyWganKYoWOF1ns@t490s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.21 17:00, Peter Xu wrote:
> On Thu, Sep 23, 2021 at 06:46:18AM +0000, Tiberiu A Georgescu wrote:
>> Mentioning the current missing information in the pagemap and alternatives
>> on how to retrieve it, in case someone stumbles upon unexpected behaviour.
>>
>> Signed-off-by: Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
>> Reviewed-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
>> Reviewed-by: Florian Schmidt <florian.schmidt@nutanix.com>
>> Reviewed-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
>> Reviewed-by: Jonathan Davies <jonathan.davies@nutanix.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

LGTM as well; I like that we only give hints instead of listing steps to 
perform as in the previous version.

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

