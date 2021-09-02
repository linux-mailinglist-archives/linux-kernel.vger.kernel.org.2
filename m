Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4073FF1AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346432AbhIBQla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346448AbhIBQl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:41:27 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3531DC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:40:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 8so2559858pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j/QFpIwVpnWHaDYhXpnYGfEufg38ONfVKj0utdXFYrE=;
        b=cO8MvTjt4ahIeaQT++QeHOxEjuxb4vhu+5nhUb+3UqskIA5/KzG1Y4ew3P50DH/FJa
         NFnzfHm43h85a/tpR7za4bWzSiMvBtCEeTcxBUzd70h1YgpEMhayj/aQYlZCHJYAAu9A
         6cCs6Lc9hoD+l8TSxhM9BEyRtYbluqc7SXllIn+oGYjyIJ6sjwV9/L0Vuibax/IwFhhJ
         2bkWzlidprGak3I8fajgJ+rshi2H8AvxP+0PxkAqARA0AKzqzSmv/bH3pIhHguOT85Jh
         xYn85EobHuhEA7tKbEU++vjxQNN8Itz3JMXCjJsCgWLG0gBy47+/rX5ERVlIUgh6uPnT
         zuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j/QFpIwVpnWHaDYhXpnYGfEufg38ONfVKj0utdXFYrE=;
        b=hf3YuwyfwZwTRs0/CEWR53obcsSGIIx8jUnvZgv/H1rRIdGtkCj3zeWsiZ3xr6S+yY
         tg4sPZZowvQtHYdBOjMCDTmTz8xAyy5jfV7UJdxG32Q//UEUcRJcHbhKmIlEWxr7bUNV
         f+DV17zUXTIR7bg87UdS6EfMeSyHSFENhLzQEb3WmQ+xZHCuneuOmk5t0VoDAxA/Fok6
         Ws+veHNDKr5ul40QtE0ooXP3xGR68mkl4n0zWWUl+rXqbLmnLXbRp6kiezWrXvgDQpL6
         AKr+2z0WtF+/Z8/YtWDHxR4u1A1c0ALjccrd7hVlQ3sttUO6s+8299SkfWZKN4wIQ/eO
         K3FQ==
X-Gm-Message-State: AOAM532ol3x1W4ma82y7Ya8dS/nsmQhFILrlbE/bp5O5+jpvg394lHmM
        mvW3mvoBMvAVZ4ZsrS2vqitbJA==
X-Google-Smtp-Source: ABdhPJw1aIXjCFXU5zBhNxENfGz2Eto823JxV39HrLV/YNU7hZHSwdn8d7TGr2WuRNFnPCDO3Zugjw==
X-Received: by 2002:aa7:9e4d:0:b0:3f8:6326:a038 with SMTP id z13-20020aa79e4d000000b003f86326a038mr4283516pfq.73.1630600828542;
        Thu, 02 Sep 2021 09:40:28 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q12sm2839726pfj.153.2021.09.02.09.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:40:28 -0700 (PDT)
Date:   Thu, 2 Sep 2021 16:40:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] KVM: Drop unused kvm_dirty_gfn_harvested()
Message-ID: <YTD+eBj+9+mb9LVg@google.com>
References: <20210901230506.13362-1-peterx@redhat.com>
 <87y28flyxj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y28flyxj.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021, Vitaly Kuznetsov wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Drop the unused function as reported by test bot.
> 
> Your subject line says "Drop unused kvm_dirty_gfn_harvested()" while in
> reallity you drop "kvm_dirty_gfn_invalid()".

Heh, Peter already sent v2[*].  Though that's a good reminder that it's helpful
to reviewers to respond to your own patch if there's a fatal mistake and you're
going to immediately post a new version.  For tiny patches it's not a big deal,
but for larger patches it can avoid wasting reviewers' time.

https://lkml.kernel.org/r/20210901230904.15164-1-peterx@redhat.com
