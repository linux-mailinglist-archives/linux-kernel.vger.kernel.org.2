Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326054000C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348214AbhICNxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 09:53:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:46862 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235802AbhICNxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 09:53:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="206546619"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="206546619"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 06:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="603069684"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 03 Sep 2021 06:52:31 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.32])
        by linux.intel.com (Postfix) with ESMTP id 8CAA25802B1;
        Fri,  3 Sep 2021 06:52:30 -0700 (PDT)
Message-ID: <c7bd15d7144dc87e473c7cc0a7f825f27527d15c.camel@gmail.com>
Subject: Re: [PATCH] tracing: Dynamically allocate the per-elt hist_elt_data
 array
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 03 Sep 2021 16:52:29 +0300
In-Reply-To: <d52ae0ad5e1b59af7c4f54faf3fc098461fd82b3.camel@kernel.org>
References: <d52ae0ad5e1b59af7c4f54faf3fc098461fd82b3.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-09-02 at 15:57 -0500, Tom Zanussi wrote:
> Setting the hist_elt_data.field_var_str[] array unconditionally to a
> size of SYNTH_FIELD_MAX elements wastes space unnecessarily.  The
> actual number of elements needed can be calculated at run-time
> instead.
> 
> In most cases, this will save a lot of space since it's a per-elt
> array which isn't normally close to being full.  It also allows us to
> increase SYNTH_FIELD_MAX without worrying about even more wastage when
> we do that.
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>

Many thanks Tom! I've tested this one.

Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

