Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6CA452C58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhKPIFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:05:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231429AbhKPIFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637049755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LCSrynp2laCG1R5XEbg3KqtinIS3fppXUc3OoVzsOks=;
        b=G7gljdma5ojE2wOjnRpUf8jL2V0t+Pu9Q+0a0wZRt/Mtibzy3BGzeQJqkKbBfsVZhHpJ8+
        oTnHP00jtYUX9cudhvTHb5MQksy8ibbYM4PfRGaGpFNAYAcNjGIiNSpLcpVOKcuuZjpIsS
        OB9OiZywpMVVHYN2g21PqVUSYQ4bTPE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-_FyzTaYdNjOU3vh_DjhWFg-1; Tue, 16 Nov 2021 03:02:34 -0500
X-MC-Unique: _FyzTaYdNjOU3vh_DjhWFg-1
Received: by mail-wm1-f72.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso1079477wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LCSrynp2laCG1R5XEbg3KqtinIS3fppXUc3OoVzsOks=;
        b=fweP+SKewj0OC7Si5D1h7XQ7/hBeq9/KynnzD0TF/JH5/yLNWXUlJHiYcmuNM15wi6
         +MtP6QRECaIjZJGqwbkhrWAL/2vdPNNdUe55TqoTDD96tjTHVS+nywzo4N0d0WdZuV/t
         mAb6008UKQmBqJoFRcaXA8SQtx7RIM1T497aQUnZi3roIj68042gotT8XwP/9di9JJXD
         Dtv56uFPLmp2WQzawxA4aLA+uEUn3Yar/6ySXDcYR00ihBm+tzgg+X8OgHx06eZtm0Tw
         aM9S/kRLX3Up6sAuf6axOgQ1V/EqTyv9Voj3F9WnTkxi/EhzOLp0m2lnZmP45KyPlFPJ
         CzjQ==
X-Gm-Message-State: AOAM533DMcJpsVlIJBN7dCgg3VtLdoUp/rUyiSFEadq1kru/KEqKYnKS
        ReK3k8Pc0H+aTyD/qZXe7Qq9FxnL0ae5ibhuDxEVe7P1vPd1WBQlBiATpAwTwy6tvyuNGdZNFpI
        3x7qgBwOb0NvYAF4vvv3uGYEK
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr6954073wrw.104.1637049752994;
        Tue, 16 Nov 2021 00:02:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6Utf7cFwIqmSHQp5zkqSecC4ZA2odmOYlZZgrRcZkRsT04uEEng/kHgOkrk3tTuv1xPPHkQ==
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr6954047wrw.104.1637049752784;
        Tue, 16 Nov 2021 00:02:32 -0800 (PST)
Received: from [192.168.3.132] (p4ff23d3a.dip0.t-ipconnect.de. [79.242.61.58])
        by smtp.gmail.com with ESMTPSA id m20sm1745208wmq.11.2021.11.16.00.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 00:02:32 -0800 (PST)
Message-ID: <4289b936-e40c-cde8-eb08-0bd13c44eba3@redhat.com>
Date:   Tue, 16 Nov 2021 09:02:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] proc/vmcore: fix clearing user buffer by properly
 using clear_user()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20211112092750.6921-1-david@redhat.com>
 <20211115140444.bca2b88cfdd992760a413442@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211115140444.bca2b88cfdd992760a413442@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.21 23:04, Andrew Morton wrote:
> On Fri, 12 Nov 2021 10:27:50 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> To clear a user buffer we cannot simply use memset, we have to use
>> clear_user(). With a virtio-mem device that registers a vmcore_cb and has
>> some logically unplugged memory inside an added Linux memory block, I can
>> easily trigger a BUG by copying the vmcore via "cp":
>>
>> ...
>>
>> Some x86-64 CPUs have a CPU feature called "Supervisor Mode Access
>> Prevention (SMAP)", which is used to detect wrong access from the kernel to
>> user buffers like this: SMAP triggers a permissions violation on wrong
>> access. In the x86-64 variant of clear_user(), SMAP is properly
>> handled via clac()+stac().
>>
>> To fix, properly use clear_user() when we're dealing with a user buffer.
>>
> 
> I added cc:stable, OK?
> 

I was a bit hesitant because this would (beofe the virtio-mem changes)
only trigger under XEN and I was wondering why nobody notices under XEN
so far. But yes, even though it only applies to the kdump kernel,
cc:stable sounds like the right think to do!

Thanks Andrew!

-- 
Thanks,

David / dhildenb

