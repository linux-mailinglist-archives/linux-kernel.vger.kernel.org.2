Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED5F3E2A0F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245726AbhHFLtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245710AbhHFLs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:48:56 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABF8C061799;
        Fri,  6 Aug 2021 04:48:39 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id s11so4706757qvz.7;
        Fri, 06 Aug 2021 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=jQzNEgWoNLcGvUsXmaU0Tm27zS2HEIPVDztBboCLbW0=;
        b=WvILx4Kzp4UlnLO6KfE2GgjlfnZ/KX7nPkGNRMF4GRXeYC6JVr+hqaKzjrDvLlCz/3
         jCVEo4tbCqDOcfLQLIFWBiNSjfbeZVdlMMk48h4xtSv5LzdnEXyRbzQ+i7HvVfXN1jPn
         J/ZLLEImIBBR+VvZU4RUVFzYqmH+j4TiI8VLnHA5sqoCYSgu2x+3SasoGK+zg6h9Kg98
         lS+CNCCgy6CqXU0kwNUctbjbLqQIytoWx6cUZvR80wLXvoFa3DQfcyRpNz6Wc7+CgHTr
         JF+HhgCRB7Qz4FsNVXLzV0v2ZSh3rtMjQsjjw/EAHSnSSGfQRRiekIWfAC/VXXEXXuaJ
         +rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=jQzNEgWoNLcGvUsXmaU0Tm27zS2HEIPVDztBboCLbW0=;
        b=MfnUsHA4fxk/Hj0EnqZq0N1QEW+4SKuF604QJJotbZP4L3CPTh7LSPzpS229gAiZHR
         kUPwiye66Hom3Shfde6ntDEmgrN5Qx8eGn80UPEjyW2V9mjPEgw46jB6/dEOdgZZMbOX
         RbDZCcGkrOMBthkXeN59kWuiy+j83wYe67Bf07A8W5ni3X2KhKFh7NLUM8MiATe/oDEg
         HS2jre3PXtPEYkuv6c/ImoSmm7GIA0zsnNe/XPRPJ9SlwjCWzDH/50AHWAwQQiU2571k
         30ahQBEoHhRSBXF2QyacIM7wdHCtoAZy6XstzHRnnaw6xdcd5TWaJzrcYm8TCMZCuZV3
         LYuQ==
X-Gm-Message-State: AOAM53335eHPMiC88gDQ80ZB4zAZsFzkywAc2k4/Gl6nDe5JE20CR+P7
        pNFN1/yZ7fNtEiWXZKS1c0E=
X-Google-Smtp-Source: ABdhPJy7i2ydG25snau8N1sDB2yOUShTQUmB+maPN0mEdYuv8CsVXqD44JGH7cK/jiM6+krywI2/Ww==
X-Received: by 2002:a0c:f24a:: with SMTP id z10mr10776533qvl.13.1628250518660;
        Fri, 06 Aug 2021 04:48:38 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id c15sm3245148qtc.37.2021.08.06.04.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:48:38 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, joe@perches.com,
        mgorman@suse.de, mheyne@amazon.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sieberf@amazon.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v34 00/13] Introduce Data Access MONitor (DAMON)
Date:   Fri,  6 Aug 2021 11:48:30 +0000
Message-Id: <20210806114831.7009-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805174324.2aaf0fb67cd19da893a86d80@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 17:43:24 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 16 Jul 2021 08:14:36 +0000 SeongJae Park <sj38.park@gmail.com> wrote:
> 
> > DAMON is a data access monitoring framework for the Linux kernel.
> 
> Merged, thanks.

Thank you!

> 
> Presumably there are companion userspace tools for DAMON.  Are they
> available?  Is there a plan to release and maintain these?

Yes, the userspace tool[1] is available, released under GPLv2, and actively
being maintained.  I am also planning to implement another basic user interface
in perf[2].  Also, the basic test suite for DAMON is available under GPLv2[3].

[1] https://github.com/awslabs/damo
[2] https://lore.kernel.org/linux-mm/20210107120729.22328-1-sjpark@amazon.com/
[3] https://github.com/awslabs/damon-tests


Thanks,
SeongJae Park
