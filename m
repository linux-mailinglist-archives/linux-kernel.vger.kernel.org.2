Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BAB4071C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhIJTUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhIJTT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:19:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72D5961167;
        Fri, 10 Sep 2021 19:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631301527;
        bh=Sh4pD9U7w51AAAI4Xnju3zUjDCk8B7lUevXPX+TctKk=;
        h=Date:From:To:Cc:Subject:From;
        b=IPWpXJ6DZpQzq0k43F0a9mlUoFnNK88PDlb2AbVDFqcttl7nKt6P87NYarv7KNPPw
         /iv0KIqnv9WqdixkTI3fVWUoTKXFgCtePObyD9vZ+/pHRQ9mPheyoutvgPc3tMQHT5
         nh3oKd0ejh6Wr17VXW3pSfeREutcOnBSm3HnhPpXv38QxszKcPedhcuF+ivQIu0GaH
         JRaoSsjB/rg7lvAa5Q28aO3BfNOjEo0hbo2wlkPkV8phXshK3q+f5nBtTlg7Kggt/K
         7z+YmBywKUqsM19n5g/XOQwp7HEuXCaIw9UISl/gAked2H4DVSIrO4Fd9l5e3jfy1e
         6ZsUJw0D/WTlQ==
Date:   Fri, 10 Sep 2021 21:17:34 +0200
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL v2] Compiler Attributes for v5.15-rc1
Message-ID: <20210910191734.GA8688@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pick up the following attribute improvements (2nd take).

The first two patches were in my tree for a long while.
The latest has been in -next for only a day, but that was
my mistake forgetting to upload it sooner to my tree.

You will find an easy conflict -- the end result should be
just adding the new attributes to the GCC 4 list.

(Sorry...)

Cheers,
Miguel

The following changes since commit 62fb9874f5da54fdb243003b386128037319b219:

  Linux 5.13 (2021-06-27 15:21:11 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.15-rc1-v2

for you to fetch changes up to b83a908498d68fafca931e1276e145b339cac5fb:

  compiler_attributes.h: move __compiletime_{error|warning} (2021-09-09 01:14:28 +0200)

----------------------------------------------------------------
Compiler Attributes improvements:

  - Fix __has_attribute(__no_sanitize_coverage__) for GCC 4 (Marco Elver)

  - Add Nick as Reviewer for compiler_attributes.h (Nick Desaulniers)

  - Move __compiletime_{error|warning} (Nick Desaulniers)

----------------------------------------------------------------
Marco Elver (1):
      Compiler Attributes: fix __has_attribute(__no_sanitize_coverage__) for GCC 4

Nick Desaulniers (2):
      MAINTAINERS: add Nick as Reviewer for compiler_attributes.h
      compiler_attributes.h: move __compiletime_{error|warning}

 MAINTAINERS                         |  1 +
 include/linux/compiler-gcc.h        |  3 ---
 include/linux/compiler_attributes.h | 25 +++++++++++++++++++++++++
 include/linux/compiler_types.h      |  6 ------
 4 files changed, 26 insertions(+), 9 deletions(-)
