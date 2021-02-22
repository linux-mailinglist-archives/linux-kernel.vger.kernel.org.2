Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C906E321D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhBVQge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhBVQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:36:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCA3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:35:43 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n10so14996686wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9HyW+R/tTqJ32XAGo3SEoB1HTbrZ1MBBmQvUTLk8VTQ=;
        b=CTgLeobky8icBFLKoJgHs91VRzgLtKreHngrsYuwaj55bzy/s90rt+9SDUmn4x0lfE
         bJSaWEnSlek9C6cBQtknyYRyvXUI3F9l0gdl2jlFCsp86buC8PuQDQQoEWw/mEoxMSti
         cXi9BpKFPR0qDui9cBDt6PafgCkXWbmhxY7Rce8FdAArb1pgnKKtWkmezSi29oYoyqZs
         4mBV7GRNN9liR4fGctYVXcagrbIy34GSj71cOND9PHHCUZPvTuYl0Dmfntrd5F/N+5xK
         vqRaxuhKzGd3DufnofEH/k8vAhmRj/01g8ZoZ6nBYZP3x0JXBKxt/3Ld3Joyh37BsN2y
         ILow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9HyW+R/tTqJ32XAGo3SEoB1HTbrZ1MBBmQvUTLk8VTQ=;
        b=PndaFrp8bSRDllcS3qjXpyY86y0TLumHCVVZuAq2hT6Bv1AUCKnMV6YZeSIzDPA8xP
         lHxVBXJSlkkhsznLsCABALsfFuXN7+3n5z0aDIfXE2UxJUotBFwelpkBZxzrYDjDA5zn
         QDPXnRMpjNiX/56cjIRkxWvEmX1YxKUUjDPfdzvI17e5uEEKu3pxa6QNAIBFpOiSgM92
         sLykPlKVtroIuswZdXhtcSfL7iqnGqcxTcH11suG/cs2FGHA60GnVl6OvTtf/OBaoTIS
         rgnOqWo9ksr+iGk/462BHZxy9oNijI0hJhRrpYZBCZGjv1P8u66+wLanQPcBe4GLUJMo
         WdWA==
X-Gm-Message-State: AOAM530seBtfviA6VzGaAqMxrWD99cyKJXpYOUaT4qcOvm8HmepwWQ85
        iil9Url/CvWuTNZ/kR28V9P+ng==
X-Google-Smtp-Source: ABdhPJwculwG7dtlay8rgowavRCvCCjs2FuL8nzagvlRCdSBKEuOEqBdCbRzg9ICG2mQzo1Vhe36tw==
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr5739015wmg.168.1614011741818;
        Mon, 22 Feb 2021 08:35:41 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id r15sm10416462wmq.47.2021.02.22.08.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:35:41 -0800 (PST)
Date:   Mon, 22 Feb 2021 16:35:38 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: Fix task utilization accountability in
 cpu_util_next()
Message-ID: <YDPdWtwO/uPHf69Q@google.com>
References: <20210222095401.37158-1-vincent.donnefort@arm.com>
 <YDODN1rnTqfTQOug@google.com>
 <20210222113602.GA286874@e120877-lin.cambridge.arm.com>
 <YDOiKH/XQDUKcrPU@google.com>
 <20210222150151.GA124800@e124901.cambridge.arm.com>
 <YDPUwKKYgZfzzCJm@google.com>
 <20210222163108.GA225035@e124901.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222163108.GA225035@e124901.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 Feb 2021 at 16:31:08 (+0000), Vincent Donnefort wrote:
> I suppose, a way of fixing this, is to keep cpu_util_next() the way it is to
> get the appropriate frequency at which the CPU would run once the task has been
> enqueued, for the 'max_util', and have 'sum_util' being the sum of the pd's util
> (without the task) + task_util_est().

You read my mind :)
