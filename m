Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADD03141DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhBHVdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:33:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233954AbhBHUnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612816934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x/DcGBxTFdBtUyaSlvHAJiTxHgjFVBlSm8gDsprfFgY=;
        b=AHhqCfzwwH4xgRSEYjVxEwWl+bS+NbJHzP6/CFAPkF8yJvxvBe3kPYr04V1uUn3DfMaEs6
        w5PyXWNY3ptx7+5T4cVzDct6I1IHhYCJ0Gm/RtS/d6BjHg0T7F7sZDmQngWOJN3AHCSd+Q
        8ceU5zpChvQoe4MLZEU4oShh3chyPTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-01GCkw8FMQukE_yjm449nQ-1; Mon, 08 Feb 2021 15:42:13 -0500
X-MC-Unique: 01GCkw8FMQukE_yjm449nQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E382580196C;
        Mon,  8 Feb 2021 20:42:11 +0000 (UTC)
Received: from treble (ovpn-120-159.rdu2.redhat.com [10.10.120.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AD5560C4D;
        Mon,  8 Feb 2021 20:42:11 +0000 (UTC)
Date:   Mon, 8 Feb 2021 14:42:09 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 05/12] x86/irq: Provide macro for inlining irq stack
 switching
Message-ID: <20210208204209.yccd76j7sp2zbv37@treble>
References: <20210204204903.350275743@linutronix.de>
 <20210204211154.618389756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204211154.618389756@linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:49:08PM +0100, Thomas Gleixner wrote:
>  #ifdef CONFIG_X86_64
> +
> +#ifdef CONFIG_UNWINDER_FRAME_POINTER
> +# define IRQSTACK_CALL_CONSTRAINT	, ASM_CALL_CONSTRAINT
> +#else
> +# define IRQSTACK_CALL_CONSTRAINT
> +#endif

Is this really needed?  i.e. does ASM_CALL_CONSTRAINT actually affect
code generation with !FRAME_POINTER?

If so then we should rework ASM_CALL_CONSTRAINT itself to be something
similar to the above, as it's only ever needed with frame pointers.

-- 
Josh

