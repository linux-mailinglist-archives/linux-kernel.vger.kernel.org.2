Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3204A3F361B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhHTVmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhHTVmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:42:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EFBE6115A;
        Fri, 20 Aug 2021 21:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629495699;
        bh=Hcyczx0dUv6OOPsK53/cEFLZyL+VYmXz7Ndl9CnAKy0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YKxJxyEKRrHb/B3gpyM+AT6e+2qO6u2bTONGLcP4ZizlmXZ0MqbDuMVEECgT9VD2y
         p7p4d1hu5PZrSB87avSQ2kGofxgkt5vLjs3hjdyCMy5pycJJoj0yLWbdZyqXNaeBtd
         lqVlodVvm/czeHtMrXdyrmQSwGDPiBHcrvwLkkIsJFwt4aUyKwzHVj0QpCgnJKo9XQ
         4Q4wtyjDXvcoPaxxKkQmGRiuLig9OfT6c0eiCasAFaR1yGBthXFe68bF0VHgpFvuFk
         ibHyfPhxMVRFRAnfdn/DNWN2VLeODJ6O3N7wHkWQjIeclfx1PI1fBeiBX6JtpAdBo8
         q5aB9Vd5qELNw==
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: introduce periodic iostat io
 latency traces
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20210820035229.216975-1-daeho43@gmail.com>
 <20210820035229.216975-2-daeho43@gmail.com>
 <48725f58-1a48-73f3-80cf-a0c5efc3b470@kernel.org>
 <CACOAw_xcwZN_H7_zi7iMJh9HpzXnPd67fNAcxhu5UUSmJk7c1Q@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <f2ff8fd5-83e0-0c63-ed48-f21a49ab90dc@kernel.org>
Date:   Sat, 21 Aug 2021 05:41:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACOAw_xcwZN_H7_zi7iMJh9HpzXnPd67fNAcxhu5UUSmJk7c1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/20 23:23, Daeho Jeong wrote:
> On Fri, Aug 20, 2021 at 3:50 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2021/8/20 11:52, Daeho Jeong wrote:
>>> +void iostat_update_and_unbind_ctx(struct bio *bio, int rw)
>>> +{
>>> +     struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
>>> +     int sync_type = bio->bi_opf & REQ_SYNC ? 0 : 1;
>>
>> int sync_type = bio->bi_opf & REQ_SYNC ? 1 : 0;
>>
>> Right?
> 
> This means just type, not boolean number. So, I set type 0 is sync and
> type 1 is async.

How about changing this to is_sync or similar name of bool type variable?

> 
>>
>>>    int f2fs_init_iostat(struct f2fs_sb_info *sbi)
>>>    {
>>>        /* init iostat info */
>>>        spin_lock_init(&sbi->iostat_lock);
>>> +     spin_lock_init(&sbi->iostat_lat_lock);
>>>        sbi->iostat_enable = false;
>>>        sbi->iostat_period_ms = DEFAULT_IOSTAT_PERIOD_MS;
>>> +     sbi->iostat_io_lat = f2fs_kzalloc(sbi, sizeof(struct iostat_lat_info),
>>> +                                     GFP_KERNEL);
>>> +     if (!sbi->iostat_io_lat)
>>> +             return -ENOMEM;
>>
>> What do you think of just embedding iostat_io_lat structure into f2fs_sb_info
>> structure? it's minor thing though.
>>
> 
> I also wanted to do that, but if we embed this type, we need to define
> that structure in f2fs.h file.
> Is it okay with you?

Oh, correct, it will be more appropriate to define the structure in iostat.h.

Is it fine to just use memset(io_lat, 0, sizeof(struct iostat_lat_info)) to
reset all fields in f2fs_reset_iostat()?

Thanks,

> 
>> Thanks,
