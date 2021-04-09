Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C9C359BC7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhDIKRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:17:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:36804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233700AbhDIKPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:15:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E90F8AEFF;
        Fri,  9 Apr 2021 10:15:21 +0000 (UTC)
Date:   Fri, 9 Apr 2021 12:15:19 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shy828301@gmail.com, weixugc@google.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com
Subject: Re: [PATCH 03/10] mm/migrate: update node demotion order during on
 hotplug events
Message-ID: <20210409101518.GB32159@linux>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183221.977831DE@viggo.jf.intel.com>
 <YG7Sc3i54IV6KyPn@localhost.localdomain>
 <20210409101400.GA32159@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409101400.GA32159@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 12:14:04PM +0200, Oscar Salvador wrote:
> On Thu, Apr 08, 2021 at 11:52:51AM +0200, Oscar Salvador wrote:
> > I am not really into PMEM, and I ignore whether we need
> > CONFIG_MEMORY_HOTPLUG in order to have such memory on the system.
> > If so, the following can be partly ignored.
> 
> Ok, I refreshed by memory with [1].

Bleh, being [1] https://lore.kernel.org/linux-mm/20190124231448.E102D18E@viggo.jf.intel.com/

-- 
Oscar Salvador
SUSE L3
