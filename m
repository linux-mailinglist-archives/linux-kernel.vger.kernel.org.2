Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAF4401EAD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbhIFQrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244626AbhIFQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:45:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050E1C061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:44:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso298466pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qUKAVgey8N4kZvJLnGlfOr9eXtHM4g/GRduXb2uYC6I=;
        b=DQb3+nwSZe+oskx3Wom0DbNOpGE8DHrNt+Mz+C3YcVhdrOCgeFmVXcLasNDWMOjHlU
         kjJGaDqHir4YdJ5yy4joWwVVEgr0J5zaXtgn0wRAQKp4egv4m5LiCbMMWp8Q047dKXkr
         VG5inevt9HG1cG2zVBAJ7zlx0MYeGV3V3H3XHMIZqDFQftypASAL3XAcfhbyDPsp2Fc0
         NY1sAeXdak/Nf2sFEdxMcptB0Re6PrE7LW/UABgZKplNx2pGuL1h8WptUJkEADtsy+a3
         R2DOD1wx7u/cSaSBoQeLWdzQJEj3Y9CovlpBGgDWDYgk5cuChmzwAqV1rR74xQPUGdQq
         dUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qUKAVgey8N4kZvJLnGlfOr9eXtHM4g/GRduXb2uYC6I=;
        b=FQ7Ycf00Oq5zf1m7rzfE3MJ0+xD9R6+MuQuvLFk41FXuJfGTPtxzyPwwei6Sf++sl1
         pMJxTHVCH+3IDaeOeNZbVOihh2DSkMY06ZB+gXZ7++SXZt8anW3gldpanOKOf/N22e85
         PkeVhPva3sNLtVMPOrhJNkuFymtXcOYNSIjncJF1JT6VleWXRk9RTBuC5RpJyxbitIB0
         9ZkEoESTvjQjm1OVw2HSixiXdxwyyDairBpt8k0rq5Z9FdZGKTSm9lpbAjDIBIqJcXwe
         qpTp6WatLkhTU68v60MO8pzz7/S+jTu6o3E/SqGv3qZ7Pf0Et8Zs9AV8UjImMT4XCdXN
         dg1g==
X-Gm-Message-State: AOAM530jGyU33xLSWcFc9yeicxv8bSnXo9L65zkKtjk07S9ibgFy7rLp
        NRyddavBj1c3CWsFn2sKX63+dSGogKvm6Q==
X-Google-Smtp-Source: ABdhPJwL/EZox1h1kx+NOTl4pTr/2mnRcnHGlBF67Qd1G8NSKezrHXhVzksQb6Kifga6MTe460ke7A==
X-Received: by 2002:a17:90b:38cd:: with SMTP id nn13mr18147pjb.81.1630946668328;
        Mon, 06 Sep 2021 09:44:28 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id z8sm8042492pfa.113.2021.09.06.09.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 09:44:27 -0700 (PDT)
Subject: Re: [PATCH] block: include dd_queued{,_show} into proper BLK_DEBUG_FS
 guard
To:     Julio Faracco <jfaracco@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210906163831.263809-1-jfaracco@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <56e17907-83d7-7b45-8b0f-5d80d9005c70@kernel.dk>
Date:   Mon, 6 Sep 2021 10:44:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210906163831.263809-1-jfaracco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 10:38 AM, Julio Faracco wrote:
> This commit fixes a compilation issue to an unused function if
> BLK_DEBUG_FS setting is not enabled. This usually happens in tiny
> kernels with several debug options disabled. For further details,
> see the message below:
> 
> ../block/mq-deadline.c:274:12: error: ‘dd_queued’ defined but not used [-Werror=unused-function]
>   274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>       |            ^~~~~~~~~
> cc1: all warnings being treated as errors

This is like the 10th one of these... The patch has been queued up for
about a week, if you check linux-next or the block tree. It's going
upstream soon, in fact it was already sent in yesterday.

-- 
Jens Axboe

