Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE39E44F23B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 09:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbhKMI5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 03:57:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58339 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232925AbhKMI5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 03:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636793682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+z8rYoU9QD9VNjpmLDDx7zDmor9Ob3HEVQtqnctyQ0=;
        b=ctUy2ikKIQxXd9LRS1X3ITcARjT8NjtoPNpRIDg/fQxIBIH6DEb7cUTN+MTZOiW8aNhk3T
        15QOoJFfBrFQfEYqjuv+2D42YL0e6GGU5pbJydFUH0//ob0XbPqIfJrUyoofYbAJGwiy/L
        GNt5GOo2ffaxm5vSpUgi2wj+QUdcvk8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-9x7F99nPOlaj0Yg28QWuYQ-1; Sat, 13 Nov 2021 03:54:39 -0500
X-MC-Unique: 9x7F99nPOlaj0Yg28QWuYQ-1
Received: by mail-wm1-f71.google.com with SMTP id 67-20020a1c0046000000b0032cd88916e5so5395544wma.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 00:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=d+z8rYoU9QD9VNjpmLDDx7zDmor9Ob3HEVQtqnctyQ0=;
        b=C/VmdmoDeS70E6WL4Jj9vk8BNdEm3cAJnSRA4EhMcsnHO+L+Kczonc46qQlAFDqViq
         P4XHhY1OeVdK/yuE3AtYNMcT22yQ4c3+K2VyYhibieOuTccosLNVaKDH+PM/wJq3Ss+o
         +H7LFrJ0ItjsPte3GXVLPozX7GoVYPsFWoh7gerkRe09QzLJv9+oKjm+r+kl4pZS6HXW
         WUE3bGFcrr3HAzabDqYhb9aT8TWtYSObtL8gn5RGH+N8+03+Gim77aRG+qaf53/PDzRp
         yxKylkO++NGJXOdle6gE3XoeAT/Lgdcr0a1/TB+lhCW2pEiL/UfSd5+rBeHaM0/zQmKE
         Fl3A==
X-Gm-Message-State: AOAM533kMsH1CeZFO39GmTcX6qBdHNFfDQc7YsBvCpZ8mDR2TCI2j3y+
        5PTYjNk/4GkoKDj4mv1UiJKy3liF6KvXqVH/dwCVB9eOfFtLJeTAodq/SFUjZLfuXUvV37C3q4C
        2lp3j6CiUzfVFeKMwhUXCujc3uOiFHymzL9iT7g+aHi4uJkGvPuX3TZyxOM3q6xZoA8K6MLJ9
X-Received: by 2002:a7b:ce0f:: with SMTP id m15mr23578929wmc.149.1636793677268;
        Sat, 13 Nov 2021 00:54:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykr6DLfv2aEzX3pfP8GsAedXQIQu2gXW2KdaV5PSZIQXS0yxFm3EOuj5Mw74jyDyTlm5cfeA==
X-Received: by 2002:a7b:ce0f:: with SMTP id m15mr23578895wmc.149.1636793677003;
        Sat, 13 Nov 2021 00:54:37 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6cef.dip0.t-ipconnect.de. [91.12.108.239])
        by smtp.gmail.com with ESMTPSA id j40sm8990732wms.16.2021.11.13.00.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 00:54:36 -0800 (PST)
Message-ID: <6f677edc-6c81-199a-0bc6-25117fa4b34e@redhat.com>
Date:   Sat, 13 Nov 2021 09:54:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [GIT PULL] virtio-mem changes for v5.16
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        "Michael S . Tsirkin" <mst@redhat.com>
References: <20211110163754.27528-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211110163754.27528-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.11.21 17:37, David Hildenbrand wrote:
> Hi Linus,
> 
> usually this would have went via the vhost tree, but as this patch depends
> on some patches that just went in via Andrews tree and MST doesn't have
> any other patches for this merge window, I'm sending it myself
> and base it on current mainline that contains the relevant commits
> already. Thanks!
> 

This is most probably at the end of the PULL queue, just a heads up that
it would be really nice to have this in v5.16. Thanks!


-- 
Thanks,

David / dhildenb

