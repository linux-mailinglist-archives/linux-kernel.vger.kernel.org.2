Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F1A3106E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhBEIkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:40:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52185 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBEIjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:39:42 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l7wdf-0005vk-5p; Fri, 05 Feb 2021 08:38:51 +0000
Date:   Fri, 5 Feb 2021 09:38:50 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andreas Oetken <ennoerlangen@googlemail.com>
Cc:     Ley Foon Tan <ley.foon.tan@intel.com>,
        linux-kernel@vger.kernel.org,
        Andreas Oetken <ennoerlangen@gmail.com>,
        Andreas Oetken <andreas.oetken@siemens.com>
Subject: Re: [PATCH] nios2: fixed broken sys_clone syscall
Message-ID: <20210205083850.d5tcnyawnxismwfn@wittgenstein>
References: <20210205082338.584931-1-ennoerlangen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210205082338.584931-1-ennoerlangen@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 09:23:38AM +0100, Andreas Oetken wrote:
> From: Andreas Oetken <andreas.oetken@siemens.com>
> 
> The tls pointer must be pushed on the stack prior to calling nios2_clone
> as it is the 5th function argument. Prior handling of the tls pointer was
> done inside former called function copy_thread_tls using the r8 register
> from the current_pt_regs directly. This was a bad design and resulted in
> the current bug introduced in 04bd52fb.
> 
> Fixes: 04bd52fb ("nios2: enable HAVE_COPY_THREAD_TLS, switch to kernel_clone_args")
> Signed-off-by: Andreas Oetken <andreas.oetken@siemens.com>
> ---

Thanks for catching this!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
