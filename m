Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B6C3A4BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 02:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhFLAZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 20:25:30 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53422 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFLAZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 20:25:29 -0400
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15C0N6Gl052432;
        Sat, 12 Jun 2021 09:23:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sat, 12 Jun 2021 09:23:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15C0N6Sg052420
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 12 Jun 2021 09:23:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] mm/oom_kill: show oom eligibility when displaying the
 current memory state of all tasks
To:     Waiman Long <llong@redhat.com>, Aaron Tomlin <atomlin@redhat.com>,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        linux-kernel@vger.kernel.org
References: <20210611171940.960887-1-atomlin@redhat.com>
 <d233acb6-72ff-4914-88a3-75bf137e5286@redhat.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <eb77e210-1088-d140-043f-088141deb94d@i-love.sakura.ne.jp>
Date:   Sat, 12 Jun 2021 09:23:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d233acb6-72ff-4914-88a3-75bf137e5286@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/06/12 2:42, Waiman Long wrote:
> A minor nit:
> 
> "oom eligible?" has 13 characters. The field width is 15. Maybe you should pad 2 more spaces to make the proper alignment.

Maybe single character (e.g. 'S' for OOM_SCORE_ADJ_MIN, 'R' for MMF_OOM_SKIP, 'V' for in_vfork(),
none for eligible) is better because dump_task() might print many hundreds of lines?
