Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C579331C6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 08:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBPHY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 02:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBPHYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 02:24:53 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45756C061786;
        Mon, 15 Feb 2021 23:24:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a207so254408wmd.1;
        Mon, 15 Feb 2021 23:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=sRDmRmADnK14Ei7lPvcCisHMhimr2FPvvEmmD2IGxDA=;
        b=A1OKH7aaTovsMb0GL6Gt/wQPEn7PrqBBMO/r9+VnNPXkglG8wZJedlO3EC1aWaJL1Q
         yBxxw1mBlPJ/AwJ7tosC71B9ncS3i+ky3iEJMwcxipSd7nhiYx+qWrGfJkfegA/GNIDn
         Li9EY5LEO9DR2BcD1cZgqz1GSOzyNFx7W5fIcZ8tZCwx3R7yBZRruEa72Xm9Lm406wwZ
         T2LGIoqsHinUi0RETf3DP2T8knxRc/QCEVF+jofnjz0hfYIxp+iz0pQhHyP0aQLwCPEK
         8GM4Ye2wXHz8Gv3/eE1A2S5WMWlgGis0Q8OTLtFMIYMuwuUoMuonzTsYH3MW7Im15SkH
         bhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sRDmRmADnK14Ei7lPvcCisHMhimr2FPvvEmmD2IGxDA=;
        b=OHILlfEZq1jgri2DULnMmgSiKac+xRcruRPSVTq+a8j6hCfB7GMHzWYdbiuuby+J0s
         ZAyYJIwG9CKgPYa4XjWFbtyC1RZ9kTH5KsHAUztMUuFdTQAbCXbEwfKIegW8CHAAoknE
         rsMEHx4XzF7HU7VEj9UeI2PErBqrc45mPB8uSxmie/ifXVjl2BsmuhR3fcMaZVz6LHPK
         hlaiqkg5q1epSONVGVYggTOJ3C/boVe4DMcwxcgQp0zr3xLCdJznFaX2yMM/4IGmz4zF
         9c2xU9vruC+wY+p9QWLOjkmuGD7Ge9ztHiJmFQROxUHdPxxPP+9zmZic5fes3iKgOlhY
         4wnw==
X-Gm-Message-State: AOAM531w0+9bRSInejCYtGd8lup2MHtD0+iP0A67gQodka2rhQiqPtTb
        lRUY7cKmELbTtj+Uhq3jHiQ=
X-Google-Smtp-Source: ABdhPJwDUpM3PdCcKwY1Iz6pYy6B7kpXx1ZTx+HHZECssFd37scHCf07v95w9lV7LfETI7FU4spdgw==
X-Received: by 2002:a1c:9a12:: with SMTP id c18mr2002949wme.146.1613460251882;
        Mon, 15 Feb 2021 23:24:11 -0800 (PST)
Received: from [0.0.0.0] ([2a01:4f8:c17:e10a::1])
        by smtp.gmail.com with ESMTPSA id v15sm29214125wra.61.2021.02.15.23.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 23:24:11 -0800 (PST)
Subject: Re: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Perry Yuan <Perry.Yuan@dell.com>
Cc:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Limonciello Mario <Mario.Limonciello@dell.com>
References: <20201228132855.17544-1-Perry_Yuan@Dell.com>
 <mXtNUreCVsPKizG-fnNKPId9_lQGit0S6pYEpk-aNT1hGQjVwblZDiO4E-YX3hxnrbbNN1-6hSntiv13wz66RxbhXjPJhpAVOIlZmmwUI7w=@protonmail.com>
 <7def1cdc-e275-9ae6-4941-55517359bb1e@gmail.com>
 <ce598a92-73ef-e9a6-d772-59f5da3d251e@redhat.com>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <facc6270-1e04-b348-a1be-a97f87870c46@gmail.com>
Date:   Tue, 16 Feb 2021 15:24:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <ce598a92-73ef-e9a6-d772-59f5da3d251e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans:

On 2021/1/13 2:37, Hans de Goede wrote:
> Hi,
> 
> I know there already is a v3 out and I will try to get around to reviewing
> that soon, still 1 remark about the discussion surrounding v2:
> 
> On 1/11/21 2:42 PM, Perry Yuan wrote:
> 
> <snip>
> 
>>>> *The flow is like this:
>>>> 1) User presses key. HW does stuff with this key (timeout is started)
>>>> 2) Event is emitted from FW
>>>> 3) Event received by dell-privacy
>>>> 4) KEY_MICMUTE emitted from dell-privacy
>>>> 5) Userland picks up key and modifies kcontrol for SW mute
>>>> 6) Codec kernel driver catches and calls ledtrig_audio_set, like this:
>>>> 	ledtrig_audio_set(LED_AUDIO_MICMUTE,
>>>> 		rt715->micmute_led ? LED_ON :LED_OFF);
>>>> 7) If "LED" is set to on dell-privacy notifies ec,
>>>>    and timeout is cancelled,HW mic mute activated.
>>>>
>>> Please proofread the commit message again, and pay attention to capitalization
>>> and spacing.
>> I want to reformat it and move the commit info to cover letter.
> 
> Please also put a copy of this as a comment in either the wmi or the
> acpi driver (with a comment pointing to the comment in the other) this is
> important info to have for someone reading the code and trying to understand
> how this all fits together.
> 
> Regards,
> 
> Hans
> 
Hans.
I have added the comments to the dell-privacy  driver file in V4

-----------------------------------------------------------------------------------
drivers/platform/x86/dell-privacy-wmi.c

EXPORT_SYMBOL_GPL(dell_privacy_valid);
/*
  * The flow of privacy event:
  * 1) User presses key. HW does stuff with this key (timeout is started)
  * 2) WMI event is emitted from BIOS
  * 3) WMI event is received by dell-privacy
  * 4) KEY_MICMUTE emitted from dell-privacy
  * 5) Userland picks up key and modifies kcontrol for SW mute
  * 6) Codec kernel driver catches and calls ledtrig_audio_set defined by
  *    dell-privacy-acpi driver.
  *    codec driver will call like this to switch micmute led state.
  *      ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led ? LED_ON 
:LED_OFF);
  * 7) If "LED" is set to on dell-privacy notifies EC,and timeout is 
cancelled,
  *      HW mic mute activated.
  */
void dell_privacy_process_event(int type, int code, int status)
{
         struct privacy_wmi_data *priv;
         const struct key_entry *key;

         mutex_lock(&list_mutex);
....

-----------------------------------------------------------------------------------
drivers/platform/x86/dell-privacy-acpi.c

/*
  * Pressing the mute key activates a time delayed circuit to physically cut
  * off the mute. The LED is in the same circuit, so it reflects the true
  * state of the HW mute.  The reason for the EC "ack" is so that software
  * can first invoke a SW mute before the HW circuit is cut off.  Without SW
  * cutting this off first does not affect the time delayed muting or status
  * of the LED but there is a possibility of a "popping" noise.
  *
  * If the EC receives the SW ack, the circuit will be activated before the
  * delay completed.
  *
  * Exposing as an LED device allows the codec drivers notification path to
  * EC ACK to work
  */
static int dell_privacy_leds_setup(struct device *dev)
{
         struct privacy_acpi_priv *priv = dev_get_drvdata(dev);
         int ret = 0;

.....
