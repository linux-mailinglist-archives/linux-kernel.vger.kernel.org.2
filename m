Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7641039809E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 07:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFBFY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 01:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhFBFY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 01:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622611394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l55W7bIxW0wl/QN0OmeznpSfL2au6N3qY2w60LTECMg=;
        b=S7wIufhfT7kV8HHdMySxKs71f2e6MgM3KQSO9K6Au8AnDp3Lga3CchcWr8jwU4hYz36M9I
        tIO02vjLOeTIjkittDPIQLD9fY5nGC8bOpfbx9S2dBOUa/Tv4vsuEZOCbQdHsyQAKvr/iJ
        3FH9GMsQYjn1tIHnroaJYCaF1fUTuJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-DMDq7yAXNEaGgu7A-4GjhQ-1; Wed, 02 Jun 2021 01:23:10 -0400
X-MC-Unique: DMDq7yAXNEaGgu7A-4GjhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A9BB501E5;
        Wed,  2 Jun 2021 05:23:09 +0000 (UTC)
Received: from localhost (ovpn-13-33.pek2.redhat.com [10.72.13.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA75F6A03A;
        Wed,  2 Jun 2021 05:23:01 +0000 (UTC)
Date:   Wed, 2 Jun 2021 13:22:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= 
        <k-hagio-ab@nec.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH V2 4/6] mm: rename the global section array to
 mem_sections
Message-ID: <20210602052259.GB409140@MiWiFi-R3L-srv>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-5-aisheng.dong@nxp.com>
 <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
 <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
 <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
 <20210601165246.99d7374d07661b7e91e49cb6@linux-foundation.org>
 <TYYPR01MB67775E2EC60DEE1195A49577DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <20210602030353.GA409140@MiWiFi-R3L-srv>
 <TYYPR01MB67770ED42E65667E304F2FF9DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYYPR01MB67770ED42E65667E304F2FF9DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/21 at 05:02am, HAGIO KAZUHITO(萩尾 一仁) wrote:
> -----Original Message-----
> > On 06/02/21 at 01:11am, HAGIO KAZUHITO(萩尾 一仁) wrote:
> > > -----Original Message-----
> > > > On Tue, 1 Jun 2021 10:40:09 +0200 David Hildenbrand <david@redhat.com> wrote:
> > > >
> > > > > > Thanks, i explained the reason during my last reply.
> > > > > > Andrew has already picked this patch to -mm tree.
> > > > >
> > > > > Just because it's in Andrews tree doesn't mean it will end up upstream. ;)
> > > > >
> > > > > Anyhow, no really strong opinion, it's simply unnecessary code churn
> > > > > that makes bisecting harder without real value IMHO.
> > > >
> > > > I think it's a good change - mem_sections refers to multiple instances
> > > > of a mem_section.  Churn is a pain, but that's the price we pay for more
> > > > readable code.  And for having screwed it up originally ;)
> > >
> > > From a makedumpfile/crash-utility viewpoint, I don't deny kernel improvement
> > > and probably the change will not be hard for them to support, but I'd like
> > > you to remember that the tool users will need to update them for the change.
> > 
> > As VIM user, I can understand Aisheng's feeling on the mem_section
> > variable which has the same symbol name as its type. Meanwhile it does
> > cause makedumpfile/crash having to be changed accordingly.
> > 
> > Maybe we can carry it when any essential change is needed in both kernel
> > and makedumpfile/crash around it.
> 
> Yes, that is a possible option.
> 
> > 
> > >
> > > The situation where we need to update the tools for new kernels is usual, but
> > > there are not many cases that they cannot even start session, and this change
> > 
> > By the way, Kazu, about a case starting session, could you be more specific
> > or rephrase? I may not get it clearly. Thanks.
> 
> As for the current crash, the "mem_section" symbol is used to determine
> which memory model is used.
> 
>         if (kernel_symbol_exists("mem_section"))
>                 vt->flags |= SPARSEMEM;
>         else if (kernel_symbol_exists("mem_map")) {
>                 get_symbol_data("mem_map", sizeof(char *), &vt->mem_map);
>                 vt->flags |= FLATMEM;
>         } else
>                 vt->flags |= DISCONTIGMEM;
> 
> So without updating, crash will assume that the memory model is DISCONTIGMEM,
> fail during vm_init() and cannot start a session.  This is an imitation of
> the situation though:
> 
> -       if (kernel_symbol_exists("mem_section"))
> +       if (kernel_symbol_exists("mem_sectionX"))
> 
> # crash
> ...
> crash: invalid structure member offset: pglist_data_node_mem_map
>            FILE: memory.c  LINE: 16420  FUNCTION: dump_memory_nodes()
> 
> [/root/bin/crash] error trace: 465304 => 4ac2bf => 4aae19 => 57f4d7
> 
>   57f4d7: OFFSET_verify+164
>   4aae19: dump_memory_nodes+5321
>   4ac2bf: vm_init+4031
>   465304: main_loop+392
> 
> #
> 
> Every time a kernel is released, there are some changes that crash can
> start up with but cannot run a specific crash's command, but a change
> that crash cannot start up like this case does not occur often.

Ah,I see. You mean this patch will cause startup failure of crash/makedumpfile
during application's earlier stage, and this is a severer situation than
others. Then we may need defer the patch acceptance to a future suitable
time. Thanks for explanation.

> 
> Also as for makedumpfile, the "SYMBOL(mem_section)" vmcore entry is used
> to determine the memory model, so it will fail with the following error
> without an update.
> 
> # ./makedumpfile --mem-usage /proc/kcore 
> get_mem_map: Can't distinguish the memory type.
> 
> makedumpfile Failed.
> 
> Thanks,
> Kazu

