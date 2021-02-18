Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3584931F1C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 22:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBRVkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 16:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBRVkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 16:40:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0D1764EB7;
        Thu, 18 Feb 2021 21:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613684366;
        bh=DJm1sF8L/UWTYmsGGYdpOJy0Yb94Rp1CFhtm2FM19rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OnHIZYKwoLvPMJ/O2JklXCi6YouZzUpWiv4kd3p4Rg0TzmXn7GMpC0Ej96vbYJtMO
         zfnP5B+ViK+X+g0WnlGdhyghzbGspP8iUAckvizSS1BIcWIdFyMEMU/N84x9Lp+pJt
         MGLACLXVG4ED21slsflYWFW26b01Mr42NLoi0Jfyasnbyeea7KTCD++oy4mFkQQzrr
         vN9HoggRnhTBlu1RsZNMjXOunx+kkAd7vxK/dsQS0sgQN/+3x/RZPWtcb9iggKHSlM
         wBovUjWrFuRa3MMYG3gKMmeCT2y+aFQJ8r2sOQvVHZiOijtBE4kC/YnKIN4SoGQvlm
         eMWSb1MNKxWyA==
Date:   Thu, 18 Feb 2021 16:39:25 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210218213925.GD2013@sasha-vm>
References: <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <20210218165104.GC2013@sasha-vm>
 <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com>
 <YC6ptKgsMh20tmu6@kroah.com>
 <20210218182050.GB15217@1wt.eu>
 <YC6zq3u2jciI2gyZ@kroah.com>
 <b283eaa5-028f-a3d0-42a1-5b11c48ffe91@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b283eaa5-028f-a3d0-42a1-5b11c48ffe91@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 12:16:50PM -0800, Scott Branden wrote:
>On 2021-02-18 10:36 a.m., Greg Kroah-Hartman wrote:
>> On Thu, Feb 18, 2021 at 07:20:50PM +0100, Willy Tarreau wrote:
>>> On Thu, Feb 18, 2021 at 06:53:56PM +0100, Greg Kroah-Hartman wrote:
>>>> On Thu, Feb 18, 2021 at 09:21:13AM -0800, Florian Fainelli wrote:
>>>>> As a company, we are most likely shooting ourselves in the foot by not
>>>>> having a point of coordination with the Linux Foundation and key people
>>>>> like you, Greg and other participants in the stable kernel.
>>>>
>>>> What does the LF have to do with this?
>>>>
>>>> We are here, on the mailing lists, working with everyone.  Just test the
>>>> -rc releases we make and let us know if they work or not for you, it's
>>>> not a lot of "coordination" needed at all.
>>>>
>>>> Otherwise, if no one is saying that they are going to need these for 6
>>>> years and are willing to use it in their project (i.e. and test it),
>>>> there's no need for us to maintain it for that long, right?
>>>
>>> Greg, please remember I expressed I really need them for slightly more than
>>> 3 years (say 3.5-4) :-) I'm fine with helping a bit more as time permits if
>>> this saves me from having to take over these kernels after you, like in the
>>> past, but I cannot engage on the regularity of my availability.
>>
>> Ok, great!
>>
>> That's one person/company saying they can help out (along with what CIP
>> has been stating.)
>>
>> What about others?  Broadcom started this conversation, odd that they
>> don't seem to want to help out :)
>Greg, I'm sorry but I'm not in a position to provide such a commitment.
>
>My original question arose because the 5.10 kernel is declared as 2 years LTS while older LTS kernels are now 6 years.
>One problem this has created is requests to provide silicon support in an older kernel version (for a new project) rather than starting from a newer kernel version that more properly supports the (silicon and non-silicon) features.

So this sounds like you have boatloads of out-of-tree code and need a
stable kernel to avoid having to rebase that code. This is not why the
LTS trees are around.

For new projects, the easiest route is to upstream your stuff and ship
the latest kernel.

>If all LTS kernels were declared as 3.5-4 years as Willy commented this would solve a few issues.
>6 year LTS kernels would only have a maximum 1 year lifespan over the latest declared LTS kernel.
>Also, many products take a year or more to develop, there isn't any life left in an LTS kernel if it is only 2 years.

Products are supposed to upgrade their kernel. If you released something
with, for example, a 5.4 kernel, doesn't mean you're forever stuck on a
5.4 kernel for that product.

>After 1-3 years of kernel age the relevant parties that want to invest and care about supporting specific kernel versions longer should become apparent and could commit to longer support.  Perhaps you move the burden of 6 years LTS elsewhere to longer term projects.  But, I'm sure many are happy because you continue doing such a great job in a central location, especially those whose product lifespan is around 6 years.

But this is exactly what's happening now: we support LTS kernels for two
years, and after that interested parties can figure it out on their own
if it's worth it for them to keep going.

-- 
Thanks,
Sasha
