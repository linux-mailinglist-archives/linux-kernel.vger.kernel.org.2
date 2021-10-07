Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97A3424E50
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbhJGHx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:53:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49304 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhJGHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:53:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97C061FF3F;
        Thu,  7 Oct 2021 07:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633593123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fs19PhUXwfMDxymNHxENr6/WsslPh9P/2gKj+6yRtCA=;
        b=sdbJJW2YjKSOwroZVbSmOLUWq01H08UZmE+2BqzCIkH2w5FqiNZ8N8vFgSDRbQpleEm0VC
        u3TQHYgyATDz3/vjQNfXrKh0dknRSzaluwx59l7VFKhCbdfF7npFvhqgI4ZeDpV6UQ0p6G
        upFmJGrkc2YUTQiBrHGC3oIuJL8tQMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633593123;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fs19PhUXwfMDxymNHxENr6/WsslPh9P/2gKj+6yRtCA=;
        b=YOQqIcQyPuqJR3Kd3VX6CX2dtbN4ZzKzEEWmkCcRDq2PYTHu0TqesWptKfDWU3oUGQqE4H
        j38xk6/dEXlkWnBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9A84132D4;
        Thu,  7 Oct 2021 07:52:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nIXwNSKnXmEECAAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 07 Oct 2021 07:52:02 +0000
Date:   Thu, 7 Oct 2021 09:52:01 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 5/5] hugetlb: add hugetlb demote page support
Message-ID: <YV6nIUn9y4DkVGWt@localhost.localdomain>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-6-mike.kravetz@oracle.com>
 <20211006084112.GA12288@linux>
 <1e699922-59a6-dc14-6676-b44c1bdf1a6f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e699922-59a6-dc14-6676-b44c1bdf1a6f@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 11:52:33AM -0700, Mike Kravetz wrote:
> Agree, I do not love the name.  Since it is only a wrapper, how about
> destroy_hugetlb_page_for_demote?  And, change those other *_for_demote
> wrappers to similiarly not have gigantic in their names.

Yes, makes sense to me. We want the names to be generic and not tied to
gigantic stuff.

Thanks Mike

-- 
Oscar Salvador
SUSE L3
