Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C63358FEB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhDHWk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhDHWkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:40:25 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA40C061760;
        Thu,  8 Apr 2021 15:40:14 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id y5so4016582qkl.9;
        Thu, 08 Apr 2021 15:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zqNhDpCeYS6QSJxT3ix+09XaNUJtxgOgbVp2qXDUwE0=;
        b=Kx8tLTz5k1pUsYsYbQ9rbZxWBPx/5tEGEUzUJZUtg5+bYQkCL66Fhc9HjxRcOtGhav
         0XrHjEVZPxED1Ea/354dZwNAS0IqfHn+HKH6IHIh1IXDo9nJv++aSOyl+SOWFHkv+rfJ
         81YbiGSwAlDFmGNXKsMXm38+D+z3GJCV4h4c2z68gm5PwsiXgGNzoPnJt1WTk+86Cvef
         uj58fX+Z+9Li01p4AvBbELqsetCg4geG9ncJdKS/C8Kr1LSGRHCGH9fITBIHhjo0JzBK
         elInXbQ30gZzm/Uhuy5Ik3M9VYSSnuFs1SfoQ9gKqDUOlLM8DyX5AHwzCGutSMHlqpj0
         TWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zqNhDpCeYS6QSJxT3ix+09XaNUJtxgOgbVp2qXDUwE0=;
        b=bhnnQo+Pqu67ajmOLiu4FKdrXtzWRifIE4z9w7A62R2Hi6We7kh2G4xZEW0r4I1chT
         56gwLz+XKQ9Pgn0QxsZ27lN6NMNhk1VRbYToNxK3gUxGR1TENYgJIu4JE52RBBTPrMsC
         T/ILafzFwrovi04V0MaOzeuEuux2v9SBKggB2ZmXHD0f372N9J5h8OEyJNhM7676vpbj
         Pjob90AbjEpPfPEeoYOfMnSZJGXJ/40S3Z5rgoUgEaspInfuVU8wXN2AIEZGOOL0f/A0
         /AQNQrLmKfPG0ZdeKUVXjh6LL1dYpuAtUjux/9NmCeM157CZU/m+oi6hM5VDYp1gw5si
         4DcA==
X-Gm-Message-State: AOAM53179banCpCEcXaQv35IM7NDn8AW2jkMp67K6mW3QSpHywfVYnEB
        1bQLcXi9zoFL4636qMUDcrE=
X-Google-Smtp-Source: ABdhPJwt6Bakcht1PibcyW2KY9OwBJDjMvdCl5uSNNXvVD9ncA79xivfDYYoE1rhP//W/DSl5xJKXA==
X-Received: by 2002:a05:620a:1585:: with SMTP id d5mr11231214qkk.325.1617921613371;
        Thu, 08 Apr 2021 15:40:13 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id c5sm551610qkl.21.2021.04.08.15.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 15:40:13 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] of: unittest: overlay: ensure proper alignment of
 copied FDT
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210408204508.2276230-1-frowand.list@gmail.com>
 <CAL_Jsq+Os6O6CpRYurmf_4-Xnzgpkd1jbDbnp0en1TPbZXTf7w@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ad805b26-4bf4-bfbc-d3b6-522295302791@gmail.com>
Date:   Thu, 8 Apr 2021 17:40:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+Os6O6CpRYurmf_4-Xnzgpkd1jbDbnp0en1TPbZXTf7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 4:28 PM, Rob Herring wrote:
> On Thu, Apr 8, 2021 at 3:45 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> The Devicetree standard specifies an 8 byte alignment of the FDT.
>> Code in libfdt expects this alignment for an FDT image in memory.
>> kmemdup() returns 4 byte alignment on openrisc.  Replace kmemdup()
>> with kmalloc(), align pointer, memcpy() to get proper alignment.
>>
>> The 4 byte alignment exposed a related bug which triggered a crash
>> on openrisc with:
>> commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
>> as reported in:
>> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>
>> ---
>>
>> changes since version 1:
>>   - use pointer from kmalloc() for kfree() instead of using pointer that
>>     has been modified for FDT alignment
>>
>> changes since version 2:
>>   - version 1 was a work in progress version, I failed to commit the following
>>     final changes
>>   - reorder first two arguments of of_overlay_apply()
>>
>> changes since version 3:
>>   - size of memory allocation and size of copy after pointer alignment
>>     differ, use separate variables with correct values for each case
>>   - edit comment to more clearly describe that ovcs->fdt is the allocated
>>     memory region, which may be different than where the aligned pointer points
>>   - remove unused parameter from of_overlay_apply()
>>
>>  drivers/of/of_private.h |  2 ++
>>  drivers/of/overlay.c    | 27 +++++++++++++++++----------
>>  drivers/of/unittest.c   | 13 ++++++++++---
>>  3 files changed, 29 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
>> index d9e6a324de0a..d717efbd637d 100644
>> --- a/drivers/of/of_private.h
>> +++ b/drivers/of/of_private.h
>> @@ -8,6 +8,8 @@
>>   * Copyright (C) 1996-2005 Paul Mackerras.
>>   */
>>
>> +#define FDT_ALIGN_SIZE 8
>> +
>>  /**
>>   * struct alias_prop - Alias property in 'aliases' node
>>   * @link:      List node to link the structure in aliases_lookup list
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index 50bbe0edf538..ecf967c57900 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -57,7 +57,7 @@ struct fragment {
>>   * struct overlay_changeset
>>   * @id:                        changeset identifier
>>   * @ovcs_list:         list on which we are located
>> - * @fdt:               FDT that was unflattened to create @overlay_tree
>> + * @fdt:               base of memory allocated to hold aligned FDT that was unflattened to create @overlay_tree
>>   * @overlay_tree:      expanded device tree that contains the fragment nodes
>>   * @count:             count of fragment structures
>>   * @fragments:         fragment nodes in the overlay expanded device tree
>> @@ -719,8 +719,8 @@ static struct device_node *find_target(struct device_node *info_node)
>>  /**
>>   * init_overlay_changeset() - initialize overlay changeset from overlay tree
>>   * @ovcs:      Overlay changeset to build
>> - * @fdt:       the FDT that was unflattened to create @tree
>> - * @tree:      Contains all the overlay fragments and overlay fixup nodes
>> + * @fdt:       base of memory allocated to hold aligned FDT that was unflattened to create @tree
>> + * @tree:      Contains the overlay fragments and overlay fixup nodes
>>   *
>>   * Initialize @ovcs.  Populate @ovcs->fragments with node information from
>>   * the top level of @tree.  The relevant top level nodes are the fragment
>> @@ -873,7 +873,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>   * internal documentation
>>   *
>>   * of_overlay_apply() - Create and apply an overlay changeset
>> - * @fdt:       the FDT that was unflattened to create @tree
>> + * @fdt:       base of memory allocated to hold the aligned FDT
>>   * @tree:      Expanded overlay device tree
>>   * @ovcs_id:   Pointer to overlay changeset id
>>   *
>> @@ -913,7 +913,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>   */
>>
>>  static int of_overlay_apply(const void *fdt, struct device_node *tree,
>> -               int *ovcs_id)
>> +                           int *ovcs_id)
>>  {
>>         struct overlay_changeset *ovcs;
>>         int ret = 0, ret_revert, ret_tmp;
>> @@ -953,7 +953,9 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>>         /*
>>          * after overlay_notify(), ovcs->overlay_tree related pointers may have
>>          * leaked to drivers, so can not kfree() tree, aka ovcs->overlay_tree;
>> -        * and can not free fdt, aka ovcs->fdt
>> +        * and can not free memory containing aligned fdt.  The aligned fdt
>> +        * is contained within the memory at ovcs->fdt, possibly at an offset
>> +        * from ovcs->fdt.
>>          */
>>         ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
>>         if (ret) {
>> @@ -1014,9 +1016,10 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>>  int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>>                          int *ovcs_id)
>>  {
>> -       const void *new_fdt;
>> +       void *new_fdt;
>> +       void *new_fdt_align;
>>         int ret;
>> -       u32 size;
>> +       u32 size, size_alloc;
>>         struct device_node *overlay_root;
>>
>>         *ovcs_id = 0;
>> @@ -1036,11 +1039,15 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>>          * Must create permanent copy of FDT because of_fdt_unflatten_tree()
>>          * will create pointers to the passed in FDT in the unflattened tree.
>>          */
>> -       new_fdt = kmemdup(overlay_fdt, size, GFP_KERNEL);
>> +       size_alloc = size + FDT_ALIGN_SIZE;
>> +       new_fdt = kmalloc(size_alloc, GFP_KERNEL);
> 
> As size_alloc is only used once, you can just do:
> 
> new_fdt = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
> 
> Same for the unittest. I can fix up.
> 
> Applying now so this gets into linux-next this week.

Thanks, that change looks like an improvement to me.

> 
> Rob
> 

