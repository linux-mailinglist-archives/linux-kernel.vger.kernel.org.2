Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93B5400146
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349479AbhICObl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:31:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51014 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349462AbhICObk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:31:40 -0400
Date:   Fri, 3 Sep 2021 16:30:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630679439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iX9ibRou0XdEYZ+bGp1TcDhh7+TKZehHehODtNVHWHE=;
        b=F/6rjyYXdOXlIILsD4o85OGpjuc5hNQoL22+Zi1UsbSiCNFKleOVV756U1HMGGlKDSYH7M
        MWbdPMRxeziJVhyj1soakx2+OPVY2zxEUBpR/otrGXCgnMhd8u7i5IulLJb4lcYZtBCWFf
        +hFw5W94nfphEQrSRuk8UiQAovxOSomv0TQJ3msZE76fbEpk5guKJJCxXLNk6/RglN6Fas
        EDXGNJ5ssTs0RFLg7yYiHH5bGxQRLflM0EDxHvSVB4JTlcWDaJwIGBsGgJjwyFrMSOFyQ+
        SUrLFOVM8HuvLbmak+r0ILtwT2ljZvst1QTfsV/D2DYJSl9VF3DgC62kscmpfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630679439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iX9ibRou0XdEYZ+bGp1TcDhh7+TKZehHehODtNVHWHE=;
        b=dCSD7Ttc5dXbeT+sVJ58iMvLPGB78zgB7/JaAazaE+wSGtehRX00O3cUNjtPWNyMCYfLb0
        l4VPfwSMHIANi5CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] lockdep: Let lock_is_held_type() detect recursive read
 as read
Message-ID: <20210903143038.mxjxbry2agyjvzsv@linutronix.de>
References: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
 <YS+twcAQ9uivowDS@boqun-archlinux>
 <20210903104557.rqss65jn4ozoptcj@linutronix.de>
 <YTIt6KIjz5gTbZif@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YTIt6KIjz5gTbZif@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-03 22:15:04 [+0800], Boqun Feng wrote:
> But the rwlock in PREEMPT_RT is writer unfair, isn't it? As per:
>=20
> 	https://lore.kernel.org/lkml/20210815211302.957920571@linutronix.de/
>=20
> also in __rwbase_read_lock():
>=20
> 	/*
> 	 * Allow readers, as long as the writer has not completely
> 	 * acquired the semaphore for write.
> 	 */
> 	if (atomic_read(&rwb->readers) !=3D WRITER_BIAS) {
> 		atomic_inc(&rwb->readers);
> 		raw_spin_unlock_irq(&rtm->wait_lock);
> 		return 0;
> 	}
>=20
> that means the readers of rwlock in PREEMPT_RT are always recursive,
> right? Am I missing something subtle?

huch. You are right. I take everything backt then. I do remember it
differently but it has been like since this implementation has been
introduced=E2=80=A6

> Regards,
> Boqun

Sebastian
