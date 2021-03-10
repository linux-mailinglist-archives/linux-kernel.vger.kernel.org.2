Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140EF33424A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhCJP51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbhCJP5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:57:02 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBF9C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:57:02 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id u20so18406582iot.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vt8rEMWHkhPs1jHpWZbBk019eFTWlnfrOi5ImgrIL3k=;
        b=xjXootqMncZRy4oHkcN6P+OUzWp7EDBiV8APpM6kbKJ7lPeWhRsNKOjqnxoaftjj36
         K0aHyzs7YOiMjHwos75lsqgVKohkGExLODh1beBrLUYqjLv7iWXIsbGm8CZr3l4ZZrNx
         sEVXoxynmybd59dM64EqfDc1xVDxpwH8CgBYMGV3zsVeUOXAzYDv5tO46RyNoXxgzssi
         i3ZowqWfwt84LfO6m/OnhOSD9M8038kqJDPa/LibW5DakTvpi9XmPcBcFaICZGZL+u3Q
         g2IFkuzUPiXmi3zkm1oB8MTFCIy369/IKHz1zaVxdxCACF7PzFDqmLDCuwnM/T9ASyI5
         hCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vt8rEMWHkhPs1jHpWZbBk019eFTWlnfrOi5ImgrIL3k=;
        b=TsHT//MmomLm6l254SPkKz3U0mh4A1bG93QHq5DgmFoU9HxJ81z+rhRlNlPhw88yoO
         OqwVSLg41YRz2cErH8OkqtRm57bXSaxAn2XT7jWlzUZwTl1lNxMDgTjR7GV/wSLcgQD2
         0ShnNguKmtDZuQqJh3eQZGnLjSD4YHDwHoKWW0w30gejS7SGllEa+6VUKltQdhHNhjMT
         xijKKZ5MPVDt9cGi4AiLHX1zv9P79KvxyOBOYffIeIyHoaTzb91VhIKH4E8piAY3bRLd
         kSV1LdGHthvD3dwcP37AVDGlat4/Zbbav1vaEPKcX++DJfZ46oSCQoZ45Yw8fwR0bLKL
         gXNw==
X-Gm-Message-State: AOAM532j24fvBCsMNW6vgonFdMoLvYUaEJtgczJqu4NwzrScp/iPY4fL
        7XkvBDDgN5eWSQqpsRdvsHkESg==
X-Google-Smtp-Source: ABdhPJzJBk2al5a+6xPTp54k5r6OKc+tXDJZDrakir0HnQ3ZfCLIoZ94Fr1LkWLyKy2xviUdy+PGDw==
X-Received: by 2002:a05:6638:3049:: with SMTP id u9mr3479188jak.57.1615391821733;
        Wed, 10 Mar 2021 07:57:01 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q6sm9641200ilm.66.2021.03.10.07.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 07:57:01 -0800 (PST)
Subject: Re: [RFC PATCH] mm: fork: Prevent a NULL deref by getting mm only if
 the refcount isn't 0
To:     Filippo Sironi <sironi@amazon.de>, linux-kernel@vger.kernel.org
Cc:     dwmw@amazon.co.uk, christian.brauner@ubuntu.com,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        peterz@infradead.org, keescook@chromium.org, krisman@collabora.com,
        peterx@redhat.com, surenb@google.com, shakeelb@google.com,
        guro@fb.com, elver@google.com
References: <20210310123703.27894-1-sironi@amazon.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4130ef8d-7b97-f63d-00fc-0ee2b494e1d0@kernel.dk>
Date:   Wed, 10 Mar 2021 08:57:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310123703.27894-1-sironi@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 5:37 AM, Filippo Sironi wrote:
> We've seen a number of crashes with the following signature:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000000
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     ...
>     Oops: 0000 [#1] SMP PTI
>     ...
>     RIP: 0010:__rb_erase_color+0xc2/0x260
>     ...
>     Call Trace:
>      unlink_file_vma+0x36/0x50
>      free_pgtables+0x62/0x110
>      exit_mmap+0xd5/0x160
>      ? put_dec+0x3a/0x90
>      ? num_to_str+0xa8/0xc0
>      mmput+0x11/0xb0
>      do_task_stat+0x940/0xc80
>      proc_single_show+0x49/0x80
>      ? __check_object_size+0xcc/0x1a0
>      seq_read+0xd3/0x400
>      vfs_read+0x72/0xb0
>      ksys_read+0x9c/0xd0
>      do_syscall_64+0x69/0x400
>      ? schedule+0x2a/0x90
>      entry_SYSCALL_64_after_hwframe+0x44/0xa9
>     ...
> 
> This happens when a process goes through the tasks stats in procfs while
> another is exiting.  This looks like a race where the process that's
> exiting drops the last reference on the mm (with mmput) while the other
> increases it (with mmget).  By only increasing when the reference isn't
> 0 to begin with, we prevent this from happening.

From a quick look it looks reasonable, but I don't quite see how we get
in the situation of finding a valid ->mm under task_lock() and the
mm_users count being 0? I'd like to understand that, because it may just
be that your patch just narrows the gap but it's still possible to
trigger a use-after-free. Doesn't seem like that would be possible under
exit_mm().

-- 
Jens Axboe

