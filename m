Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E1638105F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhENTRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbhENTRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621019801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R27Jf03ZxREnKxwqc3tfY/ljdTBme23N34D66vuvIQg=;
        b=Ow3SrpMTq+C+149YXjvsGd3ozjSYy+P7XYbL32TSDl+RSYcX1qCzuU/q9J3EU6kuqiJZtd
        BsPPd7WzlMUjlfcqurGUvXAQ0eU3RfYZdoDx1hKiwNJEKnEJubWarev8Pcdee2FXT/49eS
        JEFdkvN36RVfGYJ+0sOxxLCrLb8inww=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-El8uDjjVPU6KTbnK_GampA-1; Fri, 14 May 2021 15:16:39 -0400
X-MC-Unique: El8uDjjVPU6KTbnK_GampA-1
Received: by mail-qt1-f197.google.com with SMTP id v13-20020ac8578d0000b02901e4f5d48831so311181qta.14
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R27Jf03ZxREnKxwqc3tfY/ljdTBme23N34D66vuvIQg=;
        b=UtL0OZUD7vk/oPVuemriv7w+odXt61WtKaMKBMxcgI4D9fjMVRSj7uBo9lQWbldiZp
         MmXCxKqOg0PKAQsenF7NhhJhslqe4JxVqVtXbsK/DOZpLN+s2PXIllelGgHmHpPbdf0v
         3HBLn6KHdExsQNjpzWl1Mk7KKBZUwFs7zJo9YuEtZ9v8DQaBWJripvOwAKucc3DLlhex
         0eqFBZyJJYmxiHkyp5iWwl85H84ErnwdrKdd5kAjZlisY3R/nR8eGee+gaJa7W6u4IeE
         1VKosCdGhg36JGRywHo2t0Ey54vu9/Irh8Doln3kwckPYVgn4bMOeGqtV4iFPpegZKEA
         Xvfg==
X-Gm-Message-State: AOAM533sLfLG1JpkuiH1IssimePRqwhzO0eKL5g9tSdc88L+LstXcWxw
        M0iZBARXFfnLiYiTJ+AyT5aOGsdPIyMQgmR1/iJZFFwMKsW6TNqCehemRRUIYTAu/Evf8+5dGz7
        0nZMkX4ftXMl94I36il9uq4yf
X-Received: by 2002:ae9:e80c:: with SMTP id a12mr32290581qkg.85.1621019799290;
        Fri, 14 May 2021 12:16:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJs+ha/rpm7/oDhLt+mOMNO1Kxmt5d5fuW6jdVLELsSygkTzBiRgTBeOiTpRSfxRjcymOgfA==
X-Received: by 2002:ae9:e80c:: with SMTP id a12mr32290560qkg.85.1621019799027;
        Fri, 14 May 2021 12:16:39 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id i11sm5069427qtv.8.2021.05.14.12.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:16:38 -0700 (PDT)
Date:   Fri, 14 May 2021 15:16:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
Message-ID: <YJ7MlJaYzzJ/01R1@t490s>
References: <20210513234309.366727-1-almasrymina@google.com>
 <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com>
 <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com>
 <CAHS8izPFc+bSrKN-6gRguGefAqrj6kXaMUvgeUL5U7QxhXfWDw@mail.gmail.com>
 <f9c85756-62e1-3d5c-9fbc-f38c6e8f07f3@oracle.com>
 <YJ5tjWKyVZk2mvxo@t490s>
 <dd83c970-797e-6b7a-194d-790df5d53867@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd83c970-797e-6b7a-194d-790df5d53867@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 10:56:36AM -0700, Mike Kravetz wrote:
> Since this is a shared mapping, can we not have a 'regular' mapping to
> the same range that is uffd registered?  And, that regular mappings could
> fault and race with the uffd copy code?

Yeah we can..  Please ignore the paragraph in the parenthesis.  Sorry.

-- 
Peter Xu

