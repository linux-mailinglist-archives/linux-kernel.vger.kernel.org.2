Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0226D425806
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbhJGQgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhJGQgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:36:06 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0C3C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 09:34:12 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r1so6698841qta.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ui3Zht7gk020J4pnZHjyE2xEVPI8NlCg4DvxTFIksaQ=;
        b=1u1fP++bIB8g/1iWAgTT4y0zbnmRczgrcXrF+1kS6GjmFXj7dpGgZNbPoBqbnT0jxZ
         K+glsN/IWwiByn1dSFEQK+4QZW96M1R3VDqzeRSxOOwb4PqruuYLqkcsK5x3gwbTP6LY
         hVfmUOBsw73mwXVlnMINQIp7Pauw+Nh+busFGamOWWHZnGkxn+WzQWGfxrb7mH2jMHe9
         vV5Xd4sLHHVAPzPETxgR6L8cBVrfZf+q4f4/TGF/hwOHywILZh3881iJsClE9FAj9H5K
         S/12cjKcY66ktd64n122qziHo0944XVgOmXpvaLG6Gj3sbi+vKH3fGAGpl2ktMmJGnHq
         i9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ui3Zht7gk020J4pnZHjyE2xEVPI8NlCg4DvxTFIksaQ=;
        b=S8fQFXyWG03hw73+dDwlKxdQoc5plogBBTP8mhloYmK+rFvuWoFD/0/0mUQ5ts15oQ
         sz3aJnML9I2qOo7Np0WI3Do64dfTnasmu8QNu+bo4N7uHvkuigN14xerVvit/SD03kmp
         ZvWPPRhj9QihTKwWXBNHaZceISStFpqrMJ06omYKszqY85UZO2F5pe4jqEqyHjD6bOFF
         F8amGL5LcWHyihAfh22LaA02kbjT2LA4WbUN2QdHm6TRldKYVR8L6mTMZ+GKKDR7OXN6
         dPVc16DO4tZCEkjGSOrXtoDbWNoVThdsCvPQTAmaOXpO+NqX12vUBEItKZsIOBC/MIT/
         yPXA==
X-Gm-Message-State: AOAM532HvlZSwS/eTRrRBTgKy2nJiC+ARTY5pRNRqHCPgx2JZugA+e9A
        lLfoB7SH0Dr1RQCYZ24jmlNzpR7Vjyf8yA==
X-Google-Smtp-Source: ABdhPJxbnXn8H2eKBBwL5e2NXuHeekoXVevUbMZNR49f39CXPSHyhOeuLu+F5HLEMEePvTK3bCL2Og==
X-Received: by 2002:a05:622a:1712:: with SMTP id h18mr6106228qtk.389.1633624451319;
        Thu, 07 Oct 2021 09:34:11 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id a3sm6871qkh.67.2021.10.07.09.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 09:34:08 -0700 (PDT)
Date:   Thu, 7 Oct 2021 12:34:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     =?utf-8?B?6KejIOWSj+aihQ==?= <yongmeixie@hotmail.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?=
 =?utf-8?Q?H=5D_mm=3Avmscan=3A_fix_extra_adjustmen?= =?utf-8?Q?t?= for
 lruvec's nonresident_age in case of reactivation
Message-ID: <YV8hfv36iT7jyQTq@cmpxchg.org>
References: <TYCP286MB1108D012DA436CA72029ACA7C5DF9@TYCP286MB1108.JPNP286.PROD.OUTLOOK.COM>
 <YUnwsyE87TViMNMz@cmpxchg.org>
 <TYYP286MB11150330E283CC23CB16E40CC5A29@TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM>
 <YVc6zOy51aaRgw2y@cmpxchg.org>
 <TYYP286MB1115E3D67A88FFF1BFB68996C5B19@TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYYP286MB1115E3D67A88FFF1BFB68996C5B19@TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yongmei,

On Thu, Oct 07, 2021 at 02:35:44PM +0000, 解 咏梅 wrote:
> You're right. I checked with the commit 264e90cc07f177adec17ee7cc154ddaa132f0b2d
> 
> I was say that, because back to 1 or 2 years ago, VM used reclaim_stat's rotation/scan as the factor to balance the ratio between fs page cache and anonymous pages.
> It used the side effect of working set activation (it raised rotation count) to challenge the other side memory: file vs anon
> And in shrink_active_list deactivation also contributes to rotation count.
> 
> So I got the conclusion that active list rotation refers to deactivation.
> I checked with commit #264e90c, only executable code section contributes to active list rotation. Thank you for pointing out my misunderstanding.
> But, deactivation contributes to PGROTATED event. I'm still a sort of confused:(

Yeah PGROTATED is a little strange! I'm not sure people use it much.

> 1 more question:
> why activation/deativation/deactive_fn removes the contribution to lru cost? because those are cpu intensive not I/O intensive, right?
> 
> So for now, if we'd like to balance the ratio between fs page cache and anonymous pages, we only take I/O (in allocation path and reclaim path) into consideration.

Yes, correct. The idea is to have the algorithm serve the workingset
with the least amount of paging IO.

Actually, the first version of the patch accounted for CPU overhead,
since anon and file do have different aging rules with different CPU
requirements. However, it didn't seem to matter in my testing, and
it's a bit awkward to compare IO cost and CPU cost since it depends
heavily on the underlying hardware, so I deleted that code. It's
possible we may need to add it back if a workload shows up that cares.

> As my observation, VM don't take fs periodical dirty flush as I/O cost.

Correct.

The thinking is: writeback IO needs to happen with or without reclaim,
because of data integrity. Whereas swapping only happens under memory
pressure - without anon reclaim we would not do any swap writes.

Of course, reclaim can trigger accelerated dirty flushing, which
*could* result in increased IO and thus higher LRU cost: two buffered
writes to the same page within the dirty expiration window would
result in one disk write but could result in two under pressure. It's
a pain to track this properly, though, so the compromise is that when
kswapd gets in enough trouble that it needs to flush pages one by one
(NR_VMSCAN_WRITE). This seems to work reasonably well in practice.

> Looking forward to your reply!
> 
> Thanks again. I get more clear view of VM:)
> 
> 
> It is Chinese national holiday, sorry for my late response.

Happy Golden Week!

Johannes
