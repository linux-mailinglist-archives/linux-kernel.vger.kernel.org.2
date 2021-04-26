Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC9C36B85F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbhDZRxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbhDZRxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:53:42 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6C9C061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:53:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q10so40546870pgj.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gkq+6u4aJWjana+PXPz3rfPaI7gy3M5AW+MTrSZjSuI=;
        b=vqiqLOsk2dEgQy7+23ndN1wQpZPqAHD+wDxz0ZRZrYh+cFzWD+WJ5foLguD7XIZHK6
         +6+rBVIj7TMDDSnQIgAixact0PKzg+n9vcaJLo8bFzOev4X01S6lhbVqGJd289HLo2+z
         FYbeLxSXyzJJ6HcDb0h2vKTSzEO2dK+E2BF3mutW4ruS+GMzbuwmDiKM5RmHOnq+dMzj
         7c4Lh+URI21ksUYPbp8FTR/fGQ7b8PcaAwta4r5n/evstC0LTa2E03WWkx+yA3xv0KMP
         PAJs55bCk1bQNGnw1coHihJPXSvfkdnLGkFW9UPRXIo9s3QJuPFqZmvoe9yaxT1XmrkX
         zE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gkq+6u4aJWjana+PXPz3rfPaI7gy3M5AW+MTrSZjSuI=;
        b=PuvTlevQox68b6qZCn2AARd1AlJFgycCpC9SUL44l1c8zkqIJxwdq7B7gTNm2TGvaS
         OuGVNt/8NlB28QH2Xpd4HxkSqBLyKv8oPDoX+LiJXLAFJKLiSqA9Y/qNfHQgcr+8dsG9
         lHKTSKblFN7L0VfsVSOBIzjFFroxD/gbHyTj8bgio8rvwx8YXGV6aY/ujIFOFY6aKOlM
         vl4SCha7zNVc+6foNQJ5oLxNYCwiRxHbnr1+LsurEb1HUfRy3fDo31VYhqyhUr6uwdql
         3w9XgAk5az+kseFeWho713iVl7pbYwyS1lTUa5aTrL5xkQvTdTfs7TpJKq0dQXH5y3r4
         uJkQ==
X-Gm-Message-State: AOAM533rMxxwg19kBPEZ+37Vq5zSQJ6/x/cspYYq9jn5f657ZZ8tglxw
        Iy0FoUrVT1Ya2l/YfKp/2IYCLA==
X-Google-Smtp-Source: ABdhPJxvjPWQjMf7Pn8gwf0tuAB3+nvT1SYTyeTv9FZcVPZwvXnTmeMqi8hqEfrRgFNRzVHU+QHgEg==
X-Received: by 2002:a63:4513:: with SMTP id s19mr17600647pga.34.1619459579958;
        Mon, 26 Apr 2021 10:52:59 -0700 (PDT)
Received: from localhost ([2406:7400:73:bf98:cdf4:fbe8:4446:3272])
        by smtp.gmail.com with ESMTPSA id p10sm293289pfo.210.2021.04.26.10.52.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Apr 2021 10:52:59 -0700 (PDT)
Date:   Mon, 26 Apr 2021 23:22:54 +0530
From:   bkkarthik <bkkarthik@pesu.pes.edu>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam <developer@arusty.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelnewbies@kernelnewbies.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drivers: pnp: proc.c: Removed unnecessary varibles
Message-ID: <20210426175254.g63l272o4hnagcs2@burgerking>
References: <20210422180322.7wlyg63kv3n2k6id@ubuntu>
 <ea09f455-a00f-a13d-29d8-e3f9790dba56@linuxfoundation.org>
 <YIZIHR0ZQPXFkOH1@unreal>
 <CAJZ5v0gRv-1qYiN8EXx12iOiJvX7ORzqQfHvtWDnZLtpg6Aijg@mail.gmail.com>
 <YIa3H6kGFXiqWRtg@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIa3H6kGFXiqWRtg@unreal>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/26 03:50PM, Leon Romanovsky wrote:
> On Mon, Apr 26, 2021 at 02:00:58PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Apr 26, 2021 at 6:57 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Fri, Apr 23, 2021 at 03:08:03PM -0600, Shuah Khan wrote:
> > > > On 4/22/21 12:03 PM, Anupama K Patil wrote:
> > > > > de, e are two variables of the type 'struct proc_dir_entry'
> > > > > which can be removed to save memory. This also fixes a coding style
> > > > > issue reported by checkpatch where we are suggested to make assignment
> > > > > outside the if statement.
> > > > >
> > > >
> > > > Sounds like a reasonable change.
> > >
> > > It is unclear how much changes to ISA code are welcomed.

If changes to ISA code aren't welcomed, should these be marked obsolete in the MAINTIANERS file?

> > 
> > Real fixes and obvious cleanups are, not much more than that.
> 
> While first part is easy to determine, the second one is more blurry.
> 
> > 
> > > According to the Wikipedia, even Windows Vista disabled ISA PnP by default.
> > > https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications

I wasn't aware until after this reply. Sorry about that!

thanks,

karthik

> > 
> > It is indeed unclear how many systems with this interface still run
> > Linux, but as long as the code is in the tree, there's nothing wrong
> > with attempting to improve it.  There's no assurance that all such
> > patches will be applied, though.
> > 
> > Thanks!
