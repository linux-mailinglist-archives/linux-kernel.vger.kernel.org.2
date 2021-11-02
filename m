Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3FB443A1A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhKBX52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhKBX51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:57:27 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA9C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 16:54:52 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id r8so706062qkp.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vO4VYxq+eHBQA81nhSLqjjWx4ejJxUAVva8AW+ugOmE=;
        b=U5KqNpjEoUdbE0harjvjuk7Wlf4afX5oJF/IyOrXC00KM9K81x6cMAEls2W9npMvIc
         mtSVZzpwU+17GCnCzEZN5wmZthd88Q8xjeoNLjgLHeo60bXM6ZeyG7QaqK5nCMrvpJ1+
         wnXlQPyOFCOnN5+T9ku9C42I+b7twvEynRtqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vO4VYxq+eHBQA81nhSLqjjWx4ejJxUAVva8AW+ugOmE=;
        b=uGk/RoV/Erk3f3Ycs+R3KAaxp1PyYTEEOlSxh0pIZyxXGBiIxjAPiloq03atOUvyOn
         Wnop1QQKomvs7SK67j9TJIeASLrRJCVsDkojDCp7qNq+10f31cA+p6kCtGXq91Oju1Sg
         xQ1Fcl6osZsuz9TBrB/KIvekacclR2p+lCdTjw6B4B9rPli2eckCyB0w0inLGblf0sgj
         973fLUrRVfM7MFbAJFrzd4NbtpPt08IrgPfJ8oUXjpyGVMUBLW2Qz/pGS5aoTtjpDx5j
         EMeIJb+ox8p/cGrfblTtK+2SX9e3We/8pg8CbaoGCJiUWHSVhdvbL5PLs7Zg3PIevbSs
         jbkA==
X-Gm-Message-State: AOAM533VXaxBfOER+Y2VRWz7Ht9+oeHjQlakJmnI3HsNqsaNBUxSvzB7
        MDFsSS6OzeRUV1FA5yw4ZniX27YIeDHczw==
X-Google-Smtp-Source: ABdhPJzJxXzVTns+6QyDP8omHnk0ZTd2wBsDt10QQMCuSgPa/2MtGgPlh6hCKicu7D00A2X/6jZinw==
X-Received: by 2002:a05:620a:2585:: with SMTP id x5mr31299231qko.378.1635897291380;
        Tue, 02 Nov 2021 16:54:51 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id h14sm421680qth.23.2021.11.02.16.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 16:54:51 -0700 (PDT)
Date:   Tue, 2 Nov 2021 19:54:49 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Moore <paul@paul-moore.com>,
        patch-notifications@ellerman.id.au,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        linuxppc-dev@lists.ozlabs.org, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH v2 RESEND] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
Message-ID: <20211102235449.rwtbgmddkzdaodhv@meerkat.local>
References: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
 <163584790624.1845480.1785827913484538939.b4-ty@ellerman.id.au>
 <CAHC9VhROvSQHVQ6Wo8zHND1rGm+r6dGJur69B65sJ9JwNvMDpQ@mail.gmail.com>
 <87a6im87tq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a6im87tq.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 10:18:57AM +1100, Michael Ellerman wrote:
> It's not in next, that notification is from the b4 thanks script, which
> didn't notice that the commit has since been reverted.

Yeah... I'm not sure how to catch that, but I'm open to suggestions.

-K
