Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCAF340C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhCRSDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRSDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:03:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65212C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ODxAg8Wqr81xB7zG6/U4iNV+VQ8asoiM0yjqEKw10s4=; b=cwdhb8rAOeIk5AxjSIOOgXpBPb
        l41aCIRkpN+Q0W7eLUI+6NcimweO0rWZkY1XFUnaUllIICZAm/mZVZJ40K7SfgGpR0/wV5Ma66C8l
        cZiiztpOelw91Uq9Ge+iaGuqUd6FQBfha2NbGGflXjTGnnGILo+jcQE/ypGJqOocy77ICvbUbDE+4
        NzQdVeMOrn8/wEN74bckdA2gm2MHG0alAHUcv8N8SdTOhIOhbE+G+EqDYA2Do3nLut9I6b9tOIwsQ
        fxAchF0LFuNdHfG+H5IrUDIA4ENAzSQlTPT0oylukmK7M2kvyd1XwpdO6f6wc25vBSECy4RUM0gWo
        js7z5/sw==;
Received: from [2601:1c0:6280:3f0::9757]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwzf-003K5h-97; Thu, 18 Mar 2021 18:03:39 +0000
Subject: Re: [PATCH] drm: Few typo fixes
To:     Joe Perches <joe@perches.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210318103739.27849-1-unixbhaskar@gmail.com>
 <49d9c9372870da1c235b0afb01f5eab4385cbf0b.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ca4e3882-c0e7-e2f0-2f7c-0ec4ea2393c2@infradead.org>
Date:   Thu, 18 Mar 2021 11:03:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <49d9c9372870da1c235b0afb01f5eab4385cbf0b.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 7:25 AM, Joe Perches wrote:
> On Thu, 2021-03-18 at 16:07 +0530, Bhaskar Chowdhury wrote:
>> s/instatiated/instantiated/
>> s/unreference/unreferenced/
> 
> []> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
> []
>> @@ -644,7 +644,7 @@ EXPORT_SYMBOL(drm_property_blob_get);
>>   * @id: id of the blob property
>>   *
>>   * If successful, this takes an additional reference to the blob property.
>> - * callers need to make sure to eventually unreference the returned property
>> + * callers need to make sure to eventually unreferenced the returned property
> 
> I think this is worse.

Agreed -- not good.

-- 
~Randy

