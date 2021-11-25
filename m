Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E461845D4F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348807AbhKYGxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348894AbhKYGvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:51:05 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5A4C06175B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:47:54 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y8so3817009plg.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8xu2aIxFiMS+FdoCDZiYWeLv0HFIncR6uH5xTnTYuDE=;
        b=sQ7DeQx2L7wyOPR8AcPj2GANXOImuYpFUsZVVyPXeFkHRdzeY53EDx1g9DibKS+Tkt
         If5lxUsGj4pBaes1VY3Idbzo/bVvsRrPq8+g5S/amBkhwtyZ0rpZQSGqLlqz14rgTBxA
         qdXq298SyjxjqaonhpCTUiHc4d6KDe/Gwz7rGuRqYABI9zZEe8Du5FNiBJAKWUrGimKv
         62fy4f3TGCw/stdY8x983P+ls4Bu06nqdsA3heRa8Y/Tx/4nIJAFKtPT7cq4r5e7h/O3
         6v4bYKvH3eN5ECerCjtGIr5RBrAW07a7YL8aro9cU+JhjOmmAl9Ub/+hQL42DAeEW4gk
         t+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8xu2aIxFiMS+FdoCDZiYWeLv0HFIncR6uH5xTnTYuDE=;
        b=j8Y6x1U4lNOhLeSvdaTk0DMYBSfNIwquY3VJ0CPhwLgcKtOoNsj0tgRM4Fjn9cwi/I
         kaVaN0Bm6F8NyzxRRRpI8nnovIHcUCX6ifUkib4TOTkOVAVxCp+98m5KJTdnywQPbi9h
         oDGJWS+u5lu1YYrP56DofMafC0ccRs4B0Tn/bOuvOIAaO9jmdNhykUQLNGOgDalicsU4
         eT+jszzG36VY2QnxAx0Azu3Rmdlg3bNWdksVrEOdJGke6ZAb36O1AEpUmeRySi+b4Axq
         gLj3cMkf5RRtjs8KjPiOzgXbpeYF+iWbDiI3OCGtTBweN8a4ST/Ul3yPGjFibJ3QvQAS
         3Yxg==
X-Gm-Message-State: AOAM532vERSoaA0pnxgi+CcRKEt5A6r4anItYTY5pd3eslONhx+oPIDN
        657fYDCW3/UDQJcaTKK7eSYLmQ==
X-Google-Smtp-Source: ABdhPJzRN1Vq8J4tQeRAEWR90H5WICez/RY4tb7lTi4AOQPbpllEtnv65NgkuG6F/L8OFo9V7oaMZQ==
X-Received: by 2002:a17:902:c3cc:b0:141:be17:405e with SMTP id j12-20020a170902c3cc00b00141be17405emr27698607plj.76.1637822874397;
        Wed, 24 Nov 2021 22:47:54 -0800 (PST)
Received: from localhost ([122.181.57.99])
        by smtp.gmail.com with ESMTPSA id z8sm1312770pgc.53.2021.11.24.22.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 22:47:53 -0800 (PST)
Date:   Thu, 25 Nov 2021 12:17:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        jie.deng@intel.com, conghui.chen@intel.com,
        virtualization@lists.linux-foundation.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH v2 0/2] virtio-i2c: Fix buffer handling
Message-ID: <20211125064750.ywq3vd76uy2levoz@vireshk-i7>
References: <20211111160412.11980-1-vincent.whitchurch@axis.com>
 <20211124185546-mutt-send-email-mst@kernel.org>
 <20211125032119.vklsh4yymwnalh5b@vireshk-i7>
 <YZ8rxHDPo68AT4HN@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ8rxHDPo68AT4HN@kunai>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-11-21, 07:24, Wolfram Sang wrote:
> 
> > Wolfram, you can apply that one as well, it looks okay.
> 
> Is it? I read that the code only waits for the last request while
> Michael suggested to wait for all of them? And he did not ack patch 2
> while he acked patch 1. Did I misunderstand?

Okay, I misread it then.

To clarify, we should initialize the completion for each buffer and
wait for all of them to be completed before returning back to the
user.

Lets wait for an update by Vincent for that then.

-- 
viresh
