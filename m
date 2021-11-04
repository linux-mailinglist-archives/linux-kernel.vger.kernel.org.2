Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A1445267
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 12:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhKDLrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 07:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKDLrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 07:47:15 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AF8C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 04:44:37 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id v65so6518478ioe.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 04:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+xa/K8iZ5H3AOccYQXVWQN+Tt4/PRKVQipZvC6SEJMo=;
        b=S5G5jDlYdCg+ae++459nbhcVQp5WWC/qgUP4SZQLqLM+GY5UcuiNc54H0/RoRxvNXe
         y6hG3p65YdNdivQz2Z21T5OtvrYphfNpdZRKFf+wOEtlc7YPjPYtv7I+LIoDsu9yu/xP
         9WlB6F930p8csoZtf9HAHSM6k04/+2JlyBZdJy/4VXnc2LE8TMizbnvgOeb1ir0wRXs3
         ohhF/qchfe2+UGKmSGEapya64vtRyhbGGFNbilTrk7gKaYxyJXSY/F4mW8g+xaXWqGM+
         wrbh7armt8VraR6hKxRxY2CgFsEG3OOrA/YRaX3HiTgDxD0bfnP0IR0EK5TugKuTsXCZ
         6xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+xa/K8iZ5H3AOccYQXVWQN+Tt4/PRKVQipZvC6SEJMo=;
        b=w0/SgpsTjlKUEvRMbFYrdbcTisprzDETpJ+d0PrZtPaUwXnIm7c5Y1LojJ9i9tDBq4
         23hnc9sskMFCrVFgTYKlBF1WSFX4VTGdP+ITA2AMOY9drLANHoBi5tlGxPRw+SMkYv2W
         pYdjHlnSXbANVut6XG24JMDo0/QI4K0ZJ2uT2ww9PvNoc9CN5RtNaEMcJW45+It7UxlN
         Twyzr9hN2MnwMXF1Nkngn0gWVdjiJJcIefFYdkXdwPii2QIvh8sb4qHIp0kUTzfQL5tP
         /6BgB/P+Oms4hJhWvOOxFNhLR28bNJbTfAY0/N/QH/pT2zxZb3Yy0/y8zkmxhSLixLfa
         1hOg==
X-Gm-Message-State: AOAM533vFhRJkwp36n5Rr+CtAQDATB+97Axc0zWZzBI69uM6VscZZ+Js
        CfbkSxEH1Rlqx5qklu4xAC67+A==
X-Google-Smtp-Source: ABdhPJx7p2YYv77/7wwcpEx5ePCK2GPcv203PdvCaEh+RL+mwkU9eA/eT5AgNn7HskkQ8yfJ7ezySQ==
X-Received: by 2002:a5d:9751:: with SMTP id c17mr35566441ioo.61.1636026276916;
        Thu, 04 Nov 2021 04:44:36 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id v4sm2524632ilq.57.2021.11.04.04.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 04:44:36 -0700 (PDT)
Subject: Re: [syzbot] WARNING in io_poll_task_func (2)
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+804709f40ea66018e544@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiaoguang.wang@linux.alibaba.com
References: <0000000000007a0d5705cfea99b2@google.com>
 <0935df19-f813-8840-fa35-43c5558b90e7@kernel.dk>
 <CANp29Y4hi=iFti=BzZxEEPgnn74L80fr3WXDR8OVkGNqR9BOLw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <97328832-70de-92d9-bf42-c2d1c9d5a2d6@kernel.dk>
Date:   Thu, 4 Nov 2021 05:44:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANp29Y4hi=iFti=BzZxEEPgnn74L80fr3WXDR8OVkGNqR9BOLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/21 4:45 AM, Aleksandr Nogikh wrote:
> Hi Jeans,
> 
> We'll try to figure something out.
> 
> I've filed an issue to track progress on the problem.
> https://github.com/google/syzkaller/issues/2865 

Great thanks. It's annoyed me a bit in the past, but it's really
excessive this time around. Probably because that particular patch
caused more than its fair share of problems, but still shouldn't
be an issue once it's dropped from the trees.

-- 
Jens Axboe

