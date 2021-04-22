Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC9936837A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhDVPh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:37:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39252 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbhDVPhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:37:54 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619105838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7qWCJ3Q81wcbF9una1Suq0iJg1VmWt6VflPj/doKZ1I=;
        b=N25SkA3kl4XpGp2xguAdMeXSnlVNgloS5PA1DfRFITGe3mWyz6pMSrTB012J81QQpeEdE/
        GLYjR2p1Ws2H/1Q9WUkTyvyNjuYEcWXucWDiQIQVVQYFoRMZuKpSy2iURXZBLFcaROY0c/
        vzZWMgVWn0WRLcywNaNP/8dF/hkrP1bA7HVA2vFTvyf6Q49qCwb8VTGgB77wtOwhBWW2xV
        QMkxX4b88wWRsnXwPr76umysqB4HQ/c+Z0sAH4MPCr1dRTGQRHB6vTo4iMTr7ZnC8GMJEP
        s+iBN6bpw3g5iCBP6arLTVXPVoXeNnPNToforZWRBJEGK6VFuZynhSUxcTuBLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619105838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7qWCJ3Q81wcbF9una1Suq0iJg1VmWt6VflPj/doKZ1I=;
        b=qwgquP63myVNvjX12jgtSjHCEboVKD9vtmrZbWxL0TX7LLQUFRGh5lxqaNeO8Fi1IfjpkO
        0IP/8UN/uRRGB0AQ==
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com
Subject: Re: [signal]  4bad58ebc8:  will-it-scale.per_thread_ops -3.3% regression
In-Reply-To: <20210422060213.GC31382@xsang-OptiPlex-9020>
References: <20210420030837.GB31773@xsang-OptiPlex-9020> <87bla8rehx.ffs@nanos.tec.linutronix.de> <20210422060213.GC31382@xsang-OptiPlex-9020>
Date:   Thu, 22 Apr 2021 17:37:18 +0200
Message-ID: <87eef2xrdd.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver,

On Thu, Apr 22 2021 at 14:02, Oliver Sang wrote:
> On Tue, Apr 20, 2021 at 08:35:06PM +0200, Thomas Gleixner wrote:
>> Confused.
>
> FYI.
> we re-test this, and confirmed the regression persistent. still:
>
> 69995ebbb9d37173 4bad58ebc8bc4f20d89cff95417
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>  1.271e+09            -3.3%  1.229e+09        will-it-scale.192.threads
>    6620228            -3.3%    6401749        will-it-scale.per_thread_ops
>  1.271e+09            -3.3%  1.229e+09        will-it-scale.workload

I'll have a look.
