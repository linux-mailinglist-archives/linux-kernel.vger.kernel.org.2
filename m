Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C965A4296DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhJKSaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJKSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:30:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5B3C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:28:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oa4so13176820pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M2pNpl2tL7995hgKQ1256KxevURdkTwm4iin6b8QS5Y=;
        b=IrOou1ztG+GOXKgb/ZBl4oOVVNYCVqVBIMFLT0YcVm28akiUMuc/uxHh1il9MLTeU5
         /C/3I7/g5Cccvw+r7Pif+ZVPK0T/7/LyhMq6vM0B9p1nrc+wEzr8c2qpVCrtbq1+czOv
         Sb1c3L23EyZxy+qR8OFyp4TZXRNGQ26MyhbgA3I8ObQ9dHb5tiLetCTj3FETNvkRIr0W
         F9PDvNNbLlGv7pV+aj7GV+R90++x7VD8wYzpOzKmZcsg3gxggl9eMlJ5hV0RNMbnuFUw
         4EUn2a4avVlnRKOx5j408CdrZsVk3yl63jepKVR7SwugAjRLrosYl8+ss25RxZAAl6m4
         wnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M2pNpl2tL7995hgKQ1256KxevURdkTwm4iin6b8QS5Y=;
        b=T2+Hs0pMBXJiSXxMnRGo5E61zQoqNBwkEwhpwrdZbna6MBE27elBZWS9uPPVEEaSNz
         Wk2xDlw1LcgY0PyMXZUNFsW2xBcycYBldCGhkap2fkSSTI86KzrAJprJc2AgYTmUSd3M
         hxEzfr1xKJyqHkmNvFkptUyvMm3/gsIvDt9QAWJj4gbnlFGbQn05atDUT4ovcjyENALy
         EaRCfcoummWD1JfqBzvqbKOB5fKMtRwzMFI/68FsLuneC31awoQFqn25rC8HxSpmWMWQ
         cmLrcPBSMgLuJCDw4LauW6j281Oi4AbPnuJQCUSdJI9QaGGeBbnu374ld5/vfmgxT1mW
         8PwA==
X-Gm-Message-State: AOAM532flaMYY8RLyNn2YeADFtJ3LLhkfIbGfJS9RqUtubDK2XCwzndk
        olccbSpLMkP1gjk7kEtnAn0=
X-Google-Smtp-Source: ABdhPJyFaN9r6YI6sm7zODcYYrPjMhyRqfL5NMBXmAjzhTbMeHoOVfQfnEG1PLTti3Hu5EViJLyElw==
X-Received: by 2002:a17:90a:eb07:: with SMTP id j7mr696787pjz.20.1633976886137;
        Mon, 11 Oct 2021 11:28:06 -0700 (PDT)
Received: from [192.168.1.14] ([223.230.99.151])
        by smtp.gmail.com with ESMTPSA id rm6sm177320pjb.18.2021.10.11.11.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 11:28:05 -0700 (PDT)
Message-ID: <7ec390aa-1ecb-34ea-f422-b735888032b8@gmail.com>
Date:   Mon, 11 Oct 2021 23:58:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v2] staging: rtl8723bs: os_dep: simplify the return
 statement.
Content-Language: en-GB
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
References: <YWJ0vSrgsiKK7suE@user> <20211011123024.GB8429@kadam>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <20211011123024.GB8429@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/21 6:00 pm, Dan Carpenter wrote:
> On Sun, Oct 10, 2021 at 10:36:05AM +0530, Saurav Girepunje wrote:
>> Remove the unneeded and redundant check of variable on goto out.
>> Simplify the return using multiple goto label to avoid
>> unneeded check.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> 
> No, sorry but the goto bunny hops, the pointless do-nothing gotos, and
> the come from labels are all terrible.
> 
> regards,
> dan carpenter
> 

Thanks dan for your input.

Regards,
Saurav
