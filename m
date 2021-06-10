Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1071A3A2BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFJMpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:45:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57024 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhFJMpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:45:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8B00D21A44;
        Thu, 10 Jun 2021 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623328989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hEJqmzVa3+J6o6UKU4lgHo91Lw4IYVXyD67GtqqB0fQ=;
        b=cSqUzEfUAsz7xtFrqEbjZ/qCY6Dys74/JJXE4yu5J/T22VuHe2m65wSK7mIBakkSzamWcy
        iUCHqac0vSJUkIho8vg0EBrme4WIn1E9sa/wgu+zNkF6/npBeKZ6ShwMsSENy/3xHWV7Yn
        sGqnnItwYfdJ/3x0JMHyC50diA6Pl6U=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 45A70A4293;
        Thu, 10 Jun 2021 12:43:08 +0000 (UTC)
Date:   Thu, 10 Jun 2021 14:43:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Waiman Long <llong@redhat.com>, Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <YMII3OMPoZPuCe0r@dhcp22.suse.cz>
References: <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
 <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
 <353d012f-e8d4-c54c-b33e-54737e1a0115@redhat.com>
 <YL8MjSteKeO7w0il@dhcp22.suse.cz>
 <20210609143534.v65qknfihqimiivd@ava.usersys.com>
 <YMHivM+0DRYXzAD0@dhcp22.suse.cz>
 <20210610122323.6geriip66jjmdstj@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610122323.6geriip66jjmdstj@ava.usersys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-06-21 13:23:23, Aaron Tomlin wrote:
[...]
> Anyhow, I think we should exclude tasks that have MMF_OOM_SKIP applied in
> dump_tasks() as it could be misleading.

Well, I am not sure this is a good thing in general. We do not want to
hide tasks. We already do display oom_score_adj_min even though they are
not eligible and that can serve a good purpose from my experience. It
gives us some picture at least. Maybe a flag to mark all uneligible
tasks would be something useful but I wouldn't drop them from the list.

-- 
Michal Hocko
SUSE Labs
