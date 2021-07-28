Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7BE3D8545
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 03:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhG1BXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 21:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhG1BXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 21:23:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7BEC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:23:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so7580939pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ig4qN9lSKY4uKAkOlIGr5lSNEclLXQYYAS8Ofamptog=;
        b=TwpYN0vzjL5rNPBwfqAMSPcx2jrsYk3U7BJA5THJ4naDJKx44MBOt3II9EcRAISls/
         kpNm1SR8fCAbF9n7kPM7fGfd6Wn2GbfBvmYgHvujlUFo75TAlf/7jyVgjy7Fc7ClkS/e
         wXPNGU5xTAKOEXA0Nxltj1xrZyt9rMDiPF9fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ig4qN9lSKY4uKAkOlIGr5lSNEclLXQYYAS8Ofamptog=;
        b=ppn7DsMS9PnVR3prMxCYsbPWuOdvcyfFa6qS7rHp4ef3NDSTQHunGmPmRNvCE6/RAM
         Z33V2dTqwVDDxOzY1jyiBtTnPe9nBbMvJUYV+CmTmT7U2kU3mRUC66QKyFLQzt/qVpnl
         SPILN+/2LqJZdcDA36ztu7BRe8xutT/ayBkMt78bUHG+GXg/n462zZJT3zQunuxERCT4
         7U0v8xhtlzjECIhqyqr/guOI5I1e+bIAZZeN/AFwrxjvvbg0nHFpg36JPHXOcLOV1oa9
         QbDc+r4Rxi4D+56kR4tsPaKZUuuwO84+ilgeSgKUa63ZfEkJFW9RaQo4taK/ClRq8ASF
         vB0A==
X-Gm-Message-State: AOAM531hMvFQRpzQTqiZruapMa9YrrFlKUKOHm9tTxQ+ZDwgF7BEA3kw
        9Tii9ZaIYJ8KkzxQT4P/hHQqbw==
X-Google-Smtp-Source: ABdhPJxko3GUh8FHYlh0S9hcJRI724qwE+vWqbjdu5ygNAWk2iBL+JkGSeTqDw4SbESxd911BIYkpQ==
X-Received: by 2002:a63:d757:: with SMTP id w23mr26557669pgi.434.1627435413215;
        Tue, 27 Jul 2021 18:23:33 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:ba3e:509b:495:ec84])
        by smtp.gmail.com with ESMTPSA id o1sm148842pfp.84.2021.07.27.18.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 18:23:32 -0700 (PDT)
Date:   Wed, 28 Jul 2021 10:23:28 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/2] printk: Remove console_silent()
Message-ID: <YQCxkICd0UY+k4Dl@google.com>
References: <20210727130635.675184-1-dima@arista.com>
 <20210727130635.675184-2-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727130635.675184-2-dima@arista.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/27 14:06), Dmitry Safonov wrote:
> It' unused since removal of mn10300:
> commit 739d875dd698 ("mn10300: Remove the architecture")
> x86 stopped using it in v2.6.12 (see history git):
> commit 7574828b3dbb ("[PATCH] x86_64: add nmi button support")
> 
> Let's clean it up from the header.

Nice.

> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
