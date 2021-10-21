Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D57436896
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhJUREF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhJUREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:04:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69AFC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:01:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y1so839944plk.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ROWLVcA3zbx0a2s7WZ6YTOzMe5htCzY/r3YEXiuLx4o=;
        b=kbtKqp869IvvyYrIFZ+BH/Q0al7dwwzh5cM6+zpyBkF7KGxb3RdZG6AjqL12NXrkvj
         i8TwIJqIVmoMIBKGrwILTA3CQO+qDER/xHXw3nm0xh43UVeuwQ5oTRs40LK7OHGWTEpH
         JrpCjJhrhkPbXr4Kp1cbU+RO3L2iBO/XAW84g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ROWLVcA3zbx0a2s7WZ6YTOzMe5htCzY/r3YEXiuLx4o=;
        b=AUW6XQsaZ05Hov5u4p1V8jym3o8Fu5DPTBWQuAp5eIhVzcY3v83f67vjHt7jsyQNCZ
         WIcc0hinFHOg7lbBdP6z4jOepXYcQgNKDdlOfTHw0TzTlis3Xi/qJ+wmuORV9zUyHQmv
         loXTUGf/s8JuomG8byJm4h3cXA/dNyC1zlzXUbt/0mNv67idjpdSpLdnSn3A7tZc/vJj
         Ce+sLL+HFYgL/zEnv38CNMBOQxTdu+VfWvx5WOpzINn1cLcM8AJTpIJjPl0nfkT/nyra
         RFdggqez7szUKxMP5gQ+Eu2M94hq47rv7+K97cMfHruqrxmW/2GQcHxk8SAuFIJKKO71
         fQLw==
X-Gm-Message-State: AOAM532VWrgp3RGupRYgXhP8h5v6TCqGRRqAm26OTUNbSfg3cE8K8GkA
        7xeFzKRkYilurHMqSWuA5Fplig==
X-Google-Smtp-Source: ABdhPJxkAyOwGvHc7ivx7LjrapCTdkqnEb6o93YA/TplTcs4cE/vfWTTgvplAtmr9P2ANXp/IgvLCw==
X-Received: by 2002:a17:90a:cd:: with SMTP id v13mr8130252pjd.81.1634835707409;
        Thu, 21 Oct 2021 10:01:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l29sm5899803pgc.47.2021.10.21.10.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:01:46 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:01:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iommu/dma: Use kvcalloc() instead of kvzalloc()
Message-ID: <202110211001.F9F26D90@keescook>
References: <20210928222229.GA280355@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928222229.GA280355@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 05:22:29PM -0500, Gustavo A. R. Silva wrote:
> Use 2-factor argument form kvcalloc() instead of kvzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
