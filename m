Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710513DFC38
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 09:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhHDHl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 03:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbhHDHl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 03:41:28 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160B0C0613D5;
        Wed,  4 Aug 2021 00:41:15 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f12so770849qkh.10;
        Wed, 04 Aug 2021 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=+YKN8zFIulxmNIlW3F0W91JQ1d2GvyA2/2s6T5fcLjA=;
        b=h+X3Tahl8foSVSHxt2y7HIFQH0IexcgUU3OGrFSOU1IilFE+BsDs4VTPwaNgbpKY5J
         dkIsSYDqDPp1pFXAr73L22WMYXdPCsPW4WLlK2iqAuphF6yLKem2lcOQEqXyhUA8oek9
         xSQ7y8RgNiCiRgGT2JtByjR/BxMg78Y5btA0HDx7tqO8Xl9JWBDo5Y2y1VmVq4h1QuU5
         RJTCkxAC9KJ6RHOwIO/V8Mmdc6N5mQPRPukjKuD3hAimpnqORR6zTGrmRYNlbQBI/3xf
         Fx/Blv67OzXMHDRLS6f556aV8UbnQRpqrQ1QLwIAs5O5eRk9teDmhHlixmU6CaTbJpQX
         Lrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=+YKN8zFIulxmNIlW3F0W91JQ1d2GvyA2/2s6T5fcLjA=;
        b=hET3csGQ3mKj5iuoTqY5KWT3PaAyDz2rw9siwplXZccefX0usLdlv8EzhP+XEnH1yC
         op439gSYNuwjwsEW880jRmJdvgRHZWzZHSZQ6vFbcHyBahg0BCHysuCFmSXtamJNL5dH
         cuWV9u7h5Z2tNcFK8tN1dVej/9TMv8JYdF6YM3TnbeYhOu8wd5ugolytyw5hw7SI/2vM
         mU0zFnsF6Sd9ODC1I0+mcluAbZ+KGYaz8hE095e1/xDqaM4oIeevPAidECfLb6XKBpKI
         H3uDNjz4FzeKjw2QKqUHUiWP6H5QCdQfVuELIie7dKfHz3G3t0b1oZ9ZevWZLJQV7EIh
         tmiw==
X-Gm-Message-State: AOAM5328IpY/hqdSID6Qh8xuI8ehuWl3Jzwm7Tp5Hu/DqxZ1NscC/sUc
        nEwJedQCsijwT8tbcO+adbY=
X-Google-Smtp-Source: ABdhPJwLdZO1sAy3jiAaknQrXnaR0L2WJdQu0ZfiPIgYHgAkdE1YZuIY/FL9pb4yUW2nrclDkLHkqg==
X-Received: by 2002:a05:620a:a8f:: with SMTP id v15mr24407916qkg.257.1628062874185;
        Wed, 04 Aug 2021 00:41:14 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id v11sm602529qtc.0.2021.08.04.00.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 00:41:13 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        amit@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        foersleo@amazon.de, Greg Thelen <gthelen@google.com>,
        jgowans@amazon.com, mheyne@amazon.de,
        David Rientjes <rientjes@google.com>, sieberf@amazon.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Wei Xu <weixugc@google.com>,
        Paul Turner <pjt@google.com>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v34 00/13] Introduce Data Access MONitor (DAMON)
Date:   Wed,  4 Aug 2021 07:41:07 +0000
Message-Id: <20210804074107.3021-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210802082424.19584-1-sjpark@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello Andrew,

On Mon,  2 Aug 2021 08:24:24 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Hello Andrew,
> 
> On Wed, 28 Jul 2021 08:36:43 +0000 SeongJae Park <sj38.park@gmail.com> wrote:
> 
> [...]
> > Now all the patches have at least one 'Reviewed-by:' or 'Acked-by:' tags.  We
> > didn't find serious problems since v26[5], which was posted about four months
> > ago. so I'm thinking this patchset has passed the minimum qualification.  If
> > you think there are more things to be done before this patchset is merged in
> > the -mm tree or mainline, please let me know.  If not, Andrew, I'd like you to
> > consider merging this patchset into '-mm' tree.
> 
> I'm wondering if you had a chance to consider that.  If you had the chance but
> this patchset didn't convince you, could you please let me know your concerns
> so that I can make some progress?

Because nearly three weeks passed since this patchset is posted, I considered
rebasing it on the latest -mm tree and posting it as v35.  But, apparently it
makes no much sense because we found nothing to fix or improve.  And, this
version can still cleanly be applied on top of the latest -mm tree.  So,
instead of merely increasing the version number, I'd like to describe why I
believe this need to be merged into the -mm tree and eventually the mainline.

1. Merging this patchset will not bother other developers

Most changes in this patchset are for DAMON-dedicated new source files.  There
is a change[1] for existing files, which makes PG_Idle independent of Idle Page
Tracking, but it is only small.  Therefore, merging this patchset will not
increase the complexity of the other parts or introduce a regression.

2. Merging this patchset will not bother other users

DAMON utilizes a mechanism that designed to minimize and limit the monitoring
overhead.  That said, DAMON can be opt out in the compile time for users who
don't want it.  Even though it is compiled, it does nothing at all unless a
user explicitly asks it to do some works.  Therefore, merging this patchset
will not silently introduce any additional overhead to users.

3. This patchset is deployed to real users

We are currently using DAMON patchset for profiling production workloads, as
described in 'Real-world User Story' section of the cover letter.  It is also
deployed to real users other than us via Amazon Linux[2,3].  A few companies
and several researchers outside Amazon have publicly and/or privately shown
their interests in DAMON.

4. The downstream-only maintenance overhead is significant

Following development works based on DAMON[4,5,6] are also ongoing.  Because
all the works are currently in downstream only, the maintenance overhead is not
small for us.  Once DAMON is upstreamed, the overhead will significantly be
reduced.

5. This patchset is reviewed and apparently is stabilized

Since the first version of DAMON patchset is posted (2020-01-20), it has
evolved a lot.  All patches of this patchset got at least one 'Reviewed-by:' or
'Acked-by:' tag by v31[7], which have posted about seven weeks ago
(2021-06-21).  After that, we found and fixed only minor issues.  We also got a
few more 'Acked-by:' tags.  Since v34, which has posted about three weeks ago,
we found no more issues.  We are also continuously running extensive
DAMON-dedicated tests.  The tests include unit tests, self tests, functional
tests, performance tests, and static code analysis.  Some of those are also
publicly available[8].

[1] https://lore.kernel.org/linux-mm/20210716081449.22187-5-sj38.park@gmail.com/
[2] https://github.com/amazonlinux/linux/tree/amazon-5.4.y/master/mm/damon
[3] https://github.com/amazonlinux/linux/tree/amazon-5.10.y/master/mm/damon
[4] https://lore.kernel.org/linux-mm/20201216084404.23183-1-sjpark@amazon.com/
[5] https://lore.kernel.org/linux-mm/20201216094221.11898-1-sjpark@amazon.com/
[6] https://lore.kernel.org/linux-mm/20210720131309.22073-1-sj38.park@gmail.com/
[7] https://lore.kernel.org/linux-mm/20210621083108.17589-1-sj38.park@gmail.com/
[8] https://github.com/awslabs/damon-tests


If you think above explanation makes sense, please consider merging this into
the -mm tree.  Else, if this doesn't convince you, please let me know your
concerns or what I'm missing, so that I can make some progress.


Thanks,
SeongJae Park

[...]
