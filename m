Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302B33910BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhEZGfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232514AbhEZGfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:35:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD42361090;
        Wed, 26 May 2021 06:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622010823;
        bh=//HIC0wWxbiKsea2wsR5H038/7YI4tnT/OaBYgjVYRU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NFzYrEFHgxupPIPrHrsmPAdG3hUVS842r7TADpXHyf+ikf9M8thSLERxAQ7t9O4Rh
         NK2WBLMSB0AhmszVlIhhxZ2xC50Mbu6xywcOdXq+52A3WsMz+1HzrOmg3VXgacweMY
         FHE0IiT3cUySQkEwrgqzrgMzMJyeK6RYfAnKQq2Vmz65VP14cHFxMvI+TzOQA8QkzJ
         q+Vs2azcUtNXOKa4gB0wDvd8UBHc9X4iJ1D3W121eg3ofzSXjs7eewFeE5JHVHQZVY
         pHczQpmsccFZnVS1FCnVGKl58rYfi5ZjygYlxqiGtvl0mWWxDDQW1aAB/ADxTYSiog
         dNX94usJ5GUDQ==
Date:   Wed, 26 May 2021 15:33:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH] perf probe: Provide more detail with relocation warning
Message-Id: <20210526153340.a49ba8292f201493990f210c@kernel.org>
In-Reply-To: <05e32c82-1009-03ba-d973-8b1bc0582ce2@linux.ibm.com>
References: <20210525043744.193297-1-ravi.bangoria@linux.ibm.com>
        <20210525214858.33a66846ac09e499c3268a63@kernel.org>
        <05e32c82-1009-03ba-d973-8b1bc0582ce2@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 10:23:18 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> 
> 
> On 5/25/21 6:18 PM, Masami Hiramatsu wrote:
> > On Tue, 25 May 2021 10:07:44 +0530
> > Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:
> > 
> >> When run as normal user with default sysctl kernel.kptr_restrict=0
> >> and kernel.perf_event_paranoid=2, perf probe fails with:
> >>
> >>    $ ./perf probe move_page_tables
> >>    Relocated base symbol is not found!
> >>
> >> The warning message is not much informative. The reason perf fails
> >> is because /proc/kallsyms is restricted by perf_event_paranoid=2
> >> for normal user and thus perf fails to read relocated address of
> >> the base symbol.
> >>
> >> Tweaking kptr_restrict and perf_event_paranoid can change the
> >> behavior of perf probe. Also, running as root or privileged user
> >> works too. Add these details in the warning message.
> >>
> >> Plus, kmap->ref_reloc_sym might not be always set even if
> >> host_machine is initialized. Above is the example of the same.
> >> Remove that comment.
> > 
> > Yes, those are restricted in some cases. Anyway without priviledged
> > (super) user, perf probe can not set the probe in ftrace.
> > 
> > Hmm, I think it should check the effective user-id at first. If it
> > is not super user and the action will access tracefs and kallsyms,
> > it should warn at that point.
> 
> If kptr_restrict=2, perf probe fails with same error even for root user.
> That's why I thought to just change this warning message.

Ah, yes. In that case, perf probe must not use the base symbol.
(like -D option)
OK, then, let's merge this fix.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Different combinations of privilege, perf_event_paranoid, kptr_restrict:
> 
>    Normal/Root user
>     |   perf_event_paranoid
>     V    V   kptr_restrict        perf probe error
>    ----------------------------------------------------------------
>     N   -1    0     Failed to open kprobe_events: Permission denied
>     N    0    0     Failed to open kprobe_events: Permission denied
>     N    1    0     Failed to open kprobe_events: Permission denied
>     N    2    0     Relocated base symbol is not found!
>    
>     N   -1    1     Relocated base symbol is not found!
>     N    0    1     Relocated base symbol is not found!
>     N    1    1     Relocated base symbol is not found!
>     N    2    1     Relocated base symbol is not found!
>    
>     N   -1    2     Relocated base symbol is not found!
>     N    0    2     Relocated base symbol is not found!
>     N    1    2     Relocated base symbol is not found!
>     N    2    2     Relocated base symbol is not found!
>    
>     R   -1    0     No error.
>     R    0    0     No error.
>     R    1    0     No error.
>     R    2    0     No error.
>    
>     R   -1    1     No error.
>     R    0    1     No error.
>     R    1    1     No error.
>     R    2    1     No error.
>    
>     R   -1    2     Relocated base symbol is not found!
>     R    0    2     Relocated base symbol is not found!
>     R    1    2     Relocated base symbol is not found!
>     R    2    2     Relocated base symbol is not found!
> 
> Ravi


-- 
Masami Hiramatsu <mhiramat@kernel.org>
