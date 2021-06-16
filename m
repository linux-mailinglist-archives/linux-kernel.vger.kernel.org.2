Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D498D3A9C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhFPNuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbhFPNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:50:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2BFC061574;
        Wed, 16 Jun 2021 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ar1oClf1UL+lamYNMBNzVSUFNOyuj2ILfOaM8Y5ReNI=; b=bBJE5073geXKUMnaGwan/MAEes
        piyPFh6s2Zb3QRhaqcwm/AIQ8i8wP5c1sSILkHhVCa1xYH1fDvE2YyaxxvECqb+dzgWyIuxSw1yvC
        q4bpxvj4g5dNNc6aM8+loteS3DtkFfngiW1iEUyJz1pdQVz5HrM3aUpOTWAsQeKf20cAAyEPBb+OS
        BX31Rs/I3dxaOd9tWTQw/KnhhdxPd3UYa4GqbaA+iA3aiePaZgRb00DJ1e7svJVsI6lOhCjYtiEKd
        j+yZ6+XANBXgSzyiI+PklzeMll8Y6Nibz6gt9oBbnyrI7eKvFReH0ak6C1qU9s6fz+6bGBKmQWnJN
        +eA77MwQ==;
Received: from [2001:4bb8:19b:fdce:84d:447:81f0:ca60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltVsh-0085u4-Cp; Wed, 16 Jun 2021 13:47:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org
Subject: remove the legacy ide driver v2
Date:   Wed, 16 Jun 2021 15:46:52 +0200
Message-Id: <20210616134658.1471835-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

we've been trying to get rid of the legacy ide driver for a while now,
and finally scheduled a removal for 2021, which is three month old now.

In general distros and most defconfigs have switched to libata long ago,
but there are a few exceptions.  This series first switches over all
remaining defconfigs to use libata and then removes the legacy ide
driver.

libata mostly covers all hardware supported by the legacy ide driver.
There are three mips drivers that are not supported, but the linux-mips
list could not identify any users of those.  There also are two m68k
drivers that do not have libata equivalents, which might or might not
have users, so we'll need some input and possibly help from the m68k
community here.

This series is against Jens' for-5.14/libata branch.

Changes since v1:
 - dropped various already merged patches
 - add a new module option to allow disabling DMA just for the quirky
   cypress devices found on some stone age ARM and Alpha systems
