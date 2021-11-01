Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE7A4422F1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhKAV7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232113AbhKAV7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:59:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05B9461053;
        Mon,  1 Nov 2021 21:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635803798;
        bh=1yvbeSAe6FYPXVyBLDYNYxnS3QQk38yTPaCZ9PMZ5Jw=;
        h=Date:From:To:Cc:Subject:From;
        b=OeSjcnfgG0/o5JqTZQxvG6rtlILnMsD5gT0EYKz6ePfzy4aq7qYbBk3V9WpDRKAa2
         5C71MqAl5Nc6OSFdCHUKzLpYIhSYHovgxhJZL/0ZPstYgqAZXi0lhFWVfvUe6yWuBH
         nHy7Tq3WXHAJqFv4jhjhGlRqDtr5X5Ox9MBr7hBm/og/SDen//8NICa/xjNC0ifVaW
         QI4+SS2Z/fJ+0yUJO0+sdSqIRUUXJsVIA3WrmWrLeW/a8V0SEmSO1acXlr2KBiXSWm
         SAcfdLMxRFypE8lYyDjKC1Jv5RBNh5odWqexHJKeFIb4NRkHm5wH5c/91xrVxXhVyc
         YmfRRAnnOznuA==
Date:   Mon, 1 Nov 2021 17:01:20 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] fallthrough fixes for Clang for 5.16-rc1
Message-ID: <20211101220120.GA30083@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.16-rc1

for you to fetch changes up to 02900f428d3c7acd89b77784bec33ddec7b750a4:

  pcmcia: db1xxx_ss: Fix fall-through warning for Clang (2021-10-13 14:47:48 -0500)

----------------------------------------------------------------
fallthrough fixes for Clang for 5.16-rc1

Hi Linus,

Please, pull the following patches that fix some fall-through warnings
when building with Clang and -Wimplicit-fallthrough.

Thanks!
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (3):
      scsi: st: Fix fall-through warning for Clang
      MIPS: Fix fall-through warnings for Clang
      pcmcia: db1xxx_ss: Fix fall-through warning for Clang

 arch/mips/alchemy/devboards/db1550.c | 1 +
 arch/mips/kernel/uprobes.c           | 1 +
 drivers/pcmcia/db1xxx_ss.c           | 1 +
 drivers/scsi/st.c                    | 1 +
 4 files changed, 4 insertions(+)
