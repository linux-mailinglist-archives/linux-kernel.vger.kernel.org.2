Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EFD3BB548
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 04:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGECxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 22:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhGECxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 22:53:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700A5C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 19:50:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h4so16955063pgp.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 19:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/P0hFST51hus6yZryqTMBya2rumafbNZ40Aqxcno29Q=;
        b=N9Xi4OvJTyrfjJjepUPUak+LoPNSX3eMtJD0IeI7y0lxbUOmi0m2tpEbeWoOhBaGLV
         kEr3UC1wpjAmc6nkXbg7ExJClOvqiwGct0Ls2HdQtdwYSqL5UyX3PwKRDObox15lCK6r
         bRhHdMB3gP0JQWpLt7S6LRCg4kZu6adb9XQaBB0xfT+9wn6FZAebAMkqq4ijBPYeFic9
         eA5nJOHntI+f39jl5756KFEFGvgdeWfAQs1s0p2tLarz+B4Icsiv4itoIp6C0aEl5m0N
         K5QpTuah04+T0Vm6Tgu04vPZqpttpRRWLB0nDaFKiRgdLvMtKFac5BEiH0WrLkxFKxns
         JWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/P0hFST51hus6yZryqTMBya2rumafbNZ40Aqxcno29Q=;
        b=NiDtv5zSGCkOL36tPFJofT8rF2Baf3tRe2Dy8PZvKwrU4jMDzoilnjAnjygjtyqu46
         pWDhFEkcDIqq1RkTJMDLvQV+6/Td5pLMQuEAGebxrgyfArWItGv1JRaXEyWfLgg0nJ36
         D38UeKCTndVIunaMo/hIZ6F96m63utIT61neR4TIZocF+8UFWus6jC+N4mW++iDhw87W
         Q29epyfPULVY61WHENDQT98yvJF9WcpXylEZzHrOqRWyCO5ylEYiNIezc55dR+584BtI
         +R02vNJSqd8jeJhfl6d9O0zpsvFGP64lXZ4K5ViWUQZoxGVXoSC+MpFz9inWBzUqzpJJ
         kr2w==
X-Gm-Message-State: AOAM533dnJRzvif/BDvA9yQCw5NUzVP6sFLCunId1RwPxXTQLJ8d0Lp/
        EAS0TgACCQ+foHhYLv6WopIc7A==
X-Google-Smtp-Source: ABdhPJzsq8aAhABlI5hU5hlfMNUSAiNn0TZTukL34NpGUl7l7ciwladTFu6tnR3hvfDz8P6Wf5IPpg==
X-Received: by 2002:a63:cc03:: with SMTP id x3mr13224769pgf.133.1625453422859;
        Sun, 04 Jul 2021 19:50:22 -0700 (PDT)
Received: from [10.87.61.221] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id fv8sm9220592pjb.21.2021.07.04.19.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 19:50:22 -0700 (PDT)
Subject: Re: [PATCH] kretprobe scalability improvement
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mattwu@163.com
References: <20210703102818.20766-1-wuqiang.matt@bytedance.com>
 <YOF8fyJIzJmZUhoC@infradead.org>
 <20210705085901.20f97a48c37fdc533d554dc6@kernel.org>
From:   Matt Wu <wuqiang.matt@bytedance.com>
Message-ID: <35cefef5-571f-a7b2-c964-8c974d4e416c@bytedance.com>
Date:   Mon, 5 Jul 2021 10:50:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705085901.20f97a48c37fdc533d554dc6@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/5 AM7:59, Masami Hiramatsu wrote:
> On Sun, 4 Jul 2021 10:16:47 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> Would it make sense to just reuse kernel/bpf/percpu_freelist.c for
>> kretprobes?
> 
> Hmm, I don't think so.
> It seems that what Wuqiang proposed is more efficient than the
> percpu_freelist, and it will be less efficient from the viewpoint
> of memory usage because kretprobe freelist manages instance pool
> among all CPUs (which can be unbalanced, sometimes 95% used by one
> core, sometimes used evenly).
> 
> Actually, the best solution is to have per-task fixed-size instance
> pool which is shared by all kretprobes (e.g. 4kb/task), because
> the instance makes a "shadow stack" for each task. This may consume
> more memory but is not increased by adding kretprobes, and should be
> scalable.

Yes, per-task pool is the best for scalability.

How about allocating the kretprobe instance just from stack ? The size
of kretprobe instance is very likely to be "small", then most of allocs
could be fed quickly from current stack.

Expanding default kernel stack by 1 page is also an option, but the
impact of memory occupation would be huge, after all the kretprobe is
a rare thing and uncertain to normal threads.

Regards,
Matt Wu
