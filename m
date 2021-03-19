Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D32341324
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 03:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhCSCic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 22:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231617AbhCSCiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616121501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mm4yROJ0PR6J2D7djo4xxogQis3b4F34O1+KqveJZiE=;
        b=azs29f21x/QUc0FM/j6pJ8HrxfOAhoV+Q2olnsUG5nvq8kA/GZEccr/BmGlosFNwYVDBbx
        P91QsLSIrAHyMnY6YJaqJDmIUeWEB79xnDQBzCoG+EZpsmNNeMKK+ML/pVlOFN3Pp7csyQ
        EBJ+wUnX5MB10TKFEg+RqJtJv7BiDS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-G9OmIH8-MGegOnjvKU9gJw-1; Thu, 18 Mar 2021 22:38:19 -0400
X-MC-Unique: G9OmIH8-MGegOnjvKU9gJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 439191009478;
        Fri, 19 Mar 2021 02:38:18 +0000 (UTC)
Received: from treble (ovpn-113-46.rdu2.redhat.com [10.10.113.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E620219D9F;
        Fri, 19 Mar 2021 02:38:16 +0000 (UTC)
Date:   Thu, 18 Mar 2021 21:38:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/14] objtool: Per arch retpoline naming
Message-ID: <20210319023814.ovisg53uc5zy7gwn@treble>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.703716384@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318171919.703716384@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:11:08PM +0100, Peter Zijlstra wrote:
> @@ -872,7 +877,7 @@ static int add_jump_destinations(struct
>  		} else if (reloc->sym->type == STT_SECTION) {
>  			dest_sec = reloc->sym->sec;
>  			dest_off = arch_dest_reloc_offset(reloc->addend);
> -		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
> +		} else if (arch_is_retpoline(reloc->sym)) {
>  			/*
>  			 * Retpoline jumps are really dynamic jumps in
>  			 * disguise, so convert them accordingly.

There's another one in add_call_destinations().

-- 
Josh

