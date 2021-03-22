Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC67D344C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhCVQ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhCVQ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:56:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BFAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=gQBjO1oo3K8LJTYVDljiJaP3H55zAG5aiSDzNL8SzYc=; b=IUqKAlYx1cQXnnjD2dgBzuQdkK
        9ql0RPlxODUToFAjQ2UBAkTRdnBwa+KbGGv7nqsoe0GrBuvhEZ9PkC6irdazEgzVy2Xz39TKRQfyS
        RC2TYiZdNlrKHEv4GyxFtxeFsRlJGkWxSbdEu5tjwakM7NyPBEmg/JbcHbY4sMFsyTE87HABQPQiO
        WQkSrDVlzBLkZl1vYykGh4dUbunlfKSByuKxB780rn5hi1kSpbMvcoOQEyX/VmlFPaN788U5D5CHw
        UsUVKpJAWwoF8AC+nZsKPs1EQpQaiAkXkFZF3frpS/JRedKjC1UEnisovsqAvOi/RNbbPAsoLN03D
        uileKmPQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lONpl-008oKn-2w; Mon, 22 Mar 2021 16:55:25 +0000
Subject: Re: [PATCH] coresight: core: Fix typo in coresight-core.c
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Qi Liu <liuqi115@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@openeuler.org
References: <1616418670-45882-1-git-send-email-liuqi115@huawei.com>
 <914fbf5c-cb1a-47d0-00ec-e971f3e01ba1@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f6b88024-a78a-6306-bd94-c7ee3fca55ac@infradead.org>
Date:   Mon, 22 Mar 2021 09:55:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <914fbf5c-cb1a-47d0-00ec-e971f3e01ba1@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 7:38 AM, Suzuki K Poulose wrote:
> On 22/03/2021 13:11, Qi Liu wrote:
>> Fix up one typo: compoment->component.
>>
>> Fixes: 8e264c52e1da  ("coresight: core: Allow the coresight core driver to be built as a module")
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> 
> Thanks for the patch. I will queue this.

should be "both components"

-- 
~Randy

