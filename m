Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B06358E38
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhDHUUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHUUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:20:22 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA555C061760;
        Thu,  8 Apr 2021 13:20:10 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id t13so1573050qvs.7;
        Thu, 08 Apr 2021 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nznclVC3IBg9dVDWPKHe3VIDxWvi1+V9KduB+Ebr+qQ=;
        b=WjHUJYbdsQS7tHuQ+j/2GhE1SiwPcRtbiy7lKUzeoivPcGRuvRZJKuJp7n7H0fDOmh
         uLH3NyAfdBJMNO969azXaVBgdDB63hbGEC8kt8V3yRJ1TOmOR6pnJwDQOjo27XaqUqw+
         CKt9ppE4h/R5DQk9LDkF6lpzyps/6bpzJjV+Qf85fMxaUlUUQRdQPSl7owu8UleuuJag
         BAN+erjATpByyTyRggq0kX32uCaq6WMUA9SrKct4F6HEzxkZA6YBGnZyjewnybt7t4Gg
         mVC+OpagfGFpLTfpFn56MTLqDWY1st0tVm6lEHrlaRIbqxUTyfauLKB/8r0YWrvRb66A
         xZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nznclVC3IBg9dVDWPKHe3VIDxWvi1+V9KduB+Ebr+qQ=;
        b=sH4vxsXRImZeS/jxsEvf+76EoE4UGF/p6VuwBPaKO0+1SJhn7vaX0m2TcWX96pNB+I
         Sjjw7J6xYkaISkkEV1xgTC2wMZ27RNbL+9X67Ri0/oxQUJ39uhL+rXDzyBSVZshla0LP
         bQhIssIh6rDCZI24E/91TuiMqJla0e13zfHjYEz2YhAVkkXbJ7sE/QXnIVbMuRhkvVOg
         42ZSRN6bnkX2C4l0XcLPu7KmRwYUelzgu2TJLZSEriV44/5OOVI5kgfqHeE9LITY6LAK
         QKlrAwHfX5TQihzFCnzKmb2xQgF1E/aLoNni1thRZZbkqgnh+8Z4/I9ibROI8yyW1KoE
         n+4A==
X-Gm-Message-State: AOAM532Lr5hEczn/6N+OBgWKomtWv8DrPIKwCael28+82qtA3dTgfPLI
        w6DMXGRwVMXTTvjXwFSXDnU=
X-Google-Smtp-Source: ABdhPJyDl5TxD4+5hmKx5VhOWpdToYU/FFAdJPH9HAVjsL0Rpku7E7TSmp67XVl8NUIntxRzEfLzuA==
X-Received: by 2002:a05:6214:180d:: with SMTP id o13mr10923159qvw.10.1617913210127;
        Thu, 08 Apr 2021 13:20:10 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id p186sm306394qka.66.2021.04.08.13.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 13:20:09 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] of: unittest: overlay: ensure proper alignment of
 copied FDT
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210408151736.2216238-1-frowand.list@gmail.com>
 <CAL_JsqLJP5Q8R+4yQOhiG_xTA6CHLSWfu-0hFzmZtiv96Do_eA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <1b957025-316b-b5a4-b923-866d7ddeab7c@gmail.com>
Date:   Thu, 8 Apr 2021 15:20:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLJP5Q8R+4yQOhiG_xTA6CHLSWfu-0hFzmZtiv96Do_eA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 1:27 PM, Rob Herring wrote:
> On Thu, Apr 8, 2021 at 10:17 AM <frowand.list@gmail.com> wrote:
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
>>  drivers/of/of_private.h |  2 ++
>>  drivers/of/overlay.c    | 28 +++++++++++++++++-----------
>>  drivers/of/unittest.c   | 12 +++++++++---
>>  3 files changed, 28 insertions(+), 14 deletions(-)
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
>> index 50bbe0edf538..cf770452e1e5 100644
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
>> @@ -873,7 +873,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>   * internal documentation
>>   *
>>   * of_overlay_apply() - Create and apply an overlay changeset
>> - * @fdt:       the FDT that was unflattened to create @tree
>> + * @fdt:       base of memory allocated to hold *@fdt_align
>> + * @fdt_align: the FDT that was unflattened to create @tree, aligned
>>   * @tree:      Expanded overlay device tree
>>   * @ovcs_id:   Pointer to overlay changeset id
>>   *
>> @@ -912,8 +913,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>   * id is returned to *ovcs_id.
>>   */
>>
>> -static int of_overlay_apply(const void *fdt, struct device_node *tree,
>> -               int *ovcs_id)
>> +static int of_overlay_apply(const void *fdt, const void *fdt_align,
>> +               struct device_node *tree, int *ovcs_id)
> 
> I think it's better if you move the kfree's out of this function. It
> would be a broken design if this function was public because you'd
> have no idea if 'fdt' could be freed or not. No reason to have that
> bad design just because it's static. If a function returns an error,
> then it should undo everything it did, but nothing more.
> 
> Rob
> 

The pattern of "If a function returns an error, then it should undo
everything it did, but nothing more" is usually what I would expect,
but overlays have more than a bit of bizarro land in their genes.

Once an overlay has been applied, the devicetree subsystem owns and
is responsible for the freeing of the related FDT.

This is noted just after calling of_overlay_apply():

        ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
        if (ret < 0) {
                /*
                 * new_fdt and overlay_root now belong to the overlay
                 * changeset.
                 * overlay changeset code is responsible for freeing them.
                 */

and is also noted inside of_overlay_apply():

        /*
         * As of this point, fdt and tree belong to the overlay changeset.
         * overlay changeset code is responsible for freeing them.
         */

of_overlay_apply() is not public on purpose.  of_overlay_fdt_apply() was
created to be the public function and to provide the encapsulation of
the copy of the FDT for which memory is allocated in of_overlay_fdt_apply().

-Frank
