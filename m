Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD7C3DD0E6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 09:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhHBHCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 03:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhHBHCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:02:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FD9C06175F;
        Mon,  2 Aug 2021 00:02:23 -0700 (PDT)
Date:   Mon, 2 Aug 2021 09:02:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627887740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAzZg5McgFlmYcY3vHHS7joGLgzy1wAKFe4TyqSJf4Q=;
        b=UxfSwwajYsRzsd7ojnKcpaNOmN7Qek2ryXEVUm8tDjiwsxo1gyiHQR/Jvx2TWhmL6GWrTt
        Z1MKfWCASnaLymQN4Qw/LsROvaRBUKdLzUAgK5Xzx72p3n+WeP5BfxDBVS8n1Bgohkn5uV
        lKP5HbhfWgsWWr2Me2UvivJpdpM1qw32GVpgfGcJrehtxJRfNm3NkZLUXruzByJWJ0hRgm
        c6UIrQ+uQ6hVi9FtWnGaz7pxvaQg2VEnclcTAn/x8nQTapwgC2lytRfF0j4gRmtx9ErcPW
        SBDqPg3pFWafifT4R/YFxuI4tM2WNqTXF+G7i2z20AKXuwtH72lAC52hw2tOBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627887740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAzZg5McgFlmYcY3vHHS7joGLgzy1wAKFe4TyqSJf4Q=;
        b=7o11tUdlH+hzGPbzr8mVCq+/Ij2napnOuvPAKqRc1dtUi3P8oY5JrMB9I7fo0Z6MtII0Rt
        8x4wAdyQzs5hQNDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: v5.14-rc3-rt1 losing wakeups?
Message-ID: <20210802070218.5js3exubjxvsicx6@linutronix.de>
References: <20210730110753.jvli6alm63h5lefy@linutronix.de>
 <2ae27233ab091d09a7d1e971a47144b40dd51fa0.camel@gmx.de>
 <87pmuzsf1p.ffs@tglx>
 <6fce881efc3d8c24a5172528fe1f46ec2ddc0607.camel@gmx.de>
 <ed1d5f9ec17a5b8d758c234562dad47cfc872ed8.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ed1d5f9ec17a5b8d758c234562dad47cfc872ed8.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-01 17:14:49 [+0200], Mike Galbraith wrote:
> On Sun, 2021-08-01 at 05:36 +0200, Mike Galbraith wrote:
> > On Fri, 2021-07-30 at 22:49 +0200, Thomas Gleixner wrote:
> > > >
> > > > First symptom is KDE/Plasma's task manager going comatose.=C2=A0 No=
tice soon
> > >
> > > KDE/Plasma points at the new fangled rtmutex based ww_mutex from
> > > Peter.
> >
> > Seems not.=C2=A0 When booting KVM box with nomodeset, there's exactly o=
ne
> > early boot ww_mutex lock/unlock, ancient history at the failure point.
>=20
> As you've probably already surmised given it isn't the ww_mutex bits,
> it's the wake_q bits.  Apply the below, 5.14-rt ceases to fail.  Take
> perfectly healthy 5.13-rt, apply those bits, and it instantly begins
> failing as 5.14-rt had been.

Given what you have replied to the locking thread/
ww_mutex_lock_interruptible() may I assume that the wake_q bits are fine
and it is just the ww_mutex?

Sebastian
