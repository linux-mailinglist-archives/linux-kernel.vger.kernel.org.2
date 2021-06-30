Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D313B866A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhF3Poz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbhF3Pom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:44:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F90BC061787
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=unFu22C3yV55Y4CFXk50YQ5FBAjPOQP172b4sCTsTws=; b=B445xl4P6FHPr2Iz1oaAZ3B7DI
        vCQkV3NlvbpZlnEUysjJa2593r86PDIIQFRERZ5py/MVsA2u0Sdyg74MbUHNGeBtnKloekvUcIaiT
        0F24LUo/fDhmhg1rUKhqAghIwELBI6V3tIVbWDuVglvSnBXIWElK7is07yJZup0n5VAwy02pMnegr
        UERAlMesNFytAoC5kI9O5jfreiHwx+ynbwNwC7wEyUaBqPAD23wZrT0QyH9avdfGCFu36+vzSStqA
        L9QHzDFf0XbsB9lOU7oVg4TvkZZgg/fukRBnVgnIyB+M2hv7JXH89E8lwXY9Zk8cLEHuiKwFns149
        B/0M6mSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lycLn-00DD5Z-6a; Wed, 30 Jun 2021 15:42:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 431C7300242;
        Wed, 30 Jun 2021 17:42:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2B6762C59D785; Wed, 30 Jun 2021 17:42:06 +0200 (CEST)
Message-ID: <20210630153516.832731403@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 30 Jun 2021 17:35:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        yanfei.xu@windriver.com
Subject: [RFC][PATCH 0/4] locking/mutex: Some HANDOFF fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Cleanup and fix a few issues reported by Yanfei.

Waiman, I didn't preserve your reviewed-by, because there's a few extra
changes, and I've not yet boot tested them.

