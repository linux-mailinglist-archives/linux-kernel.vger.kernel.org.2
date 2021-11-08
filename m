Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB8A447D38
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbhKHKEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:04:08 -0500
Received: from devianza.investici.org ([198.167.222.108]:38319 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbhKHKEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:04:01 -0500
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4Hnmpc4znpz6vKk;
        Mon,  8 Nov 2021 10:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=insiberia.net;
        s=stigmate; t=1636365672;
        bh=8u/0WuCSB65aowNOnReZL6b8hQXUHeDpmrzDc2JJXjI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=m3uwy+PeMGmTSLyybhYV2cTAV8ooyFfW4UecOWKZoWRrAAIVe6sLe54t2iPaEPpZG
         PMfSTUVS9i0d5zt2iu7aWTxiR9FpzKonNri3B9yKh2011ohW6H0jAVFefniG6IvPfI
         rBxJIkMIHPxpHF/DUeJDh4MjDYPCQxgSlRRLqHq4=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: stefano@distruzione.org) by localhost (Postfix) with ESMTPSA id 4Hnmpc3nv1z6vKg;
        Mon,  8 Nov 2021 10:01:12 +0000 (UTC)
Message-ID: <6b30aaf57cec5b6a72cff1f32d4fe24e47e9754b.camel@insiberia.net>
Subject: Re: [PATCH] Allow selecting amd-pstate without CPU_SUP_INTEL
From:   Stefano Picascia <stefano.picascia@insiberia.net>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 08 Nov 2021 10:01:51 +0000
In-Reply-To: <YYjqNaND8hLGsoXg@hr-amd>
References: <9932762ef184fe132acf176081f8893800c83800.camel@insiberia.net>
         <YYjqNaND8hLGsoXg@hr-amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-08 at 17:13 +0800, Huang Rui wrote:
> On Sat, Nov 06, 2021 at 07:55:29PM +0800, Stefano Picascia wrote:
> > Currently, even if selected, amd-pstate is not enabled unless
> > CPU_SUP_INTEL is also selected, due to ACPI_CPPC_LIB depending on
> > SCHED_MC_PRIO, which in turn depends on CPU_SUP_INTEL
> 
> Actually, amd-pstate driver doesn't depend on SCHED_MC_PRIO. 

amd-pstate doesn't depend on SCHED_MC_PRIO, but ACPI_CPPC_LIB is only
selected when SCHED_MC_PRIO is selected. I guess the issue can be fixed
in a better way, but currently if one compiles the kernel with
CPU_SUP_AMD, but without CPU_SUP_INTEL, ends up with a non functional
amd-pstate. 

Not a problem for distro kernels I guess, but I was puzzled as I wasn't
getting amd-pstate even with a supported processor.

Regards!

