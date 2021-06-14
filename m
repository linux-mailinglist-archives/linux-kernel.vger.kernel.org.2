Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E493C3A5D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 08:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhFNGuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhFNGuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:50:23 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A7BC061574;
        Sun, 13 Jun 2021 23:48:08 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c124so37430479qkd.8;
        Sun, 13 Jun 2021 23:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=VXB3sDXLr2J/PWK7WC7SwWZiu5cXaiPOgPfes8Vb4PQ=;
        b=YqooeYuGVGMWri5CwsoSuuJ76S7ucjYYkrw1F+lKGb2apzv7HWD1YGN+KRK1TQqU/5
         85LGFATx5csHIBSyxrZc9qASUL4slKeAA87q4O3ORBGgBwS2KzJSUL42KWqpfQpbv36v
         9cK2PJJ/ZBAF32D0hsoCvT6CWkOlHYnQUDZ1qsFezOCR58YFUAeoKoQWKEbWfVm2vGiL
         WpVNn4nv2iTQGK9PFzvMRLm6sVEFOGRXOS34FgBdt2+InfHUshMQOc2pWcP1CDMyvBpT
         sMw1cSYM0JsWf5KO9UpuXLkBUVo0A3C0RheFQWqQ424dmDME6VybSQkVlA8cEB2n83PW
         5ojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=VXB3sDXLr2J/PWK7WC7SwWZiu5cXaiPOgPfes8Vb4PQ=;
        b=W0gXlY9piYN9wr3z9JttwuWZm9my4izmya2F3svxg4CI7/py9dU4XLp6Y9Ldhjr7xo
         JpymTswcxU63xKCShjEkCD836XcVEiShLlv6TWYhXMkkrIU9YUyt+BbHh2yIQpwuuD27
         xNB6cTvoxV06fcSaK2aTcve9CvzLOI6XmdH69Jupf2pgnRwtPQuuesRLSEiIvi4piYQu
         2SfIdPoKQWjvS82q8/9YIXAJFk7BqCCU5ggPV+Y44N9aVAjq8OoYRZxhFLFyV5MUVtMb
         AeeiX/N0yf4xOCPxCAxim8+vjng/mjtP61xi5MnJj6Ee2MILU94mQUJm1Sgl0PTCY/fI
         aDSQ==
X-Gm-Message-State: AOAM5337BKtMl+GNLcK0PI56Rdl/ILgF3BaP+D3pBr9bSOsamp0vNPew
        EqWLU9LYMKdAYlDFZ68X1dA=
X-Google-Smtp-Source: ABdhPJxkXE+S9KhgTAdMqh79idvZVqNV9wmabFXT7bYaNYhhiBrZAwd/l8BcWyDTEzBSv2hco3jOcQ==
X-Received: by 2002:a37:6409:: with SMTP id y9mr7716148qkb.18.1623653286874;
        Sun, 13 Jun 2021 23:48:06 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h68sm9625254qkf.126.2021.06.13.23.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 23:48:06 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     sieberf@amazon.com
Cc:     sj38.park@gmail.com, Jonathan.Cameron@Huawei.com, acme@kernel.org,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, linux-damon@amazon.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sjpark@amazon.de, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com
Subject: Re: [PATCH v29 07/13] mm/damon: Implement a debugfs-based user space interface
Date:   Mon, 14 Jun 2021 06:48:00 +0000
Message-Id: <20210614064800.14606-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e8687948-649f-348f-e4d6-2175b1c47551@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the comments!

On Fri, 11 Jun 2021 20:59:04 +0200 <sieberf@amazon.com> wrote:

> + Returns non-empty string on success, negarive error code otherwise.
> 
> Nit: typo, 'negarive'

Good catch!  I will fix this in the next spin.

> 
> 
> +    if (ctx->kdamond) {
> +        if (targetid_is_pid(ctx))
> +            dbgfs_put_pids(targets, nr_targets);
> +        ret = -EBUSY;
> +        goto unlock_out;
> 
> I don't understand this block, what does EBUSY mean in this context?

That means DAMON is busy because someone already requested running the
monitoring context.  So, the user will be able to wait a little bit and try
later, or try to figure out who requested the monitoring.

> 
> +    if (sscanf(kbuf, "%s", kbuf) != 1) {
> +        kfree(kbuf);
> +        return -EINVAL;
> +    }
> 
> Nit, this diverts from other patterns use elsewhere where error 
> conditions that need to free memory use a goto label.

I want to use 'goto' only if it makes the code shorter and easier to read.  In
this case, this is the only one case that could use the 'goto' statement.  And,
this part would still be two lines like below:

    if (sscanf(kbuf, "%s", kbuf) != 1) {
    	ret = -EINVAL;
    	goto out;
    }

Meanwhile, to use the 'goto', we would need to add the label below, so we will
only add one more line.  Therefore, I think using 'goto' here doesn't really
reduce the lines of code or make it easier to read.

So, if you don't care, I'd like to use current code as is.

If I missed something, please let me know.


Thanks,
SeongJae Park
