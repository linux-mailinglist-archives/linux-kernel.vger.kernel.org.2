Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AD838FBDB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhEYHhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:37:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:54852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbhEYHhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:37:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621928168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GKSyZSfAzVVq/ABR755e8Z5pcs9qhohd3YV/i12YGw=;
        b=Ets6WZ9YpTAvqq0ts49H1xJxPreCOpST9tTB/7sbHHhNZ424zNR6YJQZ9RCdidUReKkiYO
        lQBUIiq4cyuztVT/npnNNGCkNEYZ/NdkyTstGowh9N4za3CORvckFY+WPc495xGloLJp2H
        D4PbSA4WmMBbFY3CDaj14j45qFpn6Ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621928168;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GKSyZSfAzVVq/ABR755e8Z5pcs9qhohd3YV/i12YGw=;
        b=aeKZOMiCUet47hEHrHbJHkL4ltgc2DqW9DLkrsIl/zsZ/7FjFfxJX2m9YvmF8xwYEsld9u
        zc72a02lfs1kQ1Cg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4FB9CAE99;
        Tue, 25 May 2021 07:36:08 +0000 (UTC)
Date:   Tue, 25 May 2021 09:36:05 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] mm,hwpoison: fix race with hugetlb page allocation
Message-ID: <20210525073559.GA844@linux>
References: <20210518231259.2553203-1-nao.horiguchi@gmail.com>
 <20210518231259.2553203-2-nao.horiguchi@gmail.com>
 <d78f430c-2390-2a5f-564a-e20e0ba6b26a@oracle.com>
 <20210520071717.GA2641190@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520071717.GA2641190@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 07:17:17AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> So I think of inserting the check to comply with the assumption of
> get_hwpoison_huge_page() like below:
> 
>         ret = get_hwpoison_huge_page(head, &hugetlb);
>         if (hugetlb)
>                 return ret;
> 
>         if (!PageLRU(head) && !__PageMovable(head))
>                 return 0;
> 
>         if (PageTransHuge(head)) {
>                 ...
>         }
> 
>         if (get_page_unless_zero(head)) {
>                 ...
>         }
> 
>         return 0;

Hi Naoya,

would you mind posting a complete draft of what it would look like?
I am having a hard time picturing it.


Thanks

-- 
Oscar Salvador
SUSE L3
