Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA0322F22
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhBWQzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhBWQzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:55:14 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B4EC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:54:34 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id 74so2341732iob.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pbT6n+Cs8DvJhjtVRgCmgAyw2SwurC0A19vm/mcxTXs=;
        b=0BywCyjPKgbYOCAL+E4oS+FiNd2Hb9hogrqEqxrgVzm5JxPXbTjjP/KwbIO0NyQSi3
         bnDSFeIaALNY/yhR3csXEaL0VcARSVFYUh657NpmrKUQjKG8wza32RvREyDgROeqsBJo
         5SmQo/jRz+LSh3MsclxcZ+1nWgmQpjDW6+rU5f8gBewxqIUiBjoTlPHOALnnVqtgH6hQ
         oomeTM/BJKLgxZi5Z9SEnFrBDoe8kT4SQsXDqyX0UzP3wKirD46qQsMCiPvzc5zyqj2o
         xtzLM2CjPmWAhhOw4KKfdLpX3Jx+9qs2y5b0CYlyLnVgjahuSXzEmTVwIlNNdnflBSH5
         H2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pbT6n+Cs8DvJhjtVRgCmgAyw2SwurC0A19vm/mcxTXs=;
        b=NMC8cQueb4oujgEw730SL1D0FlAPIysE6Hrtq5Tn6TPcTKNTAIA6KCA01EzFuPzVsf
         KOfb0LkzdXa0QsLJeB9W0EHkNqpdilVfSsS609F8Ytttn1u520LiyNgWJolR1TuVweKP
         qXriAKNlqTgSYl4Ngvo7YIqNHPHjOUYqZVa0BypXdoST5z1jZnpWVh31O/kqkai3yBno
         oieXMS0hbGgABCU+8VvSx/gak6wKSzwkyLh4jvwLdkGw4Op5uBTC8or91Eu/crWPpv5J
         hex4kwudBgyniLD0SUFiDCG0p9fmnPeYI5zY0fqC8WxU0zVlkt6HsBS9mY6z9ANpuA81
         SI5Q==
X-Gm-Message-State: AOAM530yOPr1Sj340OUvt9jqTKeF4/zvS1k/yUbIPnVQGkx27TJciL/6
        Wp49wZwJcMAjzDnWFvXSyGjbjKK8CwMjMzRi
X-Google-Smtp-Source: ABdhPJywb0iRBLlpthFDinP6/WvOUXEm+Pi6TulrLjWAPzdeOhx5yNT21EsQqp0T+7vf0z4WTUcp9w==
X-Received: by 2002:a02:3b29:: with SMTP id c41mr28187000jaa.4.1614099273754;
        Tue, 23 Feb 2021 08:54:33 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r21sm17984292ioa.24.2021.02.23.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 08:54:33 -0800 (PST)
Subject: Re: [PATCH] blktrace: remove debugfs file dentries from struct
 blk_trace
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210216155247.1015870-1-gregkh@linuxfoundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea239ce4-9a7d-fe6a-d41a-8af8f85e3fd5@kernel.dk>
Date:   Tue, 23 Feb 2021 09:54:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210216155247.1015870-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/21 8:52 AM, Greg Kroah-Hartman wrote:
> These debugfs dentries do not need to be saved for anything as the whole
> directory and everything in it is properly cleaned up when the parent
> directory is removed.  So remove them from struct blk_trace and don't
> save them when created as it's not necessary.

Applied, thanks.

-- 
Jens Axboe

