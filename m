Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC41F3FA0C3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhH0UoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhH0UoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:44:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7594C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 13:43:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso9643285pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=es5gtjhENWB79sLZ79K6hxDx1HVq6EBAX7j3HW4typw=;
        b=gmt5Mp0IgaRkMY54PcMga1eLF7Afk7zcLUG83z2o91zzXwBqHnxQvvPoT3zEP9cJ0c
         OdOKbqWtMWEUjvllWJmrHG/F9tATXjEiwp9ToA/WpXmvIqt1ePq2JikWKceINCAx6jrm
         jfaM0XGIESsp8G6Yk0PjT6ITVGRyJ8zyko6OlRL4rr18H3k817EQVZDCnyhbsUhP32Xl
         b9ULBl3tQXTHZ00smpUsbFQHvt5Xfaxd2sdKeIx0AbQo0JHVM4xDO1sH1uhLH98qv0eG
         fDIjFXu//X2lA4PsliluOK/MbMy+aPlaJ+E/tLQOcwaQTsr+R+DaisVlYvbJQ5v5cRLv
         ayXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=es5gtjhENWB79sLZ79K6hxDx1HVq6EBAX7j3HW4typw=;
        b=o6fvDFAORLH3grBIiiQoymGQPyb4MaGFrzEREQR9vdGxN69xh2aUdkMIVXcCyVwjJ6
         Ti25bilZdc8bnqQgp0+lnej6KryZyjcj8J6YBuOrdrTJ63XikI1PtmyWM6fLpYPfgwGx
         TIc29b1WL+8QoxLTTZuCKgyOEr2F8LoYeeDzdxQHBsx/QEa90WwNGndkMBVq8wfM6Ole
         l27jrA9CSiTlqzQ3TxbsXknEF/ylPl+bo92a2xShQKVAf97F731mMcswhfxp/9YnKkJT
         JaHU0m4MGjLi2sS8Ra+BbXgZgus1XU8Wo4Fu0H6figonhJF5XJScAVdU14c1kqds0n9S
         T5qQ==
X-Gm-Message-State: AOAM531Hw1FT6EaytTbpEm9iqbMrgtoCNyjPOzBVYuNeROwlIM9cfZ5p
        YrrI5TaqTcJVQNutt3whBivQUA==
X-Google-Smtp-Source: ABdhPJwjTWsz+TFVHmuSv1hcV51k1QdExw20URi2PmswyOyTKKLv9pBovjFi4qHivbUgrCbqE0PmOg==
X-Received: by 2002:a17:90a:345:: with SMTP id 5mr16954518pjf.203.1630097012013;
        Fri, 27 Aug 2021 13:43:32 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 6sm7388391pjz.8.2021.08.27.13.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 13:43:31 -0700 (PDT)
Date:   Fri, 27 Aug 2021 20:43:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Basic recovery for machine checks inside SGX
Message-ID: <YSlObwgsUTcrixfm@google.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
 <20210827195543.1667168-1-tony.luck@intel.com>
 <YSlLAaNEhQ3kKZ1D@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSlLAaNEhQ3kKZ1D@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021, Borislav Petkov wrote:
> On Fri, Aug 27, 2021 at 12:55:37PM -0700, Tony Luck wrote:
> > Here's version 4 (just 38 more to go if I want to meet the bar set by
> > the base SGX series :-) )
> 
> You're off by 1:
> 
> https://lore.kernel.org/lkml/20201214114200.GD26358@zn.tnic/
> 
> you have only just 37 more.
> 
> :-P

LOL, sorry for setting such high standards.
