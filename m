Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D8F3905CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhEYPqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhEYPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:46:06 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE2C061574;
        Tue, 25 May 2021 08:44:35 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c10so23409289qtx.10;
        Tue, 25 May 2021 08:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=qMaa25UCc9CiAt6aoLWjY2qUV9/trgZVm8dlt7Joxcs=;
        b=Vw1xB5ELFM2diO6zMjddIXMEed/HiuoUZn1OjBlHBnEn7ydLSPlltrbtw/6GX8tDA5
         trv5bjLtr7DgGPYw2PdCv9sgvrOFlgIQzl2FIfBowGQgZMXNy0eKy112hdUgpaM4gkLs
         HMy3mx2xDQlZTBEil+4xElV/8EJpQiCmkf5CAB085XA/ucRYKy1WjMmwuvM4uaumO86p
         SlV76onPBllmRgOqs+f/EAByxbgDezJ7YiIYLESbqcONZ8BYHcPLubpdbuQIUFi2HUMJ
         dqIeQiG3rnQ5qbNGeayaSTxfcUWOJhaX71qcCjyp+nlnX+WoqErDfAsG2xgFDlVKh3vM
         CDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=qMaa25UCc9CiAt6aoLWjY2qUV9/trgZVm8dlt7Joxcs=;
        b=ByIafq9UADGTdVVDQC2rYTFV2ROcXXhSSQfoXnsjCKaSHoczmb+gEVpvOGs4Be5DQy
         pW5DnWZWUy84GyUiZj9zAQXsmQMEIs0LVCOX1zgAWbhsUtohqR6ZhZV7C9SgD7uiVxGB
         8ksfOp+pdeES57g9XPiTAE2f0/OiJDz81AuPN7/zrsVnw8nXPxauZj+44X97rF3SjiLg
         51NdlWvSxuHoMFHTXFTeW0kwoIMDdJov4SlCGaBV21vy5pJyYpO95xoYupQqLOmc0rxR
         1FgfrlulXB7/JDJp+lkEcTHAMndqDCDFVFY7O0PcyAjWC6Bx9SH2zJiFMc+7EPXxCb5B
         hxFQ==
X-Gm-Message-State: AOAM532hmU8o+4qzx64Fw3nfCwsXdolxNfGkXQNKosF9ur9f9QdWy/tT
        Spdl6I/lMp5Iv52toA76XG0=
X-Google-Smtp-Source: ABdhPJxSqkNVKiWX/7LV1mw4xRiYgCQpUWuLY3Eg/um5IywI0cE12Onm7KksFYqE3PmTtU/b3pKuRA==
X-Received: by 2002:ac8:4756:: with SMTP id k22mr33228895qtp.193.1621957474640;
        Tue, 25 May 2021 08:44:34 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id e4sm3124255qtq.5.2021.05.25.08.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 08:44:33 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     sieberf@amazon.com
Cc:     sj38.park@gmail.com, Jonathan.Cameron@Huawei.com, acme@kernel.org,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, linux-damon@amazon.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sjpark@amazon.de, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com
Subject: Re: [PATCH v29 05/13] mm/damon: Implement primitives for the virtual memory address spaces
Date:   Tue, 25 May 2021 15:44:27 +0000
Message-Id: <20210525154427.30921-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3da2bb79-4448-4857-a9d1-698a360c51a2@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 25 May 2021 17:19:04 +0200 <sieberf@amazon.com> wrote:

> Hi SeongJae,
> 
> Some questions for this patch:
> 
> Why do we split the regions in 3 areas (heap, stack, mmaped)? I 
> understand we don't want to model the whole virtual address space, but 
> why don't we just use whatever is modeled by the VMAs to define the 
> regions boundaries?

First of all, number of VMAs could be very large in some processes.  Also, VMAs
could have small gaps between them so that our merge/split strategy doesn't
works effectively.

> 
> I am not quite understanding why we both set the page idle and young (in 
> damon_ptep_mkold). For WSS computation on our end we have used 
> pte_clear_young_notify. Why do we touch the page idle flag at all? What 
> flags do the reclaim logic use to track access?

Both DAMON and reclaim logic read and write 'Accessed' bits in page table
entries to check if a page is accessed or not.  Because this could let them
interfere each other, we have two per-page flags called PG_Idle and PG_Young,
which save the original state of the 'Accessed' bit.

For example, if DAMON needs to clear 'Accessed' bit of a page, it first sees if
the page accessed.  Because simply clearing the bit could make the reclaim
logic thinks the page was not accessed, it sets PG_Young in this case.  Later,
when reclaim logic needs to check if the page is accessed or not, it first
reads the 'Accessed' bit, which cleared by DAMON, and finds it's not set.  But,
reclaim logic checks PG_Young together, which set by DAMON, so it knows the
page has accessed.  This also means PG_Young should cleared by reclaim logic,
when it clears 'Accessed' bit.  Similarly, DAMON sets PG_Idle when it clears
'Accessed' bit.  And, vice versa for reclaim logic.

Hope these answer your questions.  If something unclear or I missed some of
your point, please feel free to let me know.


Thanks,
SeongJae Park

> 
> Kind regards,
> 
> Fernand
