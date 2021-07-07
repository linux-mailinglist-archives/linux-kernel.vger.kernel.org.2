Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE763BEA03
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhGGOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhGGOqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:46:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D966C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 07:43:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z9so3023437ljm.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vkESMM/gWlQ9auljrwo1P9tZoQdMJqKtiyBWXEBwPoc=;
        b=Q7+jZT+u2LgOOB3yUnc7NN/Y8oeG/FIJBVSjBqv1DWgXd5qGUsKMf/w4SRBsR6sQBQ
         FALknI5+U3EQ+59io55EfA1TISq98BT4QpsqJ0isD5jvLV1y1VuMCVxKb0wsbWN1Zakt
         GvEcbN7VKze0SXoiFNf5pLw3hsSKjRjjdfP66/MpRaeotNhM49VW4D+MChpKBn/PAsOB
         qnMx7nHOpPd6PayQUVxUBEaene5V6ko2m+alyN5gPlhJ2rllJInFjLG7IwdwWoupXpD3
         V9yihgz0hu+qQytirlqVcGDCDbVATlmCU1TyJ5me7n3krHxBPhVK3rgY0wQ2/LI6JOkS
         g0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vkESMM/gWlQ9auljrwo1P9tZoQdMJqKtiyBWXEBwPoc=;
        b=d9ZOHGHzfA/uI57ulkTycZ96LExv7+PUNXAuRrHutvYCVLE8OqGldbfGOB4TudGxrR
         nH+0nPQP6va6wRZW3aw3d2SL2i25jSv6sOvVstUE6Gk6xbKwTgGBT2C56kY16I9eivOP
         /ILLxlat6BKqLephsUMeADQGbcKFKVrpqjgaWht2k1j1YRSAWMzJ5/n3l3MB1Z6aE6B4
         bNr7lCXM2kVnKelF9MPDuwJlZswJZD6mlBvtd/4dISPxoBeze8h/+yHC6IhKQs8tlML2
         U+iwcQyRtxLMBI/zL1GvoD5PFAhMPLRkXhCTsdXa67YS6QbpXFcD1ctsWQaR4zaZj/NB
         HUXg==
X-Gm-Message-State: AOAM531LlHFXyZlpoXjMjLBsurNlESH0wnduiRIu4BbvbG8/K2/wqE9W
        JoHxTDlBZedvLdPw0HbM4li/XUIEn3Wf0g==
X-Google-Smtp-Source: ABdhPJyx+b1MLPmm2BEQO4XhxpcmhwhyLIZ/9DSGC/wZnooSrTjXxz7Des6Ad108HLwjWdZicc2IWg==
X-Received: by 2002:a05:651c:1798:: with SMTP id bn24mr19009961ljb.335.1625669033686;
        Wed, 07 Jul 2021 07:43:53 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id bt27sm1718834lfb.267.2021.07.07.07.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 07:43:53 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 7 Jul 2021 16:43:51 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/2] mm/vmalloc: Remove gfpflags_allow_blocking() check
Message-ID: <20210707144351.GA1863@pc638.lan>
References: <20210705170537.43060-1-urezki@gmail.com>
 <20210705170537.43060-2-urezki@gmail.com>
 <YOVrCs9Uxt8zcHgR@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOVrCs9Uxt8zcHgR@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 10:51:22AM +0200, Michal Hocko wrote:
> On Mon 05-07-21 19:05:37, Uladzislau Rezki (Sony) wrote:
> > Get rid of gfpflags_allow_blocking() check from the vmalloc() path
> > as it is supposed to be sleepable anyway. Thus remove it from the
> > alloc_vmap_area() as well as from the vm_area_alloc_pages().
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 

Thanks!

--
Vlad Rezki
