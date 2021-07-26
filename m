Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A13D5A62
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhGZMwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhGZMwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:52:12 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D1C061757;
        Mon, 26 Jul 2021 06:32:40 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id p38so5029998qvp.11;
        Mon, 26 Jul 2021 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=zYuYTt9xi4PG3HSjDy3tIW6YhfgCZqmwzaknGvEr+NQ=;
        b=btB/C7CBPguwy7JGY8a1IH+pkPX1SpkRjWY0OvT6PcHOsAE74F1bDp/xwpw/8eoRi/
         VQEyE6dHNGw95HcmdiIlEx3sikCFLAjX/EpWL3wcUiG2lT8UzNO4Lf3IgB34vLfM2b6p
         yyGyBEXxwIFco64iVeTTL0dfrhZ8M7l19tGpQ3yn9U5ko3hxPSVzXv5asAr9TYS2hZry
         8YxzP0dhBoZRhxLFIi2rA9kaeJI8WqdOP0/aPUZImOemhdqnHG248wcxm/Mg+EXbItkR
         A51WmdZ79Nn03k1MEUllwtKuoi347Vk2eHkU3gw2HpVJf69sVz9ol9r0tQs/2hazELUi
         kNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=zYuYTt9xi4PG3HSjDy3tIW6YhfgCZqmwzaknGvEr+NQ=;
        b=OGAEVIy3w0BbN7dTEL62LKyJwg2qcMZ+KdVebIetEI8fBlcrloV2+JtReebTpQN2rH
         +i/NzufQdbCZBTDgjiope2QJx456KgEsjcGuUJgxpSEP1B8wBRLqjOa4Z9P7O9jsgzId
         uuSbMgcUcKkipEog6NmaIUEvbP7f4hYmgeVJ4CXL86dViGGNsXKzeGw/pHC6fGn5x093
         +wMcgQBDxJylh7ifJEm31JWJZM2aoYnhBmYTbKfNOEVg4mJgZPkFaPcAHGBRX0rRseqz
         pwKol8/pzW6Skd2OM446J3dhVsn1U4ASrmY5VOuGqKic+rzrAPI8y6NjZsOu8AGG78ra
         qd2A==
X-Gm-Message-State: AOAM530Q76GMpBWMVKo2WH66LmgHgcfU1tEjxyNUWZBi1j4f0UggTzhF
        pFBbVcU5XFpIyOW47qkm31M=
X-Google-Smtp-Source: ABdhPJxttjlXi0zlRh5X8OxWCjGb65aNuf1X/Ahl0WlinQ5Ewy6Ze3OqTZKp85DyjhMxsiPr7ERQZQ==
X-Received: by 2002:a0c:9ac7:: with SMTP id k7mr17930271qvf.49.1627306359555;
        Mon, 26 Jul 2021 06:32:39 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id d129sm18934460qkf.136.2021.07.26.06.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 06:32:38 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Dongjoo Seo <dseo3@uci.edu>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@Huawei.com>,
        acme@kernel.org, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendanhiggins@google.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        elver@google.com, fan.du@intel.com, foersleo@amazon.de,
        greg@kroah.com, gthelen@google.com, guoju.fgj@alibaba-inc.com,
        jgowans@amazon.com, joe@perches.com, linux-damon@amazon.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, mheyne@amazon.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sieberf@amazon.com, sjpark@amazon.de,
        snu@zelle79.org, vbabka@suse.cz, vdavydov.dev@gmail.com,
        zgf574564920@gmail.com
Subject: Re: [PATCH v34 00/13] Introduce Data Access MONitor (DAMON)
Date:   Mon, 26 Jul 2021 13:32:30 +0000
Message-Id: <20210726133230.1959-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723083042.2720-1-sjpark@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Fri, 23 Jul 2021 08:30:41 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Hello Dongjoo,
> 
> 
> On Fri, 23 Jul 2021 16:02:44 +0900 Dongjoo Seo <dseo3@uci.edu> wrote:
> 
> > Hello, I am new user of this amazing tool.
> 
> Thank you!  It's always great to meet a new user!
> 
> > I want to use this tool for Nvidia tx2 board with kernel version 4.9.140.
> > 
> > Do you guys have any timeline or update schedule for different kernel version compatibility?
> 
> I didn't have such a plan until now, but I think I can find a time slot to do
> one-time back porting of current DAMON on 4.9.140.  I think continuous support
> would be not so easy, though.  Nevertheless, if you need that, please feel free
> to let me know.  Once it's done, I will notify you.

Thank you for waiting.  I back-ported this patchset and another one for the
physical address space monitoring[1] on v4.9.140.  The source code is available
at DAMON development tree[2].

BTW, I can also agree to Greg's opinion.  For the reason, I also back-ported
the patches on latest v4.9.y[3].  I'd like to suggest you to try that first if
possible.  I also hope this patchset to be merged in mainline in near future,
so that NVIDIA be attracted by DAMON and thus forward-port their drivers on the
latest mainline version.

Nevertheless, DAMOS[4] and DAMON_RECLAIM[5] patchsets are not back-ported
because those need more works, and you are apparently interested in only the
monitoring part.

Please note that this backport is for only one-time.  In other words, I will
not backport the patches for every future 4.9.y release.  Nevertheless, if you
need another backport, please remember I'm here for you.

Finally, a disclaimer.  I did only minimal test for this, as below:

    $ git clone https://github.com/sjp38/masim; make -C masim/
    $ git clone https://github.com/awslabs/damo
    $ # monitor a virtual address space of a process
    $ sudo ./damo/damo record "./masim/masim ./masim/configs/zigzag.cfg"
    $ ./damo/damo report heats --heatmap stdout
    [...]
    88888888888888888888888888888888888888600000000000000000000000000000000000000000
    88888888888888888888888888888888888888600000000000000000000000000000000000000000
    44444444444444444444444444444444444444444444444444444444444444444444444444444200
    00000000000000000000000000000000000000288888888888888888888888888888888888888400
    00000000000000000000000000000000000000288888888888888888888888888888888888888400
    55555555555555555555555555555555555555422222222222222222222222222222222222222100
    88888888888888888888888888888888888888600000000000000000000000000000000000000000
    88888888888888888888888888888888888888600000000000000000000000000000000000000000
    [...]
    # x-axis: space (140021718388736-140021924798416: 196.848 MiB)
    # y-axis: time (247055083700-317341924740: 1 m 10.287 s)
    # resolution: 80x40 (2.461 MiB and 1.757 s for each character)
    $ # monitor the physcial address space of the system
    $ ./masim/masim ./masim/configs/zigzag.cfg &
    $ sudo ./damo/damo record paddr
    00000000000000000000000000000000000000000000000000000000000000000000000000000000
    00000000000000000000000000000000000000000000000000000000000000000000000000000020
    00000000000000000000000000000000000000000000000000000000000000000000000000000040
    [...]
    # x-axis: space (4294967296-136303345616: 122.942 GiB)
    # y-axis: time (356358198969-430518964169: 1 m 14.161 s)
    # resolution: 80x40 (1.537 GiB and 1.854 s for each character)

Hope you get some fun with these backports.

[1] https://lore.kernel.org/linux-mm/20201216094221.11898-1-sjpark@amazon.com/
[2] https://github.com/sjp38/linux/tree/damon/for-v4.9.140
[3] https://github.com/sjp38/linux/tree/damon/for-v4.9.276
[4] https://lore.kernel.org/linux-mm/20201216084404.23183-1-sjpark@amazon.com/
[5] https://lore.kernel.org/linux-mm/20210720131309.22073-1-sj38.park@gmail.com/


Thanks,
SeongJae Park

[...]
