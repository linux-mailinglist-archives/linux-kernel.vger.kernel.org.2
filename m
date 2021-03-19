Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D929B3420A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCSPNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:13:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230196AbhCSPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616166791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wF/vSykJXx8DwVzw9Oq7XaE26+9pvmSLZD0qoccn7m0=;
        b=K2vaIMUCHgaGiYtLF2bsU1xT12xNEC8rni8jfEmaVRjJoXtgpQXPLhocanGHPkHPc2TJrn
        5aiLt2hxBXUmN5mcbSj/h0TMlsuoaQ49nYpyDE41WWkjjmgmQsTJPqdcSJ/FW7aKKgTQEe
        BuEd8XO8PnKZ2Cw0jnSdeikjAxfzPek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-4Xy5UHB0P5ODcf_8bUmtFg-1; Fri, 19 Mar 2021 11:13:05 -0400
X-MC-Unique: 4Xy5UHB0P5ODcf_8bUmtFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B43F100A63F;
        Fri, 19 Mar 2021 15:13:04 +0000 (UTC)
Received: from treble (ovpn-119-18.rdu2.redhat.com [10.10.119.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF98C610F3;
        Fri, 19 Mar 2021 15:13:02 +0000 (UTC)
Date:   Fri, 19 Mar 2021 10:12:59 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] objtool: Add elf_create_reloc() helper
Message-ID: <20210319151259.6ddhamrh42wbvxav@treble>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.887152166@infradead.org>
 <20210319014246.c6trc4x3qewro32c@treble>
 <YFRzOFp5/pHaLDti@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFRzOFp5/pHaLDti@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:47:36AM +0100, Peter Zijlstra wrote:
> Full patch, because diff on a diff on a diff is getting ludicrous hard
> to read :-)

Appreciated :-)

> -void elf_add_reloc(struct elf *elf, struct reloc *reloc)
> +int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
> +		  unsigned int type, struct symbol *sym, int addend)
>  {
> -	struct section *sec = reloc->sec;
> +	struct reloc *reloc;
> +
> +	reloc = malloc(sizeof(*reloc));
> +	if (!reloc) {
> +		perror("malloc");
> +		return -1;
> +	}
> +	memset(reloc, 0, sizeof(*reloc));
> +
> +	reloc->sec = sec->reloc;

Maybe elf_add_reloc() could create the reloc section if it doesn't
already exist, that would help remove the multiple calls to
elf_create_reloc_section().

> +	reloc->offset = offset;
> +	reloc->type = type;
> +	reloc->sym = sym;
> +	reloc->addend = addend;
>  
>  	list_add_tail(&reloc->list, &sec->reloc_list);

This should be sec->reloc->reloc_list?

-- 
Josh

