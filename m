Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F2C3F89D1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242728AbhHZOKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232876AbhHZOKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629986968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8G/7ZlO3OCW/oELCaVsXFVvVuQOIOXBoolUrlOFg5ds=;
        b=T7H6w4XCPD32D4jzvKxRdfYCaXQ75H36vjDO9GQLqZapOkxmmvWvqHKcRcs7SVpFDc/m/R
        XXvufAemqnt+B+hRTK1TGgGIi2vJEj002Hk52PFdhr/DrXaoN++zeg7DRT/f+A0+3DkNIl
        48EYfqHnQaVEsQtVjMNVcIZshOIlGYM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-sC_xboxDO_Wm7qNQuxWBwA-1; Thu, 26 Aug 2021 10:09:27 -0400
X-MC-Unique: sC_xboxDO_Wm7qNQuxWBwA-1
Received: by mail-wm1-f71.google.com with SMTP id r4-20020a1c4404000000b002e728beb9fbso4370718wma.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 07:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8G/7ZlO3OCW/oELCaVsXFVvVuQOIOXBoolUrlOFg5ds=;
        b=HrtLIH9T0+RkKsosdXW56DKsuq8iuMuU0Y0YO3gl8GObaPkv6GJCDpTJpArarWV2ee
         qd4I2kHNWu5t4Vw4xjbkcqxRPydjD/O8/ZC+bm7We4NI+M2b2cj36qxz/eXDcLq8qn8+
         1m15jEsxm8F8rWBcK7yDFqBk9CJwGjafn3gQ+UDRUpWC44q4dgHd+7w/qkLAM3p2tfl6
         qAC9x/rx/9/FxaM5LxyyPuNZ9LvAIAjKeYdxzng6j6JSoCrqrSm0QGtTG4Nl4YFn4QxD
         olRehOsHLBO6qJDGwGz1QZl0OeW5XCGZhUugzgFYr4WxTdjnusblLsWxMQQYTwgwdOjb
         /4MQ==
X-Gm-Message-State: AOAM530qrpF3SQgvGK9AQSSvM5yoPPZcwhqqYzXn2A2xZUoH2tszrpE7
        2sqos1WWkwdS/Cpr7YMe5am8y7XKNPwuV5yLpeGPy0sNa+nSR2M8KricNIWFP99YbACF3GuBqv9
        s1bhX1NpEBpdbCUBB93abZhHn0qQo9Q/FbVCYydoMEgzzJhXU1X1gPccy9mQu6keJeiawIA6w
X-Received: by 2002:a05:600c:4786:: with SMTP id k6mr3810302wmo.177.1629986966140;
        Thu, 26 Aug 2021 07:09:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNZb+DI3d7hc5fu4d3o+gW7xumIsZ6ppo8lQ6GiIt4+/RCYJMTCrbeKlf8aKlmLHYchjnECQ==
X-Received: by 2002:a05:600c:4786:: with SMTP id k6mr3810237wmo.177.1629986965829;
        Thu, 26 Aug 2021 07:09:25 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23dec.dip0.t-ipconnect.de. [79.242.61.236])
        by smtp.gmail.com with ESMTPSA id s7sm3255500wra.75.2021.08.26.07.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 07:09:25 -0700 (PDT)
To:     SeongJae Park <sj38.park@gmail.com>, akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, dwmw@amazon.com,
        elver@google.com, fan.du@intel.com, foersleo@amazon.de,
        greg@kroah.com, gthelen@google.com, guoju.fgj@alibaba-inc.com,
        jgowans@amazon.com, joe@perches.com, mgorman@suse.de,
        mheyne@amazon.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, sieberf@amazon.com,
        snu@zelle79.org, vbabka@suse.cz, vdavydov.dev@gmail.com,
        zgf574564920@gmail.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210716081449.22187-1-sj38.park@gmail.com>
 <20210716081449.22187-6-sj38.park@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v34 05/13] mm/damon: Implement primitives for the virtual
 memory address spaces
Message-ID: <358fa060-7702-d523-5169-f25a3de0c22e@redhat.com>
Date:   Thu, 26 Aug 2021 16:09:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716081449.22187-6-sj38.park@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
> +{
> +	pte_t *pte = NULL;
> +	pmd_t *pmd = NULL;
> +	spinlock_t *ptl;
> +

I just stumbled over this, sorry for the dumb questions:


a) What do we know about that region we are messing with?

AFAIU, just like follow_pte() and follow_pfn(), follow_invalidate_pte() 
should only be called on VM_IO and raw VM_PFNMAP mappings in general 
(see the doc of follow_pte()). Do you even know that it's within a 
single VMA and that there are no concurrent modifications?

b) Which locks are we holding?

I hope we're holding the mmap lock in read mode at least. Or how are you 
making sure there are no concurrent modifications to page tables / VMA 
layout ... ?

> +	if (follow_invalidate_pte(mm, addr, NULL, &pte, &pmd, &ptl))



-- 
Thanks,

David / dhildenb

