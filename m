Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5CC3F0528
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhHRNrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbhHRNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:46:46 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E84C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 06:46:09 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GqTgx1N3Mz9t0J; Wed, 18 Aug 2021 23:46:04 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bill Wendling <morbo@google.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
In-Reply-To: <20210729141937.445051-1-masahiroy@kernel.org>
References: <20210729141937.445051-1-masahiroy@kernel.org>
Subject: Re: [PATCH 1/3] powerpc: remove unused zInstall target from arch/powerpc/boot/Makefile
Message-Id: <162929389129.3619265.1911733142384487798.b4-ty@ellerman.id.au>
Date:   Wed, 18 Aug 2021 23:38:11 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2021 23:19:35 +0900, Masahiro Yamada wrote:
> Commit c913e5f95e54 ("powerpc/boot: Don't install zImage.* from make
> install") added the zInstall target to arch/powerpc/boot/Makefile,
> but you cannot use it since the corresponding hook is missing in
> arch/powerpc/Makefile.
> 
> It has never worked since its addition. Nobody has complained about
> it for 7 years, which means this code was unneeded.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc: remove unused zInstall target from arch/powerpc/boot/Makefile
      https://git.kernel.org/powerpc/c/156ca4e650bfb9a4259b427069caa11b5a4df3d4
[2/3] powerpc: make the install target not depend on any build artifact
      https://git.kernel.org/powerpc/c/9bef456b20581e630ef9a13555ca04fed65a859d
[3/3] powerpc: move the install rule to arch/powerpc/Makefile
      https://git.kernel.org/powerpc/c/86ff0bce2e9665c8b074930fe6caed615da070c1

cheers
