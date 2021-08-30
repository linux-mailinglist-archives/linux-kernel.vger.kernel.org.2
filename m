Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39973FBD16
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 21:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhH3Tkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 15:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhH3Tku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 15:40:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57646C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 12:39:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630352395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=us4dmtVLXOhNn9SThCdMpJkgWctajJqeNbWFhIv2Wjk=;
        b=w1DGI5f3GsQ5XJ4Hm8f9cflw12YQjjmpsvX0ed2lhb0M7tTFoEyH2/2Hs9sBdRtbbmhpcB
        iDsdIjacnqAFk/myKXsTWj+/pe5Q1dZKZMG2b/o5wRrK3sBI840xaL7cuaGwEiJgnY9hLU
        R8qRzE2U0utTpkAxQYQivlc7ShFFK5H35iOEuOnpJ6cafIO1S7CiUMKnuJqDbBersk10U4
        09Mbf8yJ+se23hb61zmwMCTKPMWoQtpO+4HyTUsWlXpNREgxpnHLURRdUBq4EnikMFrBUq
        6VnpPIf8DdWK1/0WbT+xa9vas1mzTEQWTN6V8+TaWAWlOpUiREzLmNoo+RM50w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630352395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=us4dmtVLXOhNn9SThCdMpJkgWctajJqeNbWFhIv2Wjk=;
        b=9WN9YKp4fJ5C8PXIMkn5twBtFlDcUVE7xXBV3yA81osDU+vL+ir3Ds1nObgWp3Ur4duKLP
        7BSzMfnmIC9mifCQ==
To:     paulmck@kernel.org
Cc:     syzbot <syzbot+f2ceae48bb0c0ab08b9d@syzkaller.appspotmail.com>,
        bp@alien8.de, dwmw@amazon.co.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: [syzbot] WARNING in rcu_core
In-Reply-To: <20210830170647.GT4156@paulmck-ThinkPad-P17-Gen-1>
References: <000000000000d4ba6405cac3b065@google.com> <87eeabgq84.ffs@tglx>
 <20210830170647.GT4156@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 30 Aug 2021 21:39:54 +0200
Message-ID: <875yvmhgc5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30 2021 at 10:06, Paul E. McKenney wrote:
> On Mon, Aug 30, 2021 at 12:51:39PM +0200, Thomas Gleixner wrote:
>
> This looks like a use-after-free in a structure that unions the rcu_head
> structure with something else.
>
> Would adding a mem_dump_obj() somewhere in the debug-object code be
> helpful?

At least for the case where the object is not available in the debug
objects tracking.

> (Or propagate a return value out, similar to that of
> debug_object_activate()?)

That might be useful for some callers as well.

Thanks,

        tglx

