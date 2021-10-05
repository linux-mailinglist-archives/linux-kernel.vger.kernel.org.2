Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C454227DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhJENc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhJENc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:32:58 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF793C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 06:31:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 75so19783929pga.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N6WcobQhwKL5iMDYA55jGtZkA/ZPP+IY9Fikzc/zM3A=;
        b=HrahWYOUhct5Kw3eeUHtB0bTsnyrJL+raXc3dOUEJcYTzpPXCISkkeyizQumFGt/Xb
         aqiZ8fxZVPZIRAdAJ6S0DHxErqi4W0xvq9cArzGVBWv/eTNTd5GS7d52fhdlTzLXb4++
         NdMW6/QH+d9x2tKWIGgl3fQ2cDst3Cf5kmPVByt5G9tcaHO/wfXi8fayBthAYcGAPoW3
         brniTTnfV41t3jOnkLOGnRMwbTZ1n8dY7FoDftGc3hE/Aaz4JXH+4LV4M7utqzAOZlif
         wh2O4L8sosFJSRtSIqUOmo3bj6CA/V5BHsBmSzsnmrD8AN76HCEop7p45JpbtfM5sGi/
         59nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N6WcobQhwKL5iMDYA55jGtZkA/ZPP+IY9Fikzc/zM3A=;
        b=f99siL2VZqvowT6GlCxckrfMuBG1T924XeIUfXluj0J+rPEOJvOspMEGQUMzK2QceW
         s014nA2GC42hS8Qr1PpscH6QakZtibV+CgD1DOPmTQo97vVdHoPnHNh9rKg3SEJ5aM/l
         P7xBSPPkC7+rWPRxsJvqCHf0FJQ5Csn/BT296xg6njEZH57KAor5iRJFnlc4FqjOuDQT
         QwJ083IW5s+juBDR0U3rNe0LCdue1UiPI1TMZi7Ef0Ju4eLFAu8WvGfviDzKBp6vMN4u
         Hrnk2u8tMPiD8FGeI2F/uvgU8vf7WT+7anMHsvNxZNMPv4DsVurJR8sUAAZduPnh0FuP
         EF3Q==
X-Gm-Message-State: AOAM531+czJcrSqj0eB/azP24kCpJ5Tzp0fUz/k10tCpO/l2XZBGJVD8
        5eHRJ8uxTReyvaa0dwkvFVg=
X-Google-Smtp-Source: ABdhPJyPqufXl7Lxz1Hi18a6QKzQyZdopN/uYN4g1PhLhHCl0VygweuZElrVzgaB7o1Z1W46+lmPcA==
X-Received: by 2002:aa7:9517:0:b0:44c:7b4a:8073 with SMTP id b23-20020aa79517000000b0044c7b4a8073mr4522010pfp.24.1633440667178;
        Tue, 05 Oct 2021 06:31:07 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id v7sm2172219pjk.37.2021.10.05.06.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:31:06 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:31:02 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] is SLAB considered legacy and deprecated?
Message-ID: <20211005133102.GB2760@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
 <20210928111231.GA2596@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <b3c5bd9a-5fbc-8388-a4ab-6c20864dc7c6@suse.cz>
 <20211003055928.GA7643@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <377a622-9a5e-37dc-8f8d-42ae124042b6@google.com>
 <20211004060109.GA2949@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <075fde61-8c28-25ec-0ec1-28b1bdea7c95@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <075fde61-8c28-25ec-0ec1-28b1bdea7c95@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 01:39:46PM +0200, Vlastimil Babka wrote:
> On 10/4/21 08:01, Hyeonggon Yoo wrote:
> > On Sun, Oct 03, 2021 at 06:25:29PM -0700, David Rientjes wrote:
> >> I would disagree that SLAB isn't currently maintained, I think it's 
> >> actively maintained.
> > 
> > I thought it was not actively maintained because most of patches were
> > fixups and cleanups for years and as Vlastimil said, new features are
> 
> Fixups and cleanups still count as "actively maintained". The opposite
> case would be "nobody uses it because it was broken for years since
> commit X and we only noticed now".
>

Yup, there seems I was differently using meaning of "actively
maintained".

> > only added to SLUB. development was focused on SLUB.
> > 
> >> I think the general guidance is that changes for both allocators can still
> >> be merged upstream if they show a significant win (improved performnace, 
> >> maintaining performance while reducing memory footprint, code hygiene, 
> >> etc) and there's no specific policy that we cannot make changes to 
> >> mm/slab.c.
> > 
> > Good.
> > 
> > I see things to improve in SLAB and want to improve it.
> > I will appreciate if you review them.
>
> It would be great if your motivation started with "I prefer SLAB over
> SLUB because X and Y but I need to improve Z", not just a theoretical
> concern.
> 

Thank you for advice. by making dumb patches I realized that
, yeah, just a theoretical concern does not help.

I should have more understanding on internals of slab allocators
and on how their characteristics affect performance depending on situation.
and most importantly I should have actual evidence of performance measurement.

I'm sorry and Thank you for thinking about and answering my (somewhat dumb) questions.
But I'm happy that I'm learning a lot from your feedback.

> > Thanks,
> > Hyeonggon
> > 
> 
