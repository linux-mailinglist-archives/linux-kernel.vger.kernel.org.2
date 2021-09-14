Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFDE40B9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhINVLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbhINVLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:11:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE67EC061574;
        Tue, 14 Sep 2021 14:10:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9D4F62CA;
        Tue, 14 Sep 2021 21:10:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9D4F62CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1631653818; bh=hK1NTRkC+DlMXEDCIJHtEf2xig6gPPXIb7xtkRinfRQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=n2SAwOLvwQvXbAEoEB8IXbI9rQc8xnZ5FDMUSYXGgklh6xH27Jm5kafGDWnZBOswY
         qE+JlQZcOlMIrYq5TpdedHhoOQZC/uC1a9FnIryXcdfg3t+f73mQhibZl6JhI3+FCx
         FI8XTmZ3Ws8yfrLaXT+VwdJRWtHxxPwnJFEpIMIZ6BcIEexCBW9JfuHRxi44sN9uey
         aMszKF+G35Wm3mAqSwI4SydQw9aZrLtnQbPypx4fZP/z7a72ykutMSKxDt29Ox744s
         G2ACXWyLgu9hTDPgjq5YYzinC0q7+VkLMVL0Wm781nKHL6Slx0/2DUsqHocUx1Z26H
         DQ1EvWXF6qnqw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Documentation: checkpatch: Add SYMBOLIC_PERMS message
In-Reply-To: <CABJPP5DyppeW=_XXJKn_NnQahOn=k0oBi-dDdcyxN8rygwusEw@mail.gmail.com>
References: <CAKXUXMyRKM9Ev_Yyyup-T=AZe2aYcN-ZneXsLmHtUC7as67zNQ@mail.gmail.com>
 <20210904082330.14864-1-utkarshverma294@gmail.com>
 <CABJPP5DyppeW=_XXJKn_NnQahOn=k0oBi-dDdcyxN8rygwusEw@mail.gmail.com>
Date:   Tue, 14 Sep 2021 15:10:18 -0600
Message-ID: <87ee9qdft1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dwaipayan Ray <dwaipayanray1@gmail.com> writes:

> On Sat, Sep 4, 2021 at 1:53 PM Utkarsh Verma <utkarshverma294@gmail.com> wrote:
>>
>> Add a new message type SYMBOLIC_PERMS under the 'Permissions'
>> subsection. Octal permission bits are easier to read and understand
>> instead of their symbolic macro names.
>>
>> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
>> Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> ---
>>  Documentation/dev-tools/checkpatch.rst | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
>> index f0956e9ea2d8..41037594ec24 100644
>> --- a/Documentation/dev-tools/checkpatch.rst
>> +++ b/Documentation/dev-tools/checkpatch.rst
>> @@ -957,6 +957,17 @@ Permissions
>>      Permission bits should use 4 digit octal permissions (like 0700 or 0444).
>>      Avoid using any other base like decimal.
>>
>> +  **SYMBOLIC_PERMS**
>> +    Permission bits in the octal form are more readable and easier to
>> +    understand than their symbolic counterparts because many command-line
>> +    tools use this notation only. Experienced kernel developers have been using
>
> Let's remove "only".
>
>> +    this traditional Unix permission bits for decades and so they find it
>
> Maybe you meant "these" here.
>
> With these changes made,
> Acked-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

I took the liberty of apply the patch with those changes made.

Thanks,

jon
