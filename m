Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BB6447E38
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbhKHKsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:48:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229754AbhKHKsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:48:41 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD98361360;
        Mon,  8 Nov 2021 10:45:57 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mk29z-00482K-Ns; Mon, 08 Nov 2021 10:45:55 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     kvmarm@lists.cs.columbia.edu, kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH] arm64: kvm/hyp/nvhe: fix a non-kernel-doc comment
Date:   Mon,  8 Nov 2021 10:45:52 +0000
Message-Id: <163636833368.2539547.13494193613344382138.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211106032529.15057-1-rdunlap@infradead.org>
References: <20211106032529.15057-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, rdunlap@infradead.org, kvmarm@lists.cs.columbia.edu, lkp@intel.com, linux-arm-kernel@lists.infradead.org, tabba@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2021 20:25:29 -0700, Randy Dunlap wrote:
> Do not use kernel-doc "/**" notation when the comment is not in
> kernel-doc format.
> 
> Fixes this docs build warning:
> 
> arch/arm64/kvm/hyp/nvhe/sys_regs.c:478: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * Handler for protected VM restricted exceptions.

Applied to next, thanks!

[1/1] arm64: kvm/hyp/nvhe: fix a non-kernel-doc comment
      commit: deacd669e18a51cb2085450c56d851aef72b3256

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


