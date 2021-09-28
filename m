Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A43941BA7E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243170AbhI1WiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbhI1WiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:38:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D53C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 15:36:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632868594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xw5+hwmvRQv93K1oJsxnTu6Z8g7BTPU/L1fyaeGQjXA=;
        b=v5BBMp4SNo80/RzwDFgHKj52EDVHy1KRMvZXC1eZoqjjwitLGY3Y9K1nE6LsrISnqRobtv
        vcjBL6lvGR7tPxrqVKvHcuUfXcM7Ho0rXCmskQZN0uV7+MyFrPzJbIIcUe1nX9FBevmc39
        Q1UIh5gLZcOa43ErTCQhTMAXHXM6u9klvyfcE+mL7ZE+HPZsmizt8Z4DKUcspEoo3WOJRo
        vJJPHhMvz5rC1pA/wW3fKu7qvyr/+HwXMs3NDy7mwi7PU+qXg5ZoFbap+RhseVAU6drVcW
        PbMveY7jHVqITY4bdZK1hqWce7gMFZE+HsEeBlkInjW/QSx7IbJVFVMuOe/hkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632868594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xw5+hwmvRQv93K1oJsxnTu6Z8g7BTPU/L1fyaeGQjXA=;
        b=e3nMhsOgG42qpGBTiWxcB3pqZ8oVHiWvo7LOx1f4dNAq65OjBj7w3L33KKvJKeAHg++JPo
        scZDl7O6IcilxaBQ==
To:     Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org,
        sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH 3/3] sched: Always inline is_percpu_thread()
In-Reply-To: <20210928084218.063371959@infradead.org>
References: <20210928084020.819856223@infradead.org>
 <20210928084218.063371959@infradead.org>
Date:   Wed, 29 Sep 2021 00:36:34 +0200
Message-ID: <878rzg9vkd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28 2021 at 10:40, Peter Zijlstra wrote:

>   vmlinux.o: warning: objtool: check_preemption_disabled()+0x81: call to is_percpu_thread() leaves .noinstr.text section
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
