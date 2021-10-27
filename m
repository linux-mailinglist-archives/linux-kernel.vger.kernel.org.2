Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20C643D3AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244256AbhJ0VRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240846AbhJ0VRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:17:33 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A19C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:15:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id d23so5625179ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hiXmABk2yLJcTBwV/OV64LUSAMHnd37fHZz79FC6JvU=;
        b=ZWNMOoSkuRaQ/lv8qizXhk55H0ec5K7RYuCkQOMY0yln4tyxGOGFp3Gs+/CZY7p6bT
         3CZlT/Neco4TP12/d9wLKcFuseqO24iEpPL6jwtGtY8MUiJAI9mKP12Z7SKjitGg++uj
         lH3CUAw1rGdqhKUixiRRtsMf0iuWhbOzVZTJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hiXmABk2yLJcTBwV/OV64LUSAMHnd37fHZz79FC6JvU=;
        b=eGT8kfrSp5X/fv7CAGde4Oq7i6d9f0F4B/OoiYiAaIBkh1338gitnhxy/isWF48dES
         iL1LbbwWn1fcif/YFUGStH+KoOa8Avyoju0AEnJl0Ktp+wfuhkZyJMgPwXah3kPsqRJQ
         JR+iqjiom3DrxT6CTJSPeZfCML3CpKlP1rJ2BqKkqlQuBz0dKsJRBWwdH+LgeYXEO3jh
         lpPbnT2z686uEcteecNiCXzfbUEn0WcuKnMB0GF6f0wz3XY4FmPKfIhrqoiQ5rWnFJ2I
         9lhHXUN79q4QBvSdcNVmnHgXQHB+348MG04VrdA00ph0CnaGRwY3iVOv+HMc3ROYAunu
         iLtQ==
X-Gm-Message-State: AOAM530j06qS6+ye5v6YopxOCnOwhe+MJUl7lAv2W7RCJEcZngfF5Ccy
        Lkm0EB/uHCqPFJhLgNLGNT67xJKDZHFACJh6
X-Google-Smtp-Source: ABdhPJymC8UySUey5hTUdgdPZ5GY/XMniuKo27bmSUTakvDB0/TfTPjsy89eMqcskXc6SQbtQP7ztg==
X-Received: by 2002:a2e:9acf:: with SMTP id p15mr279272ljj.377.1635369306002;
        Wed, 27 Oct 2021 14:15:06 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id i6sm103952lfr.163.2021.10.27.14.15.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 14:15:05 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id bp15so8999672lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:15:04 -0700 (PDT)
X-Received: by 2002:a19:f619:: with SMTP id x25mr90493lfe.141.1635369304547;
 Wed, 27 Oct 2021 14:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com> <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com> <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com> <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
 <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com>
 <YXhH0sBSyTyz5Eh2@arm.com> <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
 <YXmkvfL9B+4mQAIo@arm.com>
In-Reply-To: <YXmkvfL9B+4mQAIo@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Oct 2021 14:14:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQqi9cw1Guz6a8oBB0xiQNF_jtFzs3gW0k7+fKN-mB1g@mail.gmail.com>
Message-ID: <CAHk-=wjQqi9cw1Guz6a8oBB0xiQNF_jtFzs3gW0k7+fKN-mB1g@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 12:13 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> As an alternative, you mentioned earlier that a per-thread fault status
> was not feasible on x86 due to races. Was this only for the hw poison
> case? I think the uaccess is slightly different.

It's not x86-specific, it's very generic.

If we set some flag in the per-thread status, we'll need to be careful
about not overwriting it if we then have a subsequent NMI that _also_
takes a (completely unrelated) page fault - before we then read the
per-thread flag.

Think 'perf' and fetching backtraces etc.

Note that the NMI page fault can easily also be a pointer coloring
fault on arm64, for exactly the same reason that whatever original
copy_from_user() code was. So this is not a "oh, pointer coloring
faults are different". They have the same re-entrancy issue.

And both the "pagefault_disable" and "fault happens in interrupt
context" cases are also the exact same 'faulthandler_disabled()'
thing. So even at fault time they look very similar.

So we'd have to have some way to separate out only the one we care about.

               Linus
