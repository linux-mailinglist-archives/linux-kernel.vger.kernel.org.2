Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687B1308586
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhA2GLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:11:50 -0500
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:50694 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230121AbhA2GLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:11:47 -0500
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 4BA9F7DC2;
        Thu, 28 Jan 2021 22:10:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4BA9F7DC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611900652;
        bh=NJ567OnihQV8gKSW5+1K4SDUw3MSCcj0EBXmTBzn5Bc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=owuKG8+hh52dmt73ST1XufzvgpQg8OGEVA9h6/YEh++xdinlj9yMjLClpRR3tzLRU
         YVbpd4c037Mw8wj8qQTL7XvyQSrL8f41Rj176LNVcCLZoPfLdAKapzML5+bL7eXlqF
         pogrwwtu4gU39rpCFPV8/asLNusq+xGgnsm56Fac=
Subject: Re: [PATCH v10 00/13] Add Broadcom VK driver
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20210129003029.10672-1-scott.branden@broadcom.com>
 <CAOesGMgzKKjOBHYM=eodZPm0rE=_oF9o_jjBudQ-Ef8gYFFMfg@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <6f34a285-76cf-b1fc-dc5c-c889e97d0d4c@broadcom.com>
Date:   Thu, 28 Jan 2021 22:10:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMgzKKjOBHYM=eodZPm0rE=_oF9o_jjBudQ-Ef8gYFFMfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-01-28 8:02 p.m., Olof Johansson wrote:
> Scott,
>
> On Thu, Jan 28, 2021 at 4:30 PM Scott Branden
> <scott.branden@broadcom.com> wrote:
>> This patch series drops previous patches in [1]
>> that were incorporated by Kees Cook into patch series
>> "Introduce partial kernel_read_file() support" [2].
>>
>> Remaining patches are contained in this series to add Broadcom VK driver.
>> (which depends on request_firmware_into_buf API addition which has
>> now been accepted into the upstream kernel as of v5.10-rc1).
>>
>> [1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
>> [2] https://lore.kernel.org/lkml/20201002173828.2099543-1-keescook@chromium.org/
>>
>> Changes from v9:
>>  - fix compile if CONFIG_TTY not set
>>  - use if-else statement instead of conditional expression in set_q_num
>>  - generate bcm_vk_msg_remove call in proper patch
>>    (was generated in tty patch when should be in msg patch)
> Did I miss something? Greg already applied v9, so any fixes on top
> needs to be new patches.
Sorry, was unfamiliar with the process of having changes in linux-next needing correcting.
I sent out new patches to correct these issues against linux-next now.
>
>
> -Olof
Thanks for providing correct process.

Scott
