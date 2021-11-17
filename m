Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FFC454D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbhKQSyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbhKQSya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:54:30 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F19FC061766
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:51:32 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 28so3050452pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YMm7uqc0PVoZ5CKUw9P95CjYEyE4WkTA6NNCCrs9xIk=;
        b=WSeVLf0WoWRPuWMFmJfO/1Sv1V44Dthw2bD8KQUn6ImGf1LCbzwoKatBL8My9+PWzi
         BVE9VI6Ez3QFzNaVT6KtRDOQp1ziApY8DPqftRX+V9PXePgc0brzwXGb7pj1BQbO+YOm
         Pf8FxsTEyrMX0999e7vBYfcmKbyfeTGgVEsWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YMm7uqc0PVoZ5CKUw9P95CjYEyE4WkTA6NNCCrs9xIk=;
        b=HA0PGKq7Zc6iG5LDIIgUPMx3DF8u969o7kgKejysl86whrRaFjpsr9lzsfVckQHq8k
         ecW3PQCtOxIIyUpOGiFnUDCD02PrnEcEf0/1/OinwrQQJazRZ2nGGJmBEqpHQeakZdZ6
         6pn2OkjMcL0PehocizwV+KixEDsx2NVDTUiIZQqB+w2n1JWPY+/L+HNHhdNXh2cYSCBN
         /RdsaScAk+GZqua9cBmNm5EMhVBInv8Oj9CiPjfjD09FU9kBOYYhg7Bz7uGUK7JE+NO+
         g0JcKtTWRk8OdbCeiTCp/hXzAaZCemXEibx8TP9m7sklpCt2vTYD/gWRXCTO2IMop5eZ
         QO1w==
X-Gm-Message-State: AOAM532oY2XeCKtRmIzAoa1lplXQbGLIk4rC7JALxHYCyEc0OUvuLmrW
        hitNOotaX/deaI+bSsw8aC2aHQ==
X-Google-Smtp-Source: ABdhPJzegaq20Wc2oLUBixdUIX3fnDf0TFKeDD46xxqB6a0a/DVlPYO5Xe1+GZALYnEX4GfVGrsXfg==
X-Received: by 2002:a63:ea4e:: with SMTP id l14mr6827570pgk.406.1637175091571;
        Wed, 17 Nov 2021 10:51:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o6sm361555pfh.70.2021.11.17.10.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 10:51:31 -0800 (PST)
Date:   Wed, 17 Nov 2021 10:51:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kyle Huey <me@kylehuey.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Robert O'Callahan <rocallahan@gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
Message-ID: <202111171049.3F9C5F1@keescook>
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 10:47:13AM -0800, Kyle Huey wrote:
> rr, a userspace record and replay debugger[0], is completely broken on
> 5.16rc1. I bisected this to 00b06da29cf9dc633cdba87acd3f57f4df3fd5c7.
> 
> That patch makes two changes, it blocks sigaction from changing signal
> handlers once the kernel has decided to force the program to take a
> signal and it also stops notifying ptracers of the signal in the same
> circumstances. The latter behavior is just wrong. There's no reason
> that ptrace should not be able to observe and even change
> (non-SIGKILL) forced signals.  It should be reverted.
> 
> This behavior change is also observable in gdb. If you take a program
> that sets SIGSYS to SIG_IGN and then raises a SIGSYS via
> SECCOMP_RET_TRAP and run it under gdb on a good kernel gdb will stop
> when the SIGSYS is raised, let you inspect program state, etc. After
> the SA_IMMUTABLE change gdb won't stop until the program has already
> died of SIGSYS.

Ah, hm, this was trying to fix the case where a program trips
SECCOMP_RET_KILL (which is a "fatal SIGSYS"), and had been unobservable
before. I guess the fix was too broad...

-- 
Kees Cook
