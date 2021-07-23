Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313B43D3933
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbhGWKac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231848AbhGWKab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627038664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1IbpdoBanVv+55BsmPU96RSVm4RAh235zsiGQqev7Q=;
        b=RLGZ3QmoVIej9FpIFh568xYuWFgy7IF7rs1LZtPXBvLLQTPhC81NWeNELmloJyl0h4a2Lx
        6moaMOP3TE/qBILeftyfMcSKebf2NSi7LJyS1jYBLCNXIAowDAzhnnYktEcGrTnIhykD/c
        ug6dI2dfJX15f7KsV0AuD303SAyweJU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-m39M_csqPhCW4YUAS4CY2Q-1; Fri, 23 Jul 2021 07:11:01 -0400
X-MC-Unique: m39M_csqPhCW4YUAS4CY2Q-1
Received: by mail-wm1-f72.google.com with SMTP id k4-20020a05600c1c84b0290210c73f067aso95724wms.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 04:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=G1IbpdoBanVv+55BsmPU96RSVm4RAh235zsiGQqev7Q=;
        b=oJ5ThDBmE3qr+HQ8MP3NgWVUEFa8ZKwdA77D2ik3U/o8SaAvcYV1DyLtzIMTRpxyih
         gkBFbanRvoCSxtjqHBAO9SPafruMYphNvQuvjUiTehds+6oZNAPSzCwCqPoopQD11p6t
         SYbIF02gjR6K8bYuurbGSEEpMHZ/VmniTS9iDiRR94k4EIzVBJeJX3ki4aWP3/BwwyTY
         1HJZSg1dmOZqlTSEoYpF5yjEwqqFlFtbi/hQpaJfNh7NLpw4R0ZKARDY8nbukMUx50+s
         VKgOLrAEv217eB2y3AUDJaEaNAWG3yTemhZ6QqSOQX1m1ImgOCPLLTP0tc1YHmlpWyGV
         kG0g==
X-Gm-Message-State: AOAM531RmNx9P6+cBowbVbRNcPcubfXodA5yehMG7rjOWv+OxORfzpbN
        BdnjAcyg9IkrHa+09hEIyNe9t++dI18Rp886FxcB/rV80BkLMDw71LPh/PLdX3G66kwf4akuA2O
        Cx92zPbz106xuSExFPMrGpGyO
X-Received: by 2002:a1c:a709:: with SMTP id q9mr13456353wme.23.1627038659884;
        Fri, 23 Jul 2021 04:10:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUcdi6qHZiPRl09NrK7l/BF1ixG4/TVNsxh9PxInN/mhKZtGyFGZDWScCkKjkehy42GwCdgA==
X-Received: by 2002:a1c:a709:: with SMTP id q9mr13456325wme.23.1627038659656;
        Fri, 23 Jul 2021 04:10:59 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id t5sm33068215wrw.38.2021.07.23.04.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 04:10:59 -0700 (PDT)
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>
References: <20210723080000.93953-1-ying.huang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <fa03db08-cd57-51ca-967b-d1b5c9efc055@redhat.com>
Date:   Fri, 23 Jul 2021 13:10:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723080000.93953-1-ying.huang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.21 10:00, Huang Ying wrote:
> "-" is missing before "EINVAL".
> 

Ehm, that's not a typo, that's a real BUG.

What are the symptoms?


-- 
Thanks,

David / dhildenb

