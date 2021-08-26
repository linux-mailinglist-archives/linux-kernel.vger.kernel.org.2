Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692823F8DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243092AbhHZSLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:11:33 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:36013 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhHZSLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:11:32 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2021 14:11:32 EDT
Received: from [87.92.210.171] (helo=[192.168.0.111])
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <lumip@lumip.de>)
        id 1mJJex-00012i-LY; Thu, 26 Aug 2021 19:59:27 +0200
Subject: Re: [PATCH] drivers/cdrom: improved ioctl for media change detection
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org
References: <20210805194417.12439-1-lumip@lumip.de>
From:   Lukas Prediger <lumip@lumip.de>
Message-ID: <dc87e72b-4eea-a055-1da9-fe6e6c08a2e3@lumip.de>
Date:   Thu, 26 Aug 2021 21:01:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210805194417.12439-1-lumip@lumip.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Df-Sender: bHVrYXMucHJlZGlnZXJAbHVtaXAuZGU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.21 22:44, Lukas Prediger wrote:
> The current implementation of the CDROM_MEDIA_CHANGED ioctl relies on
> global state, meaning that only one process can detect a disc change
> while the ioctl call will return 0 for other calling processes afterwards
> (see bug 213267 ).
>
> This introduces a new cdrom ioctl, CDROM_TIMED_MEDIA_CHANGE, that
> works by maintaining a timestamp of the last detected disc change instead
> of a boolean flag: Processes calling this ioctl command can provide
> a timestamp of the last disc change known to them and receive
> an indication whether the disc was changed since then and the updated
> timestamp.
>
> I considered fixing the buggy behavior in the original
> CDROM_MEDIA_CHANGED ioctl but that would require maintaining state
> for each calling process in the kernel, which seems like a worse
> solution than introducing this new ioctl.
>
> Signed-off-by: Lukas Prediger <lumip@lumip.de>
> ---
> This is my first patch sent to the kernel and I followed the recommended
> process as closely as I could. If I misstepped somewhere, please let me know.
> I also tried to find a mailing list more specific to the problem but was unable,
> please inform me if there is one where this should be sent instead.
>
> Finally, I wasn't sure whether/how to add my name to the updated docs
> and if I should update the date on them (there have been some recent commits
> that did not result in credits given to the commit author or updating
> the dates in the docs, but those did not add any new content either), so
> info in the most appropriate way would be welcome.
>
> Looking forward to your feedback.
> ---
>  Documentation/cdrom/cdrom-standard.rst      | 14 +++++-
>  Documentation/userspace-api/ioctl/cdrom.rst |  6 ++-
>  drivers/cdrom/cdrom.c                       | 56 +++++++++++++++++++--
>  include/linux/cdrom.h                       |  1 +
>  include/uapi/linux/cdrom.h                  | 15 ++++++
>  5 files changed, 86 insertions(+), 6 deletions(-)

As it has been several weeks and I haven't heard anything at all in response to this, 
I'd like to bring this to your attention once more. If something is wrong with it,
please let me know so I can fix it.
- Lukas

