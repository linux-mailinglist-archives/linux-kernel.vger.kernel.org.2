Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103223FBB1E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbhH3Rks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhH3Rkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:40:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6336CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:39:53 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s12so27366070ljg.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HeMMnCp0nlu/Sde0gJcxD0ub3PJKeMYmTJeH/ribw2o=;
        b=ciPa7I6WJu3/XM5+c+WaFTAVNWBLVA7Nqnv/66glKA+GWhiXOPLQhRl8U63zHWPjq0
         fQ+GA6m2t8Navpa1IoNtZhfcmOhqcNw0UtnrRRjTWrRWHURarh+C3Cj43ajLhJd7uBFK
         TPQ/GItuQ/8WBTsVN23YNvRQiKYvkPOYQUlco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeMMnCp0nlu/Sde0gJcxD0ub3PJKeMYmTJeH/ribw2o=;
        b=LWrLywTdnfUz+9mEyjXiwENdGIVEKU8J05d4ydCzvTxtpdAAnO0Kave2/QOZW3SE/S
         Cr0QRXdM++barGah6pcALtjHqsIsjxdjjM2xjK0WDJp8NzJZJ5+NE+1Oy4DVKyak3W0F
         pZvqdIwFLvRn0R2doRPztkiczTZBeN1Yy4UM0Ow3v2KVjpdNxar8BcNHIKoddDhmmMYf
         n6YULl+PeNKN6d0be9mj1IfkMq1896JtCx/BXLoBMdKilBpFdzQqTtvUQm+t28N3x0e7
         4vlPZfkm8o11IWv0+JQ4VAKNZWah9AhEm8tKsFcuE8wIUU2VFCY7dPbr1FoH/COaOcNs
         I0sw==
X-Gm-Message-State: AOAM532NZ8dwuhXswsjRnzIh48btB3kc7Chjh6PyWmUwoZ4M0741d8AZ
        8RZy9n3WFTCupWE4QFDdZkYyMrYQg0iCIUgX
X-Google-Smtp-Source: ABdhPJz7YPOMEt0CzqU5C+LNJlOQ5Ktx2ayYg7kyJ8735WP6NWbfcLCVvPjqv2/IiUUtFLrGRrOBkA==
X-Received: by 2002:a2e:91d0:: with SMTP id u16mr21692061ljg.324.1630345191219;
        Mon, 30 Aug 2021 10:39:51 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id k27sm777810ljn.72.2021.08.30.10.39.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 10:39:50 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id p15so27262520ljn.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:39:50 -0700 (PDT)
X-Received: by 2002:a2e:8808:: with SMTP id x8mr21999393ljh.220.1630345190373;
 Mon, 30 Aug 2021 10:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210830154702.247681585@linutronix.de>
In-Reply-To: <20210830154702.247681585@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 10:39:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWxv7baa91W_0CXFtG+FW_Obp5Y=4BqZD7EZ+nqcRvqg@mail.gmail.com>
Message-ID: <CAHk-=wiWxv7baa91W_0CXFtG+FW_Obp5Y=4BqZD7EZ+nqcRvqg@mail.gmail.com>
Subject: Re: [patch 00/10] x86/fpu: Clean up error handling in sigframe
 related code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 9:27 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The following series cleans this up. As a side effect the resulting text
> size of fpu/signal.o shrinks by about 150 bytes.

Well, some of the patches in the middle were confusing because of how
0/ERROR was mixing with a success true/false thing, but the end result
seems to be a whole lot more sensible.

Thanks,

             Linus
