Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A3D3C4792
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhGLGd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 02:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbhGLG3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0897C08EC89;
        Sun, 11 Jul 2021 23:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=tB53rqP9UurlO9Ubjzx5fIdyCBO9p4biSEwOPXSsFqo=; b=dzMdOtVbZVRxxudw8++DeGPLtl
        rWxB7mGdvYuZ4AETWUbLfJHkL5g99xedhkEC8KrVXGsmNoSlWEJYkmw27IQ2HCHwgxqPeyGuF6n4z
        QV9wDQYnD8Xvq+2OvZbS9BxxcfMtaMQm31nocFhIQsHL5sNTFpkFdq0RGPmo9w8EKt5Sgyqz2YJDp
        Jmzgs5iBpf32uKiThPw9SABqwTDqjLZ3uoaQgfcF9XbmQu1cTVLTe2CGbZLHz2/AmYKVGEylaRWKo
        T3qxVMUSY97ijE+OPbZ1AVZZwp8QbsOyfdmqGMkxYq8pjsTM7FWsjS9/wwxeczXm49LAbQbsFgFOu
        2WwsE6Uw==;
Received: from [2001:4bb8:184:8b7c:bd9:61b8:39ba:d78a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2pFZ-00Gws5-69; Mon, 12 Jul 2021 06:17:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Brian Cain <bcain@codeaurora.org>
Cc:     Dillon Min <dillon.minfei@gmail.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: add support for the global coherent pool to the dma core
Date:   Mon, 12 Jul 2021 08:16:57 +0200
Message-Id: <20210712061704.4162464-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series adds support for using the global coherent (aka uncached)
pool to the generic dma-direct code and then switches arm-nommu and
hexagon over to it, together with a bunch of cleanups.

Diffstat:
 arch/arm/Kconfig                |    5 -
 arch/arm/mm/dma-mapping-nommu.c |  173 +---------------------------------------
 arch/hexagon/Kconfig            |    1 
 arch/hexagon/kernel/dma.c       |   57 ++-----------
 include/linux/dma-map-ops.h     |   18 ++--
 kernel/dma/Kconfig              |    4 
 kernel/dma/coherent.c           |  159 +++++++++++++++++-------------------
 kernel/dma/direct.c             |   15 +++
 8 files changed, 124 insertions(+), 308 deletions(-)
