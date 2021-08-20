Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB913F313F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhHTQLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 12:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbhHTQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:11:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85DCC034019
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 09:05:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so7645677pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 09:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9RSxFZuikPY0+6WkzucAxhDl/Af7QYt1ZT+jZ731aVs=;
        b=C51vSheFGqvRaMzd78bsgYL+KckqPd7LdgQ1wxeWTkI06dNiE8mq/SN0h9cLyjDSKp
         XecYIk+Up2Oo2FQuvAXsBO9g4mcC8iEiR/5e9c6esL0PPyBiG6ucXN8K0+ek6epZ01uO
         MjScRZDErFj/SkOc0WQTvNyH+tea3ac7xNVzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9RSxFZuikPY0+6WkzucAxhDl/Af7QYt1ZT+jZ731aVs=;
        b=oi909Q7kYx5DmrFKBsJ9PIngfufC3qASN5YIuvGYYE9Xlno14TxKiQjuetAYfqyckm
         mUlqjj2ZG0OW610V0uhvroYHYxHa5iWJqEJG9cDuVrdb4XLdwovM2d3fBouax/xWGkIL
         L/B6svpIvL70ITF2MUuUsKuSUfIl0BZ5taHG3DkFbtpahCL2NtbyijraRHm4U9FcZqbg
         8zl6NfEbewT49V8E03YJOZZ8mu2JVi/QvSw3+jp1RzEsaJlQcfdLB0MnGrP0QeTSK8ls
         LNQcEMGD0avlrXHEUW4EJ+TNupK8aP+QxGEVDXNhQ+Wu4v4KtcsGr5UT2JYKwwhGT4Wr
         3nww==
X-Gm-Message-State: AOAM530tNitRXU8LvhOorppcVtfxdMdUNwMJref8uX74q+/xlo6KOjBh
        Lpd+DXJc5V+7C3UyGM6BCcsG9A==
X-Google-Smtp-Source: ABdhPJx1Wpa6EBam0RYtT/6mZ8dD8eoIueMBE+WIU9ng87w+5uPAP4mmMdGc1ciQ717B/aGft7Osow==
X-Received: by 2002:a17:902:7681:b0:12d:8f52:3d55 with SMTP id m1-20020a170902768100b0012d8f523d55mr16786637pll.70.1629475507362;
        Fri, 20 Aug 2021 09:05:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i24sm7377171pfo.208.2021.08.20.09.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 09:05:06 -0700 (PDT)
Date:   Fri, 20 Aug 2021 09:05:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jordy Zomer <jordy@pwning.systems>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mm/secretmem: use refcount_t instead of atomic_t
Message-ID: <202108200904.81ED4AA52@keescook>
References: <20210820043339.2151352-1-jordy@pwning.systems>
 <0874a50b61cfaf7c817cab7344c49c1641c1fd10.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0874a50b61cfaf7c817cab7344c49c1641c1fd10.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 07:57:25AM -0700, James Bottomley wrote:
> On Fri, 2021-08-20 at 06:33 +0200, Jordy Zomer wrote:
> > As you can see there's an `atomic_inc` for each `memfd` that is
> > opened in the `memfd_secret` syscall. If a local attacker succeeds to
> > open 2^32 memfd's, the counter will wrap around to 0. This implies
> > that you may hibernate again, even though there are still regions of
> > this secret memory, thereby bypassing the security check.
> 
> This isn't a possible attack, is it?  secret memory is per process and
> each process usually has an open fd limit of 1024.  That's not to say
> we shouldn't have overflow protection just in case, but I think today
> we don't have a problem.

But it's a _global_ setting, so it's still possible, though likely
impractical today. But refcount_t mitigates it and is a trivial change.
:)

-- 
Kees Cook
