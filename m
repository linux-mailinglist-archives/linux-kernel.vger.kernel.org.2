Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E3735E1AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbhDMOe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:34:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346530AbhDMOe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:34:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618324447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xzwE0OHyonBwcXj6+WFwsabkAyC/peXoTTrMmGFMg7E=;
        b=c80Cn1YsImuUkUaBgTgwqAJi86JzVntdNG/3w0VA6nSAZzV/1RNtrnEAhNOuo/9CEDRlLv
        Yqnx9xcsAOxmaro9j//kclynPsRgcaNN6WcqSs3iqTthA9YUrP1cJBScn6pPFqcjBIMhNS
        pmAgM4cHsbxPT8DcRQIEKlpbiUGhV+I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DEFF1AEAA;
        Tue, 13 Apr 2021 14:34:06 +0000 (UTC)
Date:   Tue, 13 Apr 2021 16:34:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v4 01/13] buildid: Only consider GNU notes for build ID
 parsing
Message-ID: <YHWr3tStYJ7LORnq@alley>
References: <20210410015300.3764485-1-swboyd@chromium.org>
 <20210410015300.3764485-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410015300.3764485-2-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-04-09 18:52:48, Stephen Boyd wrote:
> Some kernel elf files have various notes that also happen to have an elf
> note type of '3', which matches NT_GNU_BUILD_ID but the note name isn't
> "GNU". For example, this note trips up the existing logic:
> 
>  Owner  Data size   Description
>  Xen    0x00000008  Unknown note type: (0x00000003) description data: 00 00 00 ffffff80 ffffffff ffffffff ffffffff ffffffff
> 
> Let's make sure that it is a GNU note when parsing the build ID so that
> we can use this function to parse a vmlinux's build ID too.
> 
> Reported-by: Petr Mladek <pmladek@suse.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Fixes: bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
