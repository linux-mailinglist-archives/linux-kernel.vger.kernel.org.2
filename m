Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7675938FE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhEYJ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhEYJ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:56:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5B4C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:54:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n2so31603505wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qEEO2ZMZSJeGntakUFqLDv8eZl5wPjg44rw10m7qX/E=;
        b=cDF46+XCEHEFL7A4rUBDi5JNXMPCM6KrOkEgxy+c5CUhsMBtEmXtK+68UFGsF+bQSf
         S8L3gF3SYJ62GC9sOfz+9m6xu0tXvMqaaBSQLLkm/heYMU/S0BR0tF1zVBxXJnYqVJr/
         zHm6g6f0VdrdCrPDIqL91bsL0fsahZu3M0Vr2W05YiQL4VDWi4AnTAkcGzrR4lZz0yXq
         f8dBXMmOmFjrznE1VdXda0YWCLhttlSoIeX7Nhbut4LASnRlhUrfYbVi0qPsMiCJpFug
         JlE6xGVPT724Tbvd20jpDndUUIni5ktwzbuOO2J5zFeBseCLdlDRvDbfpLa14cL0dYy2
         T70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qEEO2ZMZSJeGntakUFqLDv8eZl5wPjg44rw10m7qX/E=;
        b=tV2ZqLVsqNakJMPhL06xaOpJSoSnp8TIIg1oRDfCozcy/jCQH84zd14ryk03BG+eDV
         geO1YSBnwlDyjCn5I69l0TlbTotYLtcFzawq9BFz8xTtH5jNX7E1Nf89l28cJhf8aZys
         eTI/WKwInClCchGFgzQqhu5DMUu197CDWyyVK5wGE8sYtx8tzuufOIFzg/RJhBeskGF/
         ZENqvLOD+A+hSQhAZOjauh2Xty7vpCFH68XU0PP2KHydPkwhKHzGRRfumklIopevsp2w
         RR11dntHtODAEHyLiSZ+0TWj4QdZ/6HuUTcUc09+L+rCoN9utKZLr2K2ax0/8EJudI/3
         9mWg==
X-Gm-Message-State: AOAM532mywnnb7gBO6SbidSRNoYhhV7RN2Wzpr05o5/Hs0k3SzmcLhFm
        AgPO4nAGmC87xoN237UpzAyUpQ==
X-Google-Smtp-Source: ABdhPJxgc8Fs5Rlucz6ZpHrZ8PnjCMCAtctbTJIiX9Yihtlh11kRIAUepyNe+aeT/+zHzezPWW6HNw==
X-Received: by 2002:adf:f805:: with SMTP id s5mr26405921wrp.143.1621936476659;
        Tue, 25 May 2021 02:54:36 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id y6sm2109727wmy.23.2021.05.25.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:54:36 -0700 (PDT)
Date:   Tue, 25 May 2021 09:54:33 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 2/3] PM / EM: Extend em_perf_domain with a flag field
Message-ID: <YKzJWabSyUzHiRb5@google.com>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-3-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621616064-340235-3-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 May 2021 at 17:54:23 (+0100), Vincent Donnefort wrote:
> Merge the current "milliwatts" option into a "flag" field. This intends to
> prepare the extension of this structure for inefficient states support in
> the Energy Model.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Reviewed-by: Quentin Perret <qperret@google.com>
