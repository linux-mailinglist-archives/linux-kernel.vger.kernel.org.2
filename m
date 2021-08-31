Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D672A3FCA64
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbhHaOyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237512AbhHaOya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630421614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6VDF51hxbfpaWMVUumQtD4q9C2aOAsvQD3/LfZAqP4M=;
        b=IAB4wrN81/1x03eEc3o6hVfdnVinEDlD/P28GEZVajAy6EaVwuMqyp8iIHOBE9iu4qu1QB
        XdP3yYMcYm2FmzI+98Kxpj/E2cGUW/flb9clqWJA9tFbsTL5RAEfNymMeyJLfE2tBMtMzw
        zEQPC5iYiB0IOxGH9VfA/xK53lko7Io=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337--Huv94v8MHuvhrLJ3XR8Ew-1; Tue, 31 Aug 2021 10:53:33 -0400
X-MC-Unique: -Huv94v8MHuvhrLJ3XR8Ew-1
Received: by mail-wm1-f69.google.com with SMTP id f19-20020a1c1f13000000b002e6bd83c344so1433022wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6VDF51hxbfpaWMVUumQtD4q9C2aOAsvQD3/LfZAqP4M=;
        b=NYBND1v8LCuecZtWrdUcx1HloaOqQMJ2su9G5qeI1BFsbzIBufJNtqEbBfMEaETclg
         S72omlJu+tgqs+1vpMxYu0yKo83wTuFf3xtiwfJDXyjv49MSNwhNnHwkcJDhuGffMvzI
         vTOcOOs2rJL2fvQh5gVbyoj6DWW5DiK6dI2OfkhdiYU6Ul9JQnlCXr7/zAQIKyB30zwI
         ZnQLA+XyBJMa+bwHfdLbMpoywzwxAPfaOcvT4+DzQ3jGKDd+G96odnHhm6AThHneCr4k
         IHoWXVV6VZ+JEcloVxMm1qhWLsKqO9HofbGQOax4Ot+WSPZVzHduEdmnLHY+1QnjLq17
         dAMg==
X-Gm-Message-State: AOAM531+8nFtKrvMAWBiXCNQiYT/yLWiONIKexoGo735jwILEynhx8Y3
        pzR/6RM9Rq7tj/d4yGVJu+GWF0OlO/a/NCEkF/pSAU6+VFpDBTtrHrNF+dW3jp1hpov+EpAn5an
        AR7svl3SbMRJmhQYVIgBy5YA6
X-Received: by 2002:a05:600c:acd:: with SMTP id c13mr4662697wmr.28.1630421612335;
        Tue, 31 Aug 2021 07:53:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZpt4uPbrs+nBeQjdBZh+eSaDaqLcdwE8DpAhzNPYPYTbfR/TjMmmGpI29u6Qa4UQlZ2PqaQ==
X-Received: by 2002:a05:600c:acd:: with SMTP id c13mr4662677wmr.28.1630421612150;
        Tue, 31 Aug 2021 07:53:32 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bf5.dip0.t-ipconnect.de. [79.242.59.245])
        by smtp.gmail.com with ESMTPSA id l21sm2638372wmh.31.2021.08.31.07.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 07:53:31 -0700 (PDT)
Subject: Re: [RFC][PATCH] mm/page_isolation: tracing: trace all
 test_pages_isolated failures
To:     "George G. Davis" <george_davis@mentor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        "George G. Davis" <davis.george@siemens.com>
References: <20210823202823.13765-1-george_davis@mentor.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <4f680b5a-9076-3ba4-caea-bdd6eafeb899@redhat.com>
Date:   Tue, 31 Aug 2021 16:53:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823202823.13765-1-george_davis@mentor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.21 22:28, George G. Davis wrote:
> From: "George G. Davis" <davis.george@siemens.com>
> 
> Some test_pages_isolated failure conditions don't include trace points.
> For debugging issues caused by "pinned" pages, make sure to trace all
> calls whether they succeed or fail. In this case, a failure case did not
> result in a trace point. So add the missing failure case in
> test_pages_isolated traces.

In which setups did you actually run into these cases?


-- 
Thanks,

David / dhildenb

