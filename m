Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F563D3095
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 01:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhGVXRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 19:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232550AbhGVXRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 19:17:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73C8260EB5;
        Thu, 22 Jul 2021 23:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626998284;
        bh=W7xDEKQqQkjOWY2rHAJi9xU5DJUMk3onw3Ns+E4AjnU=;
        h=Date:From:To:Cc:Subject:From;
        b=W2KtvzoSuglhZ1X9iGTQFXLBo+I3ikOPAmD1rR8UYUO+rn2+K0VyPUSU6oPLHmhN9
         r+NmnHz+qohhUD8LASQR4whQq74RjPmsBVTa4MwSQMbQ8/hWXQeLxy37R2lTqQ3lz2
         v0wBDvLp/6PhHlNs4FEMnTKn9hSzt81gYVrYNCgYgW1GY2U++bpyy7DIONCmVqovnO
         9d8OICoB1GxmervwMUIz33hZEeByBdbVXmtszENAodzJTfSSkFggFW4EL85Xvr84Lp
         vDJ+MPYyUp2Ep+7HDeaPrP5l511PmhrHspTbyvsEDZAEdWGCDhEU7ck79KvknG06B/
         xBhD+sxciP8sg==
Date:   Thu, 22 Jul 2021 19:00:27 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] fallthrough fixes for Clang for 5.14-rc3
Message-ID: <20210723000027.GA40195@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.14-rc3

for you to fetch changes up to 615c77eb5e870d1ffa95f4001cba3612bd2f2332:

  powerpc/pasemi: Fix fall-through warning for Clang (2021-07-19 16:47:03 -0500)

----------------------------------------------------------------
fallthrough fixes for Clang for 5.14-rc3

Hi Linus,

Please, pull the following patch that fixes a fall-through warning
when building with Clang and -Wimplicit-fallthrough on PowerPC.

Thanks

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      powerpc/pasemi: Fix fall-through warning for Clang

 arch/powerpc/platforms/pasemi/idle.c | 1 +
 1 file changed, 1 insertion(+)
