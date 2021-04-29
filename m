Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BE236E9AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhD2Lhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 07:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhD2Lhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 07:37:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96B196143D;
        Thu, 29 Apr 2021 11:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619696225;
        bh=OimQREtAsCbCtjwcO3nlmksyWqWkBSZ3W40b1WBierI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C1a0aoHHOLESde2VuJKdnOGY8TH8fcL2tHaLTt2EXxN4KTYR0ziynLtLxpbfuXpMC
         IHmPss4MSGXLMvHoc1CousLn/fbVAnWrjQZ3NaaK0WJyfYTtAMBxdKs04KRqCW8BEM
         YDtmxhwyf6B3kBwLuPn5gn+nTitVyHZHelCW7AqOf810qZ74xZ/U3NZked5FZkTTdX
         UyckX56sQJJI1i0aKJ6D4nZee9xQwY8iTFbfT8ZlSU9BbCeYXdc9m8Z43qyE0EfwBz
         OwXYJt9VZsFHOja1nmrdjUi4tcfDPgnb/iIrsoxOM2gaFy5i9oRzujYjmSDymZVor2
         8fNxVnx8WyPvA==
Date:   Thu, 29 Apr 2021 13:37:01 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Modules updates for v5.13
Message-ID: <YIqaXbAY9iHrjscS@gunter>
References: <YIlcBHhuR9LvKZ7q@gunter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YIlcBHhuR9LvKZ7q@gunter>
X-OS:   Linux gunter 5.11.16-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jessica Yu [28/04/21 14:58 +0200]:
>Hi Linus,
>
>Please pull below to receive modules updates for the v5.13 merge window.
>A summary can be found in the signed tag.
>
>Thank you,
>
>Jessica

Ugh, I had forgotten to sign the tag. Should be fixed now, sorry about that.

>--
>The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:
>
>  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)
>
>are available in the Git repository at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.13
>
>for you to fetch changes up to 33121347fb1c359bd6e3e680b9f2c6ced5734a81:
>
>  module: treat exit sections the same as init sections when !CONFIG_MODULE_UNLOAD (2021-03-29 13:08:53 +0200)
>
>----------------------------------------------------------------
>Modules updates for v5.13
>
>Summary of modules changes for the 5.13 merge window:
>
>- Fix an age old bug involving jump_calls and static_labels when
>  CONFIG_MODULE_UNLOAD=n. When CONFIG_MODULE_UNLOAD=n, it means you
>  can't unload modules, so normally the __exit sections of a module are
>  not loaded at all. However, dynamic code patching (jump_label,
>  static_call, alternatives) can have sites in __exit sections even if
>  __exit is never executed.
>
>  Reported by Peter Zijlstra: "Alternatives, jump_labels and static_call
>  all can have relocations into __exit code.  Not loading it at all would
>  be BAD." Therefore, load the __exit sections even when
>  CONFIG_MODULE_UNLOAD=n, and discard them after init.
>
>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>
>----------------------------------------------------------------
>Jessica Yu (1):
>      module: treat exit sections the same as init sections when !CONFIG_MODULE_UNLOAD
>
> kernel/module.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
