Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F4E315359
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhBIQE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhBIQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:04:22 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942E4C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 08:03:41 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t29so12168167pfg.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 08:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UxqoC0fM9CbZM3H2jpi7z490wqeM9u6xTf+JuFk5kak=;
        b=QyDhmhmIdsopyJtaq2iFVQc9x2+2DviT9HMyfInBe+JRnCk71hwSNBcJyhwQDKN1Tp
         farLJU2s9h96+hw9JkbRAcMAQVRFMlk9Z3OBq+VF4cWOvLUhwR1banYx7ZUdX6xY9vAU
         eA2q66WAsSYBBQ5sqdzQVPTdmHemx2Q1LWMoiNyU8LvkqRy5/0UGCAif8s/fyu4GJvfa
         CvaYhsFz1f5c1kBaYe2MsUokDWapGBGRY0IGt5XDXhzDbEydZni746J1akOuQLYRTfmp
         TK5gHtsmprMbTV+45jYu0mYUyETbu8G8Ryk5RZ5EHoB19c7tmgYbCcDfUgaPbQK5aRv6
         mplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UxqoC0fM9CbZM3H2jpi7z490wqeM9u6xTf+JuFk5kak=;
        b=l/JMnL2B3UFjNbj0bEKzZr4f9ZC0/x3tgy+OMIOv+1JxiOFm4ilzz4ydzHJWJ5UEtC
         HULe1/oqlfVcK/y9cpBzXEG8Zu+goCSJR728iTmK+mmZxODqSqTJpulXLVVxc4kCErFb
         gwYc0UgdWYNYsVECEfs5XoEBdArCnMqNM6pO1KGPoxuWO/S4m6jD4akJRhldBHY9Hdjo
         ltL63Nt6oj43/gk4KJ5005lCGyfogFzrCXwOi37iLkNB1tN2D52J0wm52TsbPXdTEYeD
         dBAFQ0CfKE8qpsvsP1xd2mhbzYsta7D5Wba8n8AF3MNswxb2Sr5su7xMpM17Q0wc6Xcp
         h7lA==
X-Gm-Message-State: AOAM530+wb5cWsnB7+9fNx7nguGu3rxZgMWaEfYtaYb4KLcybOfKZJJx
        dX8ztKjscVKy5xifxlUHxF4=
X-Google-Smtp-Source: ABdhPJxAjj+A4O55MiRUL5BKcqPeofP65eHtzfHerSzFbQV6or1mNpzxEDdB8PpIaP3LdzvWx2DLdg==
X-Received: by 2002:a65:5c48:: with SMTP id v8mr22840259pgr.400.1612886621060;
        Tue, 09 Feb 2021 08:03:41 -0800 (PST)
Received: from google.com ([2620:15c:211:201:d107:fbfb:a7c8:913e])
        by smtp.gmail.com with ESMTPSA id w11sm22674648pge.28.2021.02.09.08.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:03:39 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 9 Feb 2021 08:03:37 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        rdunlap@infradead.org, pdaly@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: cma: Print region name on failure
Message-ID: <YCKyWeHjJmmIx5tv@google.com>
References: <20210209142414.12768-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209142414.12768-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 04:24:14PM +0200, Georgi Djakov wrote:
> From: Patrick Daly <pdaly@codeaurora.org>
> 
> Print the name of the CMA region for convenience. This is useful
> information to have when cma_alloc() fails.
> 
> Signed-off-by: Patrick Daly <pdaly@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Acked-by: Minchan Kim <minchan@kernel.org>
