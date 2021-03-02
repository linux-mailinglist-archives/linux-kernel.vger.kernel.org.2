Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CDD32A3E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577718AbhCBJwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838186AbhCBJbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:31:05 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679D3C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 01:21:15 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id r5so9510576qvv.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 01:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwRL+zg0sY1QI/aDS9tQBo/9/k6q6jsJr21NnguWVBI=;
        b=Gdg7LlV9KTMCHNPEerej0NoU4fufDpYllG9eP8gSI0Y59DAync1sFK8G8dRPBqhLcu
         n/Neic57sVkPsdrKtFEWL/DhdlMG8bIvqFPb/Oto0y7wA6Np/nFdBehh/7/2WYXiaW9/
         PUWgCXdI893sti3BPKa0u3WEivJzBWOBz65gJ0cHl8Tqq/anY/kXvtaJXHeB/ONDKDDF
         tpfnKWPZV55J8diU/JQpIkQXORqbpEFuAd5qWqJJw0StaGBcrmHdOv/lI7AYDkYorFuM
         3rP9xZ98HT3e3b1BVG+gRYRqxVBvHJAQfO9xHKnpx+YGSUudDn9U2OZaIyGaCusWpVZI
         vIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwRL+zg0sY1QI/aDS9tQBo/9/k6q6jsJr21NnguWVBI=;
        b=bqKVoP5sqBhdI6NDQO2wbIy2qXzdroJZA7xuHPjFPo4ILgH1e8iihNAp4fjUa3TvtN
         sYg2cI0nL8Z+2w5eoGl5KCVO4Tb+K9DnacUHuSH72YEHmDl/kW/HCuAXkO0aqPuKF26D
         i8sPuzvmzyFww6OyEP+NLCbkQDVVrwBcenzRd1yxwNQVUfReum6QomwWFB0Sh2djuFBz
         xbrO9WuAgpIhkkBllZK3DzwffXcbOuaW2eblPNcDN3WZWm2B0OUmicZtODYbVlZK9kKw
         u+sYaEMFxcVvjxpDl1KQyM9JH6zqRb2m5/vXF+HFkt4BG6PFyWZLEOQfmmyhA0v3czkL
         KiEw==
X-Gm-Message-State: AOAM5323jxY3xBAC6rnowDb+L52fuw8zmoTdcoun2V7ci2Tk5zXlm3Xt
        WQYPxEOA56Am1d9r/cPO8zYrXaJQfNFhujVdxUUL5w==
X-Google-Smtp-Source: ABdhPJyHK6+xXF6lJrMdstX68u8D/GfsYLqjaCK/7e5wYKfaW5WYj/VJmdv8pUTr7VMur6NN61/WYCIvcECXjtHKruw=
X-Received: by 2002:a0c:9a04:: with SMTP id p4mr2656029qvd.38.1614676874297;
 Tue, 02 Mar 2021 01:21:14 -0800 (PST)
MIME-Version: 1.0
References: <51c397a23631d8bb2e2a6515c63440d88bf74afd.1614674144.git.christophe.leroy@csgroup.eu>
 <CANpmjNPOJfL_qsSZYRbwMUrxnXxtF5L3k9hursZZ7k9H1jLEuA@mail.gmail.com> <b9dc8d35-a3b0-261a-b1a4-5f4d33406095@csgroup.eu>
In-Reply-To: <b9dc8d35-a3b0-261a-b1a4-5f4d33406095@csgroup.eu>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Mar 2021 10:21:02 +0100
Message-ID: <CAG_fn=WFffkVzqC9b6pyNuweFhFswZfa8RRio2nL9-Wq10nBbw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] powerpc: Enable KFENCE for PPC32
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Marco Elver <elver@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [   14.998426] BUG: KFENCE: invalid read in finish_task_switch.isra.0+0x54/0x23c
> [   14.998426]
> [   15.007061] Invalid read at 0x(ptrval):
> [   15.010906]  finish_task_switch.isra.0+0x54/0x23c
> [   15.015633]  kunit_try_run_case+0x5c/0xd0
> [   15.019682]  kunit_generic_run_threadfn_adapter+0x24/0x30
> [   15.025099]  kthread+0x15c/0x174
> [   15.028359]  ret_from_kernel_thread+0x14/0x1c
> [   15.032747]
> [   15.034251] CPU: 0 PID: 111 Comm: kunit_try_catch Tainted: G    B
> 5.12.0-rc1-s3k-dev-01534-g4f14ae75edf0-dirty #4674
> [   15.045811] ==================================================================
> [   15.053324]     # test_invalid_access: EXPECTATION FAILED at mm/kfence/kfence_test.c:636
> [   15.053324]     Expected report_matches(&expect) to be true, but is false
> [   15.068359]     not ok 21 - test_invalid_access

The test expects the function name to be test_invalid_access, i. e.
the first line should be "BUG: KFENCE: invalid read in
test_invalid_access".
The error reporting function unwinds the stack, skips a couple of
"uninteresting" frames
(https://elixir.bootlin.com/linux/v5.12-rc1/source/mm/kfence/report.c#L43)
and uses the first "interesting" one frame to print the report header
(https://elixir.bootlin.com/linux/v5.12-rc1/source/mm/kfence/report.c#L226).

It's strange that test_invalid_access is missing altogether from the
stack trace - is that expected?
Can you try printing the whole stacktrace without skipping any frames
to see if that function is there?
