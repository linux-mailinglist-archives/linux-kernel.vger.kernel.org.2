Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790A53B5703
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhF1Bw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1Bw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:52:26 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD66C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 18:50:00 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id a7so3318048pga.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 18:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8iY2XvGYIEGsPy5ZGZiQi9ADeEM827+ckbpfPdEArIg=;
        b=HpotKYvpqG61Gpg54HUKhviArjzigfbpU5tFnq0t8nL+1oJI/JDmpDiYEdrBt/6kNc
         3cnt9SoxgI1NRzO7R7ERaCRg8nGA+dMEsIYD6fzdki7oE2QaLP5L9UnpD1wjtBY1TBRM
         j9ln8ZzVASY9u8024p6Wo443xXptBdCSDiFoz3G3hl8Urncmc5OlNI9A1YjnMgYISe4H
         cgl9tsf1Swp28c1xuqHQD07yBDV0rNdyRJ3V1/QB1kbDbtp3Dk7CcMAjXKC7FDRdGdJF
         s8npiLmjK9oX3q2JqSYHD9vf8dJOkOWq7gwmc1WWF6C0SSxWGQGagp5gsxZf9NmifpWn
         shCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8iY2XvGYIEGsPy5ZGZiQi9ADeEM827+ckbpfPdEArIg=;
        b=Tq64MPlG0YoBvfiJmbhG6ADmK4SMYuJKXfA/1Ox42InKg6FWwZ2J27m/dU6g8wVvIM
         +kEziamaNGdo06b7FcKRnrsqpjQ623Af24d4zVJMR5NLcRopNzCjlmby5xwcPFb56xI4
         +nXV03O+BUTCyZN2kxp3KqbnX6qGqjNAXayhmSN0wLZ6WexfnYmCsehk9Oy0WeOuzjk9
         A4vwURmgKrItwSiSjrY9zLY721G95ulLGMD55okpIYw7hemAjXCFh0Zg2fbvdOVOxzqy
         dK+nYDVxcKuSKPObnEBSRgvwJWS+BEKSjB2OccskXaiKoLXDpOeIuR3qKg9+IPyBhONg
         pRHA==
X-Gm-Message-State: AOAM53191gxhJJcS+4rRK38nzaW/mBsBgr4csWVVgfbQQUjk3pOYdB1L
        kDtD3Gb9z6iOJboofHuvQnFOEQ==
X-Google-Smtp-Source: ABdhPJwVsR2cyfJyFTLxc+oAucQiwJumgusFZrJ4XQp+UursvqAWuCuaYAIp2flT20pbByydH2JfQQ==
X-Received: by 2002:a63:e205:: with SMTP id q5mr20722318pgh.404.1624844999931;
        Sun, 27 Jun 2021 18:49:59 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id t13sm12283459pfq.4.2021.06.27.18.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 18:49:59 -0700 (PDT)
Date:   Mon, 28 Jun 2021 09:49:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, james.clark@arm.com,
        andre.przywara@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Fix incorrect sample timestamp in perf
 script
Message-ID: <20210628014953.GA163942@leoy-ThinkPad-X240s>
References: <20210626032115.16742-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626032115.16742-1-yangjihong1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jihong,

On Sat, Jun 26, 2021 at 11:21:15AM +0800, Yang Jihong wrote:
> When use perf script to parse ARM SPE data, sample timestamp does not match
> the timestamp stored in the AUX buffer, arm_spe_prep_sample function set
> "samlpe->time = speq->timestamp", "speq->timestamp" is the timestamp of first
> packet in auxtrace buffer. As a result, the time of all samples in a auxtrace
> buffer uses the same timestamp.

Could you confirm if the patch set [1] can fix your issue?

Thanks,
Leo

[1] https://lore.kernel.org/patchwork/cover/1431624/
