Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3124435A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 07:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhJUGAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhJUGA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:00:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F0DC061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 22:58:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o4-20020a17090a3d4400b001a1c8344c3fso179489pjf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 22:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xCfmwNiGSIU1FWTiYV1xWdNfk6l/Oap6HAgg6fjLReU=;
        b=QfX1KxO1iDmoWlrWX4kmj/ikKGs91ceVH1DNPzMwDs35Nrv4ObEjsLoiF1FocVaOiz
         cRJnikiJTuE0K3RFq8D/NAvMy8x5vaAZOKy+0qkZ12XsRvRwmnLoX/wpKKHWEZWo/ry7
         ZyUlwxLJU2SAZGPAn8Flu3mVIq/B74FSWofr0QzUBxDOdslCuMt/NBHl5Z65Mk9LVvIe
         VvGjJTGawL7iDva1ii96MYLDca4A3W/lK+DL9Bwk6x2m43ztlCbLFputTSZ3IhJmXGOp
         1EEBYCodViTpG/MznXF+icHPMRvRJBv79dW+nvbccVVFOrDJwMbU3ougmVOAiLBfy0EW
         O/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xCfmwNiGSIU1FWTiYV1xWdNfk6l/Oap6HAgg6fjLReU=;
        b=B2cUdQqBVWBoM3v2VO+tgWoAfhLeoC7lE6VSsLfKuBHpDjsOa6SgXt+167mmkUzaaO
         OdMHkFAON0aQXSX0bCSX2/5tuCvprfHDPv9F+HcK9YGkRZ9u7L+OzHZbgXV6BCxr7yD7
         rCG7TggVh6KsPr3K4etax++/krORx0Q5tg5/Kg9BC2TyjDwrEKkfh5ky5cKcEMhSkTlN
         WXGsETu1Bb7m3Wcsmc3PBBalDiYYHCozpIZe7iHKSzD8aMe+aICuIff9k9AuyqA1u7KX
         eq9AZdGw7flVPxGxKk5zpNekIWmP7//brLMy7NXzTv/UcGO7C6jNdJwwtbDcFkG3Axan
         mlYg==
X-Gm-Message-State: AOAM532gCj963SQ8lYt0txfJXkNNkLmRxZzRgzJj8SW1+fT3fO88gykb
        DWmo50nxAtfNT/m+lrDVH5zW58g3xxmddg==
X-Google-Smtp-Source: ABdhPJysGXA45YfqU6m6F7iEIFsFMRwo+XnZ6TQLPxUKfVVZ4koslmjfwgQj434dEw6k0qDclNfxRA==
X-Received: by 2002:a17:90a:9b84:: with SMTP id g4mr4337506pjp.123.1634795892500;
        Wed, 20 Oct 2021 22:58:12 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id b8sm4305778pfi.103.2021.10.20.22.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 22:58:12 -0700 (PDT)
Date:   Thu, 21 Oct 2021 11:28:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Deng <jie.deng@intel.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>, wsa@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH 2/2] i2c: virtio: fix completion handling
Message-ID: <20211021055810.4ivtscmg2rs5dtt4@vireshk-i7>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-3-vincent.whitchurch@axis.com>
 <a6cb9ae7-eee3-74aa-87de-a2be3fdc7a76@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6cb9ae7-eee3-74aa-87de-a2be3fdc7a76@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-21, 13:55, Jie Deng wrote:
> Can the backend driver control the time point of interrupt injection ? I
> can't think of
> 
> why the backend has to send an early interrupt. This operation should be
> avoided
> 
> in the backend driver if possible. However, this change make sense if early
> interrupt
> 
> can't be avoid.

The backend driver probably won't send an event, but the notification
event, if it comes, shouldn't have side effects like what it currently
have (where we finish the ongoing transfer by calling complete()).

-- 
viresh
