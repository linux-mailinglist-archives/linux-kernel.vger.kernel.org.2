Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6014B4326D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 20:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhJRStd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 14:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhJRStb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:49:31 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A33CC061768
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 11:47:20 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b188so12559701iof.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ob0CbEwoPeJgo71AK4uZuz6MhzSfIwRl4kQrmn5LdSo=;
        b=zryvc2+iyGSLlKZd0t8mtv3dtK+YkZ6kCiMIVzLmOCw+zbbFJuxFfHrZQGVVW8Z/TW
         PV1pHcYGTrVezQlMjoAuu5kGNyrqdiYuG/GeRZcOJTVjmuCFTd6nNOeJroIWjkxAw5cs
         tz3ifwG1gL2vBK74CnzmmDPB4yueweSeWo9UNlJNnpz0HAlsCTrHwqRRIqSdzkDwYI2X
         dBVRhP7O8PO8oMRWc9iQnX913JrKtZwwuKwqFQyddPQMwlU+5371NAluDd5GA5c9mMit
         ELtH/Ijx4V4Azrr5hn/GmkqDn57YDAR7YTtu26N4uebU98kq9NzMdobGrWTUhNqKsKTg
         CpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ob0CbEwoPeJgo71AK4uZuz6MhzSfIwRl4kQrmn5LdSo=;
        b=8E/Xc9bOr3y8O89Ni22pk1E1XDiarnTwDPwvPRTHN0LavpPipdeQyIyQSKGaqGJJC/
         VnBJf1RuHGrQWwjPMlExmJ0DypMxLleuqUTTLgZ4VrPpl4UKfHLgcdM8jh0ThMMhWx24
         FAwYTEo44coNbm3rilO8Z/VmdYYK0L70Gxc0OMKivk0IYDx//eyXXqBWBaTdw5UBoUF8
         teNslGt53NPX/soLnlFcLEYxhXZk8GgoNjYYv8b2EbX5iMNK8uE4Qu1EyqNUQQmLinj+
         csSR0olXSd7Dh5qptBkTOQu7F7lSmnlKmsocuC5q5PjlaEd+VdAxsYHbtX9MBXL3Xgp7
         x3GQ==
X-Gm-Message-State: AOAM531zcAJqdQcOSskdQNCMZrt5Wa+1dw+x0ic9sxBLJWMmEEOfxa7l
        vgrMArD6DsbJzK79yNawyfsY8698XKEBbg==
X-Google-Smtp-Source: ABdhPJyDN2zfYxfknFmpN3T8LloR/QDQg7yngT5RHbjCQ8mEx+QxOBZHcTf3jfGc6fH5qUxmVu8Leg==
X-Received: by 2002:a02:cd9c:: with SMTP id l28mr1041464jap.78.1634582839074;
        Mon, 18 Oct 2021 11:47:19 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y6sm6832160iol.11.2021.10.18.11.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 11:47:18 -0700 (PDT)
Subject: Re: [PATCH] [linux-5.10.y] io_uring: fix splice_fd_in checks backport
 typo
To:     Kamal Mostafa <kamal@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211018171808.18383-1-kamal@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <056adbd3-62eb-4aca-113e-f80c27c94a3b@kernel.dk>
Date:   Mon, 18 Oct 2021 12:47:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211018171808.18383-1-kamal@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 11:18 AM, Kamal Mostafa wrote:
> The linux-5.10.y backport of commit "io_uring: add ->splice_fd_in checks"
> includes a typo: "|" where "||" should be. (The original upstream commit
> is fine.)

Oops indeed! Greg, can you queue this one up?

-- 
Jens Axboe

