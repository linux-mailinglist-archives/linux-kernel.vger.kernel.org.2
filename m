Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118F43404D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCRLlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCRLkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:40:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6795DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dPDhPECgGTp3Sq01htRV7UCMCNIaPhsyyaoliSaQekg=; b=fk8IGtO/Rhu8cln/Gz+IsQrdoj
        numPfVhx+H6yqrUhPXoagMvrH1NkFHRYNYu3K+K8R0oSkjb8cVoyoc9jbirfxMcPQ7Yzk0ZVHyqOv
        nCBYgvNFmlgX8LXMhTKIwFt8z8f0SL0RcFhG99bFl62n5wuvRJVANi1dqFxtQ+nA/aSe4AOQlwBAj
        4/eB7qSDL/QG6Ego7sEM6MaEsiBJW8HAlYOkwRGhpM/GvI+Yk844abYQ84ezXjmPUNKwGVE+kQRKz
        vy7PdKbhKN7SIn3k/4TBAxfFAVhQKTMReq6hKEQx0oiR52hShDU/NdqkT8NnLWP1cT2d1TgwRkp3P
        odTLahOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMqyp-002uRu-JK; Thu, 18 Mar 2021 11:38:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D8D3F3003E1;
        Thu, 18 Mar 2021 12:38:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C00E12023B130; Thu, 18 Mar 2021 12:38:17 +0100 (CET)
Message-ID: <20210318113156.407406787@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 12:31:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
Subject: [PATCH 0/3] static_call() vs __exit fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After more poking a new set of patches to fix static_call() vs __exit
functions. These patches replace the patch I posted yesterday:

  https://lkml.kernel.org/r/YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net

Since I've reproduced the problem locally, and these patches do seem to fully
cure things, I'll shortly queue them for tip/locking/urgent.

