Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC193A4F12
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 15:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhFLNRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 09:17:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLNRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 09:17:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623503737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+kGaqZ0+T0luScHewSwRbmNtRqpRVptleB8XemF+sKU=;
        b=w7dD+O80GKX4laiNHXuoV8AOLXqlZ0ZqsKe/Q/enXEQi9tA09dOCadrajKP06o8KxvlQHw
        /QkNNxqtcU7JuUnoNQVLv9YrI5q1hIWd1x3DlKsMw1WWRMmpBnbO/gsYi/p8IpLE7mRdrZ
        wsBNto4Rv/9zdeH6Mo7fuyM+zttWe5DnHhix7c70G44OoNqObPYmT9yoah9cOGnUbwgDQJ
        Hpss8RTnfHcbAwv9SDTHuq9YQVvg5MCXKR7XOFvx9vLE2bw/W4HymXkvWZuCQPx17YkdMJ
        Mv4Iil8NOryb3NJlDjSgSVWOKETXwsxjt0xLStOpKVtPsURVBqukp6hxEM8Qfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623503737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+kGaqZ0+T0luScHewSwRbmNtRqpRVptleB8XemF+sKU=;
        b=zYe7CC99Uau5nWzWhiCX6OqJpWhuslM4a9V5+Twp6scd2HbP/ykte1Ki3f9SSMrzNHE9dG
        NW4r70fYGPtkN7DQ==
To:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch 08/41] x86/fpu: Restrict fpstate sanitizing to legacy components
In-Reply-To: <874ke4vynu.ffs@nanos.tec.linutronix.de>
References: <20210611161523.508908024@linutronix.de> <20210611163111.820639606@linutronix.de> <2be2ef6c-fcb8-46cf-976c-2b3a9537b660@kernel.org> <874ke4vynu.ffs@nanos.tec.linutronix.de>
Date:   Sat, 12 Jun 2021 15:15:36 +0200
Message-ID: <87r1h7usuf.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12 2021 at 00:12, Thomas Gleixner wrote:
> On Fri, Jun 11 2021 at 12:03, Andy Lutomirski wrote:
>> On 6/11/21 9:15 AM, Thomas Gleixner wrote:
>>> + *
>>> + * This is required for the legacy regset functions.
>>> + */
>>> +static void fpstate_sanitize_legacy(struct fpu *fpu)
>>> +{
>>> +	struct fxregs_state *fx = &fpu->state.fxsave;
>>> +	u64 xfeatures;
>>> +
>>> +	if (!use_xsaveopt())
>>> +		return;
>>
>> This is confusing, since we never use xsaveopt.  It's also wrong -- see
>> above.  How about just removing it?
>
> We do and this code is buggy because xsaves does not clear the component
> storage either. Neither does xsavec which we in fact do not use in the
> kernel.

So that kinda works because the CPUs which have XSAVES have XSAVEOPT
too. But XSAVESOPT can be disabled on the command line, which then makes
that condition false...

Oh well.

