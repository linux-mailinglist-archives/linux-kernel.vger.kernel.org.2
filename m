Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB83C232D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 13:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhGIL4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 07:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhGIL4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 07:56:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F40C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 04:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cVcUbdjtAm+FbjMewZaudEH2EOp1mRnJfFiMaNyVU28=; b=JJrNgZZpG+Rp3DjZy6VlogmiWE
        FTO14U93kUWEaPw4EHuTYkhjmBrci4pU0INTDQkHB0IE6e8fVzQjEjS0vnXpx1rFIEvpMLxR+OjEx
        NiLC0Au4ZnlbD8iruZ8kYOg5JX8hW9QpD0EUX66l/lpcVLU9eF5O1GhGoDlm5+pNc3brC74aB2CtO
        Iyuxe4YQI5uNWBbpmDGz0rbwKXYiyJaVGeswbtE4yAQ9Nd/bTNxe57jlq3tShidg5+az8xBOupXZ/
        SOlVa0Q2nQmmYSPXTbfxchoP0mwWqsa0nkCtRPQqPqDndF6KK19cZktATrNcG2/KqpeLO7HTOHRe1
        P0f00+yA==;
Received: from p4fdb05cb.dip0.t-ipconnect.de ([79.219.5.203] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1p4F-00ETAk-Q4; Fri, 09 Jul 2021 11:53:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     uclinux-h8-devel@lists.sourceforge.jp, linux-kernel@vger.kernel.org
Subject: remove set_fs() for h8300
Date:   Fri,  9 Jul 2021 13:53:09 +0200
Message-Id: <20210709115311.3424912-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series removes support for the deprecated set_fs address space
override on h8300.  Because h8300 doesn't actually have different
address spaces to start with as a pure nommu port the changes are
pretty simple.

Compile tested only.
