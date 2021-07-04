Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036583BACB8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 12:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhGDKVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 06:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGDKVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 06:21:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDC9C061762
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 03:18:25 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so12589955pjs.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic
         :mime-version:content-transfer-encoding;
        bh=DvZWdChDibRCbxEm0wlJ8JU0Q7PpBEdNOZC5Av65UIM=;
        b=bGAEJJqEbnWUg8eruLhznUbawcysPU4DsX1mcigHy04bzhVrd6d9KLPsSABo7+JdFi
         cIrRuNZMeMxMRiY4ADiKAcygd5+ioCRlbGu0Idw4MPsEn5l2KXqDQGulu7dzkoeqx1J5
         WXSH5obHHAo2VVf595ndClcPOw4OVfSlfpyWiBDQZKGe1CozQ1H+L+vo75SEyf5/CrG8
         f5vCSL8MV5q4mVZvFGs0T/Z/UcrXEspcBng09zllGFZ4lLkIN4mpuIYg6sszU8dJvBtP
         u9rf3tsxDAnV4liwOjqshgyfhOF0qgJJtJGjxWivb3vfrhOsTGd0y+h5tYUNIqzW5KgW
         Ar8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:date:subject:from:to:cc:message-id
         :thread-topic:mime-version:content-transfer-encoding;
        bh=DvZWdChDibRCbxEm0wlJ8JU0Q7PpBEdNOZC5Av65UIM=;
        b=rSVyxaD6z+7TAjqJi/nTZ6QqVXjsbeTGuh+ZND4DAmLgsgQRAOyhK/Y77UUzGNjEeJ
         Pt3T4zdhJD7dqlMptDbQeRRPX1BfKX+qJzIFaNhXqlMyo5Y4yzZ5AiUMZq0RcxpDdx9S
         ZdmOiThaHgSWBxaWrV/jFmPfQU1zwQbb3VId9QbRwba2bcb+AwQw1d4LTLxY25NHrOm8
         76UfwflQeEK6PUI/6mSm2pPvT/bHetJeS3TXYEI0yrHAaVuLXe9wibidZMxehaQv6Gi2
         lDcRFJAy17BPwiwCZIaYU5i+P1Lv66Dz/mNi5idz0mBjjdX4YLkTpL9WIkHmNSAR61Bv
         rIzQ==
X-Gm-Message-State: AOAM530WPWKn7v5qx+6u6C9UD1szIkvNE6vYZJzx1UIWNBxXjzPYpRlh
        l/f0l1iUw0LmA2OQ+zjQVYMBQA==
X-Google-Smtp-Source: ABdhPJxsSETjDscJaX5hgc172dvtCUcnLaYrXY0GBUW/C9SpzR7RhLN+kBvHabcIymREFqtk1jJnwA==
X-Received: by 2002:a17:902:e54b:b029:129:4fbb:16d6 with SMTP id n11-20020a170902e54bb02901294fbb16d6mr7504650plf.46.1625393905098;
        Sun, 04 Jul 2021 03:18:25 -0700 (PDT)
Received: from [10.87.61.221] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id p17sm17638392pjg.54.2021.07.04.03.18.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jul 2021 03:18:24 -0700 (PDT)
User-Agent: Microsoft-MacOutlook/16.42.20101102
Date:   Sun, 04 Jul 2021 18:18:19 +0800
Subject: Re: [PATCH] kretprobe scalability improvement
From:   Matt Wu <wuqiang.matt@bytedance.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>, <mingo@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <mattwu@163.com>
Message-ID: <C46C9460-7FD6-4F6F-9603-84E2A8BA8D8F@bytedance.com>
Thread-Topic: [PATCH] kretprobe scalability improvement
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/4, 5:17 PM, "Christoph Hellwig" <hch@infradead.org> wrote:

    Would it make sense to just reuse kernel/bpf/percpu_freelist.c for
    kretprobes?

Thanks for the info. bpf/percpu_freelist does meet the requirements of kretprobe_instances management and is more compact in memory. But  the spinlock usage (through locally) looks a bit heavy since it must disable interrupts on local cpu.

I will perform a test to collect some data for comparison.

Regards,
Matt Wu


