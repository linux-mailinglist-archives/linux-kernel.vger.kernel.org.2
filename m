Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D9A314FE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhBINPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhBINPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:15:41 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FA5C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 05:15:01 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hs11so31360172ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 05:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8nOrIochPnFZwvjiJwvTv+URQm52IBPJQpBFIQnLOik=;
        b=fqE5+0uRX4Gafcz8wTXs9Bm0GPDcU70y9opSrPx0XaCgovilXiHPLtlwoqLPfUHhMC
         v6V2wCYhGa417Sl/A2IQiqP4th9TWYzwHyqM4dAhw2k0CFzbrgMwLz5Nh3uph+6ezm1z
         HIf/V/Z6Zf/N5gUBZe143QLWDATc72RC6ggG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8nOrIochPnFZwvjiJwvTv+URQm52IBPJQpBFIQnLOik=;
        b=oD1elESa1ceMNp5eb63rY1mRgafubJnzQhTohhk+QplH6PeKLXFHS7aU5IsAabyNQF
         0EJx8Gd/5G9ZCo16DI+NGtNSsOfEp3L1V1ZGZA4F8bh92Gf8wvCRuH1E1lQn7X2QBfZ1
         PPFzOEBR2cApwWQNtFUP7v2jFHggxzNKm6cifymWt6Yr1jsxLJKbdATbi3f82MJr6xK1
         Tp0H+Pm/Giwn4XCBXJJANeqYqg6zu6YTmvia4qf0TCJJ+g5+I8vIxxOf4jtuEOhu1pqB
         3ctid1szUoVfthzXcDhf0XAhVVu43KEO2+jRBZscEQboIshAudJ6lJlPDjrjQ94mHFr7
         1ggQ==
X-Gm-Message-State: AOAM533qHkXty/UOw3X0/s4UqjJMHFsIU0v6DiamWuxb7+c/PoytNFG8
        /NU7QN8llhg/95TZSDM6Qzk2n1tmlsEH7VHB
X-Google-Smtp-Source: ABdhPJylDCQUWoepWlBaUMgLX6kUMbanM3RC3ic8NqOCVwG0I1UdLbA1XF+g7GmkgtCxCdHMID7K2w==
X-Received: by 2002:a17:906:503:: with SMTP id j3mr3535203eja.172.1612876499955;
        Tue, 09 Feb 2021 05:14:59 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id g2sm10449769ejk.108.2021.02.09.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 05:14:59 -0800 (PST)
Date:   Tue, 9 Feb 2021 13:14:58 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v2] printk: Userspace format enumeration support
Message-ID: <YCKK0uSFxMYv6rqJ@chrisdown.name>
References: <YCIRf1zOk9g2R6fH@chrisdown.name>
 <YCIzGBccfHL0dwgF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YCIzGBccfHL0dwgF@kroah.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman writes:
>How can file ever be NULL?
>
>And if it is an error, what is the problem here?  You can always feed
>the output of a debugfs_* call back into debugfs, and you never need to
>check the return values.

Oh, thanks -- that's helpful to know. Looks like I misread 
debugfs_create_{file,dir}. :-)

I'll send v3.
