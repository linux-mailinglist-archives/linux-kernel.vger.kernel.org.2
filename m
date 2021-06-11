Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69BF3A497C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFKTj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:39:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42240 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKTj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:39:27 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623440248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EKF5VOuZBLs6gaM+NwcgZNlrCJW0NmbjvdZPXlY9v2I=;
        b=VmiMJ0nH7n329R1XjlMJ+zZZS/XOs9RZyYKf3IBlVWdFIK/WyCtvVDSJQX8hiSBCM4Shmp
        TuV2BP75dRnxzju19BRxUJDz7d9aYWtINECIQaw1hTasAS4fNcIqJ46LdjQQiySRQEaUrD
        4u/sJWbtrmQHOuG/+F+eFfnrB3CodGCKIzmAqV1aC/9Rk7sXM/FkzItraaheKPs7WQ74JE
        PfpJJyTTTPkVxfW/Y7ECxgJSz8/AZfsrvkwiboAXFtWFagIhIkFxnFYGM2M/Md+VBWQaz/
        pYlNjIgcKZQGyUreEUSIgRxf3JMUWvl7o5ol5N7IhzjiAQ1pEs2jTWkIava9iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623440248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EKF5VOuZBLs6gaM+NwcgZNlrCJW0NmbjvdZPXlY9v2I=;
        b=ENHZPJZnl+pFlRtaCv0VfS2Eg0nQ585eQGk2wo9GtmFZEYs44lLWgwJ2Kv0lqjv30OcS9G
        4aL+LV5EZepmvACA==
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
Subject: Re: [patch 05/41] x86/fpu: Limit xstate copy size in xstateregs_set()
In-Reply-To: <ff835ae2-bdd8-3a82-abd1-8ac7500acdcc@kernel.org>
References: <20210611161523.508908024@linutronix.de> <20210611163111.515164108@linutronix.de> <ff835ae2-bdd8-3a82-abd1-8ac7500acdcc@kernel.org>
Date:   Fri, 11 Jun 2021 21:37:28 +0200
Message-ID: <87mtrww5tz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2021 at 11:37, Andy Lutomirski wrote:
> On 6/11/21 9:15 AM, Thomas Gleixner wrote:
>> If the count argument is larger than the xstate size, this will happily
>> copy beyond the end of xstate.
>
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
>
> This interface is horrible.  Oh well.

It's ptrace is must be horrible :)
