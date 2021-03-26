Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5127234AC4E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhCZQJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCZQJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:09:07 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D174C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:09:07 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v10so4910287pgs.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lIcnanrk10QDmrkIGCRHv28LS/gWvsFt4/Zo24VtCPo=;
        b=YMRKuY7r1PwN/cYNgX0E7y6/ZlaQD1jQVDghdRmsq+HdyOo2UE5M8JMtMdhDTXbzEg
         h7BmBP2gg2xuKWCw06LqZYmzaPHp9Ity3pkXYW26bKwaINntPFudQnrPBKQv2ct0NNaz
         hJdsF00B5cIubGCW7nyTWLm9Q1/Z6qQjDSiikApVfeqsTt3P6imBYI0uoKDD5NDr+EW5
         +IwFCFjWpwfNK/GGGWtjr2Gi3DAgLMc2dGpAY5/DTVNdCJhBBD1lgCdxwKPMVqxi7Yrw
         cMe2Zhz7Nb6Nfv2VerGE8hiacG+dNUZo0FX6hKiStpScwriJnxe156cpYKJry0at1QYX
         J3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lIcnanrk10QDmrkIGCRHv28LS/gWvsFt4/Zo24VtCPo=;
        b=Gfcln5cBBwqpjlb76vHgTtnqdnibo0LJwRVMznvwMtAdQADgpX0NPayXhP4R0+chiE
         YXjrAQhDn0z+j5vSSZmaM8x4A+sStTK2ZKTitObC5BYx3D9nRc/dwMJ8i7ulcSjKQwUV
         v2Oumb6D1SledQAIIVn8OSHZEVkgqOawA4o9cLN9CXnzJicC25tYLTSsExJN1Iq1ABtw
         fw6SVJIj6CCmKpj2iGxM0CXZxPgklWj6uqjSiSp27WNnv8TUS0lZQVbxV+mClT4QxNxt
         CuQFRfM8AjWw1jXYhMzKZ6i5B+n2+koDmJL6ZUE5kA5TFawB6rOQxZNbIMlhij6EQ/wd
         YSmQ==
X-Gm-Message-State: AOAM532jV3tc0T5H7c9jqTi+A/m/ylMSHu9AZa73Q1W1bedT/xeegGSM
        4I17rYTu2AD/FYs0v5/r0Pj1i1kG2o4=
X-Google-Smtp-Source: ABdhPJwzmsveSGWfGsLk7S94JOGaJMl7JjEhtUHvn8+RvN+t6po1fmQicMEA+L3UqTPqEe+NTNqi8Q==
X-Received: by 2002:a63:1149:: with SMTP id 9mr12650475pgr.169.1616774947076;
        Fri, 26 Mar 2021 09:09:07 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:14e1:3f1e:1043:d7ce])
        by smtp.gmail.com with ESMTPSA id w23sm3048931pgi.63.2021.03.26.09.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 09:09:06 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 26 Mar 2021 09:09:04 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     rostedt@goodmis.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: cma: Add the CMA instance name to the
 cma_alloc_start trace event
Message-ID: <YF4HIBbat5nc3Kzu@google.com>
References: <20210326155414.25006-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326155414.25006-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 05:54:14PM +0200, Georgi Djakov wrote:
> During CMA allocation, print also the name to identify the CMA instance.
> 
> Suggested-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Acked-by: Minchan Kim <minchan@kernel.org>

I guess Andrew will fold this one into original patch.

Thanks, Georgi!
