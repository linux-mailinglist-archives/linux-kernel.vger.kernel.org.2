Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E990325D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 07:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhBZGbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:31:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:57430 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhBZGbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:31:05 -0500
IronPort-SDR: q4KfNgN9U6r3w2zEQicdjsAL0yFSgiyY5CXK99Tj1O39CqNz7aDDBGtKskHml0itLkEoQbjEGn
 5U0hpNZql7Yw==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="173441155"
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="173441155"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 22:30:23 -0800
IronPort-SDR: tm6qVikHor6LPs6/WvIjitCc9LC1x2BbyQ6LQKvQKuZtI6XJ1ZZ3x+yGHT0OcEQd+6xKAyjxS9
 pw6MtLrl2MNA==
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="404774030"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 22:30:20 -0800
Date:   Fri, 26 Feb 2021 14:30:18 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Zhi Wang <zhi.a.wang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: add hotplug_cpu dependency
Message-ID: <20210226063018.GB9695@shuo-intel.sh.intel.com>
References: <20210225133838.2196965-1-arnd@kernel.org>
 <20210226013807.GA9695@shuo-intel.sh.intel.com>
 <YDiUTv5czunFzgEN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YDiUTv5czunFzgEN@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26.Feb'21 at  7:25:18 +0100, Greg Kroah-Hartman wrote:
>On Fri, Feb 26, 2021 at 09:38:07AM +0800, Shuo A Liu wrote:
>> Hi Arnd,
>>
>> There is already a patchset for this build issue. Please refer to
>> https://lore.kernel.org/lkml/20210221134339.57851-1-shuo.a.liu@intel.com/.
>>
>> Hi Greg, Would you like accept that patchset in you tree?
>
>I can't take anything new in my tree until 5.12-rc1 is out.  When that
>happens I will go through everything submitted to me and merge fixes
>like this one and get them sent to Linus in a week or so.

OK. Thanks for the information.

Thanks
shuo
