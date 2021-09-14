Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE940AA82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhINJQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:16:44 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40556
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230208AbhINJQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:16:32 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5C77540179
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631610909;
        bh=H5D/FfQQgMg0EZ2Qw/2aFXc39r6WsfLpy3vkmHT7Cb4=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=bu0sP7CW8Sg0NSBNOnvUjffSBeaabt2u9qWWFSzvoqlV0rsYH/cPhu94+HWkXjEMl
         7h4hJ1mNdARqy4pzbblyx4EdtkbLYBZOOL3+vfiemYU9aQJ9Mm8L7h3c1imuVGLq/y
         vN24S+ZmKqsxSoeTNMGs0WDCzPJJ7Sq5qWpnTAb2DHplhRmVOJ0LmIMlfmLeg8Zcuj
         688V8OkopDUPrn2v0xMz/tkZm9EkhxlaqLMughQEY+69qIm2eS5SBZJ9WwKaZ2MH0S
         czOZF5XsM7itKj15hBbmWy+5IB+8G9gTdnW5CTgCmrLIfCxBFVgPrWh8cPnDUetFpX
         s9zOs0d2EsA6A==
Received: by mail-wm1-f71.google.com with SMTP id j21-20020a05600c1c1500b00300f1679e4dso463705wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H5D/FfQQgMg0EZ2Qw/2aFXc39r6WsfLpy3vkmHT7Cb4=;
        b=B3isRiJ1TMADgjLIgPBgw6m2U8qU9N+BQkOs5+j9WP7JbE4nnwxkgEw+P+FoJFztrf
         zxkZekRxiMtcQ+ILZOV2ceBJK/OYIjbo+eiFAEVPn65pqvs10pfACLLjL9SLwEPPcZDN
         akHWlUmTksMp/n88LsyPZNj8NUO39U4c4Se8Z1k3XpZGwrDhTVVGO+vDbFed0bx5FQkP
         LXHFZttm/fN7cWpAFH5qZ88PBwSaRKSK2NVnlyLfQRlmMxWZob3Xbr5pKQ5xDsIp9Rte
         N6vZ+xRMp/32HoAfh8NO2uhIGv2ttnD9MWCMo0ZOPh9+ewOq1+e2qkt8t9bo9mrvTX4W
         Wmqg==
X-Gm-Message-State: AOAM531GLjNlvsi2kOpwAAa2JLJ5OgartwCuzos3UH96QD1mPdhCCnHs
        KJTvzqYc5tKxRa5G5JRf2s/bwHZIJ3EpwQlIGCOF6cB0z6yvtpEYRy1iFpdELD7nBlg2lUXhubF
        olshLUD5h+vQkZahZTKsdH0DCTmDnwTLnGeSaWxm3IA==
X-Received: by 2002:a1c:9a8e:: with SMTP id c136mr980811wme.191.1631610908951;
        Tue, 14 Sep 2021 02:15:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgOA95mgvqIcsSC1Y5VXovrY4W4xHwJSVK/M2pvFoSEXcBrXA1mL9AdaGoym9QoNfQdtyZKw==
X-Received: by 2002:a1c:9a8e:: with SMTP id c136mr980784wme.191.1631610908759;
        Tue, 14 Sep 2021 02:15:08 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id d8sm10448325wrv.20.2021.09.14.02.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 02:15:08 -0700 (PDT)
Subject: Re: [PATCH 06/16] tty: remove file from n_tty_ioctl_helper
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091134.17426-6-jslaby@suse.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e446060c-4208-cda5-5ac9-5650b5a1e3b2@canonical.com>
Date:   Tue, 14 Sep 2021 11:15:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914091134.17426-6-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2021 11:11, Jiri Slaby wrote:
> After the previous patch, there are no users of 'file' in
> n_tty_ioctl_helper. So remove it also from there.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/bluetooth/hci_ldisc.c | 2 +-
>  drivers/net/ppp/ppp_async.c   | 2 +-
>  drivers/net/ppp/ppp_synctty.c | 2 +-
>  drivers/tty/n_gsm.c           | 2 +-
>  drivers/tty/n_hdlc.c          | 2 +-
>  drivers/tty/n_tty.c           | 2 +-
>  drivers/tty/tty_ioctl.c       | 4 ++--
>  include/linux/tty.h           | 4 ++--
>  net/nfc/nci/uart.c            | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)
> 

For NFC:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
