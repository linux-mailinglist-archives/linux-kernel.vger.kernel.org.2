Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302B8379288
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhEJPYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhEJPXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:23:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E366C04686E
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:57:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id zg3so25000734ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=f2JnqweJIfSd6LQ8EPIWiAKNItoboLHhQmvENtw3fGA=;
        b=fJ5QX8QyyDydhJgvmYnV/Fx/KQk0nuRWucA9AHSa04/YgeaZG/SCjSduWq2ga/q1+U
         m8CDb70flkViXYAMtpRpUv1ZSnQiOcEAuzIhDi025GEtAf1xbEq57s1qs9VMrrZ7ETc0
         svQLWNXdhVfIqCJuXP2cMowr8eqgYk3PffhKha8KErPLmb3qMdWQe+vKVxrtSiZOLJZd
         GIxrtOj+ZRnd0lCcGa/1T33UEc+6LJA08xUIkMTsAbNGLRNp537SzkZxLVhdhyNYzCXU
         MkKukHhMzS2DNvV5hRC0zd93jZe8JC+JUJYqt1RBhDQSN91mGsfdJotflZpJSg8HKxKu
         nk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=f2JnqweJIfSd6LQ8EPIWiAKNItoboLHhQmvENtw3fGA=;
        b=C/V3E5JeRcT/wthW9Shkpzu9j4dNF5/oj8mRaWQqYLcU6+HgKNOVCTK7GA14bE4SFt
         pWEmwv8SdCumwEne8aRtt4MtjF/kcsosrZp5q2H9RRmWKrtITMajeQgdSaQWYMXeb9dc
         Hk2bAU7lYh5BDgmSg4yg+epxeb4qwdBCQ71PeaX5XdxXRAY5l5b4JmA2SxT/cVc8StHF
         qx4uYTNQn+/twN6pU0zuwQA/Q8RzOy4kB9CT+eIFX5x0FSDVjt4Mx4ZDLgJXaAq23YvG
         i0eW4n8nUpOxCYrT9vsAVJCYL6rW0ZseitiV/Ohpa08QWwDOYkROE+32rvSnUtrKJ8+R
         UmTg==
X-Gm-Message-State: AOAM533PGCcKHUYbMgMimbBi+0fGSUghqAiJ5A7sS3qQRTbWjtJQPyWx
        IYjUDtYb/glEvQLdrvaE8ENGsWBhfiu2PdWjhJYjjEdafWB6u/Q1
X-Google-Smtp-Source: ABdhPJw3fgQsWMwpVMBXeuRT8yPmLHx3OalvK87l6mKLuGxwkrvbEn0CjGIWrkoiDgpIYWMXMQk0p/MVPxEKbOkCMNE=
X-Received: by 2002:a17:906:7487:: with SMTP id e7mr26967650ejl.106.1620658643874;
 Mon, 10 May 2021 07:57:23 -0700 (PDT)
MIME-Version: 1.0
From:   Shivank Garg <shivankgarg98@gmail.com>
Date:   Mon, 10 May 2021 20:27:07 +0530
Message-ID: <CAOVCmzGX54u4VLUSLt_yEM4E8MQNLwW4VTkNVurPXbCuQX6d_g@mail.gmail.com>
Subject: Profiling execution time for __alloc_pages_nodemask
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        sergey.senozhatsky@gmail.com, pmladek@suse.com, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone!

I want to profile the time taken to execute the __alloc_pages_nodemask
for different linux configurations/parameters.
To measure the execution time, I use the ktime_get() apis. I get the
ktime_get() on the top, and I want to do ktime_sub(ktime_get(),ktime)
and record it in a tracepoint.
However, the patch on implementation prevents the kernel from booting
up. I debugged the bug to find out that the issue recurs on adding
ktime_get() inside the __alloc_pages_nodemask path. So, that the
kernel fails to boot up ( and show the blank screen without any logs )
I'm using the Linux kernel 5.6.13 (5821a5593fa9f28eb6fcc95c35d00454d9bb8624)

Is it an expected behavior? or a BUG? Has anyone else faced the same issue?

Can you please suggest, what would be a good way to measure execution
time for page allocation (if not ktime_get)

Stay Safe!
Best Regards,
Shivank Garg
Open-Source Enthusiast and Student, IIT Kanpur
