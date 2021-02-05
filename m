Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FB2310ECC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhBEPvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:51:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233366AbhBEPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612546081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lL4LWN0foEEoPgPGKfYn/bLCSCit6wbUnsru7AAm4B0=;
        b=baFu4lnR8kd1yLN6twnRAZwoe3KAdTb9VvYQCZv/7X/nQOGaRQshbPCiW/D3sJSeUsNQ5Z
        CZ3yATQ2c0UlMecg1XXeKSql3ZMFUwV31wG7rzBGwjofg4/WwS79PuLMm//+iO85xTe2ex
        C4r0xab/VxlmvYtKbMsvtYO/TwjzGwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-HT3h5ooONLSHDCG2tH2YwQ-1; Fri, 05 Feb 2021 09:24:09 -0500
X-MC-Unique: HT3h5ooONLSHDCG2tH2YwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64687192D789;
        Fri,  5 Feb 2021 14:24:08 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-178.rdu2.redhat.com [10.10.116.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB1975D9D7;
        Fri,  5 Feb 2021 14:24:07 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ivan Babrou <ivan@cloudflare.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/2] x86/unwind/orc: Handle missing ORC data better
Date:   Fri,  5 Feb 2021 08:24:01 -0600
Message-Id: <cover.1612534649.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of patches for improving the ORC unwinder's handling of missing
ORC data.

Josh Poimboeuf (2):
  x86/unwind/orc: Disable KASAN checking in the ORC unwinder, part 2
  x86/unwind/orc: Silence warnings caused by missing ORC data

 arch/x86/kernel/unwind_orc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.29.2

