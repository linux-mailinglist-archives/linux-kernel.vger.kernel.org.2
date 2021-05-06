Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8948375CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 23:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhEFVmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 17:42:38 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:60806 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229572AbhEFVmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 17:42:33 -0400
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C845F181D337B;
        Thu,  6 May 2021 21:41:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id B57B718A5F1;
        Thu,  6 May 2021 21:41:32 +0000 (UTC)
Message-ID: <2bea96ba2525c31b18185f51fffea2d2052aa8a0.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: warn about direct use of send_sig_info
 and force_sig_info
From:   Joe Perches <joe@perches.com>
To:     Marco Elver <elver@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 06 May 2021 14:41:31 -0700
In-Reply-To: <YJQJoq+7MAJosrHg@elver.google.com>
References: <20210506132827.3198497-1-elver@google.com>
         <CABJPP5D_azxBiKq08_m_WVmcEy8qbMCa0EsAgu57t2T+eDJA0A@mail.gmail.com>
         <YJQJoq+7MAJosrHg@elver.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B57B718A5F1
X-Spam-Status: No, score=-1.40
X-Stat-Signature: rmbqdd1f7zd69wjedhqbpyjjxip6gg5g
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+hBJaFq2jPLbIgp2RNQYdgnMu9j9P57as=
X-HE-Tag: 1620337292-37696
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-05-06 at 17:22 +0200, Marco Elver wrote:
> Setting up siginfo and using send_sig_info() or force_sig_info()
> directly is discouraged. Instead, new code wanting to generate signals
> should use the appropriate helper specific to the signal.
> 
> Eric mentioned that he'd like to make these static at some point, but
> until that can happen, let's try to avoid introducing new users of them.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7153,6 +7153,12 @@ sub process {
>  			     "Where possible, use lockdep_assert_held instead of assertions based on spin_is_locked\n" . $herecurr);
>  		}
>  
> 
> +# check for direct use of send_sig_info(), force_sig_info()
> +		if ($line =~ /\b((?:force|send)_sig_info)\(/) {

You want to be able to find uses like 'force_sig_info (<foo>...'
so you should add a \s* after the capture group.
And it's probably simpler and more readable to use
		if ($sline =~ /\b(force_sig_info|send_sig_info)\s*\(/) {
instead of the more complex regex

(sline is stripped of comments, $line is not)

> +			WARN("USE_SIGINFO_HELPER",
> +			     "Where possible, avoid using '$1' directly and use a signal-specific helper setting required siginfo fields (see include/linux/sched/signal.h).\n" . $herecurr);

A rather long and complex sentence.
How about
	"Prefer signal-specific helpers over use of '$1' (see: include/linux/sched/signal.h)\n"

And in that signal.h file, there's no obvious reference to
these signal-specific helpers.  Is there a better reference
in the Documentation/ tree?


