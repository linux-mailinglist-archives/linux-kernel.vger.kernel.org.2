Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7633346726
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhCWSFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:05:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:21877 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhCWSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:05:02 -0400
IronPort-SDR: qW+RQsju1/XEd8SqnWsNbRuIipdbzxUEF1FQrVlaqWzh+zRnDcbPN9qL40pPrBIk0HlEOpJxMx
 BQsXnmMw3k2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="187218096"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="187218096"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 11:04:52 -0700
IronPort-SDR: Z2ObeTmpUlkDr6bTqCFEhX+vfuo6CwWnRk6o1YPHiFoTswLTT10oqzfpFkyrsSSbEpiU5inl6N
 +QkpMs8WdZOQ==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="452251609"
Received: from laguitie-mobl.amr.corp.intel.com (HELO [10.252.129.185]) ([10.252.129.185])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 11:04:50 -0700
Subject: Re: [PATCH] soundwire: intel: move to auxiliary bus
To:     Greg KH <gregkh@linuxfoundation.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
References: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
 <YFmatyAoMZmBmkuZ@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <777b4ca6-0d51-285d-549f-6ef768f2a523@linux.intel.com>
Date:   Tue, 23 Mar 2021 13:04:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFmatyAoMZmBmkuZ@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Note that the auxiliary bus API has separate init and add steps, which
>> requires more attention in the error unwinding paths. The main loop
>> needs to deal with kfree() and auxiliary_device_uninit() for the
>> current iteration before jumping to the common label which releases
>> everything allocated in prior iterations.
> 
> The init/add steps can be moved together in the aux bus code if that
> makes this usage simpler.  Please do that instead.

IIRC the two steps were separated during the auxbus reviews to allow the 
parent to call kfree() on an init failure, and auxiliary_device_uninit() 
afterwards.

https://www.kernel.org/doc/html/latest/driver-api/auxiliary_bus.html#auxiliary-device

With a single auxbus_register(), the parent wouldn't know whether to use 
kfree() or auxiliary_device_uinit() when an error is returned, would it?

