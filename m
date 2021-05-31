Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500DB3959C7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhEaLhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:37:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49132 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhEaLhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:37:12 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 33A581FD30;
        Mon, 31 May 2021 11:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622460932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aCK5TBvDrOKvurXKewrtxpqHEC6/7/2/MtIqXAxSNc8=;
        b=j3TMgR3NgsY2uyih+YB62sjtD+0+UA7N6wJLEskaPgh2O/HDRbSx/3W39PHW7a4KL/xTi/
        dJaKfpS7TY9GBIMHlXtq6E6iTqu9XrxACw44aPUBnYC758M1oubiPfxH3IwkeTXfO9UlEu
        QO4EzYkRJpbv+VEpXFbBLpoX5G3YwIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622460932;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aCK5TBvDrOKvurXKewrtxpqHEC6/7/2/MtIqXAxSNc8=;
        b=OhZlFetc7flQeS6UI/AgyyAxPuY9VKDEXYwKnQ2EV7Qn/yXikNPLkHQhJCCZpwW1D7rIqD
        kAuBWvm/PzIF5JCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 99F67118DD;
        Mon, 31 May 2021 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622460932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aCK5TBvDrOKvurXKewrtxpqHEC6/7/2/MtIqXAxSNc8=;
        b=j3TMgR3NgsY2uyih+YB62sjtD+0+UA7N6wJLEskaPgh2O/HDRbSx/3W39PHW7a4KL/xTi/
        dJaKfpS7TY9GBIMHlXtq6E6iTqu9XrxACw44aPUBnYC758M1oubiPfxH3IwkeTXfO9UlEu
        QO4EzYkRJpbv+VEpXFbBLpoX5G3YwIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622460932;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aCK5TBvDrOKvurXKewrtxpqHEC6/7/2/MtIqXAxSNc8=;
        b=OhZlFetc7flQeS6UI/AgyyAxPuY9VKDEXYwKnQ2EV7Qn/yXikNPLkHQhJCCZpwW1D7rIqD
        kAuBWvm/PzIF5JCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 1qITJf3JtGAvIQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Mon, 31 May 2021 11:35:25 +0000
Subject: Re: [PATCH v4] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
To:     Michal Hocko <mhocko@suse.com>, Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org
References: <YKZObDpduqwWi/Zm@casper.infradead.org>
 <20210520142901.3371299-1-atomlin@redhat.com>
 <YLTJjJqemt5Uv9vP@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c7b69523-c141-d06c-bc02-953c7a939d91@suse.cz>
Date:   Mon, 31 May 2021 13:35:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLTJjJqemt5Uv9vP@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: imap.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.00
X-Spamd-Result: default: False [0.00 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 1:33 PM, Michal Hocko wrote:
> On Thu 20-05-21 15:29:01, Aaron Tomlin wrote:
>> A customer experienced a low-memory situation and decided to issue a
>> SIGKILL (i.e. a fatal signal). Instead of promptly terminating as one
>> would expect, the aforementioned task remained unresponsive.
>> 
>> Further investigation indicated that the task was "stuck" in the
>> reclaim/compaction retry loop. Now, it does not make sense to retry
>> compaction when a fatal signal is pending.
> 
> Is this really true in general? The memory reclaim is retried even when
> fatal signals are pending. Why should be compaction different? I do
> agree that retrying way too much is bad but is there any reason why this
> special case doesn't follow the max retry logic?

Compaction doesn't do anything if fatal signal is pending, it bails out
immediately and the checks are rather frequent. So why retry?
