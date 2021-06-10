Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77A3A2DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhFJOIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:08:53 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63715 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFJOIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:08:50 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15AE6rlQ041099;
        Thu, 10 Jun 2021 23:06:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Thu, 10 Jun 2021 23:06:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15AE6qAS041083
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Jun 2021 23:06:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
To:     Aaron Tomlin <atomlin@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <llong@redhat.com>, Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
References: <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz> <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
 <353d012f-e8d4-c54c-b33e-54737e1a0115@redhat.com>
 <YL8MjSteKeO7w0il@dhcp22.suse.cz>
 <20210609143534.v65qknfihqimiivd@ava.usersys.com>
 <YMHivM+0DRYXzAD0@dhcp22.suse.cz>
 <20210610122323.6geriip66jjmdstj@ava.usersys.com>
 <YMII3OMPoZPuCe0r@dhcp22.suse.cz>
 <20210610133644.zpoqfvlchaey24za@ava.usersys.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c205367d-f47e-61f3-3aed-fd8142a0010f@i-love.sakura.ne.jp>
Date:   Thu, 10 Jun 2021 23:06:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610133644.zpoqfvlchaey24za@ava.usersys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/06/10 22:36, Aaron Tomlin wrote:
> On Thu 2021-06-10 14:43 +0200, Michal Hocko wrote:
>> Well, I am not sure this is a good thing in general. We do not want to
>> hide tasks. We already do display oom_score_adj_min even though they are
>> not eligible and that can serve a good purpose from my experience. It
>> gives us some picture at least. Maybe a flag to mark all uneligible
>> tasks would be something useful but I wouldn't drop them from the list.
> 
> Fair enough.

Yes, marking ineligible (i.e. oom_badness() returning LONG_MIN) tasks would be useful.

By the way, was the task namely "node" (i.e. PID 1703345) multithreaded program?
Your kernel might want commit 7775face207922ea ("memcg: killed threads should not invoke memcg OOM killer").
