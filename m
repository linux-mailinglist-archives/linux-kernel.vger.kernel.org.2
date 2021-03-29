Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F17934D540
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhC2QjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhC2Qij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617035918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MTmpotKO9nQgIN5ZjXhj4X36rPku8Dx7D0Tu3VxJP8E=;
        b=ahSYwZ3599qPJSUq/Gf4GBqKD+gY8w7Kw7khn4sYEDsnS12sPYDl5TX8OWcvUATfTfe/BZ
        nj4HRV4MFtd8jQPqNCuyRiDmdvKx4g7ioKOfimUOwQNMc74DMg7ij9TsyD2E211xoKuq8v
        UkO/CMAWfxZSlff0zbPFVJSkOGQJTUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-g7Oo5IVlOKuZbqTu5AvQsA-1; Mon, 29 Mar 2021 12:38:34 -0400
X-MC-Unique: g7Oo5IVlOKuZbqTu5AvQsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 965F41927800;
        Mon, 29 Mar 2021 16:38:32 +0000 (UTC)
Received: from treble (ovpn-120-130.rdu2.redhat.com [10.10.120.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EF685D6A8;
        Mon, 29 Mar 2021 16:38:30 +0000 (UTC)
Date:   Mon, 29 Mar 2021 11:38:26 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210329163826.anuqkv5ahvoyus5c@treble>
References: <20210326151159.128534163@infradead.org>
 <20210326151300.320177914@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210326151300.320177914@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 04:12:15PM +0100, Peter Zijlstra wrote:
> @@ -61,3 +89,15 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
>  #define GEN(reg) EXPORT_THUNK(reg)
>  #include <asm/GEN-for-each-reg.h>
>  
> +#undef GEN
> +#define GEN(reg) ALT_THUNK reg
> +#include <asm/GEN-for-each-reg.h>
> +
> +#undef GEN
> +#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_call_ ## reg)
> +#include <asm/GEN-for-each-reg.h>
> +
> +#undef GEN
> +#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_jmp_ ## reg)
> +#include <asm/GEN-for-each-reg.h>
> +

Git complains about this last newline.

Otherwise everything looks pretty good to me.  Let me run it through the
test matrix.

-- 
Josh

