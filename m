Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5825D372AE7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhEDNZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231144AbhEDNZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620134693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IxWQcmXS2jOkHYwAt2gj66bGdjzbjRHMf4MKM8nnh4g=;
        b=iEaatpHoENdx9l2wEsfc1GQVO0n5IOQAEIdkkJvsVlLtvgU0Llj8tNkLPQ43IvrOrNgU28
        qjCXc48As/h64AxBPM4x6j3sJ3+Grd+aKae+oIYkk7rR7BreZiqd8Ej6k9TMBVIWD1pvbJ
        FVPxGO9Gi/LNQv7m9XOGb2eZkLIFJ6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-3pj-KjMFPT-HYHOAtZsW5A-1; Tue, 04 May 2021 09:24:52 -0400
X-MC-Unique: 3pj-KjMFPT-HYHOAtZsW5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5FEA107ACE3;
        Tue,  4 May 2021 13:24:50 +0000 (UTC)
Received: from treble (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with SMTP id BF35D2C01B;
        Tue,  4 May 2021 13:24:49 +0000 (UTC)
Date:   Tue, 4 May 2021 08:24:49 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: Re: Do we need to do anything about "dead =?utf-8?B?wrVvcHM/Ig==?=
Message-ID: <20210504132449.wmvxtubhuzuqc3xr@treble>
References: <CALCETrXRvhqw0fibE6qom3sDJ+nOa_aEJQeuAjPofh=8h1Cujg@mail.gmail.com>
 <20210503233010.x5lzpw4dq3gueg47@treble>
 <CALCETrVwFrpZU-6C=AVurVPk4ahV2yjqyhFeYbL_0OtBNJnZ=w@mail.gmail.com>
 <20210504031616.covixup7rhdil3yq@treble>
 <5937e5a2f1014e2da4a07e249745ceb1@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5937e5a2f1014e2da4a07e249745ceb1@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 01:06:06PM +0000, David Laight wrote:
> From: Josh Poimboeuf
> > Sent: 04 May 2021 04:16
> ...
> > I was actually thinking more along the lines of
> > 
> > 	val = 0;
> > 
> > 	if (user_supplied_idx < ARRAY_SIZE) // trained to speculatively be 'true'
> > 		val = boring_non_secret_array[user_supplied_idx];
> > 
> > 	if (val & 1)
> > 		do_something();
> > 
> > In other words, the victim code wouldn't be accessing the secret
> > intentionally.  So there's no reason for it to avoid doing
> > data-dependent branches.
> 
> Isn't that one of the very boring standard spectre cases?

Classic v1 as described in the Spectre paper was a data-dependent
load/store, not a data-dependent branch.

-- 
Josh

