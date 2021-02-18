Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA5131EF30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhBRTF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:05:56 -0500
Received: from z11.mailgun.us ([104.130.96.11]:13390 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234274AbhBRRZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:25:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613669119; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=fGC3KoAKoPYFDDBOLdtuddyznGdkTbqrir/yLPgrmzo=; b=AEt04cJwlvXRhDDjxg4HN/1bCOBJpBw8Wl1cHmfmAxKo+lEsx3vevEIPQwRCEH05ddJ4v3kQ
 PP3wTsx9TcCADdduxor106ejCwx0vx57Nd0ZNUAnbGDb6W3kxhPgPzoMOXHlvfr4r5x8MqgB
 28V5txi0Ja37BxC9oamw/RQJ6eE=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 602ea2e1f33d74123f3d6cb7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Feb 2021 17:24:49
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ACA03C43464; Thu, 18 Feb 2021 17:24:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from charante-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70FCBC433C6;
        Thu, 18 Feb 2021 17:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70FCBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, rientjes@google.com, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, mgorman@techsingularity.net,
        linux-mm@kvack.org
Cc:     vinmenon@codeaurora.org, sudaraja@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH RFC 0/1] mm: balancing the node zones occupancy 
Date:   Thu, 18 Feb 2021 22:54:31 +0530
Message-Id: <cover.1613661472.git.charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to start discussion about  balancing the occupancy of
memory zones in a node in the system whose imabalance may be caused by
migration of pages to other zones during hotremove and then hotadding
same memory. In this case there is a lot of free memory in newly hotadd
memory which can be filled up by the previous migrated pages(as part of
offline/hotremove) thus may free up some pressure in other zones of the
node.

Say that in system has 2 zones(Normal and Movable), where Normal zone is
almost filled up by the pages of the movable zone as part of offline
operation and then we hot add a memory node as movable zone. At this
moment, Movable zone is almost empty and Normal zone is almost filled
up(by the migrated pages as part of previous offline/hot-remove
operation). At this point of time, allocation requests from Normal zone
may have to go through reclaim cycles thus cause some pressure. This
problem is quite common in the system where they aggressively offline
and online the memory blocks in the system where the former part do the
migration of pages to the lower zones and the later part don't reverse
them and as a result the offline operation may contribute to the
pressure in other zones of the system.

To overcome this problem, we can do the reverse of what offline
operation did, after onlining the memory block i.e. **try to reverse
migrate the pages from other zones which were migrated as part of the
offline operation**. This may freeup some pressure built in the other
zones because of offline operation. Since we are reverse migrating the
pages in the system, we can name this as "reverse migration feature" or
since we are actually balancing the occupancy of the zones in the system
by migrating the pages we can name it as "balancing the system zones
occupancy" or any name...

We have the proof-of-concept code tried on the Snapdragon systems with
the system configuration, single memory node of just 2 zones, 6GB normal
zone and 2GB movable zone. And this Movable zone is such that hot-added
once and there after offline/online based on the need.

We run the below unit test to evalutate this:
1) Completely fill up the already hot added movable zone with anon
pages

2) Offline this hot added movable zone. At this point there is no
pressure in the normal zone yet, but this migration of pages can
contribute to it in the future.

3) Now fill up the normal zone such that there is 300MB or less left in
the system.

4) And now the user onlined the movable zone memory blocks in the
system.

5) Run the tests of allocating 512MB of memory from the normal zone and
in doing so try allocating the higher order pages first and then
gradually fall back to lower orders. I took the help from ion system heap
memory allocation which try to allocate the memory in available orders:
9, 4 and 0.

6) Repeat the above steps for 10 iterations and below is the average of
the results.

We did try to collect the time it takes to complete the tests and the
distribution of anon pages(are the ones participated in the tests) in
the system node zones.
a) With out the reverse migration, it took an average of around 145msec
to complete the test.
b) With the reverse migration, it took an average of the 120msec to
complete the tests.

For distribution of the anon pages in the system we did try collect the
anon pages left in the individual zone before and after the test:
------------------------------------- |-------------------------------
         Base			      |		Reverse Migration
--------------------------------------|-------------------------------
	   Beforetest Aftertest	      | Beforetest	 Aftertest
Normal zone(Anon)                     |
  Active  499825	45756         |  481441		  203124
  Inactive 46008	446687	      |	 51553	          58602
  Free     80350	224252	      |  84877		**440586**
Movable zone(Anon)                    |
  Active   2224		2626	      |  2239		**484622**
  Inactive    8		   8	      |  9		7663
--------------------------------------|-------------------------------

The above table shows that, On base case(left column), there exists a
lot of anon pages in the system which can be migrated back to Movable
zone(almost totally free), thus may freeup some space in the normal
zone. With the reverse migration(Right coloumn), we see that the anon
pages are evenly distributed in the system and lot of free memory
left in the normal zones caused by the reverse migration.

The code shows the PoC by assuming just 2 zones(normal and Movable) of a
single node in the system. The number of pages to be reverse migrated is
written on the sysfs interface from the userspace by monitoring the
memory pressure events in the system.

Charan Teja Reddy (1):
  mm: proof-of-concept for balancing node zones occupancy

 include/linux/migrate.h |   8 +-
 include/linux/mm.h      |   3 +
 include/linux/mmzone.h  |   2 +
 kernel/sysctl.c         |  11 ++
 mm/compaction.c         |   4 +-
 mm/memory_hotplug.c     | 265 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 290 insertions(+), 3 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

