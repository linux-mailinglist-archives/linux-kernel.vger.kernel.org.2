Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7E63C1F41
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 08:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhGIGXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 02:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhGIGXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 02:23:51 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFEDC0613DD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 23:21:08 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id w13so6907050qtc.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 23:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qAkS4ma6ehZVj7hlgoQzRiUO0M0ZEIWgqlnqCWow+Cs=;
        b=NvbfrMHmiWncf/2/WfmW+ymtGZkMI7x7J/bWVleXbGBsTnR9yw+Nr1eDRxwKiEWS3Y
         gZfomcB+aNZvDl/CGNfUvVq/m0Xn8W3GhRkoueX6VcThQzEwX97atKgjCMA5z2xwnbpk
         VP7FejY2z+blSJsL9QBgCBmWrtgGfCdc+/TFf2XN/0MTVz9KSpDBIvYgfRMYxArgM1hg
         c5SF/HcicpNOK9CqINx4I+WdU355JaOwJ0rIVnpqC1tDz/S5wxSUTE5r5dF6CYWNycKY
         oAh3M7ZBHtwW+jvB2xyrj/U74LrgW774WPKxu1k2xrObubfqqy6gYyUZHELSTYDPuu1K
         NItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qAkS4ma6ehZVj7hlgoQzRiUO0M0ZEIWgqlnqCWow+Cs=;
        b=h00ZcPJfTL8xSLWOu4Nr5KdiT9Mka4WJHSOA8NwCdcmXgoN43Z2Mc378RC3n5m90x3
         YjzV7UaXXkbAxyKX5PGWg9f3sB+ivNporvC+GOLXu5sw1ios7q1VWNj4HLugPxhOwZOr
         ErKiG3lfyVDo8Nls9zRUiBF4KWFtC9P3Z0dIzSVL0paD8JO4SlLoCV/iiWA1wKm2Tg+r
         A8BqYmXGeLsL8dTxrlQfApmBy5XJ3FUW+nNcMfcyxTCmBvXLw0lFnMwoQKTyR9HDgWSl
         CckACA6sd1FnFZtKf01pwoWajixIHt2mGfkrMLgVZMuEwfoSqDt2amK0C6RAQtCBECON
         pjGQ==
X-Gm-Message-State: AOAM531RwI/onf1kHeXyDb3GXA1HjDBJo7LTxmYmt4NsfTRnfhTZjN78
        Pl2rvxG7To2RfN/KK0yf/QUWZfWmHA4=
X-Google-Smtp-Source: ABdhPJwQm6ghSC+B5JHYOIp37dQpjyaDAHxDIZ7Y0oV1LdPzWOsq81dKoAuubfXa3X9aClRDdayAgg==
X-Received: by 2002:aed:2065:: with SMTP id 92mr30905472qta.283.1625811667358;
        Thu, 08 Jul 2021 23:21:07 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id t30sm2056644qkm.11.2021.07.08.23.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 23:21:06 -0700 (PDT)
Date:   Thu, 8 Jul 2021 23:21:05 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] bitmap: introduce for_each_set_bitrange
Message-ID: <YOfq0T/dVcX0+gr/@yury-ThinkPad>
References: <20210709034519.2859777-1-yury.norov@gmail.com>
 <20210709034519.2859777-3-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709034519.2859777-3-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 08:45:19PM -0700, Yury Norov wrote:
> bitmap_list_string() is very ineffective when printing bitmaps with long
> ranges of set bits because it calls find_next_bit for each bit. We can do
> better by detecting ranges of set bits.
> 
> This patch introduces a macro for_each_set_bitrange and uses it in
> bitmap_list_string(). In my environment, before/after is 943008/31008 ns.

Ah, it seems we already have bitmap_for_each_{set,clear}_region() with
the same functionality. I'll check everything again and submit v2 soon.
