Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C739D425101
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240872AbhJGK1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:27:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51684 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhJGK1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:27:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9B953203D3;
        Thu,  7 Oct 2021 10:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633602312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bMl2vQKXM/x6+ceqE26rgp1TKwW1WRTeZYtaGsc2hrY=;
        b=hqOu0yU1oXHTKegGNlAhsyW7kjAeVNIy7PZ/g4Ekb5dTYlVdXKDw8xT21FXob6uFeNicPb
        COdYkpKvoGPIs3dejZJjkYCpPNk+L/xLjW/CDVK8PujNrl2bd0inZYBc6Cj7fZj9Q5Lzdt
        iRZ3tsMcT9JjDZF8CtO5Do2bxI+laeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633602312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bMl2vQKXM/x6+ceqE26rgp1TKwW1WRTeZYtaGsc2hrY=;
        b=ClbAVRlaFzDs+umFnUwJ3dhDtrCFq18qtFZTKc6tQuWvrK2YGiifo0QqJdwkQBlCa0ZFWZ
        2g608Kv3BAbh5gDg==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3F2EAA3B83;
        Thu,  7 Oct 2021 10:25:12 +0000 (UTC)
Date:   Thu, 7 Oct 2021 11:25:10 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Subject: Re: [RFC PATCH 4/4] sched/numa: Don't update mm->numa_next_scan from
 fault path
Message-ID: <20211007102510.GQ3891@suse.de>
References: <20211004105706.3669-1-bharata@amd.com>
 <20211004105706.3669-5-bharata@amd.com>
 <20211005082335.GN3891@suse.de>
 <dbb74941-4d6c-3e5a-2f5c-d18001c2856c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <dbb74941-4d6c-3e5a-2f5c-d18001c2856c@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 02:40:15PM +0530, Bharata B Rao wrote:
> > 
> > Updating via cmpxchg would be ok to avoid potential collisions between
> > threads updating a shared mm.
> 
> Ok, may be I could just resend with changing the scan period update
> to use cmpxchg.
> 
> I also notice that in this case of scan period update, we just return
> without resetting the p->numa_faults_locality[]. Do you think if
> skipping the reset doesn't matter in this case?
> 

If there is no fault activity or migrations are failing, there is no
advantage to clearing numa_faults_locality[]. The information there
is still useful even if the scan period is updated.

-- 
Mel Gorman
SUSE Labs
