Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CE74300D3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 09:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243760AbhJPHZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 03:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234387AbhJPHZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 03:25:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F83661101;
        Sat, 16 Oct 2021 07:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634368985;
        bh=Na/z7Ltn27+slBlPaq9aTLbN+gfs2R2C879IfEaXqHc=;
        h=Date:From:To:Cc:Subject:From;
        b=hjNL+RjyaV54GD8g3uSD5SQNZHTHxEy3NU7h1j1GUCNwLftZ3eoMd1kpXS0imljMC
         qgsVynvF7qwWWsdyAp5dDHRRz/agnzJJYJWp5htKAg7QJgnlXG3bf5mEpVZ/aKjp+z
         0dhy5c/GLNO6FQtUJJeEoayeZ7XPpDDxzJYpog31RZtF7w1qNNHdTBG9l3uYwhYJ7p
         CEGM3LzYgT6EwHFRasY74beihHRKLVQU/Smot0lT/p16rz1Eo+RTeKgL1GQ/yFuy2z
         XCOtuk4xCpZYEZWUzi7eUJzzCiptDrPQN8P36maKMYnMzqq4uBkGpon3o+59x4scxn
         Z1fVp7T5mzVFQ==
Date:   Sat, 16 Oct 2021 10:22:57 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [GIT PULL] memblock: fix handling of NOMAP regions with kmemleak
Message-ID: <YWp90alRlwExAmv2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2021-10-16

for you to fetch changes up to 6e44bd6d34d659c44cd8e7fc925c8a97f49b3c33:

  memblock: exclude NOMAP regions from kmemleak (2021-10-13 08:36:59 +0300)

----------------------------------------------------------------
memblock: fix handling of NOMAP regions with kmemleak.

NOMAP regions don't have linear map entries so an attempt to scan these
areas in kmemleak would fault.

Prevent such faults by excluding NOMAP regions from kmemleak.

----------------------------------------------------------------
Mike Rapoport (1):
      memblock: exclude NOMAP regions from kmemleak

 mm/memblock.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
Sincerely yours,
Mike.
