Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23ABE336C28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 07:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhCKGWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 01:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhCKGVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:21:50 -0500
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 Mar 2021 22:21:50 PST
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C6CC061574;
        Wed, 10 Mar 2021 22:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Zr8zbvgyg7nhRZoeY3Vz1jrV4bcNHTKeMaKRinH1yII=; b=NCADNCLO/4QMkjLSVyP7bP/oJW
        uCDchjo4FZbIq3ZEDIU1dLicZOplGeORgs50bjamRJ9YOANS5nMIzRqPlGRkCXCea4QhJgA6kLPvZ
        gq/3E2ghyOhBQhKCZWQ18EmwRbZHIaiZZGtTN5PCOONAumtUX6yedboGmjUHaITbnq6+YU9F7IAAD
        lamNgWrGUh4aTXXQQT96Bw9pMHE0lyCeUXuSePMTxatlvOjZzR4WKZJdiL18mJH3dHghjs7tO9U+1
        wGfDq6JM8x9zJvFBejU5CwVC0bWTZ2Pp96+CwX/hQNXNNbxXRu8QSkmwUKFxQqoYyKziYv1tfBqsf
        h+YTmduA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKEhg-000tZN-1W; Thu, 11 Mar 2021 06:21:48 +0000
Subject: Re: [PATCH] ia64: kernel: Few typos fixed in the file fsys.S
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210311061058.29492-1-unixbhaskar@gmail.com>
 <e26a1461-0d05-d79c-7688-de45d285e068@infradead.org>
 <356e2572-63cb-c7cb-2ebd-04ea21b161f0@physik.fu-berlin.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eb1ceeee-3620-d494-7d3c-9baeca027ff2@infradead.org>
Date:   Wed, 10 Mar 2021 22:21:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <356e2572-63cb-c7cb-2ebd-04ea21b161f0@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 10:17 PM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 3/11/21 7:15 AM, Randy Dunlap wrote:
>> On 3/10/21 10:10 PM, Bhaskar Chowdhury wrote:
>>>
>>> Mundane spelling fixes.
>>>
>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> but no maintainer Cc:ed to pick it up...
> 
> I guess Andrew's tree will just work fine in this case?

Sure, it could.

-- 
~Randy

