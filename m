Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23F9343773
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 04:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCVDas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCVDaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:30:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01C7C061763
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 20:30:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z1so17583252edb.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 20:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NdlqVrkWcO2Ix0XRx3En1tLGGVW/0gQldE17Jjw8wKw=;
        b=TvpnTZoK/W+uNBydWmGvMZA2LK6Ef1tes6GeNEFwv0pQfDTvLPYOnZPasC4ex9v4TE
         fGjehDz0DW3Z4VztMlUrodWW5cL7zVHemsnYD+Prfmflzj0MMV/pABulAUFYDOQHiEn9
         WDQ+vddco1pBO1WX7H/q9cNlTJXT8VPsqiZKM5pnKvyrAoxeTWML1fRQ30Yc3zflnz0s
         CyuKAVCEB3AMJx4I3s2YlxAOE7A3p40uwpiAyCGh82TC1sDWFTwCSwZZfPhzYG/8Z0vG
         OlG9B++DC8tNJypspdEziTa7p94t1FxJZgyMlcExmlrtsKtnoptKoQCYIUDfFYJYvmuN
         LMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NdlqVrkWcO2Ix0XRx3En1tLGGVW/0gQldE17Jjw8wKw=;
        b=i5ZM613qMJ3ipnuSehCdMTItndQ4tbUD9CsxQgqY/MZiZT96E3tSnKAR+/f8AjCXD3
         yvnyGjL6h8RlBTM1FDOpziTakpqfhM5wAE69oKIntzk+UKbc3ip8IDcvQWfKNQ3ODVxP
         rYyjlqTxxfANyjdKkCrXeNJ/TqMlKtdRoJLDiGyOfCaaVRold3LlD53CQwg5yB6Tic4n
         ox8EgomHP5rlcXXzZwjM60g4jtgTmV7dBeWak1DhwI0TmAiArJ+dIhWd5fQtYSM7eoB4
         vHum3jDNUvVwHGk6ehpXLu3cFww+1cWs5EhdVW/A0EBZjRtuaY0rjRvz0aLPhhWXTLIh
         XMvQ==
X-Gm-Message-State: AOAM5300SFeCpr4uSzGVPRaDzV8TQaemzFQFXa7lDMIZ6PTOeyu9FU02
        RUZiyeRhYTYvm+VYxvMizVI=
X-Google-Smtp-Source: ABdhPJxc0kyicvZY3uoT+XACze5MY0vSON3Wfi9APIVnZ6Hdk5tEMv0PupP4XOCoL6TkBpsQPIJmIA==
X-Received: by 2002:a05:6402:1649:: with SMTP id s9mr23338523edx.177.1616383814451;
        Sun, 21 Mar 2021 20:30:14 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id z17sm8643178eju.27.2021.03.21.20.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 20:30:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 22 Mar 2021 04:30:12 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/entry: Fix a typo
Message-ID: <20210322033012.GC1885130@gmail.com>
References: <20210321201345.994577-1-unixbhaskar@gmail.com>
 <cdbd84e4-6099-3ab1-aa44-1f78ab93de1@infradead.org>
 <20210321225555.GB1885130@gmail.com>
 <YFfQO/5Ectr5fWN/@ArchLinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFfQO/5Ectr5fWN/@ArchLinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> On 23:55 Sun 21 Mar 2021, Ingo Molnar wrote:
> > 
> > * Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> > > 
> > > 
> > > On Mon, 22 Mar 2021, Bhaskar Chowdhury wrote:
> > > 
> > > >
> > > > s/swishes/switch/
> > > 
> > > should be 'switches'
> > 
> > Correct - this patch exchanged a typo for a grammar mistake...
> > 
> Sent a V2 ...check out..

I cannot find it in my mbox or on lkml - but in any case, this should 
be fixed in tip:master too.

Thanks,

	Ingo
