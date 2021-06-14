Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248633A5CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 08:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhFNGKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 02:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhFNGKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:10:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6543CC061756;
        Sun, 13 Jun 2021 23:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pNCZGFwRZkOEax8ViFXmM98e7LtCVelx6oIBxkkQG1M=; b=1LVHkK1+Nk1hyqnZm9VdPkU1uj
        l5GDp2UZxDnxn394adt/OT3dZnqic5phjqL3A5Kq91Z5VKHKMLSXmoEOjjF4NybKECCN21PI2NVgK
        TlRM4M3gHi3n79zFhkNMDbtPAyqOlI1fHB2PGf2f9lSGMF7EHnGZ1m44J+9+zOcnTs4HSaajTAyrH
        sy/ecOOKEKSC6wTti8nVYVD3KI9Bps9N5YkjvrN04ExRhDnoJXU7BBv6YTG0/RcbIRuxfCWFxFtVi
        AE2FFLJY10m3XNoxZ50E77FMlOjCLo90tipacuXn4k9+AD1r+OjAlJjq7olgCVXpmzoN1PAA4AcR9
        VWBWClew==;
Received: from [2001:4bb8:19b:fdce:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsflQ-00CgKb-U5; Mon, 14 Jun 2021 06:08:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: cleanup ubd gendisk registration
Date:   Mon, 14 Jun 2021 08:07:57 +0200
Message-Id: <20210614060759.3965724-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series sits on top of Jens' for-5.14/block branch and tries to
convert ubd to the new gendisk and request_queue registration helpers.
As part of that I found that the ide emulation code currently registers
two gendisk for a request_queue which leads to a bunch of problems we've
avoided in other drivers (only the mmc subsystem has a similar issue).
Given that the legacy IDE driver isn't practically used any more and
modern userspace doesn't hard code specific block drivers, so I think
we can just drop it.  Let me know if this is ok.
