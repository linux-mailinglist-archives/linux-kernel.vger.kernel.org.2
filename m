Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0803A43B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhFKOHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:07:51 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:41939 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhFKOHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:07:50 -0400
Received: by mail-qk1-f180.google.com with SMTP id c124so31024308qkd.8;
        Fri, 11 Jun 2021 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=r/c6iN3kChwZor0LAKmN98reQDKw83m+JgMq3vlOYzk=;
        b=ApDhLfg6/OlZ3RoOxGam3o/qxZ2520nuCsT2ZvtlKeCf13BySsJVqmyq3y51GUlPE3
         /Y9pNKNsv5BaP0KapqgZv7ymPxHgG+FVf6hHUvKh163Cd4MbBJKrMoZZBsbWKk76xIWu
         E7qathQcaDUGd1ViWpsjQEmMzpxjdewizGhbBZyWlbE37jOlLLJXkhMiqb0PS8e2eLfn
         Gq7nIg3MK7SIk51GnYMH8jEVltPSj3G4siJCHmQmpYcUXAug7XfU9Ewu4TcTjmhvHD8A
         SRwuOfdH6mOjggwx9wbWQr6OoNFbCtNlnKv9u833qffzAb90VygB2HQQlZl9i5J8XrW8
         tI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=r/c6iN3kChwZor0LAKmN98reQDKw83m+JgMq3vlOYzk=;
        b=eHjyxjOetBD3iiLze0mDuMfn2LP4oZDrXsafBkMw0OWc3iD7tOFBoQrl9P9j+xGVZw
         PB5gk37aQXWmjCiLSzLK27TftbKHTkwGMIljRFk/jOCGwT+fTs8FHasfL9rAGJ5y+Rb5
         rPyeVzU+FNzBWmJB+eTVbcxZErdYF0dOCGE6lERY3xKAz10I+9X7OzFAyHxss9cAfpmV
         TF6qVEh+gjHUUXsuIQwr4VvYbWCNgAmaBUHJwdxxBS2f0P32Z2wnZQHlxTFm/XVVxwee
         XNdP2NZumo5E1K0SS0LyjC+bxb2ySnlcyJjX4UVZVNv8P3SVqCNmNI4jMeVDcN5E1qEq
         x/Lg==
X-Gm-Message-State: AOAM531Fv5+uyVVCBF1PrI+qPMQgZ5SPRsTW/gDiEXGrEX8SWwiZ/N+H
        9rKc5MIuK7Ih6b/HiwveYCU=
X-Google-Smtp-Source: ABdhPJxgRZdWfm7ahjsIsz3WmPJBB/+VALtMbNk/7sYup+DVGb/A3CDSjRETs3ADDHvlMwU2NTQgeA==
X-Received: by 2002:a05:620a:29d4:: with SMTP id s20mr3939788qkp.287.1623420275669;
        Fri, 11 Jun 2021 07:04:35 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id x8sm4316376qkl.110.2021.06.11.07.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:04:35 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
Cc:     SeongJae Park <sj38.park@gmail.com>, akpm@linux-foundation.org,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        snu@amazon.de, vbabka@suse.cz, vdavydov.dev@gmail.com,
        zgf574564920@gmail.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v29 12/13] mm/damon: Add user space selftests
Date:   Fri, 11 Jun 2021 14:04:27 +0000
Message-Id: <20210611140427.6375-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210611135737.104838-1-mheyne@amazon.de>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello Max,

> On Thu, 20 May 2021 07:56:28 +0000 SeongJae Park <sj38.park@gmail.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit adds a simple user space tests for DAMON.  The tests are
> > using kselftest framework.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  tools/testing/selftests/damon/Makefile        |  7 ++
> >  .../selftests/damon/_chk_dependency.sh        | 28 ++++++
> >  .../testing/selftests/damon/debugfs_attrs.sh  | 98 +++++++++++++++++++
> >  3 files changed, 133 insertions(+)
> >  create mode 100644 tools/testing/selftests/damon/Makefile
> >  create mode 100644 tools/testing/selftests/damon/_chk_dependency.sh
> >  create mode 100755 tools/testing/selftests/damon/debugfs_attrs.sh
> > 
[...]
> > diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
> > new file mode 100755
> > index 000000000000..4a8ab4910ee4
> > --- /dev/null
> > +++ b/tools/testing/selftests/damon/debugfs_attrs.sh
> > @@ -0,0 +1,98 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +source ./_chk_dependency.sh
> > +
> > +# Test attrs file
> > +file="$DBGFS/attrs"
> > +
> > +ORIG_CONTENT=$(cat $file)
> 
> Missing quotes around $file. Can you run shellcheck on this code and fix all
> reportings, please?

Thanks for the nice suggestion.  I will do so in the next spin.

> 
> > +
> > +echo 1 2 3 4 5 > $file
> > +if [ $? -ne 0 ]
> > +then
> > +	echo "$file write failed"
> > +	echo $ORIG_CONTENT > $file
> > +	exit 1
> > +fi
> > +
> > +echo 1 2 3 4 > $file
> > +if [ $? -eq 0 ]
> > +then
> > +	echo "$file write success (should failed)"
> > +	echo $ORIG_CONTENT > $file
> > +	exit 1
> > +fi
> > +
> > +CONTENT=$(cat $file)
> > +if [ "$CONTENT" != "1 2 3 4 5" ]
> > +then
> > +	echo "$file not written"
> > +	echo $ORIG_CONTENT > $file
> > +	exit 1
> > +fi
> 
> I'd add test cases for the contents written to the attrs, like checking that
> input min_nr_regions is actually smaller than the input max_nr_regions values.

Good point.  Will add the test case in the next spin.

> 
> > +
> > +echo $ORIG_CONTENT > $file
> > +
> > +# Test target_ids file
> > +file="$DBGFS/target_ids"
> > +
> > +ORIG_CONTENT=$(cat $file)
> > +
> > +echo "1 2 3 4" > $file
> > +if [ $? -ne 0 ]
> > +then
> > +	echo "$file write fail"
> > +	echo $ORIG_CONTENT > $file
> > +	exit 1
> > +fi
> > +
> > +echo "1 2 abc 4" > $file
> > +if [ $? -ne 0 ]
> > +then
> > +	echo "$file write fail"
> > +	echo $ORIG_CONTENT > $file
> > +	exit 1
> > +fi
> 
> I've seen this construct more than once. Any chance to refactor this code? Or is
> this selftest not expected to grow in the future?

Good point.  Will modularize code for reducing duplicates.


Thanks,
SeongJae Park

[...]
