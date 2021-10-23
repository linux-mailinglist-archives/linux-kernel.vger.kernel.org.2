Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A77438554
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 22:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhJWUjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 16:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhJWUjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 16:39:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDE6C061714
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 13:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=0bP/MPMZTzJAGhiADSV68n2o7L0Y7Sa9kaJOitTCucU=; b=1dJ5RkRm6mGZQCkpIPjoIQqK7+
        0GQay5KvW13NgmjVue9Y1l7t6KdZzXoV6uRtQ4sNSkcD97NuiZJfLB7Q2lhJnkP05COUGrnXLGrGS
        yXbpBbR4w17Ezq5uAeL3RwSZ2THQZ1+IBfcIENmHlIvPh1y9ykP4u/zOQLaKEuNDUQFxMzI217T6U
        BDwKSJ7qKtnSg1JNyyBWMv0DCUGimczYdjUkH6CoQ/bGWUqYzfLF4qXRBIYOriysva6qLLDehExaw
        klsSBpb3Pdvxrs6SxBQz5UypsZxw295BKXcdqJtxUWOrITqTaOrrGQ20nbT0xYsWsLQTdHp7WaYeT
        ulX5Xc1w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1meNl2-00DH8y-Ga; Sat, 23 Oct 2021 20:36:48 +0000
Subject: Re: [PATCH] riscv: cacheinfo: fix typo of homogenous
To:     Palmer Dabbelt <palmer@dabbelt.com>, georgedanielmangum@gmail.com
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>, peterz@infradead.org,
        wangkefeng.wang@huawei.com, will@kernel.org, tglx@linutronix.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-51275835-4c34-4099-85f5-13c6dbef4e19@palmerdabbelt-glaptop>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <750f6239-154d-9190-24ff-ece033add638@infradead.org>
Date:   Sat, 23 Oct 2021 13:36:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <mhng-51275835-4c34-4099-85f5-13c6dbef4e19@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/21 1:30 PM, Palmer Dabbelt wrote:
> On Fri, 08 Oct 2021 13:56:25 PDT (-0700), georgedanielmangum@gmail.com wrote:
>> Updates 'homonogenous' to 'homogenous' in comment.
> 
> I don't really know spelling that well, but checkpatch says
> 
>     WARNING: 'homogenous' may be misspelled - perhaps 'homogeneous'?
> 
> when applying this.  It looks like they're both words, but "homogeneous" is the right one?
> 

Internet search to grammar.com says:

To summarise, Earlier, homogenous was used as a scientific term, mainly in biology, but now it is almost obsolete, being replaced by homologous. Whereas, homogeneous is a common word, very much in use and means having similar or comparable characteristics.

Several web sites agree that homogeneous is currently preferable.

>>
>> Signed-off-by: hasheddan <georgedanielmangum@gmail.com>
>> ---
>>  arch/riscv/kernel/cacheinfo.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
>> index 90deabfe63ea..ff98546b1152 100644
>> --- a/arch/riscv/kernel/cacheinfo.c
>> +++ b/arch/riscv/kernel/cacheinfo.c
>> @@ -29,7 +29,7 @@ static struct cacheinfo *get_cacheinfo(u32 level, enum cache_type type)
>>      /*
>>       * Using raw_smp_processor_id() elides a preemptability check, but this
>>       * is really indicative of a larger problem: the cacheinfo UABI assumes
>> -     * that cores have a homonogenous view of the cache hierarchy.  That
>> +     * that cores have a homogenous view of the cache hierarchy.  That
>>       * happens to be the case for the current set of RISC-V systems, but
>>       * likely won't be true in general.  Since there's no way to provide
>>       * correct information for these systems via the current UABI we're


-- 
~Randy
