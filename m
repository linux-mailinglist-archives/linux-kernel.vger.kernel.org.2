Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4F4387AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349927AbhEROUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349918AbhEROUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:20:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9255C061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:18:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k15so7098497pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2wHtbqb3GnAkd/ansGxvRdnUMlv0tAjngpS3Ut55DkQ=;
        b=tbeuPzZnBOpl63n8aH9z2+hPT0CUbUKmFMJxONu+ajzNEzkNViKKe24Mp/e0akqIGP
         wyX6ekmCjXlPVXD6ytjv97k+OBlcqnTYv/OfRf79VQ0LyktdZjjptmy3c1tJj2KDhEgR
         5enKSg4dXKDBjqWvdg6vrTrEFLMj5aej6Qc6baVPEiZCgeSuLbcy4Me6/n9B6q7M1P0A
         JPjLk3D96lhFb1mSPuVqOrCR8sBJq9z0fs3DFCwrh2Dqzv1sFNwIzvoBnVZfH55oJEvT
         ScJcZX3lqkUf5Y8w3eMcFFJmBdtFku8Gv8Jyv/TjhCP68ZldW7Zlk+rSgy16d4ZlPByT
         oQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2wHtbqb3GnAkd/ansGxvRdnUMlv0tAjngpS3Ut55DkQ=;
        b=iJUGi4TgwiYGQa/bQVFaxrivArNX8Gsw+yzjowzNj0Ae4TZbmomzpD+QZl5FnbZClP
         Q+r1g9SFSlRU9W3cTu8VhrxeBjF5Rvd4uNP/nl7eYMpc3V325GC9DOQLZ22o0691p4Bl
         2ik/UnB8LApd1+k/MuRaAzuhqWvHxZU4VTWA1PY6RKzZZFZEAdStfhoKNLQ8hQUESMud
         BiWoUefws2WyCjSjNmCioPcaZTcdWDw9GD58xLHi2otP3ph9aQPWd3uJpL0f6kdtbYHf
         rs9zFyohdXUmlTTSKFyUor658n4ghUJa7zBRA3/SbFrBGpAKsxY2fCQj9jOPhRO3sdwu
         FIEw==
X-Gm-Message-State: AOAM531kk8KL+cdSG55Lf/8tJdodvl+e7mEp+Bw+ywqSMXjFZubyh6dF
        C1GrwuVkMwdmzEdvA8VFWVWeNhDlT0Sr76JpJ2Q=
X-Google-Smtp-Source: ABdhPJzDDQ8ejjsWVSxOzgQvCZ3RWejOeyiYH4g3nog3oIPnbA6KKNUqZSrFXBSClnMw06sEf8VjNQ==
X-Received: by 2002:a63:b10:: with SMTP id 16mr5372439pgl.90.1621347527263;
        Tue, 18 May 2021 07:18:47 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.180.30])
        by smtp.gmail.com with ESMTPSA id d3sm12665925pfn.141.2021.05.18.07.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:18:46 -0700 (PDT)
Date:   Tue, 18 May 2021 22:18:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Grant <Al.Grant@arm.com>
Subject: Re: [PATCH v1 2/3] perf arm-spe: Correct sample flags for dummy event
Message-ID: <20210518141837.GE942578@leoy-ThinkPad-X240s>
References: <20210429150100.282180-1-leo.yan@linaro.org>
 <20210429150100.282180-3-leo.yan@linaro.org>
 <f4e483ae-acbb-7afa-c215-cb4244c2e820@arm.com>
 <20210512152330.GA121227@leoy-ThinkPad-X240s>
 <YKO46nX17/GjqJjV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKO46nX17/GjqJjV@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 09:54:02AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > Will follow your suggestion to respin the patch (and refine the code)
> > to remove the redundant condition checking for "opts->full_auxtrace".
> 
> Ok, so please collect his Tested-by and Reviewed-by and I'll wait for v2
> then,

Sure, will send the patches in tomorrow, sorry for some delay.

And thanks for reminding!
