Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76903349BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhCYVfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhCYVep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:34:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFC9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:34:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e18so3730171wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vOuyD+8iJ6pChPVDl0VFGxY46KCmbNa2kfeUJDzMkXg=;
        b=soMI3uWRUjktG04D2SQu8Qy97qHRJs7uo1iRTTUJnj71Tc1uQP8P984R/Y7LZalU1j
         +gziByYDZXZLl7kF8Ob027LJQ1qyidDTVcI6awvzbJW0i1RbBtYRvZYh6bf5ls5CQIjk
         xdmKmlte7+TYumQURsrVTuUWRbxJYrlpQdrHx1SPMk3DoqM7bmSr4y2Qoq0++a6I6MFX
         PKS6qd9U/lVfCGA1DTHkKdMJw5iKC56pjQ6LMfmpbljVbHk3dvN3b8KnU1eetT23dlMO
         2EKRrrutCsEjCxe5zt9+8hYwo/KfIfmNpD2R5OBzXDxOh+ibxUwkynf0OVLvV8N0RnrG
         L1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vOuyD+8iJ6pChPVDl0VFGxY46KCmbNa2kfeUJDzMkXg=;
        b=iPrxTAs2RyQ0ZDRTVZ+bEluMh+p8SN8Fe/RV9GY0vdO2jScPdIzcKqjSgx5mgANgze
         +yAu/cmIJ6KGlESnycE3I28eL0oyPygmOjOMKUJ56nEK+5UOBoMa1FR54Oyb9qFAj0za
         KfkVAVMfJ2flgm2wTz722W84p4E6+hSlPT64WfViSPBuSCC2QJFY3pz7nLOGHN4TMWlT
         rKDDgZeugK5avkfroKIhW9h67Bmwnu0CeI2TsihsasFNIRuB8C3it+2ACFIm4WooznvF
         +brCrBqfd1Qlw5WK01p5JYU0Qw93Mya6PiPYj2s38xMI0JjkPqIZcJeFjKkrvsp6ci0X
         wlrA==
X-Gm-Message-State: AOAM532R4YMGiQaG2peNynksM1+jlbC2Qb99QgiDzRd51DPa9d40XDOw
        Ol63NBjMleWvTJ3ervpMUQU=
X-Google-Smtp-Source: ABdhPJzaBmLiCUF9fTMgpQMDGbGE00hcRi591iwKiRoYxb9iM1hwjDFmt01SSNbGWLnnoxFGqM3aBA==
X-Received: by 2002:a5d:6a49:: with SMTP id t9mr11373439wrw.131.1616708083605;
        Thu, 25 Mar 2021 14:34:43 -0700 (PDT)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id i8sm7995314wmi.6.2021.03.25.14.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 14:34:43 -0700 (PDT)
Subject: Re: [PATCH] mremap.2: MREMAP_DONTUNMAP to reflect to supported
 mappings
To:     Brian Geffon <bgeffon@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210303175235.3308220-1-bgeffon@google.com>
 <20210323182520.2712101-1-bgeffon@google.com>
 <20210323182520.2712101-4-bgeffon@google.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <9c0b4b2a-3678-186a-072a-280628e5da02@gmail.com>
Date:   Thu, 25 Mar 2021 22:34:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323182520.2712101-4-bgeffon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Brian,

Is this already merged in Linux?  I guess not, as I've seen a patch of 
yous for the kernel, right?

Thanks,

Alex

On 3/23/21 7:25 PM, Brian Geffon wrote:
> mremap(2) now supports MREMAP_DONTUNMAP with mapping types other
> than private anonymous.
> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>   man2/mremap.2 | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/man2/mremap.2 b/man2/mremap.2
> index 3ed0c0c0a..72acbc111 100644
> --- a/man2/mremap.2
> +++ b/man2/mremap.2
> @@ -118,16 +118,6 @@ This flag, which must be used in conjunction with
>   remaps a mapping to a new address but does not unmap the mapping at
>   .IR old_address .
>   .IP
> -The
> -.B MREMAP_DONTUNMAP
> -flag can be used only with private anonymous mappings
> -(see the description of
> -.BR MAP_PRIVATE
> -and
> -.BR MAP_ANONYMOUS
> -in
> -.BR mmap (2)).
> -.IP
>   After completion,
>   any access to the range specified by
>   .IR old_address
> @@ -227,7 +217,8 @@ was specified, but one or more pages in the range specified by
>   .IR old_address
>   and
>   .IR old_size
> -were not private anonymous;
> +were part of a special mapping or the mapping is one that
> +does not support merging or expanding;
>   .IP *
>   .B MREMAP_DONTUNMAP
>   was specified and
> 

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
