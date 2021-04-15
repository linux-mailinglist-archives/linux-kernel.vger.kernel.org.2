Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F5F35FFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 04:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhDOCNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 22:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDOCN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 22:13:26 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C2EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 19:13:04 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q136so2822261qka.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 19:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=1LU0pe2FfX6MF+Ep4We7wpP6Mr3haH7XttAVTYnZ1vk=;
        b=RPaCbrdt5ZN7A+kz4qWFGsdcT+pJP6eidG8Eb4cfJGAFPNX572DD0IY3q56xfk8sTI
         ojHDfi+viUqmWOJsBn4l5kleh4E7nvLaMXtQTyoZeiblMavPstp4hqanoZlMaZ1QAVxM
         M/EzIAr25IqNSI+9PmuFIPw2RTMjYKe3F1tFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1LU0pe2FfX6MF+Ep4We7wpP6Mr3haH7XttAVTYnZ1vk=;
        b=Vv6qBhJbv1rNa6RJn36BlD+uKtzZa79g3NuTgjcfPSFQwOUT4L2q8eWenNEl6j8Icg
         kioBJ776BIeWyPvd08gx2ehyTkX3XujlXPrG88feDH14R5c3kJmqpwKUJnV+HfdP3hsY
         UkL+wbW6E/d8QbnoS3mexHqcq4iHzV4/gpAvkdZFy6hTL1zDNOAiWO2X2BDEuoAsbU7r
         WuTLLZa1wCxYLzEofHNpElHnsMRwSCRtmDN6UBysEs3QSA6YR8nStHXwd8qzIiY/LGUp
         mkW3+p/QDthrPBXYtmq44NfCV+h/0PUHweXVF0kOHRXgTYJTaz5PBeEOraficiRwbnod
         lrEA==
X-Gm-Message-State: AOAM531hwsAwk225aM9orHUnXAT+kN3nEz6kNB8ac6vjYo3I9ZL9h2C1
        Pbn1NHSZi6sQa8AHVFXx1GiYFaEsu8mzpcHx
X-Google-Smtp-Source: ABdhPJyxnCKkD2hweZ1hccVFbD0YbKxvnbjILwObjVd7AQ7OeIMmwX4NjU1pMO7QoD0INqowKC5hcQ==
X-Received: by 2002:a05:620a:24c9:: with SMTP id m9mr1308417qkn.435.1618452783677;
        Wed, 14 Apr 2021 19:13:03 -0700 (PDT)
Received: from saya.kepstin.ca (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id z6sm955260qkc.73.2021.04.14.19.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 19:13:03 -0700 (PDT)
Message-ID: <17d15837848eddd8445b206356531b9b5aae644b.camel@kepstin.ca>
Subject: Re: [PATCH v4] tools/power turbostat: Fix RAPL summary collection
 on AMD processors
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 14 Apr 2021 22:13:02 -0400
In-Reply-To: <20210330213825.77294-1-terry.bowman@amd.com>
References: <20210330213825.77294-1-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-03-30 at 21:38 +0000, Terry Bowman wrote:
> 
> +int idx_valid_amd(int idx)
> +{
> +       switch (idx) {
> +       case IDX_PKG_ENERGY:
> +               return do_rapl & MSR_PKG_ENERGY_STAT;

This isn't correct - MSR_PKG_ENERGY_STAT is the MSR offset, not a bit
mask for the do_rapl bit field.

The presence of MSR_PKG_ENERGY_STAT (along with MSR_RAPL_PWR_UNIT and
MSR_CORE_ENERGY_STAT) is indicated by the RAPL_AMD_F17H bit in do_rapl,
and can be checked with:
	do_rapl & RAPL_AMD_F17H


-- 
Calvin Walton <calvin.walton@kepstin.ca>

