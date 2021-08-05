Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBCC3E10C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbhHEJGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhHEJGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:06:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23DDC061765;
        Thu,  5 Aug 2021 02:06:25 -0700 (PDT)
Date:   Thu, 5 Aug 2021 11:06:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628154384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ewby7Aa7DBnF6pwX5WqIN3isZ3trnaYr9xD566yMh8w=;
        b=hPaCKr24i2ASPRtAQsvjluVflYd2CPeELpv1Euzoh2gFATLAEjh9bqN9fbdDgs8F9HoX54
        MlBgOVVWPiDyrwIxOD6snFttJgnmSRD5j5QRPAzRGISfxu/z3+XUqzGr0mn15EJcWzNLca
        BPURUcI7REYHYU73ik+T+jM6VtAYGFRbVKz7QykirRCrRDX4bUJZLiiorEMY3r98XTXzS6
        9un5hm59KcQA735B3BEFdrkXq7XUD7AMqZFibgi6qq9RcFcZaPRl6jChSj9ZPbeVGAiHaG
        1xYegkwvkGEu6ZkXPpOEWMWiIhRczS9IKLDLV5hSHMF27GcFGQkfOl7bR+mPKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628154384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ewby7Aa7DBnF6pwX5WqIN3isZ3trnaYr9xD566yMh8w=;
        b=ek7/ssIXlKmE6Po6yzfmXF+Ca3syQu8x51PuEaav/mN5Ml7JRJ60ObbTbdR1mtnfzkbep4
        Bz2YpEHNh56P1aDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.14-rc4-rt5
Message-ID: <20210805090623.yzkdgdeqdiernfvf@linutronix.de>
References: <20210804165017.nizmbj3m7hkqzqop@linutronix.de>
 <20210805063123.mj4rggncauziryv4@beryllium.lan>
 <20210805065351.c7eieltqihduwisr@beryllium.lan>
 <20210805070008.nvhzjp56lbx5uwk2@beryllium.lan>
 <07fff459-375b-38ef-ec4d-647beb268731@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07fff459-375b-38ef-ec4d-647beb268731@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-05 09:32:44 [+0200], Daniel Bristot de Oliveira wrote:
> On 8/5/21 9:00 AM, Daniel Wagner wrote:
> > On Thu, Aug 05, 2021 at 08:53:53AM +0200, Daniel Wagner wrote:
> >> On Thu, Aug 05, 2021 at 08:31:23AM +0200, Daniel Wagner wrote:
> >>> Just a heads up. I get these build errors:
> >>
> >> I suppose this should be:
> > 
> > and while at it, there are two more compile errors. The first one is
> > obvious, the second one is just guessing.
> > 
> 
> same problems, same fixes here.

Sorry for that. Mike reported the same. A new release will follow
shortly.

> -- Daniel

Sebastian
