Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A0E425B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 21:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbhJGTNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 15:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbhJGTM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 15:12:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5C8C061760
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 12:11:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p13so27495604edw.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yDO/zTxPr1lS+gOOoUIQTVtkK0X322i4YRzpBMKV29A=;
        b=a+hPoDMLtaAafgbR6RYGPPhd8mZJmIv/pagJHhvcZjY67+0kK8umh3q9Y4wVWnPl0Z
         BcqnTyHItR8bw3o5fOtoqX4fYzc0QP4TP3apMnf4nH2iUvTX1HUhDeB4rmM+C2ASHgtl
         6QJke5MTtqjuRtGVgu5T1JUHZQjtAQ31owQHGc0mBXQh3cBcp11Yp7VOZzQLW5sy5QNv
         jw9ETk2olAB5rEZWRwidTqGbR84B8mpvNBUfNj1vNI2YpiENdLyffEePsOeu6XPe0MYa
         qwqVrix+Hyriz6hhiCYn4WyHzjQPArEpRlwxXYmi/GmYcZl4rnCqN1FmQQFcJ1J3lZo9
         JfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yDO/zTxPr1lS+gOOoUIQTVtkK0X322i4YRzpBMKV29A=;
        b=y8q7MeYajdchut1BEyzYQiNM02kFWAC4UojIz4VdQmGzkY8ebYk6CrdPj5DZSL82hU
         Jl4VENqrt55B/YTnlRQRvs6KyhID+zyQ4AYmpdNQ6WDXLVs8m0isqFL7SZlWEwviRDAg
         C0nL0CbpIh3VRyQw991Yi0KtMQ3DsoWfmE11MWth/GCn/Ihes7KWN3M/ZPkaO1EzqB5+
         krh4lhQeQvfJf/jepl1RKDWP47wNYpQazszxqnbLLEZQuhsBvXzD3LTsv2uXW4ioc0DP
         /J6WoL/3a9VgbcLzr2pPI9aTbX8nDDKC4d4AIc8/sO29pSAg/Dim7dpUcxc5TbxeQJgI
         /Msg==
X-Gm-Message-State: AOAM5315zKagnhwj9G+I+RrMjcxBJ3v+rW0GgqptjFRbYCTBn8TvUmZr
        lx2Kgf67vhgecEpWqaaToA==
X-Google-Smtp-Source: ABdhPJx/jYOQGZrJGvn5Ozv9dt0D+KQV7Ty+5E94L3GWVWgqHf79ET+ac/9HqVe94ediIeO4iN4TMQ==
X-Received: by 2002:a17:906:7113:: with SMTP id x19mr7538973ejj.557.1633633862462;
        Thu, 07 Oct 2021 12:11:02 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.50])
        by smtp.gmail.com with ESMTPSA id t4sm129145edc.2.2021.10.07.12.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:11:02 -0700 (PDT)
Date:   Thu, 7 Oct 2021 22:11:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     christian.brauner@ubuntu.com, ebiederm@xmission.com,
        fweimer@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: test that /proc/*/task doesn't contain "0"
Message-ID: <YV9GRMBQJ0zNpXw8@localhost.localdomain>
References: <20210929232038.o0_ct-q8J%akpm@linux-foundation.org>
 <YV88AnVzHxPafQ9o@localhost.localdomain>
 <20211007115237.15ae4ba27b4ca4e21094852d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211007115237.15ae4ba27b4ca4e21094852d@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 11:52:37AM -0700, Andrew Morton wrote:
> On Thu, 7 Oct 2021 21:27:14 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> Could we please have a changelog :(
> 
> Why are we doing this?

This can be folded into

	procfs-do-not-list-tid-0-in-proc-pid-task.patch
