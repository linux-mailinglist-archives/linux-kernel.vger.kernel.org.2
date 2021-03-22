Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8339034460B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhCVNkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:40:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:40904 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhCVNkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:40:43 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1390E380;
        Mon, 22 Mar 2021 13:40:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1390E380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1616420443; bh=PLnp+capzx7a4yyXnm8hk/bB1JLQN1/aI0JlSX1IKnk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mZN16tWiuKvlK+XgoOL6JjXSCdERVjz3mg7akP0fMDxmMhLDnydiT3AwLESqIjA5d
         oiOO+WOoLgWzoF7y2lQg/d9n78wbZR35QevtT5t5ufvED2CMWUVSuIewiKjKlcdDnf
         FZjfhlfnGbUkiGZjEpabBqW70eR/iuEBtpYebMOK8Z7yU3NP95U3d7dFFx5/36v3I3
         VTyRjBqBM0VT+a1QKwIa4OfcuafS0/MH8XhsiMkDiYltSrrNTMUIbcRJKHGPLj/DFH
         2Um1azQ4qbVQyOH1mnMmox+gfTdh/LbLt9QDK1QbtXQijKJzYnha6iSEorxasRhjn6
         8DoHlxfFy1TEQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     sir@cmpwn.com, gregkh@linuxfoundation.org, lee.jones@linaro.org,
        bp@alien8.de, huawei@kernel.org, krzk@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] docs: submitting-patches Fix a typo
In-Reply-To: <YFgTkhA+IOvNVxEn@ArchLinux>
References: <20210322033000.2523887-1-unixbhaskar@gmail.com>
 <20210322034459.GE1719932@casper.infradead.org>
 <YFgTkhA+IOvNVxEn@ArchLinux>
Date:   Mon, 22 Mar 2021 07:40:41 -0600
Message-ID: <87ft0nl31i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:

> On 03:44 Mon 22 Mar 2021, Matthew Wilcox wrote:
>>On Mon, Mar 22, 2021 at 09:00:00AM +0530, Bhaskar Chowdhury wrote:
>>>
>>> s/mesages/messages/
>>
>>did you test the build afterwards?  you forgot to do something.
>>
> What are you talking about??? It is going over my head...why the build
> reqired?? A spello needs a rebuild???? Wondering....

Willy is pointing out that you have introduced an error into the docs
build.  A few minutes of your time to learn the basics of RST are likely
to prove more helpful then typing lots of question marks...

Thanks,

jon
