Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321B539A669
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 18:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhFCQ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 12:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhFCQ5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 12:57:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D31461026;
        Thu,  3 Jun 2021 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622739368;
        bh=1PQR9bfCxPmC0K7hW2iSOSzDxHfBITHjwssboezTnTY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j+TD6BKL3d7mcO5MyDuAgUORXK7tSd50WZuiOTul/ZnYvRkvw04yRQd9ojguhb7xS
         zFGp1X5XHl5oV6pH0My41RUxyAnZ7zUHMHWkk2oy/l4++Pk74HshfoMyTfpl9fyzwh
         2xAa051qBK8ZEn75Vni5jD1wF0E7k5cXb89nGIXtPs7shi96jpehx6DaScJepNHyHA
         L6vkquK3ZiOFtdGN9qwOWuIbpiekgErVv7q0bLfupuMeFQT5ALzF4LtBOO4XfWMna1
         kr6Ou4HPYnbyyKSV2bQDcT1VInIOzda50zfbwKm7oFnjdiEe7Gckje1dhGf7RcMRKl
         B5fTARro0zcJQ==
Subject: Re: [patch 8/8] x86/fpu: Deduplicate copy_xxx_to_xstate()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20210602095543.149814064@linutronix.de>
 <20210602101619.182960608@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <89f357c5-1465-29d5-c71e-75fa2a82a8c2@kernel.org>
Date:   Thu, 3 Jun 2021 09:56:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602101619.182960608@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 2:55 AM, Thomas Gleixner wrote:
> copy_user_to_xstate() and copy_kernel_to_xstate() are almost identical
> except for the copy function.
> 
> Unify them.

I keep looking at call sites of these functions and being vaguely
confused.  Maybe copy_to_userabi_xstate() would make the purpose of
these functions clearer?

Otherwise, and even if you don't like my suggestion:

Acked-by: Andy Lutomirski <luto@kernel.org>
