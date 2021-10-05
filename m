Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D80422DDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhJEQZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhJEQZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:25:07 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71430C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 09:23:16 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q205so24950445iod.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M0Efx4uhwfEZ38PmTZibKc9Nb9ZIpo8xruB3JZpP6uY=;
        b=ngv9K44X7yg3xjCLFbT/JX4x2Urt8rVeiKPi8W3zQW+9ttlooQ0a6+fvDpFA7JygAl
         syiSYblYBf6k2hGFF1yUh3muW7BKpoxCAc4ZEv+VR/ljkzHpSTlLr8JDF1L8CEFe05Y0
         r/UWVhUE1pMDv4VgAxh0kuqy8mxRaakm6ZA/PQJ2bmZN6r0kI/7/kIxNMAMDyV9VVnvd
         TGpdytgPyFxs0wcTyH0pxe1AHdCUJdskUIbGKro70Pvfa+1hkMh+Vk+yrw0IssXti+GA
         rrsnY7oDDvQuQVGzzOlOE0jKXad0XZnN2XDL1nXj1tbFbMYvW+WzVsPuPxRbiuNLg1bS
         paZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M0Efx4uhwfEZ38PmTZibKc9Nb9ZIpo8xruB3JZpP6uY=;
        b=B4YsJ7OVIYzdTnVotdgLtGfoYdVeB9NR0rRuqlcp/+IG/1Tqa7Ll+y0iBKO2CMwyXN
         YYcgZroRfqeCmGqzbuxjzNG/PpxPPl55oofjQybERlhT2y/bxDxQwvhm2DsjOdSgxcTT
         AtwlwB7V3IYaO8F9ykzImc6CVt8I4FeqrFItvBciUE2tFNQYx6qlguK3sXPSy27sGN92
         uv49fo1U6RxojsdYvboFks+YRIXuB7QFWV0hYg5iz39VS8GdIOJk7IY3gr45Cn6sM/ao
         FE3EBCYnmEHTWg4ZAJErZKuqiCmrqeCYXl1KzxC4j82lY8jdpZqr0ihO75bSLqBIlc40
         MkFA==
X-Gm-Message-State: AOAM532DYt0GtRBD+TDjIYnmsiA0acIC3tsIGsg8fInetcSGAMXh1ejZ
        pcBRaImurTBa6yS1oOJ0RGlY8g==
X-Google-Smtp-Source: ABdhPJyRBO2ZaWNNx9oMLxgSdzZt7zm1f0qHmfeVh7Otsqjj8H9nU4lh/eapGuyMyQ4riKNsyq/nzg==
X-Received: by 2002:a5d:9d44:: with SMTP id k4mr3043652iok.112.1633450995779;
        Tue, 05 Oct 2021 09:23:15 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k7sm2204139ilq.37.2021.10.05.09.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 09:23:15 -0700 (PDT)
Subject: Re: [PATCH v5 00/14] blk-mq: Reduce static requests memory footprint
 for shared sbitmap
To:     John Garry <john.garry@huawei.com>, kashyap.desai@broadcom.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, hare@suse.de, linux-scsi@vger.kernel.org
References: <1633429419-228500-1-git-send-email-john.garry@huawei.com>
 <ae33dde8-96e8-2978-5f32-c7e0a6136e8e@kernel.dk>
 <81d9e019-b730-221e-a8c0-f72a8422a2ec@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1217e922-8bd5-9c2c-b7b0-1b75fff9ee04@kernel.dk>
Date:   Tue, 5 Oct 2021 10:23:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <81d9e019-b730-221e-a8c0-f72a8422a2ec@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 7:34 AM, John Garry wrote:
> On 05/10/2021 13:35, Jens Axboe wrote:
>>> Baseline is 1b2d1439fc25 (block/for-next) Merge branch 'for-5.16/io_uring'
>>> into for-next
>> Let's get this queued up for testing, thanks John.
> 
> Cheers, appreciated
> 
> @Kashyap, You mentioned that when testing you saw a performance 
> regression from v5.11 -> v5.12 - any idea on that yet? Can you describe 
> the scenario, like IO scheduler and how many disks and the type? Does 
> disabling host_tagset_enable restore performance?

FWIW, I ran my usual peak testing on this and didn't observe any regressions.
Caveat being that a) no scheduler is involved, and b) no shared tags. But
at least that fast case/path is fine.

-- 
Jens Axboe

