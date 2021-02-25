Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BACC324847
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 02:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbhBYBEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 20:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbhBYBDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 20:03:16 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17DBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 17:02:20 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id m188so3742030yba.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 17:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dPwaQKc+YAgqasBGonL3+jz4LVxfJwN50MPbsWfhBfM=;
        b=WNVFh7n6J5tyhoXjIzu2o6Rs/3ODpYsSiM1D5wisn8dycV5Zbf77ibEf0enMP32oO6
         g7IRpeawZnTctzo/XHLbSptmrPkXP2Q/2sntlruwbTV0ooO3D89JwiBgwX79yA7SEkX4
         do8t8HzAqQlwCEzREIRLw2TWmt6CvtOQ/N5+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dPwaQKc+YAgqasBGonL3+jz4LVxfJwN50MPbsWfhBfM=;
        b=bj+XR6LlW3SXv3aJfCtYaP4eptiBGtwuOB/dWpdoTvLw9fq1LPeLM4/QR6oOv3uNdn
         /aRe8+w337lHO3xicNIYKCMTvnI6bFNdpaE96XFZDSKIhpyks+SKKGprGj8mXymd8puY
         szN1C6WnQvuK9BHP1FrJ8l5Y1YysWN1bx0RoHKaVZm2LD2G0W8eyAuxSm7/eY8+0hqUV
         NHhDQIL2cEYnKVbC329LWDbGvR04X+Tf1sQ9QxrweX2cIyqiEOnv0MUxuEF0+3lmRMEO
         msfq4ffoOFZkBDpQwM4wmNC0skESDfnn7ci/6j/dlHeY2quhFYqPMXdKk5NxW6moFdUP
         c+4g==
X-Gm-Message-State: AOAM532V7kOByN+F13DXzqc90+shQOnSSbEkr4Vsjko1cnDoQXKDJYJA
        /LVlndBqQZMbfFC8BJf2Dvpu0zLh08G4w0XCwPtaVA==
X-Google-Smtp-Source: ABdhPJxKueZKS9jCvArBDGNf3xp6Bte2jd1BXmQ8uMB5UZUm+GUfxREcXNzsOB6pExwMrwWgFR+6Dg4wbsVkHA6Nvy0=
X-Received: by 2002:a25:ab11:: with SMTP id u17mr564982ybi.192.1614214939956;
 Wed, 24 Feb 2021 17:02:19 -0800 (PST)
MIME-Version: 1.0
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Wed, 24 Feb 2021 17:02:09 -0800
Message-ID: <CABWYdi1CU_04GJXC0fK4=Rs+a0117qBr=oZX_oGa=-hmSEH75g@mail.gmail.com>
Subject: Memory allocation issues after "sysctl: Convert to iter interfaces"
To:     kernel-team <kernel-team@cloudflare.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We started seeing allocation failures on procfs reads after
commit 4bd6a7353ee1 "sysctl: Convert to iter interfaces".

I haven't done a full bisect, but the decoded stacks point
squarely at the following piece of code which was introduced:

kbuf = kzalloc(count + 1, GFP_KERNEL);

Previously reading /proc/sys/net/core/somaxconn required order 1
and order 3 allocations from the kernel, which can be seen from:

$ sudo perf record -g -e kmem:mm_page_alloc_zone_locked -- \
    cat /proc/sys/net/core/somaxconn

Now we see order 6 + order 6 allocations from cat, and even:

read(3, 0x7f8d9d3f3000, 131072) = -1 ENOMEM (Cannot allocate memory)

See the following gist for full allocation stacks on 5.4 and 5.10:

* https://gist.github.com/bobrik/dd03cce0aaeef5acd5faecc32bd44530

This seems like a regression, and unprivileged users being
able to force order 6 allocations onto the kernel doesn't feel good.
