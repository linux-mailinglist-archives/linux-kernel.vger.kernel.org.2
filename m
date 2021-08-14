Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB983EC279
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 13:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbhHNLqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 07:46:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55939 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238185AbhHNLqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 07:46:53 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 156C05C00E3;
        Sat, 14 Aug 2021 07:46:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 14 Aug 2021 07:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QzUIRd
        aYTQ9jmi1Wxf/eLSw7zIX+FKz+RZjpUwwoIZY=; b=mbnrw8GiRS19Go/KzCOsdQ
        eV13re8IxqaGsI+bAyAsaaUkIrfrhdikb+ZsJOv9Th3CspqsTE2GDAMhC47dSOQV
        +da40QCjXu/2QBLJyYlxCdPY3mCDU7E4OhQ/0CXZaEOT7N1iSOsIQYV4GU5FWzmO
        m0EJ1Sb0zgzH9e9r3DEVKDbaAd8t5CkJlOtW0eaRUaHWa9/wgYCjAV7qX4vinfyr
        +kvcukdUH5xL4VvqXEVnG/CYHmnDn8qLouSjUzvrO57cHnlh9IdcjWi7W2KfxTh+
        cCRW8jmKlcPqNZ4EXLrIXJ6h+Rc1y3OpMnHr2kOKcWAQZ50UzbBQnPxn7T7+UpTg
        ==
X-ME-Sender: <xms:EK0XYQZbrhq0m21uyBNG_VAwyDlWsOg57-SKR3m8C3onOq2OXz2XmQ>
    <xme:EK0XYbZBgmeNeirPUozN6fRrH6i-VINgwnLJIBKHpSk0ses9PFpzf_zdzr99ijr3d
    dTnzw0sUzQgGBNfynM>
X-ME-Received: <xmr:EK0XYa_Wp3jiudO3BUck3YX6eSdcbFcDnr6K_070YDTG4U4HXjj5B4wFnGZ0O4PHBTxrZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeejgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffuvffkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgvucfl
    ohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgf
    effedufffhgfeuheegffffgeegveeifeeutefhieejffetudfgueevteehtdetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljh
    honhgvshdruggvvh
X-ME-Proxy: <xmx:EK0XYaoOjxoHKKb-Wg-Y7GlZ5op4AX0aOtUvI3KM-tSDz4I6pDtGLg>
    <xmx:EK0XYbq-EQNCD7BezRkuyWH8gANrkZKWww9xpVhSERTrfbW50d1ALg>
    <xmx:EK0XYYTtR-DoDDThOrKCSH0dBMTsTawtajN9qQiaQyoVSrJK8IMK0w>
    <xmx:Ea0XYS0pbD6EhTqi5Dss1eSpAWo-SLCYXlSrUrFx16w3EXqRS6nfMg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Aug 2021 07:46:20 -0400 (EDT)
Date:   Sat, 14 Aug 2021 23:46:06 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v3 1/1] asus-wmi: Add support for platform_profile
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Message-Id: <UCVTXQ.8ME64G0S1BQ8@ljones.dev>
In-Reply-To: <CAHp75VcCzjb7TKZ84iVjJr27+nCcA10n38nwCAGATucfAAMkKA@mail.gmail.com>
References: <20210814043103.2535842-1-luke@ljones.dev>
        <20210814043103.2535842-2-luke@ljones.dev>
        <CAHp75VcCzjb7TKZ84iVjJr27+nCcA10n38nwCAGATucfAAMkKA@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy, thanks for the feedback. All is addressed, and some inline 
comment/reply. New version incoming pending pr_info() vs dev_info()

On Sat, Aug 14 2021 at 12:40:39 +0300, Andy Shevchenko 
<andy.shevchenko@gmail.com> wrote:
> On Sat, Aug 14, 2021 at 7:33 AM Luke D. Jones <luke@ljones.dev> wrote:
>> 
>>  Add initial support for platform_profile where the support is
>>  based on availability of ASUS_THROTTLE_THERMAL_POLICY.
>> 
>>  Because throttle_thermal_policy is used by platform_profile and is
>>  writeable separately to platform_profile any userspace changes to
>>  throttle_thermal_policy need to notify platform_profile.
>> 
>>  In future throttle_thermal_policy sysfs should be removed so that
>>  only one method controls the laptop power profile.
> 
> Some comments below.
> 
> ...
> 
>>  +       /*
>>  +        * Ensure that platform_profile updates userspace with the 
>> change to ensure
>>  +        * that platform_profile and throttle_thermal_policy_mode 
>> are in sync
> 
> Missed period here and in other multi-line comments.
> 
>>  +        */
> 
> ...
> 
>>  +       /* All possible toggles like throttle_thermal_policy here */
>>  +       if (asus->throttle_thermal_policy_available) {
>>  +               tp = asus->throttle_thermal_policy_mode;
>>  +       } else {
>>  +               return -1;
>>  +       }
>>  +
>>  +       if (tp < 0)
>>  +               return tp;
> 
> This will be better in a form
> 
>     if (!..._available)
>         return -ENODATA; // what -1 means?
> 

I wasn't sure what the best return was here. On your suggestion I've 
changed to ENODATA

>     tp = ...;
>     if (tp < 0)
>         return tp;
> 
> ...
> 
>>  +       /* All possible toggles like throttle_thermal_policy here */
>>  +       if (!asus->throttle_thermal_policy_available) {
>>  +               return -1;
> 
> See above.
> 
>>  +       }
> 
> ...
> 
>>  +       if (asus->throttle_thermal_policy_available) {
>>  +               pr_info("Using throttle_thermal_policy for 
>> platform_profile support\n");
> 
> Why pr_*()?

That seemed to be the convention? I see there is also dev_info(), so 
I've switched to that as it seems more appropriate.

> 
>>  +       } else {
>>  +               /*
>>  +                * Not an error if a component platform_profile 
>> relies on is unavailable
>>  +                * so early return, skipping the setup of 
>> platform_profile.
>>  +               */
>>  +               return 0;
> 
> Do it other way around,
> 
> /*
>  * Comment
>  */
> if (!...)
>   return 0;

Thanks, I think I was transliterating thought process to code as I went 
along.
All updated now.

> 
>>  +       }
> 
> 
> --
> With Best Regards,
> Andy Shevchenko


