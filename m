Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D41B3ECFEB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhHPIFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234616AbhHPIFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629101059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRgugS5R33xzA7Rkgh8EjnbwTLS/bf85VMWTo3kT5R8=;
        b=Huq6XSg8h0FU7uCnfMQiSVu74n0f87QsGzJGCuZBMaYGn5f1i8vGV+Wlkzw1OkL4ZZbX3K
        gtvjZ3Iz0jOvg5Q7BLIoChv+H+iTQhoqwaQYuuqqgbtbrg9q0H+Hz7ujgRT+hIlGQnmdmv
        micH6qa7eOagG2DmcXGDRKmhTPfTqho=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-1jB4XgGhN6K7iy51e7Yy6Q-1; Mon, 16 Aug 2021 04:04:16 -0400
X-MC-Unique: 1jB4XgGhN6K7iy51e7Yy6Q-1
Received: by mail-wr1-f69.google.com with SMTP id q19-20020adfbb93000000b00156a96f5178so1850022wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 01:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qRgugS5R33xzA7Rkgh8EjnbwTLS/bf85VMWTo3kT5R8=;
        b=o+yHsra1nVLjQuGLW+cZjadaJdgeoCS3T0/5LCn5+PWp37Q+pY9j13iI8Rzjnvora5
         n8y+WsBE5zXWw31MFE/MPggYhyhqPTJIn0UllLny1H4x+lbDBlEViitZBSb9qpX87yC8
         C9zCuGHGNrjX6X69J695UCvWzZZUypoQmz7fVhpps/9T7FcJV8i7LFC7//sFjoJ8Q+dV
         Nr/eMyGZqTojokK0p2oZMyQjtbZxg1N250ueLChkHd4DfrMQygequ82EyzmLnfu7xNXl
         YFDHlZ9R1Pw8BbO8EX4eoBFiwI4wr7M7xpYr4iMd18N4pveefvcKslwpRndlL7LpXwdJ
         Z4mw==
X-Gm-Message-State: AOAM531NJfN+HfStlErOXdsCavilNw+ORYsTb4mSJmaBcOvV5T/Nmc/G
        2D1jsm9hBJwr+AxU5o4gXrV12rZVBjESmgapcVEt/WrYyBYLFlMYS7LZUfgj1PglqTLLeszQqYA
        ISAh9eThX2qGuixQECosNMsuz3o5tmwsudn3pLyK4ZgOLoL++T/lrhRUCjCbGb7n3YcWkHTEs
X-Received: by 2002:a5d:4ec4:: with SMTP id s4mr17120174wrv.245.1629101055095;
        Mon, 16 Aug 2021 01:04:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjWXBAShNHSs++OvRlLvJnRG/VG4/LYlwCfEbIyWeSad1G5UzbxaoCgVNvJe0fSBDpGK2NKg==
X-Received: by 2002:a5d:4ec4:: with SMTP id s4mr17120146wrv.245.1629101054824;
        Mon, 16 Aug 2021 01:04:14 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id b13sm10670911wrf.86.2021.08.16.01.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 01:04:14 -0700 (PDT)
To:     qiang.zhang@windriver.com, vbabka@suse.cz,
        akpm@linux-foundation.org, sfr@canb.auug.org.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210816074605.30336-1-qiang.zhang@windriver.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm, slub: add cpus_read_lock/unlock() for
 slab_mem_going_offline_callback()
Message-ID: <ef944ea5-c3cb-24e5-1ff8-b8e1008fa6ed@redhat.com>
Date:   Mon, 16 Aug 2021 10:04:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816074605.30336-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 09:46, qiang.zhang@windriver.com wrote:
> From: "Qiang.Zhang" <qiang.zhang@windriver.com>
> 
> The flush_all_cpus_locked() should be called with cpus_read_lock/unlock(),
> ensure flush_cpu_slab() can be executed on schedule_on CPU.
> 
> Fixes: 1c84f3c91640 ("mm, slub: fix memory and cpu hotplug related lock ordering issues")

Which branch contains this commit? At least not linux.git or linux-next

> Signed-off-by: Qiang.Zhang <qiang.zhang@windriver.com>
> ---
>   mm/slub.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 5543d57cb128..cf3f93abbd3e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4593,12 +4593,14 @@ static int slab_mem_going_offline_callback(void *arg)
>   {
>   	struct kmem_cache *s;
>   
> +	cpus_read_lock();
>   	mutex_lock(&slab_mutex);
>   	list_for_each_entry(s, &slab_caches, list) {
>   		flush_all_cpus_locked(s);
>   		__kmem_cache_do_shrink(s);
>   	}
>   	mutex_unlock(&slab_mutex);
> +	cpus_read_unlock();
>   
>   	return 0;
>   }
> 

Memory notifiers are getting called from online_pages()/offline_pages(), 
where we call memory_notify(MEM_GOING_OFFLINE, &arg) under 
mem_hotplug_begin().

mem_hotplug_begin() does a cpus_read_lock().

How does this even work or against which branch is this?

-- 
Thanks,

David / dhildenb

