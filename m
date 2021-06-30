Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2379A3B8176
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 13:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhF3Ltk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 07:49:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49390 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbhF3Lti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 07:49:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 858F322676;
        Wed, 30 Jun 2021 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625053629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MGeCyD9HVgrWaFU7ExuXTPOCV6Jk78Mqxo7DZojNn4Y=;
        b=HOBDHbV/bxFNopCeSd30HhM8mX2owFCTPQqyf+XZuDQvZQ9PjU4nepFKHP1iMrYJ9zlb7Q
        6/aipQeBfSPIBAcfAhOCh84Qf3enkDSthB+U136Cx/WNix0VQvVlAuSQU/eDFWhJuTmSZQ
        MhAfa2Oy2BToXU5o5Bih4oG5HGlWQPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625053629;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MGeCyD9HVgrWaFU7ExuXTPOCV6Jk78Mqxo7DZojNn4Y=;
        b=so4Wtk7Mi8uZB/GPCwEC4VUMaPAHHycUVmNmbsiXwRiUQc2MGhV/aKzufPSFFCTfLcZ1kA
        21HhKUBgx9hn/TCQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1EFBBA3B92;
        Wed, 30 Jun 2021 11:47:09 +0000 (UTC)
Date:   Wed, 30 Jun 2021 13:47:08 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     jpoimboe@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com
Subject: Re: [PATCH v2 01/24] x86/xen: Mark cpu_bringup_and_idle() as
 dead_end_function
In-Reply-To: <20210624095147.693801717@infradead.org>
Message-ID: <alpine.LSU.2.21.2106301346520.32505@pobox.suse.cz>
References: <20210624094059.886075998@infradead.org> <20210624095147.693801717@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021, Peter Zijlstra wrote:

> The asm_cpu_bringup_and_idle() function is required to push the return
> value on the stack in order to make ORC happy, but the only reason
> objtool doesn't complain is because of a happy accident.
> 
> The thing is that asm_cpu_bringup_and_idle() doesn't return, so
> validate_branch() never terminates and falls through to the next
> function, which in the normal case is the hypercall_page. And that, as
> it happens, is 4095 NOPs and a RET.
> 
> Make asm_cpu_bringup_and_idle() terminate on it's own, by making the
> function it calls as a dead-end. This way we no longer rely on what
> code happens to come after.
> 
> Fixes: c3881eb58d56 ("x86/xen: Make the secondary CPU idle tasks reliable")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
