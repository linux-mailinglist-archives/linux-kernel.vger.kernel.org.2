Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CA54411B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 01:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhKAAtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 20:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230178AbhKAAtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 20:49:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42F51610CA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 00:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635727600;
        bh=rcgB7tCbBjzAak2imEHZUqCRLOxaFl7+jwOJRW8ZIYE=;
        h=From:Date:Subject:To:Cc:From;
        b=aj5v2k48h866FWA3p0SwPHnIqNBHcNPxjbZLvkjyEAeLuf2/Znb0DF9tYpJBs4GM9
         5V/3ARNYU95e5vXH8GdeCl+aFgqsQcHnLSWN97nrHvsxEz0TFePTEF1998kL/y7dgm
         4QjiSn4olM2j8RTBU9s46Fzsbn9mW5q7ix3sawkrLAT49Oo3uifJ0LltzRFVr9nnfH
         ubYt7CFcKt9SIfMFxERtVqIhI3pNz3m8Hnfuuf+SoAm5BPTecKFkmxlt98VAPdkwXP
         BrJUcDRdHgh47o4jnmSi53f9pNNOub5SmxOPTjn/3uYLTry8wXQ3IfC+4TmQ8dNtvy
         Lz3ASHkIYud5g==
Received: by mail-oi1-f173.google.com with SMTP id w193so22714798oie.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 17:46:40 -0700 (PDT)
X-Gm-Message-State: AOAM533dQ1H7bYBYMK3xuN5/jNj2lpxot9M2a4U6ZTeQFb41pglUivZB
        Qww/cY4gXIHV+kcvTMegEWJdlICl0HDYgDB0I7c=
X-Google-Smtp-Source: ABdhPJwCJgPzSxB0bbmepMwfWGqMXnfXt+D22JBwwHdrbtcI0TxCz/5GhEvN4PoCCM7DqNb8J6ye7b0eki+lUm94uwY=
X-Received: by 2002:aca:3885:: with SMTP id f127mr23090522oia.65.1635727599612;
 Sun, 31 Oct 2021 17:46:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:31e7:0:0:0:0:0 with HTTP; Sun, 31 Oct 2021 17:46:39
 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 1 Nov 2021 09:46:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8yUBc7iR2NeApaxsmOahh-K_wLs9fva_JgxW8fMp_AnQ@mail.gmail.com>
Message-ID: <CAKYAXd8yUBc7iR2NeApaxsmOahh-K_wLs9fva_JgxW8fMp_AnQ@mail.gmail.com>
Subject: [GIT PULL] exfat update for 5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v5.16-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit 8bb7eca972ad531c9b149c0a51ab43a417385813:

  Linux 5.15 (2021-10-31 13:53:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-5.16-rc1

for you to fetch changes up to 0c336d6e33f4bedc443404c89f43c91c8bd9ee11:

  exfat: fix incorrect loading of i_blocks for large files (2021-11-01
07:49:21 +0900)

----------------------------------------------------------------
Description for this pull request:
 - Fix ->i_blocks truncation issue caused by wrong 32bit mask.

----------------------------------------------------------------
Sungjong Seo (1):
      exfat: fix incorrect loading of i_blocks for large files

 fs/exfat/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
