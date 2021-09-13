Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E24408460
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbhIMGEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbhIMGE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:04:28 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA4AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=+rWmNYjtOHSxFp9kboaLeLfyDqIpAYRXvG/uRUUjSyg=; b=G5utu2I/carUMA5bmkBvaS1w6r
        ANfcqjgT/1sp5J9Cr+qN2iT1ryD2sCdouvpE8W1ovcIeKqDYDWto+F2ZsuorGx3Przwxo+ycG0P/V
        CU6pKEA1ZaVQ2x3PYYOr1i0XAVizeVEcXBLqy414nqetU46fFRcj7SUaaIDUU66MRTit+MpUl/u+a
        rh/5pJhny45WgFlx42j+8M2srOOxWMjvTQkbKS6GegcbEkAW0eRpuYG5C6AWQmPKKBvRNyrSTmLMI
        7syKvajDu6zH4b1N57YUSed3xyJfV0AlM/HQmEUvNQlHcMbF9LRb7b6LGkhQWJNAivgCn6CXJMNXm
        UmsjC1ag==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPf3g-000LgU-DM; Mon, 13 Sep 2021 06:03:12 +0000
Subject: Re: h8300 pull request for 5.14-rc?
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>
References: <20210913054915.GA3631@lst.de>
 <25fc5ea6-b7b7-6d75-5550-590b2ce35291@infradead.org>
 <20210913055821.GB3631@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2e286ea7-4eda-6217-8344-c855637b70e5@infradead.org>
Date:   Sun, 12 Sep 2021 23:03:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913055821.GB3631@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/21 10:58 PM, Christoph Hellwig wrote:
> On Sun, Sep 12, 2021 at 10:52:04PM -0700, Randy Dunlap wrote:
>> Rich Felker says that he will look into handling the arch/sh/ patches.
>>
>> https://lore.kernel.org/lkml/20210912015740.GJ13220@brightrain.aerifal.cx/
> 
> What does that have to do with arch/h8300/?
> 

Sorry, my bad. Late here. :(

-- 
~Randy

