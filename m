Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EFB41A152
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbhI0V22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbhI0V2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:28:24 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47EFC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VrodAO0Pdg9IB0jq54UEdE3u66vYUYlKYF1B4kV5kq8=; b=XLChNyp/CSrtitDsab7BD6WkGG
        SeT2HEs8xxHDTkKP8RR3M8l6zfvOMSH1NUYYupY+uIJiSu9pUMwKFFw/SfEPCXQ5AbElHo5tXjofD
        AcELEp7a0DuHApJRpZvnPhSr4lZs5QgNvnDMk92sCGW5fNX6bsA8GnWfQyizQxzq+uxA0YDec5Xy7
        2mfU/SYunyJeiFZN8RirNq24Fg0BHfgrxVhngvWNOPrM0ABim/iySN6k7z5m00WNw6pNx69SsAom0
        rKgF+8iHQL14lKsgQmh4qArkzkYuG/GBrWnsrGKNlyFqxY4ZwsLhSsBNe/lx8HJd4JYNjTsLoz0Tr
        Netappaw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUy97-004QHf-HR; Mon, 27 Sep 2021 21:26:45 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: m68k: default value for MEMORY_RESERVE?
Message-ID: <a1c34f2b-115c-7ab9-5b69-7c11ebc18b4f@infradead.org>
Date:   Mon, 27 Sep 2021 14:26:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Would it be safe (or unsafe) to add a default value for MEMORY_RESERVE?

As it is, kconfig can generate a randconfig with
"CONFIG_MEMORY_RESERVE=" (no value) since it has no default.

Then a following 'make all' finds an invalid symbol value and restarts
the config:

.config:214:warning: symbol value '' invalid for MEMORY_RESERVE
* Restart config...
Memory reservation (MiB) (MEMORY_RESERVE) [] (NEW)

That's OK until I try to script/automate randconfig builds.

Can we do anything about this or should I just add it to my
ignore-list?

thanks.
-- 
~Randy
