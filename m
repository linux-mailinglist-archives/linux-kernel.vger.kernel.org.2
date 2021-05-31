Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B7B3963DD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 17:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhEaPg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 11:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233853AbhEaOVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:21:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F196E61574;
        Mon, 31 May 2021 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622468698;
        bh=abyuK/7cMoBIHEFpK1YB4Eo1c7OwGPxpWxUKdGzQR+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EsSPhuVSfVHOyS9ImKyD6Cesy/yuDzdviJSLS5yWfCU2S16w3RJJ6pdh3TstExU/X
         rHr1+SeGjyDT16jKE5yaGW+PkOM73oCpeJr8hlFZy/gnKLsn6Qjf1L9BJrtwgyakYf
         5yRs5D/3zK68TVOqRuBErjYpJ9TdS0OvoaxOUPwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.4 085/177] perf jevents: Fix getting maximum number of fds
Date:   Mon, 31 May 2021 15:14:02 +0200
Message-Id: <20210531130650.838648032@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531130647.887605866@linuxfoundation.org>
References: <20210531130647.887605866@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

commit 75ea44e356b5de8c817f821c9dd68ae329e82add upstream.

On some hosts, rlim.rlim_max can be returned as RLIM_INFINITY.
By casting it to int, it is interpreted as -1, which will cause get_maxfds
to return 0, causing "Invalid argument" errors in nftw() calls.
Fix this by casting the second argument of min() to rlim_t instead.

Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: http://lore.kernel.org/lkml/20210525160758.97829-1-nbd@nbd.name
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/pmu-events/jevents.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -862,7 +862,7 @@ static int get_maxfds(void)
 	struct rlimit rlim;
 
 	if (getrlimit(RLIMIT_NOFILE, &rlim) == 0)
-		return min((int)rlim.rlim_max / 2, 512);
+		return min(rlim.rlim_max / 2, (rlim_t)512);
 
 	return 512;
 }


