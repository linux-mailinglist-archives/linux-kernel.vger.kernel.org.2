Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC533DFF8F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 12:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbhHDKoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 06:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbhHDKn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 06:43:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB2C0613D5;
        Wed,  4 Aug 2021 03:43:44 -0700 (PDT)
Date:   Wed, 4 Aug 2021 12:43:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628073822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1Idsv1sOFk+OBpc1qKQ/SGKFiafAJXMKzWBmvwy1s4=;
        b=H1GkOTaLuQ0jbESYSRIAOBhzVvgbuk/LAdswxSwzqM7WFk2A0Dg7Lppwd6ZWGcqxRSb7VX
        Nr3TcNy/pKU2skozGNCIaqhocEIKxOZsBxG8b5uBDdcIJgMvDhOjxnmRjXUt451jPONFJZ
        jjLdIhfIOBBnrpWP7XWQoFMaGeuomKu1vdGFHnS+oUDxQt6SKck8wEnURt6FX0QdhhKiGu
        UdYl+A13BPStVQY12CZz3+tKrbzaQSf2BLwb8D2ZC0rjPemwhPpb118c7E2a4b2xtpDtDo
        kjm+hE+ZrqoH3arxsdS2PBoM/sjpDfVTuGH2+YzCZv9mWwbOb7OOU43Y0GZYQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628073822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1Idsv1sOFk+OBpc1qKQ/SGKFiafAJXMKzWBmvwy1s4=;
        b=OrgdMfIWRWbTBGqC2sbWzhC/rPSTg93i9fVf35Ms+IBS5TxeGH79jIH9HHaVSH2QE5vBm6
        jGo7gGTyyDlfhkCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
References: <20210802162750.santic4y6lzcet5c@linutronix.de>
 <20210804082418.fbibprcwtzyt5qax@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804082418.fbibprcwtzyt5qax@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-04 10:24:18 [+0200], Daniel Wagner wrote:
> Hi Sebastian,
> 
> On Mon, Aug 02, 2021 at 06:27:50PM +0200, Sebastian Andrzej Siewior wrote:
> > Dear RT folks!
> > 
> > I'm pleased to announce the v5.14-rc4-rt4 patch set. 
> 
> stress-ng is able to trigger a BUG on my old x86_64 box very
> easy. Unfortunately, there is not much in the logs though.

Odd. Do you have a config for that, please?

> Thanks,
> Daniel

Sebastian
