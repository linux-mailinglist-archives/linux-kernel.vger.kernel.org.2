Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700F53C66FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 01:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhGLXfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 19:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhGLXfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 19:35:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB213C0613DD;
        Mon, 12 Jul 2021 16:32:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t5so14048359wrw.12;
        Mon, 12 Jul 2021 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=skQTf76+KZWpfJiuSHaTlzIOsmAn2wOgi37uHtRMK1I=;
        b=WD8287PkNJkQwO7gqHOB8r7bbjdKSy+2JuF2vz4woiGFv/ZcuI4S1inUqYH5eEaVfC
         YH0n38e1b/QcR7xxgOBO19TIzhOLU4W7M+NFAsPe7elJwqz0Lv3AzvVQEIMRS7hx5s/q
         dnF6HwUiPUYqexGvJ+TdSAXaKuyUpw1LdbeP9pJXc+JrCXiMzJMsAK2JDKfqq78YbzO1
         wW1fRoFfGeZ56wGLXar6jHI6LV8jkvM406j26h94gSA39HeK2WcrOK1F5txyuVV0mgbv
         nD5aUdaeXqnDmHvVtc5XSWyDqimX/BTbblEyibX3DeYKZujgUztsM92IKbt1yRteD9SB
         SakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=skQTf76+KZWpfJiuSHaTlzIOsmAn2wOgi37uHtRMK1I=;
        b=ly6DoE5nRc3Mhmw9HrkgMbpzhC40GyiPKsYIvfzFayS3GQ2yC++qmjy/p8y9U0qP6q
         hOxCAAbGTEDRQsUcHeM7t3yn/FlXNpfISbLFhaVU3DJgmC/kmcuMk1eAgrleV+2TaQoP
         m+6V/be0St3PV/cxNTLp7hWR5ZbMkvmOVid49OWRaxa6EfHCnFNaw/iVZdc09/EsoR6Q
         YhXFtmyrZUzLSrNvGDRy5fE5zWSk8TH7CeL0x99ui4ARQq7LOqEnWI4abWsTY3aoVZZZ
         f/4D9WMK3LHpDbD2bC/VZGoS9czVQI0OTyBCo89u83meukknaL4kRkyNCVUySTx2tC6n
         ZDwg==
X-Gm-Message-State: AOAM532PM/o4B2fnN8YHCp7k9dvQYtq1cm00Dk+XEk+les9esE0M5jtB
        HPOijZZoDVA32lPLSoLqLXo=
X-Google-Smtp-Source: ABdhPJyrVyLRC/IYIcycBqiBWk64XGyUpKtBvaR8/RkXIPMa/L0KkGCeHnMRxUNwRVZ4Q6qLEqwoHw==
X-Received: by 2002:a5d:4252:: with SMTP id s18mr1775152wrr.88.1626132747286;
        Mon, 12 Jul 2021 16:32:27 -0700 (PDT)
Received: from [192.168.1.211] ([2.29.20.111])
        by smtp.gmail.com with ESMTPSA id j12sm16500752wrq.83.2021.07.12.16.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 16:32:26 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
Date:   Tue, 13 Jul 2021 00:32:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712170120.GG4435@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark - sorry for the late reply.

On 12/07/2021 18:01, Mark Brown wrote:
> On Mon, Jul 12, 2021 at 07:08:23PM +0300, Andy Shevchenko wrote:
>> On Mon, Jul 12, 2021 at 4:35 PM Mark Brown <broonie@kernel.org> wrote:
>>> But why?  I'm not seeing the advantage over providing platform data
>>> based on DMI quirks here, it seems like a bunch of work for no reason.
>> What do you mean by additional work? It's exactly opposite since most
>> of the drivers in the kernel are using the fwnode interface rather
>> than platform data. Why should we _add_ the specific platform data
>> handling code in the certain drivers instead of not touching them at
>> all?
> It's adding an entirely new representation of standard data with less
> validation support than either DT or platform data which seems like a
> needlessly roundabout and error prone way of moving the data about with
> less tooling support.  As far as I can tell the only advantage is that
> it lets you write the quirk in a different source file but I'm finding
> it hard to get excited about that.


I do think it can simplify driver code too; a lot of them aren't written
to parse platform data to get the init data, as they're just relying on
reading it from devicetree so in the event that we get more cases like
this, we need to modify those drivers to look for platform data too. On
the other hand, even the drivers that don't directly call
of_get_regulator_init_data() still do that lookup during the
regulator_of_get_init_data() call in regulator_register(), so the ones
that do parse platform data for init_data structs will check DT as part
of regulator_register() anyway. Imitating that seems simpler to me.


It also creates some problems to suppress the enumeration of the i2c
device via ACPI (which we'll have to do in a machine specific fashion,
because some laptops have this chip with properly configured ACPI and
thus work fine as-is) to re-enumerate it in a board file with the
platform data; the ACPI methods and buffers are used by the i2c device's
driver; there's a bunch of regrettably non-standards-compliant
information in there that we need to check to make sure we do things
properly.


I take the point about this being error-prone lacking tooling support -
happy to work on this as much as needed to alleviate your concerns if we
decide to proceed down this route.


> If we were fixing up an existing
> ACPI binding or something this approach would make sense to me but it's
> making something entirely new out of whole cloth here.
>
> We already have generic platform data support for the regulator API so
> driver modifications would just be the DMI matching which is going to
> have to happen somewhere anyway, I don't see a huge win from putting
> them in one file rather than another.  It should basically just boil
> down to being another data table, I imagine you could write a helper for
> it, or probably even come up with some generic thing that let you
> register a platform data/DMI combo independently of the driver to get it
> out of the driver code (looking more like the existing GPIO code which
> is already being used in another bit of this quirking).
>
> It feels like this should be making more use of existing stuff than it
> is.  If you look at what the core part of the code does it's taking data
> which was provided by one part of the kernel in one set of C structs and
> parsing those into a struct init_data which is what the core actually
> wants to consume.  This seems like an entirely redundant process, we
> should be able to just write the machine configuration into some struct
> init_datas and get that associated with the regulators without creating
> an otherwise entirely unused intermediate representation of the data.

The advantage of the GPIO lookups is there's no need to have the pointer
to the registered devices to register the lookup table; we could imitate
that, by adding entries to a list with the lookup values being device
and regulator name (with the init data as the thing that's "looked up")
and check for those during regulator_register() maybe?
