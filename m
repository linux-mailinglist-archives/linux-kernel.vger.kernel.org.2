Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD83EB284
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbhHMIVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbhHMIVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:21:17 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ACDC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 01:20:50 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id b207so267350qkg.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version:date
         :message-id;
        bh=lpPhDFXTTOWSRqM8GY9dqbn4OK6iDyVVR+GdjeUtx6M=;
        b=bmfuxoUnmLEIvDoLzidonx7arflLeMhD3SCm9k+ASybb1uqMsH5pZiT1BCTtUxBvEH
         gVxAHMshRN3L9ad/fY+g+/Q5/jAoeL7OfloUf9S/pEGyr72zLpYCFxpuwsR7SFCYOqEj
         jwwXSQ5kFJ1IBoA6CG+2HNj2SDDpwdXkJ3hlfxvpNdfZRhKoryZJi1SYiIAUgXkY7y6t
         XStjlF1amMrjTgz3IFn0Wt3mHyCWcy0VClGk9ivjEx4RmY1z5Gf2gHfx7dYMO6+9RoU3
         dHePEhTSul18td13n72UKiH6d7+bPcxF1t7zRWGe5nsXq3eASmuqtLTEopnqTClq8XbG
         gewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=lpPhDFXTTOWSRqM8GY9dqbn4OK6iDyVVR+GdjeUtx6M=;
        b=TYSa8kcbfmyvFNYN8Oyh9Ljt2W2Wh8sC/ONOLwK4Ajtpg+FTP3Fh/cXn4GMscsbysQ
         MRQv8PxD/YqnYcu9vWYCb8flifPnQq72g5uS8bouknfKUoPetlinbvjGSftkq1uPa/68
         DVk9i5xDjXU2OTkn2vxowcIZMEULSlOAKRsXiM1rgVmSOW/2n9B+kwLZnIS6dq9/IPpq
         50yRaHsLXJpuhzMpbd+yJJD7NhnqJzg/kd46+OEePrUOoHlVSW6H+OtPHFwhU8Z8MsiF
         +lrgzoR3zo7wqQcBJK6wtcLOfopwOMj9+/TOgKQPuHtSPEqYydzfosuuB1Xo4YQcThuc
         TAJg==
X-Gm-Message-State: AOAM5323DhRGfd6M9xqVQxJmVUz2qR/XhNfoSTScGWzlMD0DEBm+VJO/
        f2dg5B6/f1+hmHfG6KC/oDszeg==
X-Google-Smtp-Source: ABdhPJz7UW1eVXaMOX8vBR4lPwaDI1wZ6oU5RDUOP9ao8fbddnhAXFkn9OtDF5rKe+bbSnGmmtkgCQ==
X-Received: by 2002:a05:620a:3d9:: with SMTP id r25mr971208qkm.76.1628842849779;
        Fri, 13 Aug 2021 01:20:49 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id b1sm485659qtq.12.2021.08.13.01.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:20:49 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     SeongJae Park <sj38.park@gmail.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] mm/damon/Kconfig: Hide PAGE_IDLE_FLAG from users
In-reply-to: <20210813081238.34705-1-sj38.park@gmail.com>
References: <20210813081238.34705-1-sj38.park@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 13 Aug 2021 04:20:48 -0400
Message-ID: <307031.1628842848@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 08:12:38 -0000, SeongJae Park said:
> From: SeongJae Park <sjpark@amazon.de>
>
> Commit 2a058a1a9914 ("mm/idle_page_tracking: make PG_idle reusable") of
> linux-mm[1] makes CONFIG_PAGE_IDLE_FLAG option to be presented to the
> user.  However, the option is hard to be understood by users.  Also, it
> is not intended to be set by users but other kernel subsystems like
> DAMON or IDLE_PAGE_TRACKING.  To avoid confusions, this commit removes
> the prompt so that the option is not presented to the user.
>
> [1] https://github.com/hnaz/linux-mm/commit/2a058a1a9914
>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Acked-By: Valdis Kletnieks <valdis.kletnieks@vt.edu>
