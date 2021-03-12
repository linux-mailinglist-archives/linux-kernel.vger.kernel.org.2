Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2833911F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhCLPUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:20:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:61816 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232354AbhCLPUW (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:20:22 -0500
IronPort-SDR: 1fiOFvkrfpCsjh0pwSptp7DJLHHS/BlOQ3MSwmeSZt9tJSf3d2aYt2F4uDjMJdM+jp2Etiv9NE
 3RGSIifZcAsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="188886448"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="188886448"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 07:20:22 -0800
IronPort-SDR: DFC5C6KeDznHFLtbMkxt/T5/ayAJFSgc6btsexWTSI1pSqSXBmEoZFsa6zTbBnFKTwnICmbzAc
 DGZsxIgKICKQ==
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="411033735"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 07:20:22 -0800
Date:   Fri, 12 Mar 2021 07:20:16 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Create '--add-default' option to append
 default list
Message-ID: <20210312152016.GA1318940@tassilo.jf.intel.com>
References: <20201222011131.12326-1-yao.jin@linux.intel.com>
 <20210312151437.GO203350@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312151437.GO203350@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A more concise syntax would be -e +event
> 
> The + would apply to the whole event list if there are multiple.
> 
> and maybe -event too to remove something from the default list.

Sorry that was an old email. Please ignore.

-Andi
