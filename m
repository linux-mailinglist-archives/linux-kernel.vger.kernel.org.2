Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B56F30C2D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhBBPA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:00:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234661AbhBBO7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:59:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D96264F59;
        Tue,  2 Feb 2021 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612277946;
        bh=NhRyZzADNGhgivXquiBhUD0Ww63unVcAOhiBA00ZkWM=;
        h=Date:From:To:Cc:Subject:From;
        b=ukSZIGMTENx5UQArnUDFhyuqkE1kJ5U9mkiQBMmYx8ogKsqo+sqNjqwkIfwkh6LHP
         ZxZFjvWtXRBXp5EOrSunWvJjrpLafr3bZO0vpGd8cE8G3naELvrcVGXjib+o8dLalD
         aMJuXQ6Y9AuNpvxW4TI7aILzP8ERjzEg+3Xz+UVtwj15kxn/3gOhX3kLdBalKm2f2B
         a9jMstz9aN3cmfHpRBoabw0t19O4oOCrWZ766jmQWENZ8mOfT1odGRR7TptTqkZ/WX
         8+GYgz67YyzXPUm/Sove30JECXauURJ/OVB5kQGG/2wRznLGVRpOxjsomfWjiJa6Mi
         9rv6w6GmJ/Jsw==
Date:   Tue, 2 Feb 2021 15:58:46 +0100
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clang-format for v5.11-rc7
Message-ID: <20210202145846.GA25454@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A late trivial update, assuming you do an -rc7. Otherwise, it can go
into the merge window.

Cheers,
Miguel

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/clang-format-for-linux-v5.11-rc7

for you to fetch changes up to 1074f8ec288f537f3b8462d09997a69b40f87e38:

  clang-format: Update with the latest for_each macro list (2021-01-29 15:00:23 +0100)

----------------------------------------------------------------
clang-format update

----------------------------------------------------------------
Miguel Ojeda (1):
      clang-format: Update with the latest for_each macro list

 .clang-format | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
