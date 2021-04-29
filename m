Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF0136EDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 18:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbhD2QA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 12:00:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:48372 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232004AbhD2QAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 12:00:53 -0400
IronPort-SDR: wceLzUCvMrK7YJC8tG2F1WFMjawyN8DJae4zL6hhozS+j12Ju+Jd9zUMiLjpJc/mXX1IzdPNTR
 9s827i853Rpw==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="197084677"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="197084677"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 09:00:04 -0700
IronPort-SDR: U/8yaxw3td/+8z60rk5UsvHskzKR999+tiqEUo30+iUBySpk6PSxgfNAWHCgSdYUzZ+/NHfAU7
 QdLx0yWPtq9A==
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="466397550"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 09:00:04 -0700
Date:   Thu, 29 Apr 2021 09:00:03 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] perf inject: Add facility to do in place update
Message-ID: <20210429160003.GC4032392@tassilo.jf.intel.com>
References: <20210429125854.13905-1-adrian.hunter@intel.com>
 <20210429125854.13905-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429125854.13905-5-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +		if (!data.force && !inject.in_place_update_dry_run) {
> +			char reply[10];
> +
> +			printf("The input file will be updated in place. OK? (y/n) ");
> +			if (!fgets(reply, sizeof(reply), stdin) || strcmp(reply, "y\n")) {

Interactive questions could break lots of scripting.

Just error out in this case and require the option.

