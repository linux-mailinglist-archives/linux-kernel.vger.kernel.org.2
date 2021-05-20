Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D24838B9EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 01:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhETXDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 19:03:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56012 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232628AbhETXDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 19:03:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621551728; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=pisM6KYls1v5AvliFgn9qOzxbjtfnUwMBY5Kn3jUpfI=; b=uF0FzHDye21JzOcprTGDtu8ptJIlUYJUmxERQ2IpNd7rPg1IM1XLnlgGl+gQMwZbB+Cd9T8H
 on6rrKvNxT85rVgMjJWnEhJkcxMXQaZVccd70nv6eiHCETiVABIARiWlBSINnHqLg7yfr+Gm
 3jwz6fT2WrylYQMphC3XrnYZhe0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60a6ea6c60c53c8c9d279def (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 May 2021 23:02:04
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0681C433D3; Thu, 20 May 2021 23:02:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73250C4338A;
        Thu, 20 May 2021 23:02:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 May 2021 16:02:03 -0700
From:   psodagud@codeaurora.org
To:     catalin.marinas@arm.com, will@kernel.org, Dave.Martin@arm.com,
        amit.kachhap@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: sve_user_discard
Message-ID: <785d7bc29da6bff0dceeb712c24601fd@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is regarding sve_user_disable(CPACR_EL1_ZEN_EL0EN) on every system 
call.  If a userspace task is using SVE instructions and making sys 
calls in between, it would impact the performance of the thread. On 
every SVE instructions after SVC/system call, it would trap to EL1.

I think by setting CPACR_EL1_ZEN_EL0EN flag,  the processor faults when 
it runs an SVE instruction. This approach may be taken as part of FPSIMD 
registers switching optimizations.  Can below portion of the code use 
thread.fpsimd_cpu and fpsimd_last_state variables to avoid clearing 
CPACR_EL1_ZEN_EL0EN for this kind of use cases?

static inline void sve_user_discard(void)
{
	if (!system_supports_sve())
		return;

	clear_thread_flag(TIF_SVE);

	/*
	 * task_fpsimd_load() won't be called to update CPACR_EL1 in
	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which only
	 * happens if a context switch or kernel_neon_begin() or context
	 * modification (sigreturn, ptrace) intervenes.
	 * So, ensure that CPACR_EL1 is already correct for the fast-path case.
	 */
	sve_user_disable();
}

-Thanks, Prasad
