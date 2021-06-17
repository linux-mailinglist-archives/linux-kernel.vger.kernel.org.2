Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6D3AB2B9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhFQLha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhFQLh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:37:27 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A68C061574;
        Thu, 17 Jun 2021 04:35:19 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g142so2726433qke.4;
        Thu, 17 Jun 2021 04:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=8tErQQGqVARuWTPJ1UZnyWbISdS7OqCTl4R1CLBW1Bw=;
        b=rZOgBxNZ5BtwSpmkYY+as1qvp1TbrqJ0z57PQkLfw1swif02hqM2t3ddSmm12goxP7
         5rzGLL3ijB2rNQ7d9tJ+AiQUj31PuPwM/ILmpA3dNUvBsZ8ZnCVXG4H8mDNusWZPWvkZ
         1jW/4PmJM6x9UxKd9H4usq7jqu+TBfv80XZpAdhwKT03+93nKzte+SIxS+msrftT0d+h
         EeIlZCBo9wP3Mn1y9LzgjQF2n9ptqbMem6VXoN1WnqYnHzC90MRLI2nRHisW0eOkRSAU
         2BzaogoZcyOXoBsMDx9NEck5auNah20J2Nu59lPcoUA78T0XKszLlMvLnd4LslXqxP0D
         gSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=8tErQQGqVARuWTPJ1UZnyWbISdS7OqCTl4R1CLBW1Bw=;
        b=QBwgVOfec2daXiustEpbOijx6rbO3uFgj7n6OCJ4sC5AH57SXM6uGVpoghD+7oBsv7
         kMrNuTz8/KDHh7PFSUwWM1FVrU9mj8aoFxMVUGdcA/01/irT3rxyIuh2kwA2sGrUOITG
         1CTm9vMhkoV4nFKoF1PbLGjCo46zpR/PV/SKc4DLtQKOSnPG5mrAVqV/onVODYEBzCVZ
         hbA6HI7UDXvcLhoJ2v8i/SSR8cyDDPpMUSyRFOLIvbJaM2qdukkczqbAc2s8A8doawcm
         khXBS1ow86pecSw+g04ZdJvseTKNlilO6ybJyd/JLnH2/Z6ehU53vZbc8uZotgXidix6
         aE1A==
X-Gm-Message-State: AOAM530BwjDnkPMhjtLL/RIN5TbYRqp93mYqvBFHDXWavVf1sexSK8W9
        TRAv0QJfB3yOO65UbGwqaVQ=
X-Google-Smtp-Source: ABdhPJwvYMe52BcZr+JE8BaqGbvb1iv78gnjVOMlpQLdxJauIyJdXY4BjI+L07ic566Orq7pHwZFMQ==
X-Received: by 2002:a05:620a:140c:: with SMTP id d12mr3277055qkj.228.1623929718452;
        Thu, 17 Jun 2021 04:35:18 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id t30sm1489260qkm.11.2021.06.17.04.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:35:17 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     "Boehme, Markus" <markubo@amazon.de>
Cc:     "sj38.park@gmail.com" <sj38.park@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Foerster, Leonard" <foersleo@amazon.de>,
        "guoju.fgj@alibaba-inc.com" <guoju.fgj@alibaba-inc.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-damon@amazon.com" <linux-damon@amazon.com>,
        "david@redhat.com" <david@redhat.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "Heyne, Maximilian" <mheyne@amazon.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gowans, James" <jgowans@amazon.com>,
        "Park, Seongjae" <sjpark@amazon.de>,
        "snu@zelle79.org" <snu@zelle79.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "Sieber, Fernand" <sieberf@amazon.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "zgf574564920@gmail.com" <zgf574564920@gmail.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "amit@kernel.org" <amit@kernel.org>,
        "fan.du@intel.com" <fan.du@intel.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "gthelen@google.com" <gthelen@google.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "elver@google.com" <elver@google.com>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v30 12/13] mm/damon: Add user space selftests
Date:   Thu, 17 Jun 2021 11:35:04 +0000
Message-Id: <20210617113504.5525-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1ad122038f283961b787b26bb838a063ff7c43cf.camel@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello Markus,

On Thu, 17 Jun 2021 11:29:41 +0000 "Boehme, Markus" <markubo@amazon.de> wrote:

> On Thu, 2021-06-17 at 11:28 +0000, Boehme, Markus wrote:
> > On Wed, 2021-06-16 at 07:31 +0000, SeongJae Park wrote:
> > > From: SeongJae Park <sjpark@amazon.de>
> > > 
> > > This commit adds a simple user space tests for DAMON.  The tests
> > > are
> > > using kselftest framework.
> > > 
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > ---
> > >  tools/testing/selftests/damon/Makefile        |  7 ++
> > >  .../selftests/damon/_chk_dependency.sh        | 28 +++++++
> > >  .../testing/selftests/damon/debugfs_attrs.sh  | 75
> > > +++++++++++++++++++
> > >  3 files changed, 110 insertions(+)
> > >  create mode 100644 tools/testing/selftests/damon/Makefile
> > >  create mode 100644
> > > tools/testing/selftests/damon/_chk_dependency.sh
> > >  create mode 100755 tools/testing/selftests/damon/debugfs_attrs.sh
> > > 
> > > [...]
> > > diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh
> > > b/tools/testing/selftests/damon/debugfs_attrs.sh
> > > new file mode 100755
> > > index 000000000000..60342d6c86d8
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/damon/debugfs_attrs.sh
[...]
> > > +
> > > +test_content() {
> > > +	file=$1
> > > +	orig_content=$2
> > > +	expected=$3
> > > +	expect_reason=$4
> > > +
> > > +	content=$(cat "$file")
> > > +	if [ "$content" != "$content" ]
> > 
> > That'll always evaluate false and should compare against "expected"
> > instead.

Good catch, I will fix so in the next spin.

> > 
> 
> Feel free to add Reviewed-by: Markus Boehme <markubo@amazon.de> when
> this is fixed.

Thank you!

> 
> > > +	then
> > > +		echo "reading $file expected $expected but $content"
> > > +		echo "expected because: $expect_reason"
> > > +		echo "$orig_content" > "$file"
> > > +		exit 1
> > > +	fi
> > > +}


Thanks,
SeongJae Park

[...]
