Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3626D3D2444
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 15:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhGVMX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 08:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhGVMW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 08:22:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C004C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 06:03:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gx2so6065828pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ff/8a51zf65javwTWFaQzWRS2rzY3fOngFsjFjhL2pU=;
        b=QRRSv42l3OKSfAHNwnceLsGisP7k4+dhKuS3ZPP+QH08L8pDuodnXV/ywZIp0mGMV3
         Ie4kRVwlk8+RQiyIKSVySxkANpsNy058jZtVjY0OtuEt5O6lohuXIxWHd6YAUxhOeXo0
         lX1Vr0t5kSevBOlm0Ojb3WxJrLSkKIsHWzGkPg3NnpU0KyqUPLpTETP/lEa3xjJbo0KG
         n5lf4h+ao5Aa40NstQ9J44KybIqxo0Kdd+D7K9VtVrDxTlNJFmmDDHAWmJN7+hvjw6cG
         QBhkDqdXz6X/rIXzRfn/S7OBeNZ54QUTc0rx+GUTCstf46QP9tFuHSULmZOFbR5724ws
         NhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ff/8a51zf65javwTWFaQzWRS2rzY3fOngFsjFjhL2pU=;
        b=VyxDhmeQ1Pdd4MlL/zIoTUVdzAZHLCgaVxldyGb5vjlme5H8gvSuPsFLJe4UBZmhzI
         iexd4YlzLrzZiRbre1fNhCREU1keILt7ghrjMABKFQh17DS2y5DVjJGaPIGoLWFZWn2M
         N3EBQnNbsbwOOSaQ8+w9qiwIomZKvP5aGHA8sYVBH05A2HNY3MxLpHkB9cxXsv6iqQiv
         UebnDPsJT9vorKisv4d8AP4qWf6LCWXR3I5MeCfSe5EbwrKEqytPL5jpBPOjbRZH6lhB
         x8yLvR/sAhWmK/CPydHzfEAPhtgI1CO069g8yeSYAAKVFq81lBSwI06kIrMZ+AYHe49M
         f40A==
X-Gm-Message-State: AOAM530H0LM/8eQZmdZm+JMBGiUCGfm4UgC3NRG7XbgZ+ykdD5STGx1s
        HLJb68E1y/4QSMqa5JIHnzY=
X-Google-Smtp-Source: ABdhPJyOCFGS9acfJ60WJxT+N7y/ltJ75utKHHvTo7/YKDME4Kuyaqk+hiaooaaT+vCzYQrSvH2iIQ==
X-Received: by 2002:a17:90b:1484:: with SMTP id js4mr40515679pjb.155.1626958983678;
        Thu, 22 Jul 2021 06:03:03 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id m21sm25643502pjz.36.2021.07.22.06.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 06:03:02 -0700 (PDT)
Subject: Re: [PATCH 2/3] drm: clarify lifetime/locking for drm_master's lease
 fields
To:     Daniel Vetter <daniel@ffwll.ch>
References: <20210722092929.244629-1-desmondcheongzx@gmail.com>
 <20210722092929.244629-3-desmondcheongzx@gmail.com>
 <YPlKCc7Sep71xjBC@phenom.ffwll.local>
Cc:     linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <5b8b3bd5-7519-e383-cb84-f354d898dc81@gmail.com>
Date:   Thu, 22 Jul 2021 21:02:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPlKCc7Sep71xjBC@phenom.ffwll.local>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/7/21 6:35 pm, Daniel Vetter wrote:
> On Thu, Jul 22, 2021 at 05:29:28PM +0800, Desmond Cheong Zhi Xi wrote:
>> In particular, we make it clear that &drm_device.mode_config.idr_mutex
>> protects the lease idr and list structures for drm_master. The lessor
>> field itself doesn't need to be protected as it doesn't change after
>> it's set in drm_lease_create.
>>
>> Additionally, we add descriptions for the lifetime of lessors and
>> leases to make it easier to reason about them.
>>
>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>> ---
>>   include/drm/drm_auth.h | 62 ++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 51 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/drm/drm_auth.h b/include/drm/drm_auth.h
>> index f99d3417f304..c978c85464fa 100644
>> --- a/include/drm/drm_auth.h
>> +++ b/include/drm/drm_auth.h
>> @@ -58,12 +58,6 @@ struct drm_lock_data {
>>    * @refcount: Refcount for this master object.
>>    * @dev: Link back to the DRM device
>>    * @driver_priv: Pointer to driver-private information.
>> - * @lessor: Lease holder
>> - * @lessee_id: id for lessees. Owners always have id 0
>> - * @lessee_list: other lessees of the same master
>> - * @lessees: drm_masters leasing from this one
>> - * @leases: Objects leased to this drm_master.
>> - * @lessee_idr: All lessees under this owner (only used where lessor == NULL)
>>    *
>>    * Note that master structures are only relevant for the legacy/primary device
>>    * nodes, hence there can only be one per device, not one per drm_minor.
>> @@ -88,17 +82,63 @@ struct drm_master {
>>   	struct idr magic_map;
>>   	void *driver_priv;
>>   
>> -	/* Tree of display resource leases, each of which is a drm_master struct
>> -	 * All of these get activated simultaneously, so drm_device master points
>> -	 * at the top of the tree (for which lessor is NULL). Protected by
>> -	 * &drm_device.mode_config.idr_mutex.
>> +	/**
>> +	 * @lessor:
>> +	 *
>> +	 * Lease holder. The lessor does not change once it's set in
> 
> Lessor is the lease grantor, lessee is the one receiving the lease. Maybe
> clarify this with
> 
> "Lease grantor, only set if this struct drm_master represents a lessee
> holding a lease of objects from @lessor. Full owners of the device have
> this set to NULL."
> 
>> +	 * drm_lease_create(). Each lessee holds a reference to its lessor that
> 
> I also figured it'd be a good idea to link to the drm_lease docs here to
> explain the concepts, but alas we don't have those :-( Hence at least
> define what we mean with lessor, lessee, lease and owner.
> 

Thanks for the suggestions, Daniel. I'll incorporate them in a v2.

Regarding the missing drm_lease docs... any reason we can't just add it 
in? Seems like most of the comments in drm_lease.c are almost correctly 
formatted too. I could clean them up, define the terms in a preamble, 
then add it to the v2 patch.

>> +	 * it releases upon being destroyed in drm_lease_destroy().
>> +	 *
>> +	 * Display resource leases form a tree of &struct drm_master. All of
> 
> For now we've limited the tree to a depth of 1, you can't create another
> lease if yourself are a lease. I guess another reason to update the
> drm_lease.c docs.
> 
> So maybe add "Currently the lease tree depth is limited to 1."
> 
>> +	 * these get activated simultaneously, so &drm_device.master
>> +	 * points at the top of the tree (for which lessor is NULL).
>>   	 */
>> -
>>   	struct drm_master *lessor;
>> +
>> +	/**
>> +	 * @lessee_id:
>> +	 *
>> +	 * ID for lessees. Owners always have ID 0. Protected by
> 
> Maybe clarify to "Owners (i.e. @lessor is NULL) ..."
> 
>> +	 * &drm_device.mode_config's &drm_mode_config.idr_mutex.
>> +	 */
>>   	int	lessee_id;
>> +
>> +	/**
>> +	 * @lessee_list:
>> +	 *
>> +	 * List of lessees of the same master. Protected by
> 
> We try to distinguis between list entries and the list, even though it's
> the same struct. So maybe
> 
> "List entry of lessees of @lessor, where they are linked to @lessee. Not
> use for owners."
> 
>> +	 * &drm_device.mode_config's &drm_mode_config.idr_mutex.
> 
>> +	 */
>>   	struct list_head lessee_list;
>> +
>> +	/**
>> +	 * @lessees:
>> +	 *
>> +	 * List of drm_masters leasing from this one. Protected by
>> +	 * &drm_device.mode_config's &drm_mode_config.idr_mutex.
>> +	 *
>> +	 * This master cannot be destroyed unless this list is empty as lessors
>> +	 * are referenced by all their lessees.
> 
> Maybe add "this list is empty of no leases have been granted."
> 
>> +	 */
>>   	struct list_head lessees;
>> +
>> +	/**
>> +	 * @leases:
>> +	 *
>> +	 * Objects leased to this drm_master. Protected by
>> +	 * &drm_device.mode_config's &drm_mode_config.idr_mutex.
>> +	 *
>> +	 * Objects are leased all together in drm_lease_create(), and are
>> +	 * removed all together when the lease is revoked.
>> +	 */
>>   	struct idr leases;
>> +
>> +	/**
>> +	 * @lessee_idr:
>> +	 *
>> +	 * All lessees under this owner (only used where lessor is NULL).
> 
> @lessor so it's highlighted correctly
> 
>> +	 * Protected by &drm_device.mode_config's &drm_mode_config.idr_mutex.
>> +	 */
>>   	struct idr lessee_idr;
>>   	/* private: */
> 
> With the nits addressed:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Thanks for updating the docs!
> -Daniel
> 
>>   #if IS_ENABLED(CONFIG_DRM_LEGACY)
>> -- 
>> 2.25.1
>>
> 

