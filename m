Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326DC342FA9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 22:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCTV07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 17:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCTV0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 17:26:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E7FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 14:26:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616275597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pvPr3ZokkYfdRQfsfefZc9G5iA0ihV8cgVIMTtZ80Ps=;
        b=bYigIbRTJnxVMz2ORW+UGG7xdHMglzCSnQKA9LNWRM2p2TYhMnjsVqYW/5NZnI3hulOwM/
        qYOUhkTJRjcXzmG6IHmuxQ+nf2vTgTb3tG+FktOS+eh7TI2RaByuAZfnIR0yJiz6gabsP1
        4v6QhrH0uPba5+aBfMoiLjHTB2agVP+cnkChLEyl0VzG1/tELu1uXWwR2CC6ld1zYiPHUX
        o2Nx9IlRULE881B4zrDTsqszqwGH97d+uE9yfbIn7wko+lWu+XAt9sGp48bKruIMWhJmdH
        MTLIBrm/tUcPquoPhIqztjjUJZLCF7Oes4X0lM3B7s8982DAMzd4nYST1LyAKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616275597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pvPr3ZokkYfdRQfsfefZc9G5iA0ihV8cgVIMTtZ80Ps=;
        b=nk/wVc71Z3mZcAAEZ86gi9fwt0dhbUlHMDmD18Oap1bZ8Ozb3vBkTKxj6FT1BaFAJSqFjF
        FGTdX30iLNz+j5BA==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v4 19/22] x86/fpu/amx: Enable the AMX feature in 64-bit mode
In-Reply-To: <20210221185637.19281-20-chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com> <20210221185637.19281-20-chang.seok.bae@intel.com>
Date:   Sat, 20 Mar 2021 22:26:37 +0100
Message-ID: <87v99la54i.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21 2021 at 10:56, Chang S. Bae wrote:

> In 64-bit mode, include the AMX state components in
> XFEATURE_MASK_USER_SUPPORTED.
>
> The XFD feature will be used to dynamically expand the xstate per-task
> buffer on the first use.

This patch touches absolutely nothing XFD related. What's the message
here?

Thanks,

        tglx
