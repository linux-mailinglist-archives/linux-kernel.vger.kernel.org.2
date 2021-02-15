Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966DF31B99C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhBOMrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:47:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:41324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhBOMqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:46:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 963C2ACBF;
        Mon, 15 Feb 2021 12:45:25 +0000 (UTC)
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] perf annotate: do not jump after 'k' is pressed
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Message-ID: <65416cff-4eb6-713c-a174-2aa43fa64332@suse.cz>
Date:   Mon, 15 Feb 2021 13:45:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not jump when 'k' is pressed, the cursor show stay where it is.
Right now, it jumps to the currently selected hot instruction.

Signed-off-by: Martin Liška <mliska@suse.cz>
---
  tools/perf/ui/browsers/annotate.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index bd77825fd5a1..35b82caf8090 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -759,7 +759,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
  			continue;
  		case 'k':
  			notes->options->show_linenr = !notes->options->show_linenr;
-			break;
+			continue;
  		case 'H':
  			nd = browser->curr_hot;
  			break;
-- 
2.30.0

