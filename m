Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099E7423654
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 05:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhJFDi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 23:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhJFDiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 23:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633491391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ocTbFKq103vOIaZqsII4pq9sEvQMfjZwJU9h1aYvFtM=;
        b=fJW5ww9STcVBlZRftf8PfkFbyFd9sRK5r8oZ7J3RCtWMM1GaNLBLLrqbzezf50KR4yngM7
        Q8kBe++6ds+3eC/xwIaUaM4kQD5/OvqHWmas2Qne2VYGrqPsKNlvIpsWze2PILk0bGW0h4
        KGf8Iz4JrvF6/QfH5NEB9HezH3bkqGs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-Je0DzTgyOgW6w9YysUlH5w-1; Tue, 05 Oct 2021 23:36:29 -0400
X-MC-Unique: Je0DzTgyOgW6w9YysUlH5w-1
Received: by mail-ot1-f72.google.com with SMTP id k21-20020a9d7015000000b0054d5b451decso802496otj.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 20:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ocTbFKq103vOIaZqsII4pq9sEvQMfjZwJU9h1aYvFtM=;
        b=bvX5WCqyq3Sn3MYJEviQqT3waLSwqf2Y5Lghcj29Ii7zmbBTQYv6Mor2NIpNVwp0iu
         WoHL+6Y10s0B9oAnujLGOb/XKuUDbtewZa+NCrUHIadCbw+w2hqYkPDXIAkBGys8OghA
         H6GQPtSsvnbduRSIDJQAO/XTHnHNaZyBphtOg42y8xtWTP5OjWp57I6IiGt1hxOIWRIu
         B7hYz85wk23cVkmBtmfKkzUYgzQO3Vlr5+hcAt1e26AV9U9UU8YcAMj+wUorp0a1fupB
         JxjdvcX5n6IPKweGTLKmFaFDrUvVUvdXWtTngeNsYVH6n5LmbotboQcHKXMJSBwAnEBs
         WBvg==
X-Gm-Message-State: AOAM533kGR5WjwnS5YfWLlkC2WzstGpVhLKtbkCaQFFJtkEc7JcoFEQ1
        fz0XOtbPDErxm/erh0YxvztATx2LBTWVZSi6ezWDh5hdxQqpowKYSQzUXs32yryD6aUl6VcJM3Y
        ui6JII2mqV53U6DwllucikqE3
X-Received: by 2002:a9d:6f9a:: with SMTP id h26mr17536537otq.140.1633491389170;
        Tue, 05 Oct 2021 20:36:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKxtRBnxeTiOX8KiHZzT+dQc7fjHh0uxJjbeVdjRDFW+QbyWzR8kELBvGkFwZ2NPtqHJm7Ag==
X-Received: by 2002:a9d:6f9a:: with SMTP id h26mr17536525otq.140.1633491389011;
        Tue, 05 Oct 2021 20:36:29 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id o8sm4008393otk.76.2021.10.05.20.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:36:28 -0700 (PDT)
Date:   Tue, 5 Oct 2021 20:36:26 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 01/15] objtool: Add CONFIG_CFI_CLANG support
Message-ID: <20211006033626.hfjke5jrvvzxhc67@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930180531.1190642-2-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05:17AM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function references with
> references to the CFI jump table, which confuses objtool. This change,
> based on Josh's initial patch [1], goes through the list of relocations
> and replaces jump table symbols with the actual function symbols.
> 
> [1] https://lore.kernel.org/r/d743f4b36e120c06506567a9f87a062ae03da47f.1611263462.git.jpoimboe@redhat.com/

I found the original patch description to be much more useful than this
one ;-)

-- 
Josh

