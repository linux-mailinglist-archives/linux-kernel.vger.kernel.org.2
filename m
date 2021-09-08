Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A4E4041E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 01:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244560AbhIHXuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 19:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233834AbhIHXug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:50:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E264B61157;
        Wed,  8 Sep 2021 23:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631144968;
        bh=qFd6rM3whVeSqofp8QV4rz4l/SwmbW/WN77ENeeorfA=;
        h=Date:From:To:Cc:Subject:From;
        b=pvxmqgKcqZI8Qw9fghMDM+n1GrfZpnGAMKShq0QEA/xuL5OcE9dHtn6yXodyNCvFV
         q21elM9KzDaF1HzpBNRJvv6KAxF1bPkLE8+EpfD+yP4z5pwlxNH1qnjqbrW97lpDW8
         26alWZ1UXI+KhZKbq9zh54vBoHvUHCjjcwq5/nnid9ahYclLXSnA5BcgNW3R3zWypq
         t2wMPYiEpiZVrHLGy743E9wvo75otPMfdR9uuqrBUGwySK/MtRACBsATZlT9JYvRi/
         gFiasq3Y5YFiC8nH1iLsY28MukzkgQ7/6PdDZY6Kn3grDDFkGiU9Y2jK4sddn0Z4WD
         Ktk9YVIvcmd/w==
Date:   Thu, 9 Sep 2021 01:49:14 +0200
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Compiler Attributes for v5.15-rc1
Message-ID: <20210908234751.GA8052@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pick up the following fix for GCC 4.

I have had this in my tree for a while... you will find an easy conflict.

Cheers,
Miguel

The following changes since commit 62fb9874f5da54fdb243003b386128037319b219:

  Linux 5.13 (2021-06-27 15:21:11 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.15-rc1

for you to fetch changes up to 7ed012969bbcdbd7aef5778a061681e6cbc4b402:

  Compiler Attributes: fix __has_attribute(__no_sanitize_coverage__) for GCC 4 (2021-07-16 01:06:44 +0200)

----------------------------------------------------------------
A Compiler Attributes fix:

  - Fix __has_attribute(__no_sanitize_coverage__) for GCC 4 (Marco Elver)

----------------------------------------------------------------
Marco Elver (1):
      Compiler Attributes: fix __has_attribute(__no_sanitize_coverage__) for GCC 4

 include/linux/compiler_attributes.h | 1 +
 1 file changed, 1 insertion(+)
