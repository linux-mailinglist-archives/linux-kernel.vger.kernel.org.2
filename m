Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6359341CBB3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345912AbhI2SVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343727AbhI2SVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:21:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3780EC061765
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:20:01 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id r7so2293490pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/SykeuCvrkN4lQdb6WrT+9Adck5B4c79CRVJFfba1bs=;
        b=Fp04+fXVOl6IHQ151lIH3sGA1m12lRYxD5yQ4VXUj+3xNXwojQ1I/OLmJgpBq7DmHb
         5FDJ2JNbcSKKVW+Rm1fC4d7xnd3X/2daP8QlPN2ALJwdr7jql24XaXvOUEADywkpitc3
         r5yTEhifCtn6HKAvZL74hmn25cfNdrE3Rms+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/SykeuCvrkN4lQdb6WrT+9Adck5B4c79CRVJFfba1bs=;
        b=odZG7VoxduHQ6GgXy/9ksPJyk69QGKVWHLoawujgpj+r90wbC90uo+Xk/H2/bl86Ub
         hD2MNT8EqcoLmCyP10c18xOD4X+BPcvBEg3W2WdFUXsg6q5I8XdwwK+I8ToHWZQRpZtw
         B6eHdegIr0LCsG5+9Frl1lzm/s+OweeOUcAFrBN+FvAZvoUxaszz4N0IeHZrqwhq2pLB
         8NqjRzBxm1x35VKaU1TOQxIBBrKVoIhCRXVXXsdqQJozYxuEsISMkz+QcZneJS2vLygp
         TUqXWdmJwPsJEMWYfN/DBUHc4Hhry1tu4SqjTzNBOo7gfenoMcsrSCQGGIXYXuSzfG/O
         eaFA==
X-Gm-Message-State: AOAM53307Qp//83OnoO6fn5M5nSFJFRnw6ZmC+EHvZEKztjY5Qjzz6xz
        vcvkHTVYkc7mq1nEa1Vuo4NRig==
X-Google-Smtp-Source: ABdhPJw7LIP+L1m6oc38TZilRXO7oXnPcTMpNrHWkAqVFkPouXsrV3Qu0gGTlmy94l8F7LBcCLunnw==
X-Received: by 2002:a17:90b:1e47:: with SMTP id pi7mr8056356pjb.135.1632939600659;
        Wed, 29 Sep 2021 11:20:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z85sm461486pfc.162.2021.09.29.11.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:20:00 -0700 (PDT)
Date:   Wed, 29 Sep 2021 11:19:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, pmladek@suse.com, peterz@infradead.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        viro@zeniv.linux.org.uk, christian@brauner.io,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] kernel: increase the size of kthread's comm
Message-ID: <202109291113.6DE8D6F3D@keescook>
References: <20210929115036.4851-1-laoar.shao@gmail.com>
 <20210929115036.4851-5-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929115036.4851-5-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:50:35AM +0000, Yafang Shao wrote:
> This patch increases the size of ktread's comm from 16 to 24, which is
> the same with workqueue's, to improve this situation. After this cahnge,
> [...]
> Because there're only a few of kthreads, so it won't increase too much
> memory.

Even without the performance impact changes, the math here doesn't hold
either, since using kmalloc means there are slabs being allocated to hold
the task "comm"s now (which comes with overhead), and every task added
a pointer to those 16 bytes (i.e. 8 more bytes on 64-bit systems). So
this change, even if there was 0 overhead in using slabs, would be
identical to having just raised TASK_COMM_LEN to 24. 8 byte pointer,
16 byte allocation == 24 bytes.

-Kees

-- 
Kees Cook
