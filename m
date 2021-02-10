Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16FC3171A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhBJUqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhBJUpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:45:09 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DD2C06178C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:44:22 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id m2so2023786pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMVGhI9++wS+Kt4DIl8uy7OJgJhgaTXof7QAYp/rX/s=;
        b=D/NgsJvYNnPktQ2xK8HvwiC30gvulg+54GQeol4ZNq0srigvxnCfhpME6D/XguddvK
         6KSpxrMLrciruY9sNXrk3YvPOH/20RopXdwEFOSeO7Fq1ko5lfwwLxdAIgdW1jpQ6QLk
         mFXkvV/nLQkjG4mfYp/U1d8n1KCG6jv93aviI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMVGhI9++wS+Kt4DIl8uy7OJgJhgaTXof7QAYp/rX/s=;
        b=tAacfB2wfcskS5OGr2zRSMN5tDPx1VS9lEx/J4WCV9ZlTZM+43O8HeKbIuNTffbelf
         3JUS/fZYCdCSnXS1LaSRHM7+QkXx0IbOik/Wip42Fs6PYptHMsV0De2a5B8uSMT/dizK
         uvA9c1u0vQsLyZNGx/OcjvDBkgTPg/ZfP9MqW3KwroM7M0QMujGSRq0cZ/kUV1pcnxcA
         Cj1qL0UxXgu0pmbOsATkim4NqJMRy9lDSULP+AhD4EfJpH4t0Eh0Qqw/RMmif0Lhhq44
         Dafu95YHQ57eoYEMn1MiCXvE6lUQWPXmD3AbQWe4fFWDUJ5BxUZBX2bFSeEJ/XMv/cHs
         9xOQ==
X-Gm-Message-State: AOAM5336bIGa8WYhxj1yGMDBFizS7fvpwyivYcrIRLRLdz8V0mqkJrPQ
        Zyxbr4e+kXI6UqalkRG89/8xOQ==
X-Google-Smtp-Source: ABdhPJyYhZykAX8Eic//chi7N7csGZxtVY9QVjUmn4AhnOhq/8mIzgSuJoHTyraUUVDxsigJ98HMBw==
X-Received: by 2002:a65:5b47:: with SMTP id y7mr4708626pgr.221.1612989861966;
        Wed, 10 Feb 2021 12:44:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b6sm2763247pgt.69.2021.02.10.12.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:44:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     wanghongzhe <wanghongzhe@huawei.com>, luto@amacapital.net
Cc:     Kees Cook <keescook@chromium.org>, bpf@vger.kernel.org, yhs@fb.com,
        netdev@vger.kernel.org, ast@kernel.org,
        linux-kernel@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com, kafai@fb.com,
        kpsingh@kernel.org, john.fastabend@gmail.com, wad@chromium.org
Subject: Re: [PATCH v2] seccomp: Improve performace by optimizing rmb()
Date:   Wed, 10 Feb 2021 12:44:07 -0800
Message-Id: <161298984230.3996968.4640881413498941015.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1612496049-32507-1-git-send-email-wanghongzhe@huawei.com>
References: <1612496049-32507-1-git-send-email-wanghongzhe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 11:34:09 +0800, wanghongzhe wrote:
> According to kees's suggest, we started with the patch that just replaces
> rmb() with smp_rmb() and did a performace test with UnixBench. The results
> showed the overhead about 2.53% in rmb() test compared to the smp_rmb()
> one, in a x86-64 kernel with CONFIG_SMP enabled running inside a qemu-kvm
> vm. The test is a "syscall" testcase in UnixBench, which executes 5
> syscalls in a loop during a certain timeout (100 second in our test) and
> counts the total number of executions of this 5-syscall sequence. We set a
> seccomp filter with all allow rule for all used syscalls in this test
> (which will go bitmap path) to make sure the rmb() will be executed. The
> details for the test:
> 
> [...]

Applied to for-next/seccomp, thanks!

[1/1] seccomp: Improve performace by optimizing rmb()
      https://git.kernel.org/kees/c/a381b70a1cf8

-- 
Kees Cook

