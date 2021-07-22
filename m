Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F42C3D1E37
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhGVFpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhGVFoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:44:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137AFC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 23:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BriiUpxqmfP1ThU89I9ULOLyz26OuFrzUElAtPLy8Vw=; b=XFqSDzTtHrHPI1j/ctyWUaukU+
        XHc9xgCkJaKt3d+dU06kQTpBmOfHwCMQrvkh0K0SYumgJGbFaGpJLdAYEUj8pwecwoqqDBmSnm/HU
        91GpK71Oswts78ZLUF5d783Ubhor2GSqCz06nwaBSIrJu0EDNpDRc9bteWAetpss0hDEiLZtD+5f0
        funMDFu6N/9TfLGd8u46P3ZdwnCr7olQQNEbgEyMUjB2Dc6ac2/gyZZDWqBemoXh69x1Lqu8z86Lb
        G1GbDSdlGvzSKpaMl+cgU8OkfBPwD7jYwxyVW6a3aScB0V/uBK4a1zqVFzaRZB6uQDfnHtwfsDy2T
        aFGIPujg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6S8U-009xAz-T6; Thu, 22 Jul 2021 06:24:57 +0000
Date:   Thu, 22 Jul 2021 07:24:46 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs: change fiemap way in printing compression chunk
Message-ID: <YPkPLrBszwr1aiBe@infradead.org>
References: <20210721072048.3035928-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721072048.3035928-1-daeho43@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, any chane you could switch f2fs to use iomap_fiemap instead of
the handrolled version?  Especially with the work from Eric to add
iomap based direct I/O this should be much simpler now.
