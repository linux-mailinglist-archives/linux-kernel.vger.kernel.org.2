Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03BB31D22E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 22:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBPVgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 16:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhBPVgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:36:09 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 13:35:29 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 75so3727314pgf.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 13:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=W4THqvwCZrj86xY5TPeNsXOtIISm7JzhezcEESG1o28=;
        b=tDce4dKVjM97/3J8pcvVjyDXwH9d3VSUKvnjMNNscoKwqfxrPstTZzhwSKaXkni0m3
         wEjGt+gqoU3zjpe+JXOK4VShoTu/+zfVTtBdyrXMm53F71oaQmxQijmKJcQlkS15fswD
         F2F8fwrD9E6npXQ7ZezRSHoQ/Qtqe54TAzW4lnbwCapUWlkUjp3eh21MVKSjFXLyQLLH
         Xo0d/QeCaIZ1Udq8ILqvEFj6ab8jTzeMHd0gjlOkS2WkVFMcAhaSWjTavXNOp5bZFv6X
         S1zu7qOIpkYGK1DV7jqxuPE1K6eeqWv3/cbauh+FUh8A8/5+yuzAimjc6rYUapDyE2tP
         dEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=W4THqvwCZrj86xY5TPeNsXOtIISm7JzhezcEESG1o28=;
        b=tPkYW3DA+s6LdwgtqP8dPKZTOtLYLXbqjgYB/9jYMWSo4YcH7zC222xX522o1Xy5i+
         NITFdghw5RRXQRpAGgpNm/u3Ry1TGayr9us29I6u/gjENdICJaSP/TIOUU2J/UELWQWI
         9BL3CyMQZFiRXFDSqmGOVEkcZ58Xgs6mPABuJA8yvU5U8A0TRVoYRwdyYqXkf1XGcL0L
         HtVotx5rbIU/0u7gInnVV1o82GNDa7HZhEBIZOXR/TePtNCWgDViatKB1Q7ELTpo1/Tj
         k+ODzfJI6L3jai52r+ZvENCX0zqxdCg0DKlC+rcHHungru5jvCgaxvWxn//QybrzPIoJ
         K+RQ==
X-Gm-Message-State: AOAM5334p4Cri4gd19NLn76VY3mIiOsmO+6LIcLVJC6qj2xY++2xwkb7
        aE1TGvT/uOGi+cUdOlEkRj0=
X-Google-Smtp-Source: ABdhPJyZySdGLRFgzUnDCeFjcs2MDUTSxqyX0vu7TO5GgnYZkFPgxXN3Xx87IzhkPYy53XJWufP/yQ==
X-Received: by 2002:a63:844:: with SMTP id 65mr20778335pgi.371.1613511328550;
        Tue, 16 Feb 2021 13:35:28 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id p11sm4217609pjb.3.2021.02.16.13.35.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 13:35:27 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Local execution of ipi_sync_rq_state() on
 sync_runqueues_membarrier_state()
Message-Id: <74F1E842-4A84-47BF-B6C2-5407DFDD4A4A@gmail.com>
Date:   Tue, 16 Feb 2021 13:35:23 -0800
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mathieu,

While trying to find some unrelated by, something in
sync_runqueues_membarrier_state() caught my eye:


  static int sync_runqueues_membarrier_state(struct mm_struct *mm)
  {
        if (atomic_read(&mm->mm_users) == 1 || num_online_cpus() == 1) {
                this_cpu_write(runqueues.membarrier_state, membarrier_state);

                /*
                 * For single mm user, we can simply issue a memory barrier
                 * after setting MEMBARRIER_STATE_GLOBAL_EXPEDITED in the
                 * mm and in the current runqueue to guarantee that no memory
                 * access following registration is reordered before
                 * registration. 
                 */
                smp_mb();
                return 0;
        }

 [ snip ]

  	smp_call_function_many(tmpmask, ipi_sync_rq_state, mm, 1);


And ipi_sync_rq_state() does:

	this_cpu_write(runqueues.membarrier_state,
                       atomic_read(&mm->membarrier_state));


So my question: are you aware smp_call_function_many() would not run
ipi_sync_rq_state() on the local CPU? Is that the intention of the code?

Thanks,
Nadav
