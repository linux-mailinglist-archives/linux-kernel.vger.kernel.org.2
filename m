Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7ED32DB80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhCDU6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhCDU5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:57:32 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B89C061762
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 12:56:42 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id x20so31615195oie.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 12:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lBfTd3oDp2KFnFnmSKQxa1nC+FsiGtIxnlk+/Kblz0k=;
        b=Zu1gFLVGQxh8fZR3srbK2UHHspUpnBkj9DkPdzrVHRSDrMG+OnqxjB1qxqA9u3LYDv
         1g1xcntTCYr1DMx+ym/8enYaviBH6YDPfgqPB5aCd5U4m8X1ZIfeeD4L1xm+K0HHX2lA
         EYj9CJXioEGlVxjjh4NaJjR8UT1zHeKadqsj23LtdWzdEfevIt5n03xjn67Qaa19Y9s7
         wCKEPApxuavczhGwe/VYa7zQkIl//+0tYUEt3pTGd151AY/FLTRUpBCdKtG0LiykW0Ov
         C3MuQisaxZ0Xw1dNcy+tqgvfjR0a9WgkAO910K+DctQlsz8g1XRtGoJUjCY+1HAZFDvq
         uILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lBfTd3oDp2KFnFnmSKQxa1nC+FsiGtIxnlk+/Kblz0k=;
        b=RXhCO90ogNG5cOQ8WCFMO124mz3wzCZdVqDPdl8z9sL0P7X0Sgv08Uo858TO9pAQlR
         jK6rWbUbhwYLW3YPd2i4axzLtB3Twry5jOXSDwUIGrCkxTu+nkJyO3zOepNJuTpPxxBP
         TcYhEOwQWtqJ6a5fiQRNPqwjHfdUYHVoURMc0PVVjC7NWArnUDIjspQ/DOTdZXJrVmwv
         xoq/Y8Dx4RrhB0OGjuCOisrTLvFKG7RZ1DG/vW8pj6FR3CaJjFPjosiP92vMBw6zHtiI
         MIi8RfFnG4ieW1olgtcPtqpSNT7GRGtltE6hRvHVJpO2g68hS6uqEujKujaSP94jZfVh
         Uk3w==
X-Gm-Message-State: AOAM532n0EXJ99GNhNrtqDvnvIYKm2uRWhuGhtrAMJYZXiZIxakTIHUO
        o8ij8CHSFTC1TlHaeZVXoUA4ZCfxKAUIeCtKVCw=
X-Google-Smtp-Source: ABdhPJzOBvaVFSRgVt+//TfqyyS1JKpi+aQ6WdfahlQHMA5Vr9VSpFQYTuQ8h84jmUBwahv6OCCr8Q==
X-Received: by 2002:a05:6808:a8d:: with SMTP id q13mr4341622oij.29.1614891401568;
        Thu, 04 Mar 2021 12:56:41 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id w9sm66357oia.46.2021.03.04.12.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 12:56:40 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 97so1753436otf.13;
        Thu, 04 Mar 2021 12:56:40 -0800 (PST)
X-Received: by 2002:a9d:12e1:: with SMTP id g88mr1612888otg.305.1614891400360;
 Thu, 04 Mar 2021 12:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20210303135500.24673-1-alex.bennee@linaro.org> <20210303135500.24673-2-alex.bennee@linaro.org>
In-Reply-To: <20210303135500.24673-2-alex.bennee@linaro.org>
From:   Arnd Bergmann <arnd@linaro.org>
Date:   Thu, 4 Mar 2021 21:56:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0W5X8Mvq0tDrz7d67SfQA=PqthpnGDhn8w1Xhwa030-A@mail.gmail.com>
Message-ID: <CAK8P3a0W5X8Mvq0tDrz7d67SfQA=PqthpnGDhn8w1Xhwa030-A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Joakim Bech <joakim.bech@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        ruchika.gupta@linaro.org,
        "Winkler, Tomas" <tomas.winkler@intel.com>, yang.huang@intel.com,
        bing.zhu@intel.com, Matti.Moell@opensynergy.com,
        hmo@opensynergy.com, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 2:54 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> A number of storage technologies support a specialised hardware
> partition designed to be resistant to replay attacks. The underlying
> HW protocols differ but the operations are common. The RPMB partition
> cannot be accessed via standard block layer, but by a set of specific
> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> partition provides authenticated and replay protected access, hence
> suitable as a secure storage.
>
> The RPMB layer aims to provide in-kernel API for Trusted Execution
> Environment (TEE) devices that are capable to securely compute block
> frame signature. In case a TEE device wishes to store a replay
> protected data, requests the storage device via RPMB layer to store
> the data.
>
> A TEE device driver can claim the RPMB interface, for example, via
> class_interface_register(). The RPMB layer provides a series of
> operations for interacting with the device.
>
>   * program_key - a one time operation for setting up a new device
>   * get_capacity - introspect the device capacity
>   * get_write_count - check the write counter
>   * write_blocks - write a series of blocks to the RPMB device
>   * read_blocks - read a series of blocks from the RPMB device

Based on the discussion we had today in a meeting, it seems the
main change that is needed is to get back to the original model
of passing the encrypted data to the kernel instead of cleartext
data, as the main use case we know of is to have the key inside of
the TEE device and not available to the kernel or user space.

This is also required to be able to forward the encrypted data
through the same interface on a KVM host, when the guest
uses virtio-rpmb, and the host forwards the data into an mmc or
ufs device.

That said, I can also imagine use cases where we do want to
store the key in the kernel's keyring, so maybe we end up needing
both.

> The detailed operation of implementing the access is left to the TEE
> device driver itself.
>
> [This is based-on Thomas Winkler's proposed API from:
>
>   https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-toma=
s.winkler@intel.com/
>
> The principle difference is the framing details and HW specific
> bits (JDEC vs NVME frames) are left to the lower level TEE driver to
> worry about. The eventual userspace ioctl interface will aim to be
> similarly generic. This is an RFC to follow up on:
>
>   Subject: RPMB user space ABI
>   Date: Thu, 11 Feb 2021 14:07:00 +0000
>   Message-ID: <87mtwashi4.fsf@linaro.org>]
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Linus  Walleij <linus.walleij@linaro.org>
> Cc: Arnd Bergmann <arnd.bergmann@linaro.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  MAINTAINERS                |   7 +
>  drivers/char/Kconfig       |   2 +
>  drivers/char/Makefile      |   1 +
>  drivers/char/rpmb/Kconfig  |  11 +
>  drivers/char/rpmb/Makefile |   7 +
>  drivers/char/rpmb/core.c   | 429 +++++++++++++++++++++++++++++++++++++
>  include/linux/rpmb.h       | 163 ++++++++++++++


My feeling is that it should be a top-level subsystem, in drivers/rpmb
rather than drivers/char/rpmb, as you implement an abstraction layer
that other drivers can plug into, rather than a simple driver.

       Arnd
