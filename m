Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FDC3EF1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhHQSel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhHQSej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:34:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CAC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:34:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l11so298984wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iL4mha+qm6Tde1apuUpcImkDlPPCgksXIXOGiU4nqQM=;
        b=LT/IPl3svjMKgmUH6BvskDKarh+tgGYdApGreghP73QEQjdvAGkIizMC/56ZDTgSwk
         1bVefNEVi1hKi+ns/Lf9x4z95HSUcBDgbqfgNBQvQxc+PBSj0Z2nBY0+po5MsId2Dwa6
         2w8O9wRb9Sj9iP75HFpddJlQYuCw0h92GLjWmk2wn1BKfmc5adr2yYaeOsjP/VMA0RRS
         PiPA3sWAeonUy1z9ut/MbCpdm3PQh/QB/Y74vELaM0wLNkmLLb4Hui3U4EZu9f7c699P
         RWHjkLF758/HyhJtQjRdH2+QZjNDzMQunY5OhP2Dw/d+1m0pkWvs/oRyoMzH68Wkk9sG
         OmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iL4mha+qm6Tde1apuUpcImkDlPPCgksXIXOGiU4nqQM=;
        b=ra/F2EXDS9X5hw5r6JQKFFN9KLd14npdWKAaZGHtN52Jt5m745cjJeGQjLOawOzBk2
         QxSmRmQ/A19/5f0VWrQfdxBSb52QCZH9HOisJhRpYOfyIOPRMrZWLvxgTNWzt/3GhxIP
         yyGoYkqF2RJ/nrVHOOt+DBSCNVMqrLsqbQt8HMrTT8CX9xA0qGDo/roq3VKCfEFShmSn
         ENnedds202MNfKyej4a/yY3Hf4njWwDKzAch825HdTc8cQ/O4HCfYbNAot04gxNceCpV
         6FCmDOfnz5HPCUNRMm8DdJTODS555aosYU3aPiOEeX9QbzwiaoqH9tW42NmvxGFkqwA+
         Nh8w==
X-Gm-Message-State: AOAM531FV3hm0stn0UZytqlOHZ9McOztrkHnCMb0Bl3qVQiSNCNiPjvV
        VIDTXA1JR65JgP726obCNYPWQQ==
X-Google-Smtp-Source: ABdhPJzj93fR1/QeH5Cs5CIZBOsh3ocX2SpZRvnEDuagUlVK+1/OKRjfLFxANt7lNpeaIXZrL5x+1A==
X-Received: by 2002:adf:f20d:: with SMTP id p13mr5922522wro.95.1629225245003;
        Tue, 17 Aug 2021 11:34:05 -0700 (PDT)
Received: from localhost.localdomain (p200300d9972f1000838d8dfea5ed2c3c.dip0.t-ipconnect.de. [2003:d9:972f:1000:838d:8dfe:a5ed:2c3c])
        by smtp.googlemail.com with ESMTPSA id k17sm3671511wrn.8.2021.08.17.11.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 11:34:04 -0700 (PDT)
Subject: Re: [PATCH] ipc: replace costly bailout check in sysvipc_find_ipc()
To:     Rafael Aquini <aquini@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>
References: <20210809203554.1562989-1-aquini@redhat.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <0b80af66-0ff4-5278-37e1-08966157493e@colorfullife.com>
Date:   Tue, 17 Aug 2021 20:34:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809203554.1562989-1-aquini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rafael,

I still try to understand the code. It seems, it is more or less 
unchanged from 2009:

|

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/ipc/util.c?id=7ca7e564e049d8b350ec9d958ff25eaa24226352 
|


On 8/9/21 10:35 PM, Rafael Aquini wrote:
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -788,21 +788,13 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
>   static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
>   					      loff_t *new_pos)
>   {
> -	struct kern_ipc_perm *ipc;
> -	int total, id;
> -
> -	total = 0;
> -	for (id = 0; id < pos && total < ids->in_use; id++) {
> -		ipc = idr_find(&ids->ipcs_idr, id);
> -		if (ipc != NULL)
> -			total++;
> -	}
> +	struct kern_ipc_perm *ipc = NULL;
> +	int max_idx = ipc_get_maxidx(ids);
>   
> -	ipc = NULL;
> -	if (total >= ids->in_use)
> +	if (max_idx == -1 || pos > max_idx)
>   		goto out;
>   
> -	for (; pos < ipc_mni; pos++) {
> +	for (; pos <= max_idx; pos++) {
>   		ipc = idr_find(&ids->ipcs_idr, pos);
>   		if (ipc != NULL) {
>   			rcu_read_lock();

The change looks as correct to me. But I'm still not sure that I really 
understand what the current code does:

- first, loop over index values in the idr, starting from 0, count found 
entries.

- if we found all entries before we are at index=pos: fail

- then search up to ipc_nmi for the next entry with an index >=pos.

- if something is found: use it. otherwise fail.

It seems the code tries to avoid that we loop until ipc_mni after the 
last entry was found, and therefore we loop every time from 0.


 From what I see, the change looks to be correct: You now remove the 
first loop, and instead of searching until ipc_mni, the search ends at 
<= max_idx.

I'll try to find some time to test it.


But: What about using idr_get_next() instead of the idr_find()?

We want to find the next used index, thus idr_get_next() should be even 
better than the for loop, ...


--

     Manfred

