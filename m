Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFD13D74F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhG0MWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 08:22:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51822 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbhG0MWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:22:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C92402010E;
        Tue, 27 Jul 2021 12:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627388556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhSGMq7tsjdfqb7/t5p2DvbOChFLPsCT3Y6+zkWRChw=;
        b=drooZA9RHdejzN/hjfmZw7+rh7uQDPObeOlpJ0RTDivO+SA0+VvlGdZykyq6ohmk9CWw5F
        wKhZ9IMO7qNpzYCgzVnqDEG17NUmoWOawZaulid9cKBPKnwc8fe6KC0qF8dJdwOfkq1rRe
        Q9bD+AEEBpDO04X33fHNcx8LqZq6fsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627388556;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhSGMq7tsjdfqb7/t5p2DvbOChFLPsCT3Y6+zkWRChw=;
        b=yrQhWrvOHC4v3aLtpu6TA3ebbclssktj/cKmBgZVbO3ULD0fIx5Bq6Gqq/C7ng5yyyMCvo
        jiRWE1H8T8zyDxCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F2B413B77;
        Tue, 27 Jul 2021 12:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZwwDJoz6/2AiLgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 27 Jul 2021 12:22:36 +0000
Subject: Re: [PATCH] mm: slub: Fix slub_debug disablement for list of slabs
To:     Vijayanand Jitta <vjitta@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
References: <1626176750-13099-1-git-send-email-vjitta@codeaurora.org>
 <bf2a8571-325c-6d94-0d5a-f6df71ae0c4f@suse.cz>
 <e0442add-dcf0-57d7-2298-3459136673af@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8a3d992a-473a-467b-28a0-4ad2ff60ab82@suse.cz>
Date:   Tue, 27 Jul 2021 14:22:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e0442add-dcf0-57d7-2298-3459136673af@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/21 6:43 AM, Vijayanand Jitta wrote:
> 
> 
> On 7/27/2021 4:02 AM, Vlastimil Babka wrote:
>> On 7/13/21 1:45 PM, vjitta@codeaurora.org wrote:
>>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>>>
>>> Consider the scenario where CONFIG_SLUB_DEBUG_ON is set
>>> and we would want to disable slub_debug for few slabs.
>>> Using boot parameter with slub_debug=-,slab_name syntax
>>> doesn't work as expected i.e; only disabling debugging for
>>> the specified list of slabs, instead it disables debugging
>>> for all slabs. Fix this.
>>>
>>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>>
>> Would the following work too, and perhaps be easier to follow?
> 
> Right, the below change would also work and its easier to follow as you
> said. We can go with this.
> 
> Reviewed-by: Vijayanand Jitta <vjitta@codeaurora.org>

Thanks! Here's the full patch
----8<----
From 81a225fe31e53701902bb4caa9ab1524eb044cbc Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 13 Jul 2021 17:15:50 +0530
Subject: [PATCH] mm: slub: fix slub_debug disabling for list of slabs

Vijayanand Jitta reports:

  Consider the scenario where CONFIG_SLUB_DEBUG_ON is set
  and we would want to disable slub_debug for few slabs.
  Using boot parameter with slub_debug=-,slab_name syntax
  doesn't work as expected i.e; only disabling debugging for
  the specified list of slabs. Instead it disables debugging
  for all slabs, which is wrong.

This patch fixes it by delaying the moment when the global slub_debug flags
variable is updated. In case a "slub_debug=-,slab_name" has been passed, the
global flags remain as initialized (depending on CONFIG_SLUB_DEBUG_ON enabled
or disabled) and are not simply reset to 0.

Reported-by: Vijayanand Jitta <vjitta@codeaurora.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 mm/slub.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 090fa14628f9..024f49706386 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1400,12 +1400,13 @@ parse_slub_debug_flags(char *str, slab_flags_t *flags, char **slabs, bool init)
 static int __init setup_slub_debug(char *str)
 {
 	slab_flags_t flags;
+	slab_flags_t global_flags;
 	char *saved_str;
 	char *slab_list;
 	bool global_slub_debug_changed = false;
 	bool slab_list_specified = false;
 
-	slub_debug = DEBUG_DEFAULT_FLAGS;
+	global_flags = DEBUG_DEFAULT_FLAGS;
 	if (*str++ != '=' || !*str)
 		/*
 		 * No options specified. Switch on full debugging.
@@ -1417,7 +1418,7 @@ static int __init setup_slub_debug(char *str)
 		str = parse_slub_debug_flags(str, &flags, &slab_list, true);
 
 		if (!slab_list) {
-			slub_debug = flags;
+			global_flags = flags;
 			global_slub_debug_changed = true;
 		} else {
 			slab_list_specified = true;
@@ -1426,16 +1427,18 @@ static int __init setup_slub_debug(char *str)
 
 	/*
 	 * For backwards compatibility, a single list of flags with list of
-	 * slabs means debugging is only enabled for those slabs, so the global
-	 * slub_debug should be 0. We can extended that to multiple lists as
+	 * slabs means debugging is only changed for those slabs, so the global
+	 * slub_debug should be unchanged (0 or DEBUG_DEFAULT_FLAGS, depending
+	 * on CONFIG_SLUB_DEBUG_ON). We can extended that to multiple lists as
 	 * long as there is no option specifying flags without a slab list.
 	 */
 	if (slab_list_specified) {
 		if (!global_slub_debug_changed)
-			slub_debug = 0;
+			global_flags = slub_debug;
 		slub_debug_string = saved_str;
 	}
 out:
+	slub_debug = global_flags;
 	if (slub_debug != 0 || slub_debug_string)
 		static_branch_enable(&slub_debug_enabled);
 	else
-- 
2.32.0

