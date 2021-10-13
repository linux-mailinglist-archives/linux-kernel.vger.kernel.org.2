Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A50942B292
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 04:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhJMCVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 22:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229796AbhJMCVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 22:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634091540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wcg8uv0C3xyyk65eRbzrMi+K/zZRYWFm2h8Sqmj3wMU=;
        b=SiYxrXddZTqyXliqDeYXgfmZ3Xj4SzYcVFjDOoLS3Mc+r0XKg6jRD9qBpmlj/3Q+Tnvmej
        /xMQ27G+1v9yuBYlnyRNwxzz3HPkxaBK+K1JSnk6OAgpzchRgmA5yYQYEmj5JPurrN1fbP
        oIPBG9FBeuHY+l0b4nY6ny9Rb69ko4k=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-WlP7gyPPOvOHQMpKl_o_VA-1; Tue, 12 Oct 2021 22:18:59 -0400
X-MC-Unique: WlP7gyPPOvOHQMpKl_o_VA-1
Received: by mail-pj1-f71.google.com with SMTP id oo5-20020a17090b1c8500b0019e585e8f6fso2676675pjb.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 19:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wcg8uv0C3xyyk65eRbzrMi+K/zZRYWFm2h8Sqmj3wMU=;
        b=GKwX5d2TwfrVHmKvf25oY2XszwUQ0KDE64D8CwJLG2E6iksm3heAPLLN6oHT4S3qeg
         W8px0p+nrABTpnbwAtzIxrWQivlJMQpSiL7Y4EVftH9w4/9YCcqyw1ADsVJn8dEwfemS
         zzUUG2WqXs8NudDqJhVOpyMaB+HmAWN4+klKE6MW9pfPAxCH+a9XBD8EufkLfKo8itCw
         GgAqMOMvPBn4dQgme8tRDubWA1UMWZRbH/INN+KKA1/SwHNOTs1pCq43thRR9cLez1c7
         3Q49kjULPrPfqJygHw+IjayBJb+UL32nbCabuo1yTG8tlV/jB6dxJhYkxIkdfT+s9zVn
         C/Qg==
X-Gm-Message-State: AOAM5339MqhdRYTG7kHVm/NYcvko3odZNCmjlN12w6klBXB/nR+nog/L
        KrR6fIBLG9PZFI/nS86k4F2yetvlr9Xag5GDwaUJQcR3dBRRageTkD2QPeEwXqVdroJ/Y3D3BXJ
        Rl5JO+xB0hbtubX/4DNwtPEun
X-Received: by 2002:a17:90b:34a:: with SMTP id fh10mr10255609pjb.51.1634091538057;
        Tue, 12 Oct 2021 19:18:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyx7vhHBd0uMwE25QMwUcweWXCRlis6s+sUV3hVb0B0kmMTX/EAjx0MTIPg+pR0k1K2hWHfIA==
X-Received: by 2002:a17:90b:34a:: with SMTP id fh10mr10255583pjb.51.1634091537771;
        Tue, 12 Oct 2021 19:18:57 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p189sm12159497pfp.167.2021.10.12.19.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 19:18:57 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:18:50 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] userfaultfd: support control over mm of remote PIDs
Message-ID: <YWZCClDorCCM7KMG@t490s>
References: <20210926170637.245699-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210926170637.245699-1-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 10:06:37AM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Non-cooperative mode is useful but only for forked processes.
> Userfaultfd can be useful to monitor, debug and manage memory of remote
> processes.
> 
> To support this mode, add a new flag, UFFD_REMOTE_PID, and an optional
> second argument to the userfaultfd syscall. When the flag is set, the
> second argument is assumed to be the PID of the process that is to be
> monitored. Otherwise the flag is ignored.
> 
> The syscall enforces that the caller has CAP_SYS_PTRACE to prevent
> misuse of this feature.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>

I think this patch from one pov looks just likes the other patch of the
process_madvise on DONTNEED - the new interface definitely opens new way to do
things, however IMHO it would be great to discuss some detailed scenario that
we can do with it better than the existing facilities.

The thing is uffd already provides some mechanism for doing things like
customized swapping, so that's not something new IMHO that this patch brings
(neither is what the DONTNEED patch brings), just like when I raised in the
other thread about umap.

So IMHO it'll be great if there can be some elaboration on how the "remote"
capability could help us do things better (e.g., use cases that we may not
solve with linking against another uffd-supported library, or we can't do with
register uffd then fork()).

(I skipped the security side of things, as I replied in the other thread that I
 think I buy in your point on depending on PTRACE capability and also the
 examples you gave on ptrace() and process_vm_writev() are persuasive to me,
 but no expert on that..)

Thanks,

-- 
Peter Xu

