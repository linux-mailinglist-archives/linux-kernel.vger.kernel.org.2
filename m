Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27DA39F2A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhFHJnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:43:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37626 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhFHJnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:43:40 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C572219C0;
        Tue,  8 Jun 2021 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623145307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HRJmshlKzh06hRuJq6zblAZqJa6EKi5x5hSc419U1NA=;
        b=2o8p8DznDE8mXnw4gkvTJmmxmIHrK6X0jtY8nCyAN1rR8KzdYeCq4LoBb02Q8xtfkvXrRr
        f6iAE094/uu1vg2MEWoEZib5g36tkeblVoIDsUSF0QUIihLWytgQedO1ebF7ZF2s6cDpKd
        t5k4cYHCJQs52+12z6ySLpAWooUNugs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623145307;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HRJmshlKzh06hRuJq6zblAZqJa6EKi5x5hSc419U1NA=;
        b=CN1/zWOKjD3oT5SA8p3wGOzPUI8lBXPxUPYYhOD6GZgzdijPkZ/0MeQgohLEtasG4tmuLo
        m80/hTBReMdxX2Bg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id ED591118DD;
        Tue,  8 Jun 2021 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623145307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HRJmshlKzh06hRuJq6zblAZqJa6EKi5x5hSc419U1NA=;
        b=2o8p8DznDE8mXnw4gkvTJmmxmIHrK6X0jtY8nCyAN1rR8KzdYeCq4LoBb02Q8xtfkvXrRr
        f6iAE094/uu1vg2MEWoEZib5g36tkeblVoIDsUSF0QUIihLWytgQedO1ebF7ZF2s6cDpKd
        t5k4cYHCJQs52+12z6ySLpAWooUNugs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623145307;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HRJmshlKzh06hRuJq6zblAZqJa6EKi5x5hSc419U1NA=;
        b=CN1/zWOKjD3oT5SA8p3wGOzPUI8lBXPxUPYYhOD6GZgzdijPkZ/0MeQgohLEtasG4tmuLo
        m80/hTBReMdxX2Bg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id dfwOOVo7v2CbZQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Tue, 08 Jun 2021 09:41:46 +0000
Subject: Re: [PATCH v11] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com,
        andy.shevchenko@gmail.com
Cc:     vinmenon@codeaurora.org
References: <1623141934-7699-1-git-send-email-faiyazm@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d79ff9cd-e72d-0e6a-1fb0-e8a64b20138a@suse.cz>
Date:   Tue, 8 Jun 2021 11:41:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1623141934-7699-1-git-send-email-faiyazm@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 10:45 AM, Faiyaz Mohammed wrote:
> alloc_calls and free_calls implementation in sysfs have two issues,
> one is PAGE_SIZE limitation of sysfs and other is it does not adhere
> to "one value per file" rule.
> 
> To overcome this issues, move the alloc_calls and free_calls
> implementation to debugfs.
> 
> Debugfs cache will be created if SLAB_STORE_USER flag is set.
> 
> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> to be inline with what it does.
> 
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!
