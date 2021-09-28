Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106B541B7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbhI1Txq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242559AbhI1Txp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:53:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D448C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=nCp0Yz6+43NcQCPSO/yhFy3yK/O2S77aIJzE0JnpptE=; b=NYL7YHpCdUXLjSmdKsIbe/BQdy
        Sh8Vpcc5CEXi7r4WM0/4xxfwvl31kS8cBkOeXMzW3HnKyl7tCjw/qvLMdNAmy1qBFD0HULW2d1Khu
        dRRUEctDqPd1HiyfOWEQ/wBUkwXWF9bFJFX55QDua47bgD5/RE1ehbGh9cTZPHGoUGgTlIlUCsvTg
        8BJ2eX1F6/rq96xigBHVpL6DsTGVlp4YHEIkUX9TNZSFTi7Luq3W/rkXlDhSOevL81VlQbsJ7wZbm
        +DwNrXnjc7DOzmbzjE9ys0jXnA8rTfnGfjl5lEV5zLHCZ748jCMoCYnnAfeY1hRBUlAIqPnLfrh8m
        x7j8LgCg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVJ91-008hwr-Ve; Tue, 28 Sep 2021 19:52:04 +0000
Subject: Re: [PATCH v2] HSI: cmt_speech: unmark comments as kernel-doc
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>
References: <20210928183536.30645-1-rdunlap@infradead.org>
 <20210928185727.GA10433@duo.ucw.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <85f5c28b-3b70-8e31-47a0-7317ebdc216f@infradead.org>
Date:   Tue, 28 Sep 2021 12:52:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928185727.GA10433@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 11:57 AM, Pavel Machek wrote:
> Hi!
> 
>> Fix build warnings from the kernel test robot:
>>
>> drivers/hsi/clients/cmt_speech.c:831: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>      * Block until pending data transfers have completed.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Cc: Aditya Srivastava <yashsri421@gmail.com>
>> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> If noone applies it, you may want to send it to akpm, he's  often
> helpful in pushing similar patches.

Yes, good idea. Thanks.

-- 
~Randy
