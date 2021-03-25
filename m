Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9961A349A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCYTn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCYTnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:43:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7398DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:43:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o10so4223555lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+rfCXMw7Ia35+MkG3YYSaEH5EyHrXL8XWZ5oML2YGPk=;
        b=Z84KI+gMz+ZuXDkBZLxeBsccvBv9x7Itvz6gYVLR5i/AiRsr1eRwDbto63Hft8YF2F
         dfvVQJuY5GdhrM3hTV1dbPh3VhCsWJZaPM4Mc7Aco3XAThjwpvbocKfJM7KDJE3RvLet
         w3UQqtNeYquPsnW4WlBmyK2PqnIMvsMs1aNBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+rfCXMw7Ia35+MkG3YYSaEH5EyHrXL8XWZ5oML2YGPk=;
        b=jIzi9Tz+CUY2WAzOFaPRRikLwj5fD0j9tsN/HMily6Ul6tNXjadPqE7tFMBp/DlGsf
         F8vRg1hiT4D/ihjKX2DIK3yMPZl4FIFIrkFWEBYyX1tQIhQdbNZ6mYCCQTeQbiCvvDCT
         unt8r5Rd6zUCoMMNC6Br24EBQft/MnJeARJ0K780XNexY4G4IJQMbS7nW4YA5EFAmXpJ
         UZVN8duRR+nOGREvdeiwghku8JDJVltUovNZ0itgQr0xmg5TQFG+lLSezqyZiF18RSSB
         l1A+I10Q0VdnUUanG/ROboc/FKENQRSUGotLSh5rqtXcuo2MLjHG9AaDn3dgmmvEgq87
         cB9g==
X-Gm-Message-State: AOAM530eykTte194JaW79eZDcgrBhyR0BSsRPxaC2lonSs6g68uGH3kk
        r4Az2LCWJEzlRPEN64Gqh4orMrJO82FjdQ==
X-Google-Smtp-Source: ABdhPJz7g7czC4A/p8xWNWgownr+/v/cw25ZFFe6pYaWtbzsAYJGailBreb27IkGl7H7upCDbgoMww==
X-Received: by 2002:a19:c3ce:: with SMTP id t197mr5815090lff.351.1616701395727;
        Thu, 25 Mar 2021 12:43:15 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id m20sm875621ljj.93.2021.03.25.12.43.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 12:43:15 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id q29so4237316lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:43:15 -0700 (PDT)
X-Received: by 2002:a05:6512:25a:: with SMTP id b26mr5948990lfo.253.1616701394782;
 Thu, 25 Mar 2021 12:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210325164343.807498-1-axboe@kernel.dk> <m1ft0j3u5k.fsf@fess.ebiederm.org>
 <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Mar 2021 12:42:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1XpX=iAv=1HCUReMbEgeN5UogZ4_tbi+ehaHZG6d==g@mail.gmail.com>
Message-ID: <CAHk-=wg1XpX=iAv=1HCUReMbEgeN5UogZ4_tbi+ehaHZG6d==g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Don't show PF_IO_WORKER in /proc/<pid>/task/
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Stefan Metzmacher <metze@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 12:38 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I don't know what the gdb logic is, but maybe there's some other
> option that makes gdb not react to them?

.. maybe we could have a different name for them under the task/
subdirectory, for example (not  just the pid)? Although that probably
messes up 'ps' too..

          Linus
