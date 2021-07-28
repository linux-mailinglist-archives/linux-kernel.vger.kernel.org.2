Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5603D854A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 03:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhG1BZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 21:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbhG1BZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 21:25:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD950C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:25:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i10so737825pla.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I9YVP5RX0vBBBsCMG86QASMr6cXEzun6YlfX+HWSrjs=;
        b=MU0RnqGudLR7gknZ7FIHPuqfil2ilE0hRRadTFdtG4HtxaWC2OyyYusSd52ajc8dTw
         Mvlk77Bv4nGjIFbYYoYKgu8MgXWpbQaNJh7GgdXfA+NMilLKlkI7OKNVrKT7JIYj1Wf+
         M3aJ+0F2DqpPKuFiuUAq6ApVvwAi2hLlzBVrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I9YVP5RX0vBBBsCMG86QASMr6cXEzun6YlfX+HWSrjs=;
        b=Iv4j1gK1sJL1OLO3qKYSxGcgMEHTcjS0wdd/czEoQ6pHBJp1wKMysIL9DwnyIXNY3h
         BfLCGDDPiyBQU8fh1x1P55P/5HFeT3bjt1MzvupKrXlhdGK+cGDInnm3A3Ff2QbA2L+x
         Mnhf6Sjs7eBR+mkMkGtUSYCupN8ktA4rH1KzDvQkRlMoLHe9YtYrYQoc2/F8GwBxMU1B
         s6t1MLuDpgMOeAXgNZvc0LfvMeLCHnsOdry7zdvxS8+u0LMJs7JWZMeEYWRkKa+fLTJ3
         vmss/TL69OfRnOjRm6LpP91Qq+TnnkuDzzbk7We7oxcE4lN3Yb+xIfZP3/rZpLEtinYD
         /2oA==
X-Gm-Message-State: AOAM533ZYx9sMApPpCl46K+dfeFq8eHLEOFoly2k0dvPXmu7+BNsdEvn
        l8f5O/UbLsd0h8ziKLGni0E4+Q==
X-Google-Smtp-Source: ABdhPJxEZknT0AREiVdChJtpNH4CYneo0pNG7xJHHQcNbXSPldRCqxrz+jlcqvjjmswHrJq4IVB6KA==
X-Received: by 2002:a17:90b:4c92:: with SMTP id my18mr24587795pjb.167.1627435524453;
        Tue, 27 Jul 2021 18:25:24 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:ba3e:509b:495:ec84])
        by smtp.gmail.com with ESMTPSA id 26sm4089204pjg.8.2021.07.27.18.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 18:25:24 -0700 (PDT)
Date:   Wed, 28 Jul 2021 10:25:19 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 2/2] printk: Add printk.console_no_auto_verbose boot
 parameter
Message-ID: <YQCx/8bvaJjoKLAs@google.com>
References: <20210727130635.675184-1-dima@arista.com>
 <20210727130635.675184-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727130635.675184-3-dima@arista.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/27 14:06), Dmitry Safonov wrote:
> console_verbose() increases console loglevel to CONSOLE_LOGLEVEL_MOTORMOUTH,
> which provides more information to debug a panic/oops.
> 
> Unfortunately, in Arista we maintain some DUTs (Device Under Test) that
> are configured to have 9600 baud rate. While verbose console messages
> have their value to post-analyze crashes, on such setup they:
> - may prevent panic/oops messages being printed
> - take too long to flush on console resulting in watchdog reboot
> 
> In all our setups we use kdump which saves dmesg buffer after panic,
> so in reality those extra messages on console provide no additional value,
> but rather add risk of not getting to __crash_kexec().
> 
> Provide printk.console_no_auto_verbose boot parameter, which allows
> to switch off printk being verbose on oops/panic/lockdep.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Suggested-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
