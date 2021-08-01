Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052403DCBE6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhHANjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 09:39:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41986 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhHANjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 09:39:36 -0400
Date:   Sun, 1 Aug 2021 15:39:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627825167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V2DGzvEDDOHL4wNGqLh/L3qbGiCz/WEtxEh6PwuMsKs=;
        b=mr5lb4vnCsZeTua2ZYsa3NKBjB8PegqmeO3YML93vfUO/8iRHIRMWSB81tAILTXQjftSZZ
        QYBVe3gkaZk45qJW0RkryHlJ/T3xps5ioB/fTVhN6ZlnRUu/mnnEMx1Yx6JOF76J2xKCBe
        nRE22EQkvaQQVxHI6p80hBZpFeaiaR7s+L+pW+enzumSv1ZiF9xisZCAt+RtpNom2l/e/c
        oO4yUccLGEDFXX95PriJhteAK0CrZtaQk/mfOtP15cqeyzDxkQciXJ0qY7FTeZfUkB9mx1
        csZG3uL2H7hcJoXUlqom9wEVghREZqnmYFg4ksIksxqWCFt6xQNBVaEmUMkPEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627825167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V2DGzvEDDOHL4wNGqLh/L3qbGiCz/WEtxEh6PwuMsKs=;
        b=swcnDVMxb+6GHbeFF3VI4TNMHLEgYli8nMjfujvVn5E0hWw8QWQ5CLYcuaQNLazvt2WYWD
        gSQXj6+9IdJsKDDA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 17/17] libtracefs: Add man page for tracefs_sql()
Message-ID: <YQakDYRnId+bK+ue@lx-t490>
References: <20210730221824.595597-1-rostedt@goodmis.org>
 <20210730221824.595597-18-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730221824.595597-18-rostedt@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021, Steven Rostedt wrote:
> +
> +The SQL format is as follows:
> +
> +*SELECT* <fields> FROM <start-event> JOIN <end-event> ON <matching-fields> WHERE <filter>
> +
> +Note, although the examples show the SQL commands in uppercase, they are not required to
> +be so. That is, you can use "SELECT" or "select" or "sElEct".
> +

Maybe it would be helpful to mention that, unlike normal SELECT queries,
the JOIN and ON parts above are _not_ optional?

That is, generic "one event source" queries:

  SELECT common_pid,msr,val FROM write_msr WHERE msr=72

are not supported. (I wish they were though ;-))

BTW, thanks a lot for this work. It will finally make synthetic events
usable!

Kind regards,

--
Ahmed S. Darwish
Linutronix GmbH
