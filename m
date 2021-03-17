Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2174633E8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCQFL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhCQFLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:11:38 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0D4C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 22:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=EyyTpTD4D+QG3aFMH6sULSAKUIv36vsFDInnkX5cgjc=; b=VBUqH/eAGYoAgql0IMFOaPIKGt
        zzQQCeE0tfcG7wE6oIpM4jcs4Zfi7ppXCSqaGMgSrQHxU7mi5I4g0ZUUlg4fBYSuKVuZNcC3Kbpdj
        dCL2EK3MLqrh1ksZ5e0erztlVIn7zhDXnnJtaWgCKAdBV2fsIetM9yD2aUe3dRPSvAGN8goqLLXOv
        t8pX3D0G9bmUn6l9h8xWHQafKhNaYZNOty3lpyFVlNxNRbgPJweyPv2S86tP0DOZkxxPViitwDSEQ
        MjmZIwGjtDKc8TL5DsEoLT6tRCZoF59/0NIrUHcZOl+kW0q+PRRe0hZgNi6COzFyK3QDULeQzwr0K
        zeELyE8A==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMOT1-001bSp-Nx; Wed, 17 Mar 2021 05:11:36 +0000
Subject: Re: [PATCH] kernel: locking: Mundane typo fix in the file rwsem.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org
References: <20210317041806.4096156-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d3058afe-684f-687c-4813-fd8c11969488@infradead.org>
Date:   Tue, 16 Mar 2021 22:11:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317041806.4096156-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 9:18 PM, Bhaskar Chowdhury wrote:
> 
> s/folowing/following/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  kernel/locking/rwsem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index abba5df50006..fe9cc65cd522 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -632,7 +632,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>  }
> 
>  /*
> - * The rwsem_spin_on_owner() function returns the folowing 4 values
> + * The rwsem_spin_on_owner() function returns the following 4 values
>   * depending on the lock owner state.
>   *   OWNER_NULL  : owner is currently NULL
>   *   OWNER_WRITER: when owner changes and is a writer
> --


-- 
~Randy

