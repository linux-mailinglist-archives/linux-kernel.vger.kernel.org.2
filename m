Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B5540AA86
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhINJRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:17:37 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40628
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229624AbhINJRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:17:32 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A6FCA40179
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631610974;
        bh=jxjZWeYzE1U9O4nD59VvfbtIKZY2vfyOzjYk3FCwwC0=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=hjvpZDd8ecge18HPuC5QKbExWhds+DghA9closfxiewvs8b6YIBsgMDohlE8qUjAM
         T2A12JMkgeyxng9QXZLxFVFBljtZg3wZZEMPLEppEYd7RjB6TXoYKF+rcAakoW0m6e
         S/FFyoj19DuvSSkaAhP22i92GvDQ9WBtKj0EfRu318EshOgw/EHq7be3hMrj5H/nIi
         dL5JMpl6AwqqDZKU2mbHVEr4B2rw+wjD6cTtAaKQVm+D0TjZu40dJnw9VfcWn6I1nz
         HiZZ8rPcbytS0yipfh9VZV4Pm474UHeNtp9xCbTUkKch+tfN+l//Fx9IbpiCvVJpeo
         y8NDArl7o543A==
Received: by mail-wr1-f72.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so3699649wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jxjZWeYzE1U9O4nD59VvfbtIKZY2vfyOzjYk3FCwwC0=;
        b=CTpM2wdtqfuHqzXGRAL59ppOrXDPypwnlSf+pRyk3vDNvPmXf5GcePDu8m9niVxjXU
         Jiv1FtV1AI3n89cQCN9r0ja1hRgoAYFatmNeGlnnR4G/eNxiFnfJxZLw1QbnJD2+Aj+s
         2/AbvrLysEFOQDZu/CaFa8A63oAhc824llWGFnXrpVuiijTgIci3wmAdXW1OUTwM3B7M
         nbJmSL7sCdYryHLv722lygRNYzHVySfLSPKi86M23sCkXuGsowUx3WyIoVNJ6e0jmP1d
         S8zjLeoBn/ZYUfmHi5DJ/5SMh2hnp51mJ3TGiMqKUos6NJapojm9/ALhSJ/vlmNPOqzc
         txDA==
X-Gm-Message-State: AOAM533FqQ2j3xVnPAZ3FJW30ttAYRlchnAyTj3jkjX2/RiJyHE195As
        VNzlcsgiizCwQZSTUUWQ4/Vwy1Ajp0EjnaIVOORtL4mp/GA46lGRjjr5mxrNoGIA41Hn2ms1Xbb
        dF81vjIbHKkEVN6kres9w3pAGn9Iy/7jdjYiHATzCRA==
X-Received: by 2002:adf:f486:: with SMTP id l6mr9551820wro.375.1631610974346;
        Tue, 14 Sep 2021 02:16:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBcxJ9+nhpnNlsX6tU3CX3V3dg3Nt9kYahBWD5t+KHoQHqK28w2iy95+n9ca/OanwGluxzRA==
X-Received: by 2002:adf:f486:: with SMTP id l6mr9551804wro.375.1631610974177;
        Tue, 14 Sep 2021 02:16:14 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id o13sm7992153wri.53.2021.09.14.02.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 02:16:13 -0700 (PDT)
Subject: Re: [PATCH 07/16] tty: remove file from tty_ldisc_ops::ioctl and
 compat_ioctl
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Paul Mackerras <paulus@samba.org>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091134.17426-7-jslaby@suse.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <5093137d-c30e-8cdb-585b-8d9198c8893d@canonical.com>
Date:   Tue, 14 Sep 2021 11:16:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914091134.17426-7-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2021 11:11, Jiri Slaby wrote:
> After the previous patches, noone needs 'file' parameter in neither
> ioctl hook from tty_ldisc_ops. So remove 'file' from both of them.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/bluetooth/hci_ldisc.c |  5 ++---
>  drivers/input/serio/serport.c |  5 ++---
>  drivers/net/can/slcan.c       |  4 ++--
>  drivers/net/hamradio/6pack.c  |  4 ++--
>  drivers/net/hamradio/mkiss.c  |  4 ++--
>  drivers/net/ppp/ppp_async.c   |  3 +--
>  drivers/net/ppp/ppp_synctty.c |  3 +--
>  drivers/net/slip/slip.c       |  4 ++--
>  drivers/tty/n_gsm.c           |  4 ++--
>  drivers/tty/n_hdlc.c          |  5 ++---
>  drivers/tty/n_tty.c           |  4 ++--
>  drivers/tty/tty_io.c          |  8 ++++----
>  include/linux/tty_ldisc.h     | 15 +++++++--------
>  net/nfc/nci/uart.c            |  5 ++---
>  14 files changed, 33 insertions(+), 40 deletions(-)
> 

For NFC:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>



Best regards,
Krzysztof
