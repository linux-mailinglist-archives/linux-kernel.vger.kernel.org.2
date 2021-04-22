Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B6E368838
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbhDVUt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbhDVUtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:49:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195C9C061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:48:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so10441pjj.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QnNd3C1c0U8Cy6rEZLpzrN98hcS02ETdlv0eBYCDY9I=;
        b=GeoZA0yJ0n988purgUs0PCMCU17Bu+L8wQlG66Vo/hzcqPi6v5+YgkLNa1GJuwhePr
         y/Clgwwj3/BJ80VEMHSyciTh4mVzur7v+sbdC+05atTrU0ipVDv+XqNBValvPRGRXklL
         YZtB/1PqwHwRZxThMxEFL2y8s8V9z6isoUmsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QnNd3C1c0U8Cy6rEZLpzrN98hcS02ETdlv0eBYCDY9I=;
        b=AypmFlI/jK7jKxRQpajPUQ55wolCW4Sogo75ReyZ8ME4pY1C1OQ+EsIsR/b51zFFq9
         wYzNRHn1P7jUlp8E3+uRIjLP0gLJHpN1zCfcwKvkcsZDT5ympt0LS2lX78n5d0whXAyr
         SOIxu+WDiIM8r0cKbIf49jlxwY9e+qd5Fya2LmX4EDY4mXL9wplunkj+nJ50iZq2rC3U
         SlH5DNhNDCTp8CWCNKnmKd2ftM6KfvMzWaGwztt6K4moTghlAKd+3/OYkKr+YbOl4BRu
         +SNG2z70p3Ah8S3GRZDfPt0EJwj1pVvjGkmi9619X9FskcPHXyGVmOTstYm2S9e7gANy
         q1sw==
X-Gm-Message-State: AOAM531QsODfuLHSeYMX/L4DosmdD0bfcL8GT++MRGroDTq0x7IgOYlo
        Us9wLnQP5wGKJatJLuDGTnauTA==
X-Google-Smtp-Source: ABdhPJzMvMOnaFySxstgcJPTR3rLDcb88LTqN6KyPWa+y2YnPhestqVSrc7MYSMJhsj+VL0/EcuDzA==
X-Received: by 2002:a17:90b:34c:: with SMTP id fh12mr631757pjb.114.1619124527729;
        Thu, 22 Apr 2021 13:48:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d1sm5486640pjs.12.2021.04.22.13.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 13:48:47 -0700 (PDT)
Date:   Thu, 22 Apr 2021 13:48:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] wireless: wext-spy: Fix out-of-bounds warning
Message-ID: <202104221346.4FE32C5@keescook>
References: <20210422200032.GA168995@embeddedor>
 <120f5db6566b583cc7050f13e947016f3cb82412.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <120f5db6566b583cc7050f13e947016f3cb82412.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:04:29PM +0200, Johannes Berg wrote:
> On Thu, 2021-04-22 at 15:00 -0500, Gustavo A. R. Silva wrote:
> > 
> > Changes in v2:
> >  - Use direct struct assignments instead of memcpy().
> >  - Fix one more instance of this same issue in function
> >    iw_handler_get_thrspy().
> >  - Update changelog text.
> 
> Thanks.
> 
> >  - Add Kees' RB tag. 
> 
> He probably won't mind in this case, but you did some pretty substantial
> changes to the patch, so I really wouldn't recommend keeping it there.

Thanks for double-checking! Yeah, I'm fine with it; Gustavo and I had
talked in the past about similar solutions in other places, so he
forwarded the intent from those conversations. (Not that you had any
visibility into that!) But, yes, still:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-- 
Kees Cook
