Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CEE3A48BD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhFKSh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhFKSh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:37:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A8D7611CD;
        Fri, 11 Jun 2021 18:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623436558;
        bh=xvjF2NFIqU7JWcgs+GNg0hOn3iyh4sdtJbGq9kaDSw0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IwEMV4RzMy9RadpPz+VQVfysMNHDRUsCYzzwzQJSNbzJyxn39rBUnsfRqSvqMS/QH
         gN8D/zZTWT+0YCOkU2AYdejxeHk5Cf3wRwdPF5lvygUW+Epx4XgQ/n9Lh3UwVwDDD3
         osng6qtSrS2JHZKe12wsIgb9OqNlb+DUKYDuoYNfmizHdVAr2SVrBU/ajni4miaXme
         JXeDpaTuJPmvM5mGwk2qrOdN/PcYxePV92UkffJYHT8TswnUN7hvbiPQ1A3i+plDWI
         kk66PwONOySoVrZSFrUStcaBlDWUQubZhX8Q2H0zw4YiMFELudjH7g4joz3ptEY2OW
         7fQMuM+sTMcCA==
Subject: Re: [patch 03/41] x86/fpu: Remove unused get_xsave_field_ptr()
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
 <20210611163111.288769102@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <23b132a7-3969-8969-1caf-76f81ca9cb1d@kernel.org>
Date:   Fri, 11 Jun 2021 11:35:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210611163111.288769102@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 9:15 AM, Thomas Gleixner wrote:

Reviewed-by: Andy Lutomirski <luto@kernel.org>
