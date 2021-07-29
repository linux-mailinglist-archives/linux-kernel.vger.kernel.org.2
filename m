Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170B63DAFAC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 01:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhG2XBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 19:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhG2XBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 19:01:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EB1C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 16:01:26 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r26so13980634lfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pY7m/Y43lyncS7WapXCMkLBirYxokclAcy/UGj99rQA=;
        b=XQtQEX/BG2JXB6WBNf/JB98ExbQAGG37D1sqjMTQzcAlbBF3cE9jO6h35na96096Nt
         9bLwxHZ0OUkMyTGxEIoxMov84KKm2MpsHsc39n6CfhXg+fMQAWyIBI3nG4bncuHMl/08
         g6bfAX7f+TIZ2iNmLpTBNrEuEjPlYNygVzzo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pY7m/Y43lyncS7WapXCMkLBirYxokclAcy/UGj99rQA=;
        b=p9RS4uMp41xb4D+IOEXXYu2145q3RsJnfN1Yc+U3r6XpWcKp28JYmOT+3Es5svt38E
         8XwOHUIoRImMUcKImVyPNHAu5XOOmeewiNYhyq9vY7iJ/yeVQXv970ynpDFKdS5Jzt11
         ekftgk2pttz0YLoO9M237cXaW3WWxU0uYvBSloxzTgIidoo8S0rsxfuLEqRri3GL9qiv
         QlJZh/bl19cqiVALS3QqZhfTfrSY79i8WuJdzQ9UQUZjyGj/Mzc8But68Za972EIYbcD
         jIs6V+CGAGpYJq2BXhKUvh+AxssZIWf1gtwxVEFR7nMm/V9Y6irp1v/GDgpHJpwUlF9I
         Yi8g==
X-Gm-Message-State: AOAM531c3ox81QO9bJddIFFKO2OghzwPJVTxOB0dwAJUcWbRrRliZ15C
        P0cN53IH/J4iJCvAH3n8IVqPXzeOzFx7fu16
X-Google-Smtp-Source: ABdhPJwNJSgQWUWYoy/vVdsx1NwlIEB+Aifw+xuxI8zEcY3bB5JwOBxlgD2VUnFtqmxPvv6JD3PzKg==
X-Received: by 2002:ac2:5e6f:: with SMTP id a15mr2020037lfr.234.1627599685054;
        Thu, 29 Jul 2021 16:01:25 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id k2sm463838lfu.250.2021.07.29.16.01.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 16:01:24 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id g13so13888608lfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 16:01:24 -0700 (PDT)
X-Received: by 2002:a19:c3c1:: with SMTP id t184mr5315383lff.41.1627599683697;
 Thu, 29 Jul 2021 16:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210729222635.2937453-1-sspatil@android.com> <20210729222635.2937453-2-sspatil@android.com>
In-Reply-To: <20210729222635.2937453-2-sspatil@android.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jul 2021 16:01:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-DWvsFykwAy6uwyv24nasJ39d7SHT+15x+xEXBtSm_Q@mail.gmail.com>
Message-ID: <CAHk-=wh-DWvsFykwAy6uwyv24nasJ39d7SHT+15x+xEXBtSm_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: pipe: wakeup readers everytime new data written
 is to pipe
To:     Sandeep Patil <sspatil@android.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 3:27 PM Sandeep Patil <sspatil@android.com> wrote:
>
> So restore the old behavior to wakeup all readers if any new data is
> written to the pipe.

Ah-hahh.

I've had this slightly smaller patch waiting for the better part of a year:

  https://lore.kernel.org/lkml/CAHk-=wgjR7Nd4CyDoi3SH9kPJp_Td9S-hhFJZMqvp6GS1Ww8eg@mail.gmail.com/

waiting to see if some broken program actually depends on the bogus
epollet semantics.

Can you verify that that patch fixes the realm-core brokenness too?

             Linus
