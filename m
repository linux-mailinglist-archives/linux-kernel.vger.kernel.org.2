Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE84A374806
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhEESdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbhEESdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:33:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E45EC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 11:32:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c11so3959566lfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 11:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DF4x2E+X/2I3MS2ylkXmeNQV4Ts8V9J13dnhgpIp/sU=;
        b=DDkq2BCKRi6rk7V1qAqA24p//4BHtkwFtOKJZBqgTEk4smbiKh0NDcFIYn626jBp9y
         /jzf1eJHx2xcd9c7nlDaDKpysaAKcku4PC1OcTdIrmi9f/cPJw7nHlL0ep0G3lQmqpEJ
         Hj8JkiG8deVRaI6X8y7bgHkkx6XJ6jrM4mP4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DF4x2E+X/2I3MS2ylkXmeNQV4Ts8V9J13dnhgpIp/sU=;
        b=pshXwvmUEolmTQwClemL9xlGtz3raLxGO8SqDG66umE76rQNY1LRVkqBBuAOMUyNwJ
         JFcMRbxG9ru9pvq40a2xKVWHOBwx8KjyYh13W/DlqbiSc4YpDgXalWWW4V+qjutkUvrp
         lOx7GnFN7bXUSChVsosgbQIKDgsl/LDUVIYX+d5x2CeYYyyjzOZeLQ+ShsnvhtFL/EaK
         m3+2TZ012zjF4zncdsJKYNBsdKfOHtn2AHku4LsBnNRPc5qzd/H6EPoH7hZAGT6jfKeS
         RyywqskSEYNjTwTlJrSkNnRO/hn/Pixi5krltIeLx7Qmg+luuwg1nxMGRtyUK/fgdvRZ
         FFXg==
X-Gm-Message-State: AOAM5326MibXsatjI5E4ZHn0ClsqLp6ty48hhNBELKlLhGbkWA1I6/A2
        Aamb42Vqfnqx/hDn51ElOy+qQcSffCoPl7dr
X-Google-Smtp-Source: ABdhPJwM2zu8508Cf5te0aQm7D4n3aBrXt/BdyTMp+7P2KJFvhxWXpEry9jduIV7iehJhYCPK1ygwA==
X-Received: by 2002:a05:6512:922:: with SMTP id f2mr126906lft.171.1620239555773;
        Wed, 05 May 2021 11:32:35 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b10sm42822lfb.183.2021.05.05.11.32.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 11:32:34 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id z9so3957850lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 11:32:34 -0700 (PDT)
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr151048lfg.40.1620239553933;
 Wed, 05 May 2021 11:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620186182.git.jpoimboe@redhat.com> <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
 <2f75c496ac774444b75ff808854b8e5f@AcuMS.aculab.com>
In-Reply-To: <2f75c496ac774444b75ff808854b8e5f@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 May 2021 11:32:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-a6B11tH3upLG+-P5_yFPs3PB8tiXO5JKaQjUvhOMYg@mail.gmail.com>
Message-ID: <CAHk-=wh-a6B11tH3upLG+-P5_yFPs3PB8tiXO5JKaQjUvhOMYg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess speculation
To:     David Laight <David.Laight@aculab.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 1:48 AM David Laight <David.Laight@aculab.com> wrote:
>
> This would error requests for address 0 earlier - but I don't
> believe they are ever valid in Linux.
> (Some historic x86 a.out formats did load to address 0.)

Not only loading at address 0 - there are various real reason s why
address 0 might actually be needed.

Anybody who still runs a 32-bit kernel and wants to use vm86 mode, for
example, requires address 0 because that's simply how the hardware
works.

So no. "mask to zero and make zero invalid" is not a proper model.

            Linus
