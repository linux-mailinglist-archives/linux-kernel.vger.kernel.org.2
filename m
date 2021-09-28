Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D7C41AD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbhI1LDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240238AbhI1LDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:03:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EE476108F;
        Tue, 28 Sep 2021 11:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632826903;
        bh=4elokg0o9FH5+5sHoV+DUogyPycs4wXHfkpt86cNSUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5UfLHldW5pMxfvjMDqb2cc03GF+hikMXPc9WstlfWt2CclOBSFd9Clp61OC/kE8M
         IfrCo8rmlIfWZBc37ND0v4pKb3+1H6+9quC6YUU8p1EmIBv1R4lqw3IbUBORvs3f5T
         WZm746V0PdiAyaB3GO49VNjXOELsRsvulnchZwvP6K7H7IY52woWEhiIJKsOBIW5mF
         x2Gx7CWToHGAuNZGIGhjFxgcoAtoyyKiL7FD6HUPqbHQZFrcDY+kgZEnMAXzyAf1Pc
         wAWtt7yldFIBXqLdCDYSA66KV3chOYX4jzWutV7aiXF+yW+6qEnjvhVgKrNjvEIomy
         Wq2PL66XVz6lg==
Date:   Tue, 28 Sep 2021 13:01:37 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] module: fix clang CFI with MODULE_UNLOAD=n
Message-ID: <YVL2EXeCKA3Leng+@p200300cbcf144d003adeadfffec0265a.dip0.t-ipconnect.de>
References: <20210927121541.939745-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210927121541.939745-1-arnd@kernel.org>
X-OS:   Linux p200300cbcf144d003adeadfffec0265a.dip0.t-ipconnect.de
 5.13.8-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Arnd Bergmann [27/09/21 14:15 +0200]:
>From: Arnd Bergmann <arnd@arndb.de>
>
>When CONFIG_MODULE_UNLOAD is disabled, the module->exit member
>is not defined, causing a build failure:
>
>kernel/module.c:4493:8: error: no member named 'exit' in 'struct module'
>                mod->exit = *exit;
>
>add an #ifdef block around this.
>
>Fixes: cf68fffb66d6 ("add support for Clang CFI")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks everyone!

Jessica
