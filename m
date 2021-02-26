Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D1E32694A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBZVQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBZVQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:16:12 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318BEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:15:32 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u11so5940321plg.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1DCugY7nfGPlh0RsF/P/DUQ/DpETMGZNMe6SSWPONk=;
        b=ETnajUSpyPDXlQiMPMpvJQjrFljugoohqFjR7dfUvU68cqUNbueOrgmyDurxqzOC6f
         B0tff3iVjEx+Uz4LQJOEpieGmDTEGvuNIs0m81pNtRYxChqGZfflyM1txFl+2YKzHfKo
         R0eGySN4teux/RCpImQ5qDpJAZvS4h9zKOGXkipkBSMKXkKqmKzmE2ORb/spDhkm3Bs2
         LXOLeSsEdgCUVJFA/xGwWiFGgQz/8FemOI67VseRRJyn0v811KGAhQb3nfUzR9xdQGwC
         21TJ+mwrlGh9B3Bc/0mCZv29gfdd7ZKUAUW+n/2//qDJzZfn0sb/QZkBlg52f+9uHf0/
         IJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1DCugY7nfGPlh0RsF/P/DUQ/DpETMGZNMe6SSWPONk=;
        b=dGZeEFSc8/CTd4ZyUCIzvOplMWhcVP3B/r1XjEUYPLSdV2K5pBk0lzgmJvnXHYk1tr
         DllE38322aAtlsTMECRUScFS4skwtBx2UfsW/AVvzh0SVnRbFtR3WD5MK6W7QODYBGwB
         HFdhjqUeXrG7t+81woxiYZT3eMwbAx4r8cNmWFPtHz0zVXEUjHpDMMl9cVdGkzA4noa/
         My8tgREDkc9KfYVqxiWK6fTCc+UNzbGooSr8kZNs0hgiv+zP5YvXwDsqE7jxgDyHIr7x
         3MRm0xfiO/VCaKFvDpHUnK4lZRiG6mQeu6YwuS8aZYKgvfEeOPMeA93rLeDRi7WfZNSl
         YMTQ==
X-Gm-Message-State: AOAM533nhmWWanoRg7GVXZGx90qKWvgqOtiziP6E1ZNw1o8rn8K+idPh
        gfxq5asnRMYlSpx5uKSlBSCcarIwpYmjPfu6flP1Kw==
X-Google-Smtp-Source: ABdhPJwgWrxD4a9n0QqaXmwRN3ppKgZODWrAWUEMdrhfNFlIG5pmeWEVZ9zmATpNJt9ZvEC/8EbU+jCGq7XIhEr+9PE=
X-Received: by 2002:a17:90b:4d05:: with SMTP id mw5mr5274229pjb.217.1614374131505;
 Fri, 26 Feb 2021 13:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20210223054930.2345555-1-davidgow@google.com>
In-Reply-To: <20210223054930.2345555-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 26 Feb 2021 13:15:20 -0800
Message-ID: <CAFd5g458LTmSZ98WGcMSGzd2LnxeLdOj2U2KU3mN-DBNsz9fkA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix a python tuple typing error
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 9:49 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> The first argument to namedtuple() should match the name of the type,
> which wasn't the case for KconfigEntryBase.
>
> Fixing this is enough to make mypy show no python typing errors again.
>
> Fixes 97752c39bd ("kunit: kunit_tool: Allow .kunitconfig to disable config items")
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
