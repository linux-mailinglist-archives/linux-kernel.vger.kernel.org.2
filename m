Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AAE422097
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhJEIYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:24:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50026 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbhJEIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:23:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6B4A4223F4;
        Tue,  5 Oct 2021 08:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633422123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z6TyAwNxsP811avxRnGy2VkclzJcuuGT0z3UaNObJW8=;
        b=J1iQGslrflW4b7YK5g7tJ+/LeQoU7T4bDo9vCeaHoOsqxA4dbQ9/h/hxVRXWm3WNYOq2rJ
        l67dj8/+LNiPFG5YpAngjqCbD7hU3YGrgYBNXp2JJMeX8c3lhVwSAsBx4fpNjTWvd9aT40
        H4KXeGR06h+bZTlVCrOkrpEmKmMXAQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633422123;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z6TyAwNxsP811avxRnGy2VkclzJcuuGT0z3UaNObJW8=;
        b=B89hJRQby5mJ2aqeBN21sVIitkWqvzrwjQ+R/gXkLAs4bC8RE8fllpYHOYRBMji2j52Jpm
        mxaUKHoHIQWkX0Aw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 22ECEA3B83;
        Tue,  5 Oct 2021 08:22:03 +0000 (UTC)
Date:   Tue, 5 Oct 2021 09:22:01 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, riel@redhat.com
Subject: Re: [PATCH 3/4] sched/numa: Fix a few comments
Message-ID: <20211005082201.GM3891@suse.de>
References: <20211004105706.3669-1-bharata@amd.com>
 <20211004105706.3669-4-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211004105706.3669-4-bharata@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 04:27:05PM +0530, Bharata B Rao wrote:
> Fix a few comments to help understand them better.
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
