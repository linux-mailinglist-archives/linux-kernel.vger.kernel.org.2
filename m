Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92F132EF68
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhCEPy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCEPyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:54:01 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A71C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 07:54:01 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id f10so2414014ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pa+8neL6qSANAIiMx7PXvJHjUeR7PaH8wLreJl5B1T8=;
        b=u0q+bi6FE1FMODIJ9OTd0TkOqyoJx42mCm5fQrVuNgcIBJgMzIHpXK0VHjAXqUv7B+
         gzdTkWGyNYlHs65QBkfu1WhxHj/PwO88EJiU4gpgRpQFb9OTFBYnctd5WWltmeHLs8H0
         5k0M5GhXktMimoc5L7UZluJQMLdm11sDi1v/uQhXPZz1uEVrr/Z546MxC+sKqnmDwxnG
         d1yhlP/ZWxR1BqT5j+LgfSvIJ6w7poAVc3jdhFAy/dXP0Rbxt6mwIj9OdYU0URUicVqx
         /ICGVIrH8fDoV8jkAR5bD6/cjhO06sQ+vNJ8r48/+QFVOyLioMg0E7YW7lGGRuwHLinL
         oHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pa+8neL6qSANAIiMx7PXvJHjUeR7PaH8wLreJl5B1T8=;
        b=DCfR6XsqyvwlROTb3flnIX0Ly9tqWKaQOFAAGUh0PwQgCq/lqAS4/4n8wSJvtPwjn0
         PpJzMBIHAPirE/DX4wv10neeVIYYKt/DLvittiDxX1atxbq146j4NUrZONJk/ky9Y3/1
         NoN0nLV5hyATazfEuFbwhf8gjSP+X7Uwpmoyh4WYCfhq9/nZyJo1Qx5sSfNx0j0sTzHV
         DprdBXmxQqds+/PpoOPrlh4vI5X+nQ6NKlYCHSWThLD0pm99xhCWvzoVw9EpNsJGklwX
         xbQd9+jvigd9I8D5ugfP2WB6gTXC+ZerDOhGZQjW6bHCRVcI7JJhaVZaFxxkQrLwdh5b
         2JbQ==
X-Gm-Message-State: AOAM530VXd0p50lCcSi1Z+vWNcC58D0Guthp6tt6k6iHWEo4z7jn16nz
        8JFmYPAQQMyVoL5TLAK/USsgXQ==
X-Google-Smtp-Source: ABdhPJwdLtwER3yvQibUxk/mMBxwrMuhzLUxS+UaM7Z59Ec3DDW95Oq7+hzBKsi/AqcJIuedR2BSgg==
X-Received: by 2002:a05:6e02:194a:: with SMTP id x10mr9564009ilu.165.1614959640590;
        Fri, 05 Mar 2021 07:54:00 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w2sm1462150ioa.46.2021.03.05.07.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 07:54:00 -0800 (PST)
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Wagner <dwagner@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210305105239.377577b5@canb.auug.org.au>
 <726a90e9-7139-8d0c-6e05-fcf8c15ac6ca@kernel.dk>
 <20210305074629.GB17414@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0472d90b-2286-b135-e2bf-11461768dc36@kernel.dk>
Date:   Fri, 5 Mar 2021 08:53:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210305074629.GB17414@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/21 12:46 AM, Christoph Hellwig wrote:
> On Thu, Mar 04, 2021 at 05:26:42PM -0700, Jens Axboe wrote:
>> Christoph, since there's multiple commits with issues, mind resending
>> a fixed branch? Then I'll drop the one I pulled today.
> 
> I've fixed the commit id and dropped the patch without the author
> signoff, but your branch still has the current patches.

Killed it this morning, please resend it. Plan on shipping to Linus
today so we ensure we hit -rc2.

-- 
Jens Axboe

