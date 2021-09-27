Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04FB419406
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhI0MUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbhI0MUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:20:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5796C061714
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:19:04 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y26so37181640lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hzKn1PihSVTLBn07NxNCyepUdSFNC9+ZCpNDni2IA0Q=;
        b=KWWCYxQH7dXXcsSw6KvI24GDz1Mz+bv/Qopn6VTk6MiAZweawv3GE9zHYH9ARkhe22
         ri8eZzYAQeIv9cwXD+9kv7aVIn70pQV8qt9GAzY0P+jhd039IMUJSlUB8m/Aaq47i2Ij
         akrLz7+j+8CV5ndOeiGlys/XB2nceb7PPDxWi9FVhTewTyhJnkXeBsONOrZEXBPDw+Qm
         tGNJ46JZZNpL9kgtaQ13hlHNfuCJQ8e5M/U3SwJKZgI0OdMD4im4VEZmZtQ9nQICv1H7
         UOb0NQSn1mKE+5yqhLWtJVAml+1r3h9aI9bRLez8J1aZpGNk7a9LTbdnMcoeZHGVYwQG
         4WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hzKn1PihSVTLBn07NxNCyepUdSFNC9+ZCpNDni2IA0Q=;
        b=aYQvAZBaN9jmhMaPClX3cy/5+CE3uO4cSKfF58EMR+iVKeYyiVv6sRvCCygmqC8Bt8
         uuo9+tg/z3wvc2N9m1ESc6tqyUxPDbfC/Q8ZJNW+7IApi+1f77/i6LSY3L66XegTSL4h
         x/RU2929xUCSEbCKa8yq4LwzGJO6wfFBd0CXXO8knu1B8OdbDslYVUtLvgDLnzUP7n58
         pb/WDAgbUY3MZDSiV/Dd955tyCNXOWz/KSKfVbCdJb+F9yvPRMmBkIHIVUOfSe410Qyo
         W352KR+9g0dETN1L40FSGjCmhszYEKYiZadbdA6sQzd285YcmCiec7XQUt6reIjC1FAU
         QvcQ==
X-Gm-Message-State: AOAM530l3G1aKdQ8i/3iQQoG7K+IfpIafWQbYAklB2D4zfJXUZ7OlGFz
        eU38+ZRD7oYSDz5red/MiCsZ+Q==
X-Google-Smtp-Source: ABdhPJxb7Hx7XDrSV8+tSwjeT7uO8LkszuIvMqEi+lFexR7KTie06Phg7EB/AEUXzYIGhxWZxNB5OQ==
X-Received: by 2002:ac2:54a6:: with SMTP id w6mr23291702lfk.61.1632745143223;
        Mon, 27 Sep 2021 05:19:03 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d12sm1476888lfs.283.2021.09.27.05.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:19:02 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 55AD3102FD9; Mon, 27 Sep 2021 15:19:02 +0300 (+03)
Date:   Mon, 27 Sep 2021 15:19:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/8] mm/madvise: remove unnecessary check on
 madvise_dontneed_free()
Message-ID: <20210927121902.r5gslag4nvvseoxo@box>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-3-namit@vmware.com>
 <20210927091143.tn6ediykqycu6rtu@box.shutemov.name>
 <DD025444-B1A2-4470-9069-0072A59427A5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD025444-B1A2-4470-9069-0072A59427A5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 04:05:47AM -0700, Nadav Amit wrote:
> Having said that, if you want, I can turn this condition into
> WARN_ON_ONCE() or VM_BUG_ON(), although I really see no reason to
> do so.

BUILD_BUG() should be fine here.

-- 
 Kirill A. Shutemov
