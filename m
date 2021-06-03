Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AC339AAEF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 21:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhFCTar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 15:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24925 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhFCTar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622748541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x/gj4fleOURiB06FpwTyo6dG+WTMtW3dGT0Tg+4lxHw=;
        b=YsfmKUIlAXnOw6T6ZLhaOcBIXC/jDg1udoDn0MekjBLM0eSyjxEpaj/eNrsMdn8ywE9jyS
        mJ7ZxZMzRIsN0ewCoiZrMNioYKZ+t3gvUSB3ip28l9vVkzm/xymIUOiNXUvaoOVpdtJ90o
        cuH/JnSqpuJxmpynS2qYcaYF9LEoUfY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-irPYQu-qOx6q_FOLSXIUow-1; Thu, 03 Jun 2021 15:29:00 -0400
X-MC-Unique: irPYQu-qOx6q_FOLSXIUow-1
Received: by mail-qv1-f72.google.com with SMTP id v7-20020a0ccd870000b0290219d3e21c4eso5217549qvm.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 12:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x/gj4fleOURiB06FpwTyo6dG+WTMtW3dGT0Tg+4lxHw=;
        b=aw6CY5jMJzBP5aIKhb0l6dk/ht+N+xEsM0aGnAvj3F+Dox6Mj74MJ+b5c52S6uzi/y
         lK1fz52KPEZeKfrUIMbmn3a04fOQPIiG9pykGWQSr9Cx3hucPHwukaKmRpnwMAFIw5y3
         f0ERVWF4aivZDygbueIBPIst1TEnG/7eTFbGnkiq9NR3SiwswPrMu04I7dipIi2EpD3C
         hmQrN431MDJiyNulHk9liE1HpAT7JC3Z7ZhmKvG23lgdva0g3KFLP3KsLiWeTVxvkoV4
         hKKvnDO2/yzz2g7nH5pZ3NecKmz8/Ilu1M3vjHlF4kndvBK70LG13tO3ypxU1o4J5bkH
         fw+g==
X-Gm-Message-State: AOAM531HYEXRoazomJ00s17jNs4wh39/U/2c71EbgKEXmprQK6Z87lL7
        tlV+Q72g2VeLcI0E94eDfba+CQ20rrg0jZ7LbT4xp2r4ne8sAxsqat52+6Gt5cNM8yK6yyXp1Ek
        8UNI+prOxJBegL6cj9u0NCTy6
X-Received: by 2002:a05:620a:448c:: with SMTP id x12mr839815qkp.52.1622748539795;
        Thu, 03 Jun 2021 12:28:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLUjjqgS6V5SzDAJv1efAuEwlyGvFi855kq2nrnnQnLUOJ5tlxqeQcaZvh3Y3jB/o7M29QhQ==
X-Received: by 2002:a05:620a:448c:: with SMTP id x12mr839796qkp.52.1622748539589;
        Thu, 03 Jun 2021 12:28:59 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-61-184-147-118-108.dsl.bell.ca. [184.147.118.108])
        by smtp.gmail.com with ESMTPSA id p12sm2476522qkm.23.2021.06.03.12.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 12:28:59 -0700 (PDT)
Date:   Thu, 3 Jun 2021 15:28:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] ioctl_userfaultfd.2, userfaultfd.2: add minor fault mode
Message-ID: <YLkteUqSmXFxSJNt@t490s>
References: <20210603183216.939169-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210603183216.939169-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 11:32:16AM -0700, Axel Rasmussen wrote:

[...]

Not a native speaker, feel free to take anything I said with a grain of salt..

> @@ -278,14 +287,8 @@ by the current kernel version.
>  (Since Linux 4.3.)
>  Register a memory address range with the userfaultfd object.
>  The pages in the range must be "compatible".
> -.PP
> -Up to Linux kernel 4.11,
> -only private anonymous ranges are compatible for registering with
> -.BR UFFDIO_REGISTER .
> -.PP
> -Since Linux 4.11,
> -hugetlbfs and shared memory ranges are also compatible with
> -.BR UFFDIO_REGISTER .
> +What constitutes "compatible" depends on the mode(s) being used, as described
> +below.

Would below be slightly better?

  Please refer to the list of register modes below for the compatible memory
  backends for each mode.

[...]

> @@ -735,6 +745,109 @@ or not registered with userfaultfd write-protect mode.
>  .TP
>  .B EFAULT
>  Encountered a generic fault during processing.
> +.\"
> +.SS UFFDIO_CONTINUE
> +(Since Linux 5.13.)
> +Used for resolving minor faults specifically.
> +Take the existing page(s) in the range registered with
> +.B UFFDIO_REGISTER_MODE_MINOR
> +and install page table entries for them.

"Take the existing page" reads a bit weird to me.  How about something like:
"Resolving minor-mode trapped page faults by installing page table entries with
pages in the page cache"?

[...]

> +.TP
> +.B EINVAL
> +An invalid bit was specified in the
> +.IR mode
> +field.
> +.TP
> +.B EEXIST
> +One or more pages were already mapped in the given range.

I'd think this sentence is good enough; slightly prefer dropping the latter one
"In other words..." below, as "mapped" should mean the same to me (and the
wording "fully mapped" is a bit confusing too..).

> +In other words, not only did pages exist in the page cache, but page table
> +entries already existed for those pages and they were fully mapped.

[...]

Thanks,

-- 
Peter Xu

