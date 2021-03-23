Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66E5346B53
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhCWVna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbhCWVnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:43:21 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308BBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:43:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id x14so16047448qki.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9A5rYZcglsBI7NEDlAoTBU4Zl5wr8vyLdFv+U1vnm5o=;
        b=cU2MWXhrmvMJIPPFY+bbxexi0G0jjM8KNFl8VyfkYeVEF1MFNe/fqJxh7GgUPTFflR
         SqPsyfx5OyaVhrGA0H1VHSSGQAZLMkXY+YcBwxP1b7GoFjJYf3XxeaZXnYNHCRj38NDz
         +2sWveYk4PiEK7Ikf0nRgCsW3BPpRdxdvRz2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9A5rYZcglsBI7NEDlAoTBU4Zl5wr8vyLdFv+U1vnm5o=;
        b=frh+WS+FIs/Qgqq7IVhUuiPVPh0Bh7KIdPjMJo1FeppnU1Sn9spmAwKgr7zGpxVXAw
         xhlUCGqgbkc6uxWJjL5BHA/ENcTC69baJRzgV114zI4C8msd4IDCix1vfJv+oLCmx4fo
         /Vj1v4O9BoC5PWhYBFuNsqtyh0QzV8lZavP9sFWQYzauijIybmIa0xIcw8pLnki0cw/L
         /rbENZplvMX+2EvCEPC2iOE2tY3+a5Ij9a2dqyZ80QjP5ci5vpIeagLKO5n6RY1xYOLd
         GifM70O+quJXNCMWKS1zPeGxqLIhYiOVzyJXzN+BpPwReRCi6L0pq7yw1/4tc8cRi1yt
         C7zQ==
X-Gm-Message-State: AOAM531M9FqrPRm/BuBQKV3cL3Jdw/865s2mI1k4sbMsS5WkezuyMJZV
        PjJ2Lz3MxclNYk/KnCc+glK8jA==
X-Google-Smtp-Source: ABdhPJxZJb+JsRQXrSlu96XRPInFDlUZede/dKLcYwQmDxWVCkMrvz2KcEfc8dhtyw7wL7Ctm5VKuA==
X-Received: by 2002:a05:620a:819:: with SMTP id s25mr79910qks.485.1616535799383;
        Tue, 23 Mar 2021 14:43:19 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id 79sm163979qki.37.2021.03.23.14.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 14:43:18 -0700 (PDT)
Date:   Tue, 23 Mar 2021 17:43:17 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        workflows@vger.kernel.org
Subject: Re: [Ksummit-discuss] RFC: create mailing list "linux-issues"
 focussed on issues/bugs and regressions
Message-ID: <20210323214317.t3igv3nan4lfolgr@chatter.i7.local>
Mail-Followup-To: James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        workflows@vger.kernel.org
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
 <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
 <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
 <20210323122025.77888b49@gandalf.local.home>
 <72f1c67bc8ad21bb1e5a7d77b88e2c3e50065e3b.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72f1c67bc8ad21bb1e5a7d77b88e2c3e50065e3b.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:30:33AM -0700, James Bottomley wrote:
> > I think the bulk of user issues are going to be regressions. Although
> > you may be in a better position to know for sure, but at least for
> > me, wearing my "user" hat, the thing that gets me the most is
> > upgrading to a new kernel and suddenly something that use to work no
> > longer does. And that is the definition of a regression. My test
> > boxes still run old distros (one is running fedora 13). These are the
> > boxes that catch the most issues, and if they do, they are pretty
> > much guaranteed to be a regression.
> > 
> > I like the "linux-regressions" mailing list idea.
> 
> Can't we use the fancy features of public inbox to get the best of both
> worlds?  Have the bug list (or even a collection of lists) but make the
> linux-regressions one a virtual list keying off an imap flag which a
> group of people control.  That way anything that is flagged as a
> regression appears in that public inbox.  I assume the search can be
> quite wide so we could flag a regression on any list indexed by lore?

There's a number of ways we can accomplish this, sure.

However, this functionality is not in production yet, and I'm not sure which
upcoming public-inbox features we'll be implementing as a public
lore.kernel.org service, which ones we'll only offer to kernel.org account
holders, and which ones should really be running locally by developers
themselves.

So, I don't want to say either yes or no to this one for the fear of
over-promising. I guess this is why I'm not in sales. :)

-K
