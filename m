Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40B940BCFB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhIOBP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhIOBP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:15:28 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C37C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:14:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i25so2476625lfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YA7y9iBKi4yP4Rc/YesTbY6E2GjKmwv9lciu9v4UGxI=;
        b=UJuU81i1X1Vwx6sKy1nzNsRQdWA6iHFqLZo4hx/3uL/+A4fAVnd7gPryxK5koHCLvr
         b1PsJbA+x/bBSxtxnMa4xe7D9L7nw2ZXezaqqJHBcwaLE5s5u3GuZq5GJHv2nwdfasHF
         lIgFDigAQjL6M1oRTS8liK5ZTYXkIKCvimlK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YA7y9iBKi4yP4Rc/YesTbY6E2GjKmwv9lciu9v4UGxI=;
        b=OoOkhaArHuHmYYbLAx1WBG+kXDqkigUOgNL/d7cCweNaR+TXHrTFNjqoF5onTDrANT
         GDl3ZPTIH8PS0Ejps0dBnhVn8vQN9BzoNuG+XEzNZRjgmFhxRnb08kYLLUxwCjSAG3WY
         hkJ+uzYsdYgfdtYN7rAGIoRC3srCMKobfiQ3zybhfqwtZru1f4RaSW04gNYqVUjk31W8
         HKBzBmvUPrnwxB1ZzYCcs+kQBbwg0VmA+rjl9v0UQv1znQuxcwurR+cb2HxEqCmNTFHB
         w3AZfU8xGdBW/jhiMiPJlF8DX2FPaB1M3POhXWE8MA3IZCokk404+u6/vsHRKaulup9H
         7bYg==
X-Gm-Message-State: AOAM533lMtFxOFmOp50Ljm6MGImoR8O0rI5RI/CDBBBEL3D1AuGOb9dZ
        rARwditzM4NJ9RXfROM4acRBCc27zrBGsewOFd4=
X-Google-Smtp-Source: ABdhPJwQv9zRn1kdSyp4qlizMvSjgMRaql3tv5EHmOZoGTnTSNi9nYuMu9Hoetp673VUEShm0tf11g==
X-Received: by 2002:ac2:4ecf:: with SMTP id p15mr15081391lfr.2.1631668447723;
        Tue, 14 Sep 2021 18:14:07 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v4sm1516760ljn.88.2021.09.14.18.14.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 18:14:07 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id j12so2050898ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:14:07 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr17384664ljg.31.1631668446766;
 Tue, 14 Sep 2021 18:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <163166717752.510331.12843735095061762373.stgit@devnote2> <163166721027.510331.6820619440348067061.stgit@devnote2>
In-Reply-To: <163166721027.510331.6820619440348067061.stgit@devnote2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 18:13:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigVUWvHaJKZNW+VTKWLQxCvOpoysuXQTYjO6b7VZ3GJg@mail.gmail.com>
Message-ID: <CAHk-=wigVUWvHaJKZNW+VTKWLQxCvOpoysuXQTYjO6b7VZ3GJg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] bootconfig: Free copied bootconfig data after boot
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 5:53 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Free copied bootconfig data after booting kernel because that
> data will not be used anymore.

Don't do this.

You have already passed in that 'copy' to the xbc code, and
xbc_destroy_all() should just free it.

Don't add new pointless variables to keep track of state that somebody
else already keeps track of.

           Linus
