Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CAF3390F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhCLPOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:14:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:64001 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231378AbhCLPOi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:14:38 -0500
IronPort-SDR: TPOU6JerdHtdffdrR8ScxdhgD2VYLhF3RHXzGRfmPNlEI5MrCg6blzNXN3yR+Sqi8aSwilkr0f
 nyl9Xc5xlrpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="188937870"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="188937870"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 07:14:38 -0800
IronPort-SDR: N9VKMYmfTNXld/b1lKiAKQX9WjkVM8fH8w/SpuamD0I9dPp4y3Cc+5h2l+36NOargUQ6UYLh7Y
 yH3nlMdZQlQQ==
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="448645717"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 07:14:38 -0800
Date:   Fri, 12 Mar 2021 07:14:37 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Create '--add-default' option to append
 default list
Message-ID: <20210312151437.GO203350@tassilo.jf.intel.com>
References: <20201222011131.12326-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222011131.12326-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 09:11:31AM +0800, Jin Yao wrote:
> The event default list includes the most common events which are widely
> used by users. But with -e option, the current perf only counts the events
> assigned by -e option. Users may want to collect some extra events with
> the default list. For this case, users have to manually add all the events
> from the default list. It's inconvenient. Also, users may don't know how to
> get the default list.
> 
> It's better to add a new option to append default list to the -e events.
> The new option is '--add-default'.

A more concise syntax would be -e +event

The + would apply to the whole event list if there are multiple.

and maybe -event too to remove something from the default list.

-Andi
