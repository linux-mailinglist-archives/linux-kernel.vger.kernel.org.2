Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0452C3FE9F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbhIBHXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243303AbhIBHXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630567334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=42sePlUoTEJ3Zl3ac3OCtw6kHqBXzy/OlkftRmelHeU=;
        b=COqkYvHiiR2GS4TujxwYeHrKUjz2QOVE8VdFCwzAaBLlx7KUBebvzL0xPnVKclW7N0Ml0H
        GDMk6wrv/J0roe8L3Qcj3Ur4oTOlidEZG6IPJJJtVP1VfbOL3bYRcgZfOr8ZvLKGujoJl2
        Xona3B63e7jVBZ5GdZ17BY3r9AdQuOg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-qP8ve_jQOt6BgFaU9Ug3sA-1; Thu, 02 Sep 2021 03:22:10 -0400
X-MC-Unique: qP8ve_jQOt6BgFaU9Ug3sA-1
Received: by mail-wr1-f70.google.com with SMTP id r11-20020a5d4e4b000000b001575c5ed4b4so231991wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 00:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=42sePlUoTEJ3Zl3ac3OCtw6kHqBXzy/OlkftRmelHeU=;
        b=DARv0dPssG6ppjRi+OnVWN5s3AusGX+rX5082u+YM6PSUxiNzatd/fsFMBirhSZAFD
         lsEB6ywr6P7AaiKsRCFCeOQfoUvedJtUsKfTe+ZcHvWeCpzNF6pLarsC/V51sBq8lhm8
         sj/i9wO5asLgoD3lIeGZQ204GdDVdOVMS8JMKhb/7W0PZGoIqMns1PoqeV81YrTC9B+E
         jQngiSFSY/VSNdM9YMVWmgQxrErV5YgNmpHX4cZ7ZtsRzHvO59QmAvbnOD8PhOhRwaZN
         +tqQSa41nJ3IwXK83tlOICQ4HGP8UttdcUfB7iA5SW6YtcGWD0WK2ibxasSBhy+BtUPI
         UASA==
X-Gm-Message-State: AOAM5316OU2DU9V8P27S7BfwcSL1qVBBX2BRAz3DY3xz08R+yTcmQdIR
        dY9BUVS+cXru1JMj8KfbWIg/mIMu3gmZbjfeh8dBWhIaWcGe4sCSI0N2+d6Nli+xhBpj0XNJiXv
        0W3d/yrUbU/Z6sjWdtz1orw8v
X-Received: by 2002:a05:600c:3b0e:: with SMTP id m14mr1627024wms.118.1630567329310;
        Thu, 02 Sep 2021 00:22:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCnxqjp/k4WCfBgiuxEZM5XZ8ZWr+a2MUH+SGtJOZiYwAZ8KfLSEAEhro9ry2pg6UuY5YSBA==
X-Received: by 2002:a05:600c:3b0e:: with SMTP id m14mr1627002wms.118.1630567329146;
        Thu, 02 Sep 2021 00:22:09 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60bd.dip0.t-ipconnect.de. [91.12.96.189])
        by smtp.gmail.com with ESMTPSA id c24sm972873wrb.57.2021.09.02.00.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 00:22:08 -0700 (PDT)
Subject: Re: [PATCH 3/5] mm: Drop first_index/last_index in zap_details
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
References: <20210901205622.6935-1-peterx@redhat.com>
 <20210901205622.6935-4-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <df28392f-faa3-5677-5e49-c56e297db578@redhat.com>
Date:   Thu, 2 Sep 2021 09:22:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901205622.6935-4-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.21 22:56, Peter Xu wrote:
> The first_index/last_index parameters in zap_details are actually only used in
> unmap_mapping_range_tree().  At the meantime, this function is only called by
> unmap_mapping_pages() once.  Instead of passing these two variables through the
> whole stack of page zapping code, remove them from zap_details and let them
> simply be parameters of unmap_mapping_range_tree(), which is inlined.
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Looks good, thanks

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

