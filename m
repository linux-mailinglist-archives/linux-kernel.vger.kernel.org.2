Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4000F419527
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhI0NgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:36:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33082 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhI0NgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:36:02 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id 58884200FB;
        Mon, 27 Sep 2021 13:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632749663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x3vMfvWadaNokYsZFv/qttPpg+8T11uFbVvjR0mtxDA=;
        b=DYR138EClhQud7GMJv/nceDVuoziIDrW1E2V6snusD4adI7tklblrlHRugA5k/TwzqXM47
        UtypAVEtPl0aa4Zx/P/gNpqA81Ae+4apzRFvN1asxySpptbP2uDOhRFkyFaD5kVvPhd1DZ
        ZR7O86evXuHhJJX6E/dtWBtkci/nkxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632749663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x3vMfvWadaNokYsZFv/qttPpg+8T11uFbVvjR0mtxDA=;
        b=oCAw4JMs5v0FIiVdy17zPjrH7+2vAPkmOiHGDxRsgtlzJT023Gew1U4PKjG6xpmz7XYpyW
        9H6UI6wRL7espHBQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id 08BF825D45;
        Mon, 27 Sep 2021 13:34:23 +0000 (UTC)
Date:   Mon, 27 Sep 2021 15:34:22 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] module: fix clang CFI with MODULE_UNLOAD=n
In-Reply-To: <20210927121541.939745-1-arnd@kernel.org>
Message-ID: <alpine.LSU.2.21.2109271534060.5803@pobox.suse.cz>
References: <20210927121541.939745-1-arnd@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_MODULE_UNLOAD is disabled, the module->exit member
> is not defined, causing a build failure:
> 
> kernel/module.c:4493:8: error: no member named 'exit' in 'struct module'
>                 mod->exit = *exit;
> 
> add an #ifdef block around this.
> 
> Fixes: cf68fffb66d6 ("add support for Clang CFI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
