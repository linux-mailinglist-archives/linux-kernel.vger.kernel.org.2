Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07BD35ED6A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345677AbhDNGol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346515AbhDNGoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:44:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CCEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DVwBx6xKrHYcSk7q61RQ1LnpuWWRHj1O3Je+Oxa/4vg=; b=XqF/S6iLlGTUX2tqrt08p4+rHg
        fbEXh8ilqCkm/ldI84h/JfXcK4NubhcB8lX+fF8xB1vaLU4l4CdxOQ4b0VzCj/NG1er/fQsTHf4Os
        crcaQDs+Smvh7zfdIGOmMNKCgNdSOuhEcm+oxdYbEnwL98MmIzC57LNq6fmrOLBlgjdXHhrFADgJ6
        AYjxS1CeRApiag1BA6IJgpsdaghlVroX0Vf9UDYP1394go91gkSUI3xPbM3QXNyfD5kokkmDftXGn
        kFYxtcsdnrr7nsdwa9C2VbWEYdlqhl4zQ4H1OpE5z6Z2yXJpaLj+wCYz/9Phcj07kBtTdiZUubuAG
        IKm4Ayyw==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWZFi-00BiGB-L4; Wed, 14 Apr 2021 06:43:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: [PATCH 0/3] um: headers: fix various W=1 warnings
Date:   Tue, 13 Apr 2021 23:43:47 -0700
Message-Id: <20210414064350.3923-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few W=1 warnings in arch/um/.
Prompted by the "kernel test robot".

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org

 [PATCH 1/3] um: pgtable.h: fix W=1 warning for empty body in 'do' statement
 [PATCH 2/3] um: elf.h: fix W=1 warning for empty body in 'do' statement
 [PATCH 3/3] um: stub_32.h: move 'inline' before 'void' to fix W=1 warning

 arch/um/include/asm/pgtable.h       |    2 +-
 arch/x86/um/asm/elf.h               |    2 +-
 arch/x86/um/shared/sysdep/stub_32.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
