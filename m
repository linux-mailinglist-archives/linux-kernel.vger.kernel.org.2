Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C869366B41
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbhDUMwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:52:41 -0400
Received: from elvis.franken.de ([193.175.24.41]:35182 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239999AbhDUMwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:52:32 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lZCKf-0004Cw-01; Wed, 21 Apr 2021 14:51:53 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2168AC0840; Wed, 21 Apr 2021 14:01:30 +0200 (CEST)
Date:   Wed, 21 Apr 2021 14:01:30 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     jiaxun.yang@flygoat.com, chenhuacai@kernel.org,
        viro@zeniv.linux.org.uk, morbo@google.com, paul@crapouillou.net,
        alobakin@pm.me, suxingxing@loongson.cn, tangyouling@loongson.cn,
        yangtiezhu@loongson.cn, ralf@linux-mips.org, nathan@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MIPS: Makefile: Replace -pg with CC_FLAGS_FTRACE
Message-ID: <20210421120130.GB8637@alpha.franken.de>
References: <20210420070052.25593-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420070052.25593-1-zhaoxiao@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 03:00:52PM +0800, zhaoxiao wrote:
> This patch replaces the "open-coded" -pg compile flag with a CC_FLAGS_FTRACE
> makefile variable which architectures can override if a different option
> should be used for code generation.
> 
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
> v3:Modify the description for the patch.
>  arch/mips/boot/compressed/Makefile | 2 +-
>  arch/mips/kernel/Makefile          | 8 ++++----
>  arch/mips/vdso/Makefile            | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
