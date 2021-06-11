Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845FC3A48BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFKSh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhFKSh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:37:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 015CF611CD;
        Fri, 11 Jun 2021 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623436529;
        bh=HAwSF8NyeXcIr+7p9Exe0vYwuUxOBxfo0+C2HRUo8yk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tCu0p5zyarBtJ5DoQh5jpJI5VF9gP2j6prDl8uCNB/4ycyKF4JgxNICCRHAjuV4ay
         8/2GRTfk0lnm3CNjtc2wlmmbqRQyRjFXD1Bho9UYOXTV/DNN0fCpQPhH5xU3VY06iy
         mtqdOLs8Gz7tKW/kGohB6RzWIzyPocri5Rp4vQCI2H/Z5Fs5eKXaqWmWfoIlSDGsmR
         BEnULf9FpP4/iDqYDHvaCReC+fZPToZs1V/MwQRsSUCdsCr06I4W53Xm8epFXEkC1Z
         8UTMuGdAykoU5EK6sSur3mVOkZ4NyTH+MdSe7taC2DRaE/GANB21esZ269slINauMU
         xc2SgEPgSDO/w==
Subject: Re: [patch 02/41] x86/fpu: Mark various FPU states __ro_after_init
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210611161523.508908024@linutronix.de>
 <20210611163111.130178710@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <44e818d9-bbdc-a4d2-cb0d-825aea5ebf41@kernel.org>
Date:   Fri, 11 Jun 2021 11:35:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210611163111.130178710@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 9:15 AM, Thomas Gleixner wrote:
> Nothing modifies these after booting.
> 

Reviewed-by: Andy Lutomirski <luto@kernel.org>
