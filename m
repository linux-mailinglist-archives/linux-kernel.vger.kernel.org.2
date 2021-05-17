Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39570386D59
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbhEQW6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhEQW6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:58:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A460FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:57:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h4so11227281lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYz76vvOQIMM6SrX4l88lIYdZpLN3XWg15Hgm7f4ceU=;
        b=NLHw1riAvwu7Scu+cmJqT7XAYkqchfVnwO5voIo3dsIFFmSJmu1PNKVj5LqzAtP7nD
         DRrEaD1eY1fwca+IvXwXyATut0Jmb4I9f9vGiM6J05wcQgGhsv7JHO9uHsLfpEpUvFBz
         0krodD+1HLIgtQheZwT2hfw8rJXaYG1Xowi5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYz76vvOQIMM6SrX4l88lIYdZpLN3XWg15Hgm7f4ceU=;
        b=WLIDebT35v5R9B5E5/SNR3l0s9hxxxIBvpdjMjsobf/xAN2nREkSoQbJMiP4PS7Bhd
         gT7axfwW9bt48gtsdaoWmZRGQPRvbVPsF/N1bJaeMmcHcGNPXq8yulBNqyarLliTFgv7
         wzFK6d1q0hl699HyZnwWfddiA9eZtbbf6uJCMyR5kllOKzuEZFuiRrV64khpwrXOWpfQ
         TUvklyiYimEqANnkpaGyfZlLrT7gTXaj859BZbadiJ6r4DBBt/f77HdILXAxPl2bAH7j
         T/E9elHesRnsVCQU6UpBQ2Mvr9YScxlJtiVwfanc3nngcvRYmYAPk/ekW5r3h5dtK8IM
         I2Ag==
X-Gm-Message-State: AOAM5318uMNW01HP654h9IhUx2U5O6pi6r809Q1VYChKPk83nd4xOlMX
        NB3eF3tNn3IozNNmtnfleisajldLNNyGW8rn
X-Google-Smtp-Source: ABdhPJwqb6RFgGKyUauIi3w6cMN0JNn0a4s3wAC79r9qOOOUW6Fl5UwIHT/WzM2VOBG5KgnCBYBJ+A==
X-Received: by 2002:ac2:44a7:: with SMTP id c7mr1542020lfm.332.1621292241683;
        Mon, 17 May 2021 15:57:21 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id q2sm170229lfd.84.2021.05.17.15.57.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 15:57:21 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id w4so9195804ljw.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:57:21 -0700 (PDT)
X-Received: by 2002:a2e:968e:: with SMTP id q14mr1372889lji.507.1621292241133;
 Mon, 17 May 2021 15:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgX-4PTGAH7kRvqHYiq9wPJ-zN6jhLsuOAj6cG__g9N9A@mail.gmail.com>
 <20210517135653.GA2116459@roeck-us.net> <CAHk-=whUsAw7g6x4ianP1VxsADr1b+fitmQ2qecrq70d9r3ZJQ@mail.gmail.com>
 <063c62bc-e97c-72a9-491a-2de30b0b2b6a@roeck-us.net>
In-Reply-To: <063c62bc-e97c-72a9-491a-2de30b0b2b6a@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 May 2021 15:57:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBxR-o5qrEithLunG1oWRJeomY2fnnaqv9H1dW7+9+OQ@mail.gmail.com>
Message-ID: <CAHk-=wgBxR-o5qrEithLunG1oWRJeomY2fnnaqv9H1dW7+9+OQ@mail.gmail.com>
Subject: Re: Linux 5.13-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 3:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Huh. I must have had a severe lack of coffee this morning. This is the correct
> test result for v5.13-rc2:

Ok, good. You had me worried there for a minute.

             Linus
