Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A23F43DAB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 07:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhJ1F3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 01:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhJ1F3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 01:29:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29DFE60E78;
        Thu, 28 Oct 2021 05:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635398831;
        bh=MtTLArIPjcJ9E+brocSHHX3I38Thwsm8UwOwnaormZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6PMRBm2hK1xXfKbmUKegEDLjI8SYviUQdvqJOkcDJkmPRBjSzWp6POGuOdujd9Jt
         LNLzs+sDsOWK8ANE/V7JSp6TYthhVpJP/1Bcm3LNLOGL1Zuu8cl068StDSzh1NfWbn
         w1Ez3AuS9/B0k6cuG26f3Hu6SVW4uhuIKdOPO5Lo=
Date:   Thu, 28 Oct 2021 07:27:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Colin Ian King <colin.king@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arch/Kconfig: Make CONFIG_CPU_SPECTRE available
 for all architectures
Message-ID: <YXo0qv28Xykj718l@kroah.com>
References: <cover.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <232b692cd79e4f6e4c3ee7055b5f02792a28d2c4.1635383031.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <232b692cd79e4f6e4c3ee7055b5f02792a28d2c4.1635383031.git.pawan.kumar.gupta@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 06:33:22PM -0700, Pawan Gupta wrote:
> Borrow CONFIG_CPU_SPECTRE from ARM to be available for all
> architectures. This will help in configuration of features that depend
> on CPU being affected by spectre class of vulnerabilities.
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/Kconfig        | 3 +++
>  arch/arm/mm/Kconfig | 3 ---
>  arch/x86/Kconfig    | 1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)

You forgot to cc: the bpf list for this.

greg k-h
