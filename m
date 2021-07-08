Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616D73C14E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 16:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhGHOOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 10:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhGHOOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 10:14:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B248616E8;
        Thu,  8 Jul 2021 14:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625753516;
        bh=1KfomhuDu3CpCxt02QtH0UfkbSugvdEeaTVo//4mN/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYnggQxWY7I+EIuC6fk/4x81z3jDILAu5k/te8z2rsrrLBFYAGTP40WTi7t7BbWg2
         FzUj7AL0LzIjRd+lro4VjE8K3hvUMnfllVGwIVsWPbYSvyldoAEhilBYiR0y9rZ9di
         KkFREOBfxsPKwqfoECemNDcjC42ANxqnJXWvlnOxvEZSeIthVPU9RX9ecpxmyNzpLF
         c8jjohxmVrdmjya8Lfah/m5DlGbj7D9g3mTe4ArWFes1WMdZuDYy+wZtIDoXoUOTVH
         Cm19kxpxXYAjk952W6LOaEb6VyV4FK5p649DA0MGMCedXJfmpdaA+zMAlMTO02konZ
         kw8ArFCxLQlUg==
Date:   Thu, 8 Jul 2021 16:11:51 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Reiner Huober <reiner.huober@nokia.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: combine constructors in module linker script
Message-ID: <YOcHp2+4e9S6lLH8@p200300cbcf044300404ca642de146c7c.dip0.t-ipconnect.de>
References: <1625576575-1008-1-git-send-email-reiner.huober@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1625576575-1008-1-git-send-email-reiner.huober@nokia.com>
X-OS:   Linux p200300cbcf044300404ca642de146c7c.dip0.t-ipconnect.de
 5.12.10-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Reiner Huober [06/07/21 15:02 +0200]:
>The constructor code for modules must be aware of init code inside
>different sections.
>
>Newer GCC compilers write constructors in more than one section,
>e.g. ".ctors.65435". These must be combined into a single
>".ctors" section. In the module loader, only the ".ctors" section
>is searched and the constructors therein are initialized, when
>CONFIG_CONSTRUCTORS=y is set. Other constructors are ignored.
>
>This change combines all ".ctors.*" and the ".ctors" section, if any,
>in <module>.ko into a single ."ctors" section.
>
>For code coverage in GCC, this is necessary to show the
>code coverage for modules, since code coverage uses such
>constructors when initializing a module in newer version of GCC.
>
>Signed-off-by: Reiner Huober <reiner.huober@nokia.com>

Thanks, I'll queue this up after the merge window is over.

Jessica
