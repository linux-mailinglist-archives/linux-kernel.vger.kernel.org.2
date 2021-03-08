Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A00D33123F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhCHPca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhCHPb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:31:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F90C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:31:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id y124-20020a1c32820000b029010c93864955so4058036wmy.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 07:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dNSasVgKsp25MrPS9CMg73B6ywrRGmCk45MATFRXXyU=;
        b=i+EuXPys/UBz+2pCyyi4s0IG9bzdHdCQu5/WHztlg+9sX2Fj30x5hCX6OhZTkff6cL
         8w5vWVmS+haOCBFbPwZt/j26pst/TOYcsyfznhY+dHnODJ3LXkekMUHmEogcQJm6z8hi
         /dv+cT1frBAQs+grxjefECUw5rE2Ha/fUEpXVssee4RhufrH6R10DKnr0+5R8+w3KA2e
         Hx+OssHXmoDt4q9EhoFIVi9ldT8kVHWXU44DsMVsAGweBhZXlLRqmZzo7AAHqyLM/Y5O
         ujuz2y7WHTKwY3ECBwA1CXv+ZNi8n+fXLemru7KYHKpn5O59s7OW4Ms32goUa/Olc4JF
         UoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dNSasVgKsp25MrPS9CMg73B6ywrRGmCk45MATFRXXyU=;
        b=iEbvQQQ9FF3liTEz7Wrn9ziAaspEhCguiP5LBnvdF3jIGlzi3dwUWy+Wx/HFBlA+gb
         YeiTrBbKP8vFnZ4e+jiOoiIrFIUexcp7E+/BXAEe1hiklNH7OXlVKwAecwgGbl9P/lNy
         G/dGyYodfD+HN0c1C0072nR8G+AM/GCP6fGjhzF8NBogK1W2QA4HEoQUrB9aMihjR36R
         jBgpmy+J2XabshFfKG70CmUyzrYMsFbjTdMLU68lk1OyLkdhVa5U/QOUzZzqq9pD+ADb
         RV4hlvFlkofiFxzn5JXImA3fTcuvxeZwc3yerlVFSZHkPfU1+7Valv2hQswtWENufi9B
         ezWg==
X-Gm-Message-State: AOAM5300CH3rSsEhEEdBBpvFpFWM9eaONm5+r328BnylnSktpLYCNcXa
        Uh3Ol5dFz4mGAUKllDtW/wUokA==
X-Google-Smtp-Source: ABdhPJyo5HsRmCNjH5IA/LN6GNYqc8eKdKNCowu0kiU+VpikQjXXdACPd4YH277/uUAdNRcnrzDlgg==
X-Received: by 2002:a1c:c244:: with SMTP id s65mr22881486wmf.2.1615217516275;
        Mon, 08 Mar 2021 07:31:56 -0800 (PST)
Received: from dell ([91.110.221.130])
        by smtp.gmail.com with ESMTPSA id n23sm15854202wra.71.2021.03.08.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:31:55 -0800 (PST)
Date:   Mon, 8 Mar 2021 15:31:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v3 0/4] Some improvement for Intel MAX 10 MFD drivers
Message-ID: <20210308153150.GM4931@dell>
References: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
 <20210308020454.GA32151@yilunxu-OptiPlex-7050>
 <20210308090124.GA4931@dell>
 <20210308144233.GB8110@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308144233.GB8110@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2021, Xu Yilun wrote:

> On Mon, Mar 08, 2021 at 09:01:24AM +0000, Lee Jones wrote:
> > On Mon, 08 Mar 2021, Xu Yilun wrote:
> > 
> > > Hi Lee:
> > > 
> > > Could you please help on review this patchset? They are some
> > > improvements for intel-m10-bmc MFD driver.
> > 
> > Please don't send contentless pings 1 week after submitting a set.
> > 
> > Also please refrain from top-posting.
> > 
> > This patch is on my TO-REVIEW list.
> > 
> > Unfortunately, since I work in reverse chronological order, you just
> > pushed the set to the back of the list.
> > 
> > If after a suitable period, usually around 2 weeks, you think your
> > submission has been missed, please submit a [RESEND] instead.
> 
> Thanks for clarification, I'll follow it.
> 
> I thought my submission was missed cause I didn't got your response
> since v2 at Jan 26, maybe some misunderstanding, so I'm a little hurry
> this time. Sorry.

We have plenty of time to get this in.

I'm currently catching-up.  Please bear with me.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
