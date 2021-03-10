Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B633463E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhCJSFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhCJSEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:04:49 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B62C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:04:49 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id h82so18744607ybc.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6peS7EqRQJLG8LYxxltzToQEatyLDqjaW2EoobrbIeY=;
        b=iEmXIqR7mb6zEDBSyzKckp/le0WhKb2VRZgPO3UsUfdOw43JaP+Ilpj9tsSYxtGuY8
         lOsV/YVYc/jaG/KE+6yMDysn/RhpsfAcG0QqLhtmlOTQn7HmEhbvTnWKejAHZzqLMuRd
         lcmamUWwbem/PV6PSFVaFvWD4v+ni7GP4UK5Ys28YEQbpnlK1bZAltzznpQuUBO4vzRX
         BVpsubCx1X0SrojXViJrv1x5PMCKS9H+pDPRoDOEfcgq802RP1vgUUBmzJ1uf8w9Nrly
         UuboVIX00hDRQjRFaKWp/j2YXlaA5P6SGeJjP0noftGQQ0SeSoHHNECOdacZSnrP4XBa
         PyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6peS7EqRQJLG8LYxxltzToQEatyLDqjaW2EoobrbIeY=;
        b=iCrFuUqf3UmjN1/7VDLxG1DYNnrI040hFQatI7V+RjBE3eG0e8XU8GFSu4MSqDGS1t
         IGQYXUA+1xZFTXELpxEJX/95MX2dvAxFl5B8MrhxDl+ww9yC1hASvxyYFdNE8RxvQgAx
         gi0ZLGHN2MZ1qFUGXW3aAJw3YgOhXlPllaiF+5p2uq3bJdGk79SfPgph69cI+5RyJUGt
         ya3TOwGBUdLOw84W/BJZaB5pNyUpUjrZSiKKyDXokNTwkAI3/e0MDljMpl34LSVn2BpA
         3+caqmySOM3uV7qmV8vImxfx55egU1pbumEc0VrkN4whZMvVmE7NhtOypqTYgUcCS9/C
         DsPw==
X-Gm-Message-State: AOAM533bpqgGCAR7SiP67N59MJF2S9rnx2QJ9uVWyZQysmfAK2rLKJec
        jXVO3nxFTV9coMBrik1E2q1AeOX+CeDRcXo8g1Clv0lr6RQ=
X-Google-Smtp-Source: ABdhPJxNBheL9xiKVGnAFzvOB1e1TFrtoRSB7a1ogcHNCaYFo+sAEx77cflhiFOOBQfD0MO/uazXl3FKkIPex3qXgjU=
X-Received: by 2002:a25:e651:: with SMTP id d78mr6056810ybh.93.1615399488711;
 Wed, 10 Mar 2021 10:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20210208204136.sv4omzms3nadse6e@linutronix.de>
 <CANiq72mw47Qa9M6i23Dp+_3M8juBnv33PJ-6zFk++SV57G2-cQ@mail.gmail.com>
 <20210209090112.lewvvhnc2y7oyr27@linutronix.de> <CANiq72mG3zXA7j9KbC74hQ1BMgw713Hm3WDAcQBjKxgg0fLHeg@mail.gmail.com>
 <20210213165040.vzzieegx4aliyosd@linutronix.de> <CANiq72mkkSfbnNM_mmXE-TNKO1orsAeyByMKFy1N6hm+EBA40A@mail.gmail.com>
 <20210216102856.dnaycukt3oqxoszp@linutronix.de> <CANiq72mge40Uvqf3mb4uof2gi8ktvhjoodfyJY7uLW4guTnvDw@mail.gmail.com>
 <20210216182619.xd7h4uwpqcw5kcup@linutronix.de> <CANiq72np-G3whePohyYazx3KpP6A+DsRwq-bjd7E7qKb1JG62w@mail.gmail.com>
 <20210310175117.dqv7uufl7tplmgk5@linutronix.de>
In-Reply-To: <20210310175117.dqv7uufl7tplmgk5@linutronix.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 10 Mar 2021 19:04:37 +0100
Message-ID: <CANiq72=A7oERvngbH+UY-z1meefr6j+LLktzWKx3SjAjSP9dUg@mail.gmail.com>
Subject: Re: [PATCH v3] auxdisplay: Remove in_interrupt() usage.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 6:51 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> I assumed you are going to apply it but I don't see it in -next as of
> today. Is there anything I need to do?

Ah, since you said you were posting a patch, I kept this in the
waiting list. I will apply the latest one then.

Cheers,
Miguel
