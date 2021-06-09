Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8CD3A0E13
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbhFIHvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:51:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47848 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbhFIHvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:51:19 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2ADBA21991;
        Wed,  9 Jun 2021 07:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623224964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YeaBs+NUty+CWDtESM2SEAwt7NkUS5xAGfH6h7/gPNE=;
        b=ZMU+maSBKMFXoz89leeXeDQFfatxmjGJ89Pu80LIT6eNXMISKRnlgkrHAnKejhl4YqpDRq
        R1McsyHVn5DmnBsFiF0ZDNNpFwPsOkBxOMlRJ8MjyfuskJpOQ7c17EkACiiX/+ouFLBJ6H
        Qsu3uIAc3MHL8zfwP+m7ViBx0NbGfWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623224964;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YeaBs+NUty+CWDtESM2SEAwt7NkUS5xAGfH6h7/gPNE=;
        b=T+8c27WotrIv+tQbYS5jZhsmPDhkozhn1s1xwFSji3ue3AuxxmVYL8YaifAcQf5DkSju2Z
        iNGi6fgk2Cl/7/DA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3274D118DD;
        Wed,  9 Jun 2021 07:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623224964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YeaBs+NUty+CWDtESM2SEAwt7NkUS5xAGfH6h7/gPNE=;
        b=ZMU+maSBKMFXoz89leeXeDQFfatxmjGJ89Pu80LIT6eNXMISKRnlgkrHAnKejhl4YqpDRq
        R1McsyHVn5DmnBsFiF0ZDNNpFwPsOkBxOMlRJ8MjyfuskJpOQ7c17EkACiiX/+ouFLBJ6H
        Qsu3uIAc3MHL8zfwP+m7ViBx0NbGfWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623224964;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YeaBs+NUty+CWDtESM2SEAwt7NkUS5xAGfH6h7/gPNE=;
        b=T+8c27WotrIv+tQbYS5jZhsmPDhkozhn1s1xwFSji3ue3AuxxmVYL8YaifAcQf5DkSju2Z
        iNGi6fgk2Cl/7/DA==
Received: from director1.suse.de ([192.168.254.71])
        by imap3-int with ESMTPSA
        id rpcGCYNywGDBQQAALh3uQQ
        (envelope-from <osalvador@suse.de>); Wed, 09 Jun 2021 07:49:23 +0000
Date:   Wed, 9 Jun 2021 09:49:21 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] memory-hotplug.rst: complete admin-guide overhaul
Message-ID: <YMBygcyCM6ruLlat@localhost.localdomain>
References: <20210608133855.20397-1-david@redhat.com>
 <20210608133855.20397-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608133855.20397-3-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 03:38:55PM +0200, David Hildenbrand wrote:
> The memory hot(un)plug documentation is outdated and incomplete. Most of
> the content dates back to 2007, so it's time for a major overhaul.
> 
> Let's rewrite, reorganize and update most parts of the documentation. In
> addition to memory hot(un)plug, also add some details regarding
> ZONE_MOVABLE, with memory hotunplug being one of its main consumers.
> 
> Drop the file history, that information can more reliably be had from
> the git log.
> 
> The style of the document is also properly fixed that e.g., "restview"
> renders it cleanly now.
> 
> In the future, we might add some more details about virt users like
> virtio-mem, the XEN balloon, the Hyper-V balloon and ppc64 dlpar.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

I really like this:

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
