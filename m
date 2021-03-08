Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7A330AC2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhCHKB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:01:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:55496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231515AbhCHKBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:01:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615197671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jJ0CqRoSQ5emF5DzaqWkKFlK3XAuYO3wcAOiEhmXNGM=;
        b=DXU7mb0Tya/in9AumNJAM9ppQ0gjjkLL0w68Q0pZFghr2w+Ofi06v+0dUBSfcj5ICOXfYu
        pdpujPgm9H5EMhgvoWJFzyNt5M+HFBx3F2zx8D+hBY9/E6mZECq9gqOkmNd3XtYZzEVvP7
        mRrydxhfhj94vawfOYqcXfQSC8Fq42g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C9B7AD2B;
        Mon,  8 Mar 2021 10:01:11 +0000 (UTC)
Date:   Mon, 8 Mar 2021 11:01:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, vbabka@suse.cz, timur@kernel.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: Re: [PATCH 1/2] lib/vsprintf: do not show no_hash_pointers message
 multiple times
Message-ID: <YEX15gn0lfDpc1dw@alley>
References: <20210305194206.3165917-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305194206.3165917-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-03-05 20:42:05, Marco Elver wrote:
> Do not show no_hash_pointers message multiple times if the option was
> passed more than once (e.g. via generated command line).
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
