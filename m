Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760C83E99B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhHKU2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKU2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:28:48 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998B5C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:28:24 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id bl13so1862705qvb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LC3frmOkSvH+lFYcR6dU7bcIfuDQCXIEzEOVy6RcgTw=;
        b=A3OP23K/9lC6v60ozAQDKhz925Qx+OiiPPSodMjR0aCp/ve59kASS86k4zZHpuzrTN
         BWD352t1OH568a7rsALvPA5mJhlNd54tH2Eyqj1zOe0hr0F0AY7cRGeMEKPp4oSTiqmk
         RN+fjI5Ls6Li52w/u/xUsXT5njDiHAfPNaxow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LC3frmOkSvH+lFYcR6dU7bcIfuDQCXIEzEOVy6RcgTw=;
        b=sUzFAVHsHsWEFOb1H+z/KPM24P5LfCC8xpQ1nwattLVMOr9bgXXwC692mKDMjStFuS
         rD+1P7fC9FlQ+kPbZni96AyRSfKyc7GmK19QoUMYVecJD42MUXp1pqWw0xoi44Rq+L89
         ilet1v8gPJ7xxiyjbJ6SGhPgMB/tHT4+OanQPBu7aGGiu5LHUWhEMx3hsS5FXPqvf3Vu
         8Xwoo7ImDGeowrlLVwl2vXiaO6xh90GRbptxPQflI0OC3V0ZuB0ejKIg6DkTq2ARcdvw
         /qheUQo7M/QtOI1MDvNNdmeLHIpbubnMUvNKSW1EtTlNOFAAATpzYLfuEyPE0bkGmQSD
         F/eg==
X-Gm-Message-State: AOAM531Zgvq9pta8G69FfOXV7s399kLO+5cUUFTS+QZu8X4e7FRiSboq
        teLukSDE0CbSj9szm6fTADOIvw==
X-Google-Smtp-Source: ABdhPJz6SjifcPBbr8JohDwOrZgtJxgTCBpZmk9ILQhjVjOvjhfKOSVp7sbw4IsF4yhOa+jmuPuMJg==
X-Received: by 2002:a0c:b450:: with SMTP id e16mr428248qvf.25.1628713703637;
        Wed, 11 Aug 2021 13:28:23 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id k186sm129465qkd.61.2021.08.11.13.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 13:28:23 -0700 (PDT)
Date:   Wed, 11 Aug 2021 16:28:19 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Jinlong Mao <jinlmao@codeaurora.org>
Subject: Re: [PATCH 1/1] cfi: Use rcu_read_{un}lock_sched_notrace
Message-ID: <20210811202819.u5p67vjzkdgcjzxk@nitro.local>
References: <20210811155914.19550-1-quic_eberman@quicinc.com>
 <202108111306.527943F39@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202108111306.527943F39@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 01:10:36PM -0700, Kees Cook wrote:
> Do you know if qualcomm is mangling outbound emails? (i.e. was the
> trailing body suffix added after calculating the DKIM signature?)

This may not be the case -- the DKIM signature uses "simple/simple"
normalization, meaning that all headers are preserved wrt upper/lowercase and
whitespace. These tend to not survive mailing list managers, unfortunately.

Kees, if you still have the copy that arrived straight at your chromium.org
address (not via vger), you can diff it with what you get from lore to see
where the culprit is.

-K
