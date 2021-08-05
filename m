Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C363E1A49
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbhHERUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbhHERUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:20:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DDEC061765;
        Thu,  5 Aug 2021 10:20:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c9so7513053wri.8;
        Thu, 05 Aug 2021 10:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yewv8eLDuGQeemlSPQSqp+7rB89rcOX4qDuzzTlqfT8=;
        b=EsowHEOyEYYrO9vnkTAEE8IY9xW1VG4R14262m++D4LfZdV/Aj7s3UlE2WKcuz2mFz
         MzW/pNBbbBDnPK2q3yGTwqs4TBr04kU1+bnOFW4xPtcV2PcASq5Mig+iXVaBIusf2bs2
         jpv85JF/RDxHA6QL81xnes3joy4MYEUeQJFdwrujN3ThNPQSSx1w8ZPjRChaE6wpvF4c
         ixAYbvjs7qWGmWc0JMfhE13FaHlHBlCnawj0w1c0jTzfAXV8J7HFUyxzJx9SBYhYBXiD
         fQueO7HqbgcldgMjOuvg7871gDH/TixuNQcwiicG3A4dNA0eJGIR0EKnMq79DDq/Om5g
         2n3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yewv8eLDuGQeemlSPQSqp+7rB89rcOX4qDuzzTlqfT8=;
        b=kW5FtSvPfomQWNNWTtlmBmcEHYfNcYOFTE+zGckzHrSELvI9f7Czgh7E9b9GmwceE8
         /rzLKwjo+1F5WNsPoXBOu9ewFEOruxQyXjAxDRMfzosK2cavufNIP5tM/kpCuxmLlPLG
         x+zjqwrEzFu7vVeaqzwsbydAKgukz6efMPO+z0Q9+6k9tVB28SOSLeKcPJFY7jK18295
         YaqMfQ29YNGqXXCCwc5G9OM54cvCgIhgyMiLOj81fPmXlN3U7mUozedWyWY9+IdXMGJP
         zoz3OM0a0O+IY71RZpGdSCcGXSuoyhOrJd+Jy6oKhM23juBrbD6/vln/TSI8JUuDd0eu
         B2zg==
X-Gm-Message-State: AOAM533qVSQ2FFdKZJXEs/jpoKy9dqmJiXVSYMUqHnH4k7NBacM5k+vD
        aFsRVA/1QYNvTfLFTH+l30I=
X-Google-Smtp-Source: ABdhPJxCiTfqldjm4hmLDiEc6fvPdlmv3Z2zkV8UiudjVMrbhWeJgGjYXREJlzrxpvyDVmrlFQL0Fg==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr6555518wrp.54.1628184028927;
        Thu, 05 Aug 2021 10:20:28 -0700 (PDT)
Received: from precision (aftr-62-216-202-140.dynamic.mnet-online.de. [62.216.202.140])
        by smtp.gmail.com with ESMTPSA id d7sm6872606wrs.39.2021.08.05.10.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 10:20:28 -0700 (PDT)
Date:   Thu, 5 Aug 2021 19:20:26 +0200
From:   Mete Polat <metepolat2000@gmail.com>
To:     Davidlohr Bueso <dbueso@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mete Polat <metepolat2000@gmail.com>,
        Jesper Nilsson <jesper@jni.nu>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] rbtree: remove unneeded explicit alignment in struct
 rb_node
Message-ID: <YQwd2puXiSiUWEE1@precision>
References: <20210805133213.700-1-lukas.bulwahn@gmail.com>
 <CAK8P3a3aNuxaEtAiewd+Wjc8hKtca0NrcV2kykkNC-qKT_HhzQ@mail.gmail.com>
 <50ad4c8b848bd371b4b42959167ef03d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50ad4c8b848bd371b4b42959167ef03d@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 08:02:28AM -0700, Davidlohr Bueso wrote:
> On 2021-08-05 07:02, Arnd Bergmann wrote:
> > The revert would appear to change the alignment to 16 bits instead
> > of 32 bits on m68k as well (not 8 bits as on cris), but I don't know if
> > that
> > can cause problems there.
> 
> Yeah I tried this a while back and it broke m68k, so it was a no go:
> 
> https://lore.kernel.org/lkml/CAMuHMdXeZvJ0X6Ah2CpLRoQJm+YhxAWBt-rUpxoyfOLTcHp+0g@mail.gmail.com/

The problem is that the field '__rb_parent_color' in struct rb_node is
storing the color AND the pointer to the parent node at the same time.
The color is stored in the least significant bit which is fine when
rb_node is at least 16-bit aligned. I guess, it does not work on m68k
because the makro

#define __rb_parent(pc)    ((struct rb_node *)(pc & ~3))

used to retrieve the parent pointer zeros the first two bits, not only
the first one.

Maybe the effiency to store this one color bit in another field was
required in the early days but I think moving the color to a seperate
field is really the better way to go. It also makes reasoning about the
algorithm easier.

I will create a patch.

Mete
> 
> Thanks, Davidlohr
