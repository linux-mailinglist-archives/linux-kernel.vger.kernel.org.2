Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1001643B180
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 13:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhJZLvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 07:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhJZLut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 07:50:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138EFC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 04:48:26 -0700 (PDT)
Date:   Tue, 26 Oct 2021 13:48:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635248904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/x4H9hxCpLYZVXl7Vl8JdX2ZwMomw7sQZXvJW1FdXh8=;
        b=030sBQ+x18vdgG5iBA39Z08R0JwhSIKEDMIb0OCb/MFMf8pSU4Ir2TYxT3w4R6YFgUxYNq
        57y7STzaryfthhyQV5rkiBX45v2wApyBOXc+RgpB4ZNIUKodSmWR97Hox4WBwPW+jjK1tg
        WbZExVhGcFsHo5+wJz/FJNNI5hc27Gu7n5+BV03ZUMNFRsm/l4rkQSLRTypvA7bDDp0tSb
        cxQWNxE046K/osJe72Ud6d+tenMa0wFGets421P8jv8rczR2nK3zpnpUYB3lkMw850tw1r
        HDSGek206rXwch09TFuEhUpfGrEgeDI0BI/Vj1Epe4EJW7fBMtR1ZR2iUk63xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635248904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/x4H9hxCpLYZVXl7Vl8JdX2ZwMomw7sQZXvJW1FdXh8=;
        b=aoQy+wxZs8v72fWvhVoZ/wPpvNotOxiSmjPWCJhZZ9Pqv37wLrAFu/EzXGwOn52mRGiLRG
        vyN8eLoqkgt7sRBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] smp: Wake ksoftirqd on PREEMPT_RT instead
 do_softirq().
Message-ID: <20211026114823.pto26636nzolhint@linutronix.de>
References: <20210924094755.2m32pgqwrqw2cg2s@linutronix.de>
 <YU76mB5hzvw3xZRB@infradead.org>
 <87tui7bc5m.ffs@tglx>
 <20210927073814.x5h6osr4dgiu44sc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210927073814.x5h6osr4dgiu44sc@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-27 09:38:16 [+0200], To Thomas Gleixner wrote:
> The softirq implementation on PREEMPT_RT does not provide do_softirq().
> The other user of do_softirq() is replaced with a local_bh_disable()
> + enable() around the possible raise-softirq invocation. This can not be
> done here because migration_cpu_stop() is invoked with disabled
> preemption.
>=20
> Wake the softirq thread on PREEMPT_RT if there are any pending softirqs.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1=E2=80=A6v2: Drop an empty line.

ping.

Sebastian
