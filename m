Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DDD402F5D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346259AbhIGUF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhIGUF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:05:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCB0C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:04:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631045059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=peXi6tK7nOOysDrjgMJPWuGZvpUsbQDcmuVn0mBfqDI=;
        b=h2xooX7BwFL3t4YtoLJKeU50RSEvklkxMGbbcFQlcnSblT8xSA0ILPZ5YvxufMxbLPqwKa
        tDt5w8PzAqrXfvgWVpAe8+z7niU9Fccn2FnvPsn0CoPV9+Z3a65dxe/2tmxdgt/GkV5rc3
        oI7NM5Jyo/nfTzd0R2Sv49LaKHo5z/LkTExxC9dQvPvXaRIgblWAq5CURyhN0Y+50zXW8Q
        8dEVGzYFC/IObKzMQCFkMdao9HP0I6Ej1Sari+KB1xTHE237qhCEYjNnbkYUlLwy0d0h9y
        lfTd+sUmpuIsWFKL6G6lk83ant5NNO90G0dvHBog4W9Vri1qr31mrvv6VgGyLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631045059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=peXi6tK7nOOysDrjgMJPWuGZvpUsbQDcmuVn0mBfqDI=;
        b=x/WoyI/13t6ccDMjRf/MBg5vZ2504fg1ojm7ZzE+ubPtx0C0uMI6o5Xd1r37fGhLUepbPK
        JwZKYBb/eZsvRFAA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: Re: [patch V2 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
In-Reply-To: <20210907195612.321345EED@xen13.tec.linutronix.de>
References: <20210907195612.321345EED@xen13.tec.linutronix.de>
Date:   Tue, 07 Sep 2021 22:04:19 +0200
Message-ID: <874kaw9mpo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07 2021 at 21:56, Thomas Gleixner wrote:

Please ignore. My quilt scripts went berserk for some weird reason.

I'll resend with proper threading after I figured it out.

Thanks and sorry for the noise

        tglx
  
