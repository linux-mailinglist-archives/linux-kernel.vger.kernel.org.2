Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABCC32E1B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 06:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCEFkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 00:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhCEFkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 00:40:17 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B6C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 21:40:16 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id a4so602789pgc.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 21:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F4kegxO+hyM9AAlLWbK87rAqjEYzkEMk/GVzELor2z8=;
        b=oKEQ6gNHFODs+dg2G9gk5/6gLVWzoPdxh0LP6pTy61BNuZPzZCcCWX3XB4mTZ+WaAj
         Szac7cRDk1QSTsrYA+1SNwvPzYRtOwdKbFcLTpIu1qVx2KmHh5zrgoyRJvcjEl3WfRHD
         YzovAc9Z6xlvG7ZGjG6OZhzZx6Sf76e/bVvEM2XLvz15zE8TH9KIp6YWWqnqR6WoagnE
         ju1aZ8KKxy9hApZFNtOANVLSzczg7b3uxf3HG/KHf1XJT0LzfGcA/ROlsYjzvQ9AhGpu
         xzX1qaVk5yUSnbR0sTL5/vEslTMq9vTRNqS8ipUNLyjl9C115YyiIiyIs/3DRIJ6+yYo
         6umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F4kegxO+hyM9AAlLWbK87rAqjEYzkEMk/GVzELor2z8=;
        b=c2fKVAx4PUXZ1OhJAXWyTfdQ6xSK+pysRavwubvCrtQq/LZeqF0593f1/1IRVkfrYk
         E5WaS0DI4pHLjp1iTtVLqVLCf1Sbaoh84paV2xs3NTo/arg5yJ+Lw/4L9AVK73K9mIZ/
         0pzTbid355gDsy844uJgh5U20VSWOgL6VKJZrjajkO75U1PMlcreZTRZaVdi9V0tN6OV
         D3oRS7bkVgKAz4KMg/1EBRbjEMQUXNkxaavVRgpX6KdHM/g/rj87izWSGeCRYo67+CgV
         sw36aN1Ehc0HofH/7QXV4wamJfhNWzWvxoAit9kAvf53P0ZxogSk71zmXORRF9ia1TYj
         S2FA==
X-Gm-Message-State: AOAM530VlLUhKraAtNGyfvVNbCMdgKBD1Jf3IPoR8yvWcfAf0OuFKs0j
        QhBq83dHe8/O/YfGpfLVD2M=
X-Google-Smtp-Source: ABdhPJxBvEd6h0zxbCEaLB6do9J1Bo5uZYu3HTZtKtSSy/chfRKAV6CGUU3kStEEtIgyGG44XAxpsQ==
X-Received: by 2002:a62:7708:0:b029:1ee:f656:51d5 with SMTP id s8-20020a6277080000b02901eef65651d5mr7354124pfc.59.1614922816402;
        Thu, 04 Mar 2021 21:40:16 -0800 (PST)
Received: from cosmos ([103.113.142.250])
        by smtp.gmail.com with ESMTPSA id 35sm983425pgm.64.2021.03.04.21.40.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Mar 2021 21:40:16 -0800 (PST)
Date:   Fri, 5 Mar 2021 11:10:12 +0530
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix memory leaks in __create_synth_event()
Message-ID: <20210305054011.GA1944@cosmos>
References: <20210304094521.GA1826@cosmos>
 <20210304094049.19554140@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304094049.19554140@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 09:40:49AM -0500, Steven Rostedt wrote:
> On Thu, 4 Mar 2021 15:15:24 +0530
> Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com> wrote:
> 
> Not anything to do with you. I have a set of fixes that I have queued that
> requires a ~13 hour test to run before I push off to Linus. When it was
> almost done, I discovered another bug. Fixed it. Killed the almost completed
> running test, and restarted it for another 13 hour run. I woke up this
> morning happy to see that it passed, but then found your patch.
> 
> Wash, rinse, repeat! :-p

Sorry for wrong timing of sending this patch :)

Thanks for looking into it, and applying it.

Regards,
Vamshi
