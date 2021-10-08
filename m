Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF225426CA2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhJHOTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhJHOTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:19:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF11CC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 07:17:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 133so3253228pgb.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L/CzMPO8Jc+O1sHtBrds6V1Z8tVllDjegfHAhQ7SKik=;
        b=I1hOd2ts/E6PV2b1jzAcNDssQ2UG1394aF2dmHwdaKT4Buszzh3sYpxpeGH1cmg1fk
         Lu1owAbtsRS1BrAm9VAP1E/0MOjn1uZGX1syHpf1nErKTYWIrfdte2wpZ4kn2qI/uiaR
         DfKPkBMEd4F2B0tAXo+loYJ+0YvVgd43mzZNCYBN+KS82peKsStuXkQj3cmyAr8SiUMp
         fqBCQyxR+u2u4wEoVBqBD7RoIBhXzm37hxRH3UsVaQGeDUX8I7tPu5teduzsDbIuJcnk
         1U9dIjyV9Nclftgz4qhI/vUxXdCpKsD1AiwBuUsT3lSedN2Yu2VqULYt1zbA8o7dpH3E
         Rukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L/CzMPO8Jc+O1sHtBrds6V1Z8tVllDjegfHAhQ7SKik=;
        b=6wpa0PGoPNzOlXu+yMT/Y0lAJgPxXCtzIrI0X4SJnk5Xiwjlzf+HU1weMpH943ZVYb
         c3N/vdTv+3jiHujwzPGdh7CwE43pzzS+yLdQAE1eOMTFwTY/Xahs52RDtRsOA7RwUrjX
         aPG4if2Q1bZX243VW55Y9iMgml1uUp7M4kPFQZeAnWuzAw++e8dapDV2is+o9RdEaFIJ
         2ZwRZkcQUgAmyPhdKCEDBN1AkkJjtNT3cMqz4ptUI546ZsuUdxoCQbw4WcFV6SyvtQLA
         Z62FztCt5ffKw03DrKytmVOg7wa78o6cMNpwpTUXW6nSEiejB75p3phfeGlFqx0tLFsP
         z4dw==
X-Gm-Message-State: AOAM530yWVL/1evLHFWlyfz83KTowRalVhd+9YZjTzpjFBvebolwPn4D
        ODpGyh0MjDSdo1OqFzjSAxYXG1wOu7eBGQ==
X-Google-Smtp-Source: ABdhPJwQfsJjTu87zwsiI89yix0fortGxHpuo1wt7httjv/8cs/emeHt+vhHstWSC24GjZxY/bW+dg==
X-Received: by 2002:a62:3802:0:b0:44c:776b:f555 with SMTP id f2-20020a623802000000b0044c776bf555mr10552170pfa.82.1633702634934;
        Fri, 08 Oct 2021 07:17:14 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z124sm2928254pfb.108.2021.10.08.07.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 07:17:14 -0700 (PDT)
Date:   Fri, 8 Oct 2021 14:17:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, "Darrick J . Wong" <djwong@kernel.org>,
        Stephen <stephenackerman16@gmail.com>
Subject: Re: [PATCH] mm: Fix NULL page->mapping dereference in
 page_is_secretmem()
Message-ID: <YWBS5rB7SH9aPRti@google.com>
References: <20211007231502.3552715-1-seanjc@google.com>
 <97f7ae02-3124-8de5-f614-a2f7891645a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97f7ae02-3124-8de5-f614-a2f7891645a5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021, David Hildenbrand wrote:
> I assume we want to add
> 
> Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> Cc: <stable@vger.kernel.org> # v5.14

Doh, yes we do.  Thanks!
