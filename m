Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2AF41551C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 03:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbhIWBYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 21:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWBYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:24:20 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98601C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 18:22:49 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 138so16227558qko.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 18:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=vegAYHHwWq1ucbb5wAql7Fq5zi2BQ/ySb7VWAZVFi2E=;
        b=TFjcvXxSWkkR0Nh9wFz2aZ4K4yNk6JJBI+NS97vRGxt/BD1h97F0GYiRDUv/fLZOv9
         ciHK2yFJUc/BBGKHwy5+torH60ukEx24FtkrrltDf9kwJJ8qtnqonF7V1Eds5E6swvRc
         B+4oPl31Heh8O5BENZGK2EJA2MFrUOJvhUoBW7NUGnD5ARaIY3pusJjjeTBiPgoyWlzG
         TZ+d57lBeUiVBc++9mAo8VuTR+qC/WTtA9cdQYon5nhZ0cks/ZHzu5oeZBG561xy2HXB
         E9K5yIimQIIl4HhO9/aMRjKFwWJep6tiGiOqaDfMkaO2mmsaf3cXZmnqdD085ityfZ14
         Pj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=vegAYHHwWq1ucbb5wAql7Fq5zi2BQ/ySb7VWAZVFi2E=;
        b=P0aC+oKKeqs8KfFIYm6O+36IiZ9ITORjKFMOZAHAI2eREsHM15aNpau+ztc65O8c0u
         ISiiFQAdE4SO8a4xkjiC1sJ1dpCL0nUCaIcNIGmKflcfArdnPC4q8aCFqILE3rSl0U1d
         +AdIStxy/D9XzG0Yyf0FN5RydROa6Q6EFoQdCpvON8IDFxVzLi03V22IiwwdHwuGPTF2
         WVhoy2Ttc4K7mqS775ge/jig3DaIUIwssEX7EXrCyNpLjrt71k+EP7ZJvvFqm6e3oZeN
         6iTNwo9hY9cT2YnKOfB4RVaNWkPqYZ4IH3D41YFsEVnUW+n927jWiqY7T1wmuikO+XgO
         5rQA==
X-Gm-Message-State: AOAM532lnlQd4caZuUuXZoSZ88tzPNw6F/DKCMWzimEbgyTx22QT/GxY
        u4AwErt+1fxBvW2yCwXCuSTBqg==
X-Google-Smtp-Source: ABdhPJwgFEA68LwNG5vPFKwN4yJ0g4++HtDEwv+1VFUIGTzQK3c19FfBU6Yg2yrcULMP1GZBEFuK/A==
X-Received: by 2002:a37:6350:: with SMTP id x77mr2463135qkb.356.1632360168544;
        Wed, 22 Sep 2021 18:22:48 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g5sm3021545qkl.48.2021.09.22.18.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 18:22:47 -0700 (PDT)
Date:   Wed, 22 Sep 2021 18:22:45 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
In-Reply-To: <YUu/6lWX92WLUzpt@t490s>
Message-ID: <472a3497-ba70-ac6b-5828-bc5c4c93e9ab@google.com>
References: <20210922175156.130228-1-peterx@redhat.com> <CAJHvVch3g_UY-akMdu0O9413iCb1H83DLhR1Am8WnfUyV=s1=g@mail.gmail.com> <YUueOUfoamxOvEyO@t490s> <24224366-293a-879-95db-f69abcb0cb70@google.com> <YUu/6lWX92WLUzpt@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021, Peter Xu wrote:
> On Wed, Sep 22, 2021 at 04:18:09PM -0700, Hugh Dickins wrote:
> > On Wed, 22 Sep 2021, Peter Xu wrote:
> > > 
> > > Not installing pmd means uffd-minor can still trap any further faults just like
> > > before, afaiu.
> > > 
> > > There's a very trivial detail that the pmd missing case will have a very slight
> > > code path change when the next page fault happens: in __handle_mm_fault() we'll
> > > first try to go into create_huge_pmd() once, however since shmem didn't provide
> > > huge_fault(), we'll go the VM_FAULT_FALLBACK path, and things will go like
> > > before when faulting on a small pte.  The next UFFDIO_CONTINUE will allocate
> > > that missing pmd again, however it'll install a 4K page only.
> > 
> > I think you're mistaken there.
> > 
> > I can't tell you much about ->huge_fault(), something introduced for
> > DAX I believe; but shmem has managed pmd mappings without it, since
> > before ->huge_fault() was ever added.
> 
> Right, I wanted to express we didn't go into there, hence no way to allocate
> pmd there.
> 
> > 
> > Look for the call to do_set_pmd() in finish_fault(): I think you'll
> > find that is the way shmem's huge pmds get in.
> > 
> > Earlier in the thread you suggested "shmem_getpage() only returns
> > small pages": but it can very well return PageTransCompound pages,
> > head or tail, which arrive at this do_set_pmd().
> 
> But note that uffd-minor will trap the shmem fault() even if pmd_none:
> 
> 	page = pagecache_get_page(mapping, index,
> 					FGP_ENTRY | FGP_HEAD | FGP_LOCK, 0);
> 
> 	if (page && vma && userfaultfd_minor(vma)) {
> 		if (!xa_is_value(page)) {
> 			unlock_page(page);
> 			put_page(page);
> 		}
> 		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
> 		return 0;
> 	}
> 
> That's why I think it'll be fine, because it should only be UFFDIO_CONTINUE
> that installs the pte (alongside with allocating the pmd).
> 
> Or did I miss something?

No, I think I misunderstood you before: thanks for re-explaining.
(And Axel's !userfaultfd_minor() check before calling do_fault_around()
plays an important part in making sure that it does reach shmem_fault().)

Hugh
