Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A344C1B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhKJNBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhKJNB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:01:29 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776E6C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:58:42 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id r130so2613978pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=bYJCDmXhbZdwQcqQV6p0qfHrLLCZuMTTGmF8KIZ2ebg=;
        b=0Qj3WziVPa6/9jW1dnkM0js30+i48RZdsL8Xr/KA/YP6GLcSd+4iDZ8d/hdjQ+QcSU
         M8tFdlfYx5DT9eFjBgBgX7wvdySyiUT9yMOii2gUfVN7Vv786Jo8n1ZQKGoQfLnrfzJn
         kMgCMuI8xZSKKQlHTzYYmwz4+QugGvdqrpEtRr5n8XEjx8U8wfFrwqOfsoMyKoTGZEPV
         XRghj6fVtEnWuGAMGy4rAqXylpKvDJsxJFvTlcRDQX/x3u17FhglF+aADpjYSkShkleA
         n8FYpYmuiyTdm9uJcgJVQIbN9ugR1fXEb0+HnKgzmL8CrG3jk/y35V85ws19b9PJfZTg
         V8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bYJCDmXhbZdwQcqQV6p0qfHrLLCZuMTTGmF8KIZ2ebg=;
        b=rKBLyBqjcTLW2F3JKcx/0mHNUfUqmVpA+gIJHFFSzrbXVPGPP56vBFMiKzUJRxEeNx
         35tWYw5LcdnOZxCtEnhacSzAGGNjgL7SZECtOslSEKjETZqYHM9fyfYHSPYWPc+zYc9+
         RDFdJAl9bSYyN+Gz/Yy5A3LZxpJ1z2GXzXWoTf4zwm4GFBGx7zEk6RWAbwXsjyxH3Djx
         /g8BN3iXVx8ljK5mX5EOryaKLOKgpESFXqa6xG/EzwWpuv6O9eIkp4JyU1+eELqkmgVP
         rEy1MOGPvO7zFzKViOxTYmV7AVAq7p+1IGG/B/Xob2Xr23i/2shwfzGRzmgxgHipC3PP
         GjCw==
X-Gm-Message-State: AOAM533VWaC0Mjp5jDx1jytVWaJ5ecJPB/Yl3677bnZUYbJr4N7Qacgu
        XEzkfr172rkpM7xfgeON+QeEgQ==
X-Google-Smtp-Source: ABdhPJwbusrzbHVv2OyW13KKKsVbVhQcdBFFWjiyo9LwLOH9xHto26AgH0kSAvdXoNk3nAGUeFZf9A==
X-Received: by 2002:a05:6a00:844:b0:49f:dbe4:b911 with SMTP id q4-20020a056a00084400b0049fdbe4b911mr16603220pfk.6.1636549122022;
        Wed, 10 Nov 2021 04:58:42 -0800 (PST)
Received: from [10.254.189.129] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id t4sm23081243pfj.166.2021.11.10.04.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:58:41 -0800 (PST)
Message-ID: <18fa08bf-847b-1c47-10ee-01c92caeb0cc@bytedance.com>
Date:   Wed, 10 Nov 2021 20:58:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v3 02/15] mm: introduce is_huge_pmd() helper
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com
References: <20211110084057.27676-1-zhengqi.arch@bytedance.com>
 <20211110084057.27676-3-zhengqi.arch@bytedance.com>
 <20211110122945.GO1740502@nvidia.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20211110122945.GO1740502@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/21 8:29 PM, Jason Gunthorpe wrote:
> On Wed, Nov 10, 2021 at 04:40:44PM +0800, Qi Zheng wrote:
>> Currently we have some times the following judgments repeated in the
>> code:
>>
>> 	is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)
>>
>> which is to determine whether the *pmd is a huge pmd, so introduce
>> is_huge_pmd() helper to deduplicate them.
> 
> Isn't this pmd_leaf() ?

Currently, the implementation of pmd_leaf() does not include
pmd_devmap() checks. But considering the semantics of pmd_leaf(),
the "devmap" pmd should also belong to "leaf" pmd. Maybe we should
modify pmd_leaf() to make it more semantically consistent?

By the way, something went wrong when sending this patchset, and
I have re-sent the complete patchset, please comment over there.

Thanks,
Qi

> 
> Jason
> 
