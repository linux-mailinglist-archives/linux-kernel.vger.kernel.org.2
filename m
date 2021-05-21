Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFAB38C50C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhEUKi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:38:29 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:57065 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhEUKi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:38:27 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id A9B641295;
        Fri, 21 May 2021 06:37:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 21 May 2021 06:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=UlAe4z
        MIKSC/bAu2xgDnm+7npvQPlo6QgeBHh4q7ikA=; b=U/nas5MDI7cVPqRMG8PSbz
        bWa5vFII86xbinPXENT5qWvt54kex4N7cQW9kmvWFg72LRCt+5IjRV0BxZkabhV/
        P5tI1Iks8AnLgVjB4JA9x8Wa643XlmMl+xIklrwSfGQf3TBwIoeK1Xg/zFzsI3Xw
        Dm4FtBOxIOnSOFheMbdzJSF18kiJ+OyGhxRsJYoVaDsdiYsGwSyy2EBW/OQwlSMR
        5tjdirFn7l6vGCNLLvNg5cwTrsOmFvb8lSTSmMUP0ZUTaOFwURlQE5e40nZ/IyqA
        SMLv9VaRUzV7b6RJQfzztjrEXcR+BZe9bnC/TgqZlDoDWgzLkxPLpjLOxNlWylng
        ==
X-ME-Sender: <xms:T42nYJnVYOsGpVQQeJuAvJGTyi9oGkHI5ywrPV8c-dco0UZ3L2_8cA>
    <xme:T42nYE2EJBcGI4hOZ-sY7cWBUyBkd5sGWJrIMmQJD_48QIBu70GIO55CMpI_bNgbJ
    MAr8SpGbE0aXtAl4AU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejfedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    egfeegudekfeeiledugefhgfffhfeifedugfegtdffieeuvedvgfffvdejueejhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduudeirddvhedurdduleefrddule
    einecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhu
    khgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:T42nYPraxV2wcynHzGglu3-u31E7Ptu1uS4M5LIkv9ixLWrUS-czLw>
    <xmx:T42nYJlEVp9fw6aQNPnnMNKZKBenUuG7XA5ayYKDPq29AkHIW6-6gA>
    <xmx:T42nYH1vrIAoMOOU9sZbPEdK_dSujCJTlaNAihVV8OqQaOotGpVczQ>
    <xmx:T42nYA_qLSsmbHJqzFXhTsenA70BKtvwYwVThogoWY-PZ9ti36bFLQ>
Received: from [192.168.20.39] (unknown [116.251.193.196])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri, 21 May 2021 06:36:57 -0400 (EDT)
Date:   Fri, 21 May 2021 22:36:42 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 0/2] Remove GA14/15 quirks to acpi/video_detect
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <6HDGTQ.I5W09JQ0U6UN@ljones.dev>
In-Reply-To: <3559f449-7d43-bf6f-0047-3138fd303db8@redhat.com>
References: <20210419074915.393433-1-luke@ljones.dev>
        <3559f449-7d43-bf6f-0047-3138fd303db8@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, thanks Hans. I wasn't sure how a git revert was meant to work and 
assumed that
whatever git did was fine.

I am absolutely happy for you to take care of those issues and push 
ahead.

Many thanks!

On Fri, May 21 2021 at 12:24:13 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi Luke,
> 
> On 4/19/21 9:49 AM, Luke D. Jones wrote:
>>  Revert two commits to allow a patch to acpi/video_detect to 
>> correctly
>>  set the backlight control as native.
>> 
>>  Luke D. Jones (2):
>>    Revert "platform/x86: asus-nb-wmi: Drop duplicate DMI quirk
>>      structures"
>>    Revert "platform/x86: asus-nb-wmi: add support for ASUS ROG 
>> Zephyrus
>>      G14 and G15"
> 
> Thank you, since the matching drivers/acpi/video_detect.c have been 
> merged
> by Rafael, I've added these to my review-hans branch now.
> 
> But there is one problem, these miss a:
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> 
> In their commit message, I assume this was an oversight, so I've added
> this. If you can let me know if this is ok, then I can push these to
> for-next.
> 
> I've also rewritten the commit messages to explain why things are 
> being
> reverted, see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Regards,
> 
> Hans
> 


