Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D613A8337
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFOOvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhFOOvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:51:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6242C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:49:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x24so21889403lfr.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YyEZLduH7/iFgJwKc9vp/hqM3Vrl8HD6DqfsbR4sDVg=;
        b=HprZFfL4N7GTrn8vzzdG12NKJmO6iMJi+xyICKDRcSKmjzKtel9myIFjJw+b/IqOei
         66xHWiWeVwCuAn9OGrcgF1N0Ubrlt+z1LoJA1YKBS1nPPucqAaEIoAv/rXFNEUogqMR6
         xyEDcW2Pf1Ls1yhJOp8n844CnafVRsw4Toy54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YyEZLduH7/iFgJwKc9vp/hqM3Vrl8HD6DqfsbR4sDVg=;
        b=BZuBtgnTVT0tsnrLmLI5MKgDPbC9PIhzQhst70wK82sZdVCHIaSzBA9JeWnD6ycZ+I
         OMctwcvaCS79RpyfXCUSKJQf1F+/tM62hCJ2qAEG4YWVNtoP0r/iI3PzA0Y7GzZun3I6
         XvUEEFi8TrsVeHzyR09yAgpPL/Q5tH3x3N7x//ew7qZ1IoRH6F4tAc/DwH5a+A4kec8a
         tIl3H1njrmhlZOJeocZV8DJJUzTG6ueOi6qIKd/FFDfuLKALPyjlFnuxUB3f5xwz1BqF
         F6k9S70m1cqktI4a81P8zRGaJqVqNCsD1JGpGXZKgarWEj/ktO33qub7+kavzHnC10Jc
         seMA==
X-Gm-Message-State: AOAM531ppfACOH+4Xl4yGTTdISwIQKQ2ai4R7U0e20XJrufZycP5U0DZ
        6xoi2O4JOrzyNJlXxY9vl/xirpU2Lp3Fh7llQEc=
X-Google-Smtp-Source: ABdhPJyfiWXVkZIVRrIiYUxumCrCRMBCGan+d1JZx72AQNJeYSTEdKkkbws8rPsrScZeuf/PleuniA==
X-Received: by 2002:ac2:5e36:: with SMTP id o22mr16648115lfg.320.1623768557048;
        Tue, 15 Jun 2021 07:49:17 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id d9sm1826835lfv.47.2021.06.15.07.49.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 07:49:16 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id p7so27529387lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:49:16 -0700 (PDT)
X-Received: by 2002:a05:6512:3d13:: with SMTP id d19mr15953159lfv.41.1623768556044;
 Tue, 15 Jun 2021 07:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
In-Reply-To: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Jun 2021 07:49:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com>
Message-ID: <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com>
Subject: Re: [PATCH] afs: fix no return statement in function returning non-void
To:     David Howells <dhowells@redhat.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tom Rix <trix@redhat.com>, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 4:55 AM David Howells <dhowells@redhat.com> wrote:
>
> From: Zheng Zengkai <zhengzengkai@huawei.com>
>
> Add missing return to fix following compilation issue:
>
> fs/afs/dir.c: In function =E2=80=98afs_dir_set_page_dirty=E2=80=99:
> fs/afs/dir.c:51:1: error: no return statement in function
> returning non-void [-Werror=3Dreturn-type]

This warning is actively wrong, and the patch is the wrong thing to do.

What compiler / architecture / config?

Because BUG() should have an "unreachable()", and the compiler should
know that a return statement isn't needed (and adding it shouldn't
make any difference).

And it's not warning for me when I build that code. So I really think
the real bug is entirely somewhere else, and this patch is papering
over the real problem.

               Linus
