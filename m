Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CF043DD39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 10:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhJ1I76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 04:59:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46218 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhJ1I75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 04:59:57 -0400
Date:   Thu, 28 Oct 2021 10:57:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635411449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h3Cje/SqvoYZHCrFh9PDa4DmqMrBzIUj2b9Zikpc8xU=;
        b=gDLavLb42mgNDpGDuSnlwyEe1Z9r4m/Po0NnjCth7VpzBoYctRmN0Ub+FN7H8YPPpHHyGp
        KVlQ/td991cNpKG+Kh1j+AhkiSQ0M8FvyC8s0Dg+w9t7e+jfFKPQ8DER19/5fEy+BA/oma
        Ay/x3wMdwYUlLPug8/yX2ffc6LIp77YO9F3MsQ6zoIllIpjlI+U/47FsWweq6HNOPeymMm
        dY2y/Ez+MCEz4igh8j/chZB4sisOcWAnaxAfNG7zVQX0XxatZ8eQVTN0Asx2Vducr53qRM
        LfSh3lTCULwNdPMXfgy1fxLFkJ1H6M6UxDBSOkqgKh03YsZOsQvre/dBDawveQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635411449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h3Cje/SqvoYZHCrFh9PDa4DmqMrBzIUj2b9Zikpc8xU=;
        b=5c0RE0K570oOvLi7kvEji7sKkb5/YnQB9kigXLanVL78HNxEFboadXTM25uOQvRSVBp8KC
        5fIuamHGKliWQMBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Gregor Beck <gregor.beck@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
Subject: Re: 5.4.143-rt63 fscache sleeps while holding a look
Message-ID: <20211028085728.j34fsqbvtb5hqqfc@linutronix.de>
References: <CAEvSrYKjfkO=q=kK=2GEo707QDuEGjKA5Nn3E+9=QGOxnFE+vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEvSrYKjfkO=q=kK=2GEo707QDuEGjKA5Nn3E+9=QGOxnFE+vw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-14 10:29:40 [+0200], Gregor Beck wrote:
Hi,

> with kernel 5.4.143-rt63 fscache might sleep while holding a lock:
> 
> [ 1392.058346] BUG: sleeping function called from invalid context at
> kernel/locking/rtmutex.c:973
> [ 1392.058349] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 159,
> name: kswapd0
> [ 1392.058351] Preemption disabled at:
> [ 1392.058351] [<ffffffffc053a2a5>] fscache_enqueue_object+0x45/0x100
> [fscache]

This brings some memory back. Let me stare at it.

> Gregor

Sebastian
