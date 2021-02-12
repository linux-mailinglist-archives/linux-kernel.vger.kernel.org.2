Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D562031A6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhBLVRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhBLVRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:17:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65E4C06178A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:16:50 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nm1so319534pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=M/V9sHCfr1P7mccIZjuFtNDI0XPkeWeQkaWblX7rzrU=;
        b=Novk5M0h1oNgDUgzlJk25bkItR0UvpHNxdt0a2DVs2STYka7XfgdWsO30SmM+kLjZ4
         DleObURg+mXqHj8gp6H+/k8UVgDFNP5NqMKOnmreImU1yDjOEP4471Z43GPN+ldyofox
         iBCf5OvX30jFvI/Nt03rcVmj+YbRaMx2xlVr2GUptdNeHfVhI9Dmbjajx4A140CoM3EN
         rjwWvA9mDFj12bF7YNJo6d+hmKUfjVkkVtaPzdh2/vMxL9juIqQsWQdCr/g7oolNHkYX
         Z0I2ITemWIQqFGy/+YoeOwj9+UAl4t2vJQO81rUu0xKQtd8nY77dWM7gNO3uf8wJW+t1
         37/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=M/V9sHCfr1P7mccIZjuFtNDI0XPkeWeQkaWblX7rzrU=;
        b=NGIEKbTi3L1t8oRfGcutF4T0NbiDr8OeUMLIA5F18wenlEkdbj7iVXGEVglEUFhJTY
         Ob3PMkaXadyk4Fk87qCECYk4nXpozaiGde5dCETjTVJVDRsDRfRQ8qUeVLd2zZpJgrYG
         cVwJmq3wBzpvH9M7l1einRsdrA/m2yC+xMHyrXczd7WQLl3fYwMOoHuInKqbxFZMLhmx
         R+geDr/0hZ+ifF6o9Qd9LeMnrsSXpoc4ND7V2agzaGLawOCkigpxgzEyGZvRXfHGbwsn
         osf7wrloXDxvzqvC6MqRvNTT7oLljdSS6PCcl/WapU+WHU/hVAvouA+6pQUcsm1pXAYA
         ThMg==
X-Gm-Message-State: AOAM531kCNwVxzE1GrWAF7V6dpZ4NGemRCO9gy4ZMEqZjPqkTC//tJLC
        +57anaEahlA3h4+Fw7PXZk/T6g==
X-Google-Smtp-Source: ABdhPJwnHIL/mZk6gNgm6uW6ZGCLnfRfNCRUAEqBKwD/QJDdiAR3/bxVQy1yBlxAuMhfeWJoyxFRTg==
X-Received: by 2002:a17:90a:c686:: with SMTP id n6mr4280017pjt.82.1613164609859;
        Fri, 12 Feb 2021 13:16:49 -0800 (PST)
Received: from [2620:15c:17:3:b175:9ecb:5cdc:43e5] ([2620:15c:17:3:b175:9ecb:5cdc:43e5])
        by smtp.gmail.com with ESMTPSA id bk12sm8949655pjb.1.2021.02.12.13.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 13:16:49 -0800 (PST)
Date:   Fri, 12 Feb 2021 13:16:48 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Charan Teja Reddy <charante@codeaurora.org>
cc:     akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        vinmenon@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: compaction: update the COMPACT[STALL|FAIL] events
 properly
In-Reply-To: <1613151184-21213-1-git-send-email-charante@codeaurora.org>
Message-ID: <e4a4bd48-a8a6-2c3a-88fb-50161f23bed0@google.com>
References: <1613151184-21213-1-git-send-email-charante@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Feb 2021, Charan Teja Reddy wrote:

> By definition, COMPACT[STALL|FAIL] events needs to be counted when there
> is 'At least in one zone compaction wasn't deferred or skipped from the
> direct compaction'. And when compaction is skipped or deferred,
> COMPACT_SKIPPED will be returned but it will still go and update these
> compaction events which is wrong in the sense that COMPACT[STALL|FAIL]
> is counted without even trying the compaction.
> 
> Correct this by skipping the counting of these events when
> COMPACT_SKIPPED is returned for compaction. This indirectly also avoid
> the unnecessary try into the get_page_from_freelist() when compaction is
> not even tried.
> 
> There is a corner case where compaction is skipped but still count
> COMPACTSTALL event, which is that IRQ came and freed the page and the
> same is captured in capture_control.
> 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

Acked-by: David Rientjes <rientjes@google.com>
