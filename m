Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8808F3D17F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbhGUTib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235319AbhGUTiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:38:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8758861241;
        Wed, 21 Jul 2021 20:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898742;
        bh=u96cfduoSRTVMuAHQugLqHPx5JeckJNOWKK7TyCZF+c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gQcfcIgEZmVehW5dsWRgeN23J3N+1slY39ZOj+Wgnj7YZulEfki+CCZJIptPfNTxy
         ofK6V41dAhp7yl78oSrvJizSgECg6u3ZDWaikrld4qs9elulDvuab+aRKJElWEoCEL
         MVc6/H4JZr3jfjGNoY/ptPl/xPUQwKQ4nx+1ZC24C8g2dEvYUW69l3tFGpWH5RF/6z
         GiUN0N+oIWPnuNA/tS67qk57vEXt4vemXcycUvGiz+QkScGqt5CiVpXTlr5o84BvG5
         2qyPdbdZUjO89CVscXVHXRmMT2xleHhneYoDbcY42pcb7cix1YR3T9hOpeq2a2xZmB
         kwfViFdnCphUQ==
Message-ID: <3d4168e0f7e62a31a00b3a16d155224842442dd8.camel@kernel.org>
Subject: Re: [PATCH v3] tracing/histogram: Rename "cpu" to "common_cpu"
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 21 Jul 2021 15:19:00 -0500
In-Reply-To: <20210721110053.26b4f641@oasis.local.home>
References: <20210721110053.26b4f641@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2021-07-21 at 11:00 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Currently the histogram logic allows the user to write "cpu" in as an
> event field, and it will record the CPU that the event happened on.
> 
> The problem with this is that there's a lot of events that have "cpu"
> as a real field, and using "cpu" as the CPU it ran on, makes it
> impossible to run histograms on the "cpu" field of events.
> 

Yes, you're absolutely right, it should have been named "common_cpu"
from the start, not only for this reason but also just for the sake of
consistency.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


