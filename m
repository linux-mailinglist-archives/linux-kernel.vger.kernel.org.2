Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752DE3F5165
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 21:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhHWTlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 15:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhHWTlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:41:08 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EDAC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:40:25 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b10so11225538ioq.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G2SVrRZIMROI4YKSe8URoaTR5hujeuHBAdNdertfjAY=;
        b=jUZSALcG3mLl6AOLb1PW9RpHd2KcfwHBVgIbXUjskJnzFkLhE9BKrSkqvNfpmQa2BR
         ZwjzjfkQVesicqYFrQuMSoU4kfRqh1r0gACPUQ8Mb6aOTDXbLPAGefDSEtgLuLsQNw8b
         FbCAOZM8P7jdyq2QuUu+fJ2ZA2nNr9kX0V/7f+0u+n+Z3JMqrqi0HJ0PbshmR6ba4IP8
         in9WBcZgbZ2ZQELA6ARDJyPsYEYt2mjt7afKHtCWwDWUHqs1uT16i5F0VHvGhgzf9xdY
         V7GRWCN9rPlTzxST5KWKTa6QfEe4zYycJs1BlwrTCAGsrrRsRcz6m4jco72sy6vhXWgr
         /VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G2SVrRZIMROI4YKSe8URoaTR5hujeuHBAdNdertfjAY=;
        b=DxZcDKFjDYYCNtVqpPJoAHcRElisXD4LnvRdUOqa85F2drzuFmDNd9AdgSJQgr4zEr
         7CufiWuq1bd5t6XFm8VW2L/xx1JhaNP+oUpJGC8os8Pv3iXwGaLQnRNOx36CZyh9Y6WO
         liGKr3sUi9hHJXqNzcCQS9oCDPPr0Tqs/hOJTROJ+WGQNG3e7W2ETHPTExavvH903dZ+
         EC2CNjjP9miDzYubZWfBb7ayuObl8S3lU/ewzoPVgmOuMl0AhRbMrtGRp1925O1RYsr3
         Jxmh96bIV06w+w6NofI7mt/rcZb4gE8lwtSL9kTubBIRQ+SGVFJyPPO/udNsjF3XXS7n
         i5mg==
X-Gm-Message-State: AOAM5319tmiJ/1XIY3w0v5zU9cXUU7nwoMdGjQ18DGc2z0Ge2M9IDUq6
        KBNf4mmlHNJ8yj1vUU9/wEiYOQ==
X-Google-Smtp-Source: ABdhPJwFFXxnZV6gOaCl5BdXkE0E7H1K58ErMFvT604/1u73jAT0AGDgnDM8d8OVs2fI5djeTS9rYA==
X-Received: by 2002:a6b:6603:: with SMTP id a3mr28813047ioc.68.1629747624592;
        Mon, 23 Aug 2021 12:40:24 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id p7sm8627226iln.70.2021.08.23.12.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 12:40:24 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] open/accept directly into io_uring fixed file
 table
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
References: <cover.1629559905.git.asml.silence@gmail.com>
 <7fa72eec-9222-60eb-9ec6-e4b6efbfc5fb@kernel.dk> <YSPzab+g8ee84bX7@localhost>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <59494bda-f804-4185-dd7d-4827b14bae61@kernel.dk>
Date:   Mon, 23 Aug 2021 13:40:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YSPzab+g8ee84bX7@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 1:13 PM, Josh Triplett wrote:
> On Sat, Aug 21, 2021 at 08:18:12PM -0600, Jens Axboe wrote:
>> On 8/21/21 9:52 AM, Pavel Begunkov wrote:
>>> Add an optional feature to open/accept directly into io_uring's fixed
>>> file table bypassing the normal file table. Same behaviour if as the
>>> snippet below, but in one operation:
>>>
>>> sqe = prep_[open,accept](...);
>>> cqe = submit_and_wait(sqe);
>>> io_uring_register_files_update(uring_idx, (fd = cqe->res));
>>> close((fd = cqe->res));
>>>
>>> The idea in pretty old, and was brough up and implemented a year ago
>>> by Josh Triplett, though haven't sought the light for some reasons.
>>>
>>> The behaviour is controlled by setting sqe->file_index, where 0 implies
>>> the old behaviour. If non-zero value is specified, then it will behave
>>> as described and place the file into a fixed file slot
>>> sqe->file_index - 1. A file table should be already created, the slot
>>> should be valid and empty, otherwise the operation will fail.
>>>
>>> we can't use IOSQE_FIXED_FILE to switch between modes, because accept
>>> takes a file, and it already uses the flag with a different meaning.
>>>
>>> since RFC:
>>>  - added attribution
>>>  - updated descriptions
>>>  - rebased
>>>
>>> since v1:
>>>  - EBADF if slot is already used (Josh Triplett)
>>>  - alias index with splice_fd_in (Josh Triplett)
>>>  - fix a bound check bug
>>
>> With the prep series, this looks good to me now. Josh, what do you
>> think?
> 
> I would still like to see this using a union with the `nofile` field in
> io_open and io_accept, rather than overloading the 16-bit buf_index
> field. That would avoid truncating to 16 bits, and make less work for
> expansion to more than 16 bits of fixed file indexes.
> 
> (I'd also like that to actually use a union, rather than overloading the
> meaning of buf_index/nofile.)

Agree, and in fact there's room in the open and accept command parts, so
we can just make it a separate entry there instead of using ->buf_index.
Then just pass in the index to io_install_fixed_file() instead of having
it pull it from req->buf_index.

> I personally still feel that using non-zero to signify index-plus-one is
> both error-prone and not as future-compatible. I think we could do
> better with no additional overhead. But I think the final call on that
> interface is up to you, Jens. Do you think it'd be worth spending a flag
> bit or using a different opcode, to get a cleaner interface? If you
> don't, then I'd be fine with seeing this go in with just the io_open and
> io_accept change.

I'd be inclined to go the extra opcode route instead, as the flag only
really would make sense to requests that instantiate file descriptors.
For this particular case, we'd need 3 new opcodes for
openat/openat2/accept, which is probably a worthwhile expenditure.

Pavel, what do you think? Switch to using a different opcode for the new
requests, and just grab some space in io_open and io_accept for the fd
and pass it in to install.

I do think that'd end up being less hackish and easier to grok for a
user.

-- 
Jens Axboe

