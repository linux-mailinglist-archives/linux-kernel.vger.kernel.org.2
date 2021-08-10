Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9673E5AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbhHJNMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:12:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43324 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbhHJNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:12:35 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628601132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OaBFwRmIkMYJ6nArGCfoxdS9fFU0RJW0EkC34EWy+pY=;
        b=KadFt9TgeKOmX5hfgraer3970wg4d5deZONKOXsg7AvIqTxkG6d9u4k/CrL2glo7GHMESg
        FW8VWh/DQKMrn0hCuOuLNC/Pdq/yrX9Lj4m1G6kcRXiKiL6FD+OnB58M0SaZSljK2tdWqQ
        GpHZ0R721L94rr9Ng/PeP6v0uCIFclfga2mzvZ5Htla4kSJptK/PlLZyMhLx1v0xu8Uck8
        fogFuqyK8MvDWQ8D+iYesDllCVmbT78TI9uqzcu0+Pt3IrXn+XmPXa8oKdrAfE0W2nDSkm
        nVobG3/tcCJiIFGfhZtTjq2tbbee3UPLBn7NC0sB664FMrKTaQcqoF0n8f7INQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628601132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OaBFwRmIkMYJ6nArGCfoxdS9fFU0RJW0EkC34EWy+pY=;
        b=6pAq73C7GB77pfq+iKRUFQYZRhSBuEqPClqwFBmdKSmpwiAV+a2ELp1IFRbnGK/wgCOaCm
        r9deQiarsZoTNYDw==
To:     Mingzhe Yang <cainiao666999@gmail.com>, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, yuxin.wooo@gmail.com,
        becausehan@gmail.com, huan.xie@suse.com,
        Mingzhe Yang <cainiao666999@gmail.com>
Subject: Re: [PATCH] tasklets: simplify code in tasklet_action_common()
In-Reply-To: <20210430122521.13957-1-cainiao666999@gmail.com>
References: <20210430122521.13957-1-cainiao666999@gmail.com>
Date:   Tue, 10 Aug 2021 15:12:11 +0200
Message-ID: <87czqlsatw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30 2021 at 20:25, Mingzhe Yang wrote:

> Use tasklet_is_disabled() to simplify the code in
> tasklet_action_common.

This changelog is not really helpful. Use a new function does not tell
anything. Neither does it explain why there need to be two new functions
and worse
  
> +static inline bool tasklet_is_enabled(struct tasklet_struct *t)
> +{
> +	smp_rmb();

why there is suddenly a new undocumented SMP barrier in the code.

> +	return !atomic_read(&t->count);
> +}
> +
> +static inline bool tasklet_is_disabled(struct tasklet_struct *t)
> +{
> +	return !tasklet_is_enabled(t);
> +}
> +

Aside of that there is no point in exposing these functions in a global
header.

Thanks,

        tglx
