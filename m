Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E913FE5E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbhIAW5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhIAW5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:57:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55693C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 15:56:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e21so2514033ejz.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 15:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0c37HS5qGIQEDVteYJ2WQmPS4YgB8XOhpU0JZzYZ1Qo=;
        b=gfp4E9dBC2tWKF9R7s3e22N9lHVXU87BJ5dwhu3XiXLxprxKEHSaI29Vm0i5OUt0UO
         YgTrWTl0A8gLHo569dg4NGpFxPz8apW1J+wp3dHoNgabn0eSUPPB1NCTxNZtmFl727Rj
         YQdKbVWl5SHRDKRkkKN4+XjPwPjXFrNvzCYhZEkRnHK285ZN+MZZ5mNfc/EW1ZOnRBrT
         i0UmlIW1k0ki5Ma0UDTCwg3f5P97+f21ixpT/p0cloWiLSteW2zhBKPMz5nxYHR3WY+b
         bGM4HUKZcMZg8e/CiopZ3HLPaFca/gy2cvMRW+4ocdlUm0V4xfX5civTULe2ZrojEdRK
         I5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0c37HS5qGIQEDVteYJ2WQmPS4YgB8XOhpU0JZzYZ1Qo=;
        b=Lf6rqb1zuerJYq2OAwhYm+oFQSC1nsLzBRHinIJEgFpWA+IhzOCuj+byj90vxhVytJ
         bnLWLx3QJBUUU3GoiGPRPkxp+Hbc/EA4AJL/ZARp0nG0/NK43bLuEOOOMwrMq2CnrNs2
         Rv8ZqPRu9RLRHhyWnzh0VGhB8+TfoPxOSXdBsd7S39f3AgzuWeogjPYuk7XoPgW1/rcW
         KlF5+I8L1PaHgStHTObYKTPKuAM0cb/V+PGaRZ9K/N7mMjsQQcYyLY/66KM9tKKJibIo
         f+S+aGFlHhDzk8sao9zrXohAb0LmxzRyprMRo+2CBbihEWM3e863doCygB5OT/MXkC+d
         0cFg==
X-Gm-Message-State: AOAM531JR5EgNgHlJRCv5kk2nqfD3gpsO/EHBF/qHyBKSUC6w8ou79Qd
        6iIHyjehmKs3hG18PEX3hhnH87ZgT+AStVFsryc=
X-Google-Smtp-Source: ABdhPJyWNbS01BkhSLqOZqUJi5Tfwg15PEXXHHjA1v4ofvx9dCuJ3rJDgrkfSGWUZcPLKYjbHuqa3oP69fgncW82wvQ=
X-Received: by 2002:a17:906:b14d:: with SMTP id bt13mr241919ejb.39.1630536991855;
 Wed, 01 Sep 2021 15:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS8HpUz9FUcFWt0V@zeniv-ca.linux.org.uk> <CAHk-=wiwAC8L7UsRsd-sHNS8ZETbrTB0EELvYV1qMOUo86R7kg@mail.gmail.com>
 <CAHk-=wjAPEs3HRGswJ-AE1R048j2MBsBtMfg3GOsaFykHoeKsg@mail.gmail.com>
In-Reply-To: <CAHk-=wjAPEs3HRGswJ-AE1R048j2MBsBtMfg3GOsaFykHoeKsg@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 2 Sep 2021 10:56:20 +1200
Message-ID: <CAGsJ_4yLrGv2izZ2z4QWnBbDOhEjHygHDFBthfFqW0XEkMP-ag@mail.gmail.com>
Subject: Re: Is it possible to implement the per-node page cache for programs/libraries?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Wang <zwang@amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 5:31 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Sep 1, 2021 at 10:24 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But what you could do, if  you wanted to, would be to catch the
> > situation where you have lots of expensive NUMA accesses either using
> > our VM infrastructure or performance counters, and when the mapping is
> > a MAP_PRIVATE you just do a COW fault on them.
> >
> > Sounds entirely doable, and has absolutely nothing to do with the page
> > cache. It would literally just be an "over-eager COW fault triggered
> > by NUMA access counters".
>
> Note how it would work perfectly fine for anonymous mappings too. Just
> to reinforce the point that this has nothing to do with any page cache
> issues.
>
> Of course, if you want to actually then *share* pages within a node
> (rather than replicate them for each process), that gets more
> exciting.
>
> But I suspect that this is mainly only useful for long-running big
> processes (not least due to that node binding thing), so I question
> the need for that kind of excitement.

In Linux server scenarios, it would be quite common to have long-running big
processes constantly running on one machine, for example, web, database
etc. This kind of process can cross a couple of NUMA nodes using all CPUs
in a server to achieve the maximum throughput.

SGI/HPE has a numatool with command "dplace" to help deploy processes
with replicated text in either libraries or binary (a.out) [1]:

dplace [-e] [-c cpu_numbers] [-s skip_count] [-n process_name] \
             [-x skip_mask] [-r [l|b|t]] [-o log_file] [-v 1|2] \
             command [command-args]

The dplace command accepts the following options:
...
-r: Specifies that text should be replicated on the node or nodes
where the application is running.
In some cases, replication will improve performance by reducing the
need to make offnode memory
references for code. The replication option applies to all programs
placed by the dplace command.
See the dplace man page for additional information on text
replication. The replication options are
a string of one or more of the following characters:
l - Replicate library text
b - Replicate binary (a.out) text
t - Thread round-robin option

On the other hand, it would be also interesting to investigate if
kernel text replication can help
improve performance. MIPS does have REPLICATE_KTEXT support in the kernel:
config REPLICATE_KTEXT
bool "Kernel text replication support"
depends on SGI_IP27
select MAPPED_KERNEL
help
 Say Y here to enable replicating the kernel text across multiple
 nodes in a NUMA cluster.  This trades memory for speed.

Not quite sure how it will benefit X86 and ARM64 though it seems concurrent-rt
has some solution and benchmark data in RedHawk Linux[2].

[1] http://www.nacad.ufrj.br/online/sgi/007-5646-002/sgi_html/ch05.html
[2] https://www.concurrent-rt.com/wp-content/uploads/2016/11/kernel-page-replication.pdf

>
>                 Linus

Thanks
Barry
