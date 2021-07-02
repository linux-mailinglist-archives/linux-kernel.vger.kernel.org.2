Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8434B3BA2D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhGBPjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhGBPji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 11:39:38 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B99C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 08:37:06 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s17so11819741oij.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+VLKFncvgU6I1zgdctbWizUUnNNV82ncEScl2ekh8C0=;
        b=DYuviw9iG4YJ+xWixQweYfCi/rW5IAzECKr7dB/DnkPEbN/j9ny5fqnZXB7rRB8zlJ
         fBkmyT/9N2vVPk3vX1m8I9ltaBzUrf46jdERR0KDEmkYkyNsTdbGjtji3zNiazCDi7ue
         DP3fQT9ysol6mE6GHDAJ1QiEwTjhKZ7s6mpYv5/gM9JcC5M96J7FRyP5+uJ3X/fP06ip
         ToWqX6AItsB6qYJzRLgX4iiS3XBGG+1/NGltOFp/tbyhvT0I2fCulC6wzXdHsLSN7Mhx
         U/IeHC11oaobD2DnGKcROyXiyMp0Ywrj5eObK+hS/CZDAnxd17poTyiaGfnTCG/PJDoq
         GPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+VLKFncvgU6I1zgdctbWizUUnNNV82ncEScl2ekh8C0=;
        b=YtmohDvz8749jQS2/Meh28sgsV5HwZmy3NbUCn07eWkJFuqsuS5jqmglbSc7OPh+DT
         HetSkC2Sh6bWv817bap8GyV393OvJQQUqF6pHMcEfpnJxL+mGEHDVHEu3ELNY2Av5tKG
         P6a8aqZKFO3MUIOl6oAuNgGpDNc30JFIj4zEuYxt0wtcASez4mHhpOwtY+PwizsFMRTi
         9Fpm9QHuuLuTjfYJN8/NCArtHoRH5JaRQjhicGl6l+zfo8Md42caEViN/NgG1J7vyY+7
         7z/HoaZddaJml2qg6rLoUhlzzCXmLya2zSFUktiJ9JnikyK/IB20HR4SaBlFf+2HA4hX
         Z7Uw==
X-Gm-Message-State: AOAM530/pLzT3/E1OQiHVV+6HqkZkiD2qVDcwztI4tUfCiNBU2C2jvMB
        fF2aw7MNeUz7tpY1DweoxdA=
X-Google-Smtp-Source: ABdhPJypqSof/EyO4ABSDHoUYJ6ylT3iZ7ACmzehgDQFsWsIh+nviM/IAfBREkvr81dJ9OZXyhuMbA==
X-Received: by 2002:a05:6808:68d:: with SMTP id k13mr139435oig.83.1625240225452;
        Fri, 02 Jul 2021 08:37:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c4sm683427ots.15.2021.07.02.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 08:37:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 2 Jul 2021 08:37:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     glittao@gmail.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/slub: use stackdepot to save stack trace in objects
Message-ID: <20210702153703.GA3074165@roeck-us.net>
References: <20210414163434.4376-1-glittao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414163434.4376-1-glittao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 14, 2021 at 06:34:34PM +0200, glittao@gmail.com wrote:
> From: Oliver Glitta <glittao@gmail.com>
> 
> Many stack traces are similar so there are many similar arrays.
> Stackdepot saves each unique stack only once.
> 
> Replace field addrs in struct track with depot_stack_handle_t handle.
> Use stackdepot to save stack trace.
> 
> The benefits are smaller memory overhead and possibility to aggregate
> per-cache statistics in the future using the stackdepot handle
> instead of matching stacks manually.
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

With arcv2:allnoconfig, this patch results in:

Building arcv2:allnoconfig ... failed
--------------
Error log:
arc-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
stackdepot.c:(.text+0x43a): undefined reference to `__irqentry_text_start'
arc-elf-ld: stackdepot.c:(.text+0x43a): undefined reference to `__irqentry_text_start'
arc-elf-ld: stackdepot.c:(.text+0x45a): undefined reference to `__irqentry_text_end'
arc-elf-ld: stackdepot.c:(.text+0x45a): undefined reference to `__irqentry_text_end'
arc-elf-ld: stackdepot.c:(.text+0x468): undefined reference to `__softirqentry_text_start'
arc-elf-ld: stackdepot.c:(.text+0x468): undefined reference to `__softirqentry_text_start'
arc-elf-ld: stackdepot.c:(.text+0x470): undefined reference to `__softirqentry_text_end'
arc-elf-ld: stackdepot.c:(.text+0x470): undefined reference to `__softirqentry_text_end'

Guenter

---
# bad: [fb0ca446157a86b75502c1636b0d81e642fe6bf1] Add linux-next specific files for 20210701
# good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
git bisect start 'HEAD' 'v5.13'
# good: [f63c4fda987a19b1194cc45cb72fd5bf968d9d90] Merge remote-tracking branch 'rdma/for-next'
git bisect good f63c4fda987a19b1194cc45cb72fd5bf968d9d90
# good: [49c8769be0b910d4134eba07cae5d9c71b861c4a] Merge remote-tracking branch 'drm/drm-next'
git bisect good 49c8769be0b910d4134eba07cae5d9c71b861c4a
# good: [3b858fe26f206d3c65adfc06c4db473e2dcaacd2] Merge remote-tracking branch 'char-misc/char-misc-next'
git bisect good 3b858fe26f206d3c65adfc06c4db473e2dcaacd2
# good: [b7289b49bb2edbe261f3f9a554f02996a4d12c11] Merge remote-tracking branch 'cgroup/for-next'
git bisect good b7289b49bb2edbe261f3f9a554f02996a4d12c11
# good: [20bf25c2b863e97a2724092c234e1ce892f83e5c] Merge remote-tracking branch 'pwm/for-next'
git bisect good 20bf25c2b863e97a2724092c234e1ce892f83e5c
# good: [1446f64f402a42c74c60df7f255df666fe302412] linux-next-pre
git bisect good 1446f64f402a42c74c60df7f255df666fe302412
# good: [312d598a2ea9e0927c3ec1decf24d4f3693e06f1] Merge remote-tracking branch 'mhi/mhi-next'
git bisect good 312d598a2ea9e0927c3ec1decf24d4f3693e06f1
# good: [d266180aa2811c7b6a8cf3c44e40a8f02a543a23] Merge remote-tracking branch 'cxl/next'
git bisect good d266180aa2811c7b6a8cf3c44e40a8f02a543a23
# bad: [8cf245ab25c7db5c10e7f63dcff2ccf09ade5880] sh: convert to setup_initial_init_mm()
git bisect bad 8cf245ab25c7db5c10e7f63dcff2ccf09ade5880
# bad: [125069500be687630bcfe6daa80f5408912fc3ef] mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas-fix
git bisect bad 125069500be687630bcfe6daa80f5408912fc3ef
# good: [c6c08f08ff06799b2c84e2a6a6258537a323d584] hexagon: use common DISCARDS macro
git bisect good c6c08f08ff06799b2c84e2a6a6258537a323d584
# bad: [e50e7ac989f6c658fd7b28b14274ae230825b1f9] mm/slub: use stackdepot to save stack trace in objects-fix
git bisect bad e50e7ac989f6c658fd7b28b14274ae230825b1f9
# bad: [d1be1dcc08d3ba68331dd47cfdea155f016c79db] mm/slub: use stackdepot to save stack trace in objects
git bisect bad d1be1dcc08d3ba68331dd47cfdea155f016c79db
# good: [8bf985a45ac528b6bcfbbdec4c3c263240b34264] hexagon: select ARCH_WANT_LD_ORPHAN_WARN
git bisect good 8bf985a45ac528b6bcfbbdec4c3c263240b34264
# first bad commit: [d1be1dcc08d3ba68331dd47cfdea155f016c79db] mm/slub: use stackdepot to save stack trace in objects
