Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0255635F068
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbhDNJFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhDNJFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:05:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B362C061574;
        Wed, 14 Apr 2021 02:05:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r12so30284362ejr.5;
        Wed, 14 Apr 2021 02:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PgIqpwqLBwx03sZU/M1HebUDJK3qyfZFbuDRvP4Asq8=;
        b=Mz4DQsZ5rnRJguvhv9ECKcSyh1tUic1WgXLUBeEEVOIC2jUB8RhS3SKap/YpsNyf0u
         SVqrNJmHyJB7ckrW+IGu3Z/nnz8iesO0191oW+XUXi0Tba8y0BtSOEJ8hjEGPZKSip83
         EbN6QyLLNpKdwzBohMh3/AQp8Cyxv5yCwSeDO/o2f4nHNWWtPtIJYBNHJvfV/PGsf0N4
         0645Jm3cf9XudaCoOZsN6bTEdV3CmkMF0sbc4WFzMMXwnReHPaIMp8Wi+mFeLTqYPNQ5
         Ut8FRh4T4T9rwX+qn0ou54kcIR/jdQuwHEKXYQskYB5aDbHFfLsPf53ixNAGg0yArg46
         SM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PgIqpwqLBwx03sZU/M1HebUDJK3qyfZFbuDRvP4Asq8=;
        b=lagTfSKp5dgU74gMU0eeCa0mveoTGOnjCG8W37YTqc9K32AC4GioM0a7NUEjPM0KtZ
         iTl/OUvmggcrkAowrdbzMkcxAU4csd1/nWxznjtJLbHLa3iM9LMcOWaT5FRv6+JfuLFm
         rtlzVnJ/HyUMGufcWbTk6BC2gmt7E7RjTxKct2f8Q5kzgomJQsfk9SYhR+YQXqWww+uy
         KP4w8zAuyWZDdG+RAH9VoUiRDPEblZJytgPgUFbFlN+td1zDlFQ6ORwGEq1jBywm3vfk
         iTbVDZRRy3uJKiAHuAz+aPi6WVHI2ZqlCggiqmQvJP1yO7j43TJdThiUho2e7UMb/f6C
         1gPw==
X-Gm-Message-State: AOAM530rkxz673gtCUl248+ENnoLB3ag11tXh7C+5l2KgcF0bgG/nkps
        R1U0FiV9RV82r2yvcBpVSeI=
X-Google-Smtp-Source: ABdhPJy8Gz6g4X+DKOTBByDRkyIdRUE6S00x9p+w1Fn2myDmt8CETDqlSPLrSx4ABk1BLGhbOmObuw==
X-Received: by 2002:a17:906:3c45:: with SMTP id i5mr10618233ejg.368.1618391117850;
        Wed, 14 Apr 2021 02:05:17 -0700 (PDT)
Received: from ubuntu-laptop (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.googlemail.com with ESMTPSA id v5sm11698655edx.87.2021.04.14.02.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 02:05:17 -0700 (PDT)
Message-ID: <10a2094dc66b001658c459471be146b8395cf658.camel@gmail.com>
Subject: Re: [PATCH] mmc: add quirk to disable eMMC cache for Micron eMMC
 v5.0 cards
From:   Bean Huo <huobean@gmail.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Bean Huo <beanhuo@micron.com>
Cc:     linux-kernel@vger.kernel.org,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Date:   Wed, 14 Apr 2021 11:05:16 +0200
In-Reply-To: <20210408175951.22450-1-scott.branden@broadcom.com>
References: <20210408175951.22450-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-04-08 at 10:59 -0700, Scott Branden wrote:
> From: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
> 
> 
> 
> In certain rare combination of operations, Micron eMMC v5.0 cards
> 
> may experience data errors if internal cache is enabled.
> 
> This may lead to eMMC related data errors.
> 
> Introduce a quirk to disable cache on these eMMC cards.

Hi, Scott
Give me some time, let check and confirm this interanlly.

thanks,
Bean

