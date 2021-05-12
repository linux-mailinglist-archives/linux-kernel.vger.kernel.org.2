Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED4A37BF21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhELOC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230486AbhELOC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620828079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gowrrLL3ysBs8u2zKiC3M3lu9rDb9/E0MQP7c4fvgzI=;
        b=NpHLV50D7UZ2DvzP3mR3YMR33j1tMMVZstdqE32tVIUWYgXr1psG+hGLWGAKCeUL76Uuh5
        RPTlS/32jsoVGaJ92nzrRvdNIt/3Fs/Q8n99zfneSXWB9urrKzUTTp+sNDG+NUI3sy/t7Z
        xmkYK190hNJLconPPApGfgYsN40B+JE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-hgpJoeeyNZWxxitP6sjJxw-1; Wed, 12 May 2021 10:01:18 -0400
X-MC-Unique: hgpJoeeyNZWxxitP6sjJxw-1
Received: by mail-qk1-f200.google.com with SMTP id i141-20020a379f930000b02902e94f6d938dso17393864qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gowrrLL3ysBs8u2zKiC3M3lu9rDb9/E0MQP7c4fvgzI=;
        b=rgzfJJBhCuYp2T/BSjWb2upYLDiBQC06zCMWapA2CFDqsnXTkYVUWYxygyIfzZT07K
         84qqllSXEikl5aO/76rmX9HiUOXUBAHf/alqGUDjItyCK/4Ceoaomw0vm+U8tKOqe6eK
         TZPPQrGjt7rYWZiRHPe9GFTstjUOEK2Dovsb1pRVDxGbDVoiPRPuRD20fSJE82dZYtop
         C6C+1fU2gZnwoJJXB0TXVlg0BmuvnhdhafTavRu8LL2ydccjqv4UW2U4xBj5ZJztXRpK
         VUSGQ+mB4FAA/VZ55RXxj5nYpiNNeXau2YhJXRqCfmGSTczEzdmVVkpGdKZeSUaz3EeN
         VwRQ==
X-Gm-Message-State: AOAM532VFFklT4lyHXZFcOT/qz33Xf4Vw9TnYmMcQ1akGUQGY2QIXcuw
        ppmWpSFmkWzJlF9RhOZYM8RuY0fp1kRIk8sJMifDDig2noXtrULb7B/ETIHJByCIeO26FtuM8OX
        b+GN1rD4tP9SBVF0K/MJWQucz
X-Received: by 2002:ac8:1093:: with SMTP id a19mr33433640qtj.365.1620828068030;
        Wed, 12 May 2021 07:01:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHSgHXU1mg2XTAmCZ8AesRnZrgozE7BfPtumfVlzE2V5i/gY9cW3Q94iB0M+SOMnXPuu6Blg==
X-Received: by 2002:ac8:1093:: with SMTP id a19mr33433611qtj.365.1620828067840;
        Wed, 12 May 2021 07:01:07 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h10sm78321qkh.47.2021.05.12.07.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 07:01:06 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210512152806.2492ca42@canb.auug.org.au>
Message-ID: <6e5a8e32-9b9d-67db-cfc5-8eb10ce6c87a@redhat.com>
Date:   Wed, 12 May 2021 10:01:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210512152806.2492ca42@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 1:28 AM, Stephen Rothwell wrote:
> Hi all,
>
> As Randy also reported ...
>
> After merging the akpm-current tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> mm/slab_common.c:764:8: error: array index in initializer exceeds array bounds
>    764 |  .name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #__short_size, \
>        |        ^~~~~~~~~~~~~~~
> mm/slab_common.c:776:2: note: in expansion of macro 'INIT_KMALLOC_INFO'
>    776 |  INIT_KMALLOC_INFO(0, 0),
>        |  ^~~~~~~~~~~~~~~~~
> mm/slab_common.c:756:39: error: array index in initializer exceeds array bounds
>    756 | #define KMALLOC_CGROUP_NAME(sz) .name[KMALLOC_CGROUP] = "kmalloc-cg-" #sz,
>        |                                       ^~~~~~~~~~~~~~
> mm/slab_common.c:765:2: note: in expansion of macro 'KMALLOC_CGROUP_NAME'
>    765 |  KMALLOC_CGROUP_NAME(__short_size)   \
>        |  ^~~~~~~~~~~~~~~~~~~
>
> and more
>
> Caused by commits
>
>    4d57437a3d3c ("mm: memcg/slab: create a new set of kmalloc-cg-<n> caches")
>    0727bf117622 ("mm: memcg/slab: don't create kmalloc-cg caches with cgroup.memory=nokmem")
>    d795c307bd3a ("mm: memcg/slab: disable cache merging for KMALLOC_NORMAL caches")
>
> At least they are the commits I have reverted to fix this.
>
Sorry about that. It turns out that construct like that below doesn't work.

enum kmalloc_cache_type {
         KMALLOC_NORMAL = 0,
#ifdef CONFIG_MEMCG_KMEM
         KMALLOC_CGROUP,
#else
         KMALLOC_CGROUP = KMALLOC_NORMAL,
#endif
         KMALLOC_RECLAIM,
#ifdef CONFIG_ZONE_DMA
         KMALLOC_DMA,
#else
         KMALLOC_DMA = KMALLOC_NORMAL,
#endif
         NR_KMALLOC_TYPES
};

The first ifdef is fine, but the second one will reset the enumeration 
count back to 0 if CONFIG_ZONE_DMA is not defined causing 
NR_KMALLOC_TYPES set to 1. Will send a new version to fix that.

Cheers,
Longman

