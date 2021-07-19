Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877C43CED92
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385756AbhGSTJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385115AbhGSSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:46:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16889C0613DB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:17:57 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e20so27882953ljn.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1xCs+r00YlYYmkHhfeZ23WXN1acy6oHwi3mHUNeu3k=;
        b=aFdE74ZCG+BN+jiHq4q1lakSvG+rshYWLQZu1zIoypmQmrrNlzKoxh85yXW+3m2PBp
         lDcp1W5D+wukHZK8WVSqNumwcBVKDXX9keNjOt5GV8kossCG36AANwW2SGQ9nLrOLQca
         gBbpXK2AsQp6Mwz9UbDIXY2bN8t0evot7E9EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1xCs+r00YlYYmkHhfeZ23WXN1acy6oHwi3mHUNeu3k=;
        b=CZlKFtkHt3bdSBvLl9rwvff4r9b5S7N3V7FynqKZeUO/nSVGjTBGzmQDjTq0JqEWMK
         aQXTGzkf/nC/RPe71VHwoPGbbozQ6Uz9iM/BZ1v/iUt3o34OEjSdH2Y9WSVYSCCDFxzL
         5CYgYZ+HPvyek1UFr1LmAHojj1LJkpvu72FguTqxM7OOnQqHNcBFSpukezGZEi843ixm
         IGQkX+ItyXiiD/SuDS/IFcijAowxDtRoEkDU3BamV3+RSRjgwif+/q2VJbQHZ0hOenrh
         ul3L/x7OVJKDsuLG9j1bMwDmiSyL+UTnKBg9yb159VsLEbPktqATFszBOu15V5e7e2XF
         32ag==
X-Gm-Message-State: AOAM533qFiaKoPGYKA3SeqhLPTieI4yaQQDqN1UBPFFWK9qqYza3HP2h
        hl9pEwk2sOCEOFgFbzeuqWJOQL1b/tXy61CE
X-Google-Smtp-Source: ABdhPJxhe6d3rGuK/IDK/UwMm1vzBgyU8EUUR8PkLkNOUd8REGIGrrNJzeSE5PRyhDaWu/EhD4Y1/A==
X-Received: by 2002:a2e:b0fa:: with SMTP id h26mr23861047ljl.64.1626722805382;
        Mon, 19 Jul 2021 12:26:45 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id c5sm2200256ljj.17.2021.07.19.12.26.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 12:26:44 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 8so32019623lfp.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:26:43 -0700 (PDT)
X-Received: by 2002:ac2:4475:: with SMTP id y21mr18958429lfl.487.1626722803588;
 Mon, 19 Jul 2021 12:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210718223932.2703330-1-agruenba@redhat.com> <20210718223932.2703330-2-agruenba@redhat.com>
In-Reply-To: <20210718223932.2703330-2-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Jul 2021 12:26:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxmBjwU+NpeVnUrMEgqk7qAF0VRwtXS2YPJo2n3WGyWg@mail.gmail.com>
Message-ID: <CAHk-=whxmBjwU+NpeVnUrMEgqk7qAF0VRwtXS2YPJo2n3WGyWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] iov_iter: Introduce fault_in_iov_iter helper
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 3:39 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Introduce a new fault_in_iov_iter helper for manually faulting in an iterator.
> Other than fault_in_pages_writeable(), this function is non-destructive.

You mean "Unlike" rather than "Other than" (also in the comment of the patch).

This is fairly inefficient, but as long as it's the exceptional case,
that's fine. It might be worth making that very explicit, so that
people don't try to use it normally.

                Linus
