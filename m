Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FA03B7404
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbhF2OOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:14:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53862 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhF2OO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:14:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 03B72226AB;
        Tue, 29 Jun 2021 14:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624975921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DlisRa0Lh5ZDcC0aA7CRmD4wVeWJekk5S8eo2LllnQc=;
        b=fMk0ecluwK7phJjKD9C3ZylkpTsyXs8oYN5zeMO/FPdQAPqjA7vhETF42T/F1zjHVJbPl9
        NuG+i0qntP33K2L/zVXmoz1Qk1zPJUmvcNce1m+gpZd3eMffJvVExv5o9Q+9jBlcCSaCJ5
        39DzkZtx4ptmQv2P2f1W0TaA83Cc9+U=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C75B2A3C42;
        Tue, 29 Jun 2021 14:12:00 +0000 (UTC)
Date:   Tue, 29 Jun 2021 16:11:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmalloc: add cond_resched() in __vunmap()
Message-ID: <YNsM00SodmwqV6qN@dhcp22.suse.cz>
References: <20210622225030.478384-1-aquini@redhat.com>
 <YNR4ZkwF+Bh11XMC@dhcp22.suse.cz>
 <20210624142339.GA2267@pc638.lan>
 <YNWY/IY+ftszkjM5@dhcp22.suse.cz>
 <20210625160011.GA50201@pc638.lan>
 <YNnEjp72rzT7zQ10@dhcp22.suse.cz>
 <20210628164002.GA11817@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628164002.GA11817@pc638.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-06-21 18:40:02, Uladzislau Rezki wrote:
> Also another option can be:
> 
> if a pcp list is fully consumed, so a refilling is required to proceed with array
> populating, leave atomic section(enable irq), do a breath by invoking cond_resched()?

I do not know. I would rather not medle with the pcp batches. It is a hot
path and caller can decide the fallback mechanism.
-- 
Michal Hocko
SUSE Labs
