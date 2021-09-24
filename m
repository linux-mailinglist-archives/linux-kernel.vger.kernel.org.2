Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C479417D02
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347520AbhIXVdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347407AbhIXVdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:33:16 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE51C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:31:42 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id x124so16286454oix.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4tvahGfU7bi3KWoSnewxgiaf6DUj4AvCMOuBOdPy8Fs=;
        b=HO0E1PSRkatDJSpPLuGyHBzpfTv74fYTX3Agj8a67YOlcIIMKwMBJuNoZwkb8vu6UZ
         YvmCx3KFPp+tZJtWCaqnfvkeVmnsdZDVPNMQp94ps6aGgx7pBLXzJ6SfjkGWFkn5cMZK
         /o5tGVUTbVH/jXBMGYm4TWd2Qy2pwCy7BQnj5ARdA2msyGUm4AFdbMaS3RQlowhzKNRd
         fXadoIU9Vdy+VAOx8IlgxUy7TKVIiIZhL+3p0rqf/1+QJp+4G5DDxN0NapMeBP10Bai6
         jLUypwix87Hd548u/DXIyGvsLzdflGeLeq9Rv5Iz/kaphB5eRSyNvzdP6aXKAwVjAKgD
         eVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4tvahGfU7bi3KWoSnewxgiaf6DUj4AvCMOuBOdPy8Fs=;
        b=dzAC3RXosHf729jp1RTWn13Ox/2JysGRk7kEDyAJlLS8tsi4aDdMtT1KwaO/RrQv4f
         yDjaGKmoClQlIeg2NTw1oUkOu/F15ru5yaV+uieP+QpHc4sZ+V8XFx5gZL2nltfYQ0AS
         yUwEj3ZULNYFnTUEav1KnpCpwggd2ToGKtZJfl79Y94QAeaXVr3obxuWcrk4KlnodDZX
         GwX5I10AGfB3HLGQ77nIXItkO9mhe8eR49TwimTEbu33lT0VOfDAEo7+cejTaldqjrHJ
         WIUz0XNlAiXwu1pEXtuyISGSY9FZ/8DVK05iuTu9yAZ/yxjmkVUrgP/pkTd7vj0224La
         JC4A==
X-Gm-Message-State: AOAM530AisYXBhPdTL/5+vljARo2FmXN9scw8NQ9rEdu4CMZGAzAL92P
        B6PSaKc2r4PppZeQgkxPdV0weA==
X-Google-Smtp-Source: ABdhPJygS8JzZ4K3yFR3BhQbu1otgYVr7A9q2WBnn4X/dqFAD7UX6izpjsBbB9IanPoiUJHUHDGsNw==
X-Received: by 2002:aca:f143:: with SMTP id p64mr3266120oih.161.1632519101628;
        Fri, 24 Sep 2021 14:31:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r18sm2394632ooc.27.2021.09.24.14.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 14:31:41 -0700 (PDT)
Date:   Fri, 24 Sep 2021 14:31:29 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Liu Yuntao <liuyuntao10@huawei.com>
cc:     kirill@shutemov.name, akpm@linux-foundation.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, liusirui@huawei.com, windspectator@gmail.com,
        wuxu.wu@huawei.com
Subject: Re: [PATCH v2] fix judgment error in shmem_is_huge()
In-Reply-To: <20210909032007.18353-1-liuyuntao10@huawei.com>
Message-ID: <8a5bc69-193e-9b4a-2161-b03b69eebed2@google.com>
References: <20210909032007.18353-1-liuyuntao10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sep 2021, Liu Yuntao wrote:

> In the case of SHMEM_HUGE_WITHIN_SIZE, the page index is not rounded
> up correctly. When the page index points to the first page in a huge
> page, round_up() cannot bring it to the end of the huge page, but
> to the end of the previous one.
> 
> an example:
> HPAGE_PMD_NR on my machine is 512(2 MB huge page size).
> After allcoating a 3000 KB buffer, I access it at location 2050 KB.

Your example is certainly helpful, but weird!  It's not impossible,
but wouldn't it be easier to understand if you said "2048 KB" there?

> In shmem_is_huge(), the corresponding index happens to be 512.
> After rounded up by HPAGE_PMD_NR, it will still be 512 which is
> smaller than i_size, and shmem_is_huge() will return true.
> As a result, my buffer takes an additional huge page, and that
> shouldn't happen when shmem_enabled is set to within_size.

A colleague very recently opened my eyes to within_size on shmem_enabled:
I've always been dubious of both, but they can work quite well together.

> 
> Fixes: f3f0e1d2150b2b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> Signed-off-by: Liu Yuntao <liuyuntao10@huawei.com>

Thanks, with a nice simplification from Kirill.

Acked-by: Hugh Dickins <hughd@google.com>

Ignore the comment I've added below - it's not worth worrying about.

> ---
> V1->V2:
> add simplification of the condition after round_up()
> ---
>  mm/shmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 88742953532c..b5860f4a2738 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -490,9 +490,9 @@ bool shmem_is_huge(struct vm_area_struct *vma,
>  	case SHMEM_HUGE_ALWAYS:
>  		return true;
>  	case SHMEM_HUGE_WITHIN_SIZE:
> -		index = round_up(index, HPAGE_PMD_NR);
> +		index = round_up(index + 1, HPAGE_PMD_NR);

Even without your change, I notice now that there's a possibility of
index wrapping to 0 on 32-bit architecture here.  But nothing goes
terribly wrong in that case: it is not worth worrying about here.

>  		i_size = round_up(i_size_read(inode), PAGE_SIZE);
> -		if (i_size >= HPAGE_PMD_SIZE && (i_size >> PAGE_SHIFT) >= index)
> +		if (i_size >> PAGE_SHIFT >= index)
>  			return true;
>  		fallthrough;
>  	case SHMEM_HUGE_ADVISE:
> -- 
> 2.23.0
