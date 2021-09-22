Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173C0414BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhIVOcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232401AbhIVOcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632321062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9MFwjIYK3NzURsIL5ZeXXjauXt11emCz529o4qozFY=;
        b=CNk7IbYe1HcgRaylWTk1jdMcyxSAC0Tydy80194TLLDbDoWvPbfLLrnYP+w6eZCznBrUZu
        vy0TnABm09vKag+s/9geTaFnPn0Jd5cSNmdrH6RykvzKHWe82bi8XHUyUpMLfKv7L4IySX
        Nn9H35NY8sdJlSif3o7Nzo2ris6pgNw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-MApuHH1YNo2KttL6mh7pIw-1; Wed, 22 Sep 2021 10:30:56 -0400
X-MC-Unique: MApuHH1YNo2KttL6mh7pIw-1
Received: by mail-qt1-f197.google.com with SMTP id b15-20020a05622a020f00b0029e28300d94so8719268qtx.16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H9MFwjIYK3NzURsIL5ZeXXjauXt11emCz529o4qozFY=;
        b=5+iq63JlhDzhh2v3z/poASjSnAfGRvv7QuMXoundVC7jyM6dBTY61s5yImkltsDpDA
         qYobFlVJmNRMCWYV5ORkV+2EyzeNEr4pF/E3Z98AH1rQYGKccQhIqkLD/w2Ec8yM4/6W
         i4rYYwSrgL02ocs2YwD6vZAU+kpKS+drNENCV8TcgTgOlgYw0z3Uz+SGnWtxPh3smGqH
         lySHvN2396ComQayqlii49xbgdPwbK3vPKgfK3zCzW2SpNcDCejKs5UqlDjbxQEUdtXA
         mcQwOYDDNE0w6/qujm6p7wHFyAynxsFA7Cd1chRhG1nRi3dhPyVmAT6OG4SEXvVBf+Qv
         I4Jg==
X-Gm-Message-State: AOAM531A4ys8s/0Sb3D5gaqlVOoF9lInhd/Ak6lW3xwqsLShoA1fn5w/
        wZsh05Xq9GC1Cbt8S23BasJDk/i+KAROPdP8WPJLrVER8ss0imU2hJctJQscCHHLb4uUxopCwGz
        tM8vYSMBuxUWaJB+UWruHDFvI
X-Received: by 2002:ac8:1c6:: with SMTP id b6mr32958205qtg.221.1632321056079;
        Wed, 22 Sep 2021 07:30:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQAVBr6hBwwFSYKO7U1/khHUr5y9tSTMCIoPdoZ894eUZ+OrVYZ3xfOPFjOhJbFSSfttPIFg==
X-Received: by 2002:ac8:1c6:: with SMTP id b6mr32958174qtg.221.1632321055765;
        Wed, 22 Sep 2021 07:30:55 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id f83sm1917615qke.79.2021.09.22.07.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 07:30:55 -0700 (PDT)
Date:   Wed, 22 Sep 2021 10:30:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: fix a race between writeprotect and
 exit_mmap()
Message-ID: <YUs+HZOf6mnI6mm2@t490s>
References: <20210921200247.25749-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921200247.25749-1-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 01:02:47PM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> A race is possible when a process exits, its VMAs are removed
> by exit_mmap() and at the same time userfaultfd_writeprotect() is
> called.
> 
> The race was detected by KASAN on a development kernel, but it appears
> to be possible on vanilla kernels as well.
> 
> Use mmget_not_zero() to prevent the race as done in other userfaultfd
> operations.
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 63b2d4174c4ad ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Signed-off-by: Nadav Amit <namit@vmware.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Peter Xu

