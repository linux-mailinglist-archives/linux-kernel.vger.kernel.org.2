Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5AF38FE2B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhEYJwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhEYJwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:52:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3472AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:50:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id z130so16377231wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SDwXt9P/qOLCqpXe0fydlJ08/+Ru5pzi9j/Wnx1fnCg=;
        b=MCKcRDHG5TTbrYx5UHeJ0VngImIHysm1BfiDD+Ez8oAOWCRigF5smSio74YQwuOBwM
         bUXL6445qH9ftV8/59cITe+eU9n7PiNleSbJmyWRilonLC9DwOwnJWQ2EpuAQ6hqsRvC
         2RePcrBhNoN/cqVkCN5rpBz6zGYkiVICRp45i+eYyuI2uWpltKnI/26zL791rxbpFUZ+
         wO0J72lXIWXSLQJd6G+ZqdaAJKMtq6dR18EfWA7gQdYHyimPb5MNTkDNVfwzO+AEH1E5
         igyHABPQP+j/gb5gUjYNfmFLNYgKdVrWsWDnjOlixOgqS1d1n5Gp66R8YxOnafXl55Y9
         6WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SDwXt9P/qOLCqpXe0fydlJ08/+Ru5pzi9j/Wnx1fnCg=;
        b=nWL7YQl0iqo0uiMcQkR47WVCLS5U5K9nQnJOnUvcT0eUUetxQ+DxievguBiwUKSMSh
         n8Fyp2Z7NmGOgvHZinq8eO34jXPooY5J+a+L8FcC5VDXBUHkNrlJNTzLacxSnQSKy7T2
         JdnHrs3I9XGeh4MJIc1vZC5xupXbX5OSE7rIjXZnueTEZDl17sVYJkizC9JKfYMsRoap
         YdTkXtto+6J7WhOEHjHLcZb1Pn+mvvHaV88THDV25gjzuUbx9CgOv0lV6aGeOMQcQNWv
         9PJi8PxwUX8nhho0W5xM/Y/4uyd9/sC4JHtxHNVBtdEQevbAYEx7MTpI+xIR5RnXqysf
         eA/A==
X-Gm-Message-State: AOAM532lYS6jBLAeZ4UXsStLVBJzCkQyykSwdLqo6g7mOb8jQm0I569m
        lDHb57WWsV1WYbzVMUttDavtrQ==
X-Google-Smtp-Source: ABdhPJyh7OCmnU4t946lWYMxAlSCQIkXPDed4YhuLqodCGzW/cDz8OT+JJT2kGhP3jNLdPvQquE5eQ==
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr23797621wmq.172.1621936246702;
        Tue, 25 May 2021 02:50:46 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id q5sm6722978wmc.0.2021.05.25.02.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:50:46 -0700 (PDT)
Date:   Tue, 25 May 2021 09:50:43 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 1/3] PM / EM: Fix inefficient state detection
Message-ID: <YKzIc5/j27q3XWf3@google.com>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-2-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621616064-340235-2-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 May 2021 at 17:54:22 (+0100), Vincent Donnefort wrote:
> Currently, a debug message is printed if an inefficient state is detected
> in the Energy Model. Unfortunately, it won't detect if the first state is
> inefficient or if two successive states are. Fix this behavior.

Right, and the first OPPs in the table often are the inefficient ones
(because e.g. they share the same voltage), so this definitely wants
fixing. I wonder if this wants a Fixes: tag even?

> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
