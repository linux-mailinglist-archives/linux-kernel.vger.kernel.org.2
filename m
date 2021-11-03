Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C9E443B05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 02:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhKCBap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 21:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhKCBao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 21:30:44 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40B5C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 18:28:08 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id y17so936201ilb.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 18:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6py8bgQ0B5/+fIXWiAKE7dARK0paBlJ7XzGDJcrhlUo=;
        b=fY4Xy+5HpEK8ZhIkUmNH1j3a9zqOyiBHtuJicBDonOsEEWvYTzx9H5pDPgOWuIZFPR
         gqYcIlgwXR27OtzPc+K6hZMh8BxvcAmq2TC9oMlEXlzeFnfuyroynIjynj844KdajEzr
         aj7umF/qQgApkedlFSqpjrB8YtmYWXJMn0TZryPNtobrhoKLPZbstgJWO/WT2obWdP6+
         xGeASjXcTPUIMfM3qftKOY5NgzVzS+2dMQtAEEOYwog/HU4iF84L6ggDijD7fR4gCH/N
         wLbIvSaoVm7hDUYbkSJMPmopfK02pXiCoJliqU6efpVekD43pTkO9y07oo7CZxfykj3n
         RqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6py8bgQ0B5/+fIXWiAKE7dARK0paBlJ7XzGDJcrhlUo=;
        b=EwSi9B0fAHUA61qDIUH/wBLfQ6VBTuf614FckmgAhAOzma3kM3g4+G8Rj+WwdquTz0
         p30znIhXTlZjD+JGS/QLarQjCz2kfaqJAwqwvMx13Lj5pD30sx4cJCd4levr1dawOuiu
         QuS6f4x7yzOQ2Nu00QIc0tvpPTFsXPyykIa1dYn8971SP845nGORhiMEm3DH3zsy9N91
         AlCEZ2vngGmeXoPwDBZYMcAzlBxXU1G/sUIbp/4Iz7oKeGEmT/+w8VdKmtiQwI2KcutH
         H9R3u+de1/mpnvE4+zKZeuccYO97wJnCJC7qLkXIsvhcMZ5UKCzTrwioe9sHmT5Stckv
         flXw==
X-Gm-Message-State: AOAM533QV8U2xmBHphL6QRU7gHxhqi371Kp5wcw+S5m7z2oUkHOYHPxK
        cZG8rFa3eIvK0/SQ8ckz/o2P19MVu2xMvg==
X-Google-Smtp-Source: ABdhPJwO1JGTdFIdOfS6rJRB6NOgCNJYxGHsGlwnV1pIOoBRAmgNDLSmAlVORwzRNUcJ3aKtd2J9Zw==
X-Received: by 2002:a05:6e02:190b:: with SMTP id w11mr2361219ilu.211.1635902887266;
        Tue, 02 Nov 2021 18:28:07 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k11sm446896ilv.66.2021.11.02.18.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 18:28:06 -0700 (PDT)
Subject: Re: [PATCH 06/13] nvdimm/blk: avoid calling del_gendisk() on early
 failures
To:     Dan Williams <dan.j.williams@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jim Paris <jim@jtan.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, senozhatsky@chromium.org,
        Richard Weinberger <richard@nod.at>, miquel.raynal@bootlin.com,
        vigneshr@ti.com, Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-mtd@lists.infradead.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-7-mcgrof@kernel.org>
 <CAPcyv4j+xLT=5RUodHWgnPjNq6t5OcmX1oM2zK2ML0U+OS_16Q@mail.gmail.com>
 <YYHTejXKvsGoDlOa@bombadil.infradead.org>
 <CAPcyv4h1dqBm71OQ_A5Qv4agT3PhV7uoojmSB1pEpS-CXaWb5w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <51f86768-04ca-bc7d-c17c-3d0357d84271@kernel.dk>
Date:   Tue, 2 Nov 2021 19:28:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h1dqBm71OQ_A5Qv4agT3PhV7uoojmSB1pEpS-CXaWb5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/21 6:49 PM, Dan Williams wrote:
> On Tue, Nov 2, 2021 at 5:10 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> On Fri, Oct 15, 2021 at 05:13:48PM -0700, Dan Williams wrote:
>>> On Fri, Oct 15, 2021 at 4:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>>>
>>>> If nd_integrity_init() fails we'd get del_gendisk() called,
>>>> but that's not correct as we should only call that if we're
>>>> done with device_add_disk(). Fix this by providing unwinding
>>>> prior to the devm call being registered and moving the devm
>>>> registration to the very end.
>>>>
>>>> This should fix calling del_gendisk() if nd_integrity_init()
>>>> fails. I only spotted this issue through code inspection. It
>>>> does not fix any real world bug.
>>>>
>>>
>>> Just fyi, I'm preparing patches to delete this driver completely as it
>>> is unused by any shipping platform. I hope to get that removal into
>>> v5.16.
>>
>> Curious if are you going to nuking it on v5.16? Otherwise it would stand
>> in the way of the last few patches to add __must_check for the final
>> add_disk() error handling changes.
> 
> True, I don't think I can get it nuked in time, so you can add my
> Reviewed-by for this one.

Luis, I lost track of the nv* patches from this discussion. If you want
them in 5.16 and they are reviewed, please do resend and I'll pick them
up for the middle-of-merge-window push.

-- 
Jens Axboe

