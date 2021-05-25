Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF0390859
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhEYSCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 14:02:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:41204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234353AbhEYSBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 14:01:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621965625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NgBPhouft99Ui43ozzCY0B6U/k51FIAlxJ2/MpfUsP4=;
        b=ElpQxK+HH3ANT/imMyY3cj4d5xakfztZG4n+dqNqmjsFClVF6axympo2AiEc/xd0V1vwz7
        VRTiR0H50GVzoX0V/p7gl80l9KvdWsTmLl0c3tRmQofkZxdjqo/+wsDA4nOKuSC9NkUgkC
        MCpwf2cX4XRYvldW+NOjZ9pNPb7U40o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621965625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NgBPhouft99Ui43ozzCY0B6U/k51FIAlxJ2/MpfUsP4=;
        b=7feiVxBJkKJ6PgvqiOrw4iFzGCPObeRBqzD4gwdf/Ia3sPpNrkWQI8YUubMUtHUlCC8+cH
        p/ewdh9WjO7LGADQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF264AF59;
        Tue, 25 May 2021 18:00:24 +0000 (UTC)
Date:   Tue, 25 May 2021 20:00:22 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Arm64 crash while online/offline memory sections
Message-ID: <YK07NhNOnKNB02RY@localhost.localdomain>
References: <DM5PR0201MB35576EF9B568FEE05FE58CF08E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <b34499c5-a330-1bfc-d564-8ebffb3236cd@redhat.com>
 <DM5PR0201MB35576CEF62C53EF393E3D9768E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR0201MB35576CEF62C53EF393E3D9768E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 05:57:34PM +0000, Qian Cai (QUIC) wrote:
> > Do we know which patch in particular is problematic?
> 
> Okay, the winner is "mm,memory_hotplug: Allocate memmap from the added memory range".
> 
> https://lore.kernel.org/linux-mm/20210421102701.25051-5-osalvador@suse.de/

Ok, which means that is irrelevant to having it enabled, as the latter
patch of that series actualy enables it for arm64.
Can you work out where exactly the crash happens?

I will have a look into it tomorrow.

Thanks for reporting.

-- 
Oscar Salvador
SUSE L3
