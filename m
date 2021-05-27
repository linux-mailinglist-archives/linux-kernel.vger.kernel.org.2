Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6339392C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhE0Kxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbhE0Kxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:53:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59749C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:52:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 131so206803ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1xcT6jrG5YT/VGJt3xj4b4RVYNWNiBhF6jGh+aukeaw=;
        b=aim5QEULZnMrRAJ2tmIJ7KoGEzeUF0BHqci45vYMqHDHPtvWM/bp43D7N97Pe3wg0e
         fBhx8jwCuI1wxc1ZGcZ1nwND00fWf/l/4V1+1bejZnPfK46FJS26t4LQ0ps8T5e7Y39d
         fK8QUaTVQNN6hE15jibeDML9CWUgPcovJVenNC6lddTd3aztW6NeA+pSXkO/Rj9L2Nay
         /BZvlQHaG0RXLGgKw3mU+2nPxbjRJefjePgITiVHJ3lI8enSESnm46G2I8qz5atJggeb
         2EO7Tz9fQu/EtW3GqW1tnrTSEdXEqSszTSOgTiu7ykaRyo07r+dotyZ9WeyoWr/l6Tn+
         SKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1xcT6jrG5YT/VGJt3xj4b4RVYNWNiBhF6jGh+aukeaw=;
        b=EaUKZ+EVTqscSBVo8w1HbrsywpcDEXEzXpBQb5yjUY7ZqSximoUt4rZon+Am+csC2/
         3Xmb2DSBeidWeDhOxJcxZqEVAb11MaaNNFMCCUXuydffsJQKdKbrxOWNsbpLGq1K7RHf
         TYeqeWa/Ele020AJePVTw0hzESOSvchRh4aUt1jWlMx1oQPuvx1ffaVq3kK5FGUSC3yG
         /tY6FiOAOPF/YcOO9hyfD4fW5xpLqQO+irOem5p5qTpTDlQtM0r9x8HWilEtQ8s6Qy+h
         8CCSoT5rcAxIsN3GfC3eygE6gCsaXbknHCzkOxIyihQmu8YALEIAGxkK62PZXicvKK2n
         VBzg==
X-Gm-Message-State: AOAM530vqJJ8lTHNmf0qeApbP93pdhNA+lbaamPhyuds8ORDsdJWDlkn
        1L6+yeEIF3KvBnIYJ56iJbqABg==
X-Google-Smtp-Source: ABdhPJwIadPyUd2DJfPZ0J/5KQtbOrPXt4kiqessaF9VpSaheJK8Vxnjff3O2MofSuRvXcrHcU+D9w==
X-Received: by 2002:a2e:9746:: with SMTP id f6mr2130245ljj.262.1622112728743;
        Thu, 27 May 2021 03:52:08 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h23sm169441lfc.52.2021.05.27.03.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 03:52:07 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 96AA610278E; Thu, 27 May 2021 13:52:14 +0300 (+03)
Date:   Thu, 27 May 2021 13:52:14 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     hughd@google.com, ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        minchan@kernel.org, naoya.horiguchi@nec.com,
        wangyugui@e16-tech.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 1/2] mm: thp: replace DEBUG_VM BUG with VM_WARN when
 unmap fails for split
Message-ID: <20210527105214.jqbmyufsdtb5vdhm@box>
References: <20210526201239.3351-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526201239.3351-1-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 01:12:38PM -0700, Yang Shi wrote:
> When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
> fail, but the first VM_BUG_ON_PAGE() just checks page_mapcount() however
> it may miss the failure when head page is unmapped but other subpage is
> mapped.  Then the second DEBUG_VM BUG() that check total mapcount would
> catch it.  This may incur some confusion.  And this is not a fatal issue,
> so consolidate the two DEBUG_VM checks into one VM_WARN_ON_ONCE_PAGE().
> 
> [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

For both patches: 

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
