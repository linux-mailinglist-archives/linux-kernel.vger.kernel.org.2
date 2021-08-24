Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AF83F6038
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbhHXOYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237746AbhHXOYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629815047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rXM+IBI3cANg1BoBFaXjt+OJ0V+p5mrya6klP9WdYlA=;
        b=blgt5QHXN/+r0Gs60xHNTw07lsppJhxUMHtAuTHPRo0dFyWuev2QX8zEOIr/sT7KPIkoX7
        ChaYocHJqiX5rUpr93oZdeUcIRKj1/89PiyfG2aNSVGOmLpxmZiWZ6WmMXXtjKbH3vD4is
        r8ymLnghpL8QCkhILdjWGg8bMvPBEWA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-k-9nlxzuNQGkUm3J8CW-zQ-1; Tue, 24 Aug 2021 10:24:06 -0400
X-MC-Unique: k-9nlxzuNQGkUm3J8CW-zQ-1
Received: by mail-qv1-f72.google.com with SMTP id m10-20020a056214158ab029035a6c1e5f3eso14921659qvw.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rXM+IBI3cANg1BoBFaXjt+OJ0V+p5mrya6klP9WdYlA=;
        b=VPYtMBwSaaapW/pZhpgJ9oxxYKYJqrYZpU79hOwhVZ7QOBfs+6ECFyvfMAQCzhZPzV
         wW0gGp+4okWnuZQI9SUI9lPvdCqxylXzG/bCy3F1+1ZhvplqNOkWPt0DrxrToHJ4wyLG
         bE3PUQO7C04nNEtYGBncgAclqFKgL+km7hkmlR/MQIZgaRljFpeubxal5kPzSfAPua38
         3cJCp5A2ktQ/23JanyZvclT7Xhk9ip+2Q9PrmsXiu0SCU/Cbw4x1xkqKninMqhKB+nhK
         SPlNMDQnaRbFBi0+MTMsgXTRN1tX5T40r5xY6O8zGBXMp9vuqgGqUovZSR6ph1d9DaRA
         G5qA==
X-Gm-Message-State: AOAM530RBuBrP2L9kmvQLywiDCIOa9OhwWa47pF6rvOjoo4j7HP7XqGE
        81ispLYUjKIFabKMiV6ndyrhHTduhrR1xLKlihtTYDkAW/1IDRl/hrCl1nG0HkQlZK1hLbYv3U1
        H68CBC4LRob6Y5cwcyrjbuXfi
X-Received: by 2002:ae9:ea19:: with SMTP id f25mr8455956qkg.341.1629815045910;
        Tue, 24 Aug 2021 07:24:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0k36wj5zNWxDPPKfaTblHo9ascSv6RZDAgZIszilZOADFHpaoZorFodsGnWRqf0RVmvNYxA==
X-Received: by 2002:ae9:ea19:: with SMTP id f25mr8455927qkg.341.1629815045702;
        Tue, 24 Aug 2021 07:24:05 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id f29sm273492qtv.34.2021.08.24.07.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:24:05 -0700 (PDT)
Message-ID: <6370d0a74c3ceb79c53305a64ba7a982d16d34b4.camel@redhat.com>
Subject: Re: [PATCH 11/12] fscache: Fix fscache_cookie_put() to not deref
 after dec
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 Aug 2021 10:24:04 -0400
In-Reply-To: <162431203107.2908479.3259582550347000088.stgit@warthog.procyon.org.uk>
References: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
         <162431203107.2908479.3259582550347000088.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-06-21 at 22:47 +0100, David Howells wrote:
> fscache_cookie_put() accesses the cookie it has just put inside the
> tracepoint that monitors the change - but this is something it's not
> allowed to do if we didn't reduce the count to zero.

Do you mean "if the count went to zero." ?

> 
> Fix this by dropping most of those values from the tracepoint and grabbing
> the cookie debug ID before doing the dec.
> 
> Also take the opportunity to switch over the usage and where arguments on
> the tracepoint to put the reason last.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/fscache/cookie.c            |   10 ++++++----
>  fs/fscache/internal.h          |    2 +-
>  fs/fscache/netfs.c             |    2 +-
>  include/trace/events/fscache.h |   24 +++++++-----------------
>  4 files changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
> index 2558814193e9..6df3732cf1b4 100644
> --- a/fs/fscache/cookie.c
> +++ b/fs/fscache/cookie.c
> @@ -225,8 +225,8 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
>  
>  collision:
>  	if (test_and_set_bit(FSCACHE_COOKIE_ACQUIRED, &cursor->flags)) {
> -		trace_fscache_cookie(cursor, fscache_cookie_collision,
> -				     atomic_read(&cursor->usage));
> +		trace_fscache_cookie(cursor->debug_id, atomic_read(&cursor->usage),
> +				     fscache_cookie_collision);
>  		pr_err("Duplicate cookie detected\n");
>  		fscache_print_cookie(cursor, 'O');
>  		fscache_print_cookie(candidate, 'N');
> @@ -305,7 +305,8 @@ struct fscache_cookie *__fscache_acquire_cookie(
>  
>  	cookie = fscache_hash_cookie(candidate);
>  	if (!cookie) {
> -		trace_fscache_cookie(candidate, fscache_cookie_discard, 1);
> +		trace_fscache_cookie(candidate->debug_id, 1,
> +				     fscache_cookie_discard);
>  		goto out;
>  	}
>  
> @@ -866,8 +867,9 @@ void fscache_cookie_put(struct fscache_cookie *cookie,
>  	_enter("%x", cookie->debug_id);
>  
>  	do {
> +		unsigned int cookie_debug_id = cookie->debug_id;
>  		usage = atomic_dec_return(&cookie->usage);
> -		trace_fscache_cookie(cookie, where, usage);
> +		trace_fscache_cookie(cookie_debug_id, usage, where);
>  
>  		if (usage > 0)
>  			return;
> diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
> index a49136c63e4b..345105dbbfd1 100644
> --- a/fs/fscache/internal.h
> +++ b/fs/fscache/internal.h
> @@ -291,7 +291,7 @@ static inline void fscache_cookie_get(struct fscache_cookie *cookie,
>  {
>  	int usage = atomic_inc_return(&cookie->usage);
>  
> -	trace_fscache_cookie(cookie, where, usage);
> +	trace_fscache_cookie(cookie->debug_id, usage, where);
>  }
>  
>  /*
> diff --git a/fs/fscache/netfs.c b/fs/fscache/netfs.c
> index cce92216fa28..d6bdb7b5e723 100644
> --- a/fs/fscache/netfs.c
> +++ b/fs/fscache/netfs.c
> @@ -37,7 +37,7 @@ int __fscache_register_netfs(struct fscache_netfs *netfs)
>  	if (!cookie)
>  		goto already_registered;
>  	if (cookie != candidate) {
> -		trace_fscache_cookie(candidate, fscache_cookie_discard, 1);
> +		trace_fscache_cookie(candidate->debug_id, 1, fscache_cookie_discard);
>  		fscache_free_cookie(candidate);
>  	}
>  
> diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
> index 0b9e058aba4d..55b8802740fa 100644
> --- a/include/trace/events/fscache.h
> +++ b/include/trace/events/fscache.h
> @@ -160,37 +160,27 @@ fscache_cookie_traces;
>  
>  
>  TRACE_EVENT(fscache_cookie,
> -	    TP_PROTO(struct fscache_cookie *cookie,
> -		     enum fscache_cookie_trace where,
> -		     int usage),
> +	    TP_PROTO(unsigned int cookie_debug_id,
> +		     int usage,
> +		     enum fscache_cookie_trace where),
>  
> -	    TP_ARGS(cookie, where, usage),
> +	    TP_ARGS(cookie_debug_id, usage, where),
>  
>  	    TP_STRUCT__entry(
>  		    __field(unsigned int,		cookie		)
> -		    __field(unsigned int,		parent		)
>  		    __field(enum fscache_cookie_trace,	where		)
>  		    __field(int,			usage		)
> -		    __field(int,			n_children	)
> -		    __field(int,			n_active	)
> -		    __field(u8,				flags		)
>  			     ),
>  
>  	    TP_fast_assign(
> -		    __entry->cookie	= cookie->debug_id;
> -		    __entry->parent	= cookie->parent ? cookie->parent->debug_id : 0;
> +		    __entry->cookie	= cookie_debug_id;
>  		    __entry->where	= where;
>  		    __entry->usage	= usage;
> -		    __entry->n_children	= atomic_read(&cookie->n_children);
> -		    __entry->n_active	= atomic_read(&cookie->n_active);
> -		    __entry->flags	= cookie->flags;
>  			   ),
>  
> -	    TP_printk("%s c=%08x u=%d p=%08x Nc=%d Na=%d f=%02x",
> +	    TP_printk("%s c=%08x u=%d",
>  		      __print_symbolic(__entry->where, fscache_cookie_traces),
> -		      __entry->cookie, __entry->usage,
> -		      __entry->parent, __entry->n_children, __entry->n_active,
> -		      __entry->flags)
> +		      __entry->cookie, __entry->usage)
>  	    );
>  
>  TRACE_EVENT(fscache_netfs,
> 
> 

Patch itself looks fine though.
-- 
Jeff Layton <jlayton@redhat.com>

