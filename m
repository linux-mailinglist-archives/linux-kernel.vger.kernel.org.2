Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7826545CB75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349972AbhKXR4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:56:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349945AbhKXR4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637776389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mASyT0OMl03qWDFFy00mhqeWIkZHCHpjVkFxkJ6erhk=;
        b=gqtDLTFmO0qgymnX+dm+kwESu4jensgURt4UVaSaw6rNLuzM/MGEnbMaWizNFWTrMMXJ/Y
        Hud6oaQwHEqv3Q2iol9JDYalR4ly5CoFzjH/EBlOEi5pklRNeLV1+/qJI68EudEOEtBR85
        g/u1NQdFXLXYrVsUklT4G6pcjzYWE5o=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-AL0fKwUwMiKBi3ddom-Rxw-1; Wed, 24 Nov 2021 12:53:08 -0500
X-MC-Unique: AL0fKwUwMiKBi3ddom-Rxw-1
Received: by mail-oi1-f198.google.com with SMTP id y21-20020aca4b15000000b002a819a3cd6dso1978810oia.15
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 09:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mASyT0OMl03qWDFFy00mhqeWIkZHCHpjVkFxkJ6erhk=;
        b=FN4akHzGVc239C+cXjkK+5IoQ6jISvIKqBA4PS2SOzNDui1Eu7eM5skVVZd9g3ZJof
         od+ywKAILGEZhe30yOeSMQ6NAh1KsR7OUcTyURg1g/QPFRkgpLRIScRZHuazo6DqqwlK
         3XRD01UQeti+5nI7Jm40fCS7Qjr3wl1ELbt5peReanRjKReNMt+bm/SmXyByyh0bvwVs
         mfktl/jJKGqZUDiOBJcZOMXiTVfRKRs4drRO7WQ17dPyeW1aBoTtuxxDUEyOdyooXkho
         IaUMENhxUlGOYGfhW2H2hMyWX1kC1LSeUBARPE0qULMgSWiF/UBgoi02j4J7YN5BHozP
         7HZw==
X-Gm-Message-State: AOAM533XGLI7dnv/YHVKKMu0Cnx1OuDGUmqjAZ8F418Syjp2PvAzXeBw
        Cv8mtYdOMNDGK/bf+m6yxeJAA2fIeIOWlgqVz9QG891hoEdoI6yj0fUIjJNqo4h2i4dLPIBUuHf
        CIa2q35UugCH67SITkygmc7uZ
X-Received: by 2002:a54:4f1d:: with SMTP id e29mr8178810oiy.179.1637776387520;
        Wed, 24 Nov 2021 09:53:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRWB6L5DthV9JqtypnlgpgoikvWzzaSh5YU1GEzYTaFfOEcTtDdkodALrrMwzR5kHOWImEJg==
X-Received: by 2002:a54:4f1d:: with SMTP id e29mr8178778oiy.179.1637776387316;
        Wed, 24 Nov 2021 09:53:07 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id bj8sm123395oib.51.2021.11.24.09.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 09:53:06 -0800 (PST)
Date:   Wed, 24 Nov 2021 09:53:03 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 23/23] objtool, kcsan: Remove memory barrier
 instrumentation from noinstr
Message-ID: <20211124175303.nwuk2zlnwkr7fj5f@treble>
References: <20211118081027.3175699-1-elver@google.com>
 <20211118081027.3175699-24-elver@google.com>
 <20211119203135.clplwzh3hyo5xddg@treble>
 <YZzQoz0e/oiutuq5@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZzQoz0e/oiutuq5@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:29:39PM +0100, Marco Elver wrote:
> On Fri, Nov 19, 2021 at 12:31PM -0800, Josh Poimboeuf wrote:
> > On Thu, Nov 18, 2021 at 09:10:27AM +0100, Marco Elver wrote:
> [...]
> > > +	if (insn->sec->noinstr && sym->removable_instr) {
> [...]
> > I'd love to have a clearer name than 'removable_instr', though I'm
> > having trouble coming up with something.
> [...]
> 
> I now have the below as v3 of this patch. The naming isn't entirely
> obvious, but coming up with a short name for this is tricky, but
> hopefully the comments make it clear. We can of course still pick
> another name.
> 
> Does that look reasonable?
> 
> Note, I'd like this series to sit in -next for a while (probably from
> some time next week after sending v3 if there are no further
> complaints). By default everything will be picked up by the -rcu tree,
> and we're targeting Linux 5.18.
> 
> If you feel there might be objtool conflicts coming, this patch could be
> taken through another tree as there are no hard dependencies, as long as
> this patch reaches mainline before or with the rest.
> 
> Thanks,
> -- Marco

Looks good to me.  I don't know of any upcoming conflicts, feel free to
carry it with your series for now.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

