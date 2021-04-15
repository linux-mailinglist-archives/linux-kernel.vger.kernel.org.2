Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE73609A1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhDOMmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbhDOMma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618490527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zACdA77WTa2D+EH6NmqEJg1JcWkY/0DDkKu1lgaix30=;
        b=O5l2PiE+R+uEMg5W7Lmi+vk99F9WdWAmXJ89wMzyHOeaQMz806866z7KjcViwsnv226ZSh
        1Ml/QdzTkxM6oMD7Xww/B9fIUT6kBecXq1bfxbsnbXGhoprrSYziu1jJclAuBUXORx+doc
        Ete7Vej5azYKy+PXCF4RqoP1jgnc5is=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-UcS9PgqlOUyfRZkEoV95mw-1; Thu, 15 Apr 2021 08:42:05 -0400
X-MC-Unique: UcS9PgqlOUyfRZkEoV95mw-1
Received: by mail-wm1-f71.google.com with SMTP id f134-20020a1c1f8c0000b029012e03286b7bso775772wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zACdA77WTa2D+EH6NmqEJg1JcWkY/0DDkKu1lgaix30=;
        b=Pop6up+CISi9MKNBaa2qQCGlwXysIlMHiUxjDZzpomS+i/GzX5/ZjqZbfjAP6Y5mtm
         LTqq8SeEdQRl08aSzIpoNH6n11TzU0kQxRQt4+N+Fk5SToRzXTeqdQOtIWqQgM4Reubo
         7VNhEH7r0v5o1tGKmNf7R0byDjIIW/NKUm2QGjwQGsQorzQU7O0UJiJAEAlw+BRhrckc
         L1V474BUslaMXCcRHZPfZNfNHvb5+HIPPTx+sL86/BoUluUHlODw+PlzOb1DymkpnRX6
         xZ+YmVRC3SzQjxBHXpZCufGcMt9EEKE8/jMctgIMDl8QJYET/oicLIXfWzRFrQaKcVaC
         4sYA==
X-Gm-Message-State: AOAM5324MR+q98KdSZyFwoJR6a6MyFWQMiUowQIMF3hapbULEceNQbIf
        +9D9anNHgnN/T7EdQss4GKj7Tl3u/sCBdKjMbQQFhlCJi6rgIhwh58JziR1Z0KLbVB1T7hQaC5y
        dhNX7+tziYLgDZ0BgMoFx2D/xZH6E9kSSMlVwesLFmYINe94u5D9hGXWGjpMgMuWBbLeIbyH5
X-Received: by 2002:a05:6000:c2:: with SMTP id q2mr3452640wrx.200.1618490524816;
        Thu, 15 Apr 2021 05:42:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTws3Xaqrmc9w/HCKZ9yvo04+CNq4y+/1CSb9wDtEOkwkQSuu08CvKB2o4T5u6PO45lfr3Pw==
X-Received: by 2002:a05:6000:c2:: with SMTP id q2mr3452619wrx.200.1618490524640;
        Thu, 15 Apr 2021 05:42:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6392.dip0.t-ipconnect.de. [91.12.99.146])
        by smtp.gmail.com with ESMTPSA id 18sm1378876wmo.47.2021.04.15.05.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 05:42:04 -0700 (PDT)
Subject: Re: [PATCH v8 2/7] mm,compaction: Let
 isolate_migratepages_{range,block} return error codes
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210415103544.6791-1-osalvador@suse.de>
 <20210415103544.6791-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f293a4d2-ddac-edb2-7858-92e3a3f2c6f6@redhat.com>
Date:   Thu, 15 Apr 2021 14:42:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210415103544.6791-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.21 12:35, Oscar Salvador wrote:
> Currently, isolate_migratepages_{range,block} and their callers use
> a pfn == 0 vs pfn != 0 scheme to let the caller know whether there was
> any error during isolation.
> This does not work as soon as we need to start reporting different error
> codes and make sure we pass them down the chain, so they are properly
> interpreted by functions like e.g: alloc_contig_range.
> 
> Let us rework isolate_migratepages_{range,block} so we can report error
> codes.
> Since isolate_migratepages_block will stop returning the next pfn to be
> scanned, we reuse the cc->migrate_pfn field to keep track of that.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

