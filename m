Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F46131A275
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhBLQQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:16:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhBLQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613146490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2lTZJ9hOG6B4paR/QRRh1k2aw5uLfzbbaH35EaZq2U=;
        b=NEeqsLy1LYkTC+hlBnwFdJvbniRrQWs9S8vk4XQTSRgcmYFr9RZ7hpjY62pbCFZAUyURv6
        e+cTvjMoNnBmd+4o3j5ex9xAts5183iW0aQcdrEmBJG2a/fhIxSO4OuuN1yvOUvOX/+wGT
        A7hpqneB3LQy/+q3CO4FehZQMLyaB5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-Zcg1pYC9MbqAj3D-9A8XyQ-1; Fri, 12 Feb 2021 11:14:46 -0500
X-MC-Unique: Zcg1pYC9MbqAj3D-9A8XyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CE2B85B660;
        Fri, 12 Feb 2021 16:14:43 +0000 (UTC)
Received: from treble (ovpn-120-169.rdu2.redhat.com [10.10.120.169])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43E395D6AB;
        Fri, 12 Feb 2021 16:14:42 +0000 (UTC)
Date:   Fri, 12 Feb 2021 10:14:39 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jason Gerecke <killertofu@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Baron <jbaron@akamai.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] RFC: x86/jump_label: Mark arguments as const to satisfy
 asm constraints
Message-ID: <20210212161439.pkrw6cpbfqhafrnk@treble>
References: <20210211214848.536626-1-jason.gerecke@wacom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210211214848.536626-1-jason.gerecke@wacom.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 01:48:48PM -0800, Jason Gerecke wrote:
> When compiling an external kernel module with `-O0` or `-O1`, the following
> compile error may be reported:
> 
>     ./arch/x86/include/asm/jump_label.h:25:2: error: impossible constraint in ‘asm’
>        25 |  asm_volatile_goto("1:"
>           |  ^~~~~~~~~~~~~~~~~
> 
> It appears that these lower optimization levels prevent GCC from detecting
> that the key/branch arguments can be treated as constants and used as
> immediate operands. To work around this, explicitly add the `const` label.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> ---
> Marked RFC since I'm not familiar with this subsystem or the asm blocks that
> are impacted. Extra-close inspection would be appreciated.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

