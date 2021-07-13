Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544F33C7960
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 00:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhGMWJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 18:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbhGMWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 18:09:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD56C0613DD;
        Tue, 13 Jul 2021 15:06:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r11so575006wro.9;
        Tue, 13 Jul 2021 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/3zV46goqXUufTjHSFOtqe+Hqag8yZnkCH1OaEMysKQ=;
        b=n0QPSF25EsEC1AeBM4B9dxXPcvnK+2gVjFLBEDJdhtKh3H0hxOQDU932QyNeo/XCS1
         YgRVvfNZcsJ2kQWIlj8/qj7DCRYvjmIGurOR5ZoxRQwXNpbSA3bfeCf86C9lfoEefQRz
         CgWULPNnt47FPuNc7X2BOTR75gJeZCp2j7Vhb1IyLbNYI3q9SjEzPy7zvzo7ToKaVGUi
         XuU2XkBi2kdSbR3qWIdHmEd1yWiHTZGRGsf4nq8vAKDvSgQy9/Qe9Xrs8qKuVHaNYq19
         l6+aH9wiN51yayOMJiT7p4keA/7z6IYW9hwenUvtFZcIgJsCr0Wei+Xe25XOlIbVeCZx
         BcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/3zV46goqXUufTjHSFOtqe+Hqag8yZnkCH1OaEMysKQ=;
        b=dxGaAqY1LMSAfeqI4pCj1JAdp27QrBP+PmvB1uHga00Dzk/8aj709Z4kINUwLBe5p0
         axRfmUPgdk8YskdFJZ0hoYEwV8vjgOm1gfJ6Vj/Hr4amADo30QsYTr31zmpO0xkhVsdK
         PvdWjcXkS6wK/RkWtoULMv2J72srd3tlyHRuN+tpFhmm4epRMqmUOvAT1v1zeIqB4uDl
         q2+kDIhbb6bTReAXPWa7GKxaDGtQ2cmBe3Toub/7Wi7T6LgHylr0dyHGw+V3eSQF8EgZ
         BDWcbU1JGKEvJPFCbH106tMIV29p39KZSzLaeo1ZrDRl+/XT69n7IeMBfEBc6/lSkiH6
         1sXQ==
X-Gm-Message-State: AOAM532BpkyiLACyPiHfJC/72wsZIzzBTG2SeSPqSh81igFVZjSyZ4zQ
        MIPiV1gJBq3koBjgOy6D6xM=
X-Google-Smtp-Source: ABdhPJw/JkqZaExSL3QACAADMzVi5VIANMS8RRK6A99eHr3IY7iRN17vaZD8XqKWQnhydt9RvyUi5Q==
X-Received: by 2002:a5d:6506:: with SMTP id x6mr8326125wru.86.1626214003069;
        Tue, 13 Jul 2021 15:06:43 -0700 (PDT)
Received: from [192.168.1.211] ([2.29.20.111])
        by smtp.gmail.com with ESMTPSA id s1sm3517330wmj.8.2021.07.13.15.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 15:06:42 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kieran.bingham@ideasonboard.com
References: <20210708224226.457224-1-djrscally@gmail.com>
 <20210709170426.GC4112@sirena.org.uk>
 <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
 <20210712124223.GB4435@sirena.org.uk>
 <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk>
 <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
Message-ID: <94cbb11d-c697-44cf-75e3-6c7c4789cc94@gmail.com>
Date:   Tue, 13 Jul 2021 23:06:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713152454.GC4098@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On 13/07/2021 16:24, Mark Brown wrote:
> On Tue, Jul 13, 2021 at 12:32:26AM +0100, Daniel Scally wrote:
>
>> I do think it can simplify driver code too; a lot of them aren't written
>> to parse platform data to get the init data, as they're just relying on
>> reading it from devicetree so in the event that we get more cases like
>> this, we need to modify those drivers to look for platform data too. On
>> the other hand, even the drivers that don't directly call
>> of_get_regulator_init_data() still do that lookup during the
>> regulator_of_get_init_data() call in regulator_register(), so the ones
>> that do parse platform data for init_data structs will check DT as part
>> of regulator_register() anyway. Imitating that seems simpler to me.
> The driver code is trivial boilerplate, assuming someone doesn't go and
> implement a helper to register stuff separately like I suggested.  The
> proposed swnode stuff would involve duplicating the DT parsing code.
> This seems like a whole lot of effort for something that provides a
> worse result than either of the existing things.


Alright - let me look at adding a helper to register them instead then.

>> It also creates some problems to suppress the enumeration of the i2c
>> device via ACPI (which we'll have to do in a machine specific fashion,
>> because some laptops have this chip with properly configured ACPI and
> To be clear I think that's a terrible idea.


Me too. I thought you were suggesting that I do that - sorry to have
misunderstood there. The problem we're trying to resolve here is kinda
exacerbated by a lot non-standard stuff within the ACPI for these
devices, so for example, on top of not having any power management AML
(which is what I'm trying to fix up here), the ACPI device can actually
represent a bunch of different things that might be a TPS68470 PMIC, a
different PMIC entirely or even not a physical PMIC at all, but rather
just a convenient dummy device to collect a bunch of GPIOs under. Which
one it is is revealed by parsing a buffer out of the device's ACPI, so
we need the ACPI enumeration to be able to use that properly.


Part of the reasons I went with addressing this with software nodes is
that we've used them to correct other deficiencies in the ACPI on the
same devices, like the references between the cameras and the image
signal processor ought to be described in _DSD packages [1], but are
again just hidden inside a buffer that we need to parse to figure out
the right way to make the connection, and then we used software nodes to
represent that. The difference there is that that's implementing
something that should have been there in the first place, whereas the
regulators wouldn't ordinarily be described in this way.

>>> down to being another data table, I imagine you could write a helper for
>>> it, or probably even come up with some generic thing that let you
>>> register a platform data/DMI combo independently of the driver to get it
>>> out of the driver code (looking more like the existing GPIO code which
>>> is already being used in another bit of this quirking).
>> The advantage of the GPIO lookups is there's no need to have the pointer
>> to the registered devices to register the lookup table; we could imitate
>> that, by adding entries to a list with the lookup values being device
>> and regulator name (with the init data as the thing that's "looked up")
>> and check for those during regulator_register() maybe?
> Like I keep saying I think that's a much better approach than trying to
> use swnodes, they just seem like a terrible fit for the problem.


Okedokey; I'm happy to take another look at it from this angle then -
thanks for the feedback.


[1]
https://www.kernel.org/doc/html/latest/firmware-guide/acpi/dsd/graph.html

