Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214913A15F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhFINr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233681AbhFINr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:47:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36D84610A2;
        Wed,  9 Jun 2021 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623246364;
        bh=6ZyxKHt4bLHWqLdOa8RgRW+J9inPMpdJPn3fuW/PUB4=;
        h=Date:From:To:Cc:Subject:From;
        b=fcEVtD83eP3vm/XEIqCI06JrYxXNOgk4pvbYYBuWu9pHdIuNhELa48GAcmG+9tNxm
         YoWQmj3Agoe3rZkfN9iaZLEADOIUU9BB+H+hQn3nUHabt5gDxb4WsYY/752OAzDydE
         e1duQYXCi2MIVeniB7iqrmBYNtWGaim2GNwSMPyPpX058mCa1ViYqxtRcBqik0f3in
         03GwqCYUusQsepLD2Csm0uuZ9KyyoPORJYnnpIjWNNMyEKTX8YCc/fXQnwZkEO+yJI
         3r8DqAq+mCIP6tHHWQNmq+wDvTnxS3lwmGqtS8Jev9ecvVl7A9fLf2WzQEurMkQA4X
         D82mkuXmQA2XA==
Date:   Wed, 9 Jun 2021 15:45:52 +0200
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Ming Chen <jj251510319013@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Compiler Attributes for v5.13-rc6
Message-ID: <20210609134552.GA4847@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this trivial update for the compiler attributes.

Cheers,
Miguel

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.13-rc6

for you to fetch changes up to ca0760e7d79e2bb9c342e6b3f925b1ef01c6303e:

  Compiler Attributes: Add continue in comment (2021-05-12 20:18:46 +0200)

----------------------------------------------------------------
A trivial update to the compiler attributes:

  - Add continue in comment (from Wei Ming Chen)

----------------------------------------------------------------
Wei Ming Chen (1):
      Compiler Attributes: Add continue in comment

 include/linux/compiler_attributes.h | 1 +
 1 file changed, 1 insertion(+)
