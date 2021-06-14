Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6AD3A6A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhFNPeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbhFNPel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:34:41 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCFDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:32:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id i34so8925780pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R+pPQfYM0fffh9cjmlnt9HFr67UUmTUGUU/ksxJg7tk=;
        b=W9RKslR5HCM95X0ufqGm7hjIHfFU7Yzej7alamLbz2gojqnWJRqJe9Xh4G8slFcl/J
         ioI9TnccXkr0QbIVvO3tB7jNWmllRxGDEX+Rd/WqZiXkxqeB+ROKmP2CfQ99OntOB7dh
         i4A1jh4yDIskftlbNiKAjlrq5anjTPbElj/CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+pPQfYM0fffh9cjmlnt9HFr67UUmTUGUU/ksxJg7tk=;
        b=GdBBH8UqOJbZcz85OI6TymJOPq5yipFQxRTqEUMXnX6uix42AAGoA5VVSHazgTkaBn
         hs0Uog10rrhNgJ154kwRIuzJ0psX/jcqZy4plsjEzJEPR01GLvt/+4zb9wsTR6nJqOVY
         qTHBv1NixDEoI4l5M7Q6R870kIFieaEP+CLm2aexP9kse4fpiwsvFL4N58+8mVrBq3zY
         LRfByUVQAfrOQvCEvogtHafeyjqL5B0uVY38qkR/grCYR4ISsr7n8xKhjs3HS6ohndPM
         JH0j3dOQLPp/ogFXdMfjICnGncdLXhwjf27zu54TnqdfjCBQdvGDtjFq60J7/FI63P8W
         4tUg==
X-Gm-Message-State: AOAM533HaAFwLgD+Wiwez9dQKRgtKV6Ngw7EqnXaZ1FXzV1IL2pzUYfD
        4FHaG5FZb8wOcqSPDw4n82kFXQ==
X-Google-Smtp-Source: ABdhPJwRKSTFDrtLbbhu7qg1vjwtmANL3p/lLYA+HjQfn45D25x/E/AMB0/789UHIXQJt/CH5fx2UA==
X-Received: by 2002:aa7:8588:0:b029:28e:dfa1:e31a with SMTP id w8-20020aa785880000b029028edfa1e31amr22108973pfn.77.1623684757307;
        Mon, 14 Jun 2021 08:32:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w25sm147164pgk.55.2021.06.14.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:32:36 -0700 (PDT)
Date:   Mon, 14 Jun 2021 08:32:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     youling257 <youling257@gmail.com>
Cc:     torvalds@linux-foundation.org, christian.brauner@ubuntu.com,
        andrea.righi@canonical.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] proc: Track /proc/$pid/attr/ opener mm_struct
Message-ID: <202106140826.7912F27CD@keescook>
References: <20210608171221.276899-1-keescook@chromium.org>
 <20210614100234.12077-1-youling257@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614100234.12077-1-youling257@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 06:02:34PM +0800, youling257 wrote:
> I used mainline kernel on android, this patch cause "failed to retrieve pid context" problem.
> 
> 06-14 02:15:51.165  1685  1685 E ServiceManager: SELinux: getpidcon(pid=1682) failed to retrieve pid context.
> 06-14 02:15:51.166  1685  1685 E ServiceManager: add_service('batteryproperties',1) uid=0 - PERMISSION DENIED
> 06-14 02:15:51.166  1682  1682 I ServiceManager: addService() batteryproperties failed (err -1 - no service manager yet?).  Retrying...
> 06-14 02:15:51.197  1685  1685 E ServiceManager: SELinux: getpidcon(pid=1695) failed to retrieve pid context.
> 06-14 02:15:51.197  1685  1685 E ServiceManager: add_service('android.security.keystore',1) uid=1017 - PERMISSION DENIED
> 06-14 02:15:51.198  1695  1695 I ServiceManager: addService() android.security.keystore failed (err -1 - no service manager yet?).  Retrying...
> 06-14 02:15:51.207  1685  1685 E ServiceManager: SELinux: getpidcon(pid=1708) failed to retrieve pid context.
> 06-14 02:15:51.207  1685  1685 E ServiceManager: add_service('android.service.gatekeeper.IGateKeeperService',1) uid=1000 - PERMISSION DENIED
> 06-14 02:15:51.207  1708  1708 I ServiceManager: addService() android.service.gatekeeper.IGateKeeperService failed (err -1 - no service manager yet?).  Retrying...
> 06-14 02:15:51.275  1685  1685 E ServiceManager: SELinux: getpidcon(pid=1693) failed to retrieve pid context.
> 06-14 02:15:51.275  1692  1692 I cameraserver: ServiceManager: 0xf6d309e0
> 06-14 02:15:51.275  1685  1685 E ServiceManager: add_service('drm.drmManager',1) uid=1019 - PERMISSION DENIED
> 06-14 02:15:51.276  1693  1693 I ServiceManager: addService() drm.drmManager failed (err -1 - no service manager yet?).  Retrying...
> 

Argh. Are you able to uncover what userspace is doing here?

So far, my test cases are:

1) self: open, write, close: allowed
2) self: open, clone thread. thread: change privileges, write, close: allowed
3) self: open, give to privileged process. privileged process: write: reject


-- 
Kees Cook
