Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9AA3170D3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhBJUAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhBJUAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:00:41 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B8AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:00:01 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k22so1821000pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X/pjMNA9NPnucWtVQcDsHQiSVC+LIE3WWhwdtkccKX8=;
        b=JxQLYqRNws+0XiSmYepBrgKjB7oFcsU6m9dIg5b/cBkd6BsTUvM5BoWPxY8b55WUBV
         i+wBOC0xuL7yIaRxS6/PfyrT6+p0/qD9pfFzvMzi/3nhEjRvj72Wo88GLE3h82O67I/p
         Hkq7XaMmzdxDkZJkStYbGInzasx/czdunE/UDlVlW/2nwqQFK39aEdgkiJbPsOGQfki6
         BMfTWwzYKiuOgZzaurBoEu/DVZXMUCl4UUxXBRCDa9zzPOf4uxKJ4YFVU/KFplo1Z/uL
         mHTHJzYJWRCPwEiQ8xKhaosjIgJQAUwpSCwItAR3vzX5Yi3+Rlqn+JpVnGo6k68SPMH9
         VFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X/pjMNA9NPnucWtVQcDsHQiSVC+LIE3WWhwdtkccKX8=;
        b=Luzq8nOSx7Opgl5ZONcVZnETE2zlnUJaR+lIJF8N5cJDYRpOj/r4HKVCEFpihbzSVC
         rBuBTEv8z+g++rE8Ab5rz2TMzYa+NovbuPyw/sZqEJtEfBqfo8jGp+KDT3CTmB8In5jA
         FYLOercQq8k68zCUA9cdMVs2yKJPJaXaoFm3iMQPPBuknpDZ3pEh9hbC+HAZGeGzzBzA
         FqLd6x8pAwRQvBA9uT7fFDEIkVMHCCiB+2ibaTjhLlFoAtJCsVl7C2jg86JjkLKR55NB
         MnqeD8G6xqddBXcLWqdgUNoSx5SwF+fI3tDz/knHL4o+hhp6nPW3abEZyIcUyajhXFM0
         KeZQ==
X-Gm-Message-State: AOAM530O3uW3k0hCzClxlV0X9mbylHYPiNnTQhrPYBXzQVOXR96fCRpI
        YIXG6JRQNn3xInVbhPoc5WpueQ==
X-Google-Smtp-Source: ABdhPJywKtOCis9FESO3dFlgiTKGML+vt7LocNs28KG6U3dQRCW1fqRB8r5RgpR9pPnlW/MYGXyTGg==
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr532927pjb.31.1612987200996;
        Wed, 10 Feb 2021 12:00:00 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21c1::194c? ([2620:10d:c090:400::5:a5c1])
        by smtp.gmail.com with ESMTPSA id j3sm2865402pjs.50.2021.02.10.11.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 12:00:00 -0800 (PST)
Subject: Re: [PATCH v4 0/5] add support for inline encryption to device mapper
To:     Mike Snitzer <snitzer@redhat.com>,
        Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        Eric Biggers <ebiggers@google.com>
References: <20210201051019.1174983-1-satyat@google.com>
 <20210210193327.GA8226@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c681d976-f1bd-482c-8ead-b099986b70e5@kernel.dk>
Date:   Wed, 10 Feb 2021 12:59:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210193327.GA8226@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/21 12:33 PM, Mike Snitzer wrote:
> On Mon, Feb 01 2021 at 12:10am -0500,
> Satya Tangirala <satyat@google.com> wrote:
> 
>> This patch series adds support for inline encryption to the device mapper.
>>
>> Patch 1 introduces the "passthrough" keyslot manager.
>>
>> The regular keyslot manager is designed for inline encryption hardware that
>> have only a small fixed number of keyslots. A DM device itself does not
>> actually have only a small fixed number of keyslots - it doesn't actually
>> have any keyslots in the first place, and programming an encryption context
>> into a DM device doesn't make much semantic sense. It is possible for a DM
>> device to set up a keyslot manager with some "sufficiently large" number of
>> keyslots in its request queue, so that upper layers can use the inline
>> encryption capabilities of the DM device's underlying devices, but the
>> memory being allocated for the DM device's keyslots is a waste since they
>> won't actually be used by the DM device.
>>
>> The passthrough keyslot manager solves this issue - when the block layer
>> sees that a request queue has a passthrough keyslot manager, it doesn't
>> attempt to program any encryption context into the keyslot manager. The
>> passthrough keyslot manager only allows the device to expose its inline
>> encryption capabilities, and a way for upper layers to evict keys if
>> necessary.
>>
>> There also exist inline encryption hardware that can handle encryption
>> contexts directly, and allow users to pass them a data request along with
>> the encryption context (as opposed to inline encryption hardware that
>> require users to first program a keyslot with an encryption context, and
>> then require the users to pass the keyslot index with the data request).
>> Such devices can also make use of the passthrough keyslot manager.
>>
>> Patch 2 introduces some keyslot manager functions useful for the device
>> mapper.
>>
>> Patch 3 introduces the changes for inline encryption support for the device
>> mapper. A DM device only exposes the intersection of the crypto
>> capabilities of its underlying devices. This is so that in case a bio with
>> an encryption context is eventually mapped to an underlying device that
>> doesn't support that encryption context, the blk-crypto-fallback's cipher
>> tfms are allocated ahead of time by the call to blk_crypto_start_using_key.
>>
>> Each DM target can now also specify the "DM_TARGET_PASSES_CRYPTO" flag in
>> the target type features to opt-in to supporting passing through the
>> underlying inline encryption capabilities.  This flag is needed because it
>> doesn't make much semantic sense for certain targets like dm-crypt to
>> expose the underlying inline encryption capabilities to the upper layers.
>> Again, the DM exposes inline encryption capabilities of the underlying
>> devices only if all of them opt-in to passing through inline encryption
>> support.
>>
>> A keyslot manager is created for a table when it is loaded. However, the
>> mapped device's exposed capabilities *only* updated once the table is
>> swapped in (until the new table is swapped in, the mapped device continues
>> to expose the old table's crypto capabilities).
>>
>> This patch only allows the keyslot manager's capabilities to *expand*
>> because of table changes. Any attempt to load a new table that doesn't
>> support a crypto capability that the old table did is rejected.
>>
>> This patch also only exposes the intersection of the underlying device's
>> capabilities, which has the effect of causing en/decryption of a bio to
>> fall back to the kernel crypto API (if the fallback is enabled) whenever
>> any of the underlying devices doesn't support the encryption context of the
>> bio - it might be possible to make the bio only fall back to the kernel
>> crypto API if the bio's target underlying device doesn't support the bio's
>> encryption context, but the use case may be uncommon enough in the first
>> place not to warrant worrying about it right now.
>>
>> Patch 4 makes DM evict a key from all its underlying devices when asked to
>> evict a key.
>>
>> Patch 5 makes some DM targets opt-in to passing through inline encryption
>> support. It does not (yet) try to enable this option with dm-raid, since
>> users can "hot add" disks to a raid device, which makes this not completely
>> straightforward (we'll need to ensure that any "hot added" disks must have
>> a superset of the inline encryption capabilities of the rest of the disks
>> in the raid device, due to the way Patch 2 of this series works).
>>
>> Changes v3 => v4:
>>  - Allocate the memory for the ksm of the mapped device in
>>    dm_table_complete(), and install the ksm in the md queue in __bind()
>>    (as suggested by Mike). Also drop patch 5 from v3 since it's no longer
>>    needed.
>>  - Some cleanups
>>
>> Changes v2 => v3:
>>  - Split up the main DM patch into 4 separate patches
>>  - Removed the priv variable added to struct keyslot manager in v2
>>  - Use a flag in target type features for opting-in to inline encryption
>>    support, instead of using "may_passthrough_inline_crypto"
>>  - cleanups, improve docs and restructure code
>>
>> Changes v1 => v2:
>>  - Introduce private field to struct blk_keyslot_manager
>>  - Allow the DM keyslot manager to expand its crypto capabilities if the
>>    table is changed.
>>  - Make DM reject table changes that would otherwise cause crypto
>>    capabilities to be dropped.
>>  - Allocate the DM device's keyslot manager only when at least one crypto
>>    capability is supported (since a NULL value for q->ksm represents "no
>>    crypto support" anyway).
>>  - Remove the struct blk_keyslot_manager field from struct mapped_device.
>>    This patch now relies on just directly setting up the keyslot manager in
>>    the request queue, since each DM device is tied to only 1 queue.
>>
>> Satya Tangirala (5):
>>   block: keyslot-manager: Introduce passthrough keyslot manager
>>   block: keyslot-manager: Introduce functions for device mapper support
>>   dm: add support for passing through inline crypto support
>>   dm: support key eviction from keyslot managers of underlying devices
>>   dm: set DM_TARGET_PASSES_CRYPTO feature for some targets
>>
>>  block/blk-crypto.c              |   1 +
>>  block/keyslot-manager.c         | 146 ++++++++++++++++++++++
>>  drivers/md/dm-core.h            |   5 +
>>  drivers/md/dm-flakey.c          |   4 +-
>>  drivers/md/dm-linear.c          |   5 +-
>>  drivers/md/dm-table.c           | 210 ++++++++++++++++++++++++++++++++
>>  drivers/md/dm.c                 |  18 ++-
>>  include/linux/device-mapper.h   |  11 ++
>>  include/linux/keyslot-manager.h |  11 ++
>>  9 files changed, 407 insertions(+), 4 deletions(-)
>>
>> -- 
>> 2.30.0.365.g02bc693789-goog
>>
> 
> This set looks good to me now.
> 
> To avoid DM needing another rebase on block: Jens (and others), would
> you like to review patches 1 and 2 (and reply with your Reviewed-by) so
> I could pickup the DM required keyslot-manager changes along with
> patches 3-5?

You can add my acked-by to 1+2 and queue it up.

-- 
Jens Axboe

