Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021043FA82F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 03:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhH2B7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 21:59:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60723 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbhH2B7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 21:59:32 -0400
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17T1w2CR011886;
        Sun, 29 Aug 2021 10:58:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sun, 29 Aug 2021 10:58:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17T1w2kl011883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 29 Aug 2021 10:58:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] profiling: fix shift-out-of-bounds bugs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavel Skripkin <paskripkin@gmail.com>
References: <99b9e091-9e95-5e45-5914-38a938840aa6@i-love.sakura.ne.jp>
 <20210813140022.5011-1-paskripkin@gmail.com>
 <20210819164655.6efe096b@oasis.local.home>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <cf898374-e1b4-4050-1e3b-7abe6bfccf21@i-love.sakura.ne.jp>
Date:   Sun, 29 Aug 2021 10:57:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819164655.6efe096b@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, can you take this patch?

On 2021/08/20 5:46, Steven Rostedt wrote:
> 
> Who's taking this patch? Or should Andrew just take it through his tree?
> 
> -- Steve
> 
