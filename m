Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E90E3A5B19
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 01:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhFMXqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 19:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhFMXqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 19:46:45 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD3BC061574;
        Sun, 13 Jun 2021 16:44:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 681012C0;
        Sun, 13 Jun 2021 23:44:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 681012C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623627883; bh=d1TtPFBTK4Qk5H6nv24+5P0QvXYMUJpqAJ7Mpv3BtHw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=X8iQ7/0XXxASHlaRjqQ4h62Z7Yy9P3F9zgCKF/E76XoYblogvs4JB3nQy0I+g684D
         8Kc6NfAA0BylGwRaFdKMWzIC1U4eM/fqCBqjvEc0K4cJLbSKDpq1t5rjgIFkuKh3u3
         7btx8SLM/UtyTRGopJYGBonauP603D6IMnAN2rEkkq7rsXaOpZGfyO6vb+SIh8MvCg
         luuAP1oYSpnVRltt2HUYN4ZqTh4GuVyH5WHXTXJrQSK/4MqQBE4M1Oddh0syjjEkTS
         1J2egGP+Q3W6Hwy9G5itypQGBfUTSuequ2UND6wOUllgPVUelqPJiZqtUgbr1cx0vW
         W/80aoqo9Jzfw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "H. Peter Anvin" <hpa@zytor.com>, vgoyal@redhat.com,
        x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
        dyoung@redhat.com
Subject: Re: [PATCH v3] Documentation: kdump: update kdump guide
In-Reply-To: <878s3dbbuz.fsf@meer.lwn.net>
References: <20210609083218.GB591017@MiWiFi-R3L-srv>
 <878s3dbbuz.fsf@meer.lwn.net>
Date:   Sun, 13 Jun 2021 17:44:42 -0600
Message-ID: <87sg1l9vo5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> Baoquan He <bhe@redhat.com> writes:
>
>> Some parts of the guide are aged, hence need be updated.
>>
>> 1) The backup area of the 1st 640K on X86_64 has been removed
>>    by below commits, update the description accordingly.
>>
>>    commit 7c321eb2b843 ("x86/kdump: Remove the backup region handling")
>>    commit 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
>>
>> 2) Sort out the descripiton of "crashkernel syntax" part.
>>
>> 3) And some other minor cleanups.
>>
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>
> Applied, thanks.

Actually, this patch added a docs build warning:

  /stuff/k/git/kernel/Documentation/admin-guide/kdump/kdump.rst:286: WARNING: Literal block ends without a blank line; unexpected unindent.

I've gone ahead and inserted the blank line to fix this.  In the future,
please build-test your changes to make sure that you are not adding new
warnings.

Thanks,

jon
