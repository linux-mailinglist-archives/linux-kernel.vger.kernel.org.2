Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1BD31D1D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 22:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBPVBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 16:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhBPVBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:01:16 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2FAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 13:00:35 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id p6so5300864qvm.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 13:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QSVmwKOtk7FB0iPQgSkX8IewiSJ/NEzCzZpU78EnTxA=;
        b=ni+u71Q3dKJtktZ46g9IYkuvBtAss9ivf72Rz+UoKSYd6WsVV9pE6IFqfhrMzXUNuD
         EYTp4oONfMN+5vLlGfnYBcfKUwbDdGAKiPbmbuG/ilyaP5pVR6YFz/dqLjOqAausJuhG
         BtEd2SqJ9dNA1HB/KjqdO7llv5t7Vv6Wo2ckdTMPCENJpImzBuf/VGjs68Ss/MsSzrUx
         ePs4CmF6oOPeetUchHo9WWAxq3Xq8tcyWIhUKFwUtag/EzCpOajOftompHWD8l/YlE/7
         G68SdtvkZG8GlM/9heQ8CWT2+5PzdJjru13Jbg6+aiIQZWRgKP1tt0rJ/yywZTZqbxyW
         btEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QSVmwKOtk7FB0iPQgSkX8IewiSJ/NEzCzZpU78EnTxA=;
        b=DohuWUrl1qyYgs5H4kRJs2I6DfG8ULkGxelQ1oNrwIVfK0TXK3L3+Fr2u5jaDLt8YX
         Iwnx+tpsRnx7pqpArDsEN0w+Wg0YtyjXoGBITS9QQriJTSaIBE29c2YEH8xEOioopWHM
         06irZ2Zx0nZ84wBwqOkQaFLc3WeL3upXyTr7KPBBoPK1+COysNl4jk1B9brHtA1iRaKH
         rilZk1Io7XdbYRZTBYZdZ2AldSyqMdHUIRVH9g5acK5bGDWwy47ksAjPl9M/8+/wUItC
         72m5worrDEJo+dvMZWLJRXi8Q6KJTjBI+9iI5wlkKx/Or35OExzhYq/bT8LzFTie2P1c
         LX8w==
X-Gm-Message-State: AOAM533nOj4ZFZ8TBusszny0ZgSSuBneujlDFQUJRXHIsUkywhog+LXW
        EtF4e+4i7n1tvbxJdoCJpIZdNw==
X-Google-Smtp-Source: ABdhPJw6mnEhTfDhINL8Wp1Pc1R0Jspmpg0STsdoxtizR44p2V/PXUcBIrbS8W3Mv2DyjYu80L/brg==
X-Received: by 2002:a05:6214:174d:: with SMTP id dc13mr7983283qvb.62.1613509234873;
        Tue, 16 Feb 2021 13:00:34 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id x12sm91254qkj.20.2021.02.16.13.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 13:00:33 -0800 (PST)
Date:   Tue, 16 Feb 2021 16:00:32 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: code style: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YCwycC8hPsPD7ArU@cmpxchg.org>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCv9Xb7ePnDy9xRf@alley>
 <YCwAbGoVuZJspcx5@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCwAbGoVuZJspcx5@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 05:27:08PM +0000, Chris Down wrote:
> Petr Mladek writes:
> > I wonder if we could find a better name for the configure switch.
> > I have troubles to imagine what printk enumeration might mean.
> > Well, it might be because I am not a native speaker.
> > 
> > Anyway, the word "enumeration" is used only in the configure option.
> > Everything else is "printk_fmt"
> > 
> > What about DEBUG_PRINTK_FORMATS?
> 
> Hmm, I don't like DEBUG_PRINTK_FMTS because it's not about debugging, it's
> about enumeration, I guess :-)
> 
> The name should reflect that this catalogues the available printks in the
> kernel -- "debugging" seems to imply something different.
> 
> I'm ok with a different name like "printk catalogue" or something like that
> if you prefer. Personally I think "printk enumeration" is fairly clear --
> it's about enumerating the available printks -- but anything that captures
> that spirit is fine.

How about config PRINTK_INDEX?
