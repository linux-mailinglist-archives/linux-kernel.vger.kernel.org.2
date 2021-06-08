Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A6F39FDD0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhFHRhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:37:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56772 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhFHRhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:37:16 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C159D1FD2A;
        Tue,  8 Jun 2021 17:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623173722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekpUS23lBpqTyQ4uJDG0/Y6FttsPCcNvOz09Cft9ijM=;
        b=vXQPLciAFd/sZ7El77HUtZFl7Fwo3I9Y4sFx4hliXZTNvc0hOXw4dMAQIloge3JaKIb7lb
        LWpRrYLY4+Hdeu9EzsppGH/zHjUi1tTVCxAhdltHifjOby2nZeFbQUG/7RgGykZ6qs1AwK
        E1TpSxziG7zyMbYbENFubpbFpwRrqiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623173722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekpUS23lBpqTyQ4uJDG0/Y6FttsPCcNvOz09Cft9ijM=;
        b=r1up/zcO4MfzJri+YTCOKHRc0H3RFlbA8bk5GTAgymgXKd35/4bTYU5/EDXUEAXm/MPtj5
        s1QTuzCY0eDGMbBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 993E0118DD;
        Tue,  8 Jun 2021 17:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623173722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekpUS23lBpqTyQ4uJDG0/Y6FttsPCcNvOz09Cft9ijM=;
        b=vXQPLciAFd/sZ7El77HUtZFl7Fwo3I9Y4sFx4hliXZTNvc0hOXw4dMAQIloge3JaKIb7lb
        LWpRrYLY4+Hdeu9EzsppGH/zHjUi1tTVCxAhdltHifjOby2nZeFbQUG/7RgGykZ6qs1AwK
        E1TpSxziG7zyMbYbENFubpbFpwRrqiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623173722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekpUS23lBpqTyQ4uJDG0/Y6FttsPCcNvOz09Cft9ijM=;
        b=r1up/zcO4MfzJri+YTCOKHRc0H3RFlbA8bk5GTAgymgXKd35/4bTYU5/EDXUEAXm/MPtj5
        s1QTuzCY0eDGMbBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id QfrgJFqqv2CGdQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Tue, 08 Jun 2021 17:35:22 +0000
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>, glittao@gmail.com,
        vinmenon@codeaurora.org
References: <1623141934-7699-1-git-send-email-faiyazm@codeaurora.org>
 <CAHp75VcwW6RGALAjzcK4W9xy_hDPyFti4cNY_pCwJnjUr+VYVQ@mail.gmail.com>
 <b84892d5-06ed-fdbe-b5b3-0956140573ec@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v11] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <78fc8848-bde8-769e-f8e9-6157d232a60f@suse.cz>
Date:   Tue, 8 Jun 2021 19:35:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <b84892d5-06ed-fdbe-b5b3-0956140573ec@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 7:11 PM, Faiyaz Mohammed wrote:
> 
> 
> On 6/8/2021 5:20 PM, Andy Shevchenko wrote:
>> On Tue, Jun 8, 2021 at 11:45 AM Faiyaz Mohammed <faiyazm@codeaurora.org> wrote:
>>>
>>> alloc_calls and free_calls implementation in sysfs have two issues,
>>> one is PAGE_SIZE limitation of sysfs and other is it does not adhere
>>> to "one value per file" rule.
>>>
>>> To overcome this issues, move the alloc_calls and free_calls
>>> implementation to debugfs.
>>>
>>> Debugfs cache will be created if SLAB_STORE_USER flag is set.
>>>
>>> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
>>> to be inline with what it does.
>>>
>>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>>> ---
>> 
>> It seems you missed the version bump along with changelog.
>> Note, some maintainers (actually quite many I think) are using tools
>> to fetch up the patches and two patches with the same version is a
>> problem. Hence I do not consider it a nit-pick.
>> 
> Hmmm, I think to avoid same version problem I have to push same patch
> with new version number and thank you for your patience.

I *think* Andrew wouldn't have this issue, so maybe resend only if he says it's
needed.
On the other hand I did have troubles to apply the last version locally, patch
(tool) complained of patch (file) being malformed at the end. Did you add or
delete lines from it after generating the patch? I had to use the recountdiff
tool to fix this. If you're going to resend, please make sure it's without the
same issue.

> Thanks and regards,
> Mohammed Faiyaz
> 

