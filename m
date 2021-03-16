Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CB233E060
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 22:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhCPVUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 17:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41381 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231774AbhCPVTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 17:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615929569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=brlghSipitYu3IKDgUAwzfzF2+NYRCH8ZO+8AVk5xg4=;
        b=MNDDjxRJuSdUK4+0p1z2BI/tdlOQF+ROOyTC6Qb9exHBpVwrKkAc/jY5ehjIA/TXgViICz
        G3v0l8G9gYFawqzhdoBd0M5K3VYe/6FPhYIJH/ckTeZQMNyCGcIpfZjd31PwXJ5p8whWun
        IgymQ8EiD5jOasZJtd56GZ1teoZXD8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-2wJ6AMF6P_KvFe_-NOGSGQ-1; Tue, 16 Mar 2021 17:19:27 -0400
X-MC-Unique: 2wJ6AMF6P_KvFe_-NOGSGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E41983DD27;
        Tue, 16 Mar 2021 21:19:26 +0000 (UTC)
Received: from treble (ovpn-118-162.rdu2.redhat.com [10.10.118.162])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA50C19702;
        Tue, 16 Mar 2021 21:19:24 +0000 (UTC)
Date:   Tue, 16 Mar 2021 16:19:21 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suze.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] objtool: Correctly handle retpoline thunk calls
Message-ID: <20210316211921.r7qsuueudilmlmce@treble>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.466281089@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210312171653.466281089@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 06:16:15PM +0100, Peter Zijlstra wrote:
> Just like JMP handling, convert a direct CALL to a retpoline thunk
> into a retpoline safe indirect CALL.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/check.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -953,6 +953,18 @@ static int add_call_destinations(struct
>  					  dest_off);
>  				return -1;
>  			}
> +
> +		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
> +			/*
> +			 * Retpoline calls are really dynamic calls in
> +			 * disguise, so convert them accodingly.

s/accodingly/accordingly/

-- 
Josh

