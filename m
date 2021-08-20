Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD803F34BB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbhHTTpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhHTTpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629488702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BUThNOsdPshlZXOm91Cqt6GDNXXHXoIC7PH1MwZptiw=;
        b=KeBD9h3CZ2pfERaG+hwDtP08ppq2UT6gdq/BR6jRpoLSUwlMxbWnPveOngQ361SrcU8via
        PIPUzcvw6wbtHgR/+8GRkdJb9loXMPXqGq+96+tO41+XTMxsQgBYP6k7gn00JinUhbjAom
        7X4UR399ZyQGTLan2UEUOsE6LglPkRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-30-_1T7OMOSeOf8AknIbxQ-1; Fri, 20 Aug 2021 15:45:00 -0400
X-MC-Unique: 30-_1T7OMOSeOf8AknIbxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C71EE100960A;
        Fri, 20 Aug 2021 19:44:59 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (unknown [10.22.16.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 647D16A905;
        Fri, 20 Aug 2021 19:44:55 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 0/2] objtool: altinstructions fix and cleanup
Date:   Fri, 20 Aug 2021 15:44:51 -0400
Message-Id: <20210820194453.395548-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

Here's an updated patchset with suggestions from the initial post.

For the second patch, I assumed that the two values were intended to be
synonymous, so it was effectively a big s/sec->len/sec->sh_size.

v2:
- drop the sec->len update from the first patch [josh]
- rip out sec->len as suggested [josh]

Joe Lawrence (2):
  objtool: make .altinstructions section entry size consistent
  objtool: remove redundant len value from struct section

 tools/objtool/arch/x86/decode.c      |  4 ++--
 tools/objtool/check.c                | 19 ++++++++++---------
 tools/objtool/elf.c                  | 15 +++++++--------
 tools/objtool/include/objtool/arch.h |  2 +-
 tools/objtool/include/objtool/elf.h  |  1 -
 tools/objtool/orc_gen.c              |  2 +-
 tools/objtool/special.c              |  4 ++--
 7 files changed, 23 insertions(+), 24 deletions(-)

-- 
2.26.3

