Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069A5435E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhJUJsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:48:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44954 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhJUJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:48:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B769321989;
        Thu, 21 Oct 2021 09:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634809561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mf8IwQXl1UXfUJSInC0TTiQwmDvI3e26hwaIFmhLjNA=;
        b=EIwh7hHbx1dBnZjuPSVMJ/aG1+VLaBtfNRbOrjK4UapmtbdLZMzIWkfDQ9jY+IafsRy08x
        qEbrc6c+Oi828hWyWaI2JRPXMtEyWhYo/SclFnNbRFPwWpTntQhHE39Ky5lK2LfToFBrRM
        p/M7e473qGcO3/xcQ8ChEcdyd4LgdOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634809561;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mf8IwQXl1UXfUJSInC0TTiQwmDvI3e26hwaIFmhLjNA=;
        b=iuBQzKE6LVbqf2yLFdbyqugjG7TnwSY52L1ZrYTfFkeF32391dK5DFNkS5yPao870zQxpP
        KOPYMMQY0m916iCA==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 188CFA3B8E;
        Thu, 21 Oct 2021 09:46:00 +0000 (UTC)
Date:   Thu, 21 Oct 2021 10:45:59 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 3/5] sched/fair: Wait before decaying max_newidle_lb_cost
Message-ID: <20211021094559.GD3891@suse.de>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
 <20211019123537.17146-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211019123537.17146-4-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note with the change in the subject format causes b4 to miss this patch
when downloading the series as an mbox. Just something for the maintainers
to watch for if they use b4.

On Tue, Oct 19, 2021 at 02:35:35PM +0200, Vincent Guittot wrote:
> Decay max_newidle_lb_cost only when it has not been updated for a while
> and ensure to not decay a recently changed value.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
