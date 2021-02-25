Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A16A324F97
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhBYL7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBYL7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:59:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD89C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 03:58:31 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w11so4957023wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 03:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b4v4cjKeEcA+KnFRIpgzItseyvgCGa+HHnY7oG/JlJA=;
        b=LyIFzSkGzvzXtJf52I3hqy59HIzRJmxiTbYJpBi/Z8eURFdAllEuGUfpgrPxpwHKj9
         b0u0TEklQTy/vVCsSgpTuK2e/rdCnYwEM/m1HAiz9ga1lZypkSsvvvWwLuthnXt4fTII
         h208TvYOtJ3N/pp0YFzrIVQslMwlUfcxvYlCZNtopUQ/pGaXK6K/m5sI3a3BAHSTXED2
         LtPyH+49dqzRPDS+2vBgNTPuGKQXODkBof52s7wxmelwoXGRCdGqMkE9Pcy9pj4So7bO
         Ht3H/kf+nFbdO5CLW2IvWeFxEYaVZ+kmLSjRiPhC4BijNIcKTSnbF88ubqRhtevZHYHQ
         vcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b4v4cjKeEcA+KnFRIpgzItseyvgCGa+HHnY7oG/JlJA=;
        b=dbz5R/PYB34oBPnBojzc1wh7AuxzV32CQ+9xSdb5yJ9AilW0CrXu85+1jG3oNKroBz
         1/sncO/wkHZg7wF7Xko3Uj68qhQjO8UrzRqSVjwLWqOoAM2MspI+78SaZxoJBoepco6G
         CfaSG9CGgsEaMrtYLxDMd16ShCWWh848yQrthPfoaNNPizN8wFME1VjnV0tzTpH58Me0
         cjpmflN+yldNqGlS+3KvEhRpuhh92HlI/bethbOTRv2tC70AdSXZ7U7FwwjoeXCulpMa
         mRG24mF1jPQoesIZgeXiXJ9AQX2aoTVWSEPakACXqX0oTu6WesDZekf/cloBNfwSGv8h
         0SeQ==
X-Gm-Message-State: AOAM530xfQfHsLgwnZFNh1hfz157ljbFSS1ffRuYSbeTxheXG87Ux/oD
        CnykxGZZRCL6pmcLxHShT4NDWw==
X-Google-Smtp-Source: ABdhPJyuL8Z7WS8/eu9fwxGol0YdYzNIvCLPx+6FvXYxYFNS2fzxTxjtDdj6m6AtLjMWgnNbR6F+zA==
X-Received: by 2002:a5d:4d85:: with SMTP id b5mr3194238wru.192.1614254310446;
        Thu, 25 Feb 2021 03:58:30 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id t23sm7580487wmn.13.2021.02.25.03.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 03:58:30 -0800 (PST)
Date:   Thu, 25 Feb 2021 11:58:27 +0000
From:   Quentin Perret <qperret@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     vincent.donnefort@arm.com, peterz@infradead.org, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH v2 1/2] sched/fair: Fix task utilization accountability
 in compute_energy()
Message-ID: <YDeQ47Kfh8s/B0cn@google.com>
References: <20210225083612.1113823-1-vincent.donnefort@arm.com>
 <20210225083612.1113823-2-vincent.donnefort@arm.com>
 <f2f5cf8e-3a0b-7192-5293-bad576e7066b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f5cf8e-3a0b-7192-5293-bad576e7066b@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 Feb 2021 at 12:45:06 (+0100), Dietmar Eggemann wrote:
> I.e. since _task_util_est is always >= task_util during wakeup, cpu_util
> must be > cpu_util_est (by more than _task_util_est - task_util).
> 
> I can see it for a CPU whose cpu_util has a fair amount of contributions
> from blocked tasks which cpu_util_est wouldn't have.

Yes I think this can manifest itself if there are tasks changing
behaviour, or on an idle CPU as its ue.enqueued will be 0 and we'll be
left with blocked util only.

Thanks,
Quentin
