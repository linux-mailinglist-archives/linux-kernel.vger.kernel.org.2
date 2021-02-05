Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA353112EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhBETPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 14:15:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:37605 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231243AbhBETN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 14:13:56 -0500
IronPort-SDR: qYPgD6J1nucGt0MAmvdTPxkdTbU7xq5zDi17poerJ94ZZjLb4Ss11KS5A8Uh6N46C9fdSlbNZ7
 SPzunBGOwwQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181551641"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181551641"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 12:54:51 -0800
IronPort-SDR: cfpB1xVPIF3bG0shlj0hP7EMqLwBeP1Kf4pgYWK5cqOIPIQ2sM+8+eMkP28ENxxZjThEE9ZJtP
 3KkPMydGmtHQ==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416146094"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 12:54:51 -0800
Date:   Fri, 5 Feb 2021 12:54:49 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/0] perf intel-pt: Add PSB events
Message-ID: <20210205205449.GG27611@tassilo.jf.intel.com>
References: <20210205175350.23817-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205175350.23817-1-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 07:53:46PM +0200, Adrian Hunter wrote:
> Hi
> 
> Here are 3 fixes and 1 minor new feature, for Intel PT.

For the series:

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
