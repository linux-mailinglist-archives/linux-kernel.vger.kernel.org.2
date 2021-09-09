Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE34405C00
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbhIIR1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241279AbhIIR1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:27:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D76FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 10:26:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso1962784pjq.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 10:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WKZEgEewmgYvoNLTiF8U+ITbJ8Svyx/0cDptGgsr2eI=;
        b=jzj+0vRLixy7REyFtciSclC/0FHMIuFHrqyc0Lbd3lX9GhF+A9Tgx9n4NR6VTsj8FC
         gLZT4M/5C6vl9zlotgc+OoQ1jEVwjKZjhXvuNOWluZrwiEYzrFR4mHit0EOx/OaL/fNq
         QqOAaLjBXR5NLFwFYk1GZUpLEMdoeQJvZAjUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WKZEgEewmgYvoNLTiF8U+ITbJ8Svyx/0cDptGgsr2eI=;
        b=7FF2r6FT/h7LbB2fI4EMvgUuWmG7Gn1l70MyVcoNp5114rzG95sCbOt58AS2Fx8xbt
         pYgAdByTjA1AqhYmSIb7+Ta6kJcNMz+MmVHiLqINqz2DxT397r4UquxhWM3I/EQg1Qqf
         sXU8X69kyod3YdrtuItxChkLosqOBYE3aWYgXTDoU93HPiEtFz7rC2Tr/mh0SEiHnkyc
         qhjeUYqOa5tYLSdZq/d244ae6zDTU4d3CE3vcLQVnmOXemU2WiL5fDf48+SnT+/Lyxtn
         9W1dnbWKXGCvqWu/QoAx6MMvCIFSOOUy1uiMfQ9Tsragow6/4/6X5tHydKGg8r+5mj/u
         rfgg==
X-Gm-Message-State: AOAM530lj5LEaaDh2cqkWLZuZeijXkESNqXGKor5oB74Oxuzhc1igR3p
        JsiupkjvccNggSUXzSD0/yO4wQ==
X-Google-Smtp-Source: ABdhPJxFlIB7/32j2D1bPjNc+T4c9BnLYylr85p+K3dXHSqgxEw1CDc4w78bCe2RO6TEoDar/Ln7eg==
X-Received: by 2002:a17:902:d717:b0:133:a5f6:6be6 with SMTP id w23-20020a170902d71700b00133a5f66be6mr3707617ply.14.1631208380129;
        Thu, 09 Sep 2021 10:26:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gp11sm105549pjb.2.2021.09.09.10.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 10:26:19 -0700 (PDT)
Date:   Thu, 9 Sep 2021 10:26:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lkdtm: Use init_uts_ns.name instead of macros
Message-ID: <202109091025.A70080F@keescook>
References: <20210901233406.2571643-1-keescook@chromium.org>
 <202109090848.129A49E8BD@keescook>
 <YTowAX7szcAP7ItU@kroah.com>
 <20210909160859.GE5176@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909160859.GE5176@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 05:08:59PM +0100, Mark Brown wrote:
> On Thu, Sep 09, 2021 at 06:02:09PM +0200, Greg Kroah-Hartman wrote:
> 
> > I can't see a rebuild locally here without this patch attached, so how
> > much of a problem is it right now?
> 
> It's triggering for me all the time here FWIW.

Right, if you have CONFIG_LKDTM!=n it'll show up (e.g. with an
all*config build).

> > And isn't -rc2 ok?
> 
> Lots of trees base off -rc1 so unless people change their workflow to
> merge up -rc2 it'll impact submitters.

Right, that's why I was suggesting it.

-- 
Kees Cook
