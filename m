Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E04322F23
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhBWQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbhBWQzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:55:04 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB82C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:54:24 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id q9so14743280ilo.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LKXgkh3WyGABz3Z+QGWP0BdM2RFG1PxsZAMH3q+mYo4=;
        b=PcEjZGKz3vVOBDGLLRLUYz8Fumrclho6ZlNXebpV3x+Tl003Qupb3Qwohax3BBtFki
         z5cYvBkMbOG0QyvTdFL9a/Jkz66E9LdvfsPSP/90a7uNJDxLl8e9P57q8fXJKLKqgcZ8
         vof3MODI6Ed+xMt2yrwxG8aJPXkZ1p4qUCWyp+wpGUOD1voBFhPs3vpPUWbP/m5JibAe
         cMNESE2W64PESMfUMbix8UccMIcy7/6931oJbnEmidHtEsEaa5eiA7ACav2HEWdctIkR
         iXy5Ns7cmEoL8MTyx7ydvg+MqjhUCMbpnlANBqt7nxMDt/ImRqu+rcKPewM+5BHpItig
         n6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LKXgkh3WyGABz3Z+QGWP0BdM2RFG1PxsZAMH3q+mYo4=;
        b=FWWOnlhnAglBWg9csAX9HG4BzEWh1yg0cT/fLugws8/7H1ZAZnD/fp4U7/sSd4qm/m
         zSyjI7FLse7M40hlOQcpJ4+DZcgR0gjxSQgyrXbirCc1Fsg6EGhaGo0No9CQDXLdXVXW
         CgpPo80g2l/u+QsKb24DSatzhBHwJ9Z46J96hsgbPRBpOBL5Rbe3lrb87yy4ZBv0/bSx
         kyWtIIfhIJAYFK1tCNvRYCLwqxFkOYs/Zg+nk1hNi4lu3ydYwQz9JcDUWMZvibObA9kL
         Bj3QJMlUQSofeyjm+J+4VpNyqMMH4UnW+BSTISf3iYkJpUfR9tgyYhmR+yTsTvV/1QOE
         CWng==
X-Gm-Message-State: AOAM532Lxann5FA3iSeSKmuJYM1nmJK2hgwLnkyl/mII2wGoc1zXnltv
        EyDuTLoJkzrZNOz/nUB0XPJ/thD9370KC0q9
X-Google-Smtp-Source: ABdhPJxlRs+EByyAM5wGUjIYBKSTxpVoYpBGxYeAfpE34lYvP0LYv1E0VjTPLlE1WQmjuXJsGB6/yQ==
X-Received: by 2002:a05:6e02:152f:: with SMTP id i15mr20008432ilu.183.1614099263281;
        Tue, 23 Feb 2021 08:54:23 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e1sm17976971iol.31.2021.02.23.08.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 08:54:22 -0800 (PST)
Subject: Re: [PATCH] blktrace: remove debugfs file dentries from struct
 blk_trace
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mingo@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210216155247.1015870-1-gregkh@linuxfoundation.org>
 <20210222180255.1b117616@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b0caa52e-5817-5ba4-29da-1444e6d6be86@kernel.dk>
Date:   Tue, 23 Feb 2021 09:54:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222180255.1b117616@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/21 4:02 PM, Steven Rostedt wrote:
> 
> Jens,
> 
> I guess this goes through your tree.
> 
> I'm pinging you in case you did what I did, and confused this patch as one
> of Greg's stable patches (which I almost archived as such)!
> 
> No, this is an actual update from Greg, not a patch that was backported.

I did! Greg really needs an alter-ego for these kinds of patches.

-- 
Jens Axboe

