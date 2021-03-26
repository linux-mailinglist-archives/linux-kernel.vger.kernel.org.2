Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589A834A391
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCZI7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhCZI7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:59:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D0F661A18;
        Fri, 26 Mar 2021 08:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616749155;
        bh=Wz7SXPw9LmTXAhYYVC9OPNi87BYim1h04zS6vTMMPog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUkW9rz8Nj4DAbs3ftL7yYrx2SrU31ILmT0WJ6LMTuhXNOdAP9QlpKomN3MDJuDqM
         3XEsdVGNHn+m4h5Oh8QwSTTyhNwINsBBgMilom04zA/JTnKbEC6MWKOr2zlUgwzO/P
         ew2FETtiTP76TS12FW1G+Z58DsmMw314BXAopwhM=
Date:   Fri, 26 Mar 2021 09:59:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [Ksummit-discuss] FYI & RFC: obsoleting reporting-bugs and
 making reporting-issues official
Message-ID: <YF2iYFEoc56sfeMx@kroah.com>
References: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 07:13:09AM +0100, Thorsten Leemhuis wrote:
> 
> Lo! Since a few months mainline in
> Documentation/admin-guide/reporting-issues.rst contains a text written
> to obsolete the good old reporting-bugs text. For now, the new document
> still contains a warning at the top that basically says "this is WIP".
> But I'd like to remove that warning and delete reporting-bugs.rst in the
> next merge window to make reporting-issues.rst fully official. With this
> mail I want to give everyone a chance to take a look at the text and
> speak up if you don't want me to move ahead for now.
> 
> For easier review I'll post the text of reporting-issues.rst in reply to
> this mail. I'll do that in a few chunks, as if this was a cover letter
> for a patch-set. Note, the version I'll send in some areas looks a bit
> different from the one currently in mainline. That's because the text
> I'll send already incorporates a few patches from docs-next that are
> waiting for the next merge window; I also removed the "WIP" box as well
> as two remaining "FIXME" notes, as those point to aspects I mention
> below already.
> 
> @Greg, @Sasha, I'd be especially glad if at least one of you two could
> take a look and yell if there is something you really dislike from the
> perspective of the stable maintainers.

I responded to the specific email, but will again here.  No objection
from me at all, this is a great resource, thanks for doing this.  If,
over time, it needs any tweaks to explain things that people commonly
get wrong, that's easy to do, so don't worry about trying to capture
"everything" right away.

thanks,

greg k-h
