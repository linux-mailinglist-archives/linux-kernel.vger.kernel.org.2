Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7105D45B21B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 03:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbhKXCmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 21:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhKXCmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 21:42:03 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA92DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 18:38:54 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id m9so1353745iop.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 18:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oDR6Ez54gJXjhv8//eTFCmRhSXhku16zY+9Gc+N557I=;
        b=pFO0OBcIyttQRKgPyNeBKdG5/H1+BzVpP8ajqHo9XGcMy/+TExJ2IvMLTMEVIf8JQG
         1iCIG6ZbHTlqIM0S2uQj+xRjl4Bz9Dx/cClyMjNBMUQXhS+as5MRbFwoUhKtIZHrRliY
         1j05iZhN9rrKYzNo0kiH0AzE6Unoyd7GdEgVyRVWzS8u9rdhbUuak4J+T68/DhqmhQ4+
         jZlonKL8W/RQMuRLArezi0+qdBuQ+JSNzaqbRJb9zyNchqZVyfuWyrAMVsvdPTUWxMz8
         Pjc/iw9Ubybf0/XrjNd7ZWu1baZGErh8tmGmGK9WaRBAzCwEjrANp3w0kX8lsD5eLjf4
         VFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oDR6Ez54gJXjhv8//eTFCmRhSXhku16zY+9Gc+N557I=;
        b=U2WQFMdfi17EaoJ9EfPKGM9bU54AdU26nIU1IR9CEBid39yLNpB7R5ttCQQ6IN2TBD
         IqVRTKz6GPSAJMApsAcEYLhEyHRbJUzIXwv55HRPSBr8TRxxK1JyWQIANwRepgioigz7
         HK1blA/ofHEIo/nT1eHpUth4/mBC7MQkeEHOWqhz/q/TGUw4/7qLLWpBZ3Ax0CxvOqga
         I2hxxts+rGPk3rt4Uq2pD8/qbDg1ZOzBkBcK+yYlUCiZoUYGeY6hlyhwF18/MWu6pkvg
         0HQZKx5pcmxqNYDQ9kgj8roYjSlu/5NMs6MXZ1Nkis8cuTmOwsNWpYrZEPhZLFOZswDc
         SkBA==
X-Gm-Message-State: AOAM532ZgagG48xTSKWI09DSGiFC7NKaJJ/P8hhcXmAXWw5wb+e84LV/
        5WOYvOmxIVTxKmaNCovcG20UQw==
X-Google-Smtp-Source: ABdhPJzN+fTLrMjJnhN4qikGr7oBiW9zV0LGRBpibae1TjD5ULB6oIPyY2mpNHpa+DDbLg1S5C2Yng==
X-Received: by 2002:a05:6602:3314:: with SMTP id b20mr10316177ioz.214.1637721534138;
        Tue, 23 Nov 2021 18:38:54 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y12sm9984495ill.71.2021.11.23.18.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 18:38:53 -0800 (PST)
Subject: Re: linux-next: manual merge of the tomoyo tree with the block tree
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211124113825.2d9de813@canb.auug.org.au>
 <cbeb57ae-5a87-9959-689f-d9d73baf6ee4@kernel.dk>
 <b5d2fbb7-5bc6-f0c1-0869-1c3e7096677e@i-love.sakura.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <353a1ef2-df1e-21f1-b27d-8ff940279299@kernel.dk>
Date:   Tue, 23 Nov 2021 19:38:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b5d2fbb7-5bc6-f0c1-0869-1c3e7096677e@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/21 7:25 PM, Tetsuo Handa wrote:
> On 2021/11/24 11:06, Jens Axboe wrote:
>>
>> Why does the tomoyo tree have loop commits is the question?
>>
> 
> I'm testing patches using my tree until maintainers respond.

It's a week old, please don't put patches from an unrelated tree
into a different tree.

-- 
Jens Axboe

