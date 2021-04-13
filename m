Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F278135DCE3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245261AbhDMKym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:54:42 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:48090 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhDMKyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:54:40 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 9D88040006C;
        Tue, 13 Apr 2021 12:54:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1618311258;
        bh=eOy3kxJGgC5rLUKtKBYN3qBf0SMVG8cMtK8TpSSyUlw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=OgPGQEy445mScUqD6w6lPsspEXJQNSPoFmuJu0NUaYBbmwuJsKys6411SnE40oKsG
         nIYhMxKe/mT5ZM3Cu6UbrfTMKPFz1XmLa41Ar2BdDns/gj3xwJv8yXSSp+vQFjJ/cH
         zsF4jc+5zz/lzQ/hMVNKRJ6zBS4d4eSDrpQYX/F3OdUkqfpiex/+6NtPvqRpmnen7F
         EqwqUXh36+OPOcCulWQ8VVgjtN5vHAA9vSErp9gVaLzmj38AZQl8FnJ5JVYb7A+qJS
         KsZTtXKgvpb7pQzAvwPwFqfBWU862eOMtAoZwj1tzvGbS/pm/gsQ3P08FV8hv5OD5o
         fVtEKh3J7Mqfw==
Received: by mail-pg1-f173.google.com with SMTP id j7so2223004pgi.3;
        Tue, 13 Apr 2021 03:54:18 -0700 (PDT)
X-Gm-Message-State: AOAM532ZkHVjZsIhzG1FG18lVr+J+43G3y3G6ZKuJgKhtCQ8uffRb7aT
        s3zRQp5E4Ixhao6wePuGTbi2YenYxgyaJ/nFDAs=
X-Google-Smtp-Source: ABdhPJyOuxyizuIyVvcEsfGU8UVvF3KbzJcbhfBCEPOtF4uvFJMZzGkm4tNE3UYYYLVzLfazR30B2CLPg61qxorbtfg=
X-Received: by 2002:a63:5f0c:: with SMTP id t12mr31315464pgb.381.1618311257278;
 Tue, 13 Apr 2021 03:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210329143833.1047539-1-kubernat@cesnet.cz> <20210409012754.743045-1-kubernat@cesnet.cz>
 <1839a7df-7ceb-8d2b-b618-6d85b0b63a4c@roeck-us.net> <CABKa3npa9vra9jRrrG--3gtun7HtsAVxQvfzsV5rYTQDoDNN9g@mail.gmail.com>
 <78016097-21df-8321-8b8b-33d15a6e6ff2@roeck-us.net>
In-Reply-To: <78016097-21df-8321-8b8b-33d15a6e6ff2@roeck-us.net>
From:   =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Date:   Tue, 13 Apr 2021 12:54:05 +0200
X-Gmail-Original-Message-ID: <CABKa3nqhbnDTsSQc4xgo0gvGR3xeiznJPt_nK-wA_U9aoYXg+w@mail.gmail.com>
Message-ID: <CABKa3nqhbnDTsSQc4xgo0gvGR3xeiznJPt_nK-wA_U9aoYXg+w@mail.gmail.com>
Subject: Re: [PATCH v3] hwmon: Add driver for fsp-3y PSUs and PDUs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 13. 4. 2021 v 7:36 odes=C3=ADlatel Guenter Roeck <linux@roeck-us.ne=
t> napsal:
>
> On 4/12/21 9:31 PM, V=C3=A1clav Kubern=C3=A1t wrote:
> [ ... ]
> > Okay, I have made some additional testing. Some of the registers
> > return 0xFFFF, some don't. These are the ones that pmbus_core queries
> > when the driver is loading (with values I got from
> > i2c_smbus_read_word_data):
> > PMBUS_POUT_MAX 0xFFFF
> > PMBUS_FAN_COMMAND_1 0x0
> > PMBUS_VOUT_OV_FAULT_LIMIT 0xFFFF
> > PMBUS_VOUT_OV_WARN_LIMIT 0xFFFF
> > PMBUS_VOUT_UV_WARN_LIMIT 0xFFFF
> > PMBUS_VOUT_UV_FAULT_LIMIT 0xFFFF
> > PMBUS_IOUT_OC_FAULT_LIMIT 0xFFFF
> > PMBUS_IOUT_OC_WARN_LIMIT 0x10
> > PMBUS_IOUT_UC_FAULT_LIMIT 0xFFFF
> > PMBUS_OT_FAULT_LIMIT 0xFFFF
> > PMBUS_OT_WARN_LIMIT 0xFFFFFFB6
> > PMBUS_UT_WARN_LIMIT 0xFFFF
> > PMBUS_UT_FAULT_LIMIT 0xFFFF
> > PMBUS_VIN_OV_FAULT_LIMIT 0xFFFF
> > PMBUS_VIN_OV_WARN_LIMIT 0xFFFF
> > PMBUS_VIN_UV_WARN_LIMIT 0xFFFF
> > PMBUS_VIN_UV_FAULT_LIMIT 0xFFFF
> > PMBUS_IIN_OC_FAULT_LIMIT 0xFFFF
> > PMBUS_IIN_OC_WARN_LIMIT 0x0
> > PMBUS_POUT_OP_FAULT_LIMIT 0xFFFF
> > PMBUS_POUT_OP_WARN_LIMIT 0xFFFFFFB6
> > PMBUS_PIN_OP_WARN_LIMIT 0x0
> > PMBUS_READ_FAN_SPEED_2 0x0
> > PMBUS_MFR_VIN_MIN 0x5A
> > PMBUS_MFR_VIN_MAX 0x108
> > PMBUS_MFR_IIN_MAX 0x3
> > PMBUS_MFR_PIN_MAX 0xC8
> > PMBUS_MFR_VOUT_MIN 0x1748
> > PMBUS_MFR_VOUT_MAX 0x18B0
> > PMBUS_MFR_IOUT_MAX 0xF
> > PMBUS_MFR_POUT_MAX 0x96
> > PMBUS_MFR_MAX_TEMP_1 0xFFFF
> > PMBUS_MFR_MAX_TEMP_2 0xFFFF
> >
>
> The question is really what the status register reports for those.
> I bet that PMBUS_STATUS_CML will set the "invalid command" bit
> for many if not all registers returning 0xffff. Those will
> be filtered out by the PMBus core automatically. That leaves the
> ones returning some data. Of course it would be desirable
> to have those supported, but I can understand if you don't know
> the encoding. The reason for masking those needs to be explained.
>

I thought I sent the v4 patch before, but it seems that I only sent it
to myself. Also, I realized I've sent some of the emails only to you.
That wasn't my intention. Sorry. I'm bad at emailing.

Anyway, I have posted the v4 patch right now and it includes a comment
about the masking.

V=C3=A1clav

> Thanks,
> Guenter
