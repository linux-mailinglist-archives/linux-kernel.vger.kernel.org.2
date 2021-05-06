Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287DA374FA5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 08:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhEFG5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 02:57:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232268AbhEFG5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 02:57:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620284172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lKbRHyh2lKlCKl8rir1n/Efa5oW+STFn0Q/ML8ucRpY=;
        b=ubW29TkrTiDupKWFTAjhLt/ZKbh7Nw0mTQURjRVnXbukRYNfhNnt9swQLIC6W26glObj/U
        VqHoD1tKTddXlvmkvMMmr/RTr1ZRO1x3dI8gvtfkk3SzeQyDr+iMbiybGPB22ByILx0Vhk
        gi9fepdG25NdeXtjsTgWOoqSDIpaNko=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 662A2B200;
        Thu,  6 May 2021 06:56:12 +0000 (UTC)
Date:   Thu, 6 May 2021 08:56:11 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Aili Yao <yaoaili@kingsoft.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "mm/gup: check page posion status for coredump."
Message-ID: <YJOTC3NOoeAvBTlQ@dhcp22.suse.cz>
References: <20210505135407.31590-1-mhocko@kernel.org>
 <bedd4817-5b2e-4041-3b55-f8ebfd98505f@redhat.com>
 <20210505102547.8ee8ed1848370cc259dbe857@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505102547.8ee8ed1848370cc259dbe857@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-05-21 10:25:47, Andrew Morton wrote:
> On Wed, 5 May 2021 15:55:42 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
> > 
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> cc:stable?

This has been merged into 5.12-rc7 and it didn't have any Fixes tag nor
it was CCed for stable. But stable tree is quite pro-active blindly
backporting anything resembling a fix might just sneak it in. So I would
go and mark is for stable just in case.

Thanks!

-- 
Michal Hocko
SUSE Labs
