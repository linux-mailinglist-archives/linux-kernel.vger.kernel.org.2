Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7234B44C9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 21:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhKJUGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 15:06:34 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:38607 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhKJUGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 15:06:32 -0500
Received: by mail-pl1-f175.google.com with SMTP id o14so3938506plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 12:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cIlvWeNZo6S7NB8/mVE36tUxBBajUlrl42axwAlyXyk=;
        b=y3lN9Y3JBlj76sfatOaUu7KsLt8qtux1HF8aqbfA3CzQqvk7ml9qXM7sw8V1BETmA9
         7Kn3WuD9DlnDa6a1SMHYezqB0ckei9+YvuKioVct8ZDjiyxWl4z/kThmfoOYSjIehV3P
         waQOpSzO6XfuTxNdYw0+i06rwwQrg8rsArjjaU6yVq4f/sBinBGiN/YSLbV87tV6a3rG
         BOzdIhWb5ufZ7TlmTwfHgPeDZ8EWnrnHtxUnDpD5TUhWSSJSKpTm3M2zXvSiDz0E35qt
         pKfDYxVrXgot5UGYUNEI+Hk3qvy4DPQV07tCHWmRbpnkgV5NC4JxiKKI5xuKNRIMjoSp
         2keQ==
X-Gm-Message-State: AOAM532RIJW+a7og+C+ZhUXfkcw5m0MJcGgJchxY7Lnq/9PVirJOtIKN
        uQv7uy9Y8IC86OtFHVA4lKL5ceOYyw8acQ==
X-Google-Smtp-Source: ABdhPJxbf0ym4tQoEUXmUhiY1kni30w1bAq/gA3YYv9+uo4kA2qpDC0AcveRpv3V8lpBfX+icly3mw==
X-Received: by 2002:a17:90a:ce02:: with SMTP id f2mr1771441pju.77.1636574624742;
        Wed, 10 Nov 2021 12:03:44 -0800 (PST)
Received: from sultan-box.localdomain ([199.116.118.235])
        by smtp.gmail.com with ESMTPSA id e7sm317936pgk.90.2021.11.10.12.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:03:44 -0800 (PST)
Date:   Wed, 10 Nov 2021 12:03:40 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Ben Segall <bsegall@google.com>,
        Colin Cross <ccross@android.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, mkoutny@suse.com
Subject: Re: printk deadlock due to double lock attempt on current CPU's
 runqueue
Message-ID: <YYwlnEQO0raDwS86@sultan-box.localdomain>
References: <YYrU2PdmdNkulWSM@sultan-box.localdomain>
 <20211109213847.GY174703@worktop.programming.kicks-ass.net>
 <YYuS1uNhxWOEX1Ci@phenom.ffwll.local>
 <87fss4wcgm.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fss4wcgm.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 11:13:37AM +0106, John Ogness wrote:
> Even after we introduce kthread printers, there will still be situations
> where direct printing is used: booting (before kthreads exist) and
> shutdown/suspend/crash situations, when the kthreads may not be
> active.

Although I'm unaware of any ongoing kthread printer work, I'm curious to know
how a kthread approach wouldn't employ a try_to_wake_up() from directly inside
printk(), since the try_to_wake_up() hit from inside the fbcon code is what
caused my deadlock.

Sultan
