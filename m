Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5D138E58E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhEXLiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:38:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:42682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232494AbhEXLiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:38:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621856208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I84Om9AbLWUNDYu7X6goqSlgpXNz4H2MwZ+N97qbSrs=;
        b=a77rihw26UhxQGU9Effv3MJDf+qpFhEIwSCjsfb7zneb/g2UjLKUNyjlhBfENDdAK4I93U
        2MRSuUUqcPYbZtj3Ayx9Q0RbqvknTxUxzOqz89UWazKaLv4nMbQUrtjcIc6zPWbl9x5fAs
        CMEuRFt1xK3TZLmWlbNsQm4Qky7RZak=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB5DDAD05;
        Mon, 24 May 2021 11:36:47 +0000 (UTC)
Date:   Mon, 24 May 2021 13:36:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] lib/hexdump: Add a raw pointer printing format for
 slub debugging
Message-ID: <20210524113647.h2avhbrngyydwwqn@pathway.suse.cz>
References: <20210520013539.3733631-1-swboyd@chromium.org>
 <20210520013539.3733631-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520013539.3733631-2-swboyd@chromium.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-05-19 18:35:37, Stephen Boyd wrote:
> We want to get actual pointer addresses when we're looking at slub
> debugging reports. Add another prefix format specifier that says we want
> raw pointer addresses, i.e. %px, in the printk format.

This patch makes sense only with the 2nd patch.

Please, do not do this! Raw pointers might be printed safely
only in panic(). Users should be warned by the fat warning
triggered by "no_hash_pointers" in other use-cases. And
this patch is not needed when "no_hash_pointers" are enabled.

Best Regards,
Petr
