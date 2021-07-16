Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EB53CB7B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbhGPNNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238560AbhGPNNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626441040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfHUY15Uy1dIWD5x+FWk01V2UPIrzIHLqJFcxENTfHs=;
        b=LiA8O86DiMjg39p5DtkOfM5NdZZWeUnsxjsn86/9FSP53rMMu3H0+roFUy1RXc37aaIMJp
        OvmyOlfwcnKe/DCIZ47qVtvZ7jyo7ud+6NDg7InPq/MgA4FZHed6XfsJIwDAdM7wTv33qi
        NJBKMdThfwdpzotsdv8f3s/1o5mNWj8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-5JFyxzB7MvKxcG8nwc8OWg-1; Fri, 16 Jul 2021 09:10:38 -0400
X-MC-Unique: 5JFyxzB7MvKxcG8nwc8OWg-1
Received: by mail-wm1-f70.google.com with SMTP id p9-20020a7bcc890000b02902190142995dso2353062wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mfHUY15Uy1dIWD5x+FWk01V2UPIrzIHLqJFcxENTfHs=;
        b=pI5vBvmG5080wDTH8i4zOpwQv06wkJ9uinz2RToQhEA5jpjzdBjwzXoAEw9f5COASv
         rfOoQxZ9ufIOOW7C67KCiUxn9EUHxedbwlm74V2ZkHKMfQxxkWk9OtyKwv5hgPRXHsTd
         bE08+Bs+n3TwucT3G6txz+JcYmAW8waYXSrdc5m43dMUpMpU3frYGGqFCEnZF+Bx5K0G
         l0BDxmhIVaY6tD4xqCT4GopQcecLziV7bhivkALdJOBHMf33Y5UtIIyaVN5B24H8RTIJ
         nNaRDGNT0sc+MndWaJ+x8PFbTAeo0MlrGgTlmcdhH/E2315BPFfRiOZXImPHsChhMP5f
         SDyw==
X-Gm-Message-State: AOAM533EXGtM2KZEBJDleabTfqmloh1XTeq5lK5t5MkGkCnRWCZ8ydut
        cTqnpXnZY2SM7VcTM8xWEjQjBhy7JdZB/MaSpD3PbI5PJXBcziocMNqSdOQd+YuyO1LshS+9yfS
        kJECBoQ3HwZP25ZyO1KSIWQ7F9gxEA5JV/4+TVjlp9reFDAKCbz+fZpCZgOApme1bqhalLYJl
X-Received: by 2002:a5d:5286:: with SMTP id c6mr12176236wrv.75.1626441037758;
        Fri, 16 Jul 2021 06:10:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQow3phVBvU1Ndrlr2yK7XIXEgJZXo6n2/PrXt/Z+O6qejNxABtVTM2Ro0p1O0JTSxEdpmTA==
X-Received: by 2002:a5d:5286:: with SMTP id c6mr12176214wrv.75.1626441037529;
        Fri, 16 Jul 2021 06:10:37 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c621f.dip0.t-ipconnect.de. [91.12.98.31])
        by smtp.gmail.com with ESMTPSA id m18sm7776641wmq.45.2021.07.16.06.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 06:10:37 -0700 (PDT)
Subject: Re: [PATCH] virtio-balloon: Use virtio_find_vqs() helper
From:   David Hildenbrand <david@redhat.com>
To:     tianxianting <xianting.tian@linux.alibaba.com>,
        Xianting Tian <xianting_tian@126.com>, mst@redhat.com,
        jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1626190724-7942-1-git-send-email-xianting_tian@126.com>
 <bbe52a89-c7ea-c155-6226-0397f223cd80@linux.alibaba.com>
 <95d7f688-79fc-05dc-87ca-da46e0179f0e@redhat.com>
Organization: Red Hat
Message-ID: <58096b5a-8acb-a88f-c2c6-cd6e3201407f@redhat.com>
Date:   Fri, 16 Jul 2021 15:10:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <95d7f688-79fc-05dc-87ca-da46e0179f0e@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.07.21 14:53, David Hildenbrand wrote:
> On 16.07.21 14:46, tianxianting wrote:
>> Do you interest in this patch? just little improvment:)
> 
> I am, especially when I'm cc'ed and aware of it ;)
> 

Sorry, just found it in my gmail spam folder ... WTH. Why does the 
original one get filtered but not your ping ...

-- 
Thanks,

David / dhildenb

