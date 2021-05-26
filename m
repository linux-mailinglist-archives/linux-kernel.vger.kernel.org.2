Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA1B39153B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhEZKov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:44:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50148 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbhEZKot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:44:49 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out1.suse.de (Postfix) with ESMTP id 51FC1218C1;
        Wed, 26 May 2021 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622025797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fPj7I8V78aVsynCxxpq/KE8MVBwA6HB4n+JsNyHu7MU=;
        b=w1rKkhFi0pJrSnQzbPlCi4jd4JUmWCVbmkawo5ONWkLGZjaAd4OOTVjHa4Gmezql6+NA8L
        Xs2JC03L35Z2UpeaK8c9+ThtIDQe8LKA4JXZ5fhUKQy4gIg3IGzfafNbLsx4l8jSmbIKso
        Wf3uKdBlLO/TjQhlOa5pd+2vYAIa8z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622025797;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fPj7I8V78aVsynCxxpq/KE8MVBwA6HB4n+JsNyHu7MU=;
        b=Kgg05ZV4mpHpEobXG9Pmzub+QvqWZu63oCZiSMvUiYFaVZDMzSS8BBkwapybROS2wdhjrA
        nBAUC4K0V2lia6CA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id EC14011A98;
        Wed, 26 May 2021 10:43:16 +0000 (UTC)
Date:   Wed, 26 May 2021 12:43:15 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Ding Hui <dinghui@sangfor.com.cn>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/page_alloc: fix counting of free pages after take
 off from buddy
Message-ID: <20210526104315.GD1656@linux>
References: <20210526075247.11130-1-dinghui@sangfor.com.cn>
 <301ec664-f153-7ed6-0231-8bbffb630a0d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301ec664-f153-7ed6-0231-8bbffb630a0d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 09:58:15AM +0200, David Hildenbrand wrote:
> I guess if we'd actually be removing a page from the buddy while it's
> currently isolated by someone else (i.e., alloc_contig_range()), we might be
> in bigger trouble.
> 
> I think we should actually skip isolated pages completely.
> take_page_off_buddy() should not touch them.

That might be a problem indeed.
I will have a look at it.

Thanks

-- 
Oscar Salvador
SUSE L3
