Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C48398E6A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhFBPVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:21:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33770 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhFBPUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:17 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 108B5336E9;
        Wed,  2 Jun 2021 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622647112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=+mrc6++6WowrRrzI0TFBvSWZxYHBvzCg6qyOdVwJT+I=;
        b=P/l32B3moMloUZry2OLrDmFGSICn+UwgN/YI7h2bcMtBwIbDMDU29jQpy6X8qmEeygauvY
        9AXKHt6yRQcmxVIviCWMMLkOazy2yTr9KbjGXhCRGiyJg2Pq2v2nxLOuhdjOzH9J3PvNX2
        ta+7UyPCGLVVdJk0y+8/1GGfzd7vWCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622647112;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=+mrc6++6WowrRrzI0TFBvSWZxYHBvzCg6qyOdVwJT+I=;
        b=qm8lA7JhSr+Rz3HQvm3OuD2ukMyxFgu9GaE+ypLPloiJTAVQs1mPFDJeLl7jpGXjKlzCH+
        +92lpVDDB3ha/9Cw==
Received: by imap.suse.de (Postfix, from userid 51)
        id 05A2F11CD7; Wed,  2 Jun 2021 15:28:32 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3092411D1C;
        Wed,  2 Jun 2021 09:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622625308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=+mrc6++6WowrRrzI0TFBvSWZxYHBvzCg6qyOdVwJT+I=;
        b=BmPshbbJFOD35THzu+13J1d+3d7G3OQ5iq82DNDZVKQn65bH9khU4Pw/kM675AlL44Lh3U
        lf4/3ymCXHXyG7LpExx8Elq+gv1IJvk8f3//yhlFzf4MBjqyF3IJw48yUY1BOMF2ZDqwlw
        q7KsZiOjokj13qmjBM5Pk3yT50QcI6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622625308;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=+mrc6++6WowrRrzI0TFBvSWZxYHBvzCg6qyOdVwJT+I=;
        b=XWYbN4hjXRzM4bk5v7D+cpn63OB4U1TvN1dKZ5FbKWZX8URQw/6jZevcRf04uJ4MQiEaQF
        8WA4CPtKx34cB5BQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id KrtyCBxMt2A6HgAALh3uQQ
        (envelope-from <osalvador@suse.de>); Wed, 02 Jun 2021 09:15:08 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/3] Memory hotplug locking cleanup
Date:   Wed,  2 Jun 2021 11:14:54 +0200
Message-Id: <20210602091457.17772-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I decided to go one step further and completely rip out zone's span_seqlock
and all related functions, since we should be ok by using {get,put}_online_mems()
on the reader side given that memory-hotplug is the only user fiddling with
those values.

Patch#1 and patch#2 could probably be squashed but I decided to keep them
separated so the intention becomes more clear.
Patch#3 only removes declarations that seem never be used.

Given that this is a much bigger surgery, I decided to drop any Acked-by/
Reviewed-by.

Oscar Salvador (3):
  mm,page_alloc: Use {get,put}_online_mems() to get stable zone's values
  mm,memory_hotplug: Drop unneeded locking
  mm,memory_hotplug: Remove unneeded declarations

 include/linux/memory_hotplug.h | 38 --------------------------------------
 include/linux/mmzone.h         | 23 +++++------------------
 mm/memory_hotplug.c            | 16 +---------------
 mm/page_alloc.c                | 15 ++++++---------
 4 files changed, 12 insertions(+), 80 deletions(-)

-- 
2.16.3

