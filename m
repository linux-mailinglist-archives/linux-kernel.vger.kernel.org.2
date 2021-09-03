Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D045400478
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350338AbhICSDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229929AbhICSDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630692171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnDa6K6xFS+tV9OXrILmFSSHahyJVpS7GlKc3UMRiis=;
        b=efTajegKnFEv8o1gpmtyiGs+yAcOul/O8wM104yoCiAk6jjLNdMEdyTFaHCJKkuagNR5vC
        EWF2BZf3mk3WRBdOeHgL1KspsmQ1QQDnw1rzlzecgfwuG1DAR+kpDAFhHARz0Y9u2Vkx1Z
        6PPfiBh886X+0yvmfbcZlop521GS3HY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-Mn4SclSuM3KaxDMrtdtepw-1; Fri, 03 Sep 2021 14:02:50 -0400
X-MC-Unique: Mn4SclSuM3KaxDMrtdtepw-1
Received: by mail-qv1-f70.google.com with SMTP id b1-20020ad45181000000b00374cb3949ecso137629qvp.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 11:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZnDa6K6xFS+tV9OXrILmFSSHahyJVpS7GlKc3UMRiis=;
        b=jPzZIHxytCee37Ekef6qW+JeYTyYDAFG05oLPz8TIJLCaMacs+t2bbs60W/GXgDkMn
         a0DBI3UYKlFNhxbo/wAyOiPl8ojvUK+Etp/gtv/1Qh6CxUnxyE64PzLpOLFVUAK3Wn7a
         J1fX7QUem8wB+LeXWi+It0WREXsssLbAwBQjRTueDxVQhj0/xjwypZBdz891QU/pMkoL
         HnopFmvzPhLWaKSq1SFlI0UkXnyv0qFLdjdFvnvCwmFauzA4ZIiPi8rDhgrtlKqU94rr
         z6LEl9sLL3EVnwPel5BC7IJF0uIEdyj2VNfmh9qK00V+mCXw0rdqoHe5QzfLp1HH0RZr
         3TEg==
X-Gm-Message-State: AOAM532iZp+TvFQPg+KfqCqGnV4BRYdZNF9UBWzZV2+fIPtmndGevy1a
        6SVibosyPIbrbayBLNGxXmvewjCgdY/XL9S+85h2BD39SeOh8xORPI55S5fJDwOAkyMuP0k6Cgx
        zKfQZFclVCntBHA/CqKpdiPnj
X-Received: by 2002:a0c:9a08:: with SMTP id p8mr353764qvd.2.1630692169819;
        Fri, 03 Sep 2021 11:02:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk4oScsUP5FZAKhLLXiQDoNIFUzqNOO0AnJ6KAMByq8bGQgCKRs7ys4TPelO3W7ZxEfnPu9w==
X-Received: by 2002:a0c:9a08:: with SMTP id p8mr353719qvd.2.1630692169465;
        Fri, 03 Sep 2021 11:02:49 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id b19sm4421720qkc.7.2021.09.03.11.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 11:02:49 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/2] ipc/util.c: Cleanup and improve sysvipc_find_ipc(),
 V2
To:     Manfred Spraul <manfred@colorfullife.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, 1vier1@web.de
References: <20210903052020.3265-1-manfred@colorfullife.com>
 <20210903052020.3265-3-manfred@colorfullife.com>
Message-ID: <cb984dbc-27ee-e0c5-1b2a-95d64f0f3598@redhat.com>
Date:   Fri, 3 Sep 2021 14:02:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210903052020.3265-3-manfred@colorfullife.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 1:20 AM, Manfred Spraul wrote:
> sysvipc_find_ipc() can be simplified further:
>
> - It uses a for() loop to locate the next entry in the idr.
>    This can be replaced with idr_get_next().
>
> - It receives two parameters (pos - which is actually
>    and idr index and not a position, and new_pos, which
Typo: "and" => "an"
>    is really a position).
>    One parameter is sufficient.
>
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> ---
>   ipc/util.c | 53 ++++++++++++++++++++++++++++++++---------------------
>   1 file changed, 32 insertions(+), 21 deletions(-)
>
> diff --git a/ipc/util.c b/ipc/util.c
> index d48d8cfa1f3f..bc5000b2457a 100644
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -782,28 +782,37 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
>   	return iter->pid_ns;
>   }
>   
> -/*
> - * This routine locks the ipc structure found at least at position pos.
> +/**
> + * sysvipc_find_ipc - Find and lock the ipc structure based on seq pos
> + * @ids: ipc identifier set
> + * @pos: expected position
> + *
> + * The function finds an ipc structure, based on the sequence file
> + * position @pos. If there is no ipc structure at position @pos, then
> + * the successor is selected.
> + * If a structure is found, then it is locked (both rcu_read_lock() and
> + * ipc_lock_object()) and  @pos is set to the position needed to locate
> + * the found ipc structure.
> + * If nothing is found (i.e. EOF), @pos is not modified.
> + *
> + * The function returns the found ipc structure, or NULL at EOF.
>    */
> -static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
> -					      loff_t *new_pos)
> +static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t *pos)
>   {
> -	struct kern_ipc_perm *ipc = NULL;
> -	int max_idx = ipc_get_maxidx(ids);
> +	int tmpidx;
> +	struct kern_ipc_perm *ipc;
>   
> -	if (max_idx == -1 || pos > max_idx)
> -		goto out;
> +	/* convert from position to idr index -> "-1" */
> +	tmpidx = *pos - 1;
>   
> -	for (; pos <= max_idx; pos++) {
> -		ipc = idr_find(&ids->ipcs_idr, pos);
> -		if (ipc != NULL) {
> -			rcu_read_lock();
> -			ipc_lock_object(ipc);
> -			break;
> -		}
> +	ipc = idr_get_next(&ids->ipcs_idr, &tmpidx);
> +	if (ipc != NULL) {
> +		rcu_read_lock();
> +		ipc_lock_object(ipc);
> +
> +		/* convert from idr index to position  -> "+1" */
> +		*pos = tmpidx + 1;
>   	}
> -out:
> -	*new_pos = pos + 1;
>   	return ipc;
>   }
>   
> @@ -817,11 +826,13 @@ static void *sysvipc_proc_next(struct seq_file *s, void *it, loff_t *pos)
>   	if (ipc && ipc != SEQ_START_TOKEN)
>   		ipc_unlock(ipc);
>   
> -	return sysvipc_find_ipc(&iter->ns->ids[iface->ids], *pos, pos);
> +	/* Next -> search for *pos+1 */
> +	(*pos)++;
> +	return sysvipc_find_ipc(&iter->ns->ids[iface->ids], pos);
>   }
>   
>   /*
> - * File positions: pos 0 -> header, pos n -> ipc id = n - 1.
> + * File positions: pos 0 -> header, pos n -> ipc idx = n - 1.
>    * SeqFile iterator: iterator value locked ipc pointer or SEQ_TOKEN_START.
>    */
>   static void *sysvipc_proc_start(struct seq_file *s, loff_t *pos)
> @@ -846,8 +857,8 @@ static void *sysvipc_proc_start(struct seq_file *s, loff_t *pos)
>   	if (*pos == 0)
>   		return SEQ_START_TOKEN;
>   
> -	/* Find the (pos-1)th ipc */
> -	return sysvipc_find_ipc(ids, *pos - 1, pos);
> +	/* Otherwise return the correct ipc structure */
> +	return sysvipc_find_ipc(ids, pos);
>   }
>   
>   static void sysvipc_proc_stop(struct seq_file *s, void *it)

Other than the typo, the patch looks good to me.

Acked-by: Waiman Long <longman@redhat.com>

