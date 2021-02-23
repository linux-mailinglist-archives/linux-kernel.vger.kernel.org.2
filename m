Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06408323419
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhBWXHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:07:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:51736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233626AbhBWW7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:59:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2C2CAE30;
        Tue, 23 Feb 2021 22:58:17 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 23 Feb 2021 23:58:17 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: fix uninitialized subpool pointer
In-Reply-To: <53527e9d-d09b-7287-9f79-ebdbf4e9bc7a@oracle.com>
References: <20210223215544.313871-1-mike.kravetz@oracle.com>
 <20210223224540.GB2740@localhost.localdomain>
 <53527e9d-d09b-7287-9f79-ebdbf4e9bc7a@oracle.com>
User-Agent: Roundcube Webmail
Message-ID: <a7f063ea6b5eae4a4fcf038268e3a604@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-23 23:55, Mike Kravetz wrote:
> Yes, that is the more common case where the once active hugetlb page
> will be simply added to the free list via enqueue_huge_page().  This
> path does not go through prep_new_huge_page.

Right, I see.

Thanks

-- 
Oscar Salvador
SUSE L3
