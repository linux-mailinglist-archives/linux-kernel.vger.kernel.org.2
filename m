Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE60B30AFB2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhBASoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhBASoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:44:37 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3DFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:43:57 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b17so10511399plz.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PlNBxyGKqX8rTM2Nlq0u1yNj1djA6ZOFZTkUZoytNjs=;
        b=QREHAf9bNTRvpxtgMZRmhnoM7P6JXcSJGy1pcjXJAKa+fp/F0ZOe1WCZhRF5Y0evjx
         oHbpoDpmNUyAViOTzPc7HuvKseKotQ4oEcpbXyJEr3+QMHgVqgnBSn1HwYwC2wbbyCvD
         OlYvTeMquNE0ijxO/2GZ4/OacMaCoieBxqrKlX3UEjJTh6UMHp1vgJJ5D0PPmjhZfQ/w
         POWk3ZdGCWw2AYjp2v58a99oIYfZvgVf/6fHmXx5wxg6CsLkqAec067ZmYZDCIiqrcWo
         Aa+v9CU2fwugTuteccp14nFxdPKraNhCagMy0TnZCKYteB6zlkl3wgtH4VoPF/euYphU
         SQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PlNBxyGKqX8rTM2Nlq0u1yNj1djA6ZOFZTkUZoytNjs=;
        b=pIuWUplKURZiaJfAqeMF8a6OUWlpMA5lMoYDGvbJdjd/Md2VFU3TKmAU6Fy3rP+iKh
         NJy8cm7QnfQTYTYPN3IDYRLxrnv059oqQihPgiCWQPKuCp4tSyOk1s1QgYOepEy6uTkX
         r5252OZHybcfRQvsFgXp4UsV316Wbr0avv+SFlSff1v48M0rfmCgHpzjRskZ635LHUoT
         5n0eU0dykQan3CFX4oU/rfN1ws/jm+m5khSdmo/DWFUYa2sX+I55lSVlQKzGlJUSvm4c
         geQp5qkQtIfRM0mcAFk9UUTmv3bCcZO/PsR+8iMJ5e9JxsyB4Iewicl/JynAIRG8kOuk
         sOSw==
X-Gm-Message-State: AOAM532LNG4WfQurcbyzxbJu429hn3Vbtb7oz/aoBm8cX1H+ufqPCHje
        XnAZBNpZN3bnZSXkziE6VEG9ZlniQ5k=
X-Google-Smtp-Source: ABdhPJz1TyrNkqlPnmv8BbCuwBEvggzs5mlSYRBRBLn1ZMYBh1z3OpXg9PdaPI8nF7dLMqEbq/2rlA==
X-Received: by 2002:a17:902:a401:b029:dc:3e1d:234a with SMTP id p1-20020a170902a401b02900dc3e1d234amr18798296plq.48.1612205036799;
        Mon, 01 Feb 2021 10:43:56 -0800 (PST)
Received: from google.com ([2620:15c:211:201:540a:d3ca:9e74:48ac])
        by smtp.gmail.com with ESMTPSA id y75sm18543200pfg.119.2021.02.01.10.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:43:55 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 1 Feb 2021 10:43:52 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_io: Use pr_alert_ratelimited for swap read/write
 errors
Message-ID: <YBhL6LkWAAV0QEZL@google.com>
References: <20210201142055.29068-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201142055.29068-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 04:20:55PM +0200, Georgi Djakov wrote:
> If there are errors during swap read or write, they can easily fill
> the log buffer and remove any previous messages that might be useful
> for debugging, especially on systems that rely for logging only on
> the kernel ring-buffer.
> 
> For example, on a systems using zram as swap, we are more likely to
> see any page allocation errors preceding the swap write errors if the
> alerts are ratelimited.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Acked-by: Minchan Kim <minchan@kernel.org>
