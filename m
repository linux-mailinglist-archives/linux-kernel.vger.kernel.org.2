Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FFE3DF982
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 04:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhHDCCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 22:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbhHDCCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 22:02:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E16C061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 19:01:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ec13so1579040edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 19:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OQYuCzODGsyt/DqKxZOBjYjUO0WZANTojPvfkOL4rQ=;
        b=je0WvXR42DZrGfIyJqkwj9wuQGH2H9H70uJNtg7JBiUYNAVDbdO7Fkkpl5Bf4Sfbq/
         rqhwGp5yhtZugm73fIOtkQj3oagsGwMgIUWZ/CTLdTqe3rSFLtjjJTIC+mtLwx04hH5w
         D2AYpAmYMSjWror3Se8f4gKV0iyUliUoinpIbWnLH/d6yaM+ECKkbtR+/dIGieu+6pYc
         ULiPGwRV6wcvOy7XGeVx6ZOXEHXvd8S1nazEkVg6tXsgDtCKl5tGh1LoNDWezCYOlwBU
         M0wzL06fhCAW7A5g90U6/NhiUlil/qYxmxjXhz5iXTB3LW3D4uMJjoWHJdYy9Q+YtR0J
         7plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OQYuCzODGsyt/DqKxZOBjYjUO0WZANTojPvfkOL4rQ=;
        b=oxAKCziT1nr37PB+UpViwEv/M+U0jPl3pVcFoHDnjYhE3BYJrQi88C8KJi+/EnQLah
         I5PuRCCMF/lm6+BBLM0e+xHq2MVti8NlTVTpIR4YloCuNg4YdAtER3KZvkLhEVReL9fE
         tqvIoeQ8+xq+LSTKsPEJvRNMcXKcMmTeY6tAOvbwkm0VDCqkaE4vwRlTQ5DnwZcHM7DF
         s4nKESjCtXgVjBq95PG8UDhk0kpvxedazdMIDX/0lOuAlNNfH1ZhA1yeVed1s8wF1X2x
         Ter+R9RjbQFHGopegU36jf1S4rYOS+hU1EXPou7PB1FIZgCWk1z4OGMokWct8GufphjQ
         wN2Q==
X-Gm-Message-State: AOAM532e1C+JoDtI4Nc8TH9hscZhWDfGV+d2hvaRzCemoTx7Y/8gYxmn
        R3ZIcUZJ/FnF5pxwGqsl84DA0ViDVPghkFTHkD0OzQ==
X-Google-Smtp-Source: ABdhPJxZbFpJ1tgAX1jlPGs7e04DxLljSzNXhdshECMp6vCfXJMH2Xvw8/B44B1iux6PUbwTalxzZCK+EkFn8C6HSUQ=
X-Received: by 2002:aa7:cd9a:: with SMTP id x26mr28987239edv.26.1628042516316;
 Tue, 03 Aug 2021 19:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626252248.git.zhansayabagdaulet@gmail.com> <071c17b5b04ebb0dfeba137acc495e5dd9d2a719.1626252248.git.zhansayabagdaulet@gmail.com>
In-Reply-To: <071c17b5b04ebb0dfeba137acc495e5dd9d2a719.1626252248.git.zhansayabagdaulet@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 3 Aug 2021 22:01:20 -0400
Message-ID: <CA+CK2bAskx+z49d=MbMJUXh8+3zCRi8c1-uDixw7g8gmrunYPw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] selftests: vm: add KSM merging across nodes test
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     shuah@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 4:56 AM Zhansaya Bagdauletkyzy
<zhansayabagdaulet@gmail.com> wrote:
>
> Add check_ksm_numa_merge() function  to test that pages in different NUMA
> nodes are being handled properly. First, two duplicate pages are allocated
> in two separate NUMA nodes using the libnuma library. Since there is one
> unique page in each node, with merge_across_nodes = 0, there won't be any
> shared pages. If merge_across_nodes is set to 1, the pages will be
> treated as usual duplicate pages and will be merged. If NUMA config is
> not enabled or the number of NUMA nodes is less than two, then the test
> is skipped. The test is run as follows: ./ksm_tests -N
>
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
