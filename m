Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF563530A3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 23:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhDBVQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 17:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhDBVQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 17:16:19 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880EEC061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 14:16:17 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id x2so6047287oiv.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EuMNzSviNgVTCMigCRn9biGypSs6VLzXgTTmdNbGnM0=;
        b=X/QMAEI97fgJ80rjf5uFusAtG4H/6OuS9yml3Iu4aBdSHgjhorK2ZE4AgLosnrcs9R
         JPRqXF1gOO4T/2rvF9wjHpJyfEW9Idw5AVyrsqt0KIgzU4QrHwOxF3Mk7mXfA0c3266/
         B2Sr+4xkGTLkp919H+ZpuV6vjm/v5KZLF0Z5s//CKlQJ3z/TAzLBYO8CvEkxsifUM2ch
         4hxs8LqAlRV1ehfc/cx7r3/aK9HkSCvTaF8LaoXeNMAdESRI+2JD7AOkRCyHmWwzgH9L
         kt0JoL74GWXs0hgNp27lO0SZdIGzCsX4lG23THqAFFz07Wdli/Ze0jnhzV3P8D0SiFO2
         BW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EuMNzSviNgVTCMigCRn9biGypSs6VLzXgTTmdNbGnM0=;
        b=VT4AgTudL1ZZxc5w/38bGD5aIpXlEcBu7d532UwUxKvI4Z33emla7dybxIYI/U0Qic
         cWja3sdP8VZKCtkFvb1ybPmtGWU7DCu4nadFMn2NQmBVdvA9dxsPKQKtXX8tPGhWbfBY
         CPc+7AWl2LVyOqPA/6ww6IPnNYbyk3afZHshLkvJpHcenmfvaBIRzQDQNyq/T8m1y5qt
         Kc1r+zNrqbxjm9wlDN7Cb8loeP2uUlOBQgOSvMvm9cw2ejw1C1+julLuD2Kgj+WeUPrK
         SXw3dw6jlZPdzEAi5lLSrOSmXwFwsTUU3y/D+azzmSXG6dmOrGZ4Wwj+Gol8LoUruo5d
         JeiQ==
X-Gm-Message-State: AOAM5330sTQg3CFlvJ0zFUVA8JHIQ8bVACUUQRT6noKxL30/ZVNRrYJ9
        k4Hk6GW7DCfQf9xS52hDmXsyTw==
X-Google-Smtp-Source: ABdhPJxHoLg7Mj6MbBeuVeCELsvBwuzhCT4GwDHbTxgp/9Ssp/rTN2MV9BgkVyI0Rhfnb98rln/95w==
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr11264930oie.4.1617398176714;
        Fri, 02 Apr 2021 14:16:16 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e34sm2099720ote.70.2021.04.02.14.16.15
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 02 Apr 2021 14:16:16 -0700 (PDT)
Date:   Fri, 2 Apr 2021 14:16:04 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
In-Reply-To: <alpine.LSU.2.11.2104021239060.1092@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2104021354150.1029@eggly.anvils>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils> <20210331024913.GS351017@casper.infradead.org> <alpine.LSU.2.11.2103311413560.1201@eggly.anvils> <20210401170615.GH351017@casper.infradead.org> <20210402031305.GK351017@casper.infradead.org>
 <20210402132708.GM351017@casper.infradead.org> <20210402170414.GQ351017@casper.infradead.org> <alpine.LSU.2.11.2104021239060.1092@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2021, Hugh Dickins wrote:
> 
> There is a "Put holes back where they were" xas_store(&xas, NULL) on
> the failure path, which I think we would expect to delete empty nodes.
> But it only goes as far as nr_none.  Is it ok to xas_store(&xas, NULL)
> where there was no non-NULL entry before?  I should try that, maybe
> adjusting the !nr_none break will give a very simple fix.

No, XArray did not like that:
xas_update() XA_NODE_BUG_ON(node, !list_empty(&node->private_list)).

But also it's the wrong thing for collapse_file() to do, from a file
integrity point of view. So far as there is a non-NULL page in the list,
or nr_none is non-zero, those subpages are frozen at the src end, and
THP head locked and not Uptodate at the dst end. But go beyond nr_none,
and a racing task could be adding new pages, which THP collapse failure
has no right to delete behind its back.

Not an issue for READ_ONLY_THP_FOR_FS, but important for shmem and future.

> 
> Or, if you remove the "static " from xas_trim(), maybe that provides
> the xas_prune_range() you proposed, or the cleanup pass I proposed.
> To be called on collapse_file() failure, or when eviction finds
> !mapping_empty().

Something like this I think.

Hugh
