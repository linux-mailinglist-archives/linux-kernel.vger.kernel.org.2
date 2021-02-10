Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA2E317069
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhBJTlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:41:24 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:43542 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhBJTjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=psGCywiRzOWWuNJrJEB2hAOapOEV0xQn5GH2xdqJzMk=; b=xY2aTBb991p4EsGVRsMXJkzHyz
        ICzDY9mXUz4qBS6sqluY/UsQEgO/8SRsIyD7WZeuVm61zSMKJUV7DN/ZZuZE7aIJBHeZVvQ49cPIL
        r3VLoGeHJcgCA08JH7PCDvOzVoiBdy3nMFX/9WzDIroiz6bOWGe3SwRXtMtPjuF4iZ34=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1l9uzD-0005YE-FR; Wed, 10 Feb 2021 13:17:17 -0600
From:   Nicholas Fraser <nfraser@codeweavers.com>
Subject: [PATCH 0/4] perf: Fix archive/debugcache PE files
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org
Cc:     Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
Message-ID: <d1c87379-8837-a5e7-eb44-f063ca0f4766@codeweavers.com>
Date:   Wed, 10 Feb 2021 14:17:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -40.6
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hello perf maintainers, I have some patches to get "perf archive"
    working with PE binaries (e.g. Wine DLLs or Windows executables.) The PE
   support in perf is fairly new and "perf archive" hasn't been updated to work
    with it. [...] 
 Content analysis details:   (-40.6 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 USER_IN_WELCOMELIST    user is listed in 'welcomelist_from'
  -20 USER_IN_WHITELIST      DEPRECATED: See USER_IN_WELCOMELIST
  -20 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -0.5 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
 -0.1 AWL                    AWL: Adjusted score from AWL reputation of From: address
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello perf maintainers,

I have some patches to get "perf archive" working with PE binaries (e.g.
Wine DLLs or Windows executables.) The PE support in perf is fairly new and
"perf archive" hasn't been updated to work with it. In getting this working
I've come across a number of bugs in perf that these patches aim to fix.
The patches are independent and can be committed in any order.

Some of these are because build-ids are now variable width. Build-ids in PE
files are always 16-byte GUIDs; much of the existing code still assumes a
20-byte SHA-1 build-id. I've tried to make the minimal amount of changes to
allow 16-byte build-ids to work with a debugcache from a perf archive.

I'm new to kernel development so I apologize if I'm doing this incorrectly.

Thanks,

Nick

Nicholas Fraser (4):
  perf buildid-cache: Don't skip 16-byte build-ids
  perf report: Load PE files from debug cache only
  perf archive: Fix filtering of empty build-ids
  perf report: Fix return value when loading PE DSO

 tools/perf/perf-archive.sh |  3 +--
 tools/perf/util/build-id.c |  5 +++--
 tools/perf/util/build-id.h |  4 +++-
 tools/perf/util/symbol.c   | 12 ++++--------
 4 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.30.0

