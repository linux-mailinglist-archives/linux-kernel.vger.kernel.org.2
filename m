Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C424041C1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245080AbhI2Jcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhI2Jca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:32:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 254E661407;
        Wed, 29 Sep 2021 09:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632907843;
        bh=qoR8rruErp26ABUtn9zVAJkjQ5jP3VhXepiuJ2UQNmk=;
        h=Date:From:To:Cc:Subject:From;
        b=ndgJKFJwP4argBO0VBkwGMu0+iTZuaFSjDdcsQKSEiCvGJRN8PKkG8zxmv9LSczbc
         1z+EsaHehi04q8Na0XF6Qy0/kMhDaKHOWbiH0LJ5dAN3Nf80dO4B4PYLON7Rn9DKTZ
         /CrYI8QM1/iaqXSXq4ARUja5kddGdj+xzXmWrA74qqKDZfH54zj20fB77HPlfOSD43
         0KRgmVtOOJxbEAuBJBWoxM77JOsKGnSIQ6tu35BjMYcEzKjFYwvvC4fLyhxxaRqcSf
         sWMQfzw5gUiNLLOwDL82QEvig2FeFPpG0FLaPuRLZS0639gPexjBh3YKIRZ3fAtojj
         fn6QETz5q9oiQ==
Date:   Wed, 29 Sep 2021 12:30:39 +0300
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.15-rc4
Message-ID: <20210929093039.GA108003@ogabbay-vm2.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

One important fix for the habanalabs driver for 5.15.
It fixes an issue where we return -EINTR in the IOCTL that waits
on command submission completion, and the user-space will try
to immediately call that IOCTL again with the same
arguments structure it used in the previous call. More details
in the commit itself.

Thanks,
Oded

The following changes since commit bb8a4fcb2136508224c596a7e665bdba1d7c3c27:

  ipack: ipoctal: fix module reference leak (2021-09-27 17:38:49 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-09-29

for you to fetch changes up to 4ca57d5139a0be3cf76c1667a4c0afb16d4a3b02:

  habanalabs: fix resetting args in wait for CS IOCTL (2021-09-29 12:18:48 +0300)

----------------------------------------------------------------
This tag contains the following fix for 5.15-rc4:

- Prevent memset of ioctl arguments in case driver returns -EINTR

----------------------------------------------------------------
Rajaravi Krishna Katta (1):
      habanalabs: fix resetting args in wait for CS IOCTL

 .../misc/habanalabs/common/command_submission.c    | 33 +++++++++++++---------
 include/uapi/misc/habanalabs.h                     |  6 ++--
 2 files changed, 21 insertions(+), 18 deletions(-)
