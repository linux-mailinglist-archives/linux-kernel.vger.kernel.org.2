Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC193EC13E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 09:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhHNHwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 03:52:18 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54191 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236519AbhHNHwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 03:52:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 826F75C00EE;
        Sat, 14 Aug 2021 03:51:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 14 Aug 2021 03:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=r7z4wj
        tS+5cvW6c8Afk88EXJJL+Kwa5QXm4fkgHzNpA=; b=DQF8I0D9YkUUr38GZ9oQ4q
        ZnM6irqRgP7mK5XjC+8vdUT/mEqw38h2aNrXu02nLcBWJihLJpq8GYk+FPwE+ADC
        w6fD+HE0b7SNfxR7/MapTCVBjcfwMc9xs0uESEyhq8jxqnmMJODUnZygmm1GHokx
        u7xhC9J2WASa9DCuaueZrXTy0WCHF6RvCRPO/SkXSvZ1AAuRzEb8SNl7ddjHylK1
        GKP1cb+EM1piQ4yQX4VBXHRHxPsbBquBN901BfLxc3B/2TmxihylKDm4oEZYOeaT
        z1qpJwJYpz81PWmVSzctdFDyM89NM1abMmy5YIN6ik0dKLRYnAtgw03xVX4ZHVaw
        ==
X-ME-Sender: <xms:E3YXYXDgFaD_EUvRULYLLZju8AVEKlVRpUtXTrmFhdZwqZ3fvOLmrw>
    <xme:E3YXYdhLKyANl8RAgRnX8zR_tRRMHLAnnj33BdB4RG94-EAa9zR_p5JvrpJhvsBLz
    78ytdqc9m0ZAFl2I_8>
X-ME-Received: <xmr:E3YXYSmzE8sjMFONtgHC0qaguejrTMyMOSor4tVuhpzM1NnusqfO2NN2ql7cFElUxcKe-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvffkjghfofggtgesthdtre
    dtredtvdenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdr
    uggvvheqnecuggftrfgrthhtvghrnhepgfeffedufffhgfeuheegffffgeegveeifeeute
    fhieejffetudfgueevteehtdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:E3YXYZyKCScxwsJ6OykOqSFZxRrWymnWJvhHK5dveGgBEhSna3XlYw>
    <xmx:E3YXYcTwq31rcRZuqaCHFzn7UYsE6ybFCA0yvPT8pX_FuaH9avbBZA>
    <xmx:E3YXYcY3HGqw9eKvpBNc9mIJH1MIhvmKZiWYa35c0TrEBASL_bQXaw>
    <xmx:FHYXYXLNNP2myXKJld2baGWzmhdshTpG2xLedVb8y0i51IUN60HoGw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Aug 2021 03:51:43 -0400 (EDT)
Date:   Sat, 14 Aug 2021 19:51:29 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v3 0/1] asus-wmi: add platform_profile support
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org
Message-Id: <THKTXQ.ELSNF0TA7RAV1@ljones.dev>
In-Reply-To: <20210814043103.2535842-1-luke@ljones.dev>
References: <20210814043103.2535842-1-luke@ljones.dev>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, Aug 14 2021 at 16:31:02 +1200, Luke D. Jones <luke@ljones.dev> 
wrote:
> Changelog:
> - V2
>   + Correctly unregister from platform_profile if
>     throttle_thermal_policy fails
>   + Do platform_profile_notify() in both 
> throttle_thermal_policy_store()
>     and in throttle_thermal_policy_switch_next()
>   + Remove unnecessary prep for possible fan-boost modes as this
>     doesn't match expected platform_profile behaviour
> - V3
>   + Add missing declaration for err in
>     throttle_thermal_policy_switch_next
> 
> Luke D. Jones (1):
>   asus-wmi: Add support for platform_profile
> 
>  drivers/platform/x86/asus-wmi.c | 139 
> +++++++++++++++++++++++++++++++-
>  1 file changed, 135 insertions(+), 4 deletions(-)
> 
> --
> 2.31.1

Hi,

I teested the patch again and it appears that the 
platform_profile_notify() in both throttle_thermal_policy_store() and 
throttle_thermal_policy_switch_next() updates the 
/sys/firmware/acpi/platform_profile sysfs path fine, but userspace 
isn't updated?

The way I'm checking is:
1. echo 1 |sudo tee 
/sys/devices/platform/asus-nb-wmi/throttle_thermal_policy
2. cat -p /sys/firmware/acpi/platform_profile
   - performance (updated correctly by platform_profile_notify)
3. Check gnome-settings, not updated.

Doing `echo "performance" |sudo tee 
/sys/firmware/acpi/platform_profile` updates both 
throttle_thermal_policy and userspace as expected. I'm wondering if 
I've missed something?

Cheers,
Luke.


