Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1543565E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhDGIBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhDGIBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:01:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD707C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:00:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id e14so26071488ejz.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0q2Zvg2ZRyPTOxL3mrhu4veJpz9kXed+0KYyX9N+YTQ=;
        b=isFXxKtPVgwQ9QXaSnhC+UCeyjZvj1kmTFE1wvgDHdzfsnsFalAL71p8FNLJAejuJO
         NeUXC4HZEfK9N2U9Y/hvJADU3evkK2Bv4BWPJ2hocd7VZtbpXXo2vOk0Ntiwi/5FDOtC
         oCKhjzvz8gY6whyryjkCbsP+qZNoTsOglPuz7fYtwMkFPHOz2Cx/5+FaMGLe/w1xOe9a
         VCFGD+MjYmASPUGuXm+4+PSWwFFnn941tsOzqvlwRXU4VWe3eYyzSm9G/9E3Dg4PtH74
         B4RyEYhc53NBKGaO4pRt03Zj4QmKXxdHAMe/EIYWqixcMqpCD22X6vChg390z4++ij4E
         XWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0q2Zvg2ZRyPTOxL3mrhu4veJpz9kXed+0KYyX9N+YTQ=;
        b=l4S+vpaunAKK0IF4LJs1xGrQjc2bHM0R2lXsTYvbs397+vLfCcXsW6Cizi+ocXWqjG
         zo/YIDgeCaJtbNu5oFgSFrnP/O0/BF+Sqk2Q6V9/18XQFNS5f5PZymc+Dfq5sPOvJDsG
         mt5JGlLvJ3j2XLR4RnlNhRdldxwY2934tZBN7jUHdpeksTdExmos8tPxayszHKrnTdml
         MJqRJPbRHlcxhy0QXG78qMknGBSIqSJ/5JY1011dI77ogcTn5ezw0SRlGQdyBwfy2t80
         7DibgKBFN1yV0A1mnRYq9vDj4eYm9gsl8x6TzdWx63S24XptHGqTocbE3GdiDW+VU7B+
         f5WQ==
X-Gm-Message-State: AOAM532htaEdMJQlxllugUb84AjG6Td+dB0UxhRRf0e6CETZ8dv+vlxr
        v1knighRQKtTJZn2+E0kHZJivA==
X-Google-Smtp-Source: ABdhPJykjBsZCEiRWzfJ/ZfRR3+kO3TdB05SBBr/NgMlhjRXvikzkxWBd2h9PjamvsLkByWOwE/IiA==
X-Received: by 2002:a17:906:1519:: with SMTP id b25mr2275874ejd.254.1617782458394;
        Wed, 07 Apr 2021 01:00:58 -0700 (PDT)
Received: from dell ([91.110.221.225])
        by smtp.gmail.com with ESMTPSA id h20sm5766358ejk.110.2021.04.07.01.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 01:00:57 -0700 (PDT)
Date:   Wed, 7 Apr 2021 09:00:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 03/11] block: mtip32xx: mtip32xx: Mark debugging variable
 'start' as __maybe_unused
Message-ID: <20210407080056.GY2916463@dell>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
 <20210312105530.2219008-4-lee.jones@linaro.org>
 <3d04bf40-a614-18f2-b003-a9786ceca1fc@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d04bf40-a614-18f2-b003-a9786ceca1fc@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Apr 2021, Bart Van Assche wrote:

> On 3/12/21 2:55 AM, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/block/mtip32xx/mtip32xx.c: In function ‘mtip_standby_immediate’:
> >  drivers/block/mtip32xx/mtip32xx.c:1216:16: warning: variable ‘start’ set but not used [-Wunused-but-set-variable]
> 
> Has it been verified that the compiler is wrong, or in other words that
> this patch does not suppress a useful warning?

Neither is true.

'start' is used, but only when debug is enabled.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
