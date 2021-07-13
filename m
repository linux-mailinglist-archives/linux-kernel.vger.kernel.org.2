Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66683C730F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhGMPXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:23:53 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:50075 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236977AbhGMPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:23:52 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 06E42BEC88
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:21:01 +0100 (IST)
Received: (qmail 14824 invoked from network); 13 Jul 2021 15:21:00 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 13 Jul 2021 15:21:00 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Zhang Qiang <Qiang.Zhang@windriver.com>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/4 v2] 5.14-rc1 mm/page_alloc.c stray patches
Date:   Tue, 13 Jul 2021 16:20:56 +0100
Message-Id: <20210713152100.10381-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(This v2 is because I didn't refresh the patches from my git tree properly
before sending, sorry for the noise)

This series is some fixes that would have likely have been included in
the 5.14-rc1 merge window if they were on time.  Mail indicates that some
may already be picked up for mmotm but the tree is not up to date yet so
I'm including them just in case.

Three are fixes to the bulk memory allocator and one is a fallout from
cleaning up warnings that trips BTF that expected a symbol to be global.

 mm/page_alloc.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

-- 
2.26.2

