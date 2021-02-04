Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22FA30FBA1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbhBDSfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbhBDSd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:33:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B53DC06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:33:16 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id h7so6043099lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hsUHxWVQ9pn1uVdqIrgpTfjCGGtb4+YVBfEy6i5I4j8=;
        b=MIpB4GK7A+9drQZ10/Y0xovSPfiwOCvliMddfq/jpGDedVMqXyhEAhy7KYlKseXjin
         A2upjPV9hbYJ3KKwZxV7a8IotVYydpQXhvxCZReUKugIa6aGcF5zj1akjgRTnweyO43c
         TVmSCIRenACFaf9Nu8ulsM6OzU/sCMUNDL6H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsUHxWVQ9pn1uVdqIrgpTfjCGGtb4+YVBfEy6i5I4j8=;
        b=oQoLkvcCRqudhxNiLKvSe+6dZY4kWihTtDkb5WMO8lxHeSG+Rh1Ide8hTYfLRzCuI7
         3pH7VwPviaNtBr4nUGItTasTF1Pj9z8jS822U/PHV/cE7IQd+VEdX7U2A9Nwhu2rv8wT
         AiKvYaiQSODVSnGLwssoMynAKwiBjvp/NUS49LBE6NsfG2KCKk+Z76EV4EFOVax+T1ZI
         I06XoZ0TDKCU+gH2HW4+ou4fmuG3pNFBSZemx5vQFWoNXLOQFPJIM5bUfvkIRNxxhg4Y
         BJPsLUmbgyk8NFG4BnJUMK/bu9m/yvWdvArNlSkgFL93GrcMYwqJiYSq7ZCeFiY+R/lT
         zPSA==
X-Gm-Message-State: AOAM53292ZXHJARxEeKNZXWd3Tga4TpOOo4hGljh/4l3wTPYnVQXDXN0
        Eo3LdmCZb+zVs5wlU0UMjeP0vh3K1E5AwA==
X-Google-Smtp-Source: ABdhPJxbb8sd7UFcpHahh8CfQhFHJ9aXBiTX1R8wGue127uNq3+hWo8NeetW3zcEXohMqUbyasqCeA==
X-Received: by 2002:a05:6512:3253:: with SMTP id c19mr352576lfr.245.1612463594635;
        Thu, 04 Feb 2021 10:33:14 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id r21sm705674lfm.207.2021.02.04.10.33.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 10:33:13 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id v15so4559141ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:33:13 -0800 (PST)
X-Received: by 2002:a2e:720d:: with SMTP id n13mr421266ljc.220.1612463592842;
 Thu, 04 Feb 2021 10:33:12 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
 <161160687463.28991.354987542182281928@build.alporthouse.com>
 <CAHk-=wh23BXwBwBgPmt9h2EJztnzKKf=qr5r=B0Hr6BGgZ-QDA@mail.gmail.com> <20210204181925.GL299309@linux.ibm.com>
In-Reply-To: <20210204181925.GL299309@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Feb 2021 10:32:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg49zd_Z2V7+djV-sCVia0=Gv3GNWz6MYsa7vG16Ya5Sg@mail.gmail.com>
Message-ID: <CAHk-=wg49zd_Z2V7+djV-sCVia0=Gv3GNWz6MYsa7vG16Ya5Sg@mail.gmail.com>
Subject: Re: Linux 5.11-rc5
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 10:19 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Mon, Jan 25, 2021 at 12:49:39PM -0800, Linus Torvalds wrote:
> >
> > Mike: should we perhaps revert the first patch too (commit
> > bde9cfa3afe4: "x86/setup: don't remove E820_TYPE_RAM for pfn 0")?
>
> Unfortunately, I was too optimistic and didn't take into account that this
> commit changes the way /dev/mem sees the first page of memory.
>
> There were reports of slackware users about issues with lilo after upgrade
> from 5.10.11 to 5.10.12

Ok, applied to mainline.

Greg & stable people - this is now commit 5c279c4cf206 ("Revert
"x86/setup: don't remove E820_TYPE_RAM for pfn 0"") in my tree.
Although maybe you just want to revert the commit in stable, rather
than take it from upstream? Same difference.

                 Linus
