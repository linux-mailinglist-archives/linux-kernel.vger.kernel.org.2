Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811803420AF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCSPQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230084AbhCSPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616166950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lHgUqg7lUeprSxrO1km+5FvJKGhOk0xBGuEus+eOkRg=;
        b=HgDpAEWQGOiZQyvg33cq9YmzJtDG+edNXv2xfUcD0HahjEspN5wuNr34drRjr+3jVn+LOq
        WaVVB6af/3BZoTpWb5Qlk12X9J7Hc3FEB61n1lqjbpwij1ILZjH1fTErAq7YDWuG9IqPvz
        jMQdm40Y7/GN+brAtbjYdtUXpcTBZQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-3D0R7IGDO5-6v6Y-GX71rA-1; Fri, 19 Mar 2021 11:15:48 -0400
X-MC-Unique: 3D0R7IGDO5-6v6Y-GX71rA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 381641922962;
        Fri, 19 Mar 2021 15:15:47 +0000 (UTC)
Received: from treble (ovpn-119-18.rdu2.redhat.com [10.10.119.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 830A950DD2;
        Fri, 19 Mar 2021 15:15:45 +0000 (UTC)
Date:   Fri, 19 Mar 2021 10:15:42 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suze.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] objtool: Rework rebuild_reloc logic
Message-ID: <20210319151542.hju53tpeuqdiyf3g@treble>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.649709484@infradead.org>
 <20210317033417.lbwemc2j2cpsdlzd@treble>
 <YFG53wkgw6nDBgIl@hirez.programming.kicks-ass.net>
 <20210318004917.sytcivxy5h2ujttc@treble>
 <YFNOH1m+FrFK8TRN@hirez.programming.kicks-ass.net>
 <20210318163640.5u6rucdk66aodun7@treble>
 <YFOIGYblhHTqp/fa@hirez.programming.kicks-ass.net>
 <20210318173842.55rwasdbqlfx7a2i@treble>
 <YFRtbkM9jA9iCWQm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFRtbkM9jA9iCWQm@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:22:54AM +0100, Peter Zijlstra wrote:
> @@ -814,6 +814,11 @@ struct section *elf_create_reloc_section
>  	}
>  }
>  
> +static inline bool is_reloc_section(struct section *reloc)
> +{
> +	return reloc->base && reloc->base->reloc == reloc;
> +}

I believe the 2nd condition will always be true, so it can just be
'return reloc->base'.

-- 
Josh

