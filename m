Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E32942ED5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhJOJR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhJOJR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:17:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF2EC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:15:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 5so5544091edw.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MijKcoywXZiJ/TAfeUQvoBq2vYQe9FT8lGZbL7eVuLY=;
        b=jvtwlXyyqaCw9x0aEvTBt7y6s84PRxF46I0emgA39mxfA7bFuDxXxAopNRUhpfbxLl
         EKopmJ6o07eI0CrDG+EKGfo2J7bW4/gfgRccfn6y8UVzgDvBXEJWP8t1ULDwvWWOiWPn
         JjQVEqXi8WNFBvFz8KPKogxnrYl2gpdrcb9BqUc1eUJSvXQzM0FmqYB4oUWTP4UYClec
         2hgwlFvSb6JB0F8o1djx1ixYKVVi7DJENMbE0/4zxtL1X0I8bO5S6aJPE5DPuSuPzKfs
         +aTzTos5uoct8EDjsqmXihpSpvK9OYhxTRCS+irHfdzXBkM2E9WzcyksHm0a6bVdatUU
         sXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MijKcoywXZiJ/TAfeUQvoBq2vYQe9FT8lGZbL7eVuLY=;
        b=nMqHoY9Y0Gyw8bABslSOEvBRdLEP0cXznMdiVahWfbM+xfXZfqrloz5sBVD70gXh3Y
         sDx9KRyu10N7CQQiPTx/mt46QTV6PVAc2EyhJAtcb8V7Kkx5kwO1F+bdXD16F7w85DSt
         D4fsC/+giMcJ2eCX+cpSh7p6URtVt9b9K9eW3672pTnx5ciytCkoL++kdRq4/VZx7A16
         pOk4T/guubfXJPUiH+rP8F2k4dUjiuxU8zaoPv7M3Gq1DPAEiYWP76YzbPjVDkCOL172
         PHhQzQRVK75vnnqvfLSfoi1jaw55c5DP9UqLXgI8kzF2q5tqAlAyZMuCTm/xDHjPhKTj
         TmkQ==
X-Gm-Message-State: AOAM5326uQ7DMNMzYUHrRMY9Ebfnt0TU4zM9wMWk/XIVraPD43pknvAV
        GwOg6RX6J/8yK7iA344gyR9Kr9lFdXw=
X-Google-Smtp-Source: ABdhPJxsgjWRkOd/eO86fZAyEQf5utZhJf1Qc0pJgU4Nnm6X+m9zGccqf2t6wooVtvvk4+YQPvUq1A==
X-Received: by 2002:a17:907:6e2a:: with SMTP id sd42mr2770842ejc.333.1634289317029;
        Fri, 15 Oct 2021 02:15:17 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id i19sm1205273ejo.101.2021.10.15.02.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:15:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        saurav.girepunje@gmail.com, insafonov@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     saurav.girepunje@hotmail.com
Subject: Re: [PATCH v3] staging: rtl8723bs: os_dep: simplify the return statement
Date:   Fri, 15 Oct 2021 11:15:14 +0200
Message-ID: <13289545.LovHZTAFgE@localhost.localdomain>
In-Reply-To: <YWhBQF4yUH0/r53A@Sauravs-MacBook-Air.local>
References: <YWhBQF4yUH0/r53A@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 14, 2021 4:40:00 PM CEST Saurav Girepunje wrote:
> Remove goto statement where function simply return value without doing
> any cleanup action.
> 
> Simplify the return using goto label to avoid unneeded 'if' condition
> check.
> 
> Remove the unneeded and redundant check of variable on goto.
> 
> Remove the assignment of NULL on local variable.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
> 
> ChangeLog V3:
> 
> 	-Remove goto statement where function simply return value
> 	 without doing any cleanup action.
> 	-Remove the assignment of NULL on local variable.
> 	-Replace the goto statement added after the memcpy on V2.
> 	 with return 0 statement.
> 
> ChangeLog V2:
> 
> 	-Add goto out after the memcpy for no error case return with
> 	 ret only. On V1 doing free, which was not required for no error
> 	 case.

You still don't explain why you changed v1. You had freed resources on 
success path. That was not allowed because you introduced a change in the 
logic and a huge bug. Therefore, in v2, you are not merely changing something 
that "was not required". Instead you are changing something that is not 
permitted.

Thanks,

Fabio



