Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45043A0D19
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbhFIHGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbhFIHF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:05:59 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05B4C061574;
        Wed,  9 Jun 2021 00:03:51 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g12so4886576qtb.2;
        Wed, 09 Jun 2021 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=QXV/x/+60YHq03EFxUIcFBCeTbgyh3RYCROJ7grisQo=;
        b=T53vAhB/yYq1jxqN1Y/BNCqU9x1WkQGcVXffS+pl0MFq6xtCTuD88+lZckajKJ6aTR
         vRmpZh80S6DS1bOhiiZc1e4Onu+ngjTmJufnhgl1ynFucfkQh3t0STcWHmi1rXytYJic
         ckj8vimwqoUMP/NT7gMfzZGec321gIgJLHBVFbY+d9lje7mAakZPsaIi9mhM+lkdcr8J
         kasSxaaQfd3nlRBnM8+ibIE95GG2k0Bi4wFsdVyAaYCC5xJrl4jKoNKTdit79sa0ZqJ/
         YhRhpxuucidhId1lV5m7kgh3Yxg05cGchEQFxRRy39xE5pSLLnQ2MLkTa4wSBEb+lFva
         CtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=QXV/x/+60YHq03EFxUIcFBCeTbgyh3RYCROJ7grisQo=;
        b=JX/ORf6uqMQAkXfBgVcNYR1tA7Mntxs4MamUKimT4OjZKS4xwpFHYSicYIA1cLyXaH
         gmIfdkwxkzdUzCOpPbK3hOrekZ2bOySjcO4F3VSvLLqCvzyfO7UkUT31HYhIblDXhHiV
         4okNLlMxcjp+r5ECaykiJfEOyDwrR9ZI0YVvUWQp3jdLnziTBsYSo7eq9VJo4r48giJz
         5LulHpxnHqTt0fGJOC2JN3+jSzEQbMoOQaKn56dWm/9zC8/HKw6XwdAOAoQNM2G5xflr
         KwXbPQTrOgr+CWPvxGcmyuhh5dMCiAd2vB4jHuDwogXY1xlTFRt8YRC795eFWkRLOJ6L
         CDQw==
X-Gm-Message-State: AOAM5336Fida0GQfD+AoJ8i+hQ9+dvpEKV4VRuxk+MWrwiRZKs/w9ekT
        Ru6qEocCvAnS4l+v2ic1xmI=
X-Google-Smtp-Source: ABdhPJxXo1M9oQcQr7ODrb0ImCkWKJ2lF2aijATdthn8p2Kvnr5igRwRA+jac3xihFPxAAcZOhTyGg==
X-Received: by 2002:a05:622a:130b:: with SMTP id v11mr9782307qtk.4.1623222231157;
        Wed, 09 Jun 2021 00:03:51 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id s133sm10923995qke.97.2021.06.09.00.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 00:03:50 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendanhiggins@google.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        elver@google.com, fan.du@intel.com, foersleo@amazon.de,
        greg@kroah.com, gthelen@google.com, guoju.fgj@alibaba-inc.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v29 10/13] Documentation: Add documents for DAMON
Date:   Wed,  9 Jun 2021 07:03:41 +0000
Message-Id: <20210609070341.1421-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520075629.4332-11-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Thu, 20 May 2021 07:56:26 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit adds documents for DAMON under
> `Documentation/admin-guide/mm/damon/` and `Documentation/vm/damon/`.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  Documentation/admin-guide/mm/damon/guide.rst | 158 +++++++++++++
>  Documentation/admin-guide/mm/damon/index.rst |  15 ++
>  Documentation/admin-guide/mm/damon/plans.rst |  29 +++
>  Documentation/admin-guide/mm/damon/start.rst | 114 +++++++++
>  Documentation/admin-guide/mm/damon/usage.rst | 112 +++++++++
>  Documentation/admin-guide/mm/index.rst       |   1 +
>  Documentation/vm/damon/api.rst               |  20 ++
>  Documentation/vm/damon/design.rst            | 166 +++++++++++++
>  Documentation/vm/damon/eval.rst              | 232 +++++++++++++++++++
>  Documentation/vm/damon/faq.rst               |  58 +++++
>  Documentation/vm/damon/index.rst             |  31 +++
>  Documentation/vm/index.rst                   |   1 +

I think 'guide.rst', 'plans.rst', and 'eval.rst' are not appropriate to be
merged in mainline.  I will remove those from the next spin.  So, if you are
reviewing this patch, please skip those.


Thanks,
SeongJae Park

[...]
