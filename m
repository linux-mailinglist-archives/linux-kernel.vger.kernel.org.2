Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C8F372CE7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhEDP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230254AbhEDP1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620141984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+WO7uY4tDtLKHyctUd8TImZN/GK65bYwlug7Q/x0A0=;
        b=L/BhKcYOE7FgihfiroA+ogoF/xfF3GNNWkU2+I0yd8prsU8XT5sksNPBIQr00p5zq88fVG
        7XGO9fMJGuAVYRXk5mo5LlBV51snMpPyKGsuK331K3HSZYAxc2bhLFI37hAwLiqKtsAdDx
        pYyyLEo3evPfSZbBXA9Fhvoj3hosjTM=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-6XUOq26aP6qZLiawbwSYvA-1; Tue, 04 May 2021 11:26:19 -0400
X-MC-Unique: 6XUOq26aP6qZLiawbwSYvA-1
Received: by mail-il1-f200.google.com with SMTP id f12-20020a056e0204ccb02901613aa15edfso7349886ils.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 08:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x+WO7uY4tDtLKHyctUd8TImZN/GK65bYwlug7Q/x0A0=;
        b=Fs7V0ouf3iaz6KRFekEJQUKr8ZUG7uqHPIFFKAAs4bBwpsw6uZ2ymcLDW+IuXzLCkp
         EH4kFUIG65C8fFU4kw3vCHNf9PJv0qZo6bp0rYK2S+OxIVgrZhvMKotG4yZKbSg7JGOO
         Y/jdW6HqGqfaM2fMecO0vpmr79Yelztm19YwQPMmqrX6OTKVS2WMx81yvjd+rpgrpscP
         OPHkqkk3ztkvROS2t3OQ12uPRGFOzMOEgCI+Z8SJb5DI0iciRBSNzQYOYKqARw3ar+P5
         +z8ldtroUIFsdF37LGQTT3CUIFoZC1Hjm+WqhvWBjh3oaEFPIwvUA51NXuEVOeRFyM03
         chuA==
X-Gm-Message-State: AOAM533+gOCruUo7qD/kXN9Cd7q4SZUD/PL4ei1HoCdxwUrHMa+9erl7
        8C9GXI3+IH2SMHL5a80s0uYNhAWbBzaquKGlweIwU8oK7/k/1x7mgqJfkTb2PaQLWqvJfteOm1d
        1m+9iseHm2xnENeS6hBCT3uuv
X-Received: by 2002:a92:d80f:: with SMTP id y15mr13517672ilm.305.1620141978774;
        Tue, 04 May 2021 08:26:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIgmegiqHBetDA5/cZS+TOd4kUsEUhWRiPgqoLAZr3o5u2vj0gYxVgFCFdkIcHY7o/8YQYmQ==
X-Received: by 2002:a92:d80f:: with SMTP id y15mr13517664ilm.305.1620141978640;
        Tue, 04 May 2021 08:26:18 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id v4sm1303484iol.3.2021.05.04.08.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 08:26:18 -0700 (PDT)
Date:   Tue, 4 May 2021 10:26:14 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Print out unknown kernel parameters
Message-ID: <20210504152614.mgiihv4ukqajo3jb@halaneylaptop>
References: <20210503213400.27360-1-ahalaney@redhat.com>
 <dfc44b3f-a810-cfbe-f13f-39548ab3fb08@infradead.org>
 <20210503184606.5e8461c0@gandalf.local.home>
 <YJFho3AasxxcD/hH@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YJFho3AasxxcD/hH@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 05:00:51PM +0200, Borislav Petkov wrote:
> On Mon, May 03, 2021 at 06:46:06PM -0400, Steven Rostedt wrote:
> > Note, the issue this is trying to solve is to catch "typos" when someone
> > adds a parameter. Perhaps we should add a parameter called "check" and/or a
> > config option to always check.
> 
> Well, actually, you want this checking to always happen and
> unconditionally at that.
> 
> The fact that we cannot differentiate between params given to init vs
> mistyped params, makes it harder to solve elegantly.
> 
I tend to agree, while the "debug" option Randy mentioned gives you the
same info, I lean towards notifying about any unrecognized parameter
personally in an unconditional manner that is clearly mentioning your
command line arguments - it is a bit round about to have to find them
from init. Definitely a matter of opinion, but with the kernel having
specific ways to denote init destined parameters (anything after "--") I
think an unconditional message is acceptable.

> > > > +void print_unknown_bootoptions(void)
> 
> static
> 
Good catch, will fix this in v2 - thank you!

> > > > +{
> > > > +	const char *const *p;
> > > > +
> > > > +	if (panic_later || (!argv_init[1] && !envp_init[2]))
> > > > +		return;
> > > > +
> > > > +	pr_notice("Unknown command line parameters:\n");
> > > > +	for (p = &argv_init[1]; *p; p++)
> > > > +		pr_notice("    %s\n", *p);
> > > > +	for (p = &envp_init[2]; *p; p++)
> > > > +		pr_notice("    %s\n", *p);
> > > > +}
> > 
> > Perhaps make this one line, like "Kernel command line:" has.
> 
> Yap, only one newline at the end pls.
> 
I'm outvoted, will adjust to a single line!

> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
> 

Thanks,
Andrew

