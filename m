Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615E833FA63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhCQVTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230369AbhCQVTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616015942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJuWBirWZevEe1qdUUJUM0zyPqke25oP95wtgMd+Sq8=;
        b=aTg/e9ZPgfAWEYs6mpO5Ag8F6NNL5WX1csSTgPgvkhx/n0lJu4mzsbatcbaRc/DYSqOGhQ
        Mxmf4/R+NUue3Kb/D9l60aigCQtHNxJ7Ar48/Cdm1m3ugB6s8lv9NsggXwszIUXkahJj8B
        UDwlyD5EAhLXqZH8xcYDb2KqEXb8QwA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-nNhksLcmPTCH_8b0Ursh1Q-1; Wed, 17 Mar 2021 17:19:00 -0400
X-MC-Unique: nNhksLcmPTCH_8b0Ursh1Q-1
Received: by mail-qk1-f197.google.com with SMTP id x11so27060712qki.22
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zJuWBirWZevEe1qdUUJUM0zyPqke25oP95wtgMd+Sq8=;
        b=qUU93l0vZIs+GAvhnDhp3/ROmY6HV1btHu+gQBN89M8SxrkRmAToK/ruFLcaY5GhKn
         ppLqtEIS+7peodW6sT3W5KpZr13U+z3HJGYMBqCi8Lf6gYtOufm3djkA65ngg11IZKqG
         cjFHujPE5WTQPKQQ5IvGlA7/Qi2wQKXh3XBTbqi6ygfTekwMT7tQUn4WUjzO2zuv9x1f
         fqwto1hHQ3ztKIwzeQ4uUNS4YGNUXCALczT4wgTb3fZL86Y75zqEnpjacpt9OWzPVG31
         EK/bGKDgX1MQdNvnKVl4/g//K8Y7MjsE/ApvbiKdbyPOz3gQHu8b+5DYqLGgMxPwRlgh
         zzAg==
X-Gm-Message-State: AOAM532pZgfUhAlSc/bNwmXcd8DlOWavsvd3y6RG6la/lS3aP5LbX2fj
        vKKPmD4m+OBuiAlKgSJZCWbsxVcz+2mrBlC7GEY+qtiIigorZ08Ny5bgCdFrkTWnFEiZ4Q67quq
        ZNBoE0fquEfyUFJSvvmyK+Zuc
X-Received: by 2002:a05:620a:85e:: with SMTP id u30mr1252416qku.427.1616015939333;
        Wed, 17 Mar 2021 14:18:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhq6bqTA0FWK73UvJDzjgEn5ktBSk9FLI7tTjvi91rAjqHANwIaMUmYjcYzF3aSRStcgNLfQ==
X-Received: by 2002:a05:620a:85e:: with SMTP id u30mr1252388qku.427.1616015939099;
        Wed, 17 Mar 2021 14:18:59 -0700 (PDT)
Received: from xz-x1 ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id h8sm146847qkk.116.2021.03.17.14.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:18:58 -0700 (PDT)
Date:   Wed, 17 Mar 2021 17:18:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH v2 1/2] mm: Allow non-VM_DONTEXPAND and VM_PFNMAP
 mappings with MREMAP_DONTUNMAP
Message-ID: <20210317211857.GN395976@xz-x1>
References: <20210303175235.3308220-1-bgeffon@google.com>
 <20210317191334.564944-1-bgeffon@google.com>
 <20210317204015.GM395976@xz-x1>
 <CADyq12z6vQ0qHs14aVOFgqfn9pvFak-vwEVmLTObMQ1exsOM+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADyq12z6vQ0qHs14aVOFgqfn9pvFak-vwEVmLTObMQ1exsOM+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 04:44:25PM -0400, Brian Geffon wrote:
> Hi Peter,

Hi, Brian,

> Thank you as always for taking a look. This change relies on the
> existing check in vma_to_resize on line 686:
> https://elixir.bootlin.com/linux/v5.12-rc3/source/mm/mremap.c#L686
> which returns -EFAULT when the vma is VM_DONTEXPAND or VM_PFNMAP.

Do you mean line 676?

https://elixir.bootlin.com/linux/v5.12-rc3/source/mm/mremap.c#L676

I'm not sure whether it'll work for MREMAP_DONTUNMAP, since IIUC
MREMAP_DONTUNMAP only works for the remap case with no size change, however in
that case in vma_to_resize() we'll bail out even earlier than line 676 when
checking against the size:

https://elixir.bootlin.com/linux/v5.12-rc3/source/mm/mremap.c#L667

So IIUC we'll still need the change as Hugh suggested previously.

Thanks,

-- 
Peter Xu

