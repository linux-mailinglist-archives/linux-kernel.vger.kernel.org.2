Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC6739CEED
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhFFMPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhFFMOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:14:09 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F999C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:12:19 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb3N2vCrz9sXh; Sun,  6 Jun 2021 22:12:16 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Fangrui Song <maskray@google.com>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, clang-built-linux@googlegroups.com,
        Paul Mackerras <paulus@samba.org>
In-Reply-To: <20210518205858.2440344-1-ndesaulniers@google.com>
References: <20210518205858.2440344-1-ndesaulniers@google.com>
Subject: Re: [PATCH] powerpc: Kconfig: disable CONFIG_COMPAT for clang < 12
Message-Id: <162298132108.2353459.12234342332245763294.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:41 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 13:58:57 -0700, Nick Desaulniers wrote:
> Until clang-12, clang would attempt to assemble 32b powerpc assembler in
> 64b emulation mode when using a 64b target triple with -m32, leading to
> errors during the build of the compat VDSO. Simply disable all of
> CONFIG_COMPAT; users should upgrade to the latest release of clang for
> proper support.

Applied to powerpc/next.

[1/1] powerpc: Kconfig: disable CONFIG_COMPAT for clang < 12
      https://git.kernel.org/powerpc/c/6fcb574125e673f33ff058caa54b4e65629f3a08

cheers
