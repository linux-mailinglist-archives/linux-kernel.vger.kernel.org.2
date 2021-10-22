Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FDC436F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 03:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhJVB2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 21:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJVB2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:28:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B67C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 18:26:29 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n8so1116016lfk.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 18:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xsse017yN+jkMYes04rg2vRNZrdXOO+9AoDYRJcoNB0=;
        b=HXZBHWUILKGBBp+ASfl9+L98u4U5JmA/qy7gmck+obzjGzUEWOcb27CFDOdWB2dJtE
         9doENDMvg4//R+470Ff8JeiR+WnSlrMV6yOHE+/n7kqinMrtUn7Sbn1UT+WIwat4s6px
         0EkeYrJlcAKDwpqfG6x4+0SML0r6RrLrSlREE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xsse017yN+jkMYes04rg2vRNZrdXOO+9AoDYRJcoNB0=;
        b=eNs8NsRapgJV36CDIhvF3En8f8ahz6+Z1ghxWMm8KUGklr5oBHZf3U/LxSOWHAZmC7
         VJgKWup50lM5zwCQQt+6/dxX/pzeaxxOEqTvs9nlP6oYreOq9TXyx+erQ7ijiT32+sLU
         fzz4c9WnZvAwmpgHyj9Ry4DLt33K+yXLhwAZZydbXdwn91bJAC4dP6qeN5HP6pfMTjQE
         vZZc+MIAX5i70RxslbQE5KvLU9+swnxNYU6bYqOXDBLKJz9ZPVDWxTGW6cvZHyyhkCXh
         7oImJycrBaZ7Yxrr3JWu/oKVxrRerrndoXAUrJQSrdB8sNlmKuIkfQZ4OqxJOj/IKYuD
         yhag==
X-Gm-Message-State: AOAM530/O959tqNWcpiyFM4WrA/jNlCcabGzX+xZkeAc4mSLzZRilHLM
        TAjYo+DNJZZhb5nxRhOcAePHe6wngNWPjtl6
X-Google-Smtp-Source: ABdhPJzsmvlNcB7RCmD2wa4AHJH0d61O5XV3aHOiKsq7fa/SkE3OJWFJa8XlbCNVfV8haLUxubc1sQ==
X-Received: by 2002:a05:6512:22c5:: with SMTP id g5mr8318010lfu.646.1634865987409;
        Thu, 21 Oct 2021 18:26:27 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id bi3sm588058lfb.84.2021.10.21.18.26.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 18:26:25 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id u5so401769ljo.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 18:26:24 -0700 (PDT)
X-Received: by 2002:a2e:9945:: with SMTP id r5mr9947488ljj.249.1634865984245;
 Thu, 21 Oct 2021 18:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211021180236.37428-1-mark.rutland@arm.com>
In-Reply-To: <20211021180236.37428-1-mark.rutland@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Oct 2021 15:26:08 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj7i-c-b7iYuZKJj4phZnca9bmNvRDoedkze+_dd_uYuQ@mail.gmail.com>
Message-ID: <CAHk-=wj7i-c-b7iYuZKJj4phZnca9bmNvRDoedkze+_dd_uYuQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] irq: remove handle_domain_{irq,nmi}()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Jonas Bonn <jonas@southpole.se>, kernelfans@gmail.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        vgupta@kernel.org, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 8:02 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> This series reworks the irq code to remove them, handling the necessary
> entry work consistently in entry code (be it architectural or generic).

Thanks for doing this.

This is obviously a much bigger patch than the original, but this
really feels like it's the proper fix, and maintainable going
forwards.

Obviously the big issue is testing this all, but I like the patches
from scanning them.

                  Linus
