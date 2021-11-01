Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4426C441EC0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhKAQpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhKAQpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:45:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A75C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 09:43:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w1so12438640edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KsuKAfI1J927R7wBfsDr9jYL8c9OdMkp9LmHo7bAPg=;
        b=Y/U/INPe/rmTm+KGdx/CwfL+Rs29y8YJ8P627tEGE3k/2oDTpUxpFOk7z1GP6wa3nG
         +epYv7DsMPfGT6H5LsRvdQbcZMdxrLhRN9+ggtkReKKpuTlE5BzUCETKJHPNJ3kDFydQ
         L3+Rnf89fpEouSnDbp2OHzHx2D7uOw3n+YKqZNL3MiYCqekt+rZ3+IIHJduxq5QVlra8
         k+M0dHFwEgtB1p355In4RcEoupLxyn29y5ckVhBi2WJF9LmsYS83fETS7aHDAeznNs8P
         pdIYG/GQxf8tGENG0UB2AYzWsouL+Pz6zGU7s8AspBWd4Mcdzw0dA/nPoSq/2uB6kMDw
         QmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KsuKAfI1J927R7wBfsDr9jYL8c9OdMkp9LmHo7bAPg=;
        b=ni1FjoRaafbA5JryCnWNIm0bch9jyAFnZjCycnpROySDOAgIIqrSVrdlcbG3PaZVDr
         nRAU0Rq2AhQN95og08zSv40V0y7baX3DykrAcNHUy93tOtSF1B3kjUCvTVyqXaylvBqx
         by2z/1mgVC0JN4eoLR/rvMeKFbMqfdFkxMCN4VeB7HaIKBEGehyrxgVumQ9AMmFXz5ye
         WXyntFOv9G09bE0kUU4xJ410z1WSwSumg3QKFX4VBLk38J0Xsov0v4IW3HuelS+bVRhg
         mGasORoLE+l6L+gP4WabxeoHzgR+6ufQ8kUnAoi0DWTQZB5SGTi69blRTQs5DQTUSBLB
         iXmw==
X-Gm-Message-State: AOAM530flmaH6tCbvfQ3gFcmtrjBCSKAxThZ+60zPiFTTE1pp4NPqeEf
        /qlehKy3tVXISXVwRO4vUUc=
X-Google-Smtp-Source: ABdhPJyNJfDLWQBLy85DRkxbGwlcFzw7uvG3gIvBD8e/wxbcnFr5yywviPmlRzNnyUpj4pAZ432Rvg==
X-Received: by 2002:a17:907:608c:: with SMTP id ht12mr38210596ejc.78.1635784989689;
        Mon, 01 Nov 2021 09:43:09 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-54-101.retail.telecomitalia.it. [79.56.54.101])
        by smtp.gmail.com with ESMTPSA id k23sm9151404edv.22.2021.11.01.09.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:43:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
Date:   Mon, 01 Nov 2021 17:43:08 +0100
Message-ID: <2458707.yljdXZV4jf@localhost.localdomain>
In-Reply-To: <YYAFK83uzfBn03D/@kroah.com>
References: <20211101142732.5638-1-fmdefrancesco@gmail.com> <YYAFK83uzfBn03D/@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 1, 2021 4:18:03 PM CET Greg Kroah-Hartman wrote:
> On Mon, Nov 01, 2021 at 03:27:32PM +0100, Fabio M. De Francesco wrote:
> > Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in
> > report_del_sta_event(). This function is called while holding spinlocks,
> > therefore it is not allowed to sleep. With the GFP_ATOMIC type flag, the
> > allocation is high priority and must not sleep.
> > 
> > This issue is detected by Smatch which emits the following warning:
> > "drivers/staging/r8188eu/core/rtw_mlme_ext.c:6848 report_del_sta_event()
> > warn: sleeping in atomic context".
> > 
> > After the change, the post-commit hook output the following message:
> > "CHECK: Prefer kzalloc(sizeof(*pcmd_obj)...) over
> > kzalloc(sizeof(struct cmd_obj)...)".
> > 
> > According to the above "CHECK", use the preferred style in the first
> > kzalloc().
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > v1->v2: Fix an overlooked error due to an incorrect copy-paste
> > 	of the sizeof() operator.
> 
> What commit does this fix?
> 
> thanks,
> 
> greg k-h
> 
Sorry, Greg. Please let me know if I understand correctly what you are asking 
for...

In v1 I introduced a silly error while copy-pasting "sizeof()" and then I 
fixed it in v2.
  
I think that you mean that I should reword the list of changes from v1 
because I'm not explaining properly why I submitted v2.
  
Is my understanding correct? If so, I have no problem in submitting v3. 

Thank you in advance, 

Fabio

P.S.: I had to resend this email and I want apologize for the noise. It seems 
that it contained HTML parts and for this reasons it was rejected by the 
relevant lists.




