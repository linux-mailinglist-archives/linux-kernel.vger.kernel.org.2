Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943173F5CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbhHXLNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:13:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49000 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbhHXLNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:13:43 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4351E1FD89;
        Tue, 24 Aug 2021 11:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629803578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T//DTmVMjK9REXkQcu9neG97LcFkMDx+SNqL/Q28EUM=;
        b=fRmx+NCziQB/kslRCSbWJeLf2UbxXjgMMXjaPDlENPkeXv8VXVi63v1/UwYVH+vLMH1Wcw
        +lWQf/SqPUjRW6PLG+B+em9HjByLUN4KdlB08dfuz2T0xiwbaJ4rdIKztcqlQVQPMv7Bdk
        JVozl8DSmo1le6TAUNAuufvzrsZO4YE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629803578;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T//DTmVMjK9REXkQcu9neG97LcFkMDx+SNqL/Q28EUM=;
        b=WDUBB+J/r3yrIg713s121i6sdEdLXOEdgLa4RC6efUSlkdWpTzKeP0NE7PdO5Mvwgv/Vvi
        SOzg8qUV+Pag6CBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 064491393C;
        Tue, 24 Aug 2021 11:12:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id +K4mOznUJGE9GAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 24 Aug 2021 11:12:57 +0000
Message-ID: <325020b2-67b0-7cdd-36e2-bdb90f8820e3@suse.cz>
Date:   Tue, 24 Aug 2021 13:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCHv2 1/2] kernel/workqueue: Make schedule_on_each_cpu as
 EXPORT_SYMBOL_GPL
Content-Language: en-US
To:     Dennis Zhou <dennis@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Christoph Hellwig <hch@infradead.org>
References: <5afc2a0c4da65e71ccf24fe65396710d34fc662e.1629751104.git.riteshh@linux.ibm.com>
 <YSRUNzVEig80IBtq@fedora>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YSRUNzVEig80IBtq@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 04:06, Dennis Zhou wrote:
> Hello,
> 
> On Tue, Aug 24, 2021 at 02:12:29AM +0530, Ritesh Harjani wrote:
>> Make schedule_on_each_cpu as EXPORT_SYMBOL_GPL
>> 
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>> [v1 -> v2]: Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
>> 
>>  kernel/workqueue.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index f148eacda55a..993f8983186d 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -3309,6 +3309,7 @@ int schedule_on_each_cpu(work_func_t func)
>>  	free_percpu(works);
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_GPL(schedule_on_each_cpu);
>> 
>>  /**
>>   * execute_in_process_context - reliably execute the routine with user context
>> --
>> 2.31.1
>> 
> 
> I think you missed the point of Christoph's comment. I agree with him
> and don't think a test justifies exporting of this particular function.

Could symbol namespaces help in these cases? It feels wrong to limit in-tree
test modules this way.
https://www.kernel.org/doc/html/latest/core-api/symbol-namespaces.html

> Thanks,
> Dennis
> 

