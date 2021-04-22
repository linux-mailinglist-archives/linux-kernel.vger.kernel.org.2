Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A721B36864E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbhDVSCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbhDVSC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:02:27 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4C0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 11:01:52 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso20495501otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fFsg2TYH4ireYbDXYZfMkh//O1PSqMS4ecjkYme1zY8=;
        b=X02AEET3t8W1GphyQbfBj+u54F5dKLPWbvCS6mQwB2d6EFWhCmfH+rxYKcuKdcIcsg
         3PKacMIfnADuThoFvzaMz47FsBLzx/suhn0vB10OowZchSX5frZet7RTUb7ZWa0bpiWo
         PuXTiidfE3DdLSUfBUQEE8xuXTyd7GhlEmtVU6OZU7mdZNyvlKtCIAc9fk42zwIKwEak
         8+XvE7H5l1p8zqcF047BPFIeN7V1zCbPCIlz6EpeFeDM5X4Q2AgitwiXhm62Wz+ZC1MN
         tYlEuITtoAP5VVL+EJ/DMlN3Dj5ioDNss2vP1pfZhoXW3ql86kKc7NoK1iMNMdbkW6aY
         XrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fFsg2TYH4ireYbDXYZfMkh//O1PSqMS4ecjkYme1zY8=;
        b=J6H0ApCbZ7wfv/7PLf/WPxe4qoYFIiAP5DzVFZOzExrV4GSQ66M7LsUx2bczm1pwjY
         lhFZuW688n/IsUU2cadlUbN09eFJKC84UBlZunjn8xpwlHFxFt3oufU+3JYIEHIhPrYK
         1ex7h2xeVXq5bTFzsjmjvwtt1ckdV8mKDdYGu97xLgXgyRgF7hnKtX6ePyI7bEe8s3v2
         AT+gBDByzxO9dXtek1glOKVL2kArzwiACsIcEhEFC1mXrbiFopalKjKtzJ91PmneYR4S
         EAWUbwdTjFD13Yqb3UzEXnTvFlCq0vEo/TKO2thqm6Napjc8QWWablXq4aW/ztBHzlDy
         CXFw==
X-Gm-Message-State: AOAM532GE4+oSIaekO6tYJt284DCO3efzQmw+kE145o3ev2CXIsytook
        8AZgauXToUDAJQYTph21lFE=
X-Google-Smtp-Source: ABdhPJyNarHpS5WY+8vWZAXfBSVcwnTESJLOxUfjcuU6SKi9L+VlSuBl5p/hm9mHT5YJFZInNcEJ4w==
X-Received: by 2002:a9d:2030:: with SMTP id n45mr4030256ota.98.1619114512237;
        Thu, 22 Apr 2021 11:01:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o128sm676823oig.9.2021.04.22.11.01.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Apr 2021 11:01:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 22 Apr 2021 11:01:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] static_call: Fix unused variable warning
Message-ID: <20210422180149.GA107132@roeck-us.net>
References: <20210422003334.139452-1-linux@roeck-us.net>
 <20210421204139.669f5c22@oasis.local.home>
 <YIEjrb7uO1KLgf3y@hirez.programming.kicks-ass.net>
 <552a3a35-43c6-348e-ad46-1abb298cbfbc@roeck-us.net>
 <YIGgrMeudHobfDYQ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIGgrMeudHobfDYQ@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 06:13:32PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 22, 2021 at 07:01:47AM -0700, Guenter Roeck wrote:
> > On 4/22/21 12:20 AM, Peter Zijlstra wrote:
> > > On Wed, Apr 21, 2021 at 08:41:39PM -0400, Steven Rostedt wrote:
> > >>
> > >> Second patch with the exact same update. Perhaps we should take one
> > >> before we get more of them ;-)
> > >>
> > > 
> > > I thought we already fixed that...
> > 
> > Not in v5.12-rc8-6-g4bdafe832681, which is ToT right now.
> > 
> > Ah, I do see it in -next, but that doesn't help me in mainline,
> > nor in stable branches where the patch introducing the problem
> > has been backported to.
> 
> Given it's a silly warning I didn't figure it was urgent material. I
> suppose we can backport it if someone (you apperntly) cares.

We build release images with -Werror, and some of those images have
CONFIG_MODULES=n. So this wasn't silly for us. It was catastrophic
for the affected images. We already applied my proposed fix, so it
isn't specifically urgent for us anymore. However, the presence of
such "silly" warnings in stable releases (and backporting of patches
introducing such warnings into stable releases) gives ammunition
to those arguing that we should not merge stable releases because
they introduce regressions. And your statement that the warning is
"silly" doesn't help either, sorry.

Guenter
