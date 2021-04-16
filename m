Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CEC361F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbhDPMGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243253AbhDPMGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:06:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D847C061345
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 05:05:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nk8so712074pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 05:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=53duoniRLlTsqGW5bX0atBzLc+S3mfJFAbdOwh1ig0Y=;
        b=XebPfasu1f3IBqtFL6POE5QmVzAHRsSQVt7c+rdKOs5np1YjkQXjRsHgvWFgJMF3iA
         rK4bKx8OazzVjStP27trdd2cyXDUVfB5WwN/t7kG5nbzeSi9uVhMzfIxmkuKukl+pr2E
         T0o/zFHD6PaydvQRcGLNNV1YoeXFapMFDL/skPDIfX81M8iVDM0RwYQ6t6UpClAruuch
         bOvuHaHnuk4SVX2i/KmO2wfJ7VX2wrIsCDsNiOyBugD9qFVrF8zk685nGlprCqrtRiae
         qVrZqOKBdfl2B/RpxarYoyiN+INVJpEYbZxAgGs8SFusptWa29IBnEM3VrvHmzwgEvee
         lYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=53duoniRLlTsqGW5bX0atBzLc+S3mfJFAbdOwh1ig0Y=;
        b=S5KrJDljXBCl3rsWztanJKhbMgbK/huzfd+zptH8oMRpURJIvFcIvcFP9iyghtlaca
         iJl5g3iLklYm+njz3IdJCPOo4XotHv1ar2Bjy+ievhj4cRDE7aU5wAVmvc581+uZckpx
         Gce7yUBEKrsE32rpfRtjvkHx7Hyl5R9Kd+qVQ2fJNu6d8wc+drpqMlQQfc3UIjwhGrJc
         qPkJYw3ymdehwIE3hH3tiMRz2LJORRa88YXTweaNwt+Ttm2HVwy9yEz9BfpEoFsBL0rX
         jDabqJPBTafxr15fvtI1307KOn8Np/XB2Bu5/28holSvZ3lyhUGkhU0s63TEoe0Er1BO
         MS2A==
X-Gm-Message-State: AOAM532PhZ18XbPFPtOLcA95t28rqoc9uXsueIU9Z1ei2C+JdGeefZzW
        r5xGUSX1kjCgqAewzYK4eeWXwfdQcIrPiQ==
X-Google-Smtp-Source: ABdhPJzdFI0du4cM1vGt4YPtsF3WN6FdkKb3ZQOSkCs9vbf+YlEZ322C+4J6PyFeBFnbrOVvjmolBg==
X-Received: by 2002:a17:902:b908:b029:e9:4010:7fd3 with SMTP id bf8-20020a170902b908b02900e940107fd3mr9098400plb.55.1618574736699;
        Fri, 16 Apr 2021 05:05:36 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j20sm10911895pji.3.2021.04.16.05.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 05:05:36 -0700 (PDT)
Subject: Re: [PATCH 0/5] Another small set of cleanups for floppy driver
To:     Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210416083449.72700-1-efremov@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <af78129d-66ac-3460-ae87-bee55ba634a3@kernel.dk>
Date:   Fri, 16 Apr 2021 06:05:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210416083449.72700-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/21 2:34 AM, Denis Efremov wrote:
> Just a couple of patches to make checkpatch.pl a bit more happy.
> All these patches preserve original semantics of the code and only
> memset(), memcpy() patches change binary code.

Applied, thanks.

-- 
Jens Axboe

