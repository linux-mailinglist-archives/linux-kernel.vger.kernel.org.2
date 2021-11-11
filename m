Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78F544D33E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhKKIf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhKKIfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:35:53 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFA5C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:33:04 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n85so4984369pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cQVAJBxtLDcdT8czp21oJV0GtvRbSqf0TXdQFh4Bfjc=;
        b=BVsJ/aPJVT/YOg+ijVVxBW9o3WUEdwF1DILcpB9B4slESN0DvnXBXiaML6DMqgoptf
         dfMm/cPxjyMqHpICGxJ5q2PrN+6q6er4o+oIVJW/BhM+hVvcmdSpv3tgsvkLXSoRoKRe
         7tfSEcp4KsmJipC3wAxPFKF9cNUSpG6ot1yoJfvrGXB4fd5T9NgQ1qlSbprgHLqyajCl
         V1MG7kVYCyR2+yFlA/WpnUdBYi/8H1cJlm5IboB8/zaZqt4AzCde5fQRjDhg2ipAgIP8
         x4Z2krjhPAbkPru/qfzazMt11mXw/tsh53YzIjLDQPN2nrnsBibZ07rYTIzjDNmy8fKn
         fzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cQVAJBxtLDcdT8czp21oJV0GtvRbSqf0TXdQFh4Bfjc=;
        b=5WnqBWzEVyue7RNfTbFCFUqdXmd6e/zTSUREFVofKWFHafOWe5lRd+91iFjboPDNWM
         ju6KXAv4xG68PZ1g4ZbdBMic72i89abK8eE4QvspIfwMLLLGXpii4yKRwKBVaMPulpco
         MakDpQtaQG5IJwLJ/TwlkyXBLyqY73vNjCc8/OfGTH3tx8ow7roso0aqmTHWUOf+Ra89
         0vlXRoDQcUDzkJUmuqb6rm8tr89nDwwc9DFOR4jlepBnS1mapovBb9pJF/8ece16ghni
         MLkK94ZuPfahxS+Vbb4UcssHTlO3zCfZOK0Zie/VP6ZMckzJJSWofN0QmIXw2BburLmH
         ySyA==
X-Gm-Message-State: AOAM532BrFVBTlS9+UcVda6NR0ck4AjpZhes7upJyJmaQGk0XOfKpYJz
        Sqz9Tk84mnnzVSbZTRSEBO/Fxg==
X-Google-Smtp-Source: ABdhPJwtCjs2MHlVJVkOEfpWgHSlApfVNOWf6hcKqZQBdBMO3Bq2IFwekq5Jiap3x9+Q2nsp/AqXfw==
X-Received: by 2002:aa7:91c5:0:b0:49f:a400:9771 with SMTP id z5-20020aa791c5000000b0049fa4009771mr5099461pfa.79.1636619583898;
        Thu, 11 Nov 2021 00:33:03 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id 7sm1649208pgk.55.2021.11.11.00.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 00:33:03 -0800 (PST)
Date:   Thu, 11 Nov 2021 16:32:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] perf arm-spe: Snapshot mode test
Message-ID: <20211111083257.GB106401@leoy-ThinkPad-X240s>
References: <20211109163009.92072-1-german.gomez@arm.com>
 <20211109163009.92072-4-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109163009.92072-4-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 04:30:09PM +0000, German Gomez wrote:
> Shell script test_arm_spe.sh has been added to test the recording of SPE
> tracing events in snapshot mode.
> 
> Signed-off-by: German Gomez <german.gomez@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
