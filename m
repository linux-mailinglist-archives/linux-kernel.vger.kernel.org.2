Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12406391896
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhEZNSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhEZNSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:18:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAB0E613B9;
        Wed, 26 May 2021 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622035011;
        bh=LXobja8LB8VO3c7Zu/EJvpMV/chTpzUwIFAvo7VkUo4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o8+8KqKHcCohw74SaIRiCSvUii4D11QGetAyKuAJo5lpXWEF5Q17G0GUseaKPFAW0
         uendXzieCizlb510GuvCFxNPX72cPRjhZKi4SFY1U2E909xbbpw/klvhk9TauBc73l
         rJ5889/HMZPlLOcobHkEt8g4vUX76XDuwsv7+xmqFVc9EjqcQ3YETxzYfp+XlMm2xO
         DNJXFP5FU2j0ENO7eIgIvshS07YKt4UgepfEn0eoVTyGhjhlMuvzbKj6cNPvlnwd1b
         Wa1s8whBOkXFN0RWeJjvDQ7ssMai8kdteBWBey8bmiIZBMwIczBzvOyeBwlpHL1h5n
         kk0CxKTZ5C9VQ==
Date:   Wed, 26 May 2021 22:16:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, acme@kernel.org
Subject: Re: [PATCH] tools/perf: doc: Add permission and sysctl notice
Message-Id: <20210526221647.972ffffddc88c1b08c19a024@kernel.org>
In-Reply-To: <ebaefebf-76d0-790a-2062-6f451b683be8@linux.ibm.com>
References: <20210525043744.193297-1-ravi.bangoria@linux.ibm.com>
        <162201967838.287555.4257117900130102987.stgit@devnote2>
        <ebaefebf-76d0-790a-2062-6f451b683be8@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 15:20:58 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> 
> 
> On 5/26/21 2:31 PM, Masami Hiramatsu wrote:
> > Add a section to notify the permission and sysctl setting
> > for perf probe. And fix some indentations.
> 
> Yes, it makes sense to have this detail in man page.
> 
> Few minor points below ...
> 
> >   
> > +PERMISSIONS AND SYSCTL
> > +----------------------
> > +Since perf probe depends on ftrace (tracefs) and kallsyms (/proc/kallsyms), you have to care about the permission and some sysctl knobs.
> > +
> > + - Since tracefs and kallsyms requires root or privileged user to access it, the following perf probe commands also require it; --add, --del, --list (except for --cache option)
> > +
> > + - /proc/sys/kernel/kptr_restrict = 2 (restrict all users) also prevents perf probe to retrieve the important information from kallsyms. You also need to set to 1 (restrict non CAP_SYSLOG users) for the above commands.
> > +
> > + - Since the perf probe commands read the vmlinux and/or the debuginfo file, you need to ensure that you can read those files.
> 
> 1) Last two points are applicable to kprobes only, not uprobes. Would
>     it make sense to clarify that?

Ah, right. And the last one may be also related to uprobes.

> 2) For 3rd point, simple perf probe on function entry will work without
>     vmlinux/debuginfo (by using kallsyms). Should we mention that?

Hmm, that depends on the options. If we use -k option, it will get the symbols from the given vmlinux.

> 
> In any case,
> 
> Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Thanks! I'll update it for uprobe.


> 
> Ravi


-- 
Masami Hiramatsu <mhiramat@kernel.org>
