Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B943E50C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 03:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhHJBt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 21:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232781AbhHJBtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628560143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/wAzrc8J5cmRbOchhGbtSEbD1ZOJi+Aa/9jK/YVSb4=;
        b=YP/2bhvunI0ZRRBUqkt+vTZEW28JkQBgoabRmj5SNLdI93XnU6/QR0E7H7UFzBz3jkEkIK
        RuaFyx1+B46z+a56T94mRaMTTcxB6yjOw44MlvyGucsnGMygZRMnY7UoQDFwkWdBItGLEO
        CVRpcpahdSoT2/r5wKwSlw2p1jDtCjc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-qqM4ZMadMTOEt1dtFfEXXQ-1; Mon, 09 Aug 2021 21:49:01 -0400
X-MC-Unique: qqM4ZMadMTOEt1dtFfEXXQ-1
Received: by mail-qv1-f69.google.com with SMTP id b2-20020a0cc9820000b0290352b2c7d7e1so4829851qvk.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 18:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=H/wAzrc8J5cmRbOchhGbtSEbD1ZOJi+Aa/9jK/YVSb4=;
        b=XGxdCDGA+Rhcm3wh5ROxg8US6so7y8iit6MJ1Ezc6j7UzCt9brX2QKyNauJET1v9KE
         7aYiipSGhxSm/QEft3FUexoWd8ioSZ1dE25i9SS5NYavgZcCBwkpEsVGueAiM7d72GR9
         yoWAEDJh4Dm00/Zcm4/gGRAG6cF15OLvuAIKJ71xMyihuadg8xn0S5eGRUqHDMQRceBC
         JxiRTOTd8lpCRyNNx2dCHUmwBdMRtFjfIrd0iuzhI/gQDfS35rx1oqoRcV6M9ZWuNrft
         JqOaIysn9yiEUq4NkNfBUu42yvu7QpGLmYHqf0/+fByQ34bMdKSj591cAgejO93xTb8n
         l8Jg==
X-Gm-Message-State: AOAM532091ZjMdOKyttrQfdFEsF+GC58U3zsaC+SZgWZeL0D7b5BPTq9
        F3Lgj2VCUjeOeJ7EpVeBL64XCp6Qm33HCIJ3AnQTfPf+vy0CO4VzR7V5nsa6VIARjxS2Dq7yZWQ
        4KbDpUG2/iyZ+viIMZ97a53Pi
X-Received: by 2002:ac8:774b:: with SMTP id g11mr21973515qtu.380.1628560141371;
        Mon, 09 Aug 2021 18:49:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxS96rEJ7oHThL6ULlmD05tFerias1RrhZgDQJBFfovNbEIMgoaj5F5YHivPXC6VoUI51JWWg==
X-Received: by 2002:ac8:774b:: with SMTP id g11mr21973505qtu.380.1628560141206;
        Mon, 09 Aug 2021 18:49:01 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id y67sm10104324qkd.58.2021.08.09.18.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 18:49:00 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] ipc: replace costly bailout check in sysvipc_find_ipc()
To:     Rafael Aquini <aquini@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>
References: <20210809203554.1562989-1-aquini@redhat.com>
Message-ID: <c67b8612-d299-704e-9294-7c5f82028272@redhat.com>
Date:   Mon, 9 Aug 2021 21:48:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809203554.1562989-1-aquini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 4:35 PM, Rafael Aquini wrote:
> sysvipc_find_ipc() was left with a costly way to check if the offset
> position fed to it is bigger than the total number of IPC IDs in use.
> So much so that the time it takes to iterate over /proc/sysvipc/* files
> grows exponentially for a custom benchmark that creates "N" SYSV shm
> segments and then times the read of /proc/sysvipc/shm (milliseconds):
>
>      12 msecs to read   1024 segs from /proc/sysvipc/shm
>      18 msecs to read   2048 segs from /proc/sysvipc/shm
>      65 msecs to read   4096 segs from /proc/sysvipc/shm
>     325 msecs to read   8192 segs from /proc/sysvipc/shm
>    1303 msecs to read  16384 segs from /proc/sysvipc/shm
>    5182 msecs to read  32768 segs from /proc/sysvipc/shm
>
> The root problem lies with the loop that computes the total amount of ids
> in use to check if the "pos" feeded to sysvipc_find_ipc() grew bigger than
> "ids->in_use". That is a quite inneficient way to get to the maximum index
> in the id lookup table, specially when that value is already provided by
> struct ipc_ids.max_idx.
>
> This patch follows up on the optimization introduced via commit 15df03c879836
> ("sysvipc: make get_maxid O(1) again") and gets rid of the aforementioned
> costly loop replacing it by a simpler checkpoint based on ipc_get_maxidx()
> returned value, which allows for a smooth linear increase in time complexity
> for the same custom benchmark:
>
>       2 msecs to read   1024 segs from /proc/sysvipc/shm
>       2 msecs to read   2048 segs from /proc/sysvipc/shm
>       4 msecs to read   4096 segs from /proc/sysvipc/shm
>       9 msecs to read   8192 segs from /proc/sysvipc/shm
>      19 msecs to read  16384 segs from /proc/sysvipc/shm
>      39 msecs to read  32768 segs from /proc/sysvipc/shm
>
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> ---
>   ipc/util.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/ipc/util.c b/ipc/util.c
> index 0027e47626b7..d48d8cfa1f3f 100644
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

The "pos > max_idx" check is redundant and so is not really necessary. 
Other than that, the patch looks good to me.

Reviewed-by: Waiman Long <longman@redhat.com>

