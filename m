Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07B321ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhBVSKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhBVSKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:10:07 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E52DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 10:09:27 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id l3so14915776oii.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 10:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=ob/B2XIiNAwwgFUjON50dpjSxQziIkc4+9+tj/Bnuyc=;
        b=gcgblNV8LrOGKV9pLG+o44PAHWS0JDA3vEkv6KQZjSr98clvc+tA5P1faxuNy6Zeg+
         esQkeYAW6kfiCz4kKY0Da7s7jd2+X36VTVxy7s4IaAdz0U0W1eFn2xjBEQYDnye1IA3Y
         AZ6L88xZNF6yksuS6xRjiUYbUc0SrnfYM9/ANp9pvzTy00FVbnmfWISlEgJPOtYBRNPv
         8Sk2rUtSX+7/t3GKHT29UmEpXcK3KdfFF6hoywo89izE3RSBfOPcNf0hHH7+568XVAJM
         vLJY4wXjq3ui5+B/4GVfkiaPHl2SOeV0oCDR4Fdn87C/Rgl4zzXILz6mgNcF+uiq2bHi
         juzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition;
        bh=ob/B2XIiNAwwgFUjON50dpjSxQziIkc4+9+tj/Bnuyc=;
        b=tqAzGpa9Je0oj+XcGpPhqZUbNgUnwyffc8EgxiU7K1UVX7AxuhWZ4DjZ2+nnVlnmWn
         aANMjNJ+w1jHZXIFSHI3na6t4mBYStasNR/7rjy/4L8w0eMNx/usnsqty6f/rq2wHQmT
         aPHhoRFcNSt1hvNn7C0t4Q7lcgCgV7BMWWoSss65O7LRXrAfxi3crMoU2mTn0y6HmIm9
         RGQBJOAKGpzmHRv33XqriAMdkNArevA2lZ5aZcGohTWsfr0Y5ONvFnJoH04WbJjVIMfn
         zvCK0TInydth09uvJEZN5le1fbFbTdGJ2J/XrUW4xjbIHirNaDp2Aphma6IWU9PaaQCd
         cWcA==
X-Gm-Message-State: AOAM533fanDJAZrdV7CRsRDnfyM80aPdHOOo7HekHwnd4LsaAIj7B3NT
        2ekp3h40zy3XerLt5xW06EFN0nEpogCH
X-Google-Smtp-Source: ABdhPJwWNRuPXnz8uuTyGRa3LfTkvGJv6QumzRPDalJ8dm3+DPQLQf0gTBpi7sf+KViT3Glt6yvOag==
X-Received: by 2002:a05:6808:1445:: with SMTP id x5mr16256087oiv.45.1614017366828;
        Mon, 22 Feb 2021 10:09:26 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id k21sm3902361otl.27.2021.02.22.10.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 10:09:26 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:34c9:977:d082:51d0])
        by serve.minyard.net (Postfix) with ESMTPSA id 7827F1801B1;
        Mon, 22 Feb 2021 18:09:25 +0000 (UTC)
Date:   Mon, 22 Feb 2021 12:09:24 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.12
Message-ID: <20210222180924.GE3859@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 76c057c84d286140c6c416c3b4ba832cd1d8984e:

  Merge branch 'parisc-5.11-2' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2021-01-27 11:06:15 -0800)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.12-1

for you to fetch changes up to fc26067c7417e7fafed7bcc97bda155d91988734:

  ipmi: remove open coded version of SMBus block write (2021-01-28 07:15:12 -0600)

----------------------------------------------------------------
Pull request for IPMI for 5.12

Only one change in this pull, but it's required for other things, so it
needs to go in.

-corey

----------------------------------------------------------------
Wolfram Sang (1):
      ipmi: remove open coded version of SMBus block write

 drivers/char/ipmi/ipmb_dev_int.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

