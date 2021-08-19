Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0853F1D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbhHSPzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbhHSPzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:55:35 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049AFC061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:54:59 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id n1-20020a9d1e810000b0290514da4485e4so9310165otn.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C8GgLD2AWU2t7GSbLiX658zk46KtoTZ/x17u8BwJCW8=;
        b=kJ+Zc6q4hESs1rlxArXMdVZcJZZ4sGxrmkbGiLh4s+XF6edKCJvIC4YrLzXuozGCJS
         VCGtk2hQOl2BPhDM5JaAm5o9zl7guecdn5n1VJ9I9d5+3XMuAQOWHHag93/IVb+tQOX0
         6oGw9CZHgrkVIwx51avoYThAc/nWAYyJNIwoJzJttLdHnliDZjW9ObNnHK3M6MnJuvqq
         /ubI8/SuulagQBeUd2G+Qv+tU/wfxiiXeAHbzH1F6lvtmTW46KDD4qG1fb1jni2/igCA
         qqG8DhwrLQv/AWGSv2bkSy1e/HRC6udZj1qGTZ48O8DBz5sYiJlDlQEsVf0aIdE3D3FT
         naWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C8GgLD2AWU2t7GSbLiX658zk46KtoTZ/x17u8BwJCW8=;
        b=j0TFSRfHo3ju8GLhCLS7JiPW3wFFjPOBJr48JdP0F/SBbrQLu5jD1YwVTXFXW6Ll9C
         KkOeRs+C6wMNWYTSpXGatCtRhoGffeq/ZABHLK9Cxk/Nzl+Z1E/XGVJtreVBBvgrEBFh
         Dmx7vUOCHjB6cJmLx9Y4LUlD9knx+Szi9xQ5w941RzDc/PfefGP8Z929ho9yygP96oNx
         Esd/L4UeV1UpyyJeGMJJYs0FDcAOZ5AnLLcZOJGyJRAAo+rzPgUf+ZIvWkfOaS9E/uAF
         qXPMv5q2K7FDKEky99NQakq/22+S9tiMACDIxYQg/dVkIO2v77ou456mLJxU0n8RNC6F
         Eo+g==
X-Gm-Message-State: AOAM533wkaenWpfcMiecm7mGCPc0NTwLG/BeoylWaktHAv7ZkOOw2mcV
        8d5k/jrhPsdGTvV/kjLd0h8OIA==
X-Google-Smtp-Source: ABdhPJxhDspJTH8XJzNvW0iH6VGxhAJXd6iAliUoB3do8NpMAjL1zVBPm1jhLn9i3J5+cGKbn/V8aA==
X-Received: by 2002:a05:6830:4018:: with SMTP id h24mr12343159ots.161.1629388498365;
        Thu, 19 Aug 2021 08:54:58 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d6sm679867oiw.0.2021.08.19.08.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 08:54:58 -0700 (PDT)
Subject: Re: [PATCH 1/1] io_uring: Add register support to other PAGE_SIZE
To:     wangyangbo <wangyangbo@uniontech.com>
Cc:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiehuanjun@uniontech.com
References: <24d10cda-445e-10f3-d249-dac254e199e0@kernel.dk>
 <20210819055657.27327-1-wangyangbo@uniontech.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f0be35b2-4ecb-1ce6-203c-cec0fb9407b1@kernel.dk>
Date:   Thu, 19 Aug 2021 09:54:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210819055657.27327-1-wangyangbo@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/21 11:56 PM, wangyangbo wrote:
> Now allocated rsrc table uses PAGE_SIZE as the size of 2nd-level, and
> accessing this table relies on each level index from fixed TABLE_SHIFT
> (12 - 3) in 4k page case. In order to correctly work in non-4k page,
> define TABLE_SHIFT as non-fixed (PAGE_SHIFT - shift of data) for
> 2nd-level table entry number.

That's a lot better! Thanks, applied for 5.15.

-- 
Jens Axboe

