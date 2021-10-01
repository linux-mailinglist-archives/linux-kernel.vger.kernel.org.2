Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF04841F23B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355101AbhJAQh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355097AbhJAQhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:37:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FF5C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 09:36:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so41068216lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 09:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jD7nwgHxMSeInUUrs6FJvRIyAdhMaTevfxCsu5BdLTM=;
        b=PpsqrsGdIFtn0KUPuJCzf5kI4Ojb7JegjF0BMY8LGcnxojJcyAKH5k+wMEqCTVCgzl
         1JQOIKyWlYlFXvLkV+P4j2KXRW+vn73pOipkMa/rdLBsfXs2C5ON06epk0gG2f0lb3JE
         TuSCdW5hFzBNhpbQQUh5N3vycq4ZQXUL7ShOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jD7nwgHxMSeInUUrs6FJvRIyAdhMaTevfxCsu5BdLTM=;
        b=myC6kl3MgNLFW5vspBORy8LiAsgFfDC6yXaSutrkHM5mR/sGPaBCY5S8Q7Zc0gbe8k
         zrfnRyq6CNvCVpzCK9vsxt2IB4YW5KLcH3EQOVUz/yKRYpNEERAQuuWPq/6J0WaTlyfG
         2Kl0IulpQ7RxNRK1+G9tyUdfiJ/XynrBpZg7ItIioz9XYXCTZEprf3U/K0hPhvnRc7MP
         50R9wgRIt0LVjoWPzg2a94FopTiXOF3f0XaSuLGta+Ki6/qtbtu2bDYZh2b+DHrq/qkB
         SBpfSmUPaoQR86x+Mbt1rbmddbpm7R8OGoZ9J8/5tIkGRu1NinITTzIGYhJcpvhnmLkt
         7P5w==
X-Gm-Message-State: AOAM5305mjiLYkemgjQ0ZmoZ67605iqsioCN05PDLX3njMD7SMcyyM0q
        ZD6GbHlnbVuJj4vET4fK+aEQRg7dr9mLybn+c8M=
X-Google-Smtp-Source: ABdhPJwKjMh/WQ+t7k+QQIiYq6ns/LCmD5Zang1Q0vIGZ61wKPoxuc/lUFwJL4bxzVKkzBLvw+DncQ==
X-Received: by 2002:a05:6512:1196:: with SMTP id g22mr6420216lfr.449.1633106168890;
        Fri, 01 Oct 2021 09:36:08 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id b26sm723293lji.128.2021.10.01.09.36.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 09:36:07 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id x27so40559389lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 09:36:04 -0700 (PDT)
X-Received: by 2002:a19:ef01:: with SMTP id n1mr6592631lfh.150.1633106163819;
 Fri, 01 Oct 2021 09:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
 <87lf3f7eh6.fsf@oldenburg.str.redhat.com> <20210929174146.GF22689@gate.crashing.org>
 <2088260319.47978.1633104808220.JavaMail.zimbra@efficios.com> <871r54ww2k.fsf@oldenburg.str.redhat.com>
In-Reply-To: <871r54ww2k.fsf@oldenburg.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Oct 2021 09:35:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgexLqNnngLPts=wXrRcoP_XHO03iPJbsAg8HYuJbbAvw@mail.gmail.com>
Message-ID: <CAHk-=wgexLqNnngLPts=wXrRcoP_XHO03iPJbsAg8HYuJbbAvw@mail.gmail.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>,
        akiyks <akiyks@gmail.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 9:26 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> Will any conditional branch do, or is it necessary that it depends in
> some way on the data read?

The condition needs to be dependent on the read.

(Easy way to see it: if the read isn't related to the conditional or
write data/address, the read could just be delayed to after the
condition and the store had been done).

               Linus
