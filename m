Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBA141F949
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 04:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhJBCFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 22:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232278AbhJBCEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 22:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633140188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnJIUH5y7lwCwatGp+cWMPbIzQqOwL1mXDf/k3O/iEg=;
        b=VuBmQv+yPUVXNyStFdEJAfJf6lLl8glx2+6pOVcdC2HUFFQURqrILzZzlU1Ltb7W/xTN3v
        0EJTiYF3DjTcyvlnC6jv4WjcjjTNZYzhJJkW2P/RED3dFXmvU0hHTCe8vTYks4ziDEgUgX
        TspCAzrae1h2xQ1emAWE0u5qnA0SW2U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-7QGs0IyKMpuR3SldfYnjnQ-1; Fri, 01 Oct 2021 22:03:06 -0400
X-MC-Unique: 7QGs0IyKMpuR3SldfYnjnQ-1
Received: by mail-qk1-f198.google.com with SMTP id u22-20020a05620a431600b0045dcc8487daso18410783qko.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 19:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xnJIUH5y7lwCwatGp+cWMPbIzQqOwL1mXDf/k3O/iEg=;
        b=TegPeL8OMeLAu2PLHAWoz0t/RLOH7GdkCkd6GOQVSOAIUNwPRRidrAJce70DaV5QI8
         kR1B8NmDuFr2gf80ZY9VPU02m1GYevKb93m+AcNmmvj0lqMROCIeBrxBMM2eHe9KD85W
         cMxmJWadDqWejJmKTpsszsOt4yiY+zAV1Cr5HtApHDbjvGz/wvnRQe/sz8S4fcL1P91D
         NM2p444aQIhwlFqezyvqUfj/8MH+NAzEa0XJ1qS6Lge9i/fxuz+sA97qBYLMTXuHNHo8
         nUGtCLUJoR15GiYefeqbZe0l48EwHGbrRAXxla+zzCZjqVz3KCMoZNDtiMg2gB4qu0c3
         2wuA==
X-Gm-Message-State: AOAM531GpAb5rO0eE2fPegVanMb8xq2saOdZoSQ89wZk2L+NrxVR+tJV
        V/U/WQGT8bIPM3ndQqMzSX02BXb/ltS/kCgWeJdoS8sJvGu+0H55Kwv6rM7R/DJNEWrgCwQNLrA
        Cptndo3TzkoV7hd2NiveJnJEC
X-Received: by 2002:ac8:51d7:: with SMTP id d23mr1366464qtn.332.1633140186469;
        Fri, 01 Oct 2021 19:03:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyei3tVv14fNrp7a4mEN1eQaA52YTKDfW7PRXgu/igrMlJ2dGo/5jNaxmZZ+RUooFfL7OOUfw==
X-Received: by 2002:ac8:51d7:: with SMTP id d23mr1366434qtn.332.1633140186308;
        Fri, 01 Oct 2021 19:03:06 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id c6sm4839644qtx.72.2021.10.01.19.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 19:03:06 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/3] mm, memcg: Remove obsolete memcg_free_kmem()
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20211001190938.14050-1-longman@redhat.com>
 <20211001190938.14050-3-longman@redhat.com>
 <YVehP18mCcsXmFy1@carbon.dhcp.thefacebook.com>
Message-ID: <b45fd235-a454-360e-4853-d41db3213e9d@redhat.com>
Date:   Fri, 1 Oct 2021 22:03:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVehP18mCcsXmFy1@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/21 8:01 PM, Roman Gushchin wrote:
> On Fri, Oct 01, 2021 at 03:09:37PM -0400, Waiman Long wrote:
>> Since commit d648bcc7fe65 ("mm: kmem: make memcg_kmem_enabled()
>> irreversible"), the only thing memcg_free_kmem() does is to call
>> memcg_offline_kmem() when the memcg is still online. However,
>> memcg_offline_kmem() is only called from mem_cgroup_css_free() which
>> cannot be reached if the memcg hasn't been offlined first.
> Hm, is it true? What if online_css() fails?
I just realize that memcg_online_kmem() is called at css_create(). So 
yes, if css_online() fails (i.e. ENOMEM), we will need to do 
memcg_offline_kmem().
>> As this
>> function now serves no purpose, we should just remove it.
> It looks like we can just use memcg_offline_kmem() instead of
> memcg_free_kmem().

Right, memcg_free_kmem() isn't the right name for that. I agree that we 
should just change mem_cgroup_css_free() to call memcg_offline_kmem() 
directly. Will update the patch accordingly.

Thanks,
Longman

