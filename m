Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02883EE7E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 09:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhHQH6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 03:58:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36948 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbhHQH6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:58:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A054A2000E;
        Tue, 17 Aug 2021 07:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629187069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQSPMmgepRWx/W8lRpj8JNGzlpHUm8j9e1oI+oQVKoM=;
        b=egDfmTWgjA58Lnzy1gjCq+fdRgXSTrAwfYeINkivcfOCTt8hL19vWspPbORZCIg1ywLpUQ
        Cqz9afwHSSxluPVibn8IppqgnDXlZPDS/39HFzASfM452nvUiPMmKR/lFvjKGNg/kcrtX1
        Ni6vKmBSZALV/rEChZPaBI4VsxhDvJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629187069;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQSPMmgepRWx/W8lRpj8JNGzlpHUm8j9e1oI+oQVKoM=;
        b=g9+tvvJprEwd+NmROQI0RtrEDKbuN2p+fsuMBMCBoGh5FNtR37fI13PUJw+WbG4nIEFwEX
        irBs6ylNj9y+QKAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4111A13DF4;
        Tue, 17 Aug 2021 07:57:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HyfCDP1rG2GcNAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Aug 2021 07:57:49 +0000
Subject: Re: [PATCH] mm, slub: add cpus_read_lock/unlock() for
 slab_mem_going_offline_callback()
To:     David Hildenbrand <david@redhat.com>, qiang.zhang@windriver.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210816074605.30336-1-qiang.zhang@windriver.com>
 <ef944ea5-c3cb-24e5-1ff8-b8e1008fa6ed@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <dd5785b6-3f96-3af9-586b-1d962228bed8@suse.cz>
Date:   Tue, 17 Aug 2021 09:57:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ef944ea5-c3cb-24e5-1ff8-b8e1008fa6ed@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 10:04 AM, David Hildenbrand wrote:
> On 16.08.21 09:46, qiang.zhang@windriver.com wrote:
>> From: "Qiang.Zhang" <qiang.zhang@windriver.com>
>>
>> The flush_all_cpus_locked() should be called with cpus_read_lock/unlock(),
>> ensure flush_cpu_slab() can be executed on schedule_on CPU.
>>
>> Fixes: 1c84f3c91640 ("mm, slub: fix memory and cpu hotplug related lock ordering issues")
> Memory notifiers are getting called from online_pages()/offline_pages(), 
> where we call memory_notify(MEM_GOING_OFFLINE, &arg) under 
> mem_hotplug_begin().
> 
> mem_hotplug_begin() does a cpus_read_lock().

Exactly. Also flush_all_cpus_locked() has a lockdep assert for
cpus_read_lock() which doesn't trigger in testing.

> How does this even work or against which branch is this?
> 

