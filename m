Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC4C314594
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhBIBYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhBIBXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:23:53 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C434C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 17:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6WVO+n6pdHhW/WV2NkxvsNL/Yr0QrCpRFQ288rb4RAk=; b=2Mo19wSrLRzwh/QESokzohcgw/
        W3kj3/67aznnNTEzDijikaq5YiJzzRl4zJNnQnsal2Iezypt4TwXYqldsqbWNUMGssZekjD7gZzQH
        HxnDQ/dW4T34lMvwUFM9bqYOSaSjEtarVjy01Awp42aHv4BRZgHrWNCyBqWMt3cejz7khE5kHzPdX
        HRrEzKl6UjN7pZjmfgJU0Xb/AktfLTVNzQ5Nzeo19hXRZA0fSz2ssDdHxNZkCapvGCSVNzs3fX9PR
        coskPr0SO69eS5FkiWrqsja3TI/C0JMO1GczuhhTfKP77BtUAeQg1tbEuTITQxXzocSthJhY2ClRk
        3Oqkrfkg==;
Received: from [2601:1c0:6280:3f0::cf3b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9HkD-0005B9-W0; Tue, 09 Feb 2021 01:23:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: [PATCH] x86: vdso: fix printf() format warnings in vdso2c.h
Date:   Mon,  8 Feb 2021 17:23:05 -0800
Message-Id: <20210209012305.31062-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %zu instead of %lu for size_t to prevent w printf()
format warnings in vdso2c.h

  HOSTCC  arch/x86/entry/vdso/vdso2c
In file included from ../arch/x86/entry/vdso/vdso2c.c:162:
../arch/x86/entry/vdso/vdso2c.h: In function 'extract64':
../arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
   38 |  fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
      |                                                  ~~^              ~~~
In file included from ../arch/x86/entry/vdso/vdso2c.c:166:
../arch/x86/entry/vdso/vdso2c.h: In function 'extract32':
../arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
   38 |  fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
      |                                                  ~~^              ~~~

Fixes: 8382c668ce4f ("x86/vdso: Add support for exception fixup in vDSO functions")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
---
 arch/x86/entry/vdso/vdso2c.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-511-rc7.orig/arch/x86/entry/vdso/vdso2c.h
+++ lnx-511-rc7/arch/x86/entry/vdso/vdso2c.h
@@ -35,7 +35,7 @@ static void BITSFUNC(extract)(const unsi
 	if (offset + len > data_len)
 		fail("section to extract overruns input data");
 
-	fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
+	fprintf(outfile, "static const unsigned char %s[%zu] = {", name, len);
 	BITSFUNC(copy)(outfile, data + offset, len);
 	fprintf(outfile, "\n};\n\n");
 }
