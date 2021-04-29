Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD7236EBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbhD2ODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbhD2ODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:32 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970B9C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:02:44 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FWHJK6k2Bz9sX2; Fri, 30 Apr 2021 00:02:41 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Mackerras <paulus@samba.org>
In-Reply-To: <20210426203518.981550-1-nathan@kernel.org>
References: <20210426203518.981550-1-nathan@kernel.org>
Subject: Re: [PATCH] powerpc: Avoid clang uninitialized warning in __get_user_size_allowed
Message-Id: <161970488758.4033873.8885072573106528353.b4-ty@ellerman.id.au>
Date:   Fri, 30 Apr 2021 00:01:27 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021 13:35:18 -0700, Nathan Chancellor wrote:
> Commit 9975f852ce1b ("powerpc/uaccess: Remove calls to __get_user_bad()
> and __put_user_bad()") switch to BUILD_BUG() in the default case, which
> leaves x uninitialized. This will not be an issue because the build will
> be broken in that case but clang does static analysis before it realizes
> the default case will be done so it warns about x being uninitialized
> (trimmed for brevity):
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Avoid clang uninitialized warning in __get_user_size_allowed
      https://git.kernel.org/powerpc/c/f9cd5f91a897ea0c45d0059ceeb091cee78c6ebe

cheers
