Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE43F423B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 00:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhHVWvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 18:51:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232833AbhHVWvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 18:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629672664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ed3GqrOG9mDN34eH1Tr5OjkoyB3m3r+fRZda0yY/B9Y=;
        b=LL/gK+woWvq5lkiRLiMN9yungOZQpNWWfRk7TFrap5+IZSjZ9aT82MAadaOBg8D6a4tLlH
        7KQaeC/UcjHZ/xZJNgQ0NuR701VKoAycgreMW9LayfbLCMhePvZGL561YwWeZoqOKHKOm6
        1M8TfWX/s9hY9MdGu4e2lqws0Kfhi2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-UvB58LEYN-GhEpcT1AOAsQ-1; Sun, 22 Aug 2021 18:51:00 -0400
X-MC-Unique: UvB58LEYN-GhEpcT1AOAsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 747CE1082921;
        Sun, 22 Aug 2021 22:50:59 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (unknown [10.22.32.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80E0360C9F;
        Sun, 22 Aug 2021 22:50:54 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Andy Lavr <andy.lavr@gmail.com>
Subject: [PATCH v3 0/2] objtool: altinstructions fix and cleanup
Date:   Sun, 22 Aug 2021 18:50:35 -0400
Message-Id: <20210822225037.54620-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version won't eat your memory and swap when building the entire
kernel.  Apologies to Andy who discovered this over the weekend.

Tested full build and boot w/o problem.  The vmlinux sections, relocs,
size, etc. all appear to be the same before and after this set.
External tooling (kpatch-build) is happy, too.

v3:
- fix bug introduced in arch_decode_instruction() [andy]

v2:
- drop the sec->len update from the first patch [josh]
- rip out sec->len as suggested [josh]


Joe Lawrence (2):
  objtool: make .altinstructions section entry size consistent
  objtool: remove redundant len value from struct section

 tools/objtool/arch/x86/decode.c     |  2 +-
 tools/objtool/check.c               | 16 ++++++++--------
 tools/objtool/elf.c                 | 14 ++++++--------
 tools/objtool/include/objtool/elf.h |  1 -
 tools/objtool/orc_gen.c             |  2 +-
 tools/objtool/special.c             |  4 ++--
 6 files changed, 18 insertions(+), 21 deletions(-)

-- 
2.26.3

