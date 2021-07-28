Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9446A3D8540
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 03:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhG1BVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 21:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhG1BVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 21:21:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF578C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:21:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so1874454pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qb6AmUun9APuPrgzQxqKUIOoVaaUXmZ7gAzLjwZEots=;
        b=J1d4jufgbTDIilvtvajEVip/DQBZZaoteqloKCVqCncgADyy/7p+Sy7M+xFjGsKqsh
         JsYLj4SGbO0kcXmd28grb1CRmsyQC30p/YzuMKh0/ymzJ+xogDXu1HRj6fCaJpHl+8cB
         VWP8qHJTf/lrWjQtW5woxf6YwW8OOv13pntps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qb6AmUun9APuPrgzQxqKUIOoVaaUXmZ7gAzLjwZEots=;
        b=e0qkT/S8A/xmyRusvgW/uDdOwyW4DShkSKsskhNrECuLQOaBuMB4rDSV/e5G5GzXEZ
         /mrdPsgJFY1LJCKTH2+mNGCf/mmdjjacwY7k2FWzBVKALJ/nSFxiDiLYkqq+LvRZNtNo
         zrpLPGdK+SYODh9DANvTZ6mTc+ZrMYUvc1Hxh6DlFQxJt4l4A6kFhvpmluZkyIaNVpyv
         WpOhxzVtP5qCPXzc29EbgEC/uqCYYg1u2EA3FMnuMvnSIrNhFthm8kqIa2uhv8cYZ04w
         ZCKqouG1Aui9TG2JLBdmmiJwPk0VjPCWoQWuI4lvXNstEbMfAl7kpfGf4192WNN28+c6
         XJ0A==
X-Gm-Message-State: AOAM532GfXy0J7AhijDeZtjlcdWWaGCltYjYnOsWbDhQFrX6LpcQEYtn
        NvRm3dNUEf1YdypD5BYYcQ1yzA==
X-Google-Smtp-Source: ABdhPJwiVrFwcUA4wc6qcaXZTfTgMANGRyCc4k5ykDEYlJd0wxkyOpdvIDZci6McVQSa8l1PIpzHCA==
X-Received: by 2002:a17:903:30c3:b029:12c:1bf3:68d7 with SMTP id s3-20020a17090330c3b029012c1bf368d7mr11610278plc.73.1627435294347;
        Tue, 27 Jul 2021 18:21:34 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:ba3e:509b:495:ec84])
        by smtp.gmail.com with ESMTPSA id y28sm5080048pff.137.2021.07.27.18.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 18:21:33 -0700 (PDT)
Date:   Wed, 28 Jul 2021 10:21:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/nmi_backtrace: Serialize even messages about idle
 CPUs
Message-ID: <YQCxGfFUMKfcUPgK@google.com>
References: <20210727080939.27193-1-pmladek@suse.com>
 <87r1fjiwsn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1fjiwsn.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/27 17:53), John Ogness wrote:
> On 2021-07-27, Petr Mladek <pmladek@suse.com> wrote:
> > The commit 55d6af1d66885059ffc2a ("lib/nmi_backtrace: explicitly serialize
> > banner and regs") serialized backtraces from more CPUs using the re-entrant
> > printk_printk_cpu lock. It was a preparation step for removing the obsolete
> > nmi_safe buffers.
> >
> > The single-line messages about idle CPUs were not serialized against other
> > CPUs and might appear in the middle of backtrace from another CPU,
> > for example:
> >
> > [56394.590068] NMI backtrace for cpu 2
> > [56394.590069] CPU: 2 PID: 444 Comm: systemd-journal Not tainted 5.14.0-rc1-default+ #268
> > [56394.590071] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> > [56394.590072] RIP: 0010:lock_is_held_type+0x0/0x120
> > [56394.590071] NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0xb/0x10
> > [56394.590076] Code: a2 38 ff 0f 0b 8b 44 24 04 eb bd 48 8d ...
> > [56394.590077] RSP: 0018:ffffab02c07c7e68 EFLAGS: 00000246
> > [56394.590079] RAX: 0000000000000000 RBX: ffff9a7bc0ec8a40 RCX: ffffffffaab8eb40
> >
> > It might cause confusion what CPU the following lines belongs to and
> > whether the backtraces are really serialized.
> 
> I originally implemented this, but later decided against it because it
> causes idle CPUs to begin busy-waiting in NMI context in order to log a
> single line saying they are idle. If the user is aware that there is
> only 1 line for the idle message, then the user knows that it isn't
> causing a problem for reading the stack trace.

I agree, but don't have any strong opinion against the patch.

> Feel free to add:
>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
