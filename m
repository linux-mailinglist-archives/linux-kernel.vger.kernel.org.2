Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C40436475
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhJUOj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhJUOj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:39:57 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58B7C061348
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:37:41 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x27-20020a9d459b000000b0055303520cc4so606030ote.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=dDWiDipIHK5HS6MeBxjwAzx3AX6EeZz5LXZckVi1/bo=;
        b=GK5V02ISlYBHzpOBLF1zpta1GjhfAs9dy2MvUVgN5TUFpyOInmeAsVfJP+6ah1rZVv
         bNIlx97VDxD5ozhsnrZZdE3Yn1O3JsA5IdMmdE6ZkcdhXHQFcVyTXcjjAMTie4cXf+0U
         WM8isIKKkZJEZffuGxvnr5jfzL6xGo6TW6NawGLgOIgbYFVPAFy7PeKfOXv8/SZx2kFp
         ljkEVIabkyc9VzhlUyVw2hH0o4ouYSc0MspRk+qCO98md3YCz7CxX0GlMRcHmHdfrtBb
         OBxSugbTXw0jsGomAnItJKwo1ZJplwg0mTw/1ARmCBWIfNuOQRepNV7ep24Dwe5pv7yz
         J3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=dDWiDipIHK5HS6MeBxjwAzx3AX6EeZz5LXZckVi1/bo=;
        b=AokHzq460z0neBvsUX4Ioq2IAXoaaNQOVt+qVpiNuEKr17rnNh+BEMHG8vBKZCbcbR
         x8ITXu2jllBdT8negKQXYy+T9CatDKgbXqkaZYS0bnqB7e2eiEp2DHsv7v9ZFu3PxIaq
         yteMywzahutOXx9YdgTgKS2bJlOA6ao7k9KPPoNCuLQtsA9JSYUwwP/xRj+dnLusHRzR
         uQUmRDbjAo6E1/ttM31M5dgVecU23w4VwVLPqSYfY2i13wJOOS6tPUg12x9gxXv9JvnR
         JYAHUrq5s3V94d9DB282TG28ysEjbLc7PEcKX86FYMqdlRbtEBMQv6QYDi3a7m4YR3R0
         wNJg==
X-Gm-Message-State: AOAM532cUYL+Q/ioZwbFkTk/JyWGLVlxa1FBO0Vd50GXinEeE2ooBjmE
        jcUxwELfTCIXGw8Y7NgN+OyDhg==
X-Google-Smtp-Source: ABdhPJxNL5QPcUrTS8+siBt4FYmfmiwU2xtnsVC3wrzxIslvK3bC3TMz4siO5gWkpAxAhnVJjJ67WQ==
X-Received: by 2002:a9d:20a3:: with SMTP id x32mr4783922ota.91.1634827061206;
        Thu, 21 Oct 2021 07:37:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id bk8sm1131310oib.57.2021.10.21.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:37:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>
In-Reply-To: <cover.1634822969.git.asml.silence@gmail.com>
References: <cover.1634822969.git.asml.silence@gmail.com>
Subject: Re: [PATCH v2 0/2] optimise blk_try_enter_queue()
Message-Id: <163482705916.41758.93518625125015139.b4-ty@kernel.dk>
Date:   Thu, 21 Oct 2021 08:37:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 14:30:50 +0100, Pavel Begunkov wrote:
> Kill extra rcu_read_lock/unlock() pair in blk_try_enter_queue().
> Testing with io_uring (high batching) with nullblk:
> 
> Before:
> 3.20%  io_uring  [kernel.vmlinux]  [k] __rcu_read_unlock
> 3.05%  io_uring  [kernel.vmlinux]  [k] __rcu_read_lock
> 
> [...]

Applied, thanks!

[1/2] percpu_ref: percpu_ref_tryget_live() version holding RCU
      commit: 3b13c168186c115501ee7d194460ba2f8c825155
[2/2] block: kill extra rcu lock/unlock in queue enter
      commit: e94f68527a35271131cdf9d3fb4eb3c2513dc3d0

Best regards,
-- 
Jens Axboe


