Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C0035AB87
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 08:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhDJG4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 02:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDJG4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 02:56:48 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E97C061762;
        Fri,  9 Apr 2021 23:56:34 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so2767138otf.12;
        Fri, 09 Apr 2021 23:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=69v/xKDkKDVCv+vp6CQW+QiOX+E1rN7FFRDWueCafvo=;
        b=Gc4dkBYtifAXKh3RHfECQuQGpi9IQOjQNqARZLHPSrzAP5v2S0mk9s4SP/4tHEpn7u
         O/+nrlFgKT0YSNuvy5x+puqruIK/aA8f2saxzA79KHmiXVeS0ktpEZZ3Cr8Zi4O20QnF
         vpuhISk/WPTxSroMN9cNbMj8X0sOJigy1HmezAo/itXogwvyOOfkoREAFjN4No61goJB
         3sjmlgpJpIbEXSNrzPGcpLkUarariYSHIpv0rv6yuNODkzeGWgC86q+WpSNEBuWhKsF/
         PCp4MMPtC9JLIIab5o4BhS7lt+mWs2gfxcharLizFOb6ZxSm+T4wiRP6KlHQf19cNinS
         xfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=69v/xKDkKDVCv+vp6CQW+QiOX+E1rN7FFRDWueCafvo=;
        b=DMFKLlgw/M/Rv6+RU/rGVpAcsKDxWCSipH8TklbwSxb1iapAUJoRc58aofGO6nhrTk
         XBCuSkc9Vpv+i+eJYKWlzW+vkeVDeS7FKbFj49bIo6WBkaQJxNY0Yb8WQBDAe7Zuzpuz
         gbEYwtqw4ZByQH9CPRan20dyeZk5LswfYJDvMjlQjAlFsgUaf70lJ8QUa5Y2oCZgVivA
         aG+RaaSe2nLS7ToT4pI0XQJ2xoJJWfO6Dx4RWa2NfI5IUqpSCE07T+/se8mQJijv7F2u
         U0nPZkUv1Tx1X/v32I6oOSsNZkSAh0HKidanY7rRq4CrPQOp2BJXxYK9sOg41oUSstFL
         C3xQ==
X-Gm-Message-State: AOAM530H5ZWg1KwsYPGOoNNBZ66wvHyJ3zq7QLbxtqc++yFiZnoMVdR5
        mluh3M0xqHLM9PPMHyJtpCc=
X-Google-Smtp-Source: ABdhPJzcgKWTIsecdEmYCtl4qlXrZrft/c7DTBhj09G08CnyTHtvq6ExnQ20cfgVi0fjlf54xo53tw==
X-Received: by 2002:a9d:bf8:: with SMTP id 111mr6550391oth.306.1618037793451;
        Fri, 09 Apr 2021 23:56:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l26sm1159294otd.21.2021.04.09.23.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 23:56:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] platform/x86: add Gigabyte WMI temperature driver
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
References: <N6sOrC__lJeA1mtEKUtB18DPy9hp5bSjL9rq1TfOXiRE7IAO5aih5oyPEpq-vyqdZZsF4W8FIe-9GWB15lO-3fQlqjWQrMTlTJvqLBBGYOQ=@protonmail.com>
 <20210405204810.339763-1-linux@weissschuh.net>
 <44fbb57c-88ee-62f0-c72c-507cad17eb7d@redhat.com>
 <123d021b-b86b-4356-b234-fb46fa260193@t-8ch.de>
 <6993d257-fdc1-2be6-555d-86c6b8c9d18d@redhat.com>
 <d6cc98f4-1be2-f8bf-0426-58e324fc495b@roeck-us.net>
 <c55b1f8e-24b9-4574-8668-aed64832242b@t-8ch.de>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <b236c75e-43c0-e56d-aed7-153fdc11729c@roeck-us.net>
Date:   Fri, 9 Apr 2021 23:56:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c55b1f8e-24b9-4574-8668-aed64832242b@t-8ch.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 11:02 PM, Thomas Weißschuh wrote:
> On Do, 2021-04-08T08:00-0700, Guenter Roeck wrote:
>> On 4/8/21 2:36 AM, Hans de Goede wrote:
>>> On 4/7/21 9:43 PM, Thomas Weißschuh wrote:
>>>> On Mi, 2021-04-07T17:54+0200, Hans de Goede wrote:
>>> Jean, Guenter,
>>>
>>> Thomas has been working on a WMI driver to expose various motherboard
>>> temperatures on a gigabyte board where the IO-addresses for the it87 chip
>>> are reserved by ACPI. We are discussing how best to deal with this, there
>>> are some ACPI methods to directly access the super-IO registers (with locking
>>> to protect against other ACPI accesses). This reminded me of an idea I had
>>> a while ago to solve a similar issue with an other superIO chip, abstract
>>> the superIO register access-es using some reg_ops struct and allow an ACPI/WMI
>>> driver to provide alternative reg_ops:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=204807#c47
>>>
>>> Do you think this is a good idea (or a bad one)? And would something like that
>>> be acceptable to you ?
>>>
>>
>> The upstream it87 driver is severely out of date. I had an out-of-tree driver
>> with various improvements which I didn't upstream, first because no one was willing
>> to review changes and then because it had deviated too much. I pulled it from
>> public view because I got pounded for not upstreaming it, because people started
>> demanding support (not asking, demanding) for it, and because Gigabyte stopped
>> providing datasheets for the more recent ITE chips and it became effectively
>> unmaintainable.
>>
>> Some ITE chips have issues which can cause system hangs if accessed directly.
>> I put some work to remedy that into the non-upstream driver, but that was all
>> just guesswork. Gigabyte knows about the problem (or so I was told from someone
>> who has an NDA with them), but I didn't get them or ITE to even acknowledge it
>> to me. I even had a support case open with Gigabyte for a while, but all I could
>> get out of them is that they don't support Linux and what I would have to reproduce
>> the problem with Windows for them to provide assistance (even though, again,
>> they knew about it).
>>
>> As for using ACPI locks or WMI to ensure that ACPI leaves the chip alone while
>> the driver accesses chips directly: That is an option, but it has (at least)
>> two problems.
>>
>> First, ACPI access methods are not well documented or standardized. I had tried
>> to find useful means to do that some time ago, but I gave up because each board
>> (even from the same vendor) handles locking and accesses differently. We would
>> end up with lots of board specific code. Coincidentally, that was for ASUS boards
>> and the nct6775 driver.
> 
> At least for all the Gigabyte ACPI tables I have looked at all access is done
> via two-byte "OperationRegion" over the Index/Data addresses, a "Field" with
> two entries for these and an "IndexField" that is actually used to perform the
> accesses.
> As the IndexField is synchronized via "Lock" it should take a lock on the
> OperationRegion itself.
> 
> So I think we should be technically fine with validating these assumption and
> then also taking locks on the OperationRegion.
> 
> If it is reasonable to do so is another question.
> 
You'd still have to validate this for each individual board unless you get
confirmation from Gigabyte that the mechanism is consistent on their boards.
Then you'd have to handle other vendors using it87 chips, and those are
just as close-lipped as Gigabyte. Ultimately it would require acpi match
tables to match the various boards and access methods. I had experimented
with this this a long time ago but gave up on it after concluding that it was
unmaintainable.

>> Second, access through ACPI is only one of the issues. Turns out there are two
>> ITE chips on many of the Gigabyte boards nowadays, and the two chips talk to each
>> other using I2C. My out-of-tree driver tried to remedy that by blocking those
>> accesses while the driver used the chip, but, again, without Gigabyte / ITE
>> support this was never a perfect solution, and there was always the risk that
>> the board ended up hanging because that access was blocked for too long.
>> Recent ITE chips solve that problem by providing memory mapped access to the
>> chip registers, but that is only useful if one has a datasheet.
> 
> Are both of these chips available at the two well-known registers 0x2e and
> 0x4e?
> 

The ones I know of are, yes.

Oh, that reminds me, there is another bug. Here are my comments about that:

/*
 * On various Gigabyte AM4 boards (AB350, AX370), the second Super-IO chip
 * (IT8792E) needs to be in configuration mode before accessing the first
 * due to a bug in IT8792E which otherwise results in LPC bus access errors.
 * This needs to be done before accessing the first Super-IO chip since
 * the second chip may have been accessed prior to loading this driver.
 *
 * The problem is also reported to affect IT8795E, which is used on X299 boards
 * and has the same chip ID as IT8792E (0x8733). It also appears to affect
 * systems with IT8790E, which is used on some Z97X-Gaming boards as well as
 * Z87X-OC.
 * DMI entries for those systems will be added as they become available and
 * as the problem is confirmed to affect those boards.
 */

> Would this too-long blocking also occur when only accessing single registers
> for read-only access?

I don't know. Remember, zero support from Gigabyte / ITE.

Guenter
