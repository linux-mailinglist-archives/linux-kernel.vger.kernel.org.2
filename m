Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E643911BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhEZIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:03:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:60370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232298AbhEZICv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:02:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622016079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWOPBQ1pj1zFMUMsz/b4hKBPetst6s8mKbcaRpTB9pY=;
        b=j8QQ++bLNEhkbROh07PvuR8wQ+bThLNGen2ltYlHcruvlhFPoGjzTNuAVnX1rBveuDG9Ot
        lekvX9WNHmRKPN7bTXF5PhMgE0G6avQ4lKF0mkd8HPXgC+FcAOvy6wmh82yiqoHTTt0VnC
        +ec+WsA95DeBlHCOz9OrU/brik0Csas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622016079;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWOPBQ1pj1zFMUMsz/b4hKBPetst6s8mKbcaRpTB9pY=;
        b=Gc195WCgEiU/ST9BzqWQ88o6wFlEtJ/nk9Md+Edd1UQcoZmxfTFLC0mnxlkF514SYA0FZ3
        cmH6Nul5CGyiYUCg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2F381AF4F;
        Wed, 26 May 2021 08:01:19 +0000 (UTC)
Date:   Wed, 26 May 2021 10:01:16 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qian Cai <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v1] drivers/base/memory: fix trying offlining memory
 blocks with memory holes on aarch64
Message-ID: <20210526080111.GA31866@linux>
References: <20210526075226.5572-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526075226.5572-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 09:52:26AM +0200, David Hildenbrand wrote:
> Fixes: a08a2ae34613 ("mm,memory_hotplug: allocate memmap from the added memory range")
> Reported-by: Qian Cai (QUIC) <quic_qiancai@quicinc.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Thanks David:

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
