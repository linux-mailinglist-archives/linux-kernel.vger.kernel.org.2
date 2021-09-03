Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2274002CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349834AbhICQCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbhICQCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:02:18 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114B6C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 09:01:18 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id gf5so3424213qvb.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D+klCNTaIWLPsXOQSCcYBo0vzp9QlNQpU3YASo1c48o=;
        b=XUpasbNhz9flFIHg2CAfg5ky8CYX1dHU0HCCXtQxtuzM7G2L0aRub1J0E0eIXbroUa
         UlcF2SPWVauFbZgnsd95DYXIhJ8cXzU6zHAhkWEYzaeMvEDNbOxVUGf5F93ON1lnf7pU
         k8Sl9xvf1zlqfuiQbdFPja+O4fq+3fkzglaQ6OuW33rnZ0lP7lmbCCL7MBZ7K3Pxx7YL
         bzQyBwUYW3/H2OG/aXuFP8eg2tjfOEr4H8u0ljEsdJs8PeV+67v3oJoV7ztSeBBzA9UL
         Dc7uTtVJZrtDWk3tU8KqhdnqCvNiQ7dA7VEpjEZUQrSg4P2DNelXDWVOZxO3FHgjmsGz
         RJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D+klCNTaIWLPsXOQSCcYBo0vzp9QlNQpU3YASo1c48o=;
        b=ComgJ9KfAHQj0/+TsM75CPX6cynUkfWFsbDsJrlZGm32mz1VXOdscT/buJAwlntmQb
         5CeYSG4a7b9mACN8vOKsXGfpv/l5pHRMIL28g3VRNop2bEIash64o0gj3+ORTOdiaBKr
         uUZHBOgt9DBWyhEJneTTRu+/yy3tdOrfzIm3Ogobvgf9JH344SIzsOnYXFRzwjzgDd89
         K5tVAbBWtyx+QYP+lJk5VCe94Z2YWPHsvaa5rGX4Bec5oUA0fjgiT3eZe19WXtqUSLcm
         4fUfPjeVc9fjmrSKYVihwZ8QADLeT4fuVRzChzHcy16ihEAtyBuxEJMXLUWYc7EiwMcE
         oECw==
X-Gm-Message-State: AOAM530PAKQlYGogQnGneEU2CwCNe0nzncrqtNBZ1c5b/DjyU+tH/ogI
        wPP6gMZOl8vdy7wAZamhdvNy81Dz7Bg=
X-Google-Smtp-Source: ABdhPJwMmfBsr+9XDbHsQO0Ok2a8EnbmbJTxqLmBhFgYJBac4ir4amV5DMRI8d2ZnDVSz3cw7MEF+g==
X-Received: by 2002:a0c:ab08:: with SMTP id h8mr4439332qvb.41.1630684877014;
        Fri, 03 Sep 2021 09:01:17 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id n11sm4003904qkk.17.2021.09.03.09.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 09:01:16 -0700 (PDT)
Date:   Fri, 3 Sep 2021 09:01:14 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/vsprintf: add __putchar()
Message-ID: <YTJGyk65rv/026+p@yury-ThinkPad>
References: <20210827171155.700434-1-yury.norov@gmail.com>
 <YSuNTVh17CxUNxtC@smile.fi.intel.com>
 <20210903105607.35af6674@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903105607.35af6674@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 10:56:07AM -0400, Steven Rostedt wrote:
> On Sun, 29 Aug 2021 16:36:13 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Fri, Aug 27, 2021 at 10:11:55AM -0700, Yury Norov wrote:
> > > There are 26 occurrences of the code snippet like this in the file :
> > > 	if (buf < end)
> > > 	        *buf = separator;
> > > 	++buf;
> > > 
> > > This patch adds a helper function __putchar() to replace opencoding.
> > > It adds a lot to readability, and also saves 43 bytes of text on x86.  
> > 
> > Last time I tried similar it failed the compilation.
> > 
> > Anyway, while you remove a lot of code I'm not sure it makes the code better
> > to read and understand. Also, we use the same idiom outside of this file.
> > 
> > I would ask Rasmus' opinion on this.
> > 
> 
> I actually like the clean up, although I haven't reviewed the entire patch.

Thanks.
 
> If it is used outside this file, perhaps it should be in a header instead
> and those other locations should be updated accordingly.

I used 'grep "buf < end"' to find spots for cleanup. And except for
lib/vsprintf.c, there is a few random drivers inappropriate for this
cleanup. Andy, can you please share details?

Steve, if you like it, are you OK if I resend this patch? I just found
another spot in lib/vsprintf.c to rework.

Thanks,
Yury
