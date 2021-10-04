Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39ED442186A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 22:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhJDUcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 16:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhJDUcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:32:04 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B054C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 13:30:15 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 5so9300841iov.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 13:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hxMugFlrhkWFOyvUUoClqgASfxacPxvOevTMxO7yAo4=;
        b=ESwse+jDKIu6q5BR2jgOUg7zAxbfsr1XtHvgSUxbYc/LXkGpmEz1LvIHWbJ8O9TsNG
         vBNECy0wh4oawiUIHXGqEIxyQlPfzIgaIDE1iDvqbTek+LEs03kEAWcnFWLUfJDCoLx4
         hn3ZVR0PDOBVrwD0zI5bz3JD++x/NkBzVtChiK+3JxzjaC3bQgVuZ2l1EAh66jn8HTb5
         fa5E+v6fOG0qU+JD/2L7ZqsIGsAqxkY/ZuI92EoXox5U6poOA2F6zsaQ7bB1HSx3eL71
         t2sPHd8kf/7C+PXKfwS3Q6sV9vfyl231mnU3yD0OtbxG2NIGMRXBrlB+6VnbPHnAIah3
         UeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hxMugFlrhkWFOyvUUoClqgASfxacPxvOevTMxO7yAo4=;
        b=g9KbOPeu+WTuCkxkweYQPDtVEWkDC2Vlq392GpM//gqRdBE5jxJmoCfT0OhogpruZ4
         wzg29gl+7vUF+rWi2daY3Bd6XLXlo/WgYj4uR8ztW6MxBic0CTLTjZN9DesP7rQAC67j
         mlRfa/6mWJfVNiCo87zjlFHZtnJ2ebqkfv69agF+63lJZbqjuVFz2vlD01ZMp7fL3W6i
         o1JTG1zX8vxK+pqm59bY1K/GoEbf1aG6RioZFnwqoJexj5+jWYP5AkA7zbTFHjneF6PP
         VFCMXI1SmsDJ60pijdRU9KlLwjR9JpcSS4nDU+uJJSmbM48jjD8a6BzefckEBdZNxaVo
         pHew==
X-Gm-Message-State: AOAM530Wt15BxKuTcTnQi83WdJ/sRjyDKOeD1i8epUwI/UQAxNjc0Po0
        TXxwjK7YbZf62Etd3gaFqaYnAv8vvUNuap2La7Y=
X-Google-Smtp-Source: ABdhPJyVHL6uANaYYRdy8It3v68z5LTEyqAY14i50vAHAEOQ5vQ0id1O7tvsYvmN2Tk0fG0UX7qLIw==
X-Received: by 2002:a5e:9810:: with SMTP id s16mr11308615ioj.171.1633379414192;
        Mon, 04 Oct 2021 13:30:14 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e9sm9481130iob.52.2021.10.04.13.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 13:30:13 -0700 (PDT)
Subject: Re: [PATCH V3 6/9] io_uring: switch to kernel_worker
To:     Mike Christie <michael.christie@oracle.com>, geert@linux-m68k.org,
        vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
References: <20211004192128.381453-1-michael.christie@oracle.com>
 <20211004192128.381453-7-michael.christie@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6882df86-9dcd-26ac-af85-9b11d37ba598@kernel.dk>
Date:   Mon, 4 Oct 2021 14:30:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211004192128.381453-7-michael.christie@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 1:21 PM, Mike Christie wrote:
> Convert io_uring and io-wq to use kernel_worker.

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

