Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E59446E11
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 14:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhKFNiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 09:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234224AbhKFNiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 09:38:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 405C061101;
        Sat,  6 Nov 2021 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636205734;
        bh=PlN9LLXvybfSG7U++33bUZq71PSO7CGO78d4A6IQEkE=;
        h=Date:From:To:Cc:Subject:From;
        b=Ek17PabkXxPTqY73iz2jzaKMXsW1Q1UrqQ56VN0REXZBnCZAFtNDLPSNTfx8zZ+jR
         1+S1kDxMw036GAC97zlM89OOvWuoQspsPP2A6DLBqX1L3ydfQLyUJ+pkn/vNlGrzVN
         qSgzTuI8GvUDYl5EfiLH1fk3oakE/Z0PQjWFgsVYyXy3N7Hqzjr+YWamnG1yKtKGVR
         DdpWSIm0jpdLgyci0v3crEaVNV71yTqGvPK37YB4Nbg6qXE7CGlyN9Pm25vKXNOoE3
         yFna4UZkgaojoZUaFA3o+SKMrasKkuB/yyP2h1V2ZRF32NQ+4kFB198umNBboB5rwR
         ac9KGr2ATm61g==
Date:   Sat, 6 Nov 2021 14:35:23 +0100
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Compiler Attributes for v5.16
Message-ID: <20211106133345.GA15102@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.16

for you to fetch changes up to 7c00621dcaeea206d7489b3e8b50b1864841ae69:

  compiler_types: mark __compiletime_assert failure as __noreturn (2021-10-22 01:16:58 +0200)

----------------------------------------------------------------
An improvement for __compiletime_assert and a trivial cleanup
----------------------------------------------------------------
Miguel Ojeda (2):
      Compiler Attributes: remove GCC 5.1 mention
      compiler_types: mark __compiletime_assert failure as __noreturn

 include/linux/compiler_attributes.h | 1 -
 include/linux/compiler_types.h      | 8 +++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)
