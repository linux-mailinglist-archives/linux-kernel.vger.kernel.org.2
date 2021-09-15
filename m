Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9140E40CB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhIOQw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIOQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:52:55 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88F7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:51:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i4so7318374lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+Ub0zI6NViK2Hb3gMx+eNNcpf1q5YJWdKqTQu85yko=;
        b=CWZGe87pztKVInbNUX8YurCZzrlM6Se8hHWVzIfmhTef4A5v/eRrX6+s74fox/+3D7
         VrGVh8ArOnfzc2uzDSCHJeF0PGTN3OfGDXvZeRXSAJlj6w9PH6MbZKH3xo0c0N3/g2WU
         8HBmeBpjQLiIBNigxXb4/ZZeeCHoZPNAZo7HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+Ub0zI6NViK2Hb3gMx+eNNcpf1q5YJWdKqTQu85yko=;
        b=nM9WpVev8gaexZ6NWSKbWN31lEaIqI9X3BSMX1WPlVrnuUzt7/XdpYhIEyC3FfhL6Q
         Als/VibA+NETyv/N9toMjQyxnoPM2zcm/Q7nkcGE7++vt07KGbSThF22BCVGJi8+nn17
         kwjNnAnkOrn5zZpUaOgPYyB97DbX4hsUDufCzGlXJGXlUv1Cnder5/rlhoHEitjrWdFr
         2PCnR3XNraOIsBLCvfPHfrsrjn2z7CJrLKPxTcBQ1+dUQzwIPdl+BW6xX0/L2P3RRTfC
         vfExlv6Urkf/Nn52QwfQoRlH95BvYEfJsmjp7SUjDcdnxoXNi895Cq8vWbL2f77kV3hX
         KRSA==
X-Gm-Message-State: AOAM5306Q6ekMZWszOYadyi6jnvTMAzIHLi34kbsn0NmEzy2kTRJRRPj
        LkQVmz2bh4HVlOvovfvPvT9S8/zTSSumHMa4s3w=
X-Google-Smtp-Source: ABdhPJzpmYGeI6Su/sxCwtd9EDQGGudzofjYzsN3pcxNWT06zO2THfOal7F67EEfYaH+O5bxTnOkMg==
X-Received: by 2002:ac2:48b7:: with SMTP id u23mr661692lfg.51.1631724694077;
        Wed, 15 Sep 2021 09:51:34 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id n3sm29475lft.63.2021.09.15.09.51.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:51:31 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id g14so2222422ljk.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:51:31 -0700 (PDT)
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr811514ljm.95.1631724691135;
 Wed, 15 Sep 2021 09:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <163171196689.590070.15063104707696447188.stgit@devnote2> <CAHk-=wjtP5U-jr7cpTS78iqyh6rys15-Gf0VwoqngNNH1AQH8Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjtP5U-jr7cpTS78iqyh6rys15-Gf0VwoqngNNH1AQH8Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Sep 2021 09:51:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=win5Syn-=2viR6MHCBnhBNh=wj2c189pa_=-9g3OdMEuQ@mail.gmail.com>
Message-ID: <CAHk-=win5Syn-=2viR6MHCBnhBNh=wj2c189pa_=-9g3OdMEuQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] bootconfig: Fixes to bootconfig memory management
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

On Wed, Sep 15, 2021 at 9:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, I'll apply your trivial fixup for the bootconfig copy of
> memblock.h, and forget about it, and then if we end up having more
> problems with it later, we can look at a bigger fix.

Just to clarify - I applied that build fix directly to my tree, but
this series of leak fixes I'll leave for the tracing tree.

             Linus
